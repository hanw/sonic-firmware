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


// (C) 2001-2010 Altera Corporation. All rights reserved.
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
module  alt_pma_10gbaser_tgx
#(
   parameter
	//reserved parameter, don't change them.
	device_family="Stratix IV", 
	intended_device_variant ="GT",
	//must have parameters
	number_of_channels = 1,
	operation_mode = "DUPLEX", //TX, RX, DUPLEX
	phase_comp_fifo_mode = "EMBEDDED",//EMBEDDED, NONE 
	serialization_factor = 40,//8,10,16,20,32,40
	data_rate = "10312.5 Mbps",
	pll_input_frequency = "644.53125 MHz",
	
	//additonal system parameters
	number_pll_inclks = 1,//reconfig may need more than one reference clock
	pll_inclk_select = 0,//0-number_of_ref_clks
	pll_type = "CMU",//ATX|CMU
	bonded_mode = "FALSE",
	starting_channel_number = 0,//0,4,8,12 ...
	support_reconfig = 1,
	rx_use_cruclk = "FALSE",
	
	//analog parameters
	gx_analog_power = "AUTO",//AUTO|2.5v|3.0v|3.3v|3.9v
	
	pll_lock_speed = "AUTO",//AUTO|LOW|MEDIUM|HIGH 
	tx_analog_power = "AUTO",//AUTO|1.4V|1.5V 
	tx_slew_rate = "LOW",//AUTO,LOW,MEDIUM,HIGH
	tx_termination = "OCT_100_OHMS",//OCT_85_OHMS,OCT_100_OHMS,OCT_120_OHMS,OCT_150_OHMS                      
	tx_common_mode = "0.65V",  //"0.65V"                              
	
	rx_pll_lock_speed = "AUTO",//AUTO|LOW|MEDIUM|HIGH
	rx_common_mode = "0.82v",  //TRISTATE|0.82v|1.1v                                
	rx_signal_detect_threshold = 2,                       
	rx_ppmselect = 32,                                         
	rx_termination = "OCT_100_OHMS", //OCT_85_OHMS,OCT_100_OHMS,OCT_120_OHMS,OCT_150_OHMS                      
	
	tx_preemp_pretap = 0,//0-7
	tx_preemp_pretap_inv = "FALSE",//?TRUE? or ?FALSE?. Determine whether the pre-emphasis control signal for the pretap needed to be inverted or not.?true? ? Invert the pre-emphasis control signal for the pre tap.?false? ? Do not invert the pre-emphasis control signal for the pretap.
	tx_preemp_tap_1 = 5,//0-15
	tx_preemp_tap_2 = 0,//0-7
	tx_preemp_tap_2_inv = "FALSE",//?TRUE? or ?FALSE?.
	tx_vod_selection = 1,//0-7
	
	rx_eq_dc_gain = 0, //0-4                                        
	rx_eq_ctrl = 14,//0-16                                           
	
	sys_clk_in_mhz = 150, // used to calculate reset controller delays as system clock cycle counts
	reconfig_interfaces = 1,
	loopback_mode = "NONE"//NONE|SLB|PLB|PRECDR_RSLB|POSTCDR_RSLB|RPLB
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
   output  wire   [17* number_of_channels -1:0]	reconfig_from_gxb, //sync with reconfig_clk. 17 bit per quad
