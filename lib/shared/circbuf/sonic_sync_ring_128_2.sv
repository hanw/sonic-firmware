//                              -*- Mode: Verilog -*-
// Filename        : sonic_sync_ring_128_2.sv
// Description     : Store sync_header from DMA channel on Tx path
// Author          : Han Wang
// Created On      : Sat Nov 19 17:34:20 2011
// Last Modified By: Han Wang
// Last Modified On: Sat Nov 19 17:34:20 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!

/*
 * Combine two sonic_dpram_async_64_2 memory block to one 128-in 2-out block.
 * 128-bit address maps to 64-bit address one-to-one on writing.
 * On Reading, 0x0 - 0x1F should read from bot_half at address 0x0 - 0x1F.
 *             0x20 - 0x3F should read from top_half at address 0x0 - 0x1F.
 * 
 * 0x0000_0000 - 0x0001_1111 maps to 0x0000_0000 and 0x0001_1111, sel = 0,
 * 0x0010_0000 - 0x0011_1111 maps to 0x0000_0000 and 0x0001_1111, sel = 1.
 * 
 * 128K buffer design:
 * 128-bit block address has 9 bits addresses, 2-bit block address should have 15
 * bits address.
 * 
 * 256K buffer design:
 * 128-bit block address has 10 bits addresses, 2-bit block address should have 16
 * bits address.
 * 
 */

module sonic_sync_ring_128_2 (/*AUTOARG*/
   // Outputs
   data_out,
   // Inputs
   data_in, wren, rd_clock, wr_clock, wr_address, rd_address
   ) ;

   input [127:0] data_in;
   input 	 wren;
   input 	 rd_clock;
   input 	 wr_clock;
   input [8:0] 	 wr_address;
   input [`TX_READ_ADDR_WIDTH-1:0]  rd_address;
   output [1:0]  data_out;

   logic [1:0] 	 data_out_ms, data_out_ls;
   logic 	 data_sel;
   logic 	 data_sel_r;
   logic [`TX_WRITE_ADDR_WIDTH-1:0]  mapped_read_address;

   assign mapped_read_address = {rd_address[`TX_READ_ADDR_WIDTH-1:6], rd_address[4:0]};

   /* 
    * To match read latency of memory,
    * Simulation in Modelsim shows two cycle read delay.
    */
   always @ ( posedge rd_clock ) begin
      data_sel <= rd_address[5];
//      data_sel <= data_sel_r;
   end
   
   sonic_dpram_async_64_2 top_half (.data(data_in[127:64]),
				    .wrclock(wr_clock),
				    .rdclock(rd_clock),
				    .rdaddress(mapped_read_address),
				    .wraddress(wr_address),
				    .wren(wren),
				    .q(data_out_ms)
				    );

   sonic_dpram_async_64_2 bot_half (.data(data_in[63:0]),
				    .wrclock(wr_clock),
				    .rdclock(rd_clock),
				    .rdaddress(mapped_read_address),
				    .wraddress(wr_address),
				    .wren(wren),
				    .q(data_out_ls)
				    );
   
   assign data_out = (data_sel) ? data_out_ms : data_out_ls;
      
endmodule // sonic_sync_ring_128_2

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
