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


//
// PMA-direct component for TGX-style transceiver architectures
//
// $Header$
//
`timescale 1 ps / 1 ps
module  siv_xcvr_low_latency_phy_nr
#(
   
    //reserved parameter, don't change them.
    parameter device_family="Stratix IV", 
    intended_device_variant ="ANY",
    
    //must have parameters
    parameter number_of_channels = 1,
    parameter number_of_reconfig_interface = 1,//it's number of quad for S4
    parameter operation_mode = "DUPLEX", //TX, RX, DUPLEX
    parameter phase_comp_fifo_mode = "NONE",//EMBEDDED, NONE 
    parameter serialization_factor = 16,//8,10,16,20,32,40
    parameter data_rate = "3125 Mbps",
    parameter pll_input_frequency = "156.25 MHz",
    
    //additonal system parameters
    parameter number_pll_inclks = 1,//reconfig may need more than one reference clock
    parameter pll_inclk_select = 0,//0-number_of_ref_clks
    parameter pll_type = "CMU",//ATX|CMU
    parameter bonded_mode = "TRUE",
    parameter starting_channel_number = 0,//0,4,8,12 ...
    parameter support_reconfig = 1,
    parameter rx_use_cruclk = "FALSE",
    
    //analog parameters
    parameter gx_analog_power = "AUTO",//AUTO|2.5v|3.0v|3.3v|3.9v
    
    parameter pll_lock_speed = "AUTO",//AUTO|LOW|MEDIUM|HIGH 
    parameter tx_analog_power = "AUTO",//AUTO|1.4V|1.5V 
    parameter tx_slew_rate = "LOW",//AUTO,LOW,MEDIUM,HIGH
    parameter tx_termination = "OCT_100_OHMS",//OCT_85_OHMS,OCT_100_OHMS,OCT_120_OHMS,OCT_150_OHMS                      
    parameter tx_common_mode = "0.65V",  //"0.65V"                              
    
    parameter rx_pll_lock_speed = "AUTO",//AUTO|LOW|MEDIUM|HIGH
    parameter rx_common_mode = "0.82v",  //TRISTATE|0.82v|1.1v                                
    parameter rx_signal_detect_threshold = 2,                       
    parameter rx_ppmselect = 32,                                         
    parameter rx_termination = "OCT_100_OHMS", //OCT_85_OHMS,OCT_100_OHMS,OCT_120_OHMS,OCT_150_OHMS                      
    
    parameter tx_preemp_pretap = 0,//0-7
    parameter tx_preemp_pretap_inv = "FALSE",//TRUE” or FALSE”. Determine whether the pre-emphasis control signal for the pretap needed to be inverted or not.“true” – Invert the pre-emphasis control signal for the pre tap.“false” – Do not invert the pre-emphasis control signal for the pretap.
    parameter tx_preemp_tap_1 = 5,//0-15
    parameter tx_preemp_tap_2 = 0,//0-7
    parameter tx_preemp_tap_2_inv = "FALSE",//TRUE” or FALSE”.
    parameter tx_vod_selection = 1,//0-7
    
    parameter rx_eq_dc_gain = 0, //0-4                                        
    parameter rx_eq_ctrl = 14,//0-16                                           
    
    parameter sys_clk_in_mhz = 150, // used to calculate reset controller delays as system clock cycle counts
    
    parameter loopback_mode = "NONE"//NONE|SLB|PLB|PRECDR_RSLB|POSTCDR_RSLB|RPLB
)
( 

   // user data (avalon-MM slave interface) //for all the channel rst, powerdown, rx serilize loopback enable
   input   wire         rst,
   input   wire         clk,
   input   wire	[5:0]	ch_mgmt_address,
   input   wire		ch_mgmt_read,
   output  wire	[31:0]	ch_mgmt_readdata,
   input   wire		ch_mgmt_write,
   input   wire	[31:0]	ch_mgmt_writedata,
   output  wire 	ch_mgmt_waitrequest,

   // avalon-ST interface with PMA controller
   input   wire		cal_blk_clk,
   input   wire		cal_blk_pdn,
   input   wire		gx_pdn,//sync with clk
   input    wire         tx_rst_digital, // digital reset
   input    wire         rx_rst_digital, // digital reset
   output    wire        tx_pma_ready, // pma tx pll_locked
   output    wire        rx_pma_ready, // pma rx pll is locked to data
 
   input   wire 	pll_pdn, //sync with clk
   output  wire 	pll_locked, //conduit
   
    // avalon-ST interface with reconfig controller
   input   wire			reconfig_clk,
   input   wire	  [3:0]		reconfig_to_gxb, //sync with reconfig_clk
   output  wire   [17* number_of_reconfig_interface -1:0]	reconfig_from_gxb, //sync with reconfig_clk. 17 bit per quad
//   input   wire	  [24 * number_of_reconfig_interface -1 : 0]		aeq_to_gxb, //sync with reconfig_clk
//   output  wire	  [8*number_of_reconfig_interface -1:0]		aeq_from_gxb,  //sync with reconfig_clk.
 

  //channel related avalon-clock interface
    input  wire	  [number_pll_inclks-1:0]	pll_ref_clk,
    input  wire	  [number_of_channels-1:0]	rx_cdr_ref_clk,

  //channel related avalon-ST interface, tx
    input   wire  [number_of_channels * serialization_factor -1:0]	tx_parallel_data,// sync with tx_clkout_clk
    output  wire  [number_of_channels-1:0]	tx_serial_data, // canduit 
    output  wire  [number_of_channels-1:0]	tx_out_clk,
	
  //channel related AVALON-st INTERFACE, rx
    input   wire  [number_of_channels-1:0]	rx_serial_data,//canduit
    output  wire  [number_of_channels * serialization_factor -1:0]	rx_parallel_data,// sync with rx_clkout_clk
    output  wire  [number_of_channels-1:0]	rx_recovered_clk,
	
    output  wire  [number_of_channels-1:0]	rx_is_lockedtodata,//conduit
    output  wire  [number_of_channels-1:0]	rx_is_lockedtoref,//conduit

    output  wire  [number_of_channels-1:0]	tx_digital_rst, // output digital reset for soft PCS, this reset can be controlled in AVMM
    output  wire  [number_of_channels-1:0]	rx_digital_rst // output digital reset for soft PCS, this reset can be controlled in AVMM

);

// instantiate package with common functions
import alt_pma_functions::*;

//derived parameters
localparam tx_inclk0_input_period_loc = freq2ps(pll_input_frequency) ;                         
localparam use6g= (((mega2k(data_rate) > 1000000) && ((serialization_factor == 32) || (serialization_factor == 40))) || ((serialization_factor != 8) && (serialization_factor != 10)))?  "TRUE" : "FALSE";                           
localparam pma_serialization_factor = (phase_comp_fifo_mode != "EMBEDDED") ? serialization_factor :
	((serialization_factor>20)? (serialization_factor/2): 
	((serialization_factor<16)? serialization_factor : 
	((use6g == "TRUE")? serialization_factor : serialization_factor /2))); 
//localparam RX_INCLK_INPUT_PERIOD_LOC = ( RX_INCLK_INPUT_PERIOD == 0) ? freq2ps(RX_pll_input_frequency) : RX_INCLK_INPUT_PERIOD;                         
//localparam rx_inclk_input_frequency_loc = ( operation_mode == "DUPLEX") ? ((RX_INCLK_INPUT_FREQUENCY == 0) ? INCLK_INPUT_FREQUENCY : RX_INCLK_INPUT_FREQUENCY) :0;                         
localparam double_serialization_mode=(serialization_factor/pma_serialization_factor == 2) ? "TRUE":"FALSE";                       
localparam rx_eqa_ctrl = (device_family=="Stratix IV") ? ((rx_eq_ctrl >10)? 7 :0) : ((rx_eq_ctrl >1)? 1:0);
localparam rx_eqb_ctrl = (device_family=="Stratix IV") ? ((rx_eq_ctrl >6)? 7 :0) : ((rx_eq_ctrl >3)? 1:0);
localparam rx_eqc_ctrl = (device_family=="Stratix IV") ? ((rx_eq_ctrl >3)? 7 :0) : 0;
localparam rx_eqd_ctrl = (device_family=="Stratix IV") ? ((rx_eq_ctrl >0)? 7 :0) : 0;
localparam rx_eqv_ctrl = (device_family=="Stratix IV") ? 
	((rx_eq_ctrl==2 | rx_eq_ctrl==5 | rx_eq_ctrl==8 | rx_eq_ctrl==13)? 4 :
	((rx_eq_ctrl==3 | rx_eq_ctrl==6 | rx_eq_ctrl==10 | rx_eq_ctrl==15)? 7 : 
	((rx_eq_ctrl==9 | rx_eq_ctrl==14 )? 5 :
	(rx_eq_ctrl==12)? 3 : 0))) :
	((rx_eq_ctrl==0 | rx_eq_ctrl==2 | rx_eq_ctrl==4 )? 1 :0 );
localparam number_of_ctrl_bus=(bonded_mode == "FALSE")? number_of_reconfig_interface : 1; 

localparam enable_lc_tx_pll_param = (pll_type == "CMU")? "FALSE" : "TRUE"; 
localparam enable_pma_direct_param = (phase_comp_fifo_mode == "EMBEDDED")? "FALSE":"TRUE"; 
localparam dwidth_factor = (use6g == "TRUE")? (double_serialization_mode == "TRUE" ? 4:2):(double_serialization_mode == "TRUE" ? 2:1); 
localparam reconfig_dprio_mode = (support_reconfig == 0)? 0 : 1;

localparam 	control_signal_width = (bonded_mode == "TRUE") ? 1: number_of_channels;
localparam pma_direct_xn = (phase_comp_fifo_mode == "NONE")? bonded_mode : "FALSE";
localparam pma_bonding = (phase_comp_fifo_mode == "EMBEDDED")? bonded_mode : "FALSE";

wire [control_signal_width-1:0] gxb_pdn_loc;
generate
genvar i;
for (i=0; i<control_signal_width; i=i+1) 
begin: gxb_pdn_bus
assign gxb_pdn_loc[i] = gx_pdn;
end 
endgenerate

wire [control_signal_width-1:0] pll_pdn_loc;
generate
genvar j;
for (j=0; j<control_signal_width; j=j+1) 
begin: pll_pdn_bus
assign pll_pdn_loc[j] = pll_pdn;
end 
endgenerate

wire [number_of_channels-1:0] rx_set_locktodata;
wire [number_of_channels-1:0] rx_set_locktoref;
 
wire [number_of_channels-1:0] rx_analog_rst;   
wire [number_of_channels-1:0] rx_seriallpbken;



alt4gxb #(
          .cbx_hdl_language             ("Verilog"),   
          .enable_pma_xn_bonding        (pma_direct_xn),
          .cmu_pll_inclk_log_index      (pll_inclk_select), 
          .cmu_pll_log_index            (0), 
          .device_family                (device_family),
          .intended_device_variant      (intended_device_variant), 
          .effective_data_rate          (data_rate), 
          .enable_lc_tx_pll             (enable_lc_tx_pll_param), 
          .enable_pma_direct            (enable_pma_direct_param), 
          .enable_pll_inclk_drive_rx_cru((rx_use_cruclk == "FALSE")? "TRUE" : "FALSE"), 
          .equalizer_ctrl_a_setting     (rx_eqa_ctrl), 
          .equalizer_ctrl_b_setting     (rx_eqb_ctrl), 
          .equalizer_ctrl_c_setting     (rx_eqc_ctrl), 
          .equalizer_ctrl_d_setting     (rx_eqd_ctrl), 
          .equalizer_ctrl_v_setting     (rx_eqv_ctrl), 
          .equalizer_dcgain_setting     (rx_eq_dc_gain), 
          .gen_reconfig_pll             ("FALSE"), 
          .gx_channel_type              ("AUTO"), 
          .gxb_analog_power             (gx_analog_power), 
          .gxb_powerdown_width          (control_signal_width), 
          .input_clock_frequency        (pll_input_frequency),                                                          
          .loopback_mode                (loopback_mode), 
          .number_of_channels           (number_of_channels), 
          .number_of_quads              (number_of_reconfig_interface), 
          .operation_mode               (operation_mode), 
          .pll_control_width            (number_of_ctrl_bus), 
          .protocol                     ("BASIC"), 
          .use_global_clk_divider       (pma_bonding),
          .receiver_termination         (rx_termination), 
          .reconfig_calibration         ("TRUE"), 
          .reconfig_dprio_mode          (reconfig_dprio_mode), 
          .reconfig_fromgxb_port_width  (17*number_of_reconfig_interface ), 
          .reconfig_pll_inclk_width     ((support_reconfig == 0)? 1: number_pll_inclks), 
          .reconfig_protocol            ("BASIC"), 
          .reconfig_togxb_port_width    (4),  
          .rx_use_cruclk                (rx_use_cruclk),
          .rx_channel_width             (serialization_factor), 
          .rx_common_mode               (rx_common_mode), 
          .rx_cru_bandwidth_type        (rx_pll_lock_speed), 
          .rx_digitalreset_port_width   (number_of_channels), 
          .rx_enable_lock_to_data_sig   ("true"), 
          .rx_enable_lock_to_refclk_sig ("true"), 
          .rx_ppmselect                 (rx_ppmselect), 
          .rx_reconfig_clk_scheme       ("indv_clk_source"),
          .rx_signal_detect_threshold   (rx_signal_detect_threshold), 
          .rx_use_clkout                ("TRUE"), 
          .rx_use_coreclk               ("false"),
          .rx_use_deserializer_double_data_mode(use6g), 
          .rx_use_double_data_mode      (double_serialization_mode), 
          .starting_channel_number      (starting_channel_number), 
          .transmitter_termination      (tx_termination),
          .tx_dwidth_factor             (dwidth_factor), 
          .tx_analog_power              (tx_analog_power), 
          .tx_channel_width             (serialization_factor), 
          .tx_clkout_width              (number_of_channels), 
          .tx_common_mode               (tx_common_mode), 
          .tx_pll_bandwidth_type        (pll_lock_speed), 
          .tx_pll_inclk0_period         (tx_inclk0_input_period_loc), 
          .tx_pll_type                  (pll_type), 
          .tx_reconfig_clk_scheme       ("tx_ch0_clk_source"), 
          .tx_slew_rate                 (tx_slew_rate), 
          .tx_transmit_protocol         ("basic"),
          .tx_use_coreclk               ("false"), 
          .tx_use_double_data_mode      (double_serialization_mode),
          .tx_use_serializer_double_data_mode       (use6g),
          .preemphasis_ctrl_pretap_setting          (tx_preemp_pretap),
          .preemphasis_ctrl_pretap_inv_setting      (tx_preemp_pretap_inv),
          .preemphasis_ctrl_1stposttap_setting      (tx_preemp_tap_1),
          .preemphasis_ctrl_2ndposttap_setting      (tx_preemp_tap_2),
          .preemphasis_ctrl_2ndposttap_inv_setting  (tx_preemp_tap_2_inv),
          .use_calibration_block        ("TRUE"), 
          .vod_ctrl_setting             (tx_vod_selection),
          .tx_digitalreset_port_width   (number_of_channels),
          .rx_use_align_state_machine   ("true"),//must have
          .tx_datapath_low_latency_mode ("true"),
          .rx_use_deskew_fifo           ("false"),
          .rx_word_aligner_num_byte     (2),
          .rx_rate_match_fifo_mode      ("none"),
          .tx_enable_bit_reversal       ("false"),
          .tx_enable_self_test_mode     ("false"),
          .tx_flip_tx_in                ("false"),
          .rx_dwidth_factor             (dwidth_factor),
          .rx_8b_10b_mode               ("none"),
          .rx_allow_align_polarity_inversion    ("false"),
          .rx_allow_pipe_polarity_inversion     ("false"),
          .tx_bitslip_enable            ("false"),
          .rx_bitslip_enable            ("true"),
          .rx_byte_ordering_mode        ("none"),
          .rx_enable_self_test_mode     ("false"),
          .rx_flip_rx_out               ("false"),
          .rx_force_signal_detect       ("true"),
          .rx_phfiforegmode             ("false"),
          .rx_datapath_low_latency_mode ("true"),
          .rx_datapath_protocol         ("basic"),
          .rx_enable_bit_reversal       ("false"),
          .rx_enable_deep_align_byte_swap("false")
        ) pma_direct ( 
            .cal_blk_clk            (cal_blk_clk), 
            .cal_blk_powerdown      (cal_blk_pdn), 
            .gxb_powerdown          (gxb_pdn_loc), 
            .pll_inclk(pll_ref_clk),
            //.pll_inclk_rx_cruclk((support_reconfig == 0)? 0 : pll_ref_clk),
            .rx_cruclk              ((rx_use_cruclk == "TRUE")? rx_cdr_ref_clk[number_of_channels - 1:0] : {number_of_channels{1'b0}}),
            .pll_locked             (pll_locked), 
            .pll_powerdown          (pll_pdn_loc), 
            .reconfig_clk           (reconfig_clk), 
            .reconfig_fromgxb       (reconfig_from_gxb), 
            .reconfig_togxb         (reconfig_to_gxb), 
            .rx_analogreset         (rx_analog_rst[number_of_channels-1:0]), 
            .rx_seriallpbken        ((loopback_mode == "SLB")? rx_seriallpbken[number_of_channels-1:0] : 0),  
            .tx_digitalreset        ((phase_comp_fifo_mode == "EMBEDDED")? tx_digital_rst[number_of_channels-1:0] : {number_of_channels{1'b0}}),  
            .rx_digitalreset        ((phase_comp_fifo_mode == "EMBEDDED")? rx_digital_rst[number_of_channels-1:0] : {number_of_channels{1'b0}}),    
            .rx_clkout              (rx_recovered_clk[number_of_channels-1:0]), 
            .rx_datain              (rx_serial_data[number_of_channels-1:0]), 
            .rx_dataout             (rx_parallel_data[serialization_factor * number_of_channels-1:0]), 
            .rx_freqlocked          (rx_is_lockedtodata[number_of_channels-1:0]), 
            .rx_locktodata          (rx_set_locktodata[number_of_channels-1:0]), 
            .rx_locktorefclk        (rx_set_locktoref[number_of_channels-1:0]), 
            .rx_pll_locked          (rx_is_lockedtoref[number_of_channels-1:0]), 
            .tx_clkout              (tx_out_clk[number_of_channels-1:0]), 
            .tx_datain              (tx_parallel_data[serialization_factor * number_of_channels-1:0]), 
            .tx_dataout             (tx_serial_data[number_of_channels-1:0]) 
    );

alt_pma_ch_controller_tgx #(
    .number_of_channels     (number_of_channels),
    .sys_clk_in_mhz         (sys_clk_in_mhz),
    .sync_depth             (2)
) channel_ctrl (
    .rst(rst),
    .tx_rst_digital     (tx_rst_digital), // tx_digitalreset
    .rx_rst_digital     (rx_rst_digital), // rx_digitalreset
    .tx_pma_ready       (tx_pma_ready), // pma tx pll_locked
    .rx_pma_ready       (rx_pma_ready), // pma rx pll is locked to data
    .rx_oc_busy         (reconfig_to_gxb[3]), // rx_ocilator busy
    .pll_locked         (pll_locked), // tx pll_is_locked

    .ch_mgmt_address    (ch_mgmt_address),
    .ch_mgmt_read       (ch_mgmt_read),
    .ch_mgmt_readdata   (ch_mgmt_readdata),
    .ch_mgmt_write      (ch_mgmt_write),
    .ch_mgmt_writedata  (ch_mgmt_writedata),
    .clk                (clk),
    .ch_mgmt_waitrequest(ch_mgmt_waitrequest),
    
    .rx_is_lockedtodata (rx_is_lockedtodata),
    .rx_is_lockedtoref  (rx_is_lockedtoref),
    
    .rx_set_locktodata  (rx_set_locktodata),
    .rx_set_locktoref   (rx_set_locktoref),
    
    .rx_analog_rst      (rx_analog_rst),
    .rx_seriallpbken    (rx_seriallpbken),
    .tx_digital_rst     (tx_digital_rst),
    .rx_digital_rst     (rx_digital_rst)
);

endmodule