//   input   wire	  [24 * number_of_reconfig_interface -1 : 0]		aeq_to_gxb, //sync with reconfig_clk
//   output  wire	  [8*number_of_reconfig_interface -1:0]		aeq_from_gxb,  //sync with reconfig_clk.
 

  //channel related avalon-clock interface
    input  wire	  [number_pll_inclks-1:0]	pll_ref_clk,
 
  //channel related avalon-ST interface, tx
    input   wire  [number_of_channels * serialization_factor -1:0]	tx_parallel_data,// sync with tx_clkout_clk
    output  wire  [number_of_channels-1:0]	tx_serial_data, // canduit 
    output  wire  [number_of_channels-1:0]	tx_out_clk,
	
  //channel related AVALON-st INTERFACE, rx
    input   wire  [number_of_channels-1:0]	rx_serial_data,//canduit
    output  wire  [number_of_channels * serialization_factor -1:0]	rx_parallel_data,// sync with rx_clkout_clk
    output  wire  [number_of_channels-1:0]	rx_recovered_clk,

    output  wire  [number_of_channels-1:0] tx_digital_rst,
    output  wire  [number_of_channels-1:0] rx_digital_rst,

	
    output  wire  [number_of_channels-1:0]	rx_is_lockedtodata,//conduit
    output  wire  [number_of_channels-1:0]	rx_is_lockedtoref//conduit
);



   siv_xcvr_low_latency_phy_nr #(
	.device_family(device_family), 
	.intended_device_variant(intended_device_variant),
	.number_of_channels (number_of_channels),
	.operation_mode(operation_mode), //TX, RX, DUPLEX
	.phase_comp_fifo_mode (phase_comp_fifo_mode),//EMBEDDED, NONE 
	.serialization_factor (serialization_factor),//8,10,16,20,32,40
	.data_rate(data_rate),
	.pll_input_frequency (pll_input_frequency),
	
	//additonal system parameters
	.number_pll_inclks (number_pll_inclks),//reconfig may need more than one reference clock
	.pll_inclk_select (pll_inclk_select),//0-number_of_ref_clks
	.pll_type (pll_type),//ATX|CMU
	.bonded_mode (bonded_mode),
	.starting_channel_number (starting_channel_number),//0,4,8,12 ...
	.support_reconfig (support_reconfig),
	.rx_use_cruclk ( rx_use_cruclk),
	.number_of_reconfig_interface(reconfig_interfaces),
	//analog parameters
	.gx_analog_power (gx_analog_power),//AUTO|2.5v|3.0v|3.3v|3.9v
	
	.pll_lock_speed (pll_lock_speed),//AUTO|LOW|MEDIUM|HIGH 
	.tx_analog_power (tx_analog_power),//AUTO|1.4V|1.5V 
	.tx_slew_rate (tx_slew_rate),//AUTO,LOW,MEDIUM,HIGH
	.tx_termination (tx_termination),//OCT_85_OHMS,OCT_100_OHMS,OCT_120_OHMS,OCT_150_OHMS                      
	.tx_common_mode(tx_common_mode),  //"0.65V"                              
	
	.rx_pll_lock_speed (rx_pll_lock_speed),//AUTO|LOW|MEDIUM|HIGH
	.rx_common_mode(rx_common_mode),  //TRISTATE|0.82v|1.1v                                
	.rx_signal_detect_threshold ( rx_signal_detect_threshold),                       
	.rx_ppmselect (rx_ppmselect),                                         
	.rx_termination (rx_termination), //OCT_85_OHMS,OCT_100_OHMS,OCT_120_OHMS,OCT_150_OHMS                      
	
	.tx_preemp_pretap (tx_preemp_pretap),//0-7
       	.tx_preemp_pretap_inv((tx_preemp_pretap_inv==1)? "TRUE" : "FALSE"),
	.tx_preemp_tap_1 (tx_preemp_tap_1),//0-15
	.tx_preemp_tap_2 (tx_preemp_tap_2),//0-7
       	.tx_preemp_tap_2_inv((tx_preemp_tap_2_inv==1)? "TRUE" : "FALSE"),
	.tx_vod_selection (tx_vod_selection),//0-7
	
	.rx_eq_dc_gain (rx_eq_dc_gain), //0-4                                        
	.rx_eq_ctrl (rx_eq_ctrl),//0-16  
	.sys_clk_in_mhz(sys_clk_in_mhz),                                         
	
	//.rx_analog_reset_hold_time (rx_analog_reset_hold_time), //4ms, this is calculated according to system clock, here use 125Mhz                                        
	
	.loopback_mode (loopback_mode)//NONE|SLB|PLB|PRECDR_RSLB|POSTCDR_RSLB|RPLB
	) siv_alt_pma( 
       	.rst(rst),
       	.clk(clk),
       	.ch_mgmt_address(ch_mgmt_address),
       	.ch_mgmt_read(ch_mgmt_read),
       	.ch_mgmt_readdata(ch_mgmt_readdata),
       	.ch_mgmt_write(ch_mgmt_write),
       	.ch_mgmt_writedata(ch_mgmt_writedata),
       	.ch_mgmt_waitrequest(ch_mgmt_waitrequest),

   // avalon-ST interface with PMA controller
   	.cal_blk_clk(cal_blk_clk),
   	.cal_blk_pdn(cal_blk_pdn),
   	.gx_pdn(gx_pdn),//sync with clk
   	.tx_rst_digital(tx_rst_digital), // digital reset
   	.rx_rst_digital(rx_rst_digital), // digital reset
   	.tx_pma_ready(tx_pma_ready), // pma tx pll_locked
   	.rx_pma_ready(rx_pma_ready), // pma rx pll is locked to data
   	
   	.pll_pdn(pll_pdn), //sync with clk
   	.pll_locked(pll_locked), //conduit
   
    // avalon-ST interface with reconfig controller
 	.reconfig_clk(reconfig_clk), 
	.reconfig_to_gxb(reconfig_to_gxb), //sync with reconfig_clk
	.reconfig_from_gxb(reconfig_from_gxb), //sync with reconfig_clk. 17 bit per quad

	.pll_ref_clk(pll_ref_clk),

	.tx_parallel_data(tx_parallel_data),// sync with tx_clkout_clk
   	.tx_serial_data(tx_serial_data), // canduit 
	.tx_out_clk(tx_out_clk),
	
	.rx_serial_data(rx_serial_data),//canduit
	.rx_parallel_data(rx_parallel_data),// sync with rx_clkout_clk
	.rx_recovered_clk(rx_recovered_clk),

	.tx_digital_rst(tx_digital_rst),	
	.rx_digital_rst(rx_digital_rst),	

	.rx_is_lockedtodata(rx_is_lockedtodata),//conduit
	.rx_is_lockedtoref(rx_is_lockedtoref)//conduit
	);

endmodule
