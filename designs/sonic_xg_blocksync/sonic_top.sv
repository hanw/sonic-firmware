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
//* This file provides the top level wrapper file of the core and example applications
//*/
module sonic_top (
                  // inputs:
                  free_100MHz,
                  local_rstn,
                  pcie_rstn,
                  pclk_in,
                  phystatus_ext,
                  pipe_mode,
                  pld_clk,
                  refclk,
                  rx_in0,
                  rx_in1,
                  rx_in2,
                  rx_in3,
                  rx_in4,
                  rx_in5,
                  rx_in6,
                  rx_in7,
                  rxdata0_ext,
                  rxdata1_ext,
                  rxdata2_ext,
                  rxdata3_ext,
                  rxdata4_ext,
                  rxdata5_ext,
                  rxdata6_ext,
                  rxdata7_ext,
                  rxdatak0_ext,
                  rxdatak1_ext,
                  rxdatak2_ext,
                  rxdatak3_ext,
                  rxdatak4_ext,
                  rxdatak5_ext,
                  rxdatak6_ext,
                  rxdatak7_ext,
                  rxelecidle0_ext,
                  rxelecidle1_ext,
                  rxelecidle2_ext,
                  rxelecidle3_ext,
                  rxelecidle4_ext,
                  rxelecidle5_ext,
                  rxelecidle6_ext,
                  rxelecidle7_ext,
                  rxstatus0_ext,
                  rxstatus1_ext,
                  rxstatus2_ext,
                  rxstatus3_ext,
                  rxstatus4_ext,
                  rxstatus5_ext,
                  rxstatus6_ext,
                  rxstatus7_ext,
                  rxvalid0_ext,
                  rxvalid1_ext,
                  rxvalid2_ext,
                  rxvalid3_ext,
                  rxvalid4_ext,
                  rxvalid5_ext,
                  rxvalid6_ext,
                  rxvalid7_ext,
                  test_in,

		  xcvr_rx_clkout,
		  xcvr_tx_clkout,
		  xcvr_rx_dataout,
		  xcvr_tx_datain,
		  pma_tx_ready,
		  pma_rx_ready,
		  reset_nios,
		  set_lpbk,
		  unset_lpbk,
		  
                  clk250_out,
                  clk500_out,
                  core_clk_out,
                  gen2_speed,
                  lane_width_code,
                  pcie_reconfig_busy,
                  phy_sel_code,
                  powerdown_ext,
                  rate_ext,
                  rc_pll_locked,
                  ref_clk_sel_code,
                  rxpolarity0_ext,
                  rxpolarity1_ext,
                  rxpolarity2_ext,
                  rxpolarity3_ext,
                  rxpolarity4_ext,
                  rxpolarity5_ext,
                  rxpolarity6_ext,
                  rxpolarity7_ext,
                  test_out_icm,
		  monitor_out_0,
		  monitor_out_1,
                  tx_out0,
                  tx_out1,
                  tx_out2,
                  tx_out3,
                  tx_out4,
                  tx_out5,
                  tx_out6,
                  tx_out7,
                  txcompl0_ext,
                  txcompl1_ext,
                  txcompl2_ext,
                  txcompl3_ext,
                  txcompl4_ext,
                  txcompl5_ext,
                  txcompl6_ext,
                  txcompl7_ext,
                  txdata0_ext,
                  txdata1_ext,
                  txdata2_ext,
                  txdata3_ext,
                  txdata4_ext,
                  txdata5_ext,
                  txdata6_ext,
                  txdata7_ext,
                  txdatak0_ext,
                  txdatak1_ext,
                  txdatak2_ext,
                  txdatak3_ext,
                  txdatak4_ext,
                  txdatak5_ext,
                  txdatak6_ext,
                  txdatak7_ext,
                  txdetectrx_ext,
                  txelecidle0_ext,
                  txelecidle1_ext,
                  txelecidle2_ext,
                  txelecidle3_ext,
                  txelecidle4_ext,
                  txelecidle5_ext,
                  txelecidle6_ext,
                  txelecidle7_ext
                  );

   output           clk250_out;
   output           clk500_out;
   output           core_clk_out;
   output           gen2_speed;
   output [  3: 0]  lane_width_code;
   output           pcie_reconfig_busy;
   output [  3: 0]  phy_sel_code;
   output [  1: 0]  powerdown_ext;
   output           rate_ext;
   output           rc_pll_locked;
   output [  3: 0]  ref_clk_sel_code;
   output           rxpolarity0_ext;
   output           rxpolarity1_ext;
   output           rxpolarity2_ext;
   output           rxpolarity3_ext;
   output           rxpolarity4_ext;
   output           rxpolarity5_ext;
   output           rxpolarity6_ext;
   output           rxpolarity7_ext;
   output [  8: 0]  test_out_icm;
   output           tx_out0;
   output           tx_out1;
   output           tx_out2;
   output           tx_out3;
   output           tx_out4;
   output           tx_out5;
   output           tx_out6;
   output           tx_out7;
   output           txcompl0_ext;
   output           txcompl1_ext;
   output           txcompl2_ext;
   output           txcompl3_ext;
   output           txcompl4_ext;
   output           txcompl5_ext;
   output           txcompl6_ext;
   output           txcompl7_ext;
   output [  7: 0]  txdata0_ext;
   output [  7: 0]  txdata1_ext;
   output [  7: 0]  txdata2_ext;
   output [  7: 0]  txdata3_ext;
   output [  7: 0]  txdata4_ext;
   output [  7: 0]  txdata5_ext;
   output [  7: 0]  txdata6_ext;
   output [  7: 0]  txdata7_ext;
   output           txdatak0_ext;
   output           txdatak1_ext;
   output           txdatak2_ext;
   output           txdatak3_ext;
   output           txdatak4_ext;
   output           txdatak5_ext;
   output           txdatak6_ext;
   output           txdatak7_ext;
   output           txdetectrx_ext;
   output           txelecidle0_ext;
   output           txelecidle1_ext;
   output           txelecidle2_ext;
   output           txelecidle3_ext;
   output           txelecidle4_ext;
   output           txelecidle5_ext;
   output           txelecidle6_ext;
   output           txelecidle7_ext;
   output wire [127:0]   monitor_out_0;
   output wire [127:0]   monitor_out_1;
      
   input [1:0] 	    xcvr_rx_clkout;
   input [1:0] 	    xcvr_tx_clkout;
   input [79:0]     xcvr_rx_dataout;
   output [79:0]    xcvr_tx_datain;
   input 	    pma_tx_ready;
   input 	    pma_rx_ready;
   output wire 	    reset_nios;
   output wire 	    set_lpbk;
   output wire 	    unset_lpbk;
   
   input            free_100MHz;
   input            local_rstn;
   input            pcie_rstn;
   input            pclk_in;
   input            phystatus_ext;
   input            pipe_mode;
   input            pld_clk;
   input            refclk;
   input            rx_in0;
   input            rx_in1;
   input            rx_in2;
   input            rx_in3;
   input            rx_in4;
   input            rx_in5;
   input            rx_in6;
   input            rx_in7;
   input [  7: 0]   rxdata0_ext;
   input [  7: 0]   rxdata1_ext;
   input [  7: 0]   rxdata2_ext;
   input [  7: 0]   rxdata3_ext;
   input [  7: 0]   rxdata4_ext;
   input [  7: 0]   rxdata5_ext;
   input [  7: 0]   rxdata6_ext;
   input [  7: 0]   rxdata7_ext;
   input            rxdatak0_ext;
   input            rxdatak1_ext;
   input            rxdatak2_ext;
   input            rxdatak3_ext;
   input            rxdatak4_ext;
   input            rxdatak5_ext;
   input            rxdatak6_ext;
   input            rxdatak7_ext;
   input            rxelecidle0_ext;
   input            rxelecidle1_ext;
   input            rxelecidle2_ext;
   input            rxelecidle3_ext;
   input            rxelecidle4_ext;
   input            rxelecidle5_ext;
   input            rxelecidle6_ext;
   input            rxelecidle7_ext;
   input [  2: 0]   rxstatus0_ext;
   input [  2: 0]   rxstatus1_ext;
   input [  2: 0]   rxstatus2_ext;
   input [  2: 0]   rxstatus3_ext;
   input [  2: 0]   rxstatus4_ext;
   input [  2: 0]   rxstatus5_ext;
   input [  2: 0]   rxstatus6_ext;
   input [  2: 0]   rxstatus7_ext;
   input            rxvalid0_ext;
   input            rxvalid1_ext;
   input            rxvalid2_ext;
   input            rxvalid3_ext;
   input            rxvalid4_ext;
   input            rxvalid5_ext;
   input            rxvalid6_ext;
   input            rxvalid7_ext;
   input [ 39: 0]   test_in;

   wire             app_int_ack_icm;
   wire             app_int_sts_icm;
   wire             app_msi_ack;
   wire [  4: 0]    app_msi_num;
   wire             app_msi_req;
   wire             app_msi_req0;
   wire             app_msi_req1;
   wire [  2: 0]    app_msi_tc;
   wire [ 12: 0]    cfg_busdev_icm;
   wire [ 31: 0]    cfg_devcsr_icm;
   wire [ 19: 0]    cfg_io_bas;
   wire [ 31: 0]    cfg_linkcsr_icm;
   wire [ 15: 0]    cfg_msicsr;
   wire [ 11: 0]    cfg_np_bas;
   wire [ 43: 0]    cfg_pr_bas;
   wire [ 31: 0]    cfg_prmcsr_icm;
   wire             clk250_out;
   wire             clk500_out;
   wire             core_clk_out;
   wire [  6: 0]    cpl_err_icm;
   wire [  6: 0]    cpl_err_in;
   wire             cpl_pending_icm;  
   wire             cpl_pending_icm0;  
   wire             cpl_pending_icm1;  
   wire [  4: 0]    dl_ltssm;
   wire [127: 0]    err_desc;
   wire             fixedclk_serdes;
   wire             gen2_speed;
   wire [ 23: 0]    cfg_tcvcmap;
   wire             gnd_msi_stream_ready0;
   wire             gnd_msi_stream_ready1;
   wire [  9: 0]    gnd_pm_data;
   wire             rx_mask1;
   wire [127: 0]    tx_st_data1;
   wire             tx_st_eop1;
   wire             tx_st_err1;
   wire             tx_st_sop1;
   wire             tx_st_empty1;

   wire             gnd_tx_stream_mask0;
   wire             gnd_tx_stream_mask1;
   wire [ 19: 0]    ko_cpl_spc_vc0;
   wire [  3: 0]    lane_act;
   wire [  3: 0]    lane_width_code;
   wire             lmi_ack;
   wire [ 11: 0]    lmi_addr;
   wire [ 31: 0]    lmi_din;
   wire [ 31: 0]    lmi_dout;
   wire             lmi_rden;
   wire             lmi_wren;
   wire [  4: 0]    open_aer_msi_num0;
   wire [  4: 0]    open_aer_msi_num1;
   wire [ 23: 0]    open_cfg_tcvcmap;
   wire             open_cplerr_lmi_busy;
   wire [  7: 0]    open_msi_stream_data0;
   wire [  7: 0]    open_msi_stream_data1;
   wire             open_msi_stream_valid0;
   wire             open_msi_stream_valid1;
   wire [  9: 0]    open_pm_data;
   
   wire [4:0] 	    open_pex_msi_num;
   wire [2:0] 	    open_app_msi_tc;
   wire [4:0] 	    open_app_msi_num;
   wire 	    open_app_int_sts;
   wire [6:0] 	    open_cpl_err;
   wire [127:0]     open_err_desc;
   
   wire [127: 0]    rx_st_data1;
   wire             rx_st_eop1;
   wire             open_rx_st_err0;
   wire             open_rx_st_err1;
   wire             rx_st_sop1;
   wire             otb0;
   wire             otb1;
   wire             pcie_reconfig_busy;
   wire [  4: 0]    pex_msi_num_icm;
   wire [  3: 0]    phy_sel_code;
   wire             pme_to_sr;
   wire [  1: 0]    powerdown_ext;
   wire             rate_ext;
   wire             rc_pll_locked;
   wire             reconfig_clk;
   wire             reconfig_clk_locked;
   wire [  3: 0]    ref_clk_sel_code;
   wire             rx_mask0;
   wire [  7: 0]    rx_st_bardec0;
   wire [ 15: 0]    rx_st_be0;
   wire [  7: 0]    rx_st_bardec1;
   wire [ 15: 0]    rx_st_be1;
   wire [127: 0]    rx_st_data0;
   wire             rx_st_empty0;
   wire             rx_st_empty1;
   wire             rx_st_eop0;
   wire             rx_st_sop0;
   wire [ 81: 0]    rx_stream_data0;
   wire [ 81: 0]    rx_stream_data0_1;
   wire             rx_stream_ready0;
   wire             rx_stream_valid0;
   wire [ 81: 0]    rx_stream_data1;
   wire [ 81: 0]    rx_stream_data1_1;
   wire             rx_stream_ready1;
   wire             rx_stream_valid1;
   wire             rxpolarity0_ext;
   wire             rxpolarity1_ext;
   wire             rxpolarity2_ext;
   wire             rxpolarity3_ext;
   wire             rxpolarity4_ext;
   wire             rxpolarity5_ext;
   wire             rxpolarity6_ext;
   wire             rxpolarity7_ext;
   wire             srstn;
   wire [  8: 0]    test_out_icm;
   wire [ 63: 0]    test_out_int;
   wire [  3: 0]    tl_cfg_add;
   wire [ 31: 0]    tl_cfg_ctl;
   wire             tl_cfg_ctl_wr;
   wire [ 52: 0]    tl_cfg_sts;
   wire             tl_cfg_sts_wr;
   wire             tx_fifo_empty0;
   wire             tx_fifo_empty1;
   wire             tx_out0;
   wire             tx_out1;
   wire             tx_out2;
   wire             tx_out3;
   wire             tx_out4;
   wire             tx_out5;
   wire             tx_out6;
   wire             tx_out7;
   wire [127: 0]    tx_st_data0;
   wire  	    tx_st_empty0;
   wire             tx_st_eop0;
   wire             tx_st_err0;
   wire             tx_st_sop0;
   wire [ 35: 0]    tx_stream_cred0;
   wire [ 74: 0]    tx_stream_data0;
   wire [ 74: 0]    tx_stream_data0_1;
   wire             tx_stream_ready0;
   wire             tx_stream_valid0;
   wire [ 74: 0]    tx_stream_data1;
   wire [ 74: 0]    tx_stream_data1_1;
   wire             tx_stream_ready1;
   wire             tx_stream_valid1;
   wire             txcompl0_ext;
   wire             txcompl1_ext;
   wire             txcompl2_ext;
   wire             txcompl3_ext;
   wire             txcompl4_ext;
   wire             txcompl5_ext;
   wire             txcompl6_ext;
   wire             txcompl7_ext;
   wire [  7: 0]    txdata0_ext;
   wire [  7: 0]    txdata1_ext;
   wire [  7: 0]    txdata2_ext;
   wire [  7: 0]    txdata3_ext;
   wire [  7: 0]    txdata4_ext;
   wire [  7: 0]    txdata5_ext;
   wire [  7: 0]    txdata6_ext;
   wire [  7: 0]    txdata7_ext;
   wire             txdatak0_ext;
   wire             txdatak1_ext;
   wire             txdatak2_ext;
   wire             txdatak3_ext;
   wire             txdatak4_ext;
   wire             txdatak5_ext;
   wire             txdatak6_ext;
   wire             txdatak7_ext;
   wire             txdetectrx_ext;
   wire             txelecidle0_ext;
   wire             txelecidle1_ext;
   wire             txelecidle2_ext;
   wire             txelecidle3_ext;
   wire             txelecidle4_ext;
   wire             txelecidle5_ext;
   wire             txelecidle6_ext;
   wire             txelecidle7_ext;
   
   wire [1:0] 	    xcvr_rx_clkout;
   wire [1:0] 	    xcvr_tx_clkout;
   wire [79:0] 	    xcvr_rx_dataout;
   wire [79:0] 	    xcvr_tx_datain;
   wire 	    pma_tx_ready;
   wire 	    pma_rx_ready;

   wire [127:0]     tx_vc_out_data;
   wire 	    tx_vc_out_valid;
   wire 	    tx_vc_out_ready;
   wire 	    tx_vc_out_sop;
   wire 	    tx_vc_out_eop;
   wire 	    tx_vc_out_chan;
   wire 	    tx_vc_out_err;
   wire 	    tx_vc_out_empty;

   wire [127:0]     rx_vc_in_data;
   wire 	    rx_vc_in_valid;
   wire 	    rx_vc_in_ready;
   wire 	    rx_vc_in_sop;
   wire 	    rx_vc_in_eop;
   reg 		    rx_vc_in_chan;
   wire 	    rx_vc_in_empty;
   wire [7:0] 	    rx_vc_in_bardec;
   wire [15:0] 	    rx_vc_in_be;
   
   reg [127:0] 	    rx_vc_in_data_r;
   reg 		    rx_vc_in_valid_r;
   reg 		    rx_vc_in_sop_r;
   reg 		    rx_vc_in_eop_r;
   reg 		    rx_vc_in_empty_r;
   reg [7:0] 	    rx_vc_in_bardec_r;
   reg [15:0] 	    rx_vc_in_be_r;
      
   assign ref_clk_sel_code = 0;
   assign lane_width_code = 3;
   assign phy_sel_code = 6;
   assign otb0 = 1'b0;
   assign otb1 = 1'b1;
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
   assign test_out_icm = {lane_act,dl_ltssm};
   assign pcie_reconfig_busy = 1'b1;
   assign gen2_speed = cfg_linkcsr_icm[17];
   
   assign tx_st_sop1 = tx_stream_data1[73];
   assign tx_st_eop1 = tx_stream_data1_1[72];
   assign tx_st_err1 = tx_stream_data1[74];
   assign tx_st_data1 = {tx_stream_data1_1[63:0], tx_stream_data1[63:0]};
   assign tx_st_empty1 = tx_stream_data1[72];
   assign rx_stream_data1 = {rx_st_be1[7:0], rx_st_sop1, rx_st_empty1, rx_st_bardec1, rx_st_data1[63:0]};
   assign rx_stream_data1_1 = {rx_st_be1[15:8], rx_st_sop1, rx_st_eop1, rx_st_bardec1, rx_st_data1[127:64]};
   assign gnd_tx_stream_mask0 = 1'b0;
   assign gnd_tx_stream_mask1 = 1'b0;
   
   assign gnd_msi_stream_ready0 = 1'b0;
   assign gnd_msi_stream_ready1 = 1'b0;

   assign app_msi_req = app_msi_req0 | app_msi_req1;
   assign cpl_pending_icm = cpl_pending_icm0 | cpl_pending_icm1;

   top_plus ep_plus
     (
      .app_int_ack (app_int_ack_icm),
      .app_int_sts (app_int_sts_icm),
      .app_msi_ack (app_msi_ack),
      .app_msi_num (app_msi_num),
      .app_msi_req (app_msi_req),
      .app_msi_tc (app_msi_tc),
      .clk250_out (clk250_out),
      .clk500_out (clk500_out),
      .core_clk_out (core_clk_out),
      .cpl_err (cpl_err_icm),
      .cpl_pending (cpl_pending_icm),
      .fixedclk_serdes (fixedclk_serdes),
      .lane_act (lane_act),
      .lmi_ack (lmi_ack),
      .lmi_addr (lmi_addr),
      .lmi_din (lmi_din),
      .lmi_dout (lmi_dout),
      .lmi_rden (lmi_rden),
      .lmi_wren (lmi_wren),
      .local_rstn (local_rstn),
      .ltssm (dl_ltssm),
      .pcie_rstn (pcie_rstn),
      .pclk_in (pclk_in),
      .pex_msi_num (pex_msi_num_icm),
      .phystatus_ext (phystatus_ext),
      .pipe_mode (pipe_mode),
      .pld_clk (pld_clk),
      .pm_auxpwr (1'b0),
      .pm_data (gnd_pm_data),
      .pm_event (1'b0),
      .pme_to_cr (pme_to_sr),
      .pme_to_sr (pme_to_sr),
      .powerdown_ext (powerdown_ext),
      .rate_ext (rate_ext),
      .rc_pll_locked (rc_pll_locked),
      .reconfig_clk (reconfig_clk),
      .reconfig_clk_locked (reconfig_clk_locked),
      .refclk (refclk),
      .rx_in0 (rx_in0),
      .rx_in1 (rx_in1),
      .rx_in2 (rx_in2),
      .rx_in3 (rx_in3),
      .rx_in4 (rx_in4),
      .rx_in5 (rx_in5),
      .rx_in6 (rx_in6),
      .rx_in7 (rx_in7),
      .rx_st_bardec0 (rx_vc_in_bardec),
      .rx_st_be0 (rx_vc_in_be), 
      .rx_st_data0 (rx_vc_in_data),
      .rx_st_empty0 (rx_vc_in_empty), 
      .rx_st_eop0 (rx_vc_in_eop),
      .rx_st_err0 (open_rx_st_err0),
      .rx_st_mask0 (rx_mask0),
      .rx_st_ready0 (rx_vc_in_ready),
      .rx_st_sop0 (rx_vc_in_sop),
      .rx_st_valid0 (rx_vc_in_valid),
      .rxdata0_ext (rxdata0_ext),
      .rxdata1_ext (rxdata1_ext),
      .rxdata2_ext (rxdata2_ext),
      .rxdata3_ext (rxdata3_ext),
      .rxdata4_ext (rxdata4_ext),
      .rxdata5_ext (rxdata5_ext),
      .rxdata6_ext (rxdata6_ext),
      .rxdata7_ext (rxdata7_ext),
      .rxdatak0_ext (rxdatak0_ext),
      .rxdatak1_ext (rxdatak1_ext),
      .rxdatak2_ext (rxdatak2_ext),
      .rxdatak3_ext (rxdatak3_ext),
      .rxdatak4_ext (rxdatak4_ext),
      .rxdatak5_ext (rxdatak5_ext),
      .rxdatak6_ext (rxdatak6_ext),
      .rxdatak7_ext (rxdatak7_ext),
      .rxelecidle0_ext (rxelecidle0_ext),
      .rxelecidle1_ext (rxelecidle1_ext),
      .rxelecidle2_ext (rxelecidle2_ext),
      .rxelecidle3_ext (rxelecidle3_ext),
      .rxelecidle4_ext (rxelecidle4_ext),
      .rxelecidle5_ext (rxelecidle5_ext),
      .rxelecidle6_ext (rxelecidle6_ext),
      .rxelecidle7_ext (rxelecidle7_ext),
      .rxpolarity0_ext (rxpolarity0_ext),
      .rxpolarity1_ext (rxpolarity1_ext),
      .rxpolarity2_ext (rxpolarity2_ext),
      .rxpolarity3_ext (rxpolarity3_ext),
      .rxpolarity4_ext (rxpolarity4_ext),
      .rxpolarity5_ext (rxpolarity5_ext),
      .rxpolarity6_ext (rxpolarity6_ext),
      .rxpolarity7_ext (rxpolarity7_ext),
      .rxstatus0_ext (rxstatus0_ext),
      .rxstatus1_ext (rxstatus1_ext),
      .rxstatus2_ext (rxstatus2_ext),
      .rxstatus3_ext (rxstatus3_ext),
      .rxstatus4_ext (rxstatus4_ext),
      .rxstatus5_ext (rxstatus5_ext),
      .rxstatus6_ext (rxstatus6_ext),
      .rxstatus7_ext (rxstatus7_ext),
      .rxvalid0_ext (rxvalid0_ext),
      .rxvalid1_ext (rxvalid1_ext),
      .rxvalid2_ext (rxvalid2_ext),
      .rxvalid3_ext (rxvalid3_ext),
      .rxvalid4_ext (rxvalid4_ext),
      .rxvalid5_ext (rxvalid5_ext),
      .rxvalid6_ext (rxvalid6_ext),
      .rxvalid7_ext (rxvalid7_ext),
      .srstn (srstn),
      .test_in (test_in),
      .test_out (test_out_int),
      .tl_cfg_add (tl_cfg_add),
      .tl_cfg_ctl (tl_cfg_ctl),
      .tl_cfg_ctl_wr (tl_cfg_ctl_wr),
      .tl_cfg_sts (tl_cfg_sts),
      .tl_cfg_sts_wr (tl_cfg_sts_wr),
      .tx_cred0 (tx_stream_cred0),
      .tx_fifo_empty0 (tx_fifo_empty0),
      .tx_out0 (tx_out0),
      .tx_out1 (tx_out1),
      .tx_out2 (tx_out2),
      .tx_out3 (tx_out3),
      .tx_out4 (tx_out4),
      .tx_out5 (tx_out5),
      .tx_out6 (tx_out6),
      .tx_out7 (tx_out7),
//      .tx_st_data0 (tx_st_data0),
      .tx_st_data0 (tx_vc_out_data),
//      .tx_st_empty0 (tx_st_empty0[0]),
      .tx_st_empty0 (tx_vc_out_empty),
//      .tx_st_eop0 (tx_st_eop0),
      .tx_st_eop0 (tx_vc_out_eop),
//      .tx_st_err0 (tx_st_err0),
      .tx_st_err0 (tx_vc_out_err),
//      .tx_st_ready0 (tx_stream_ready0),
      .tx_st_ready0 (tx_vc_out_ready),
//      .tx_st_sop0 (tx_st_sop0),
      .tx_st_sop0 (tx_vc_out_sop),
//      .tx_st_valid0 (tx_stream_valid0),
      .tx_st_valid0 (tx_vc_out_valid),
      .txcompl0_ext (txcompl0_ext),
      .txcompl1_ext (txcompl1_ext),
      .txcompl2_ext (txcompl2_ext),
      .txcompl3_ext (txcompl3_ext),
      .txcompl4_ext (txcompl4_ext),
      .txcompl5_ext (txcompl5_ext),
      .txcompl6_ext (txcompl6_ext),
      .txcompl7_ext (txcompl7_ext),
      .txdata0_ext (txdata0_ext),
      .txdata1_ext (txdata1_ext),
      .txdata2_ext (txdata2_ext),
      .txdata3_ext (txdata3_ext),
      .txdata4_ext (txdata4_ext),
      .txdata5_ext (txdata5_ext),
      .txdata6_ext (txdata6_ext),
      .txdata7_ext (txdata7_ext),
      .txdatak0_ext (txdatak0_ext),
      .txdatak1_ext (txdatak1_ext),
      .txdatak2_ext (txdatak2_ext),
      .txdatak3_ext (txdatak3_ext),
      .txdatak4_ext (txdatak4_ext),
      .txdatak5_ext (txdatak5_ext),
      .txdatak6_ext (txdatak6_ext),
      .txdatak7_ext (txdatak7_ext),
      .txdetectrx_ext (txdetectrx_ext),
      .txelecidle0_ext (txelecidle0_ext),
      .txelecidle1_ext (txelecidle1_ext),
      .txelecidle2_ext (txelecidle2_ext),
      .txelecidle3_ext (txelecidle3_ext),
      .txelecidle4_ext (txelecidle4_ext),
      .txelecidle5_ext (txelecidle5_ext),
      .txelecidle6_ext (txelecidle6_ext),
      .txelecidle7_ext (txelecidle7_ext)
      );


   altpcierd_reconfig_clk_pll reconfig_pll
     (
      .c0 (reconfig_clk),
      .c1 (fixedclk_serdes),
      .inclk0 (free_100MHz),
      .locked (reconfig_clk_locked)
      );


   altpcierd_tl_cfg_sample cfgbus
     (
      .cfg_busdev (cfg_busdev_icm),
      .cfg_devcsr (cfg_devcsr_icm),
      .cfg_io_bas (cfg_io_bas),
      .cfg_linkcsr (cfg_linkcsr_icm),
      .cfg_msicsr (cfg_msicsr),
      .cfg_np_bas (cfg_np_bas),
      .cfg_pr_bas (cfg_pr_bas),
      .cfg_prmcsr (cfg_prmcsr_icm),
      .cfg_tcvcmap (cfg_tcvcmap),
      .pld_clk (pld_clk),
      .rstn (srstn),
      .cfg_io_lim(),
      .cfg_np_lim(),
      .cfg_pr_lim(),
      .tl_cfg_add (tl_cfg_add),
      .tl_cfg_ctl (tl_cfg_ctl),
      .tl_cfg_ctl_wr (tl_cfg_ctl_wr),
      .tl_cfg_sts (tl_cfg_sts),
      .tl_cfg_sts_wr (tl_cfg_sts_wr)
      );

   defparam cfgbus.HIP_SV = 0;

   altpcierd_cplerr_lmi lmi_blk
     (
      .clk_in (pld_clk),
      .cpl_err_in (cpl_err_in),
      .cpl_err_out (cpl_err_icm),
      .cplerr_lmi_busy (open_cplerr_lmi_busy),
      .err_desc (err_desc),
      .lmi_ack (lmi_ack),
      .lmi_addr (lmi_addr),
      .lmi_din (lmi_din),
      .lmi_rden (lmi_rden),
      .lmi_wren (lmi_wren),
      .rstn (srstn)
      );
   
   /*
    * sonic_vc: for arbitrating two avalon-st into one.
    */
   
   always @ (posedge pld_clk) begin
      if (srstn == 1'b0) begin
	 rx_vc_in_chan <= 1'b0;
      end
      else if ((rx_vc_in_sop == 1) &&
	  ((rx_vc_in_data[31:24] == 8'h40) || 
	   (rx_vc_in_data[31:24] == 8'h60) ||
	   (rx_vc_in_data[31:24] == 8'h45) ||
	   (rx_vc_in_data[31:24] == 8'h42) ||
	   (rx_vc_in_data[31:24] == 8'h4A) ||
	   (rx_vc_in_data[31:24] == 8'h4B) ||
	   (rx_vc_in_data[31:24] == 8'h0A) ||
	   (rx_vc_in_data[31:24] == 8'h0B) ||
	   (rx_vc_in_data[31:24] == 8'h00) ||
	   (rx_vc_in_data[31:24] == 8'h01) ||
	   (rx_vc_in_data[31:24] == 8'h20) ||
	   (rx_vc_in_data[31:24] == 8'h21) ||
	   (rx_vc_in_data[31:24] == 8'h05) ||
	   (rx_vc_in_data[31:24] == 8'h02))) begin
	 casez (rx_vc_in_data[22:20]) // TLP header byte 0-3
	   3'b0??: rx_vc_in_chan <= 1'b0;
	   3'b1??: rx_vc_in_chan <= 1'b1;
	 endcase // casez (rx_vc_in_data[22:20])
      end // if (rx_vc_in_sop == 1)
   end

   always @ (posedge pld_clk) begin
      rx_vc_in_data_r  <= rx_vc_in_data;
      rx_vc_in_valid_r <= rx_vc_in_valid;
      rx_vc_in_sop_r   <= rx_vc_in_sop;
      rx_vc_in_eop_r   <= rx_vc_in_eop;
      rx_vc_in_empty_r <= rx_vc_in_empty;
      rx_vc_in_bardec_r <= rx_vc_in_bardec;
      rx_vc_in_be_r <= rx_vc_in_be;
   end
      
   sonic_vc vc (
		.clk_clk                  (pld_clk),          //        clk.clk
		.reset_reset_n            (srstn),            //      reset.reset_n
		.tx_vc_in0_valid          (tx_stream_valid0), //  tx_vc_in0.valid
		.tx_vc_in0_ready          (tx_stream_ready0), //           .ready
		.tx_vc_in0_data           (tx_st_data0),      //           .data
		.tx_vc_in0_startofpacket  (tx_st_sop0),       //           .startofpacket
		.tx_vc_in0_endofpacket    (tx_st_eop0),       //           .endofpacket
		.tx_vc_in0_empty          (tx_st_empty0),     //           .empty
		.tx_vc_in0_error          (tx_st_err0),       //           .error
		.tx_vc_in1_valid          (tx_stream_valid1), //  tx_vc_in1.valid
		.tx_vc_in1_ready          (tx_stream_ready1), //           .ready
		.tx_vc_in1_data           (tx_st_data1),      //           .data
		.tx_vc_in1_startofpacket  (tx_st_sop1),       //           .startofpacket
		.tx_vc_in1_endofpacket    (tx_st_eop1),       //           .endofpacket
		.tx_vc_in1_empty          (tx_st_empty1),     //           .empty
		.tx_vc_in1_error          (tx_st_err1),       //           .error
		.tx_vc_out_channel        (tx_vc_out_chan),   //  tx_vc_out.channel
		.tx_vc_out_valid          (tx_vc_out_valid),  //           .valid
		.tx_vc_out_ready          (tx_vc_out_ready),  //           .ready
		.tx_vc_out_data           (tx_vc_out_data),   //           .data
		.tx_vc_out_startofpacket  (tx_vc_out_sop),    //           .startofpacket
		.tx_vc_out_endofpacket    (tx_vc_out_eop),    //           .endofpacket
		.tx_vc_out_empty          (tx_vc_out_empty),  //           .empty
		.tx_vc_out_error          (tx_vc_out_err),    //           .error
		.rx_vc_in_channel         (rx_vc_in_chan),    //   rx_vc_in.channel
		.rx_vc_in_valid           (rx_vc_in_valid_r),   //           .valid
		.rx_vc_in_ready           (rx_vc_in_ready),   //           .ready
		.rx_vc_in_data            (rx_vc_in_data_r),    //           .data
		.rx_vc_in_startofpacket   (rx_vc_in_sop_r),     //           .startofpacket
		.rx_vc_in_endofpacket     (rx_vc_in_eop_r),     //           .endofpacket
		.rx_vc_in_empty           (rx_vc_in_empty_r), //      .empty
		.rx_vc_in_bardec_export   (rx_vc_in_bardec_r),
		.rx_vc_in_be_export       (rx_vc_in_be_r),
		.rx_vc_out0_valid         (rx_stream_valid0), // rx_vc_out0.valid
		.rx_vc_out0_ready         (rx_stream_ready0), //           .ready
		.rx_vc_out0_data          (rx_st_data0),      //           .data
		.rx_vc_out0_startofpacket (rx_st_sop0),       //           .startofpacket
		.rx_vc_out0_endofpacket   (rx_st_eop0),       //           .endofpacket
		.rx_vc_out0_empty         (rx_st_empty0),
		.rx_vc_out0_bardec_export (rx_st_bardec0),
		.rx_vc_out0_be_export     (rx_st_be0),
		.rx_vc_out1_valid         (rx_stream_valid1), // rx_vc_out1.valid
		.rx_vc_out1_ready         (rx_stream_ready1), //           .ready
		.rx_vc_out1_data          (rx_st_data1),      //           .data
		.rx_vc_out1_startofpacket (rx_st_sop1),       //           .startofpacket
		.rx_vc_out1_endofpacket   (rx_st_eop1),       //           .endofpacket
		.rx_vc_out1_empty         (rx_st_empty1),
		.rx_vc_out1_bardec_export (rx_st_bardec1),
		.rx_vc_out1_be_export     (rx_st_be1)
		);
   
   wire [31:0] 	    p1_prg_wrdata;           // P0 out, P1 in
   wire [7:0] 	    p1_prg_addr;             // P0 out, P1 in
   wire [31:0] 	    p1_dma_rd_prg_rddata;    // P0 in;  P1 out
   wire [31:0] 	    p1_dma_wr_prg_rddata;    // P0 in;  P1 out
   wire 	    p1_dma_rd_prg_wrena;     // P0 out; P1 in
   wire 	    p1_dma_wr_prg_wrena;     // P0 out; P1 in
   wire [31:0] 	    p1_irq_prg_rddata;       // P0 in;  P1 out
   wire 	    p1_irq_prg_wrena;        // P0 out; P1 in
   wire [31:0] 	    p1_cmd_prg_rddata;       // P0 in;  P1 out
   wire 	    p1_cmd_prg_wrena;        // P0 out; P1 in
   wire [15:0] 	    p1_rx_ecrc_bad_cnt;      // P0 in;  P1 out
   wire [63:0] 	    p1_read_dma_status;      // P0 in;  P1 out
   wire [63:0] 	    p1_write_dma_status;     // P0 in;  P1 out

   sonic_application_streaming_port app0
     (
      .aer_msi_num (open_aer_msi_num0),
      .app_int_ack (app_int_ack_icm),
      .app_int_sts (app_int_sts_icm),
      .app_msi_ack (app_msi_ack),
      .app_msi_num (app_msi_num),
      .app_msi_req (app_msi_req0),
      .app_msi_tc (app_msi_tc),
      .cfg_busdev (cfg_busdev_icm),
      .cfg_devcsr (cfg_devcsr_icm),
      .cfg_linkcsr (cfg_linkcsr_icm),
      .cfg_msicsr (cfg_msicsr),
      .cfg_prmcsr (cfg_prmcsr_icm),
      .cfg_tcvcmap (cfg_tcvcmap),
      .xcvr_rx_clkout(xcvr_rx_clkout[0]),
      .xcvr_tx_clkout(xcvr_tx_clkout[0]),
      .xcvr_rx_dataout(xcvr_rx_dataout[39:0]),
      .xcvr_tx_datain(xcvr_tx_datain[39:0]),
      .pma_tx_ready(pma_tx_ready),
      .pma_rx_ready(pma_rx_ready),
      .reset_nios(reset_nios),
      .set_lpbk(set_lpbk),
      .unset_lpbk(unset_lpbk),
      .monitor_out(monitor_out_0),
      .clk_in (pld_clk),
      .cpl_err (cpl_err_in),
      .cpl_pending (cpl_pending_icm0),
      .err_desc (err_desc),
      .ko_cpl_spc_vc0 (ko_cpl_spc_vc0),
      .msi_stream_data0 (open_msi_stream_data0),
      .msi_stream_ready0 (gnd_msi_stream_ready0),
      .msi_stream_valid0 (open_msi_stream_valid0),
      .pex_msi_num (pex_msi_num_icm),
      .pm_data (open_pm_data),
      .rstn (srstn),
      .rx_stream_data0_0 (rx_stream_data0),
      .rx_stream_data0_1 (rx_stream_data0_1),
      .rx_stream_mask0 (rx_mask0),
      .rx_stream_ready0 (rx_stream_ready0),
      .rx_stream_valid0 (rx_stream_valid0),
      .test_sim (test_in[0]),
      .tx_stream_cred0 (tx_stream_cred0),
      .tx_stream_data0_0 (tx_stream_data0),
      .tx_stream_data0_1 (tx_stream_data0_1),
      .tx_stream_fifo_empty0 (tx_fifo_empty0),
      .tx_stream_mask0 (gnd_tx_stream_mask0),
      .tx_stream_ready0 (tx_stream_ready0),
      .tx_stream_valid0 (tx_stream_valid0),
      /* Work around for TC */
      .p1_prg_wrdata        (p1_prg_wrdata),
      .p1_prg_addr          (p1_prg_addr),
      .p1_dma_rd_prg_rddata (p1_dma_rd_prg_rddata),
      .p1_dma_wr_prg_rddata (p1_dma_wr_prg_rddata),
      .p1_dma_rd_prg_wrena  (p1_dma_rd_prg_wrena),
      .p1_dma_wr_prg_wrena  (p1_dma_wr_prg_wrena),
      .p1_irq_prg_rddata    (p1_irq_prg_rddata),
      .p1_irq_prg_wrena     (p1_irq_prg_wrena),
      .p1_cmd_prg_rddata    (p1_cmd_prg_rddata),
      .p1_cmd_prg_wrena     (p1_cmd_prg_wrena),
      .p1_rx_ecrc_bad_cnt   (p1_rx_ecrc_bad_cnt),
      .p1_read_dma_status   (p1_read_dma_status),
      .p1_write_dma_status  (p1_write_dma_status)
      );

   defparam app0.AVALON_WADDR = 14,
     app0.CHECK_BUS_MASTER_ENA = 1,
     app0.CHECK_RX_BUFFER_CPL = 1,
     app0.CLK_250_APP = 1,
     app0.ECRC_FORWARD_CHECK = 0,
     app0.ECRC_FORWARD_GENER = 0,
     app0.MAX_NUMTAG = 32,
     app0.MAX_PAYLOAD_SIZE_BYTE = 512,
     app0.TL_SELECTION = 7,
     app0.TXCRED_WIDTH = 36,
     app0.PORT_NUM = 0;


   sonic_application_streaming_port app1
     (
      .aer_msi_num (open_aer_msi_num1),
      .app_int_ack (app_int_ack_icm),
      .app_int_sts (open_app_int_sts),
      .app_msi_ack (app_msi_ack),
      .app_msi_num (open_app_msi_num),
      .app_msi_req (app_msi_req1),
      .app_msi_tc (open_app_msi_tc),
      .cfg_busdev (cfg_busdev_icm),
      .cfg_devcsr (cfg_devcsr_icm),
      .cfg_linkcsr (cfg_linkcsr_icm),
      .cfg_msicsr (cfg_msicsr),
      .cfg_prmcsr (cfg_prmcsr_icm),
      .cfg_tcvcmap (cfg_tcvcmap),
      .xcvr_rx_clkout(xcvr_rx_clkout[1]),
      .xcvr_tx_clkout(xcvr_tx_clkout[1]),
      .xcvr_rx_dataout(xcvr_rx_dataout[79:40]),
      .xcvr_tx_datain(xcvr_tx_datain[79:40]),
      .pma_tx_ready(pma_tx_ready),
      .pma_rx_ready(pma_rx_ready),
/*      .reset_nios(reset_nios),
      .set_lpbk(set_lpbk),
      .unset_lpbk(unset_lpbk), */
      .monitor_out(monitor_out_1),
      .clk_in (pld_clk),
      .cpl_err (open_cpl_err),
      .cpl_pending (cpl_pending_icm1),
      .err_desc (open_err_desc),
      .ko_cpl_spc_vc0 (ko_cpl_spc_vc0),
      .msi_stream_data0 (open_msi_stream_data1),
      .msi_stream_ready0 (gnd_msi_stream_ready0),
      .msi_stream_valid0 (open_msi_stream_valid1),
      .pex_msi_num (open_pex_msi_num),
      .pm_data (open_pm_data),
      .rstn (srstn),
      .rx_stream_data0_0 (rx_stream_data1),
      .rx_stream_data0_1 (rx_stream_data1_1),
      .rx_stream_mask0 (rx_mask1),
      .rx_stream_ready0 (rx_stream_ready1),
      .rx_stream_valid0 (rx_stream_valid1),
      .test_sim (test_in[0]),
      .tx_stream_cred0 (tx_stream_cred0),
      .tx_stream_data0_0 (tx_stream_data1),
      .tx_stream_data0_1 (tx_stream_data1_1),
      .tx_stream_fifo_empty0 (tx_fifo_empty0),
      .tx_stream_mask0 (gnd_tx_stream_mask1),
      .tx_stream_ready0 (tx_stream_ready1),
      .tx_stream_valid0 (tx_stream_valid1),
      /* Work around for TC */
      .p1_prg_wrdata        (p1_prg_wrdata),
      .p1_prg_addr          (p1_prg_addr),
      .p1_dma_rd_prg_rddata (p1_dma_rd_prg_rddata),
      .p1_dma_wr_prg_rddata (p1_dma_wr_prg_rddata),
      .p1_dma_rd_prg_wrena  (p1_dma_rd_prg_wrena),
      .p1_dma_wr_prg_wrena  (p1_dma_wr_prg_wrena),
      .p1_irq_prg_rddata    (p1_irq_prg_rddata),
      .p1_irq_prg_wrena     (p1_irq_prg_wrena),
      .p1_cmd_prg_rddata    (p1_cmd_prg_rddata),
      .p1_cmd_prg_wrena     (p1_cmd_prg_wrena),
      .p1_rx_ecrc_bad_cnt   (p1_rx_ecrc_bad_cnt),
      .p1_read_dma_status   (p1_read_dma_status),
      .p1_write_dma_status  (p1_write_dma_status)
      );

   defparam app1.AVALON_WADDR = 14,
     app1.CHECK_BUS_MASTER_ENA = 1,
     app1.CHECK_RX_BUFFER_CPL = 1,
     app1.CLK_250_APP = 1,
     app1.ECRC_FORWARD_CHECK = 0,
     app1.ECRC_FORWARD_GENER = 0,
     app1.MAX_NUMTAG = 32,
     app1.MAX_PAYLOAD_SIZE_BYTE = 512,
     app1.TL_SELECTION = 7,
     app1.TXCRED_WIDTH = 36,
     app1.PORT_NUM = 1;

endmodule

