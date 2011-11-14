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


`timescale 1ns/10ps
// 
// Reset controller for Stratix IV PMA channels with RX CDR in auto-lock mode. 
//
// Uses alt_reset_ctrl_lego to handle each reset stage, with 3 required for the overall sequence.
// Parameter default for lock-to-data-auto timer assumes 50 MHz system clock
//
//	$Header$
//

`timescale 1 ns / 1 ns

module	tgx_ch_reset_ctrl
#(
	parameter	sys_clk_in_mhz = 50	// needed for 1us and 4us delay timers
)
(
	// User inputs and outputs
	input	wire	clk,
	input	tri1	reset_all,
	input	tri0	reset_tx_digital,
	input	tri0	reset_rx_digital,
	input	wire	rst,
	output	wire	tx_ready,
	output	wire	rx_ready,
	
	// I/O to Stratix IV transceiver control & status
//	output	wire	pll_powerdown,		// reset TX PLL
	output	wire	tx_digitalreset,	// reset TX PCS
	output	wire	rx_analogreset,		// reset RX PMA
	output	wire	rx_digitalreset,	// reset RX PCS
//	output	wire	gxb_powerdown,		// powerdown whole quad
	input	wire	pll_is_locked,		// TX PLL is locked status
	input	tri0	rx_oc_busy,			// RX channel offset cancellation status
	input	tri1	rx_is_lockedtodata	// RX CDR PLL is locked to data status
);

localparam clk_in_mhz =
`ifdef QUARTUS__SIMGEN
	2;	// simulation-only value
`elsif ALTERA_RESERVED_QIS
	sys_clk_in_mhz;	// use real counter lengths for normal Quartus synthesis
`else
	2;	// simulation-only value
`endif
localparam t_ltd_auto = clk_in_mhz*4; // 4 us minimum

wire tx_digital_rst_done;
wire rx_digital_rst_done;
wire tx_digital_rst_only;
wire rx_digital_rst_only;
//wire rx_analog_rst_int;
wire rx_analog_rst_done;
wire rx_digital_rst_int;
wire tx_digital_rst_int;

alt_reset_ctrl_lego #(
	.reset_hold_cycles (3)	// reset pulse length in clock cycles
) tx_digital_only_rst_lego (
	.clock(clk),
	.start(reset_all),
	.reset(tx_digital_rst_only),
	.aclr(rst),
	.rdone(tx_digital_rst_done),	// reset done signal
	.sdone(tx_ready)	// sequence done for this lego
);

alt_reset_ctrl_lego #(
	.reset_hold_cycles (3)	// reset pulse length in clock cycles
) rx_digital_only_rst_lego (
	.clock(clk),
	.start(reset_all),
	.reset(rx_digital_rst_only),
	.aclr(rst),
	.rdone(rx_digital_rst_done),	// reset done signal
	.sdone(rx_ready)	// sequence done for this lego
);


alt_reset_ctrl_lego #(
	.reset_hold_til_rdone (1),	// reset pulse length in clock cycles
	.sdone_delay_cycles (2)	// reset pulse length in clock cycles
) rx_analog_rst_lego (
	.clock(clk),
	.start(reset_all),
	.reset(rx_analogreset),
	.aclr(rst),
	.rdone(!rx_oc_busy & tx_digital_rst_done),	// reset done signal
	.sdone(rx_analog_rst_done)	// sequence done for this lego
);

alt_reset_ctrl_lego #(
	.reset_hold_til_rdone (1),	// reset pulse length in clock cycles
	.sdone_delay_cycles(t_ltd_auto) // hold rx_digitalreset for 4us
) rx_digital_rst_lego (
	.clock(clk),
	.start(reset_all),
	.reset(rx_digital_rst_int),
	.aclr(rst),
	.rdone(rx_analog_rst_done & rx_is_lockedtodata),	// reset done signal
	.sdone(rx_digital_rst_done)	// sequence done for this lego
);

alt_reset_ctrl_lego #(
	.reset_hold_til_rdone (1),	// reset pulse length in clock cycles
	.sdone_delay_cycles (2)	// reset pulse length in clock cycles
) tx_digital_rst_lego (
	.clock(clk),
	.start(reset_all),
	.reset(tx_digital_rst_int),
	.aclr(rst),
	.rdone(pll_is_locked),	// reset done signal
	.sdone(tx_digital_rst_done)	// sequence done for this lego
);

assign tx_digitalreset = tx_digital_rst_only | tx_digital_rst_int;
assign rx_digitalreset = rx_digital_rst_only | rx_digital_rst_int;

endmodule

