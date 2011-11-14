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

//siv sub top level, it include PCS, PMA, PCS MAP, reset controller is separated into each sub module. 
// this one will export reconfig ports of pma, when used need to merge 10gbaser with other protocal, this will be the  top level
//It decode the mgmt according to memory map aggrement.

module siv_10gbaser_pcs_pma_map #(
	parameter num_channels = 4,   // define the channel numbers
	parameter sys_clk_in_mhz = 50, //system clock for the avalone interface. It is limited by reconfig speed. This parameter will affact the reset hold time.
	parameter starting_channel_number = 0, //physical start channel number, useful in SIV
	parameter sync_depth = 2,
        parameter ref_clk_freq = "322.265625 MHz", // support both 322.265625 MHz, 644.53125 MHz
	parameter tx_termination = "OCT_85_OHMS", //Select the Transmitter termination resistance
	parameter tx_common_mode = "0.65V",//
	parameter tx_preemp_pretap = 0,//Select the Pre-emphasis pre-tap setting 0-7
	parameter tx_preemp_pretap_inv = 0,//0/1. Determine whether the pre-emphasis control signal for the pretap needed to be inverted or not.?true? ? Invert the pre-emphasis control signal for the pre tap.?false? ? Do not invert the pre-emphasis control signal for the pretap.
	parameter tx_preemp_tap_1 = 5,//0-15 Select the Pre-emphasis first post-tap setting
	parameter tx_preemp_tap_2 = 0,//0-7 Select the Pre-emphasis second post-tap setting
	parameter tx_preemp_tap_2_inv = 0,//0/1.Select the Pre-emphasis second post-tap polarity setting
	parameter tx_vod_selection = 1,//0-7 Select the Transitter VOD control setting
	parameter rx_termination = "OCT_100_OHMS", //OCT_85_OHMS,OCT_100_OHMS,OCT_120_OHMS,OCT_150_OHMS  Select the Receiver termination resistance                    
	parameter rx_common_mode = "0.82v",
	parameter rx_eq_dc_gain = 0, //0-4 Select the Receiver DC gain                                       
	parameter rx_eq_ctrl = 14,//0-16   Select the Receiver static equalizer setting 
	parameter reconfig_interfaces = 1  // reconfiger interface = num_channels/4 for SIV
)(
	input  wire        mgmt_clk,            //         mgmt_clk.clk
	input  wire        mgmt_clk_rstn,    //     mgmt_clk_rst.reset_n
	input  wire        mgmt_read,           //         phy_mgmt.read
	input  wire        mgmt_write,          //                 .write
	input  wire [7:0] mgmt_address,        //                 .address
	input  wire [31:0] mgmt_writedata,      //                 .writedata
	output wire [31:0] mgmt_readdata,       //                 .readdata
	output wire        mgmt_waitrequest,    //                 .waitrequest
	input  wire        xgmii_tx_clk,        //     xgmii_tx_clk.clk
	input  wire        pll_ref_clk,         //      pll_ref_clk.clk
	output wire        xgmii_rx_clk,        //     xgmii_rx_clk.clk
	input  wire        rx_oc_busy,			// RX channel offset cancellation status
	output wire        tx_ready,           //         tx_ready.data
	output wire        rx_ready,          //        rx_ready0.data
	output wire        [num_channels -1 : 0]block_lock,		
	output wire        [num_channels -1 : 0]hi_ber,	
        output wire        [num_channels -1 : 0]rx_recovered_clk,	
	output wire        [num_channels -1 : 0]rx_data_ready,		
	input  wire [72*num_channels -1 : 0] xgmii_tx_dc,      //    xgmii_tx_dc_0.data
	output wire [72*num_channels -1 : 0] xgmii_rx_dc,      //    xgmii_rx_dc_0.data
	output wire [num_channels -1 : 0] tx_serial_data, // tx_serial_data_0.export
	input  wire [num_channels -1 : 0] rx_serial_data,  // rx_serial_data_0.export
	input wire [3:0] reconfig_to_gxb,
	output wire [num_channels * 17 -1:0] reconfig_from_gxb,
	
	input wire pma_controller_gxb_pdn,
	output wire tx_pll_locked,
	input wire tx_pll_pdn,
	input wire pma_controller_cal_blk_pdn,
	input wire cal_blk_clk //calibration block clock

 	);
