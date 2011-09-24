// /**
//  * This Verilog HDL file is used for simulation and synthesis in
//  * the chaining DMA design example. It arbitrates PCI Express packets for
//  * the modules sonic_dma_dt (read or write) and sonic_rc_slave. It
//  * instantiates the Endpoint memory used for the DMA read and write transfer.
//  */
// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on
`include "sonic_constants.sv"
// synthesis verilog_input_version verilog_2001
// turn off superfluous verilog processor warnings
// altera message_level Level1
// altera message_off 10034 10035 10036 10037 10230 10240 10030

//-----------------------------------------------------------------------------
// Title         : PCI Express Reference Design Example Application
// Project       : PCI Express MegaCore function
//-----------------------------------------------------------------------------
// File          : sonic_application_core_logic.v
// Author        : Altera Corporation
//-----------------------------------------------------------------------------
// Description :
// This is the complete example application for the PCI Express Reference
// Design. This has all of the application logic for the example.
// We extended this file to encapsulate the logics for one port into one module.
// And duplicate the same module for the second port.
// We design an overlay arbitor to arbitrate the PCI traffic between two ports.
// As a result, this module contains three main modules, port 0, port 1, and arbitor.
//-----------------------------------------------------------------------------
// Copyright (c) 2008 Altera Corporation. All rights reserved.  Altera products are
// protected under numerous U.S. and foreign patents, maskwork rights, copyrights and
// other intellectual property laws.
//
// This reference design file, and your use thereof, is subject to and governed by
// the terms and conditions of the applicable Altera Reference Design License Agreement.
// By using this reference design file, you indicate your acceptance of such terms and
// conditions between you and Altera Corporation.  In the event that you do not agree with
// such terms and conditions, you may not use the reference design file. Please promptly
// destroy any copies you have made.
//
// This reference design file being provided on an "as-is" basis and as an accommodation
// and therefore all warranties, representations or guarantees of any kind
// (whether express, implied or statutory) including, without limitation, warranties of
// merchantability, non-infringement, or fitness for a particular purpose, are
// specifically disclaimed.  By making this reference design file available, Altera
// expressly does not recommend, suggest or require that this reference design file be
// used in combination with any other product not provided by Altera.
//-----------------------------------------------------------------------------
//
// This module instantiates the two port on board.
// Each port has its own set of Tx/Rx ring buffer, command controller,
// IRQ controller, DMA engine, rc_slave module.
// The task of this module is to arbitrate the PCIe traffic at coarse.
// This module grants the PCIe bus (Tx or Rx direction) separately to a single port 
// at any given time.
// The arbitration interface includes:
// - tx_ready (OR'ed of all tx_ready signals from a port).
// - tx_idle  (OR'ed of all tx_busy signals from a port).
// - rx_ready (OR'ed of all rx_ready signals from a port).
// - rx_idle  (OR'ed of all rx_idle signals from a port).
// - tx_sel   (select one of the port to use the PCIe tx bus).
// - rx_sel   (select one of the port to use the PCIe rx bus).

module sonic_application_core_logic #(
	parameter MAX_NUMTAG             = 32,
	parameter AVALON_WADDR           = 12,
	parameter CHECK_BUS_MASTER_ENA   = 0,
	parameter AVALON_WDATA           = 64,
	parameter MAX_PAYLOAD_SIZE_BYTE  = 256,
	parameter BOARD_DEMO             = 0,
	parameter TL_SELECTION           = 0,
	parameter TXCRED_WIDTH           = 36,
	parameter CLK_250_APP            = 0,  // When 1 indicate application clock rate is 250MHz instead of 125 MHz
	parameter RC_64BITS_ADDR         = 0,  // When 1 use 64 bit tx_desc address and not 32
	parameter USE_CREDIT_CTRL        = 0,
	parameter USE_MSI                = 1,  // When 1, tx_arbitration uses tx_cred
	parameter USE_DMAWRITE           = 1,
	parameter USE_DMAREAD            = 1,
	parameter AVALON_ST_128          = 0,
	parameter INTENDED_DEVICE_FAMILY = "Cyclone IV GX",
	parameter CDMA_AST_RXWS_LATENCY  = 2
	)(
	input clk_in  ,
	input hw_rstn ,

	input[12:0] cfg_busdev,
	input[31:0] cfg_devcsr,
	input[31:0] cfg_prmcsr,
	input[23:0] cfg_tcvcmap,
	input[31:0] cfg_linkcsr,
	input[15:0] cfg_msicsr,
	input[19:0] ko_cpl_spc_vc0,

	output  cpl_pending,
	output[6:0] cpl_err,
	output [127:0] err_desc,

	// MSI signals section
	input       app_msi_ack,
	output reg     app_msi_req,
	output reg [2:0] app_msi_tc ,
	output reg [4:0] app_msi_num,

	// Legacy Interupt signals
	output      app_int_sts,
	input       app_int_ack,

	// Transceiver in/out
/*	input 		xcvr_rx_clkout,
	input 		xcvr_tx_clkout,
    input [39:0] xcvr_rx_dataout,
	output [39:0] xcvr_tx_datain,
*/
	input [1:0]		xcvr_rx_clkout,
	input [1:0]		xcvr_tx_clkout,
    input [79:0] xcvr_rx_dataout,
	output [79:0] xcvr_tx_datain,

    input		pma_tx_ready,
	input		pma_rx_ready,
	output		reset_nios,
	output		set_lpbk,
	output		unset_lpbk,

	// Receive section channel 0
	output       rx_ack0  ,
	output       rx_mask0 ,
	output       rx_ws0   ,
	input        rx_req0  ,
	input[135:0] rx_desc0 ,
	input[127:0] rx_data0 ,
	input[15:0]  rx_be0,
	input        rx_dv0   ,
	input        rx_dfr0  ,
	input [15:0] rx_ecrc_bad_cnt,

	//transmit section channel 0
	output                   tx_req0 ,
	input                    tx_ack0 ,
	output [127:0]           tx_desc0,
	output                   tx_dv0  ,
	output                   tx_dfr0 ,
	input                    tx_ws0 ,
	output [127:0]           tx_data0,
	output                   tx_err0 ,
	input                    tx_mask0,
	input                    cpld_rx_buffer_ready,
	input [35:0]             tx_cred0,
    // specifify the maximum amount of data available in RX Buffer for a given MRd
	input [15:0]             rx_buffer_cpl_max_dw,  
	input                    tx_stream_ready0

	);


    // Tx muxed
    wire tx_req_p0;
    wire [127:0] tx_desc_p0;
    wire tx_dv_p0;
    wire tx_dfr_p0;
    wire [127:0] tx_data_p0;
    wire tx_err_p0;
    wire tx_req_p1;
    wire [127:0] tx_desc_p1;
    wire tx_dv_p1;
    wire tx_dfr_p1;
    wire [127:0] tx_data_p1;
    wire tx_err_p1;

    // Rx muxed
    wire rx_ack_p0;
    wire rx_ack_p1;
    wire rx_ws_p0;
    wire rx_ws_p1;
    wire rx_mask_p0;
    wire rx_mask_p1;
    wire app_int_sts_p0;
    wire app_int_sts_p1;
    assign rx_ack0 = rx_ack_p0 | rx_ack_p1;
    assign rx_ws0 = rx_ws_p0 | rx_ws_p1;
    assign rx_mask0 = rx_mask_p0 | rx_mask_p1;
    assign app_int_sts = app_int_sts_p0 | app_int_sts_p1;

    // cpl 
    wire [6:0] cpl_err_p0;
    wire [6:0] cpl_err_p1;
    wire [127:0] err_desc_p0;
    wire [127:0] err_desc_p1;
    wire cpl_pending_p0;
    wire cpl_pending_p1;
    assign cpl_err = cpl_err_p0 | cpl_err_p1;
    assign err_desc = err_desc_p0 | err_desc_p1;
    assign cpl_pending = cpl_pending_p0 | cpl_pending_p1;

    // IRQ muxed
	wire       app_msi_req_p0;
	wire       app_msi_req_p1;
	wire [2:0]  app_msi_tc_p0;
    wire [2:0]  app_msi_tc_p1;
	wire [4:0]  app_msi_num_p0;
	wire [4:0]  app_msi_num_p1;

    always @ (negedge hw_rstn or posedge clk_in) begin
        if (hw_rstn == 1'b0) begin
            app_msi_req <= 0;
            app_msi_tc <= 0;
            app_msi_num <= 0;
        end
        else begin
            app_msi_req <= app_msi_req_p0 | app_msi_req_p1;

            if (app_msi_req_p0 == 1'b1) begin
                app_msi_tc <= app_msi_tc_p0;
                app_msi_num <= app_msi_num_p0;
            end
            else if(app_msi_req_p1 == 1'b1) begin
                app_msi_tc <= app_msi_tc_p1;
                app_msi_num <= app_msi_num_p1;
            end
        end
    end

    // Use One level arbiter, it is simpler and faster.
    wire [15:0] arbiter_req;
    wire [15:0] arbiter_grant;
    wire [3:0]  arbiter_select;
    wire        arbiter_valid;
    wire [7:0]  tx_rdy_p1;
    wire [7:0]  tx_rdy_p0;

    assign arbiter_req = { 8'h0, tx_rdy_p0 };
    
    wire pci_tx_idle;
    wire pci_tx_idle_p0_tx_sel;
    wire dma_tx_idle_p0;
    wire dma_tx_idle_p1;
    wire dma_tx_idle_p0_tx_sel_p0;
    wire dma_tx_idle_p0_tx_sel_p1;
    assign pci_tx_idle = dma_tx_idle_p0 & dma_tx_idle_p1;
    assign pci_tx_idle_p0_tx_sel = dma_tx_idle_p0_tx_sel_p0 & 
                                   dma_tx_idle_p0_tx_sel_p1;

    // use arbiter_enable to read the next arbitration decision
/*    
    wire arbiter_enable;   
    assign arbiter_enable = pci_tx_idle & pci_tx_idle_p0_tx_sel;

    sonic_arbiter # (
        .width (16),
        .select_width(4)
    ) arbiter (
        .enable(arbiter_enable),
        .req (arbiter_req),
        .grant (arbiter_grant),
        .select (arbiter_select),
        .valid (arbiter_valid),
        .clk(clk_in),
        .rst_n(hw_rstn)
    );

    reg port_sel;
    always @ (negedge hw_rstn or posedge clk_in) begin
        if (hw_rstn == 1'b0) begin
            port_sel <= 1'b0;
        end
        else if (arbiter_valid) begin
            port_sel <= arbiter_select[3];
        end
    end
*/

    sonic_arbiter_one # (
        .width(16),
        .select_width(4)
    ) arbiter (
        .rst_n(hw_rstn),
        .clk(clk_in),
        .req(arbiter_req),
        .grant(arbiter_grant),
        .select(arbiter_select),

        .tx_mask0(tx_mask0),
        .tx_stream_ready0(tx_stream_ready0),
        .pci_bus_master_enable((CHECK_BUS_MASTER_ENA==1)?cfg_prmcsr[2]:1'b1),
        .pci_tx_idle(pci_tx_idle),
        .pci_tx_idle_p0_tx_sel(pci_tx_idle_p0_tx_sel)
    );

    
    wire port_sel;
    assign port_sel = arbiter_select[3];

    assign tx_req0  = (port_sel == 1'b1) ? tx_req_p1 : tx_req_p0  ;
    assign tx_desc0 = (port_sel == 1'b1) ? tx_desc_p1: tx_desc_p0 ;
    assign tx_data0 = (port_sel == 1'b1) ? tx_data_p1: tx_data_p0 ;
    assign tx_dfr0  = (port_sel == 1'b1) ? tx_dfr_p1 : tx_dfr_p0  ;
    assign tx_dv0   = (port_sel == 1'b1) ? tx_dv_p1  : tx_dv_p0   ;
    assign tx_err0  = (port_sel == 1'b1) ? tx_err_p1 : tx_err_p0  ;
    
    //
    // Arbitration
    //

    // Port 0,
    sonic_single_port_logic #(
        .AVALON_WADDR           (AVALON_WADDR),
        .AVALON_WDATA           (AVALON_WDATA),
        .MAX_NUMTAG             (MAX_NUMTAG),
        .MAX_PAYLOAD_SIZE_BYTE  (MAX_PAYLOAD_SIZE_BYTE),
        .BOARD_DEMO             (BOARD_DEMO),
        .USE_CREDIT_CTRL        (USE_CREDIT_CTRL),
        .USE_DMAWRITE           (USE_DMAWRITE),
        .USE_DMAREAD            (USE_DMAREAD ),
        .USE_MSI                (USE_MSI),
        .CHECK_BUS_MASTER_ENA   (CHECK_BUS_MASTER_ENA),
        .RC_64BITS_ADDR         (RC_64BITS_ADDR),
        .CLK_250_APP            (CLK_250_APP),
        .TL_SELECTION           (TL_SELECTION),
        .INTENDED_DEVICE_FAMILY (INTENDED_DEVICE_FAMILY),
        .AVALON_ST_128          (AVALON_ST_128),
        .TXCRED_WIDTH           (TXCRED_WIDTH),
        .CDMA_AST_RXWS_LATENCY  (CDMA_AST_RXWS_LATENCY),
        .PORT_NUM               (0)
     ) sonic_port0 (
        .app_msi_ack (app_msi_ack),
        .app_msi_req (app_msi_req_p0),
        .app_msi_num (app_msi_num_p0),
        .app_msi_tc  (app_msi_tc_p0),

        .app_int_sts (app_int_sts_p0),             
        .app_int_ack (app_int_ack),

        .cfg_busdev  (cfg_busdev),
        .cfg_prmcsr  (cfg_prmcsr),
        .cfg_devcsr  (cfg_devcsr),
        .cfg_linkcsr (cfg_linkcsr),
        .cfg_tcvcmap (cfg_tcvcmap),
        .cfg_msicsr  (cfg_msicsr),

        .cpl_err                (cpl_err_p0),      
        .err_desc               (err_desc_p0),     
        .cpl_pending            (cpl_pending_p0),  
        .ko_cpl_spc_vc0         (ko_cpl_spc_vc0),
        .tx_mask0               (tx_mask0),
        .cpld_rx_buffer_ready   (cpld_rx_buffer_ready),
        .tx_cred0               (tx_cred0),
        .tx_stream_ready0       (tx_stream_ready0),

        .clk_in (clk_in),
        .hw_rstn (hw_rstn),  
        
        .xcvr_rx_clkout(xcvr_rx_clkout[0]),
        .xcvr_tx_clkout(xcvr_tx_clkout[0]),
        .xcvr_rx_dataout(xcvr_rx_dataout[39:0]),
        .xcvr_tx_datain(xcvr_tx_datain[39:0]),
        .pma_tx_ready(pma_tx_ready),
        .pma_rx_ready(pma_rx_ready),
        .reset_nios(reset_nios),		        //FIXME
        .set_lpbk(set_lpbk),                    //FIXME
        .unset_lpbk(unset_lpbk),                //FIXME

        .rx_req0    (rx_req0),
        .rx_ack0    (rx_ack_p0),
        .rx_data0   (rx_data0),
        .rx_be0     (rx_be0),
        .rx_desc0   (rx_desc0),
        .rx_dfr0    (rx_dfr0),
        .rx_dv0     (rx_dv0),
        .rx_ws0     (rx_ws_p0),                   
        .rx_mask0   (rx_mask_p0),                 
        .rx_ecrc_bad_cnt(rx_ecrc_bad_cnt),

        .rx_buffer_cpl_max_dw(rx_buffer_cpl_max_dw),

        .tx_req0    (tx_req_p0),
        .tx_ack0    (tx_ack0),
        .tx_desc0   (tx_desc_p0),
        .tx_data0   (tx_data_p0),
        .tx_dfr0    (tx_dfr_p0),
        .tx_dv0     (tx_dv_p0),
        .tx_err0    (tx_err_p0),
        .tx_ws0     (tx_ws0),

        .tx_rdy     (tx_rdy_p0),
        .arb_grant  (arbiter_grant[7:0]),
        .dma_tx_idle            (dma_tx_idle_p0),
        .dma_tx_idle_p0_tx_sel  (dma_tx_idle_p0_tx_sel_p0),
        .pci_tx_idle            (pci_tx_idle),
        .pci_tx_idle_p0_tx_sel  (pci_tx_idle_p0_tx_sel)

        );

    // Port 1

    sonic_single_port_logic #(
        .AVALON_WADDR           (AVALON_WADDR),
        .AVALON_WDATA           (AVALON_WDATA),
        .MAX_NUMTAG             (MAX_NUMTAG),
        .MAX_PAYLOAD_SIZE_BYTE  (MAX_PAYLOAD_SIZE_BYTE),
        .BOARD_DEMO             (BOARD_DEMO),
        .USE_CREDIT_CTRL        (USE_CREDIT_CTRL),
        .USE_DMAWRITE           (USE_DMAWRITE),
        .USE_DMAREAD            (USE_DMAREAD ),
        .USE_MSI                (USE_MSI),
        .CHECK_BUS_MASTER_ENA   (CHECK_BUS_MASTER_ENA),
        .RC_64BITS_ADDR         (RC_64BITS_ADDR),
        .CLK_250_APP            (CLK_250_APP),
        .TL_SELECTION           (TL_SELECTION),
        .INTENDED_DEVICE_FAMILY (INTENDED_DEVICE_FAMILY),
        .AVALON_ST_128          (AVALON_ST_128),
        .TXCRED_WIDTH           (TXCRED_WIDTH),
        .CDMA_AST_RXWS_LATENCY  (CDMA_AST_RXWS_LATENCY),
        .PORT_NUM               (1)
     ) sonic_port1 (
        .app_msi_ack (app_msi_ack),
        .app_msi_req (app_msi_req_p1),
        .app_msi_num (app_msi_num_p1),
        .app_msi_tc  (app_msi_tc_p1),

        .app_int_sts (app_int_sts_p1),
        .app_int_ack (app_int_ack),

        .cfg_busdev  (cfg_busdev),
        .cfg_prmcsr  (cfg_prmcsr),
        .cfg_devcsr  (cfg_devcsr),
        .cfg_linkcsr (cfg_linkcsr),
        .cfg_tcvcmap (cfg_tcvcmap),
        .cfg_msicsr  (cfg_msicsr),

        .cpl_err                (cpl_err_p1),
        .err_desc               (err_desc_p1),
        .cpl_pending            (cpl_pending_p1),
        .ko_cpl_spc_vc0         (ko_cpl_spc_vc0),
        .tx_mask0               (tx_mask0),
        .cpld_rx_buffer_ready   (cpld_rx_buffer_ready),
        .tx_cred0               (tx_cred0),
        .tx_stream_ready0       (tx_stream_ready0),

        .clk_in (clk_in),
        .hw_rstn (hw_rstn),  
        
        .xcvr_rx_clkout(xcvr_rx_clkout[1]),
        .xcvr_tx_clkout(xcvr_tx_clkout[1]),
        .xcvr_rx_dataout(xcvr_rx_dataout[79:40]),
        .xcvr_tx_datain(xcvr_tx_datain[79:40]),
        .pma_tx_ready(pma_tx_ready),
        .pma_rx_ready(pma_rx_ready),
/*
        .reset_nios(reset_nios),		
        .set_lpbk(set_lpbk),
        .unset_lpbk(unset_lpbk),
*/
        .reset_nios(),
        .set_lpbk(),
        .unset_lpbk(),

        .rx_req0    (rx_req0),
        .rx_ack0    (rx_ack_p1),
        .rx_data0   (rx_data0),
        .rx_be0     (rx_be0),
        .rx_desc0   (rx_desc0),
        .rx_dfr0    (rx_dfr0),
        .rx_dv0     (rx_dv0),
        .rx_ws0     (rx_ws_p1),
        .rx_mask0   (rx_mask_p1),
        .rx_ecrc_bad_cnt(rx_ecrc_bad_cnt),

        .rx_buffer_cpl_max_dw(rx_buffer_cpl_max_dw),

        .tx_req0    (tx_req_p1),
        .tx_ack0    (tx_ack0),
        .tx_desc0   (tx_desc_p1),
        .tx_data0   (tx_data_p1),
        .tx_dfr0    (tx_dfr_p1),
        .tx_dv0     (tx_dv_p1),
        .tx_err0    (tx_err_p1),
        .tx_ws0     (tx_ws0),
    
        // 8-bit bus req signals.
        .tx_rdy     (tx_rdy_p1),
        .arb_grant  (arbiter_grant[15:8]),
        .dma_tx_idle            (dma_tx_idle_p1),
        .dma_tx_idle_p0_tx_sel  (dma_tx_idle_p0_tx_sel_p1),
        .pci_tx_idle            (pci_tx_idle),
        .pci_tx_idle_p0_tx_sel  (pci_tx_idle_p0_tx_sel)

    );


endmodule
