//                              -*- Mode: Verilog -*-
// Filename        : sonic_rx_circular_buffer_66.sv
// Description     : rx ring with 66-bit to 128-bit conversion
// Author          : Han Wang
// Created On      : Fri Nov 18 19:41:56 2011
// Last Modified By: Han Wang
// Last Modified On: Fri Nov 18 19:41:56 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!

/*
 Receive Circular Buffer, for 66 bits blocks.
 
 Inputs are 66-bit blocks from blocksync. 
 Outputs are 128-bit block to the DMA engine.
 
 The linux driver request data in 4KB pages through the DMA engine.
 Each address issued by DMA points to 128-bit data block, because
 the data width of the DMA engine is 128 bits. For a 4KB pages, this
 corresponds to address offset of 4096 / (128/8) = 256.
 
 For each page, we use a segment on the top to store sync_headers.
 In the rest of the page, we store data blocks associated with the
 sync headers. The memory map is as follows:
 -----------------------------------------------------------------------
 Vaddr| Vaddr(bin)       | Paddr | Paddr(bin)              Types
 ----------------------------------------------------------------------- 
 0     0b0000000             0     0b0000000     First sync header byte
 1                           1    
 2                           2
 
 123   0b1111011            123    0b1111011     Last sync header byte
 -----------------------------------------------------------------------
                            124    
                            125              Empty-ness ...
                            126
                            127
 -----------------------------------------------------------------------
 128   0b0000_1000_0000      0     0b0000_0000_0000   First data byte
 ...
 ...
 
 4094
 4095  0b1111_1111_1111    3967    0b1111_0111_1111   Last data byte
 -----------------------------------------------------------------------
 
 For each pages, 124 bytes are used for storing sync header. 
 3968 bytes are used for storing data block. 4 bytes are empty.
 In total, 496 66-bit blocks are stored in a single page.

 We currently have 8192 128-bit entries in the ring memory, which 
 means we could store upto 32 pages worth of data in it. 
 
 We create a separate memory block as sync-header ring, it has  a 2-bit wide input and
 128-bit wide output. It needs 124 / 8 = 15.5 entries to store all  the sync headers.
 We round this to 128 bytes (16 128-bit entires).
 
 For each DMA transaction, a page is requested, the first 128 bytes are sync headers, 
 with valid sync header from byte 0 to byte 123. The rest of the DMA transaction will
 contains the correponding 64-bit data-block of the 66-bit block. As what we have computed,
 we can fit 496 64-bit blocks, or 248 128-bit block in a single pages. 

 For instance: 
 Page 0: 
   128 bytes of sync header from sync_ring address [0:15].
   3968 bytes of data block from data_ring address [16:256].
 Page 1:
   128 bytes of sync header from sync_ring address [16:31].
   3968 bytes of data block from data_ring address [272:512].
 Page 2:
   128 bytes of sync header from sync_ring address [32:47].
   3968 bytes of data block from data_ring address [528:756].
 ...
 
 Page 31:
   128 bytes of sync header from sync_ring address [496:512].
   3968 bytes of data block from data_ring address [7944:8192].
 
 As we have shown before, it is only possible to store upto 32 pages with the current
 memory size, 8192 - 7936 = 256 128-bit entires are not used in the data_ring memory.
 
 To align thing better, we distribute the unused entires of data_ring memory sparsely
 in each page. For example, the first 16 128-bit entries in the data_ring memory are
 not used, because they are shadowed by the sync_header ring. We store the first entires
 of data_block in entry 16, up to entry 256.

 For the DMA engine, the two rings (sync_ring & data_ring) are a single entity, because
 the address mapping from dma address to ring address is handled by the ring_mmap module.
 
 For the blocksync module, the rings are also a single entity, because 66-bit incoming
 block is splitted by the ring_mmap module, 2-bit sync headers are stored in sync_ring.
 64-bit data_blocks are stored in data_ring.

 Here we need to make a design decision about what the interface between DMA engine and
 RX ring should be: Current low level interface includes rd_address, full/empty status signals,
 and rd_used_qwords count. But, as far as the driver's concern, it only issues DMA transaction,
 if there is a full page worth of data available in the Rx ring. As a result, the Rx ring
 only need to indicate to the driver about the amount of ready data in the unit of pages.
 (The driver will build its own mapping of the ring, and specify the proper offset to 
 the ring during DMA.) We don't need to tell driver the value of rd_used_qwords, just 
 rd_used_qwords % page_size should be sufficient.
 
 */

