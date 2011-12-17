//                              -*- Mode: Verilog -*-
// Filename        : sonic_sync_ring.sv
// Description     : combine two 2-bit in 64-bit out memory into one 2-bit in 128-bit out memory
// Author          : Han Wang
// Created On      : Wed Nov 16 15:14:23 2011
// Last Modified By: Han Wang
// Last Modified On: Wed Nov 19 15:53:00 2011
// Update Count    : 1
// Status          : simulated passed
/*
 * dpram_async_2_64 has 2^14 = 16384 2-bit entries.
 * dparm_async_64_128 should have 16384 64-bit entries to match the sync_ring.
 * 
 * dpram_async_2_64 has 2^9 = 512 64-bit output entries, two outputs forms one 128-bit outputs.
 * sonic_sync_ring, which has two dpram_async_2_64 thus has 2^9 output entries.
 * 
 * dpram_async_64_128 has 2^13 = 8192 128-bit output entries.
 * 
 */
module sonic_sync_ring_2_128 (/*AUTOARG*/
   // Outputs
   data_out,
   // Inputs
   wr_address, rd_address, data_in, wr_clock, rd_clock, wren
   ) ;

   input [13:0] wr_address;
   input [7:0] 	rd_address;
   input [1:0] 	data_in;
   input 	wr_clock;
   input 	rd_clock;
   input 	wren;
   output [127:0] data_out;

   wire [63:0] 	  data_out_top, data_out_bot;

   /*
    * Each bit in address points to 2-bit data.
    * For 64-bit data, we have 32 different blocks, addressed with 5 bits.
    * We store bit[127:64] in top_half ring and bit[63:0] in bot_half ring.
    * Bit[5] tells us which ring the current address is at.
    */
   sonic_dpram_async_2_64 top_half (.data(data_in),
				    .wrclock(wr_clock),
				    .rdclock(rd_clock),
				    .rdaddress(rd_address),
				    .wraddress({wr_address[13:6],wr_address[4:0]}),
				    .wren(wr_address[5] & wren),
				    .q(data_out_top)
				    );
   
   sonic_dpram_async_2_64 bot_half (.data(data_in),
				    .wrclock(wr_clock),
				    .rdclock(rd_clock),
				    .rdaddress(rd_address),
				    .wraddress({wr_address[13:6],wr_address[4:0]}),
				    .wren(~wr_address[5] & wren),
				    .q(data_out_bot)
				    );
   
   assign data_out = { data_out_top , data_out_bot};

endmodule // sonic_sync_ring



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
