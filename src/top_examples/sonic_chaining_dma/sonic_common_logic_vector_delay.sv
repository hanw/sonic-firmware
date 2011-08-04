// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030
//-----------------------------------------------------------------------------
// Title         : 
// Project       : 
//-----------------------------------------------------------------------------
// File          : 
// Author        : 
//-----------------------------------------------------------------------------
// Description :
// 
// 
//-----------------------------------------------------------------------------

module sonic_common_logic_vector_delay # (
	parameter WIDTH = 1,
	parameter DELAY = 0
	)(
	// clock, enable and reset
	input logic clock,
	input logic reset,
	input logic ena,
	// input and output
	input logic [WIDTH-1:0] data,
	output logic [WIDTH-1:0] q
	);
	
	int i;

	generate 
		// if zero delay is requested, just combinationally pass through
		if (DELAY == 1'b0) begin
			assign q = data;
		end
		// if one or more cycles of delay have been requested, build a simple
		// shift register and do the delaying.
		else begin
			logic [WIDTH-1:0] shift_register [0:DELAY-1];
			
			always @ (posedge reset or posedge clock) begin
				if (reset == 1'b1) begin
					for (int i = 0; i < DELAY; i++)
						shift_register[i] <= {WIDTH{1'b0}};
				end
				else begin
					if (ena == 1'b1) begin
						for (i = 0; i <= DELAY-2; i=i+1) begin
							shift_register[i] <= shift_register[i+1];
						end
						shift_register[DELAY-1] <= data;
					end
				end
			end
			// assign output from the end of shift register
			assign q = shift_register[0];
		end
	endgenerate
endmodule
