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

module sonic_translate_address (/*AUTOARG*/
   // Outputs
   int_read_addr,
   // Inputs
   ext_read_addr, clk, reset
   ) ;
   input [13:0] ext_read_addr;
   input 	clk;
   input 	reset;
   output [13:0] int_read_addr;

   logic [5:0]	 pgn;
   logic [13:0]  int_read_addr;
   logic [13:0]  int_read_addr_r;
   logic [13:0]  int_read_addr_rr;
   logic [13:0]  ext_read_addr_r;
      
`ifdef SYNTHESIS
   // Use altera mult_add module
   // This module has 4-cycle delay
   sonic_mult_add multadd (.clock0(clk),
			   .dataa_0(ext_read_addr_r),
			   .datab_0(14'h1),
			   .dataa_1(14'h10),
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
      if (ext_read_addr < 14'h1F0)
	pgn <= 1;
      else if (ext_read_addr < 14'h3E0)
	pgn <= 2;
      else if (ext_read_addr < 14'h5D0)
	pgn <= 3;
      else if (ext_read_addr < 14'h7C0)
	pgn <= 4;
      else if (ext_read_addr < 14'h9B0)
	pgn <= 5;
      else if (ext_read_addr < 14'hBA0)
	pgn <= 6;
      else if (ext_read_addr < 14'hD90)
	pgn <= 7;
      else if (ext_read_addr < 14'hF80)
	pgn <= 8;
      else if (ext_read_addr < 14'h1170)
	pgn <= 9;
      else if (ext_read_addr < 14'h1360)
	pgn <= 10;
      else if (ext_read_addr < 14'h1550)
	pgn <= 11;
      else if (ext_read_addr < 14'h1740)
	pgn <= 12;
      else if (ext_read_addr < 14'h1930)
	pgn <= 13;
      else if (ext_read_addr < 14'h1B20)
	pgn <= 14;
      else if (ext_read_addr < 14'h1D10)
	pgn <= 15;
      else if (ext_read_addr < 14'h1F00)
	pgn <= 16;
      else if (ext_read_addr < 14'h20F0)
	pgn <= 17;
      else if (ext_read_addr < 14'h22E0)
	pgn <= 18;
      else if (ext_read_addr < 14'h24D0)
	pgn <= 19;
      else if (ext_read_addr < 14'h26C0)
	pgn <= 20;
      else if (ext_read_addr < 14'h28B0)
	pgn <= 21;
      else if (ext_read_addr < 14'h2AA0)
	pgn <= 22;
      else if (ext_read_addr < 14'h2C90)
	pgn <= 23;
      else if (ext_read_addr < 14'h2E80)
	pgn <= 24;
      else if (ext_read_addr < 14'h3070)
	pgn <= 25;
      else if (ext_read_addr < 14'h3260)
	pgn <= 26;
      else if (ext_read_addr < 14'h3450)
	pgn <= 27;
      else if (ext_read_addr < 14'h3640)
	pgn <= 28;
      else if (ext_read_addr < 14'h3830)
	pgn <= 29;
      else if (ext_read_addr < 14'h3A20)
	pgn <= 30;
      else if (ext_read_addr < 14'h3C10)
	pgn <= 31;
      else
	pgn <= 32;
   end
      
endmodule // sonic_translate_address

