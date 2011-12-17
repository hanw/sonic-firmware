//Legal Notice: (C)2011 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

///** This Verilog HDL file is used for simulation and synthesis in chained DMA design example
//    This file convert the Avalon ST streaming interface to Desc/Data
//    interface used by the application.
//*/
module sonic_application_top (

	// Avalon ST Rx interface
	input  [  7: 0] rx_st_bardec0,	
	input  [ 15: 0] rx_st_be0,		
	input  [127: 0] rx_st_data0,
	input           rx_st_empty0,
	input           rx_st_eop0,
	input           rx_st_err0,
	input           rx_st_sop0,
	input           rx_st_valid0,
	output          rx_st_ready0,

	// Avalon ST TX interface
	//
	output   [127: 0] tx_st_data0,
	output            tx_st_empty0,
	output            tx_st_eop0,
//	output            tx_st_err0,
	output            tx_st_sop0,
	output            tx_st_valid0,
	input		  tx_st_ready0,
	// MSI Interrupt
	// Desc/Data Interface only

	// MSI Interrupt
	// Avalon ST Interface only
	output[4:0]   pex_msi_num,
	output        app_msi_req,
	input         app_msi_ack, //reg
	output[2:0]   app_msi_tc,
	output[4:0]   app_msi_num,

	// Legacy Interrupt
	output        app_int_sts,
	input         app_int_ack,

	// Side band static signals
	// Desc/Data Interface only
	output		  rx_stream_mask0,
	// Side band static signals
	// Desc/Data Interface + Avalon ST Interface
	input [35:0] tx_stream_cred0,
	input tx_stream_fifo_empty0,

	// Configuration info signals
	// Desc/Data Interface + Avalon ST Interface
	input[12:0] cfg_busdev,  // Bus device number captured by the core
	input[31:0] cfg_devcsr,  // Configuration dev control status register of
							// PCIe capability structure (address 0x88)
	input[31:0] cfg_prmcsr,  // Control and status of the PCI configuration space (address 0x4)
	input[23:0] cfg_tcvcmap,
	input[31:0] cfg_linkcsr,
	input[15:0] cfg_msicsr,
	output      cpl_pending,
	output[6:0] cpl_err,
	output[127:0] err_desc,

	input 		xcvr_rx_clkout,
	input 		xcvr_tx_clkout,
	input  [39:0] xcvr_rx_dataout,
	output [39:0] xcvr_tx_datain,
	input		pma_tx_ready,
	input		pma_rx_ready,
	output		gen2_speed,
	input clk_in  ,
	input rstn
	);

	wire    [ 81: 0] rx_stream_data0;
	wire    [ 81: 0] rx_stream_data0_1;
	wire             rx_stream_valid0;
	wire             rx_stream_ready0;

	wire    [ 74: 0] tx_stream_data0;
	wire    [ 74: 0] tx_stream_data0_1;
	wire             tx_stream_ready0;
	wire             tx_stream_valid0;

	wire	[  7: 0] open_msi_stream_data0;
	wire             open_msi_stream_valid0;
	wire			 gnd_msi_stream_ready0;
	wire	[  9: 0] open_pm_data;
	wire	[23:0]	 gnd_cfg_tcvcmap_icm;
	wire	[  4: 0] open_aer_msi_num;
	wire    [ 19: 0] ko_cpl_spc_vc0;

	assign rx_stream_valid0 = rx_st_valid0;
	assign rx_st_ready0 = rx_stream_ready0;

	assign tx_st_valid0 = tx_stream_valid0;
	assign tx_stream_ready0 = tx_st_ready0;

	assign gnd_tx_stream_mask0 = 1'b0;
	assign gnd_msi_stream_ready0 = 1'b0;
	assign gnd_cfg_tcvcmap_icm = 0;
	assign gnd_pm_data = 0;

	assign ko_cpl_spc_vc0[7 : 0] = 8'd112;
	assign ko_cpl_spc_vc0[19 : 8] = 12'd448;

	assign tx_st_sop0 = tx_stream_data0[73];
	assign tx_st_err0 = tx_stream_data0[74];
	assign rx_stream_data0 = {rx_st_be0[7 : 0], rx_st_sop0, rx_st_empty0, rx_st_bardec0, rx_st_data0[63 : 0]};
	assign rx_stream_data0_1 = {rx_st_be0[15 : 8], rx_st_sop0, rx_st_eop0, rx_st_bardec0, rx_st_data0[127 : 64]};
	assign tx_st_data0 = {tx_stream_data0_1[63 : 0],tx_stream_data0[63 : 0]};
	assign tx_st_eop0 = tx_stream_data0_1[72];
	assign tx_st_empty0 = tx_stream_data0[72];
	
	assign gen2_speed = cfg_linkcsr[17];

	sonic_application_streaming_port app
	(
	  .aer_msi_num (open_aer_msi_num),
	  .app_int_ack (app_int_ack),
	  .app_int_sts (app_int_sts),
	  .app_msi_ack (app_msi_ack),
	  .app_msi_num (app_msi_num),
	  .app_msi_req (app_msi_req),
	  .app_msi_tc (app_msi_tc),
	  .cfg_busdev (cfg_busdev),
	  .cfg_devcsr (cfg_devcsr),
	  .cfg_linkcsr (cfg_linkcsr),
	  .cfg_msicsr (cfg_msicsr),
	  .cfg_prmcsr (cfg_prmcsr),
	  .cfg_tcvcmap (gnd_cfg_tcvcmap_icm),
	  .clk_in (clk_in),
	  .cpl_err (cpl_err),
	  .cpl_pending (cpl_pending),
	  .err_desc (err_desc),
	  .ko_cpl_spc_vc0 (ko_cpl_spc_vc0),
	  .msi_stream_data0 (open_msi_stream_data0),
	  .msi_stream_ready0 (gnd_msi_stream_ready0),
	  .msi_stream_valid0 (open_msi_stream_valid0),
	  .pex_msi_num (pex_msi_num),
	  .pm_data (open_pm_data),
	  .rstn (rstn),
	  .rx_stream_data0_0 (rx_stream_data0),
	  .rx_stream_data0_1 (rx_stream_data0_1),
	  .rx_stream_mask0 (rx_stream_mask0),
	  .rx_stream_ready0 (rx_stream_ready0),
	  .rx_stream_valid0 (rx_stream_valid0),
	  .test_sim (1'b0),// (test_in[0]),
	  .tx_stream_cred0 (tx_stream_cred0),
	  .tx_stream_data0_0 (tx_stream_data0),
	  .tx_stream_data0_1 (tx_stream_data0_1),
	  .tx_stream_fifo_empty0 (tx_stream_fifo_empty0),
	  .tx_stream_mask0 (gnd_tx_stream_mask0),
	  .tx_stream_ready0 (tx_stream_ready0),
	  .tx_stream_valid0 (tx_stream_valid0),

	  .xcvr_rx_clkout(xcvr_rx_clkout),
	  .xcvr_tx_clkout(xcvr_tx_clkout),
	  .xcvr_rx_dataout(xcvr_rx_dataout),
	  .xcvr_tx_datain(xcvr_tx_datain),
	  .pma_tx_ready(pma_tx_ready),
	  .pma_rx_ready(pma_rx_ready)
	);

	defparam app.AVALON_WADDR = 13,
		   app.CHECK_BUS_MASTER_ENA = 1,
		   app.CHECK_RX_BUFFER_CPL = 1,
		   app.CLK_250_APP = 1,
		   app.ECRC_FORWARD_CHECK = 0,
		   app.ECRC_FORWARD_GENER = 0,
		   app.MAX_NUMTAG = 32,
		   app.MAX_PAYLOAD_SIZE_BYTE = 512,
		   app.TL_SELECTION = 7,
		   app.TXCRED_WIDTH = 36;


endmodule

