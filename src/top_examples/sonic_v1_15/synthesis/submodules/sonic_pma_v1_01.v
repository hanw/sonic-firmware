// megafunction wizard: %Low Latency PHY v11.0%
// GENERATION: XML
// sonic_pma_v1_01.v

// 

`timescale 1 ps / 1 ps
module sonic_pma_v1_01 (
		input  wire        phy_mgmt_clk,         //       phy_mgmt_clk.clk
		input  wire        phy_mgmt_clk_reset,   // phy_mgmt_clk_reset.reset
		input  wire [8:0]  phy_mgmt_address,     //           phy_mgmt.address
		input  wire        phy_mgmt_read,        //                   .read
		output wire [31:0] phy_mgmt_readdata,    //                   .readdata
		output wire        phy_mgmt_waitrequest, //                   .waitrequest
		input  wire        phy_mgmt_write,       //                   .write
		input  wire [31:0] phy_mgmt_writedata,   //                   .writedata
		output wire        tx_ready,             //           tx_ready.export
		output wire        rx_ready,             //           rx_ready.export
		input  wire        pll_ref_clk,          //        pll_ref_clk.clk
		output wire        pll_locked,           //         pll_locked.export
		output wire        tx_serial_data,       //     tx_serial_data.export
		input  wire        rx_serial_data,       //     rx_serial_data.export
		output wire        rx_is_lockedtoref,    //  rx_is_lockedtoref.export
		output wire        rx_is_lockedtodata,   // rx_is_lockedtodata.export
		output wire        tx_clkout0,           //         tx_clkout0.clk
		output wire        rx_clkout0,           //         rx_clkout0.clk
		input  wire [39:0] tx_parallel_data0,    //  tx_parallel_data0.data
		output wire [39:0] rx_parallel_data0     //  rx_parallel_data0.data
	);

	wire  [39:0] sonic_pma_v1_01_inst_rx_parallel_data; // port fragment
	wire   [0:0] sonic_pma_v1_01_inst_rx_clkout;        // port fragment
	wire   [0:0] sonic_pma_v1_01_inst_tx_clkout;        // port fragment

	altera_xcvr_low_latency_phy #(
		.device_family           ("Stratix IV"),
		.intended_device_variant ("GT"),
		.operation_mode          ("DUPLEX"),
		.lanes                   (1),
		.bonded_mode             ("FALSE"),
		.serialization_factor    (40),
		.pll_type                ("CMU"),
		.data_rate               ("10312.5 Mbps"),
		.base_data_rate          ("10312.5 Mbps"),
		.pll_refclk_freq         ("644.53125 MHz"),
		.bonded_group_size       (1),
		.select_10g_pcs          (0),
		.tx_use_coreclk          (0),
		.rx_use_coreclk          (0),
		.tx_bitslip_enable       (0),
		.tx_bitslip_width        (7),
		.rx_bitslip_enable       (0),
		.phase_comp_fifo_mode    ("EMBEDDED"),
		.loopback_mode           ("SLB"),
		.use_double_data_mode    ("true"),
		.mgmt_clk_in_mhz         (150),
		.gxb_analog_power        ("AUTO"),
		.pll_lock_speed          ("AUTO"),
		.tx_analog_power         ("AUTO"),
		.tx_slew_rate            ("OFF"),
		.tx_termination          ("OCT_100_OHMS"),
		.tx_preemp_pretap        (0),
		.tx_preemp_pretap_inv    ("false"),
		.tx_preemp_tap_1         (0),
		.tx_preemp_tap_2         (0),
		.tx_preemp_tap_2_inv     ("false"),
		.tx_vod_selection        (2),
		.tx_common_mode          ("0.65V"),
		.rx_pll_lock_speed       ("AUTO"),
		.rx_common_mode          ("0.82V"),
		.rx_termination          ("OCT_100_OHMS"),
		.rx_eq_dc_gain           (1),
		.rx_eq_ctrl              (16),
		.starting_channel_number (0),
		.pll_refclk_cnt          (1),
		.plls                    (1)
	) sonic_pma_v1_01_inst (
		.phy_mgmt_clk         (phy_mgmt_clk),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            //       phy_mgmt_clk.clk
		.phy_mgmt_clk_reset   (phy_mgmt_clk_reset),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      // phy_mgmt_clk_reset.reset
		.phy_mgmt_address     (phy_mgmt_address),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        //           phy_mgmt.address
		.phy_mgmt_read        (phy_mgmt_read),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           //                   .read
		.phy_mgmt_readdata    (phy_mgmt_readdata),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       //                   .readdata
		.phy_mgmt_waitrequest (phy_mgmt_waitrequest),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    //                   .waitrequest
		.phy_mgmt_write       (phy_mgmt_write),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          //                   .write
		.phy_mgmt_writedata   (phy_mgmt_writedata),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      //                   .writedata
		.tx_ready             (tx_ready),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                //           tx_ready.export
		.rx_ready             (rx_ready),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                //           rx_ready.export
		.pll_ref_clk          (pll_ref_clk),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             //        pll_ref_clk.clk
		.pll_locked           (pll_locked),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              //         pll_locked.export
		.tx_serial_data       (tx_serial_data),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          //     tx_serial_data.export
		.rx_serial_data       (rx_serial_data),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          //     rx_serial_data.export
		.rx_is_lockedtoref    (rx_is_lockedtoref),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       //  rx_is_lockedtoref.export
		.rx_is_lockedtodata   (rx_is_lockedtodata),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      // rx_is_lockedtodata.export
		.tx_clkout            (sonic_pma_v1_01_inst_tx_clkout),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          //         tx_clkout0.clk
		.rx_clkout            (sonic_pma_v1_01_inst_rx_clkout),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          //         rx_clkout0.clk
		.tx_parallel_data (tx_parallel_data0),
		//.tx_parallel_data     ({tx_parallel_data0[0],tx_parallel_data0[1],tx_parallel_data0[2],tx_parallel_data0[3],tx_parallel_data0[4],tx_parallel_data0[5],tx_parallel_data0[6],tx_parallel_data0[7],tx_parallel_data0[8],tx_parallel_data0[9],tx_parallel_data0[10],tx_parallel_data0[11],tx_parallel_data0[12],tx_parallel_data0[13],tx_parallel_data0[14],tx_parallel_data0[15],tx_parallel_data0[16],tx_parallel_data0[17],tx_parallel_data0[18],tx_parallel_data0[19],tx_parallel_data0[20],tx_parallel_data0[21],tx_parallel_data0[22],tx_parallel_data0[23],tx_parallel_data0[24],tx_parallel_data0[25],tx_parallel_data0[26],tx_parallel_data0[27],tx_parallel_data0[28],tx_parallel_data0[29],tx_parallel_data0[30],tx_parallel_data0[31],tx_parallel_data0[32],tx_parallel_data0[33],tx_parallel_data0[34],tx_parallel_data0[35],tx_parallel_data0[36],tx_parallel_data0[37],tx_parallel_data0[38],tx_parallel_data0[39]}), //  tx_parallel_data0.data
		.rx_parallel_data     (sonic_pma_v1_01_inst_rx_parallel_data),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   //  rx_parallel_data0.data
		.tx_bitslip           (7'b0000000),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              //        (terminated)
		.rx_bitslip           (1'b0),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    //        (terminated)
		.tx_coreclkin         (1'b0),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    //        (terminated)
		.rx_coreclkin         (1'b0),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    //        (terminated)
		.reconfig_from_xcvr   (),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        //        (terminated)
		.reconfig_to_xcvr     (4'b0000)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  //        (terminated)
	);

	assign rx_parallel_data0 = { sonic_pma_v1_01_inst_rx_parallel_data[39:0] };
//	assign rx_parallel_data0 = { sonic_pma_v1_01_inst_rx_parallel_data[0:0], sonic_pma_v1_01_inst_rx_parallel_data[1:1], sonic_pma_v1_01_inst_rx_parallel_data[2:2], sonic_pma_v1_01_inst_rx_parallel_data[3:3], sonic_pma_v1_01_inst_rx_parallel_data[4:4], sonic_pma_v1_01_inst_rx_parallel_data[5:5], sonic_pma_v1_01_inst_rx_parallel_data[6:6], sonic_pma_v1_01_inst_rx_parallel_data[7:7], sonic_pma_v1_01_inst_rx_parallel_data[8:8], sonic_pma_v1_01_inst_rx_parallel_data[9:9], sonic_pma_v1_01_inst_rx_parallel_data[10:10], sonic_pma_v1_01_inst_rx_parallel_data[11:11], sonic_pma_v1_01_inst_rx_parallel_data[12:12], sonic_pma_v1_01_inst_rx_parallel_data[13:13], sonic_pma_v1_01_inst_rx_parallel_data[14:14], sonic_pma_v1_01_inst_rx_parallel_data[15:15], sonic_pma_v1_01_inst_rx_parallel_data[16:16], sonic_pma_v1_01_inst_rx_parallel_data[17:17], sonic_pma_v1_01_inst_rx_parallel_data[18:18], sonic_pma_v1_01_inst_rx_parallel_data[19:19], sonic_pma_v1_01_inst_rx_parallel_data[20:20], sonic_pma_v1_01_inst_rx_parallel_data[21:21], sonic_pma_v1_01_inst_rx_parallel_data[22:22], sonic_pma_v1_01_inst_rx_parallel_data[23:23], sonic_pma_v1_01_inst_rx_parallel_data[24:24], sonic_pma_v1_01_inst_rx_parallel_data[25:25], sonic_pma_v1_01_inst_rx_parallel_data[26:26], sonic_pma_v1_01_inst_rx_parallel_data[27:27], sonic_pma_v1_01_inst_rx_parallel_data[28:28], sonic_pma_v1_01_inst_rx_parallel_data[29:29], sonic_pma_v1_01_inst_rx_parallel_data[30:30], sonic_pma_v1_01_inst_rx_parallel_data[31:31], sonic_pma_v1_01_inst_rx_parallel_data[32:32], sonic_pma_v1_01_inst_rx_parallel_data[33:33], sonic_pma_v1_01_inst_rx_parallel_data[34:34], sonic_pma_v1_01_inst_rx_parallel_data[35:35], sonic_pma_v1_01_inst_rx_parallel_data[36:36], sonic_pma_v1_01_inst_rx_parallel_data[37:37], sonic_pma_v1_01_inst_rx_parallel_data[38:38], sonic_pma_v1_01_inst_rx_parallel_data[39:39] };

	assign rx_clkout0 = { sonic_pma_v1_01_inst_rx_clkout[0] };

	assign tx_clkout0 = { sonic_pma_v1_01_inst_tx_clkout[0] };

endmodule
// Retrieval info: <?xml version="1.0"?>
//<!--
//	Generated by Altera MegaWizard Launcher Utility version 1.0
//	************************************************************
//	THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//	************************************************************
//	Copyright (C) 1991-2011 Altera Corporation
//	Any megafunction design, and related net list (encrypted or decrypted),
//	support information, device programming or simulation file, and any other
//	associated documentation or information provided by Altera or a partner
//	under Altera's Megafunction Partnership Program may be used only to
//	program PLD devices (but not masked PLD devices) from Altera.  Any other
//	use of such megafunction design, net list, support information, device
//	programming or simulation file, or any other related documentation or
//	information is prohibited for any other purpose, including, but not
//	limited to modification, reverse engineering, de-compiling, or use with
//	any other silicon devices, unless such use is explicitly licensed under
//	a separate agreement with Altera or a megafunction partner.  Title to
//	the intellectual property, including patents, copyrights, trademarks,
//	trade secrets, or maskworks, embodied in any such megafunction design,
//	net list, support information, device programming or simulation file, or
//	any other related documentation or information provided by Altera or a
//	megafunction partner, remains with Altera, the megafunction partner, or
//	their respective licensors.  No other licenses, including any licenses
//	needed under any third party's intellectual property, are provided herein.
//-->
// Retrieval info: <instance entity-name="altera_xcvr_low_latency_phy" version="11.0" >
// Retrieval info: 	<generic name="device_family" value="Stratix IV" />
// Retrieval info: 	<generic name="intended_device_variant" value="GT" />
// Retrieval info: 	<generic name="operation_mode" value="DUPLEX" />
// Retrieval info: 	<generic name="lanes" value="1" />
// Retrieval info: 	<generic name="gui_bonding_enable" value="0" />
// Retrieval info: 	<generic name="serialization_factor" value="40" />
// Retrieval info: 	<generic name="pll_type" value="CMU" />
// Retrieval info: 	<generic name="data_rate" value="10312.5 Mbps" />
// Retrieval info: 	<generic name="gui_base_data_rate" value="1250 Mbps" />
// Retrieval info: 	<generic name="gui_pll_refclk_freq" value="644.53125 MHz" />
// Retrieval info: 	<generic name="bonded_group_size" value="1" />
// Retrieval info: 	<generic name="gui_select_10g_pcs" value="1" />
// Retrieval info: 	<generic name="gui_tx_use_coreclk" value="0" />
// Retrieval info: 	<generic name="gui_rx_use_coreclk" value="0" />
// Retrieval info: 	<generic name="tx_bitslip_enable" value="0" />
// Retrieval info: 	<generic name="rx_bitslip_enable" value="0" />
// Retrieval info: 	<generic name="phase_comp_fifo_mode" value="EMBEDDED" />
// Retrieval info: 	<generic name="loopback_mode" value="SLB" />
// Retrieval info: 	<generic name="use_double_data_mode" value="true" />
// Retrieval info: 	<generic name="gui_mgmt_clk_in_hz" value="150000000" />
// Retrieval info: 	<generic name="gui_split_interfaces" value="1" />
// Retrieval info: 	<generic name="gui_avalon_symbol_size" value="0" />
// Retrieval info: 	<generic name="gxb_analog_power" value="AUTO" />
// Retrieval info: 	<generic name="pll_lock_speed" value="AUTO" />
// Retrieval info: 	<generic name="tx_analog_power" value="AUTO" />
// Retrieval info: 	<generic name="tx_slew_rate" value="OFF" />
// Retrieval info: 	<generic name="tx_termination" value="OCT_100_OHMS" />
// Retrieval info: 	<generic name="tx_preemp_pretap" value="0" />
// Retrieval info: 	<generic name="gui_tx_preemp_pretap_inv" value="false" />
// Retrieval info: 	<generic name="tx_preemp_tap_1" value="0" />
// Retrieval info: 	<generic name="tx_preemp_tap_2" value="0" />
// Retrieval info: 	<generic name="gui_tx_preemp_tap_2_inv" value="false" />
// Retrieval info: 	<generic name="tx_vod_selection" value="2" />
// Retrieval info: 	<generic name="tx_common_mode" value="0.65V" />
// Retrieval info: 	<generic name="rx_pll_lock_speed" value="AUTO" />
// Retrieval info: 	<generic name="rx_common_mode" value="0.82V" />
// Retrieval info: 	<generic name="rx_termination" value="OCT_100_OHMS" />
// Retrieval info: 	<generic name="rx_eq_dc_gain" value="1" />
// Retrieval info: 	<generic name="rx_eq_ctrl" value="16" />
// Retrieval info: 	<generic name="starting_channel_number" value="0" />
// Retrieval info: 	<generic name="pll_refclk_cnt" value="1" />
// Retrieval info: 	<generic name="plls" value="1" />
// Retrieval info: 	<generic name="AUTO_PHY_MGMT_CLK_CLOCK_RATE" value="-1" />
// Retrieval info: 	<generic name="AUTO_PLL_REF_CLK_CLOCK_RATE" value="-1" />
// Retrieval info: </instance>
// IPFS_FILES : sonic_pma_v1_01.vo
// RELATED_FILES: sonic_pma_v1_01.v, altera_xcvr_functions.sv, altera_xcvr_low_latency_phy.sv, alt_pma_ch_controller_tgx.v, tgx_ch_reset_ctrl.sv, alt_pma_controller_tgx.v, alt_reset_ctrl_lego.sv, alt_reset_ctrl_tgx_cdrauto.sv, alt_xcvr_resync.sv, alt_xcvr_csr_common_h.sv, alt_xcvr_csr_common.sv, alt_xcvr_csr_pcs8g_h.sv, alt_xcvr_csr_pcs8g.sv, alt_xcvr_csr_selector.sv, alt_xcvr_mgmt2dec.sv, altera_wait_generate.v, alt_pma_functions.sv, siv_xcvr_low_latency_phy_nr.sv, alt_xcvr_reconfig_h.sv, alt_xcvr_reconfig_siv.sv, alt_xcvr_reconfig_analog.sv, alt_xcvr_reconfig_analog_tgx.v, alt_xcvr_reconfig_offset_cancellation.sv, alt_xcvr_reconfig_offset_cancellation_tgx.v, alt_xcvr_reconfig_eyemon.v, alt_xcvr_reconfig_eyemon_tgx.v, alt_xcvr_reconfig_dfe.v, alt_xcvr_reconfig_dfe_tgx.v, alt_xcvr_reconfig_basic_tgx.v, alt_mutex_acq.v, alt_dprio.v, alt_xcvr_arbiter.sv, alt_xcvr_m2s.sv
