// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"{-to addr_shift_reg[31]} DPRIO_INTERFACE_REG=ON;{-to wr_out_data_shift_reg[31]} DPRIO_INTERFACE_REG=ON;{-to rd_out_data_shift_reg[13]} DPRIO_INTERFACE_REG=ON;{-to in_data_shift_reg[0]} DPRIO_INTERFACE_REG=ON;{-to startup_cntr[0]} DPRIO_INTERFACE_REG=ON;{-to startup_cntr[1]} DPRIO_INTERFACE_REG=ON;{-to startup_cntr[2]} DPRIO_INTERFACE_REG=ON"} *)
module  alt_dprio	( 
	input   wire [15:0]  address,
	output   wire busy,
	input   wire [15:0]  datain,
	output wire  [15:0]  dataout,
	input   wire dpclk,
	output  wire dpriodisable,
	output  wire dprioin,
	output wire  dprioload,
	input   wire dprioout,
	input   wire [6:0]  quad_address,
	input wire rden,
	input wire wren,
	input wire wren_data
	);

	(* ALTERA_ATTRIBUTE = {"PRESERVE_REGISTER=ON;POWER_UP_LEVEL=LOW"} *)
	reg	[31:0]	addr_shift_reg;
	(* ALTERA_ATTRIBUTE = {"PRESERVE_REGISTER=ON;POWER_UP_LEVEL=LOW"} *)
	reg	[15:0]	in_data_shift_reg;
	(* ALTERA_ATTRIBUTE = {"PRESERVE_REGISTER=ON;POWER_UP_LEVEL=LOW"} *)
	reg	[15:0]	rd_out_data_shift_reg;
	(* ALTERA_ATTRIBUTE = {"PRESERVE_REGISTER=ON;POWER_UP_LEVEL=LOW"} *)
	reg	[2:0]	startup_cntr;
	(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
	reg	[2:0]	state_mc_reg;
	(* ALTERA_ATTRIBUTE = {"PRESERVE_REGISTER=ON;POWER_UP_LEVEL=LOW"} *)
    reg	[31:0]	wr_out_data_shift_reg;
	(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
	reg  [5:0]   state_mc_counter_q;

	wire  pre_amble_cmpr_agb;
	wire  [7:0]   state_mc_decode_eq;
	wire	dprioin_mux_dataout;
	wire  busy_state;
	wire  idle_state;
	wire  rd_addr_done;
	wire  rd_addr_state;
	wire  rd_data_done;
	wire  rd_data_input_state;
	wire  rd_data_output_state;
	wire  rd_data_state;
	wire rdinc;
	wire  read_state;
	wire  s0_to_0;
	wire  s0_to_1;
	wire  s1_to_0;
	wire  s1_to_1;
	wire  s2_to_0;
	wire  s2_to_1;
	wire  startup_done;
	wire  startup_idle;
	wire  wr_addr_done;
	wire  wr_addr_state;
	wire  wr_data_done;
	wire  wr_data_state;
	wire  write_state;
	wire  [2:0] startup_cntr_d;
	wire  [2:0]	startup_cntr_ena;

	// synopsys translate_off
	initial
	begin
		addr_shift_reg = 0;
		in_data_shift_reg = 0;
		rd_out_data_shift_reg = 0;
		startup_cntr[2:0] = 3'b0;
		state_mc_reg = 0;
		wr_out_data_shift_reg = 0;
		state_mc_counter_q = 6'b0;
	end
	// synopsys translate_on

	always @ (posedge dpclk)
	begin
        if (state_mc_counter_q == 6'b011111)
        begin
            addr_shift_reg <= {{2{{2{1'b0}}}}, {3{1'b0}}, quad_address, 2'b10, address};
            rd_out_data_shift_reg <= {{2{1'b0}}, {2{1'b1}}, {3{1'b0}}, quad_address, 2'b10};
            wr_out_data_shift_reg <= {{2{1'b0}}, 2'b01, {3{1'b0}}, quad_address, 2'b10, datain};
        end
        else begin
            addr_shift_reg <= {addr_shift_reg[30:0], 1'b0};
            rd_out_data_shift_reg <= {rd_out_data_shift_reg[14:0], 1'b0};
            wr_out_data_shift_reg <= {wr_out_data_shift_reg[30:0], 1'b0};
        end
        
        if (rd_data_input_state == 1'b1)
            in_data_shift_reg <= {in_data_shift_reg[14:0], dprioout};
    end
			
	always @ (posedge dpclk)
	begin
        if (startup_cntr_ena[0] == 1'b1)
		    startup_cntr[0] <= startup_cntr_d[0];
        if (startup_cntr_ena[1:1] == 1'b1)
            startup_cntr[1] <= startup_cntr_d[1];
        if (startup_cntr_ena[2:2] == 1'b1)
            startup_cntr[2] <= startup_cntr_d[2];
    end
    
	assign startup_cntr_d = {(startup_cntr[2] ^ (startup_cntr[1] & startup_cntr[0])), (startup_cntr[0] ^ startup_cntr[1]), (~ startup_cntr[0])};
	assign startup_cntr_ena = {3{((((rden | wren) | rdinc) | (~ startup_idle)) & (~ startup_done))}};
	
	always @ ( posedge dpclk)
	begin
	    state_mc_reg <= {(s2_to_1 | (((~ s2_to_0) & (~ s2_to_1)) & state_mc_reg[2])), (s1_to_1 | (((~ s1_to_0) & (~ s1_to_1)) & state_mc_reg[1])), (s0_to_1 | (((~ s0_to_0) & (~ s0_to_1)) & state_mc_reg[0]))};
    end

    always @(posedge dpclk)
    begin
        if (write_state | read_state)
        begin
            if (state_mc_counter_q == 6'b111111)
                state_mc_counter_q <= 6'b0;
            else
                state_mc_counter_q <= state_mc_counter_q[5:0] + 6'b1;
        end
    end
    
	lpm_decode #(
		.lpm_decodes (8),
		.lpm_width (3),
		.lpm_type ("lpm_decode"))
		state_mc_decode( 
	.data(state_mc_reg),
	.eq(state_mc_decode_eq)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clken(1'b1),
	.clock(1'b0),
	.enable(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
		
	or(dprioin_mux_dataout, ((((((wr_addr_state | rd_addr_state) & addr_shift_reg[31]) & pre_amble_cmpr_agb) | ((~ pre_amble_cmpr_agb) & (wr_addr_state | rd_addr_state))) | (((wr_data_state & wr_out_data_shift_reg[31]) & pre_amble_cmpr_agb) | ((~ pre_amble_cmpr_agb) & wr_data_state))) | (((rd_data_output_state & rd_out_data_shift_reg[15]) & pre_amble_cmpr_agb) | ((~ pre_amble_cmpr_agb) & rd_data_output_state))), ~(((write_state | rd_addr_state) | rd_data_output_state)));
	
	assign
        pre_amble_cmpr_agb = (state_mc_counter_q > 6'b011111),
		busy = busy_state,
		busy_state = (write_state | read_state),
		dataout = in_data_shift_reg,
		dpriodisable = (~ (startup_cntr[2] & (startup_cntr[0] | startup_cntr[1]))),
		dprioin = dprioin_mux_dataout,
		dprioload = (~ ((startup_cntr[0] ^ startup_cntr[1]) & (~ startup_cntr[2]))),
		idle_state = state_mc_decode_eq[0],
		
		rd_addr_done = (rd_addr_state & (state_mc_counter_q == 6'b111111)),
		
		rd_addr_state = (state_mc_decode_eq[5] & startup_done),
        rd_data_done = (rd_data_state & (state_mc_counter_q == 6'b111111)),
        	
		rd_data_input_state = ((state_mc_counter_q >= 6'b110000) & rd_data_state),
		
		rd_data_output_state = (state_mc_counter_q < 6'b110000 & rd_data_state),
		rd_data_state = (state_mc_decode_eq[7] & startup_done),
		rdinc = 1'b0,
		read_state = (rd_addr_state | rd_data_state),
		s0_to_0 = ((wr_data_state & wr_data_done) | (rd_data_state & rd_data_done)),
		s0_to_1 = (((idle_state & (wren | ((~ wren) & ((rden | rdinc) | wren_data)))) | (wr_addr_state & wr_addr_done)) | (rd_addr_state & rd_addr_done)),
		s1_to_0 = (((wr_data_state & wr_data_done) | (rd_data_state & rd_data_done)) | (idle_state & (wren | (((~ wren) & (~ wren_data)) & rden)))),
		s1_to_1 = (((idle_state & ((~ wren) & (rdinc | wren_data))) | (wr_addr_state & wr_addr_done)) | (rd_addr_state & rd_addr_done)),
		s2_to_0 = ((((wr_addr_state & wr_addr_done) | (wr_data_state & wr_data_done)) | (rd_data_state & rd_data_done)) | (idle_state & (wren | wren_data))),
		s2_to_1 = ((idle_state & (((~ wren) & (~ wren_data)) & (rdinc | rden))) | (rd_addr_state & rd_addr_done)),
		startup_done = ((startup_cntr[2] & (~ startup_cntr[0])) & startup_cntr[1]),
		startup_idle = ((~ startup_cntr[0]) & (~ (startup_cntr[2] ^ startup_cntr[1]))),
		
        wr_addr_done = (wr_addr_state & (state_mc_counter_q == 6'b111111)),
        
		wr_addr_state = (state_mc_decode_eq[1] & startup_done),
		
        wr_data_done = (wr_data_state & (state_mc_counter_q == 6'b111111)),
        
		wr_data_state = (state_mc_decode_eq[3] & startup_done),
		write_state = (wr_addr_state | wr_data_state);
endmodule //alt_dprio