localparam rx_analog_reset_hold_time = sys_clk_in_mhz * 4;
localparam pll_reset_hold_time = sys_clk_in_mhz; 
localparam loopback_mode = "SLB"; //NONE|SLB|PLB|PRECDR_RSLB|POSTCDR_RSLB|RPLB decide loopback mode, default is SLB, it can use memory map directory control. 

wire [num_channels -1 : 0]xgmii_rx_clk_wire;		
wire [num_channels -1 : 0]rx_is_lockedtodata;
wire [num_channels -1 : 0]rx_is_lockedtoref;

wire [num_channels * 40 -1 : 0]pma_parallel_rx_data;
wire [num_channels * 40 -1 : 0]pma_parallel_tx_data;

wire reset_controller_pll_powerdown;
wire reset_controller_tx_digitalreset;
wire reset_controller_rx_analogreset;
wire reset_controller_rx_digitalreset;

wire [num_channels -1 : 0] csr_pll_powerdown;
wire [num_channels -1 : 0] csr_tx_digitalreset;
wire [num_channels -1 : 0] csr_rx_analogreset;
wire [num_channels -1 : 0] csr_rx_digitalreset;
wire [num_channels -1 : 0] csr_reset_tx_digital;
wire [num_channels -1 : 0] csr_reset_rx_digital;
wire csr_reset_all ;		// power-up to 1 to trigger auto-init sequence
assign xgmii_rx_clk = xgmii_rx_clk_wire[0];		
wire pll_siv_xgmii_pll_ready;
wire xgmii_rx_clk_from_pll;

wire [num_channels -1 : 0]rx_pma_clk;		
wire [num_channels -1 : 0]tx_pma_clk;		
wire [num_channels -1 : 0]signal_ok;

wire [num_channels -1 : 0]clr_errblk_cnt;		
wire [num_channels -1 : 0]clr_ber_cnt;		
wire [num_channels -1 : 0]block_lock_wire;		
wire [num_channels -1 : 0]hi_ber_wire;		
wire [num_channels -1 : 0]pcs_status_wire;		
wire [num_channels -1 : 0]tx_fifo_full;		
wire [num_channels -1 : 0]rx_fifo_full;		
wire [num_channels * 6 -1 : 0]ber_cnt;		
wire [num_channels * 8 -1 : 0]errored_block_cnt;		

wire 	[num_channels -1 : 0]tx_ready_wire;
wire 	[num_channels -1 : 0]rx_ready_wire;

assign 	tx_ready = &tx_ready_wire;
assign 	rx_ready = &rx_ready_wire;
assign rx_recovered_clk = rx_pma_clk;

wire enable_pma_ctrl;
wire enable_pcs ;
wire enable_ch;
wire  [31:0]pma_mgmt_writedata;
wire  [31:0]pma_mgmt_readdata;
wire  [31:0]ch_mgmt_readdata ;
wire  pma_mgmt_waitrequest, ch_mgmt_waitrequest, pcs_mgmt_waitrequest;
wire  [1:0]pma_mgmt_address;
wire  pma_mgmt_read;
wire  pma_mgmt_write;

wire  [31:0]ch_mgmt_writedata;
wire  [5:0]ch_mgmt_address;
wire  ch_mgmt_read ;
wire  ch_mgmt_write; 
wire tx_pma_ready;
wire rx_pma_ready;

wire  [31:0]pcs_mgmt_readdata;
wire  [31:0]pcs_mgmt_writedata;
wire  [7:0]pcs_mgmt_address;
wire  pcs_mgmt_read ;
wire  pcs_mgmt_write; 

wire 	[num_channels -1 : 0]tx_digital_rst;	
wire 	[num_channels -1 : 0]rx_digital_rst;	



