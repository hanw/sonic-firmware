// Generated by IP Compiler for PCI Express 11.0 [Altera, IP Toolbench 1.3.0 Build 157]
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
// ************************************************************
// Copyright (C) 1991-2011 Altera Corporation
// Any megafunction design, and related net list (encrypted or decrypted),
// support information, device programming or simulation file, and any other
// associated documentation or information provided by Altera or a partner
// under Altera's Megafunction Partnership Program may be used only to
// program PLD devices (but not masked PLD devices) from Altera.  Any other
// use of such megafunction design, net list, support information, device
// programming or simulation file, or any other related documentation or
// information is prohibited for any other purpose, including, but not
// limited to modification, reverse engineering, de-compiling, or use with
// any other silicon devices, unless such use is explicitly licensed under
// a separate agreement with Altera or a megafunction partner.  Title to
// the intellectual property, including patents, copyrights, trademarks,
// trade secrets, or maskworks, embodied in any such megafunction design,
// net list, support information, device programming or simulation file, or
// any other related documentation or information provided by Altera or a
// megafunction partner, remains with Altera, the megafunction partner, or
// their respective licensors.  No other licenses, including any licenses
// needed under any third party's intellectual property, are provided herein.


module top_core (
	AvlClk_i,
	CraAddress_i,
	CraByteEnable_i,
	CraChipSelect_i,
	CraRead,
	CraWrite,
	CraWriteData_i,
	Rstn_i,
	RxmIrqNum_i,
	RxmIrq_i,
	RxmReadDataValid_i,
	RxmReadData_i,
	RxmWaitRequest_i,
	TxsAddress_i,
	TxsBurstCount_i,
	TxsByteEnable_i,
	TxsChipSelect_i,
	TxsRead_i,
	TxsWriteData_i,
	TxsWrite_i,
	aer_msi_num,
	app_int_sts,
	app_msi_num,
	app_msi_req,
	app_msi_tc,
	core_clk_in,
	cpl_err,
	cpl_pending,
	crst,
	hpg_ctrler,
	lmi_addr,
	lmi_din,
	lmi_rden,
	lmi_wren,
	npor,
	pclk_central,
	pclk_ch0,
	pex_msi_num,
	pld_clk,
	pll_fixed_clk,
	pm_auxpwr,
	pm_data,
	pm_event,
	pme_to_cr,
	rc_areset,
	rc_inclk_eq_125mhz,
	rc_pll_locked,
	rc_rx_pll_locked_one,
	rx_st_mask0,
	rx_st_ready0,
	srst,
	test_in,
	tx_st_data0,
	tx_st_data0_p1,
	tx_st_eop0,
	tx_st_eop0_p1,
	tx_st_err0,
	tx_st_sop0,
	tx_st_sop0_p1,
	tx_st_valid0,
	phystatus0_ext,
	rxdata0_ext,
	rxdatak0_ext,
	rxelecidle0_ext,
	rxstatus0_ext,
	rxvalid0_ext,
	phystatus1_ext,
	rxdata1_ext,
	rxdatak1_ext,
	rxelecidle1_ext,
	rxstatus1_ext,
	rxvalid1_ext,
	phystatus2_ext,
	rxdata2_ext,
	rxdatak2_ext,
	rxelecidle2_ext,
	rxstatus2_ext,
	rxvalid2_ext,
	phystatus3_ext,
	rxdata3_ext,
	rxdatak3_ext,
	rxelecidle3_ext,
	rxstatus3_ext,
	rxvalid3_ext,
	phystatus4_ext,
	rxdata4_ext,
	rxdatak4_ext,
	rxelecidle4_ext,
	rxstatus4_ext,
	rxvalid4_ext,
	phystatus5_ext,
	rxdata5_ext,
	rxdatak5_ext,
	rxelecidle5_ext,
	rxstatus5_ext,
	rxvalid5_ext,
	phystatus6_ext,
	rxdata6_ext,
	rxdatak6_ext,
	rxelecidle6_ext,
	rxstatus6_ext,
	rxvalid6_ext,
	phystatus7_ext,
	rxdata7_ext,
	rxdatak7_ext,
	rxelecidle7_ext,
	rxstatus7_ext,
	rxvalid7_ext,
	CraIrq_o,
	CraReadData_o,
	CraWaitRequest_o,
	RxmAddress_o,
	RxmBurstCount_o,
	RxmByteEnable_o,
	RxmRead_o,
	RxmWriteData_o,
	RxmWrite_o,
	TxsReadDataValid_o,
	TxsReadData_o,
	TxsWaitRequest_o,
	app_int_ack,
	app_msi_ack,
	avs_pcie_reconfig_readdata,
	avs_pcie_reconfig_readdatavalid,
	avs_pcie_reconfig_waitrequest,
	core_clk_out,
	derr_cor_ext_rcv0,
	derr_cor_ext_rpl,
	derr_rpl,
	dl_ltssm,
	dlup_exit,
	eidle_infer_sel,
	ev_128ns,
	ev_1us,
	hip_extraclkout,
	hotrst_exit,
	int_status,
	l2_exit,
	lane_act,
	lmi_ack,
	lmi_dout,
	npd_alloc_1cred_vc0,
	npd_cred_vio_vc0,
	nph_alloc_1cred_vc0,
	nph_cred_vio_vc0,
	pme_to_sr,
	r2c_err0,
	rate_ext,
	rc_gxb_powerdown,
	rc_rx_analogreset,
	rc_rx_digitalreset,
	rc_tx_digitalreset,
	reset_status,
	rx_fifo_empty0,
	rx_fifo_full0,
	rx_st_bardec0,
	rx_st_be0,
	rx_st_be0_p1,
	rx_st_data0,
	rx_st_data0_p1,
	rx_st_eop0,
	rx_st_eop0_p1,
	rx_st_err0,
	rx_st_sop0,
	rx_st_sop0_p1,
	rx_st_valid0,
	serr_out,
	suc_spd_neg,
	swdn_wake,
	swup_hotrst,
	test_out,
	tl_cfg_add,
	tl_cfg_ctl,
	tl_cfg_ctl_wr,
	tl_cfg_sts,
	tl_cfg_sts_wr,
	tx_cred0,
	tx_deemph,
	tx_fifo_empty0,
	tx_fifo_full0,
	tx_fifo_rdptr0,
	tx_fifo_wrptr0,
	tx_margin,
	tx_st_ready0,
	use_pcie_reconfig,
	wake_oen,
	powerdown0_ext,
	rxpolarity0_ext,
	txcompl0_ext,
	txdata0_ext,
	txdatak0_ext,
	txdetectrx0_ext,
	txelecidle0_ext,
	powerdown1_ext,
	rxpolarity1_ext,
	txcompl1_ext,
	txdata1_ext,
	txdatak1_ext,
	txdetectrx1_ext,
	txelecidle1_ext,
	powerdown2_ext,
	rxpolarity2_ext,
	txcompl2_ext,
	txdata2_ext,
	txdatak2_ext,
	txdetectrx2_ext,
	txelecidle2_ext,
	powerdown3_ext,
	rxpolarity3_ext,
	txcompl3_ext,
	txdata3_ext,
	txdatak3_ext,
	txdetectrx3_ext,
	txelecidle3_ext,
	powerdown4_ext,
	rxpolarity4_ext,
	txcompl4_ext,
	txdata4_ext,
	txdatak4_ext,
	txdetectrx4_ext,
	txelecidle4_ext,
	powerdown5_ext,
	rxpolarity5_ext,
	txcompl5_ext,
	txdata5_ext,
	txdatak5_ext,
	txdetectrx5_ext,
	txelecidle5_ext,
	powerdown6_ext,
	rxpolarity6_ext,
	txcompl6_ext,
	txdata6_ext,
	txdatak6_ext,
	txdetectrx6_ext,
	txelecidle6_ext,
	powerdown7_ext,
	rxpolarity7_ext,
	txcompl7_ext,
	txdata7_ext,
	txdatak7_ext,
	txdetectrx7_ext,
	txelecidle7_ext);


	input		AvlClk_i;
	input	[11:0]	CraAddress_i;
	input	[3:0]	CraByteEnable_i;
	input		CraChipSelect_i;
	input		CraRead;
	input		CraWrite;
	input	[31:0]	CraWriteData_i;
	input		Rstn_i;
	input	[5:0]	RxmIrqNum_i;
	input		RxmIrq_i;
	input		RxmReadDataValid_i;
	input	[63:0]	RxmReadData_i;
	input		RxmWaitRequest_i;
	input	[16:0]	TxsAddress_i;
	input	[9:0]	TxsBurstCount_i;
	input	[7:0]	TxsByteEnable_i;
	input		TxsChipSelect_i;
	input		TxsRead_i;
	input	[63:0]	TxsWriteData_i;
	input		TxsWrite_i;
	input	[4:0]	aer_msi_num;
	input		app_int_sts;
	input	[4:0]	app_msi_num;
	input		app_msi_req;
	input	[2:0]	app_msi_tc;
	input		core_clk_in;
	input	[6:0]	cpl_err;
	input		cpl_pending;
	input		crst;
	input	[4:0]	hpg_ctrler;
	input	[11:0]	lmi_addr;
	input	[31:0]	lmi_din;
	input		lmi_rden;
	input		lmi_wren;
	input		npor;
	input		pclk_central;
	input		pclk_ch0;
	input	[4:0]	pex_msi_num;
	input		pld_clk;
	input		pll_fixed_clk;
	input		pm_auxpwr;
	input	[9:0]	pm_data;
	input		pm_event;
	input		pme_to_cr;
	input		rc_areset;
	input		rc_inclk_eq_125mhz;
	input		rc_pll_locked;
	input		rc_rx_pll_locked_one;
	input		rx_st_mask0;
	input		rx_st_ready0;
	input		srst;
	input	[39:0]	test_in;
	input	[63:0]	tx_st_data0;
	input	[63:0]	tx_st_data0_p1;
	input		tx_st_eop0;
	input		tx_st_eop0_p1;
	input		tx_st_err0;
	input		tx_st_sop0;
	input		tx_st_sop0_p1;
	input		tx_st_valid0;
	input		phystatus0_ext;
	input	[7:0]	rxdata0_ext;
	input		rxdatak0_ext;
	input		rxelecidle0_ext;
	input	[2:0]	rxstatus0_ext;
	input		rxvalid0_ext;
	input		phystatus1_ext;
	input	[7:0]	rxdata1_ext;
	input		rxdatak1_ext;
	input		rxelecidle1_ext;
	input	[2:0]	rxstatus1_ext;
	input		rxvalid1_ext;
	input		phystatus2_ext;
	input	[7:0]	rxdata2_ext;
	input		rxdatak2_ext;
	input		rxelecidle2_ext;
	input	[2:0]	rxstatus2_ext;
	input		rxvalid2_ext;
	input		phystatus3_ext;
	input	[7:0]	rxdata3_ext;
	input		rxdatak3_ext;
	input		rxelecidle3_ext;
	input	[2:0]	rxstatus3_ext;
	input		rxvalid3_ext;
	input		phystatus4_ext;
	input	[7:0]	rxdata4_ext;
	input		rxdatak4_ext;
	input		rxelecidle4_ext;
	input	[2:0]	rxstatus4_ext;
	input		rxvalid4_ext;
	input		phystatus5_ext;
	input	[7:0]	rxdata5_ext;
	input		rxdatak5_ext;
	input		rxelecidle5_ext;
	input	[2:0]	rxstatus5_ext;
	input		rxvalid5_ext;
	input		phystatus6_ext;
	input	[7:0]	rxdata6_ext;
	input		rxdatak6_ext;
	input		rxelecidle6_ext;
	input	[2:0]	rxstatus6_ext;
	input		rxvalid6_ext;
	input		phystatus7_ext;
	input	[7:0]	rxdata7_ext;
	input		rxdatak7_ext;
	input		rxelecidle7_ext;
	input	[2:0]	rxstatus7_ext;
	input		rxvalid7_ext;
	output		CraIrq_o;
	output	[31:0]	CraReadData_o;
	output		CraWaitRequest_o;
	output	[31:0]	RxmAddress_o;
	output	[9:0]	RxmBurstCount_o;
	output	[7:0]	RxmByteEnable_o;
	output		RxmRead_o;
	output	[63:0]	RxmWriteData_o;
	output		RxmWrite_o;
	output		TxsReadDataValid_o;
	output	[63:0]	TxsReadData_o;
	output		TxsWaitRequest_o;
	output		app_int_ack;
	output		app_msi_ack;
	output	[15:0]	avs_pcie_reconfig_readdata;
	output		avs_pcie_reconfig_readdatavalid;
	output		avs_pcie_reconfig_waitrequest;
	output		core_clk_out;
	output		derr_cor_ext_rcv0;
	output		derr_cor_ext_rpl;
	output		derr_rpl;
	output	[4:0]	dl_ltssm;
	output		dlup_exit;
	output	[23:0]	eidle_infer_sel;
	output		ev_128ns;
	output		ev_1us;
	output	[1:0]	hip_extraclkout;
	output		hotrst_exit;
	output	[3:0]	int_status;
	output		l2_exit;
	output	[3:0]	lane_act;
	output		lmi_ack;
	output	[31:0]	lmi_dout;
	output		npd_alloc_1cred_vc0;
	output		npd_cred_vio_vc0;
	output		nph_alloc_1cred_vc0;
	output		nph_cred_vio_vc0;
	output		pme_to_sr;
	output		r2c_err0;
	output		rate_ext;
	output		rc_gxb_powerdown;
	output		rc_rx_analogreset;
	output		rc_rx_digitalreset;
	output		rc_tx_digitalreset;
	output		reset_status;
	output		rx_fifo_empty0;
	output		rx_fifo_full0;
	output	[7:0]	rx_st_bardec0;
	output	[7:0]	rx_st_be0;
	output	[7:0]	rx_st_be0_p1;
	output	[63:0]	rx_st_data0;
	output	[63:0]	rx_st_data0_p1;
	output		rx_st_eop0;
	output		rx_st_eop0_p1;
	output		rx_st_err0;
	output		rx_st_sop0;
	output		rx_st_sop0_p1;
	output		rx_st_valid0;
	output		serr_out;
	output		suc_spd_neg;
	output		swdn_wake;
	output		swup_hotrst;
	output	[63:0]	test_out;
	output	[3:0]	tl_cfg_add;
	output	[31:0]	tl_cfg_ctl;
	output		tl_cfg_ctl_wr;
	output	[52:0]	tl_cfg_sts;
	output		tl_cfg_sts_wr;
	output	[35:0]	tx_cred0;
	output	[7:0]	tx_deemph;
	output		tx_fifo_empty0;
	output		tx_fifo_full0;
	output	[3:0]	tx_fifo_rdptr0;
	output	[3:0]	tx_fifo_wrptr0;
	output	[23:0]	tx_margin;
	output		tx_st_ready0;
	output		use_pcie_reconfig;
	output		wake_oen;
	output	[1:0]	powerdown0_ext;
	output		rxpolarity0_ext;
	output		txcompl0_ext;
	output	[7:0]	txdata0_ext;
	output		txdatak0_ext;
	output		txdetectrx0_ext;
	output		txelecidle0_ext;
	output	[1:0]	powerdown1_ext;
	output		rxpolarity1_ext;
	output		txcompl1_ext;
	output	[7:0]	txdata1_ext;
	output		txdatak1_ext;
	output		txdetectrx1_ext;
	output		txelecidle1_ext;
	output	[1:0]	powerdown2_ext;
	output		rxpolarity2_ext;
	output		txcompl2_ext;
	output	[7:0]	txdata2_ext;
	output		txdatak2_ext;
	output		txdetectrx2_ext;
	output		txelecidle2_ext;
	output	[1:0]	powerdown3_ext;
	output		rxpolarity3_ext;
	output		txcompl3_ext;
	output	[7:0]	txdata3_ext;
	output		txdatak3_ext;
	output		txdetectrx3_ext;
	output		txelecidle3_ext;
	output	[1:0]	powerdown4_ext;
	output		rxpolarity4_ext;
	output		txcompl4_ext;
	output	[7:0]	txdata4_ext;
	output		txdatak4_ext;
	output		txdetectrx4_ext;
	output		txelecidle4_ext;
	output	[1:0]	powerdown5_ext;
	output		rxpolarity5_ext;
	output		txcompl5_ext;
	output	[7:0]	txdata5_ext;
	output		txdatak5_ext;
	output		txdetectrx5_ext;
	output		txelecidle5_ext;
	output	[1:0]	powerdown6_ext;
	output		rxpolarity6_ext;
	output		txcompl6_ext;
	output	[7:0]	txdata6_ext;
	output		txdatak6_ext;
	output		txdetectrx6_ext;
	output		txelecidle6_ext;
	output	[1:0]	powerdown7_ext;
	output		rxpolarity7_ext;
	output		txcompl7_ext;
	output	[7:0]	txdata7_ext;
	output		txdatak7_ext;
	output		txdetectrx7_ext;
	output		txelecidle7_ext;

	wire [7:0] signal_wire0 = 8'b0;
	wire signal_wire1 = 1'b0;
	wire signal_wire2 = 1'b0;
	wire signal_wire3 = 1'b0;
	wire signal_wire4 = 1'b0;
	wire signal_wire5 = 1'b0;
	wire [15:0] signal_wire6 = 16'b0;
	wire [1:0] signal_wire7 = 2'b0;
	wire [2:0] signal_wire8 = 3'b0;
	wire [6:0] signal_wire9 = 7'b0;
	wire signal_wire10 = 1'b1;
	wire signal_wire11 = 1'b0;
	wire signal_wire12 = 1'b0;
	wire [12:0] signal_wire13 = 13'b0;
	wire [11:0] signal_wire14 = 12'b0;
	wire [7:0] signal_wire15 = 8'b0;
	wire signal_wire16 = 1'b0;
	wire [2:0] signal_wire17 = 3'b0;
	wire [3:0] signal_wire18 = 4'b0;
	wire [3:0] signal_wire19 = 4'b0;
	wire signal_wire20 = 1'b0;
	wire signal_wire21 = 1'b0;
	wire signal_wire22 = 1'b0;
	wire signal_wire23 = 1'b0;
	wire signal_wire24 = 1'b0;
	wire [2:0] signal_wire25 = 3'b0;
	wire signal_wire26 = 1'b0;
	wire [1:0] signal_wire27 = 2'b0;
	wire [7:0] signal_wire28 = 8'b0;
	wire [23:0] signal_wire29 = 24'b0;
	wire [2:0] signal_wire30 = 3'b0;
	wire signal_wire31 = 1'b0;
	wire signal_wire32 = 1'b0;
	wire [63:0] signal_wire33 = 64'b0;
	wire [63:0] signal_wire34 = 64'b0;
	wire signal_wire35 = 1'b0;
	wire signal_wire36 = 1'b0;
	wire signal_wire37 = 1'b0;
	wire signal_wire38 = 1'b0;
	wire signal_wire39 = 1'b0;
	wire signal_wire40 = 1'b0;

	altpcie_hip_pipen1b	altpcie_hip_pipen1b_inst(
		.AvlClk_i(AvlClk_i),
		.CraAddress_i(CraAddress_i),
		.CraByteEnable_i(CraByteEnable_i),
		.CraChipSelect_i(CraChipSelect_i),
		.CraRead(CraRead),
		.CraWrite(CraWrite),
		.CraWriteData_i(CraWriteData_i),
		.Rstn_i(Rstn_i),
		.RxmIrqNum_i(RxmIrqNum_i),
		.RxmIrq_i(RxmIrq_i),
		.RxmReadDataValid_i(RxmReadDataValid_i),
		.RxmReadData_i(RxmReadData_i),
		.RxmWaitRequest_i(RxmWaitRequest_i),
		.TxsAddress_i(TxsAddress_i),
		.TxsBurstCount_i(TxsBurstCount_i),
		.TxsByteEnable_i(TxsByteEnable_i),
		.TxsChipSelect_i(TxsChipSelect_i),
		.TxsRead_i(TxsRead_i),
		.TxsWriteData_i(TxsWriteData_i),
		.TxsWrite_i(TxsWrite_i),
		.aer_msi_num(aer_msi_num),
		.app_int_sts(app_int_sts),
		.app_msi_num(app_msi_num),
		.app_msi_req(app_msi_req),
		.app_msi_tc(app_msi_tc),
		.avs_pcie_reconfig_address(signal_wire0),
		.avs_pcie_reconfig_chipselect(signal_wire1),
		.avs_pcie_reconfig_clk(signal_wire2),
		.avs_pcie_reconfig_read(signal_wire3),
		.avs_pcie_reconfig_rstn(signal_wire4),
		.avs_pcie_reconfig_write(signal_wire5),
		.avs_pcie_reconfig_writedata(signal_wire6),
		.core_clk_in(core_clk_in),
		.cpl_err(cpl_err),
		.cpl_pending(cpl_pending),
		.crst(crst),
		.hpg_ctrler(hpg_ctrler),
		.lmi_addr(lmi_addr),
		.lmi_din(lmi_din),
		.lmi_rden(lmi_rden),
		.lmi_wren(lmi_wren),
		.mode(signal_wire7),
		.npor(npor),
		.pclk_central(pclk_central),
		.pclk_ch0(pclk_ch0),
		.pex_msi_num(pex_msi_num),
		.pld_clk(pld_clk),
		.pll_fixed_clk(pll_fixed_clk),
		.pm_auxpwr(pm_auxpwr),
		.pm_data(pm_data),
		.pm_event(pm_event),
		.pme_to_cr(pme_to_cr),
		.rc_areset(rc_areset),
		.rc_inclk_eq_125mhz(rc_inclk_eq_125mhz),
		.rc_pll_locked(rc_pll_locked),
		.rc_rx_pll_locked_one(rc_rx_pll_locked_one),
		.rx_st_mask0(rx_st_mask0),
		.rx_st_ready0(rx_st_ready0),
		.srst(srst),
		.swdn_in(signal_wire8),
		.swup_in(signal_wire9),
		.test_in(test_in),
		.tl_slotclk_cfg(signal_wire10),
		.tlbp_dl_aspm_cr0(signal_wire11),
		.tlbp_dl_comclk_reg(signal_wire12),
		.tlbp_dl_ctrl_link2(signal_wire13),
		.tlbp_dl_data_upfc(signal_wire14),
		.tlbp_dl_hdr_upfc(signal_wire15),
		.tlbp_dl_inh_dllp(signal_wire16),
		.tlbp_dl_maxpload_dcr(signal_wire17),
		.tlbp_dl_req_phycfg(signal_wire18),
		.tlbp_dl_req_phypm(signal_wire19),
		.tlbp_dl_req_upfc(signal_wire20),
		.tlbp_dl_req_wake(signal_wire21),
		.tlbp_dl_rx_ecrcchk(signal_wire22),
		.tlbp_dl_snd_upfc(signal_wire23),
		.tlbp_dl_tx_reqpm(signal_wire24),
		.tlbp_dl_tx_typpm(signal_wire25),
		.tlbp_dl_txcfg_extsy(signal_wire26),
		.tlbp_dl_typ_upfc(signal_wire27),
		.tlbp_dl_vc_ctrl(signal_wire28),
		.tlbp_dl_vcid_map(signal_wire29),
		.tlbp_dl_vcid_upfc(signal_wire30),
		.tx_st_data0(tx_st_data0),
		.tx_st_data0_p1(tx_st_data0_p1),
		.tx_st_eop0(tx_st_eop0),
		.tx_st_eop0_p1(tx_st_eop0_p1),
		.tx_st_err0(tx_st_err0),
		.tx_st_sop0(tx_st_sop0),
		.tx_st_sop0_p1(tx_st_sop0_p1),
		.tx_st_valid0(tx_st_valid0),
		.rx_st_mask1(signal_wire31),
		.rx_st_ready1(signal_wire32),
		.tx_st_data1(signal_wire33),
		.tx_st_data1_p1(signal_wire34),
		.tx_st_eop1(signal_wire35),
		.tx_st_eop1_p1(signal_wire36),
		.tx_st_err1(signal_wire37),
		.tx_st_sop1(signal_wire38),
		.tx_st_sop1_p1(signal_wire39),
		.tx_st_valid1(signal_wire40),
		.phystatus0_ext(phystatus0_ext),
		.rxdata0_ext(rxdata0_ext),
		.rxdatak0_ext(rxdatak0_ext),
		.rxelecidle0_ext(rxelecidle0_ext),
		.rxstatus0_ext(rxstatus0_ext),
		.rxvalid0_ext(rxvalid0_ext),
		.phystatus1_ext(phystatus1_ext),
		.rxdata1_ext(rxdata1_ext),
		.rxdatak1_ext(rxdatak1_ext),
		.rxelecidle1_ext(rxelecidle1_ext),
		.rxstatus1_ext(rxstatus1_ext),
		.rxvalid1_ext(rxvalid1_ext),
		.phystatus2_ext(phystatus2_ext),
		.rxdata2_ext(rxdata2_ext),
		.rxdatak2_ext(rxdatak2_ext),
		.rxelecidle2_ext(rxelecidle2_ext),
		.rxstatus2_ext(rxstatus2_ext),
		.rxvalid2_ext(rxvalid2_ext),
		.phystatus3_ext(phystatus3_ext),
		.rxdata3_ext(rxdata3_ext),
		.rxdatak3_ext(rxdatak3_ext),
		.rxelecidle3_ext(rxelecidle3_ext),
		.rxstatus3_ext(rxstatus3_ext),
		.rxvalid3_ext(rxvalid3_ext),
		.phystatus4_ext(phystatus4_ext),
		.rxdata4_ext(rxdata4_ext),
		.rxdatak4_ext(rxdatak4_ext),
		.rxelecidle4_ext(rxelecidle4_ext),
		.rxstatus4_ext(rxstatus4_ext),
		.rxvalid4_ext(rxvalid4_ext),
		.phystatus5_ext(phystatus5_ext),
		.rxdata5_ext(rxdata5_ext),
		.rxdatak5_ext(rxdatak5_ext),
		.rxelecidle5_ext(rxelecidle5_ext),
		.rxstatus5_ext(rxstatus5_ext),
		.rxvalid5_ext(rxvalid5_ext),
		.phystatus6_ext(phystatus6_ext),
		.rxdata6_ext(rxdata6_ext),
		.rxdatak6_ext(rxdatak6_ext),
		.rxelecidle6_ext(rxelecidle6_ext),
		.rxstatus6_ext(rxstatus6_ext),
		.rxvalid6_ext(rxvalid6_ext),
		.phystatus7_ext(phystatus7_ext),
		.rxdata7_ext(rxdata7_ext),
		.rxdatak7_ext(rxdatak7_ext),
		.rxelecidle7_ext(rxelecidle7_ext),
		.rxstatus7_ext(rxstatus7_ext),
		.rxvalid7_ext(rxvalid7_ext),
		.CraIrq_o(CraIrq_o),
		.CraReadData_o(CraReadData_o),
		.CraWaitRequest_o(CraWaitRequest_o),
		.RxmAddress_o(RxmAddress_o),
		.RxmBurstCount_o(RxmBurstCount_o),
		.RxmByteEnable_o(RxmByteEnable_o),
		.RxmRead_o(RxmRead_o),
		.RxmWriteData_o(RxmWriteData_o),
		.RxmWrite_o(RxmWrite_o),
		.TxsReadDataValid_o(TxsReadDataValid_o),
		.TxsReadData_o(TxsReadData_o),
		.TxsWaitRequest_o(TxsWaitRequest_o),
		.app_int_ack(app_int_ack),
		.app_msi_ack(app_msi_ack),
		.avs_pcie_reconfig_readdata(avs_pcie_reconfig_readdata),
		.avs_pcie_reconfig_readdatavalid(avs_pcie_reconfig_readdatavalid),
		.avs_pcie_reconfig_waitrequest(avs_pcie_reconfig_waitrequest),
		.core_clk_out(core_clk_out),
		.derr_cor_ext_rcv0(derr_cor_ext_rcv0),
		.derr_cor_ext_rpl(derr_cor_ext_rpl),
		.derr_rpl(derr_rpl),
		.dl_ltssm(dl_ltssm),
		.dlup_exit(dlup_exit),
		.eidle_infer_sel(eidle_infer_sel),
		.ev_128ns(ev_128ns),
		.ev_1us(ev_1us),
		.hip_extraclkout(hip_extraclkout),
		.hotrst_exit(hotrst_exit),
		.int_status(int_status),
		.l2_exit(l2_exit),
		.lane_act(lane_act),
		.lmi_ack(lmi_ack),
		.lmi_dout(lmi_dout),
		.npd_alloc_1cred_vc0(npd_alloc_1cred_vc0),
		.npd_cred_vio_vc0(npd_cred_vio_vc0),
		.nph_alloc_1cred_vc0(nph_alloc_1cred_vc0),
		.nph_cred_vio_vc0(nph_cred_vio_vc0),
		.pme_to_sr(pme_to_sr),
		.r2c_err0(r2c_err0),
		.rate_ext(rate_ext),
		.rc_gxb_powerdown(rc_gxb_powerdown),
		.rc_rx_analogreset(rc_rx_analogreset),
		.rc_rx_digitalreset(rc_rx_digitalreset),
		.rc_tx_digitalreset(rc_tx_digitalreset),
		.reset_status(reset_status),
		.rx_fifo_empty0(rx_fifo_empty0),
		.rx_fifo_full0(rx_fifo_full0),
		.rx_st_bardec0(rx_st_bardec0),
		.rx_st_be0(rx_st_be0),
		.rx_st_be0_p1(rx_st_be0_p1),
		.rx_st_data0(rx_st_data0),
		.rx_st_data0_p1(rx_st_data0_p1),
		.rx_st_eop0(rx_st_eop0),
		.rx_st_eop0_p1(rx_st_eop0_p1),
		.rx_st_err0(rx_st_err0),
		.rx_st_sop0(rx_st_sop0),
		.rx_st_sop0_p1(rx_st_sop0_p1),
		.rx_st_valid0(rx_st_valid0),
		.serr_out(serr_out),
		.suc_spd_neg(suc_spd_neg),
		.swdn_wake(swdn_wake),
		.swup_hotrst(swup_hotrst),
		.test_out(test_out),
		.tl_cfg_add(tl_cfg_add),
		.tl_cfg_ctl(tl_cfg_ctl),
		.tl_cfg_ctl_wr(tl_cfg_ctl_wr),
		.tl_cfg_sts(tl_cfg_sts),
		.tl_cfg_sts_wr(tl_cfg_sts_wr),
		.tlbp_dl_ack_phypm(),
		.tlbp_dl_ack_requpfc(),
		.tlbp_dl_ack_sndupfc(),
		.tlbp_dl_current_deemp(),
		.tlbp_dl_currentspeed(),
		.tlbp_dl_dll_req(),
		.tlbp_dl_err_dll(),
		.tlbp_dl_errphy(),
		.tlbp_dl_link_autobdw_status(),
		.tlbp_dl_link_bdwmng_status(),
		.tlbp_dl_rpbuf_emp(),
		.tlbp_dl_rst_enter_comp_bit(),
		.tlbp_dl_rst_tx_margin_field(),
		.tlbp_dl_rx_typ_pm(),
		.tlbp_dl_rx_valpm(),
		.tlbp_dl_tx_ackpm(),
		.tlbp_dl_up(),
		.tlbp_dl_vc_status(),
		.tlbp_link_up(),
		.tx_cred0(tx_cred0),
		.tx_deemph(tx_deemph),
		.tx_fifo_empty0(tx_fifo_empty0),
		.tx_fifo_full0(tx_fifo_full0),
		.tx_fifo_rdptr0(tx_fifo_rdptr0),
		.tx_fifo_wrptr0(tx_fifo_wrptr0),
		.tx_margin(tx_margin),
		.tx_st_ready0(tx_st_ready0),
		.use_pcie_reconfig(use_pcie_reconfig),
		.wake_oen(wake_oen),
		.derr_cor_ext_rcv1(),
		.npd_alloc_1cred_vc1(),
		.npd_cred_vio_vc1(),
		.nph_alloc_1cred_vc1(),
		.nph_cred_vio_vc1(),
		.r2c_err1(),
		.rx_fifo_empty1(),
		.rx_fifo_full1(),
		.rx_st_bardec1(),
		.rx_st_be1(),
		.rx_st_be1_p1(),
		.rx_st_data1(),
		.rx_st_data1_p1(),
		.rx_st_eop1(),
		.rx_st_eop1_p1(),
		.rx_st_err1(),
		.rx_st_sop1(),
		.rx_st_sop1_p1(),
		.rx_st_valid1(),
		.tx_cred1(),
		.tx_fifo_empty1(),
		.tx_fifo_full1(),
		.tx_fifo_rdptr1(),
		.tx_fifo_wrptr1(),
		.tx_st_ready1(),
		.powerdown0_ext(powerdown0_ext),
		.rxpolarity0_ext(rxpolarity0_ext),
		.txcompl0_ext(txcompl0_ext),
		.txdata0_ext(txdata0_ext),
		.txdatak0_ext(txdatak0_ext),
		.txdetectrx0_ext(txdetectrx0_ext),
		.txelecidle0_ext(txelecidle0_ext),
		.powerdown1_ext(powerdown1_ext),
		.rxpolarity1_ext(rxpolarity1_ext),
		.txcompl1_ext(txcompl1_ext),
		.txdata1_ext(txdata1_ext),
		.txdatak1_ext(txdatak1_ext),
		.txdetectrx1_ext(txdetectrx1_ext),
		.txelecidle1_ext(txelecidle1_ext),
		.powerdown2_ext(powerdown2_ext),
		.rxpolarity2_ext(rxpolarity2_ext),
		.txcompl2_ext(txcompl2_ext),
		.txdata2_ext(txdata2_ext),
		.txdatak2_ext(txdatak2_ext),
		.txdetectrx2_ext(txdetectrx2_ext),
		.txelecidle2_ext(txelecidle2_ext),
		.powerdown3_ext(powerdown3_ext),
		.rxpolarity3_ext(rxpolarity3_ext),
		.txcompl3_ext(txcompl3_ext),
		.txdata3_ext(txdata3_ext),
		.txdatak3_ext(txdatak3_ext),
		.txdetectrx3_ext(txdetectrx3_ext),
		.txelecidle3_ext(txelecidle3_ext),
		.powerdown4_ext(powerdown4_ext),
		.rxpolarity4_ext(rxpolarity4_ext),
		.txcompl4_ext(txcompl4_ext),
		.txdata4_ext(txdata4_ext),
		.txdatak4_ext(txdatak4_ext),
		.txdetectrx4_ext(txdetectrx4_ext),
		.txelecidle4_ext(txelecidle4_ext),
		.powerdown5_ext(powerdown5_ext),
		.rxpolarity5_ext(rxpolarity5_ext),
		.txcompl5_ext(txcompl5_ext),
		.txdata5_ext(txdata5_ext),
		.txdatak5_ext(txdatak5_ext),
		.txdetectrx5_ext(txdetectrx5_ext),
		.txelecidle5_ext(txelecidle5_ext),
		.powerdown6_ext(powerdown6_ext),
		.rxpolarity6_ext(rxpolarity6_ext),
		.txcompl6_ext(txcompl6_ext),
		.txdata6_ext(txdata6_ext),
		.txdatak6_ext(txdatak6_ext),
		.txdetectrx6_ext(txdetectrx6_ext),
		.txelecidle6_ext(txelecidle6_ext),
		.powerdown7_ext(powerdown7_ext),
		.rxpolarity7_ext(rxpolarity7_ext),
		.txcompl7_ext(txcompl7_ext),
		.txdata7_ext(txdata7_ext),
		.txdatak7_ext(txdatak7_ext),
		.txdetectrx7_ext(txdetectrx7_ext),
		.txelecidle7_ext(txelecidle7_ext));

	defparam
		altpcie_hip_pipen1b_inst.p_pcie_hip_type = "0",
		altpcie_hip_pipen1b_inst.retry_buffer_last_active_address = "2047",
		altpcie_hip_pipen1b_inst.advanced_errors = "false",
		altpcie_hip_pipen1b_inst.bar0_io_space = "false",
		altpcie_hip_pipen1b_inst.bar0_64bit_mem_space = "true",
		altpcie_hip_pipen1b_inst.bar0_prefetchable = "true",
		altpcie_hip_pipen1b_inst.bar0_size_mask = 28,
		altpcie_hip_pipen1b_inst.bar1_io_space = "false",
		altpcie_hip_pipen1b_inst.bar1_64bit_mem_space = "true",
		altpcie_hip_pipen1b_inst.bar1_prefetchable = "false",
		altpcie_hip_pipen1b_inst.bar1_size_mask = 0,
		altpcie_hip_pipen1b_inst.bar2_io_space = "false",
		altpcie_hip_pipen1b_inst.bar2_64bit_mem_space = "false",
		altpcie_hip_pipen1b_inst.bar2_prefetchable = "false",
		altpcie_hip_pipen1b_inst.bar2_size_mask = 18,
		altpcie_hip_pipen1b_inst.bar3_io_space = "false",
		altpcie_hip_pipen1b_inst.bar3_64bit_mem_space = "false",
		altpcie_hip_pipen1b_inst.bar3_prefetchable = "false",
		altpcie_hip_pipen1b_inst.bar3_size_mask = 18,
		altpcie_hip_pipen1b_inst.enable_ecrc_check = "false",
		altpcie_hip_pipen1b_inst.enable_ecrc_gen = "false",
		altpcie_hip_pipen1b_inst.enable_l1_aspm = "false",
		altpcie_hip_pipen1b_inst.l01_entry_latency = 31,
		altpcie_hip_pipen1b_inst.pcie_mode = "SHARED_MODE",
		altpcie_hip_pipen1b_inst.extend_tag_field = "false",
		altpcie_hip_pipen1b_inst.bypass_cdc = "false",
		altpcie_hip_pipen1b_inst.vc_arbitration = 0,
		altpcie_hip_pipen1b_inst.no_soft_reset = "true",
		altpcie_hip_pipen1b_inst.enable_ch0_pclk_out = "false",
		altpcie_hip_pipen1b_inst.core_clk_divider = 1,
		altpcie_hip_pipen1b_inst.millisecond_cycle_count = 250000,
		altpcie_hip_pipen1b_inst.max_link_width = 8,
		altpcie_hip_pipen1b_inst.lane_mask = 8'b00000000,
		altpcie_hip_pipen1b_inst.single_rx_detect = 0,
		altpcie_hip_pipen1b_inst.enable_adapter_half_rate_mode = "true",
		altpcie_hip_pipen1b_inst.enable_coreclk_out_half_rate = "true",
		altpcie_hip_pipen1b_inst.enable_gen2_core = "true",
		altpcie_hip_pipen1b_inst.gen2_lane_rate_mode = "true",
		altpcie_hip_pipen1b_inst.vendor_id = 4466,
		altpcie_hip_pipen1b_inst.device_id = 57345,
		altpcie_hip_pipen1b_inst.revision_id = 1,
		altpcie_hip_pipen1b_inst.class_code = 16711680,
		altpcie_hip_pipen1b_inst.subsystem_vendor_id = 23518,
		altpcie_hip_pipen1b_inst.subsystem_device_id = 10241,
		altpcie_hip_pipen1b_inst.port_link_number = 1,
		altpcie_hip_pipen1b_inst.max_payload_size = 2,
		altpcie_hip_pipen1b_inst.msi_function_count = 2,
		altpcie_hip_pipen1b_inst.endpoint_l0_latency = 0,
		altpcie_hip_pipen1b_inst.endpoint_l1_latency = 0,
		altpcie_hip_pipen1b_inst.diffclock_nfts_count = 255,
		altpcie_hip_pipen1b_inst.sameclock_nfts_count = 255,
		altpcie_hip_pipen1b_inst.l1_exit_latency_sameclock = 7,
		altpcie_hip_pipen1b_inst.l1_exit_latency_diffclock = 7,
		altpcie_hip_pipen1b_inst.l0_exit_latency_sameclock = 7,
		altpcie_hip_pipen1b_inst.l0_exit_latency_diffclock = 7,
		altpcie_hip_pipen1b_inst.enable_msi_64bit_addressing = "true",
		altpcie_hip_pipen1b_inst.gen2_diffclock_nfts_count = 255,
		altpcie_hip_pipen1b_inst.gen2_sameclock_nfts_count = 255,
		altpcie_hip_pipen1b_inst.enable_function_msix_support = "false",
		altpcie_hip_pipen1b_inst.credit_buffer_allocation_aux = "BALANCED",
		altpcie_hip_pipen1b_inst.eie_before_nfts_count = 4,
		altpcie_hip_pipen1b_inst.completion_timeout = "ABCD",
		altpcie_hip_pipen1b_inst.enable_completion_timeout_disable = "true",
		altpcie_hip_pipen1b_inst.msix_pba_bir = 0,
		altpcie_hip_pipen1b_inst.msix_pba_offset = 0,
		altpcie_hip_pipen1b_inst.msix_table_bir = 0,
		altpcie_hip_pipen1b_inst.msix_table_offset = 0,
		altpcie_hip_pipen1b_inst.msix_table_size = 0,
		altpcie_hip_pipen1b_inst.use_crc_forwarding = "false",
		altpcie_hip_pipen1b_inst.RX_BUF = 11,
		altpcie_hip_pipen1b_inst.RH_NUM = 8,
		altpcie_hip_pipen1b_inst.G_TAG_NUM0  = 32;
endmodule
