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
// Description : We assume the lower bits goes out first, and the bits are
//               assigned to the lower bits of the output register.
//               For example, if we assign 0xaabbccddee to output register, at
//               state 3, we will assign the ee to sr1[63:56] and copy 
//               sr0[55:0] to sr1[55:0]
// 
//	Here is how the state machine works:
//		Upon reset, everything is clear, sr0 and sr1 all contains zeros.
//		S0:	sr0[39:0] <= data_in, valid = 0.
//		S1: sr0 shift to sr1, sr1[63:40] <= data_in[23:0],
//			sr0[15:0] <= data_in[39:24], valid = 1.
//		S2:	sr0 shift to sr1, sr1[55:16] <= data_in[39:0],
//			valid = 0.
//		S3: sr1[63:56] <= data_in[7:0], sr0[31:0] <= data_in[39:8],
//			valid = 1.
//		S4: sr0 shift to sr1, sr1[63:32] <= data_in[31:0], 
//			sr0[7:0] <= data_in[39:32].
//			vaild = 1.
//		S5: sr0 shift to sr1, sr1[47:8] <= data_in[39:0], valid = 0.
//		S6: sr1[63:48] <= data_in[15:0], sr0[23:0] <= data_in[39:16], 
//			valid = 1.
//		S7: sr0 shift to sr1, sr1[63:24] <= data_in[39:0], valid = 1.
//
//
//-----------------------------------------------------------------------------

//-------------------------------------------------

module sonic_upstream_gearbox #(
	parameter int INPUT_WIDTH = 40,
	parameter int OUTPUT_WIDTH = 64
	)(
	input logic clk,
	input logic reset,
	input logic [INPUT_WIDTH-1:0] data_in,
	output logic [OUTPUT_WIDTH-1:0] data_out, 
	output logic data_valid
	);

	enum int unsigned { IDLE = 255, S0 = 0, S1 = 2, S2 = 4, S3 = 8, S4 = 16,
						S5 = 32, S6 = 64, S7 = 128} state, next_state;

	// Used valid register and mux for gearboxing
	reg [OUTPUT_WIDTH-1:0] sr0;
	reg [OUTPUT_WIDTH-1:0] sr1;
	reg valid;

/* Old implementation, not working.
	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			sr0 <= 64'h0;
			sr1 <= 64'h0;
			valid <= 0;
		end
		else begin
			case (state)
			S0:begin
				sr0[63:24]	<= data_in[39:0];
				sr0[23:0]	<= 0;
				sr1[63:0]	<= 0;
				valid		<= 0;
			end
			S1: begin
				sr1[63:24]	<= sr0[63:24];
				sr1[23:0]	<= data_in[39:16];
				sr0[63:48]	<= data_in[15:0];
				sr0[47:0]	<= 0;
				valid		<= 1;
			end
			S2: begin
				sr0[47:8]	<= data_in[39:0];
				valid		<= 0;
			end
			S3: begin
				sr1[63:8]	<= sr0[63:8];
				sr1[7:0]	<= data_in[39:32];
				sr0[63:32]	<= data_in[31:0];
				sr0[31:0]	<= 0;
				valid		<= 1;
			end
			S4: begin 
				sr1[63:32]	<= sr0[63:32];
				sr1[31:0]	<= data_in[39:8];
				sr0[63:56]	<= data_in[7:0];
				sr0[55:0]	<= 0;
				valid		<= 1;
			end
			S5: begin
				sr0[55:16]	<= data_in[39:0];
				valid		<= 0;
			end
			S6: begin
				sr1[63:16]  <= sr0[63:16];
				sr1[15:0]	<= data_in[39:24];
				sr0[63:40]	<= data_in[23:0];
				sr0[39:0]	<= 0;
				valid		<= 1;
			end
			S7: begin
				sr1[63:40]	<= sr0[63:40];
				sr1[39:0]	<= data_in[39:0];
				valid		<= 1;
			end
			endcase
		end
	end
*/	

	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			sr0 <= 64'h0;
			sr1 <= 64'h0;
			valid <= 0;
		end
		else begin
			case (state)
			S0:begin
				sr0[39:0]	<= data_in[39:0];
				sr0[63:40]	<= 0;
				sr1[63:0]	<= 0;
				valid		<= 0;
			end
			S1: begin
				sr1[39:0]	<= sr0[39:0];
				sr1[63:40]	<= data_in[23:0];
				sr0[15:0]	<= data_in[39:24];
				sr0[63:16]	<= 0;
				valid		<= 1;
			end
			S2: begin
				sr1[15:0]	<= sr0[15:0];
				sr1[55:16]	<= data_in[39:0];
				sr1[63:56]	<= 0;
				valid		<= 0;
			end
			S3: begin
				sr1[63:56]	<= data_in[7:0];
				sr0[31:0]	<= data_in[39:8];
				sr0[63:32]	<= 0;
				valid		<= 1;
			end
			S4: begin 
				sr1[31:0]	<= sr0[31:0];
				sr1[63:32]	<= data_in[31:0];
				sr0[7:0]	<= data_in[7:0];
				sr0[63:8]	<= 0;
				valid		<= 1;
			end
			S5: begin
				sr1[7:0]	<= sr0[7:0];
				sr1[47:8]	<= data_in[39:0];
				sr1[63:48]	<= 0;
				valid		<= 0;
			end
			S6: begin
				sr1[63:48]	<= data_in[15:0];
				sr0[23:0]	<= data_in[39:16];
				sr0[63:24]	<= 0;
				valid		<= 1;
			end
			S7: begin
				sr1[23:0]	<= sr0[23:0];
				sr1[63:24]	<= data_in[39:0];
				valid		<= 1;
			end
			endcase
		end
	end

	always @(*) begin
		case(state)
			S0: next_state = S1;
			S1: next_state = S2;
			S2: next_state = S3;
			S3: next_state = S4;
			S4: next_state = S5;
			S5: next_state = S6;
			S6: next_state = S7;
			S7: next_state = S0;
		endcase
	end

	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1)
			state <= S0;
		else 
			state <= next_state;
	end

	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			data_out <= 64'h0;
		end
		else if (valid == 1'b1) begin
			data_out <= sr1;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			data_valid <= 0;
		end
		else begin
			data_valid <= valid;
		end
	end
endmodule
