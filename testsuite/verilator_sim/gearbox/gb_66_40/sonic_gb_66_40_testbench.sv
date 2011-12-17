/*
 * Testbench for gearbox, introduce arbitrary delay
 * C++ testbench does not support delayed input.
 */

module sonic_gb_66_40_testbench (/*AUTOARG*/
   // Outputs
   data_out, rd_req_out,
   // Inputs
   data_in, clk_in, reset, ena
   ) ;
   input [65:0] data_in;
   input 	clk_in;
   input 	reset;
   input 	ena;
   
   output [39:0] data_out;
   output 	 rd_req_out;

   logic [65:0]	 data_in_delayed;

   /*
    * introduce one-cycle delay.
    */
   always @ (posedge clk_in) begin
      data_in_delayed <= data_in;
   end
      
   sonic_gearbox_66_40 gearbox (.data_in(data_in_delayed),
				.clk_in(clk_in),
				.reset(reset),
				.ena(ena),
				.data_out(data_out),
				.rd_req_out(rd_req_out)
				);
      
endmodule // gb_66_40_testbench
