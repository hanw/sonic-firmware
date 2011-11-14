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

//-------------------------------------------------

module sonic_downstream_gearbox #(
	parameter int INPUT_WIDTH = 64,
	parameter int OUTPUT_WIDTH = 40
	)(
	input logic clk,
	input logic reset,
	input logic ena,
	input logic [INPUT_WIDTH-1:0] data_in,
	output logic rdreq,
	output logic [OUTPUT_WIDTH-1:0] data_out
	);

   parameter IDLE = 8'b11111111;
   parameter S0   = 8'b0;
   parameter S1   = 8'b10;
   parameter S2   = 8'b100;
   parameter S3   = 8'b1000;
   parameter S4   = 8'b10000;
   parameter S5   = 8'b100000;
   parameter S6   = 8'b1000000;
   parameter S7   = 8'b10000000;
   
   reg [7:0] 				state;
   reg [7:0] 				next_state;
   
//	enum int unsigned { IDLE = 255, S0 = 0, S1 = 2, S2 = 4, S3 = 8, S4 = 16,
//						S5 = 32, S6 = 64, S7 = 128} state, next_state;

	// Used valid register and mux for gearboxing
	reg [INPUT_WIDTH-1:0] 		sr0;
	reg [INPUT_WIDTH-1:0] sr1;
	reg shift;
	reg shift_r;

	assign rdreq = shift;

	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			sr0 <= 64'h0;
			sr1 <= 64'h0;
		end
		else begin

			// Compensate for the memory access latency.
			// currently, the ram has latency of 1 clock cycle,
			// because the input signals to the ram are registered.
			shift_r <= shift;

			if (shift_r == 1'b1) begin
				sr0 <= data_in;
				sr1 <= sr0;
			end
		
			// State machine for 'data_out',
			// assumes that the first data is ready at S0 in sr0.
			// memory access latency is compensated by the 'shift' state machine
			case (state)
				S0:begin
					data_out <= {sr0[39:0]};
				end
				S1: begin
					data_out <= {sr0[15:0],sr1[63:40]};
				end
				S2: begin
					data_out <= {sr1[55:16]};
				end
				S3: begin
					data_out <= {sr0[31:0], sr1[63:56]};
				end
				S4: begin
					data_out <= {sr0[7:0], sr1[63:32]};
				end
				S5: begin
					data_out <= {sr1[47:8]};
				end
				S6: begin
					data_out <= {sr0[23:0], sr1[63:48]};
				end
				S7: begin
//					data_out <= {sr0[63:24]};	was for 'shift' state machine 0.
					data_out <= {sr1[63:24]};
				end
				IDLE:begin
					data_out <= 64'h0;
				end
			endcase

			// state machine for 'shift' signal when memory latency is zero cycle.
			// used for unit-test simulation, actual design has latency of one.
	/*		case (state)
				S0:begin
					shift	 <= 1'b1;
				end
				S1: begin
					shift	 <= 1'b0;
				end
				S2: begin
					shift	 <= 1'b1;
				end
				S3: begin
					shift	 <= 1'b1;
				end
				S4: begin
					shift	 <= 1'b0;
				end
				S5: begin
					shift	 <= 1'b1;
				end
				S6: begin
					shift	 <= 1'b0;
				end
				S7: begin
					shift	 <= 1'b1;
				end
				IDLE:begin
					shift	 <= 1'b1;
				end
			endcase
	*/
			//state machine for 'shift' signal,
			//when the read access latency to ram is one clock cycle.
			case (state)
				S0:begin
					shift	 <= 1'b0;
				end
				S1: begin
					shift	 <= 1'b1;
				end
				S2: begin
					shift	 <= 1'b1;
				end
				S3: begin
					shift	 <= 1'b0;
				end
				S4: begin
					shift	 <= 1'b1;
				end
				S5: begin
					shift	 <= 1'b0;
				end
				S6: begin
					shift	 <= 1'b1;
				end
				S7: begin
					shift	 <= 1'b1;
				end
				IDLE:begin
					shift	 <= 1'b1;
				end
			endcase
		
		end
	end
	
	always @(*) begin
		if (ena == 1'b0) 
			next_state = IDLE;
		else begin
			case(state)
				IDLE: next_state = S0;
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
	end

	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1)
			state <= IDLE;
		else 
			state <= next_state;
	end

endmodule