`include "sonic_constants.sv"

module sonic_rx_circular_buffer_66 (/*AUTOARG*/
   // Outputs
   data_out,
   // Inputs
   data_in, rd_address, rd_clk, reset, wr_clk, wrena, wrreq
   ) ;

   input [65:0]   data_in;
   input [12:0]   rd_address;
   input 	  rd_clk;
   input 	  reset;
   input 	  wr_clk;
   input 	  wrena;  
   input          wrreq; 
   output [127:0] data_out;
   
   logic [127:0]  sync_ring_data_out, data_ring_data_out, data_out;
   logic [7:0] 	  sync_ring_rd_address;
   logic	  data_out_sel;   
   logic [13:0]   wr_address;
   logic [65:0]   data_in_r;
   logic [65:0]   data_in_rr;
   logic [65:0]   data_in_rrr;

   logic 	  wrreq_r;
   logic 	  wrreq_rr;
   
   logic 	  data_out_sel_r;
   logic 	  data_out_sel_rr;
   
   /*
    * ring_mmap
    * mmap dma_address to sync_ring address and data_ring address
    * 
    * rd_address              sync_ring_rd_address
    * 0x0   - 0x7     maps to     0x0 - 0x7
    * 0x100 - 0x107   maps to     0x8 - 0xF
    * 0x200 - 0x207   maps to     0x10 - 0x17
    * ...
    */
   assign sync_ring_rd_address = {rd_address[12:8] , rd_address[2:0]};
   assign data_out = (data_out_sel) ? data_ring_data_out : sync_ring_data_out;

   always @ ( posedge wr_clk ) begin
      data_in_r <= data_in;
      data_in_rr <= data_in_r;
      data_in_rrr <= data_in_rr;
      wrreq_r <= wrreq;
      wrreq_rr <= wrreq_r;
      data_out_sel_r <= data_out_sel;
      data_out_sel_rr <= data_out_sel_r;
   end
   
   /*
    * sonic_calc_address
    * NOTE: generate wr_address, with 2-cycle delay.
    *       input data should match the slack of this module.
    */
   sonic_calc_address gen_wr_addr (.clk_in(wr_clk),
				   .ena(wrena),
				   .incr(wrreq),
				   .reset(reset),
				   .addr_out(wr_address)
				   );
   
   /*
    * sync_ring,
    */
   sonic_sync_ring_2_128 sync_ring (.data_out(sync_ring_data_out),
				    .wr_address(wr_address),
				    .rd_address(sync_ring_rd_address),
				    .data_in(data_in_r[1:0]),
				    .wren(wrena && wrreq_rr), 
				    .wr_clock(wr_clk),
				    .rd_clock(rd_clk)
				    );
   /*
    * data_ring
    */
   sonic_dpram_async_64_128 data_ring (.data(data_in_r[65:2]),
				       .wraddress(wr_address),
				       .wrclock(wr_clk),
				       .wren(wrena && wrreq_rr), 
				       .rdaddress(rd_address),
				       .rdclock(rd_clk),
				       .rden(1'b1), //rem: HanW
				       .q(data_ring_data_out)
				       );
   /*
    * data_out_sel should match the delay of ram access.
    * FIX: add reg to match delay.
    */
   always @ ( posedge rd_clk or posedge reset ) begin
      if (reset)
	data_out_sel <= 0;
      else
	data_out_sel <= rd_address[7] | rd_address[6] | rd_address[5] |
			rd_address[4] | rd_address[3];
   end
      
      
endmodule // sonic_rx_circular_buffer_66


//-----------------------------------------------------------------------------------------
// Copyright 2011 Cornell University. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of
// conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
// of conditions and the following disclaimer in the documentation and/or other materials
// provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY CORNELL UNIVERSITY ''AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
// ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// The views and conclusions contained in the software and documentation are those of the
// authors and should not be interpreted as representing official policies, either expressed
// or implied, of Cornell University.
//------------------------------------------------------------------------------------------
