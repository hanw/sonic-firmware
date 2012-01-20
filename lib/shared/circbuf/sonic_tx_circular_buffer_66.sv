//                              -*- Mode: Verilog -*-
// Filename        : sonic_tx_circular_buffer_66.sv
// Description     : 128 to 66 transmit circular buffer
// Author          : Han Wang
// Created On      : Sat Nov 19 16:02:06 2011
// Last Modified By: Han Wang
// Last Modified On: Sat Nov 19 16:02:06 2011
// Update Count    : 0
// Status          : need to simulate with 66-40 gearbox
/*
 * Transmit Circular Buffer, for 66 bits blocks
 * 
 * Inputs are 128-bit block from DMA engine.
 * We assume that every DMA transaction transfer a page worth of data to the Tx Ring.
 * Start address of pages are well defined offsets into the Tx ring. 1st page starts
 * at offset 0x0, 2nd page starts at offset 0x100, 3rd page starts at offset 0x200.
 * The last page supported by Tx ring starts at 0x1F00.
 * 
 * The device driver must use 'page' to send data, and the 'page' is fixed size of 4096 bytes.
 * 
 * Tx Ring waits for an entire page to be received, before it sends the data to network.
 * The delay of sending packets can be as much as the time it takes to send a page worth of 
 * data from host to Tx Ring.
 * 
 * We never send zero through the network, because 10GbE sends idle symbol, if there is no
 * packets to send.
 * 
 Page Format: Same as the Rx Ring.
 -----------------------------------------------------------------------
 Vaddr| Vaddr(bin)       | Paddr | Paddr(bin)              Types
 ----------------------------------------------------------------------- 
 0
 1                Empty-ness ...
 2  
 3  
 4     0b0000000             4     0b0000000     First sync header byte
 5                           5    
 6                           6
 
 123   0b1111011            123    0b1111011     
 124   0b1111100 
 125              
 126
 127   0b1111111            127    0b1111111     Last sync header byte
 -----------------------------------------------------------------------
 128   0b0000_1000_0000      0     0b0000_0000_0000   First data byte
 ...
 ...
 
 4094
 4095  0b1111_1111_1111    3967    0b1111_0111_1111   Last data byte
 -----------------------------------------------------------------------
 
 Read comments in sonic_rx_circular_buffer_66 for the description of page layout.  
 Each page has 496 (0x1F0) entries, when translating the read address 0x0 to
 memory addr of data ring, 0x0 maps to 0x10 in data ring, and 0x10 in sync ring.
 The conversion is simple: first, we name the bit address of sync header i in the
 page to be 32+2i, since the first sync header starts at bit offset 32.
 The bit address of data block i in the page to be (32+2i) * 32, since the first
 data block starts at bit offset 1024. The 2-bit address or read address to sync
 ring is (32+2i)/2 = 16+i. And the 64-bit address or read address to data ring is
 (32+2i) * 32 / 64 = 16+i. Therefore, we should always use the same address to 
 index the sync and data ring.
 
 The external circuitry does not observe the offset in sync/data ring. Therefore,
 when an read request to position 0 comes in to the tx_cbuf block, an address 
 translation block is needed to translate the ext_read_addr 0 to int_read_addr of
 0x10. The ext_read_addr 0x1F0 should be translated to int_read_addr of 0x200.
 ===============================
   Ext          |    Internal
 -------------------------------
     0x0               0x10
     0x1EF             0x1FF
     0x1F0             0x210
     0x3DF             0x3FF
     0x3E0             0x400
     ...
 ===============================
 Expanding the above hex number to binary:
     0x0 = 0x0, 0x10 = 0x1_0000
     0x1EF = 0x1_1110_1111, 0x1FF = 0x1_1111_1111
     0x1F0 = 0x1_1111_0000, 0x210 = 0x10_0001_0000
     0x1F1 = 0x1_1111_0001, 0x211 = 0x10_0001_0001
     0x1F2 = 0x1_1111_0010, 0x212 = 0x10_0001_0010
     0x3DF = 0x11_1101_1111, 0x3FF = 0x11_1111_1111
 Symbolically, 
     (ext_addr + 0x10 * pgn) = int_addr
 Convert to logic gates:
     
 *
 * FIX:  
 *   - (FIXED) read should not return anything until some 64-bit has been written.
 *   - write should not succeed if reset == '1'.
 * 
 */

