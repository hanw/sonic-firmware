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

//% This file is used for xcvr simulation purpose only, it uses the
//% alt_pma_10gbaser_tgx to workaround the 'alt4gxb not found' problem.
//% In addition, we commented out a few extra signals to get the simulation
//% run.

`timescale 1ps/1ps

import altera_xcvr_functions::*;

module altera_xcvr_low_latency_phy_sim
#(
    
    // alt_pma
    parameter device_family="Stratix V", 
    parameter intended_device_variant ="ANY",
    parameter operation_mode = "DUPLEX",
    parameter lanes = 1,
    parameter bonded_mode = "FALSE",
    parameter serialization_factor = 8,
    parameter pll_type = "CMU",
    parameter data_rate = "3125 Mbps",
    parameter base_data_rate = "0 Mbps",
    parameter pll_refclk_freq = "156.25 MHz",
    parameter bonded_group_size = 1,
    parameter select_10g_pcs = 0,
    parameter tx_use_coreclk = 0,
    parameter rx_use_coreclk = 0,
    parameter tx_bitslip_enable = 0,
    parameter tx_bitslip_width = 5,
    parameter rx_bitslip_enable = 0,
    parameter phase_comp_fifo_mode = "NONE",
    parameter loopback_mode = "NONE",
    parameter use_double_data_mode = "false",
    parameter mgmt_clk_in_mhz = 150,
    
    //stratix IV only parameters
    parameter gxb_analog_power = "AUTO",
    parameter pll_lock_speed = "AUTO",
    parameter tx_analog_power = "AUTO",
    parameter tx_slew_rate = "LOW",
    parameter tx_termination = "OCT_100_OHMS",
    parameter tx_preemp_pretap = 0,
    parameter tx_preemp_pretap_inv = "FALSE",
    parameter tx_preemp_tap_1 = 5,
    parameter tx_preemp_tap_2 = 0,
    parameter tx_preemp_tap_2_inv = "FALSE",
    parameter tx_vod_selection = 1,
    parameter tx_common_mode = "0.65V",
    parameter rx_pll_lock_speed = "AUTO",
    parameter rx_common_mode = "0.82v",
    parameter rx_termination = "OCT_100_OHMS",
    parameter rx_eq_dc_gain = 0,
    parameter rx_eq_ctrl = 14,
    
    //Reconfig parameters
    parameter starting_channel_number = 0,
    parameter pll_refclk_cnt = 1,
    parameter plls = 1
    
) 
(
    // user data (avalon-MM slave interface)
    input   wire            phy_mgmt_clk,
    input   tri0            phy_mgmt_clk_reset,
    input   wire    [8:0]   phy_mgmt_address,
    input   tri1            phy_mgmt_read,
    output  wire    [31:0]  phy_mgmt_readdata,
    output  wire            phy_mgmt_waitrequest,
    input   tri0            phy_mgmt_write,
    input   wire    [31:0]  phy_mgmt_writedata,
    
    output  wire    tx_ready,
    output  wire    rx_ready,    
    
    input   wire    [plls-1:0]      pll_ref_clk,
    output  wire    [plls-1:0]      pll_locked,
    
    output  wire    [lanes-1:0]     tx_serial_data,
    input   wire    [lanes-1:0]     rx_serial_data,
    
    output  wire    [lanes-1:0]     rx_is_lockedtodata,
    output  wire    [lanes-1:0]     rx_is_lockedtoref,
    
    input  wire     [lanes-1:0]     tx_coreclkin,
    input  wire     [lanes-1:0]     rx_coreclkin,
    
    output  wire    [lanes-1:0]     tx_clkout,
    output  wire    [lanes-1:0]     rx_clkout,
    
    input   wire  [lanes * serialization_factor -1:0]  tx_parallel_data,
    output  wire  [lanes * serialization_factor -1:0]  rx_parallel_data,
    
    input   wire  [get_custom_reconfig_to_width  (device_family,operation_mode,lanes,plls,bonded_group_size)-1:0] reconfig_to_xcvr,
    output  wire  [get_custom_reconfig_from_width(device_family,operation_mode,lanes,plls,bonded_group_size)-1:0] reconfig_from_xcvr,
    
    input   tri0  [lanes*tx_bitslip_width-1:0]         tx_bitslip,
    input   tri0  [lanes-1:0]                          rx_bitslip,

	input wire [lanes-1:0]		tx_rst_digital,
	input wire [lanes-1:0]		rx_rst_digital,
	output wire [lanes-1:0]		tx_digital_rst,
	output wire [lanes-1:0]		rx_digital_rst
);



localparam is_s5 = has_s5_style_hssi(device_family);
localparam is_s4 = has_s4_style_hssi(device_family);
localparam is_c4 = has_c4_style_hssi(device_family);

localparam address_width = 9;
localparam data_width = 32;
localparam pll_inclk_select = 0;

//reconfiguration
localparam reconfig_interfaces  = get_custom_reconfig_interfaces("Stratix V",operation_mode,lanes,plls,bonded_group_size);
localparam enable_pma_direct = (!is_s5) && (phase_comp_fifo_mode != "EMBEDDED");
localparam siv_reconfig_interfaces = (enable_pma_direct)? lanes : ((lanes % 4) == 0) ? lanes/4 : lanes/4 + 1;
    

//wire declaration
wire            pma_mgmt_read;
wire    [data_width-1:0]  pma_mgmt_readdata;
wire            pma_mgmt_write;
wire            pma_mgmt_waitrequest;

wire            pma_controller_mgmt_read;
wire    [data_width-1:0]  pma_controller_mgmt_readdata;
wire            pma_controller_mgmt_write;
wire            pma_controller_mgmt_waitrequest;

wire            reconfig_mgmt_read;
wire    [data_width-1:0]  reconfig_mgmt_readdata;
wire            reconfig_mgmt_write;
wire            reconfig_mgmt_waitrequest;


wire    pma_cal_blk_pdn;
wire    pma_controller_cal_blk_pdn;
wire    pma_gx_pdn;
wire    pma_controller_gx_pdn;
wire    pma_pll_pdn;
wire    pma_controller_pll_pdn;
wire    pma_pll_locked;
wire    pma_controller_pll_locked;

wire    [3:0]   siv_pma_reconfig_to_gxb;
wire    [3:0]   siv_reconfig_reconfig_to_gxb;
wire    [17*siv_reconfig_interfaces-1:0]      siv_reconfig_reconfig_from_gxb;
wire    [17*siv_reconfig_interfaces-1:0]      siv_pma_reconfig_from_gxb;
wire    [24*siv_reconfig_interfaces-1 : 0]    siv_pma_aeq_to_gxb;
wire    [8*siv_reconfig_interfaces-1:0]       siv_reconfig_aeq_from_gxb;

//register declaration
generate
    if (is_s5)
    begin
        sv_xcvr_low_latency_phy_nr
        #(
            //common parameters
            .device_family                  (device_family), 
            .intended_device_variant        (intended_device_variant),
            
            //must have parameters
            .lanes                          (lanes),
            .operation_mode                 (operation_mode),
            .phase_comp_fifo_mode           (phase_comp_fifo_mode),
            .serialization_factor           (serialization_factor),
            .data_rate                      (data_rate),
            .base_data_rate                 (base_data_rate),
            .pll_refclk_freq                (pll_refclk_freq),
            
            //additonal system parameters
            .sys_clk_in_mhz                 (mgmt_clk_in_mhz),
            .plls                           (plls),
            .pll_refclk_cnt                 (pll_refclk_cnt),
            .starting_channel_number        (starting_channel_number),
            
            //Stratix V specific parameter
            .bonded_group_size      (bonded_group_size),
            .tx_use_coreclk         (tx_use_coreclk),
            .rx_use_coreclk         (rx_use_coreclk),
            .tx_bitslip_en          (tx_bitslip_enable),
	    .tx_bitslip_width       (tx_bitslip_width),
            .rx_bitslip_en          (rx_bitslip_enable),
            .select_10g_pcs         (select_10g_pcs),
            .use_double_data_mode   (use_double_data_mode)
        )
        sv_xcvr_low_latency_phy_nr_inst
        (
            // user data (avalon-MM slave interface) 
            .rst                (phy_mgmt_clk_reset),
            .clk                (phy_mgmt_clk),
            .ch_mgmt_address    (phy_mgmt_address[5:0]),
            .ch_mgmt_read       (pma_mgmt_read),
            .ch_mgmt_readdata   (pma_mgmt_readdata),
            .ch_mgmt_write      (pma_mgmt_write),
            .ch_mgmt_writedata  (phy_mgmt_writedata),
            .ch_mgmt_waitrequest(pma_mgmt_waitrequest),
                
            // avalon-ST interface with PMA controller
            .gx_pdn             (pma_gx_pdn),
            .tx_rst_digital     ({1'b0}),
            .rx_rst_digital     ({1'b0}),
            .tx_pma_ready       (tx_ready),
            .rx_pma_ready       (rx_ready),    
            .pll_pdn            (pma_pll_pdn),
            .pll_locked         (pma_pll_locked),
                
            //channel related avalon-clock interface
            .pll_ref_clk        (pll_ref_clk),
            .tx_coreclk         (tx_coreclkin),
            .rx_coreclk         (rx_coreclkin),
                
            //channel related avalon-ST interface, tx
            .tx_parallel_data   (tx_parallel_data),
            .tx_serial_data     (tx_serial_data),
            .tx_clkout          (tx_clkout),
            .tx_bitslip         (tx_bitslip),
                
            //channel related AVALON-st INTERFACE, rx
            .rx_serial_data             (rx_serial_data),
            .rx_parallel_data           (rx_parallel_data),
            .rx_clkout                  (rx_clkout),
            .rx_parallel_data_read      ({lanes{1'b0}}),
            .rx_bitslip                 (rx_bitslip),
            .rx_is_lockedtodata         (rx_is_lockedtodata),
            .rx_is_lockedtoref          (rx_is_lockedtoref),
	    
            //reconfig port
            .reconfig_to_xcvr           (reconfig_to_xcvr),
            .reconfig_from_xcvr         (reconfig_from_xcvr),
          
            //reset_output from channel controller
            .tx_digital_rst     (),
            .rx_digital_rst     ()

        );
    end
    else if (is_s4 || is_c4)
    begin
        siv_xcvr_low_latency_phy_nr
//		alt_pma_10gbaser_tgx
        #(
            //common parameters
            .device_family              (device_family), 
            .intended_device_variant    (intended_device_variant),
            
            //must have parameters
            .number_of_channels             (lanes),

			//commented for sim
            //.number_of_reconfig_interface   (siv_reconfig_interfaces),
            .operation_mode                 (operation_mode),
            .phase_comp_fifo_mode           (phase_comp_fifo_mode),
            .serialization_factor           (serialization_factor),
            .data_rate                      (data_rate),
            .pll_input_frequency            (pll_refclk_freq),
            
            //additonal system parameters
            .sys_clk_in_mhz         (mgmt_clk_in_mhz),
            .number_pll_inclks      (pll_refclk_cnt),
            .pll_inclk_select       (pll_inclk_select),
            .pll_type               (pll_type),
            .bonded_mode            (bonded_mode),
            .starting_channel_number(starting_channel_number),
            .support_reconfig       (1),
            .rx_use_cruclk          ("FALSE"),
            
            //Stratix V specific parameter
            //bonded_group_size = 1, //legal values: 1+
            .loopback_mode          (loopback_mode),
            
            //stratix IV only parameters
            //analog control
            .gx_analog_power            (gxb_analog_power),
            .pll_lock_speed             (pll_lock_speed),
            .tx_analog_power            (tx_analog_power),
            .tx_slew_rate               (tx_slew_rate),
            .tx_termination             (tx_termination),
            .tx_common_mode             (tx_common_mode),
            .rx_pll_lock_speed          (rx_pll_lock_speed),
            .rx_common_mode             (rx_common_mode),
            .rx_signal_detect_threshold (2),
            .rx_ppmselect               (32),
            .rx_termination             (rx_termination),
            .tx_preemp_pretap           (tx_preemp_pretap),
            .tx_preemp_pretap_inv       (tx_preemp_pretap_inv),
            .tx_preemp_tap_1            (tx_preemp_tap_1),
            .tx_preemp_tap_2            (tx_preemp_tap_2),
            .tx_preemp_tap_2_inv        (tx_preemp_tap_2_inv),
            .tx_vod_selection           (tx_vod_selection),
            .rx_eq_dc_gain              (rx_eq_dc_gain),
            .rx_eq_ctrl                 (rx_eq_ctrl)
        ) 
        siv_xcvr_low_latency_phy_nr_inst 
        (
            // user data (avalon-MM slave interface) 
            .rst                (phy_mgmt_clk_reset),
            .clk                (phy_mgmt_clk),
            .ch_mgmt_address    (phy_mgmt_address[5:0]),
            .ch_mgmt_read       (pma_mgmt_read),
            .ch_mgmt_readdata   (pma_mgmt_readdata),
            .ch_mgmt_write      (pma_mgmt_write),
            .ch_mgmt_writedata  (phy_mgmt_writedata),
            .ch_mgmt_waitrequest(pma_mgmt_waitrequest),
                
            // avalon-ST interface with PMA controller
            .cal_blk_clk        (phy_mgmt_clk),
            .cal_blk_pdn        (pma_cal_blk_pdn),
            .gx_pdn             (pma_gx_pdn),
            .tx_rst_digital     (tx_rst_digital),
            .rx_rst_digital     (rx_rst_digital),
            .tx_pma_ready       (tx_ready),
            .rx_pma_ready       (rx_ready),    
            .pll_pdn            (pma_pll_pdn),
            .pll_locked         (pma_pll_locked),
                
            //channel related avalon-clock interface
            .pll_ref_clk        (pll_ref_clk),
			// commented for sim
            //.rx_cdr_ref_clk     ({lanes{pll_ref_clk[0]}}),
                
            //channel related avalon-ST interface, tx
            .tx_parallel_data   (tx_parallel_data),
            .tx_serial_data     (tx_serial_data),
            .tx_out_clk         (tx_clkout),
                
            //channel related AVALON-st INTERFACE, rx
            .rx_serial_data         (rx_serial_data),
            .rx_parallel_data       (rx_parallel_data),
            .rx_recovered_clk       (rx_clkout),
            .rx_is_lockedtodata     (rx_is_lockedtodata),
            .rx_is_lockedtoref      (rx_is_lockedtoref),

            //reset_output from channel controller
            .tx_digital_rst         (tx_digital_rst),
            .rx_digital_rst         (rx_digital_rst),
            
            //reconfiguration port
            .reconfig_clk           (phy_mgmt_clk),
            .reconfig_to_gxb        (siv_pma_reconfig_to_gxb),
            .reconfig_from_gxb      (siv_pma_reconfig_from_gxb)

		  // Commented for simulation
		  //  ,
          //  .aeq_to_gxb             (/*UNUSED*/),
          //  .aeq_from_gxb           (/*UNUSED*/)
        );
    end
    else	// unsupported family
    begin
        initial 
        begin
            $display("Critical Warning: device_family value, '%s', is not supported", current_device_family(device_family));
        end
    end
endgenerate

generate
    if (is_s4)
    begin
        alt_xcvr_reconfig_siv
        #(
            .number_of_reconfig_interfaces(siv_reconfig_interfaces) 
        )
        siv_reco
        (
            .mgmt_clk_clk               (phy_mgmt_clk),
            .mgmt_rst_reset             (phy_mgmt_clk_reset),
            .reconfig_mgmt_address      (phy_mgmt_address[6:0]),
            .reconfig_mgmt_waitrequest  (reconfig_mgmt_waitrequest),
            .reconfig_mgmt_read         (reconfig_mgmt_read),
            .reconfig_mgmt_readdata     (reconfig_mgmt_readdata),
            .reconfig_mgmt_write        (reconfig_mgmt_write),
            .reconfig_mgmt_writedata    (phy_mgmt_writedata),
            .reconfig_done              (),
            .reconfig_togxb             (siv_reconfig_reconfig_to_gxb),
            .reconfig_fromgxb           (siv_reconfig_reconfig_from_gxb)
        );
    end
    else if (is_c4)
    begin
        alt_xcvr_reconfig_civ
        #(
            .number_of_reconfig_interfaces(siv_reconfig_interfaces)
        )
        civ_reco 
        (
            .reconfig_mgmt_clk_clk      (phy_mgmt_clk),
            .reconfig_mgmt_rst_reset    (phy_mgmt_clk_reset),
            
            // user reconfiguration management interface
            .reconfig_mgmt_address      (phy_mgmt_address[6:0]),
            .reconfig_mgmt_waitrequest  (reconfig_mgmt_waitrequest),
            .reconfig_mgmt_read         (reconfig_mgmt_read),
            .reconfig_mgmt_readdata     (reconfig_mgmt_readdata),
            .reconfig_mgmt_write        (reconfig_mgmt_write),
            .reconfig_mgmt_writedata    (phy_mgmt_writedata),
            .reconfig_done              (),            
            .reconfig_togxb             (siv_reconfig_reconfig_to_gxb),
            .reconfig_fromgxb           (siv_reconfig_reconfig_from_gxb)
        );
    end
    else 	// unsupported family
    begin
        if(!is_s5)
        begin
            initial begin
                $display("Critical Warning: device_family value, '%s', is not supported", current_device_family(device_family));
            end
        end

        assign reconfig_mgmt_waitrequest = 1'd0;
        assign reconfig_mgmt_readdata = 32'd0;
    end
endgenerate

alt_pma_controller_tgx 
#(
    .number_of_plls         (plls),
    .sys_clk_in_mhz         (mgmt_clk_in_mhz)
)
pma_ctrl 
(
    .clk                    (phy_mgmt_clk),
    .rst                    (phy_mgmt_clk_reset),
    .tx_pll_ready           (),
       
    // user data (avalon-MM formatted) 
    .pma_mgmt_address       (phy_mgmt_address[1:0]),
    .pma_mgmt_read          (pma_controller_mgmt_read),
    .pma_mgmt_readdata      (pma_controller_mgmt_readdata),
    .pma_mgmt_write         (pma_controller_mgmt_write),
    .pma_mgmt_writedata     (phy_mgmt_writedata),
    .pma_mgmt_waitrequest   (pma_controller_mgmt_waitrequest),
       
    // user data (avalon-clock formatted) 
    .cal_blk_clk            (phy_mgmt_clk),
        
    // user data: pll control (avalon-ST formatted)
    .cal_blk_pdn            (pma_controller_cal_blk_pdn),
    .gx_pdn                 (pma_controller_gx_pdn),
    .pll_pdn                (pma_controller_pll_pdn),
    .pll_locked             (pma_controller_pll_locked)
);


generate
    if((operation_mode != "RX") && (operation_mode != "Rx") && (operation_mode != "rx"))
    begin
        assign pma_controller_pll_locked = pma_pll_locked;
    end
    else
    begin
        assign pma_controller_pll_locked = 1'b1;
    end
endgenerate

///////////////////////////////////////////////////////////////////////
// Decoder for multiple slaves of Low latency phy_mgmt interface
///////////////////////////////////////////////////////////////////////
localparam arb_pma_controller = 0;
localparam arb_pma = 1;
localparam arb_reconfig = 2;
localparam arb_count = 3;         // total decodes is 3

wire [arb_count-1:0] r_decode;   // 3 decoder enable values, indexed as above

//  memory map address mapping, in word addresses (already drops 2 lower byte address bits)
//  alt_pma_controller base address   = 9'h020 to 9'h03f
//  alt_pma (reset + ch) base address = 9'h040 to 9'h07f
//  alt_xcvr_reconfig base address    = 9'h100 to 9'h1ff
assign r_decode = 
			  (phy_mgmt_address[8:5] == 4'b0001) ? (3'b001 << arb_pma_controller)
			: (phy_mgmt_address[8:6] == 3'b001)  ? (3'b001 << arb_pma)
			: (phy_mgmt_address[8]   == 1'b1)    ? (3'b001 << arb_reconfig)
			: {arb_count{1'b0}};

assign phy_mgmt_readdata = pma_controller_mgmt_readdata & {32{r_decode[arb_pma_controller]}}
							| pma_mgmt_readdata & {32{r_decode[arb_pma]}}
							| reconfig_mgmt_readdata & {32{r_decode[arb_reconfig]}};

assign phy_mgmt_waitrequest = pma_controller_mgmt_waitrequest & r_decode[arb_pma_controller]
							| pma_mgmt_waitrequest & r_decode[arb_pma]
							| reconfig_mgmt_waitrequest & r_decode[arb_reconfig];

// read controls
assign pma_controller_mgmt_read = phy_mgmt_read & r_decode[arb_pma_controller];
assign pma_mgmt_read = phy_mgmt_read & r_decode[arb_pma];

generate
    if(!is_s5)
    begin
        assign reconfig_mgmt_read = phy_mgmt_read & r_decode[arb_reconfig];
        assign reconfig_mgmt_write = phy_mgmt_write & r_decode[arb_reconfig];
    end
endgenerate

// write controls
assign pma_controller_mgmt_write = phy_mgmt_write & r_decode[arb_pma_controller];
assign pma_mgmt_write = phy_mgmt_write & r_decode[arb_pma];


///////////////////////////////////////////////////////////////////////
// Misc conenctions
///////////////////////////////////////////////////////////////////////

assign pma_gx_pdn                       = pma_controller_gx_pdn;
assign pma_pll_pdn                      = pma_controller_pll_pdn;
assign pll_locked                       = pma_pll_locked;

generate
    if (is_s4 || is_c4)
    begin
        assign pma_cal_blk_pdn = pma_controller_cal_blk_pdn;
    end
    
    if (is_s4)
    begin
        assign siv_reconfig_reconfig_from_gxb   = siv_pma_reconfig_from_gxb; 
        assign siv_pma_reconfig_to_gxb          = siv_reconfig_reconfig_to_gxb;
    end
endgenerate

endmodule

