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
module sonic_common_gray_clock_crosser # (
	parameter WIDTH = 8
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
	
	// this signal holds the input data converted to gray format
	logic [WIDTH-1:0] gray_data;	
	
	// a shift register, to carry the gray data across the clock domains avoiding metastability
	localparam SHIFT_REGISTER_LENGTH = 3;
	
	(* altera_attribute = "-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS" *)
	(* preserve *) reg [WIDTH-1:0] shift_register [0:SHIFT_REGISTER_LENGTH-1];
	
	logic [WIDTH-1:0] q_reg;

	// convert input to gray format
	always @ (posedge reset or posedge inclock) begin
		if (reset == 1'b1) begin
			gray_data <= 0;
		end
		else if (inena == 1'b1) begin
			gray_data <= data ^ {1'b0,data[WIDTH-1:1]};
		end
	end
	
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
			shift_register[SHIFT_REGISTER_LENGTH-1] <= gray_data;
		end
	end

	logic [WIDTH-1:0] partial_xor;
	logic zeros = {WIDTH{1'b0}};

	int i_out;
	// convert the output of the shift register back to binary for output
	always @ (posedge reset or posedge outclock) begin
		if (reset == 1'b1) begin
			q_reg <= 0;
			end
		else if (outena == 1'b1) begin
			partial_xor = shift_register[0];
	
			for (i_out = 1; i_out < WIDTH; i_out++) begin
				partial_xor = partial_xor ^ (shift_register[0] >> i_out);
			end
			
			q_reg <= partial_xor;
		end
	end
	
	// driver output lines
	assign q = q_reg;

endmodule
