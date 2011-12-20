//                              -*- Mode: Verilog -*-
// Filename        : sonic_calc_address.sv
// Description     : compute the next RD address for TX and WR address for Rx.
// Author          : Han Wang
// Created On      : Fri Nov 25 16:02:26 2011
// Last Modified By: Han Wang
// Last Modified On: Fri Nov 25 16:02:26 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!
module sonic_calc_address (/*AUTOARG*/
			   // Outputs
			   addr_out,
			   // Inputs
			   clk_in, reset, incr, ena
			   ) ;
   input clk_in;
   input reset;
   input incr;
   input ena;
   
   output [13:0] addr_out; // assume max 0x3E00 entries.

   logic [13:0]  next_address;
   
   always @ ( posedge clk_in or posedge reset) begin
      if (reset)
	next_address <= 0;
      else if (next_address == 14'h3DFF)
	next_address <= 0;
      else begin
	 if (incr && ena) begin
	    next_address <= next_address + 14'h1;
	 end
      end
   end

   sonic_translate_address sta (.ext_read_addr(next_address),
				.clk(clk_in),
				.reset(reset),
				.int_read_addr(addr_out)
				);
   
endmodule // sonic_calc_address