//add n pcs for n channel design
assign signal_ok=rx_is_lockedtodata;
genvar i;
generate 
	for(i = 0; i < num_channels; i = i + 1) 
	begin: pcs_ch
		alt_10gbaser_pcs siv_10gbaser_ch_inst(
			.tx_ready(tx_ready_wire[i]),
			.rx_ready(rx_ready_wire[i]),
			.tx_pma_ready(tx_pma_ready),
			.rx_pma_ready(rx_pma_ready),
			.xgmii_pll_ready(pll_siv_xgmii_pll_ready),
			// AvalonMM signals
			.mgmt_clk(mgmt_clk),                  	// AvalonMM clock
			.mgmt_rst(!mgmt_clk_rstn),                	// AvalonMM active low reset
			.pcs_mgmt_address(3'b000),              	// AvalonMM address
			.pcs_mgmt_read(1'b0),                 	// AvalonMM read
			.pcs_mgmt_write(1'b0),                	// AvalonMM write
			.pcs_mgmt_writedata(16'h00),            	// AvalonMM write data
		
			.tx_usr_clk(xgmii_tx_clk),        //     xgmii_tx_clk.clk
			.xgmii_rx_clk(xgmii_rx_clk_wire[i]),
			.xgmii_tx_dc(xgmii_tx_dc[(i + 1) * 72 -1 : i *72]),      //    xgmii_tx_dc_0.data
			.xgmii_rx_dc(xgmii_rx_dc[(i + 1) * 72 -1 : i *72]),      //    xgmii_rx_dc_0.data
			.rx_usr_clk(xgmii_rx_clk_from_pll),
			// XGMII inputs from MAC
			.rx_pma_clk(rx_pma_clk[i]),               	// RX PMA Clock
			.pma_data_in(pma_parallel_rx_data[(i + 1) * 40 -1 : i *40]),          		// Data In from PMA 
		
			// Outputs to PMA
			.tx_pma_clk(tx_pma_clk[i]),           		// TX PMA Clock
			.pma_data_out(pma_parallel_tx_data[(i + 1) * 40 -1 : i *40]),             	// Data Out to PMA
		
			// Control Signals
			.signal_ok(signal_ok[i]),					// Indicates Data from PMA is valid 
			.clr_errblk_cnt(clr_errblk_cnt[i]),				// Clear the Errored Block Counter
			.clr_ber_count(clr_ber_cnt[i]),				// Clear the Errored Block Counter
			.tx_rst_only(tx_digital_rst[i]),
			.rx_rst_only(rx_digital_rst[i]),

			// Status signals
			.block_lock(block_lock_wire[i]),					// Block Locked 
			.rx_data_ready(rx_data_ready[i]),					// Block Locked 


			.hi_ber(hi_ber_wire[i]),						// Indicates High BER detected 
			.ber_count(ber_cnt[(i + 1) * 6 -1 : i *6]), 					// Indicates BER Count
			.errored_block_count(errored_block_cnt[(i + 1) * 8 -1 : i *8]),		// Errored Block Count
			.pcs_status(pcs_status_wire[i]),					// PCS status
			.tx_fifo_full(tx_fifo_full[i]),				// TX Clock Comp FIFO full
			.rx_fifo_full(rx_fifo_full[i])				// RX Clock Comp FIFO full
			);

	end
endgenerate

//pcs map
csr_pcs10gbaser #(
	.lanes( num_channels)
)pcs_map(
	// user data (avalon-MM formatted) 
	.clk(mgmt_clk),
	.reset(!mgmt_clk_rstn),
	.address(pcs_mgmt_address),
	.read(pcs_mgmt_read),
	.readdata(pcs_mgmt_readdata),
	.write(pcs_mgmt_write),
	.writedata(pcs_mgmt_writedata),
//	.waitrequest(pcs_mgmt_waitrequest),            	// AvalonMM write data


	.rx_clk(xgmii_rx_clk_from_pll),	// to synchronize rx control outputs
	.tx_clk(xgmii_rx_clk_from_pll),	// to synchronize tx control outputs

	.rx_pma_clk(rx_pma_clk),	// to synchronize rx control outputs

	//transceiver status inputs to this CSR
	.pcs_status         (pcs_status_wire),
	.hi_ber             (hi_ber_wire),
	.block_lock         (block_lock_wire),
	.rx_data_ready         (rx_data_ready),
	.tx_fifo_full       (tx_fifo_full),
	.rx_fifo_full       (rx_fifo_full),
	.rx_sync_head_error (0),
	.rx_scrambler_error (0),
	.ber_cnt            (ber_cnt),
	.errored_block_cnt(errored_block_cnt),

	
	// read/write control outputs
	// PCS controls
	.csr_rclr_errblk_cnt(clr_errblk_cnt),
	.csr_rclr_ber_cnt(clr_ber_cnt)
);

// one pma support n channel
   alt_pma_10gbaser_tgx #(
	.device_family("Stratix IV"), 
	.intended_device_variant("GT"),
	.number_of_channels (num_channels),
	.operation_mode("DUPLEX"), //TX, RX, DUPLEX
	.phase_comp_fifo_mode ("EMBEDDED"),//EMBEDDED, NONE 
	.serialization_factor (40),//8,10,16,20,32,40
	.data_rate("10312.5 Mbps"),
	.pll_input_frequency ("644.53125 MHz"),
	
	//additonal system parameters
	.number_pll_inclks (1),//reconfig may need more than one reference clock
	.pll_inclk_select (0),//0-number_of_ref_clks
	.pll_type ("CMU"),//ATX|CMU
	.bonded_mode ("FALSE"),
	.starting_channel_number (starting_channel_number),//0,4,8,12 ...
	.support_reconfig (1),
	.rx_use_cruclk ( "FALSE"),
	
	//analog parameters
	.gx_analog_power ("AUTO"),//AUTO|2.5v|3.0v|3.3v|3.9v
	
	.pll_lock_speed ("AUTO"),//AUTO|LOW|MEDIUM|HIGH 
	.tx_analog_power ("AUTO"),//AUTO|1.4V|1.5V 
	.tx_slew_rate ("LOW"),//AUTO,LOW,MEDIUM,HIGH
	.tx_termination (tx_termination),//OCT_85_OHMS,OCT_100_OHMS,OCT_120_OHMS,OCT_150_OHMS                      
	.tx_common_mode(tx_common_mode),  //"0.65V"                              
	
	.rx_pll_lock_speed ("AUTO"),//AUTO|LOW|MEDIUM|HIGH
	.rx_common_mode(rx_common_mode),  //TRISTATE|0.82v|1.1v                                
	.rx_signal_detect_threshold ( 2),                       
	.rx_ppmselect (32),                                         
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
	.reconfig_interfaces(reconfig_interfaces),
	.loopback_mode (loopback_mode)//NONE|SLB|PLB|PRECDR_RSLB|POSTCDR_RSLB|RPLB
	) siv_alt_pma( 
       	.rst(!mgmt_clk_rstn),
       	.clk(cal_blk_clk),
       	.ch_mgmt_address(ch_mgmt_address),
       	.ch_mgmt_read(ch_mgmt_read),
       	.ch_mgmt_readdata(ch_mgmt_readdata),
       	.ch_mgmt_write(ch_mgmt_write),
       	.ch_mgmt_writedata(ch_mgmt_writedata),
       	.ch_mgmt_waitrequest(ch_mgmt_waitrequest),

   // avalon-ST interface with PMA controller
   	.cal_blk_clk(mgmt_clk),
   	.cal_blk_pdn(pma_controller_cal_blk_pdn),
   	.gx_pdn(pma_controller_gxb_pdn),//sync with clk
   	.tx_rst_digital(1'b0), // digital reset
   	.rx_rst_digital(1'b0), // digital reset
   	.tx_pma_ready(tx_pma_ready), // pma tx pll_locked
   	.rx_pma_ready(rx_pma_ready), // pma rx pll is locked to data
   	
   	.pll_pdn(tx_pll_pdn), //sync with clk
   	.pll_locked(tx_pll_locked), //conduit
   
    // avalon-ST interface with reconfig controller
 	.reconfig_clk(mgmt_clk), 
	.reconfig_to_gxb(reconfig_to_gxb), //sync with reconfig_clk
	.reconfig_from_gxb(reconfig_from_gxb), //sync with reconfig_clk. 17 bit per quad

	.pll_ref_clk(pll_ref_clk),

	.tx_parallel_data(pma_parallel_tx_data),// sync with tx_clkout_clk
   	.tx_serial_data(tx_serial_data), // canduit 
	.tx_out_clk(tx_pma_clk),
	
	.rx_serial_data(rx_serial_data),//canduit
	.rx_parallel_data(pma_parallel_rx_data),// sync with rx_clkout_clk
	.rx_recovered_clk(rx_pma_clk),

	.tx_digital_rst(tx_digital_rst),	
	.rx_digital_rst(rx_digital_rst),	

	.rx_is_lockedtodata(rx_is_lockedtodata),//conduit
	.rx_is_lockedtoref(rx_is_lockedtoref)//conduit
	);

//pll to generate 156.25MHx xgmii_rx clock	
	pll_siv_xgmii #(
		.pll_reset_hold_time(pll_reset_hold_time)                                 // reset pulse length in clock cycles
	) pll_siv_xgmii_clk (
		.mgmt_clk  (mgmt_clk),                 //       mgmt_clk.clk
		.mgmt_rst  (!mgmt_clk_rstn),        // mgmt_clk_reset.reset
		.pll_ready (pll_siv_xgmii_pll_ready), //      pll_ready.data
		.ref_clk   (pll_ref_clk),              //        ref_clk.clk
		.out_clk   (xgmii_rx_clk_from_pll)     //        out_clk.clk
	);


// address decoder for PCS PMA CHANNEL
assign enable_pcs = (mgmt_address[7]) & !(mgmt_address[6]) & !(mgmt_address[5]);//200 shift 2 bits at the lsb
assign enable_ch = (!mgmt_address[7]) & (mgmt_address[6]) ;//180 shift 2 bits at lsb& 100
assign mgmt_readdata = (ch_mgmt_readdata & {32{ch_mgmt_read & !mgmt_waitrequest}}) | (pcs_mgmt_readdata & {32{pcs_mgmt_read & !mgmt_waitrequest}})  ;

assign ch_mgmt_writedata = mgmt_writedata;
assign ch_mgmt_address	= mgmt_address[5:0];
assign ch_mgmt_read = enable_ch & mgmt_read;
assign ch_mgmt_write = enable_ch & mgmt_write;

assign pcs_mgmt_writedata = mgmt_writedata;
assign pcs_mgmt_address = mgmt_address[7:0];
assign pcs_mgmt_read = enable_pcs & mgmt_read;
assign pcs_mgmt_write= enable_pcs & mgmt_write; 

//waite generate, in read command, sub module will get data 1 clock later.
	altera_wait_generate wait_gen(
	 .rst(!mgmt_clk_rstn),
	.clk(mgmt_clk),
	.launch_signal(mgmt_read),
	.wait_req(mgmt_waitrequest)
	 );
	
	//sync output with mgmt_clk
generate 
	for(i = 0; i < num_channels; i = i + 1) 
	begin: sync_out_pin
		altera_std_synchronizer # (
	         .depth ( sync_depth)
		)   stdsync_block_lock ( 
			.clk(mgmt_clk),
			.din(block_lock_wire[i]),
			.dout(block_lock[i]),
			.reset_n(mgmt_clk_rstn)
		);
	
		altera_std_synchronizer # (
	         .depth ( sync_depth)
		)   stdsync_hi_ber ( 
			.clk(mgmt_clk),
			.din(hi_ber_wire[i]),
			.dout(hi_ber[i]),
			.reset_n(mgmt_clk_rstn)
		);
end
endgenerate
endmodule
