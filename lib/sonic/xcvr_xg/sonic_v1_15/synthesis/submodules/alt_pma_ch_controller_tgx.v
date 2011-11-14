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
module alt_pma_ch_controller_tgx #(
  parameter
  	number_of_channels = 4, 
  	sys_clk_in_mhz = 50,  // used to calculate internal delays in terms of system clock cycles
  	sync_depth =2
  )
  (            
	//controller standard interface to user
	input   tri0		rst, // controller logic reset
//	input   wire		powerdown_all, // save power
	input   tri0		rx_rst_digital, // tx_digitalreset
	input   tri0		tx_rst_digital, // rx_digitalreset
	output  wire		tx_pma_ready, // pma tx pll_locked
	output  wire		rx_pma_ready, // pma rx pll is locked to data
	input   tri0		rx_oc_busy, // rx offset cancellation busy
	input   tri1		pll_locked, // tx pll_locked
	
	// user data (avalon-MM formatted) 
	input 	wire      	clk,
	input 	tri0 [5:0]	ch_mgmt_address,
	input 	tri1       	ch_mgmt_read,
	output	wire [31:0]	ch_mgmt_readdata,
	input 	tri0       	ch_mgmt_write,
	input 	tri0 [31:0]	ch_mgmt_writedata,
	output	wire		ch_mgmt_waitrequest,
	
	input    tri1 [number_of_channels-1:0]	rx_is_lockedtodata,
	input    tri1 [number_of_channels-1:0]	rx_is_lockedtoref,
	
	output   wire [number_of_channels-1:0]	rx_set_locktodata,
	output   wire [number_of_channels-1:0]	rx_set_locktoref,
	output   wire [number_of_channels-1:0]	rx_seriallpbken,
	
	output   wire [number_of_channels-1:0]	rx_analog_rst,
	output   wire [number_of_channels-1:0]	tx_digital_rst,
	output   wire [number_of_channels-1:0]	rx_digital_rst
);
	// reset controller outputs
	wire  reset_controller_tx_ready;
	wire  reset_controller_rx_ready;
	wire  reset_controller_pll_powerdown;
	wire  reset_controller_tx_digitalreset;
	wire  reset_controller_rx_analogreset;
	wire  reset_controller_rx_digitalreset;

	// Control & status register map (CSR) outputs
	wire  csr_reset_tx_digital;	// to reset controller
	wire  csr_reset_rx_digital;	// to reset controller
	wire  csr_reset_all;		// to reset controller
	wire [number_of_channels - 1 : 0] csr_tx_digitalreset;		// to xcvr instance
	wire [number_of_channels - 1 : 0] csr_rx_analogreset;		// to xcvr instance
	wire [number_of_channels - 1 : 0] csr_rx_digitalreset;		// to xcvr instance
	wire [number_of_channels - 1 : 0] csr_phy_loopback_serial;	// to xcvr instance
	wire [number_of_channels - 1 : 0] csr_rx_set_locktoref;		// to xcvr instance
	wire [number_of_channels - 1 : 0] csr_rx_set_locktodata;		// to xcvr instance


	///////////////////////////////////////////////////////////////////	

	// Implement waitrequest to match previous implementation
	altera_wait_generate wait_gen(
	 .rst(rst),
	.clk(clk),
	.launch_signal(ch_mgmt_read),
	.wait_req(ch_mgmt_waitrequest)
	 );
	// Instantiate memory map logic for given number of lanes & PLL's
	// Includes all except PCS
	alt_xcvr_csr_common #(
		.lanes(number_of_channels),
		.plls(1)
	) csr (
		.clk(clk),
		.reset(rst),
		.address(8'h40 | ch_mgmt_address), // map word 0 of this module to word 64 of alt_xcvr_csr_common
		.read(ch_mgmt_read),
		.write(ch_mgmt_write),
		.writedata(ch_mgmt_writedata),
		.pll_locked(pll_locked),
		.rx_is_lockedtoref(rx_is_lockedtoref),
		.rx_is_lockedtodata(rx_is_lockedtodata),
		.rx_signaldetect(),
		.reset_controller_tx_ready(reset_controller_tx_ready),
		.reset_controller_rx_ready(reset_controller_rx_ready),
		.reset_controller_pll_powerdown(reset_controller_pll_powerdown),
		.reset_controller_tx_digitalreset(reset_controller_tx_digitalreset),
		.reset_controller_rx_analogreset(reset_controller_rx_analogreset),
		.reset_controller_rx_digitalreset(reset_controller_rx_digitalreset),
		.readdata(ch_mgmt_readdata),
		.csr_reset_tx_digital(csr_reset_tx_digital),
		.csr_reset_rx_digital(csr_reset_rx_digital),
		.csr_reset_all(csr_reset_all),
		.csr_pll_powerdown(),
		.csr_tx_digitalreset(csr_tx_digitalreset),
		.csr_rx_analogreset(csr_rx_analogreset),
		.csr_rx_digitalreset(csr_rx_digitalreset),
		.csr_phy_loopback_serial(csr_phy_loopback_serial),
		.csr_rx_set_locktoref(csr_rx_set_locktoref),
		.csr_rx_set_locktodata(csr_rx_set_locktodata)
	);


	// Instantiate reset controller for PMA channels
	alt_reset_ctrl_tgx_cdrauto #(
		.sys_clk_in_mhz(sys_clk_in_mhz)
	) rc (
		.clock(clk),
		.reset_all(csr_reset_all),
		.reset_tx_digital(csr_reset_tx_digital | tx_rst_digital),
		.reset_rx_digital(csr_reset_rx_digital | rx_rst_digital),
		.powerdown_all(rst),
		.tx_ready(reset_controller_tx_ready),
		.rx_ready(reset_controller_rx_ready),
		.pll_powerdown (),
		.tx_digitalreset(reset_controller_tx_digitalreset),
		.rx_analogreset(reset_controller_rx_analogreset),
		.rx_digitalreset(reset_controller_rx_digitalreset),
		.gxb_powerdown(),
		.pll_is_locked(pll_locked),
		.rx_oc_busy(rx_oc_busy),
		.rx_is_lockedtodata(&rx_is_lockedtodata),
		.manual_mode()
	);

	// Assign outputs from reset controller
	assign tx_pma_ready = reset_controller_tx_ready;
	assign rx_pma_ready = reset_controller_rx_ready;

	// Assign outputs from CSR to channel control bits
	assign rx_set_locktodata = csr_rx_set_locktodata;
	assign rx_set_locktoref = csr_rx_set_locktoref;
	assign rx_seriallpbken = csr_phy_loopback_serial;
 
	assign rx_analog_rst = csr_rx_analogreset;
	assign tx_digital_rst = csr_tx_digitalreset;
	assign rx_digital_rst = csr_rx_digitalreset;

endmodule