`include "sonic_constants.sv"

module sonic_tx_circular_buffer_66 (/*AUTOARG*/
   // Outputs
   data_out, clock_crossed_rd_address,
   // Inputs
   data_in, wr_address, wr_clk, rd_clk, reset, wrreq, rdena, rdreq
   ) ;

   input [127:0] data_in;
   input [12:0]  wr_address;
   input 	 wr_clk;
   input 	 rd_clk;
   input 	 reset;
   input         wrreq;
   input 	 rdena; 	 
   input 	 rdreq;
//   input 	 tag_cpl;
//   output 	 gearbox_ena;
   output [65:0] data_out;
   output [13:0] clock_crossed_rd_address;
      
   logic [1:0] 	 dout_sync;
   logic [63:0]  dout_data;

   logic [13:0]  rd_address;
   logic [7:0]   wr_address_sync;
   logic [12:0]  wr_address_data;
   logic 	 wren_data;
   logic 	 wren_sync;

//   logic 	 data_out_available;
//   logic 	 rd_ready;
   
   assign data_out = {dout_data, dout_sync};
//   assign gearbox_ena = rd_ready;
   
   /*
    * mmap: convert wr_address to address for sonic_sync_ring or sonic_tx_ring.
    * Since 64-bit data is always received after its sync_header. We use the
    * wptr of tx_data_ring to optimize the transmit delay, by not waiting for
    * the entire page to be received, but wait for the 64-bit data to be received
    * before sending the block.
    */
   assign wr_address_sync = {wr_address[12:8], wr_address[2:0]}; 
   assign wr_address_data = wr_address;
   
   /*
    * Generate wren signals.
    * wren_sync: '1' when the address is top 128 bytes of a page.
    * wren_data: '1' when the address is next 3968 bytes in the page.
    * NOTE: write_address is oword-base.
    */
   assign wren_data = (wr_address[7] | wr_address[6] | wr_address[5] | wr_address[4] | wr_address[3]) & wrreq;
   assign wren_sync = (~wren_data) & wrreq;

   /*
    * sonic_calc_address
    * NOTE: generate read address
    */
   sonic_calc_address gen_rd_addr (.clk_in(rd_clk),
				   .ena(rdena),
				   .incr(rdreq),
				   .reset(reset),
				   .addr_out(rd_address)
				   );
   
   /*
    * sonic_async_128_64
    * First 16 entires of every 1024 entries are empty, because 
    * they are shadowed by the sync_ring for sync_headers.
    */
   sonic_dpram_async_128_64 data_ring (.data(data_in),
				       .rdaddress(rd_address),
				       .rdclock(rd_clk),
				       .rden(1'b1),
				       .wraddress(wr_address_data),
				       .wrclock(wr_clk),
				       .wren(wren_data),
				       .q(dout_data)
				       );
   
   /*
    * sonic_sync_ring_128_2
    * First valid sync_header appears at position 0x10,
    * Because 0x0 - 0xF in data_ring is also empty.
    * We use same address to index both ring, valid data starts at 0x10.
    */
   sonic_sync_ring_128_2 sync_ring(.data_in(data_in),
				   .wren(wren_sync),
				   .rd_clock(rd_clk),
				   .wr_clock(wr_clk),
				   .wr_address(wr_address_sync),
				   .rd_address(rd_address),
				   .data_out(dout_sync)
				   );

   // clock crossed tx ring rptr to application clock domain.
   sonic_common_gray_clock_crosser rdcounter_to_wrclock(
							.inclock(rd_clk),
							.outclock(wr_clk),
							.inena(rdena),
							.outena(1'b1),
							.reset(reset),
							.data(rd_address),
							.q(clock_crossed_rd_address)
							);
   defparam rdcounter_to_wrclock.WIDTH = 14;
   
endmodule // sonic_tx_circular_buffer_66

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
