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
module sonic_common_signal_clock_crosser # (
	parameter WIDTH = 8,
	parameter SHIFT_REGISTER_LENGTH = 3
	) (
	// clock and reset
	input logic inclock,
	input logic outclock,
	input logic inena,
	input logic outena,
	input logic reset,

	input logic [WIDTH-1:0] data,
	output logic [WIDTH-1:0] q
	);
	
	// a shift register, to carry the data across the clock domains avoiding metastability
	//localparam SHIFT_REGISTER_LENGTH = 3;
	
	(* altera_attribute = "-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS" *)
	(* preserve *) reg [WIDTH-1:0] shift_register [0:SHIFT_REGISTER_LENGTH-1];
	
	int i_shift;
	// shift register to cross clock domains and avoid metastability
	always @ (posedge reset or posedge outclock) begin
		if (reset == 1'b1) begin
			for (int i = 0; i < SHIFT_REGISTER_LENGTH; i++) 
				shift_register[i] <= {WIDTH{1'b0}};
		end
		else begin
			for (i_shift = 0; i_shift <= SHIFT_REGISTER_LENGTH-2; i_shift=i_shift+1) begin
				shift_register[i_shift] <= shift_register[i_shift+1];
			end
			// this statemenet cross clock domains
			shift_register[SHIFT_REGISTER_LENGTH-1] <= data;
		end
	end

	// driver output lines
	assign q = shift_register[0];

endmodule
