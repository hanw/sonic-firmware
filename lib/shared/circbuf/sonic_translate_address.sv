//                              -*- Mode: Verilog -*-
// Filename        : sonic_translate_address.sv
// Description     : translate ext_read_addr to int_read_addr.
// Author          : Han Wang
// Created On      : Thu Nov 24 19:17:31 2011
// Last Modified By: Han Wang
// Last Modified On: Thu Nov 24 19:17:31 2011
// Update Count    : 0
// Status          : Not finished for synthesizable code.

/*
 * This module has two cycles of propagation delay.
 * 
 */

`include "sonic_constants.sv"

module sonic_translate_address (/*AUTOARG*/
   // Outputs
   int_read_addr,
   // Inputs
   ext_read_addr, clk, reset
   ) ;

   input [14:0] ext_read_addr;
   input 	clk;
   input 	reset;
   output [14:0] int_read_addr;

   logic [6:0]	 pgn;
   logic [14:0]  int_read_addr;
   logic [14:0]  int_read_addr_r;
   logic [14:0]  int_read_addr_rr;
   logic [14:0]  ext_read_addr_r;
      
`ifdef SYNTHESIS
   // Use altera mult_add module
   // This module has 4-cycle delay
   sonic_mult_add multadd (.clock0(clk),
			   .dataa_0(ext_read_addr_r),
			   .datab_0(15'h1),
			   .dataa_1(15'h10),
			   .datab_1({8'h0, pgn}),
			   .result(int_read_addr)
			   );
   
   always @ (posedge clk) begin
      ext_read_addr_r <= ext_read_addr;
   end
      
`else
   always @ ( posedge clk ) begin
      ext_read_addr_r <= ext_read_addr;
      // Add two cycle delay to match sonic_mult_add
      int_read_addr_rr <= ext_read_addr_r + 8'h10 * pgn;
      int_read_addr_r <= int_read_addr_rr;
      int_read_addr <= int_read_addr_r;
   end
`endif
	  
   /*
    * Not the best approach, but the simpliest to code.
    * 0x1F0 * N.
    * Decide which page does the current page falls into.
    */
   
   always @ (posedge clk) begin
      if (ext_read_addr < 15'h1F0)
	pgn <= 1;
      else if (ext_read_addr < 15'h3E0)
	pgn <= 2;
      else if (ext_read_addr < 15'h5D0)
	pgn <= 3;
      else if (ext_read_addr < 15'h7C0)
	pgn <= 4;
      else if (ext_read_addr < 15'h9B0)
	pgn <= 5;
      else if (ext_read_addr < 15'hBA0)
	pgn <= 6;
      else if (ext_read_addr < 15'hD90)
	pgn <= 7;
      else if (ext_read_addr < 15'hF80)
	pgn <= 8;
      else if (ext_read_addr < 15'h1170)
	pgn <= 9;
      else if (ext_read_addr < 15'h1360)
	pgn <= 10;
      else if (ext_read_addr < 15'h1550)
	pgn <= 11;
      else if (ext_read_addr < 15'h1740)
	pgn <= 12;
      else if (ext_read_addr < 15'h1930)
	pgn <= 13;
      else if (ext_read_addr < 15'h1B20)
	pgn <= 14;
      else if (ext_read_addr < 15'h1D10)
	pgn <= 15;
      else if (ext_read_addr < 15'h1F00)
	pgn <= 16;
      else if (ext_read_addr < 15'h20F0)
	pgn <= 17;
      else if (ext_read_addr < 15'h22E0)
	pgn <= 18;
      else if (ext_read_addr < 15'h24D0)
	pgn <= 19;
      else if (ext_read_addr < 15'h26C0)
	pgn <= 20;
      else if (ext_read_addr < 15'h28B0)
	pgn <= 21;
      else if (ext_read_addr < 15'h2AA0)
	pgn <= 22;
      else if (ext_read_addr < 15'h2C90)
	pgn <= 23;
      else if (ext_read_addr < 15'h2E80)
	pgn <= 24;
      else if (ext_read_addr < 15'h3070)
	pgn <= 25;
      else if (ext_read_addr < 15'h3260)
	pgn <= 26;
      else if (ext_read_addr < 15'h3450)
	pgn <= 27;
      else if (ext_read_addr < 15'h3640)
	pgn <= 28;
      else if (ext_read_addr < 15'h3830)
	pgn <= 29;
      else if (ext_read_addr < 15'h3A20)
	pgn <= 30;
      else if (ext_read_addr < 15'h3C10)
	pgn <= 31;
      else if (ext_read_addr < 15'h3E00)
	pgn <= 32;
      else if (ext_read_addr < 15'h3FF0)
	pgn <= 33;
      else if (ext_read_addr < 15'h41E0)
	pgn <= 34;
      else if (ext_read_addr < 15'h43D0)
	pgn <= 35;
      else if (ext_read_addr < 15'h45C0)
	pgn <= 36;
      else if (ext_read_addr < 15'h47B0)
	pgn <= 37;
      else if (ext_read_addr < 15'h49A0)
	pgn <= 38;
      else if (ext_read_addr < 15'h4B90)
	pgn <= 39;
      else if (ext_read_addr < 15'h4D80)
	pgn <= 40;
      else if (ext_read_addr < 15'h4F70)
	pgn <= 41;
      else if (ext_read_addr < 15'h5160)
	pgn <= 42;
      else if (ext_read_addr < 15'h5350)
	pgn <= 43;
      else if (ext_read_addr < 15'h5540)
	pgn <= 44;
      else if (ext_read_addr < 15'h5730)
	pgn <= 45;
      else if (ext_read_addr < 15'h5920)
	pgn <= 46;
      else if (ext_read_addr < 15'h5B10)
	pgn <= 47;
      else if (ext_read_addr < 15'h5D00)
	pgn <= 48;
      else if (ext_read_addr < 15'h5EF0)
	pgn <= 49;
      else if (ext_read_addr < 15'h60E0)
	pgn <= 50;
      else if (ext_read_addr < 15'h62D0)
	pgn <= 51;
      else if (ext_read_addr < 15'h64C0)
	pgn <= 52;
      else if (ext_read_addr < 15'h66B0)
	pgn <= 53;
      else if (ext_read_addr < 15'h68A0)
	pgn <= 54;
      else if (ext_read_addr < 15'h6A90)
	pgn <= 55;
      else if (ext_read_addr < 15'h6C80)
	pgn <= 56;
      else if (ext_read_addr < 15'h6E70)
	pgn <= 57;
      else if (ext_read_addr < 15'h7060)
	pgn <= 58;
      else if (ext_read_addr < 15'h7250)
	pgn <= 59;
      else if (ext_read_addr < 15'h7440)
	pgn <= 60;
      else if (ext_read_addr < 15'h7630)
	pgn <= 61;
      else if (ext_read_addr < 15'h7820)
	pgn <= 62;
      else if (ext_read_addr < 15'h7A10)
	pgn <= 63;
      else
	pgn <= 64;
   end
      
endmodule // sonic_translate_address

