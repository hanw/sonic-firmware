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


// Transceiver Reconfiguration Module for Stratix IV architectures
//
// Includes many function-specific sub-modules, such as:
//  - analog reconfig (alt_xcvr_reconfig_analog)
//  - offset cancellation (alt_xcvr_reconfig_offset_cancellation)
//  - ...

// $Header$

`timescale 1 ns / 1 ns

module alt_xcvr_reconfig_siv #(
	parameter number_of_reconfig_interfaces = 1
) (
	input  wire        mgmt_clk_clk,              //             mgmt_clk.clk
	input  wire        mgmt_rst_reset,            //             mgmt_rst.reset

	// user reconfiguration management interface
	input  wire [6:0]  reconfig_mgmt_address,     //        reconfig_mgmt.address
	output reg         reconfig_mgmt_waitrequest = 0, //                 .waitrequest
	input  wire        reconfig_mgmt_read,        //                     .read
	output reg  [31:0] reconfig_mgmt_readdata = ~0,    //                .readdata
	input  wire        reconfig_mgmt_write,       //                     .write
	input  wire [31:0] reconfig_mgmt_writedata,   //                     .writedata
	output wire        reconfig_done,             //        reconfig_done.export

	output wire [3:0]  reconfig_togxb,             //  reconfig_togxb_data.data
    input  wire [number_of_reconfig_interfaces*17 - 1 : 0] reconfig_fromgxb // dprioout, testbus from altgx : (17+4 bits/quad)
);

	// master interface to basic reconfiguration block that interfaces to the transceiver channel
	wire [2:0]  basic_address;     //   basic.address    // master interface must include 2 lower addr bits
	wire        basic_waitrequest; //        .waitrequest
	wire        basic_irq;         //        .irq
	wire        basic_read;        //        .read
	wire [31:0] basic_readdata;    //        .readdata
	wire        basic_write;       //        .write
	wire [31:0] basic_writedata;   //        .writedata
	
	// native testbus input
	wire [15:0] testbus_data;

	localparam l_dev_family = "Stratix IV";
	localparam width_awa = 3;	// word address width of interface to analog reconfig block
	localparam width_bwa = 3;	// word address width of interface to basic reconfig block
	localparam arb_count = 4;	// count of the total number of sub-components that can act
								// as slaves to the mgmt interface, and masters to the 'basic' block
	localparam arb_offset = 0;
	localparam arb_analog = 1;
	localparam arb_eyemon = 2;
	localparam arb_dfe    = 3;

	// Analog controls output ports, mgmt facing
	wire [31:0] sc_analog_readdata;
	wire  sc_analog_waitrequest;

	// Offset cancellation output ports, mgmt facing
	wire [31:0] sc_offset_readdata;
	wire  sc_offset_waitrequest;

	// Eyemon output ports, mgmt facing
	wire [31:0] sc_eyemon_readdata;
	wire  sc_eyemon_waitrequest;

	// DFE output ports, mgmt facing
	wire [31:0] sc_dfe_readdata;
	wire  sc_dfe_waitrequest;

	///////////////////////////////////////////////////////////////////////
	// Decoder for multiple slaves of reconfig_mgmt interface
	///////////////////////////////////////////////////////////////////////
	wire [arb_count-1:0] r_decode;
	assign r_decode = 
		  (reconfig_mgmt_address[6:width_awa] == arb_offset) ? (({arb_count-arb_offset{1'b0}} | 1'b1) << arb_offset)
		: (reconfig_mgmt_address[6:width_awa] == arb_analog) ? (({arb_count-arb_analog{1'b0}} | 1'b1) << arb_analog)
		: (reconfig_mgmt_address[6:width_awa] == arb_eyemon) ? (({arb_count-arb_eyemon{1'b0}} | 1'b1) << arb_eyemon)
		: (reconfig_mgmt_address[6:width_awa] == arb_dfe)    ? (({arb_count-arb_dfe{1'b0}} | 1'b1) << arb_dfe)
		: {arb_count{1'b0}};

	// reconfig_mgmt output generation is muxing of decoded slave output
	always @(*) begin
		case (reconfig_mgmt_address[6:width_awa])
		arb_offset: begin
			reconfig_mgmt_readdata = sc_offset_readdata;
			reconfig_mgmt_waitrequest = sc_offset_waitrequest;
			end
		arb_analog: begin
			reconfig_mgmt_readdata = sc_analog_readdata;
			reconfig_mgmt_waitrequest = sc_analog_waitrequest;
			end
		arb_eyemon: begin
			reconfig_mgmt_readdata = sc_eyemon_readdata;
			reconfig_mgmt_waitrequest = sc_eyemon_waitrequest;
			end
		arb_dfe: begin
			reconfig_mgmt_readdata = sc_dfe_readdata;
			reconfig_mgmt_waitrequest = sc_dfe_waitrequest;
			end
		default: begin
			reconfig_mgmt_readdata = -1;
			reconfig_mgmt_waitrequest = 1'b0;
			end
		endcase
	end

	///////////////////////////////////////////////////////////////////////
	// Arbiter for multiple masters accessing 'basic' reconfig slave port
	///////////////////////////////////////////////////////////////////////
	wire [arb_count-1:0] req;	// req[0] is highest priority when current grantee is done
	wire [arb_count-1:0] grant;

	alt_xcvr_arbiter #(
		.width(arb_count)	// count total number of sub-components that act as masters to 'basic'
	) arbiter (
		.clock(mgmt_clk_clk),
		.req(req),
		.grant(grant)
	);

	////////////////////////////////////
	// Sub-component: analog controls
	// word address offset: +0
	////////////////////////////////////

	// Analog controls output ports, mgmt facing
	wire  analog_reconfig_done;
	// Analog controls output ports, basic slave facing
	wire [width_bwa+1:0] scs_analog_address;
	wire [31:0] scs_analog_writedata;
	wire  scs_analog_write;
	wire  scs_analog_read;

	// Analog controls master-to-slave access fabric outputs
	tri0 m2s_analog_read;
	tri0 m2s_analog_write;
	tri0 [width_bwa-1:0] m2s_analog_address;
	tri0 [31:0] m2s_analog_writedata;
	wire [31:0] m2s_analog_readdata;
	wire m2s_analog_waitrequest;

	alt_xcvr_reconfig_analog_tgx sc_analog (
		.reconfig_clk(mgmt_clk_clk),
		.reset(mgmt_rst_reset),
		// external mgmt interface facing
		.analog_reconfig_address(reconfig_mgmt_address[width_awa-1:0]),
		.analog_reconfig_writedata(reconfig_mgmt_writedata),
		.analog_reconfig_write(reconfig_mgmt_write & r_decode[arb_analog]),
		.analog_reconfig_read(reconfig_mgmt_read & r_decode[arb_analog]),
		.analog_reconfig_readdata(sc_analog_readdata),
		.analog_reconfig_waitrequest(sc_analog_waitrequest),
		.analog_reconfig_done(analog_reconfig_done),
		// master-to-slave fabric facing, to basic reconfig
		.analog_reconfig_irq_from_base(basic_irq),
		.analog_reconfig_waitrequest_from_base(m2s_analog_waitrequest),
		.analog_reconfig_readdata_base(m2s_analog_readdata),
		.analog_reconfig_address_base(scs_analog_address),
		.analog_reconfig_writedata_base(scs_analog_writedata),
		.analog_reconfig_write_base(scs_analog_write),
		.analog_reconfig_read_base(scs_analog_read)
	);

	// master-to-slave access module
	alt_xcvr_m2s #(
		.width_addr(width_bwa),
		.width_data(32)
	) m2s_analog (
		.clock(mgmt_clk_clk),
		.req(req[arb_analog]),
		.grant(grant[arb_analog]),
		// master ports, facing basic reconfig block
		.m_read(scs_analog_read),
		.m_write(scs_analog_write),
		.m_address(scs_analog_address[2 +: width_bwa]),	// drop 2 lower addr bits
		.m_writedata(scs_analog_writedata),
		.m_readdata(m2s_analog_readdata),
		.m_waitrequest(m2s_analog_waitrequest),
		// slave-side ports, from basic reconfig block
		.s_readdata(basic_readdata),
		.s_waitrequest(basic_waitrequest),
		.s_read(m2s_analog_read),
		.s_write(m2s_analog_write),
		.s_address(m2s_analog_address),
		.s_writedata(m2s_analog_writedata)
	);

	///////////////////////////////////////////
	// Sub-component: offset cancellation
	// word address offset: +8 (0x20 in bytes)
	///////////////////////////////////////////

	// Offset cancellation output ports:
	wire  offset_cancellation_done;
	wire [width_bwa-1:0] scs_offset_address;
	wire [31:0] scs_offset_writedata;
	wire  scs_offset_write;
	wire  scs_offset_read;

	// Offset cancellation master-to-slave access fabric outputs
	tri0 m2s_offset_read;
	tri0 m2s_offset_write;
	tri0 [width_bwa-1:0] m2s_offset_address;
	tri0 [31:0] m2s_offset_writedata;
	wire [31:0] m2s_offset_readdata;
	wire m2s_offset_waitrequest;

	alt_xcvr_reconfig_offset_cancellation #(
		.number_of_reconfig_interfaces(number_of_reconfig_interfaces),
		.device_family(l_dev_family)
	) sc_offset (
		.reconfig_clk(mgmt_clk_clk),
		.reset(mgmt_rst_reset),
		// external mgmt interface facing
		.offset_cancellation_address(reconfig_mgmt_address[0]),	// slave uses a single address bit
		.offset_cancellation_writedata(reconfig_mgmt_writedata),
		.offset_cancellation_write(reconfig_mgmt_write & r_decode[arb_offset]),
		.offset_cancellation_read(reconfig_mgmt_read & r_decode[arb_offset]),
		.offset_cancellation_readdata(sc_offset_readdata),
		.offset_cancellation_waitrequest(sc_offset_waitrequest),
		// master-to-slave fabric facing, to basic reconfig
		.offset_cancellation_irq_from_base(basic_irq),
		.offset_cancellation_waitrequest_from_base(m2s_offset_waitrequest),
		.offset_cancellation_readdata_base(m2s_offset_readdata),
		.testbus_data(testbus_data),
		.offset_cancellation_done(offset_cancellation_done),
		.offset_cancellation_address_base(scs_offset_address),
		.offset_cancellation_writedata_base(scs_offset_writedata),
		.offset_cancellation_write_base(scs_offset_write),
		.offset_cancellation_read_base(scs_offset_read)
	);

	// master-to-slave access module
	alt_xcvr_m2s #(
		.width_addr(width_bwa),
		.width_data(32)
	) m2s_offset (
		.clock(mgmt_clk_clk),
		.req(req[arb_offset]),
		.grant(grant[arb_offset]),
		// master ports, facing basic reconfig block
		.m_read(scs_offset_read),
		.m_write(scs_offset_write),
		.m_address(scs_offset_address),	// drop 2 lower addr bits
		.m_writedata(scs_offset_writedata),
		.m_readdata(m2s_offset_readdata),
		.m_waitrequest(m2s_offset_waitrequest),
		// slave-side ports, from basic reconfig block
		.s_readdata(basic_readdata),
		.s_waitrequest(basic_waitrequest),
		.s_read(m2s_offset_read),
		.s_write(m2s_offset_write),
		.s_address(m2s_offset_address),
		.s_writedata(m2s_offset_writedata)
	);

	///////////////////////////////////////////
	// Sub-component: "EyeQ" eye monitor
	// word address offset: +16 (0x40 in bytes)
	///////////////////////////////////////////

	// Eyemon output ports:
	wire  eyemon_done;
	wire [width_bwa+1:0] scs_eyemon_address;
	wire [31:0] scs_eyemon_writedata;
	wire  scs_eyemon_write;
	wire  scs_eyemon_read;

	// eyemon master-to-slave access fabric outputs
	tri0 m2s_eyemon_read;
	tri0 m2s_eyemon_write;
	tri0 [width_bwa-1:0] m2s_eyemon_address;
	tri0 [31:0] m2s_eyemon_writedata;
	wire [31:0] m2s_eyemon_readdata;
	wire m2s_eyemon_waitrequest;

	alt_xcvr_reconfig_eyemon #(
		.number_of_reconfig_interfaces(number_of_reconfig_interfaces),
		.device_family(l_dev_family)
	) sc_eyemon (
		.reconfig_clk(mgmt_clk_clk),
		.reset(mgmt_rst_reset),
		// external mgmt interface facing
		.eyemon_address(reconfig_mgmt_address[width_awa-1:0]),	// slave uses a 3-bit address
		.eyemon_writedata(reconfig_mgmt_writedata),
		.eyemon_write(reconfig_mgmt_write & r_decode[arb_eyemon]),
		.eyemon_read(reconfig_mgmt_read & r_decode[arb_eyemon]),
		.eyemon_readdata(sc_eyemon_readdata),
		.eyemon_waitrequest(sc_eyemon_waitrequest),
		// master-to-slave fabric facing, to basic reconfig
		.eyemon_irq_from_base(basic_irq),
		.eyemon_waitrequest_from_base(m2s_eyemon_waitrequest),
		.eyemon_readdata_base(m2s_eyemon_readdata),
		.eyemon_done(eyemon_done),
		.eyemon_address_base(scs_eyemon_address),
		.eyemon_writedata_base(scs_eyemon_writedata),
		.eyemon_write_base(scs_eyemon_write),
		.eyemon_read_base(scs_eyemon_read)
	);

	// master-to-slave access module
	alt_xcvr_m2s #(
		.width_addr(width_bwa),
		.width_data(32)
	) m2s_eyemon (
		.clock(mgmt_clk_clk),
		.req(req[arb_eyemon]),
		.grant(grant[arb_eyemon]),
		// master ports, facing basic reconfig block
		.m_read(scs_eyemon_read),
		.m_write(scs_eyemon_write),
		.m_address(scs_eyemon_address[2 +: width_bwa]),	// drop 2 lower addr bits
		.m_writedata(scs_eyemon_writedata),
		.m_readdata(m2s_eyemon_readdata),
		.m_waitrequest(m2s_eyemon_waitrequest),
		// slave-side ports, from basic reconfig block
		.s_readdata(basic_readdata),
		.s_waitrequest(basic_waitrequest),
		.s_read(m2s_eyemon_read),
		.s_write(m2s_eyemon_write),
		.s_address(m2s_eyemon_address),
		.s_writedata(m2s_eyemon_writedata)
	);

	///////////////////////////////////////////
	// Sub-component: DFE
	// word address offset: +24 (0x60 in bytes)
	///////////////////////////////////////////

	// DFE output ports:
	wire  dfe_done;
	wire [width_bwa+1:0] scs_dfe_address;
	wire [31:0] scs_dfe_writedata;
	wire  scs_dfe_write;
	wire  scs_dfe_read;

	// dfe master-to-slave access fabric outputs
	tri0 m2s_dfe_read;
	tri0 m2s_dfe_write;
	tri0 [width_bwa-1:0] m2s_dfe_address;
	tri0 [31:0] m2s_dfe_writedata;
	wire [31:0] m2s_dfe_readdata;
	wire m2s_dfe_waitrequest;

	alt_xcvr_reconfig_dfe #(
		.number_of_reconfig_interfaces(number_of_reconfig_interfaces),
		.device_family(l_dev_family)
	) sc_dfe (
		.reconfig_clk(mgmt_clk_clk),
		.reset(mgmt_rst_reset),
		// external mgmt interface facing
		.dfe_address(reconfig_mgmt_address[width_awa-1:0]),	// slave uses a 3-bit address
		.dfe_writedata(reconfig_mgmt_writedata),
		.dfe_write(reconfig_mgmt_write & r_decode[arb_dfe]),
		.dfe_read(reconfig_mgmt_read & r_decode[arb_dfe]),
		.dfe_readdata(sc_dfe_readdata),
		.dfe_waitrequest(sc_dfe_waitrequest),
		// master-to-slave fabric facing, to basic reconfig
		.dfe_irq_from_base(basic_irq),
		.dfe_waitrequest_from_base(m2s_dfe_waitrequest),
		.dfe_readdata_base(m2s_dfe_readdata),
		.dfe_done(dfe_done),
		.dfe_address_base(scs_dfe_address),
		.dfe_writedata_base(scs_dfe_writedata),
		.dfe_write_base(scs_dfe_write),
		.dfe_read_base(scs_dfe_read)
	);

	// master-to-slave access module
	alt_xcvr_m2s #(
		.width_addr(width_bwa),
		.width_data(32)
	) m2s_dfe (
		.clock(mgmt_clk_clk),
		.req(req[arb_dfe]),
		.grant(grant[arb_dfe]),
		// master ports, facing basic reconfig block
		.m_read(scs_dfe_read),
		.m_write(scs_dfe_write),
		.m_address(scs_dfe_address[2 +: width_bwa]),	// drop 2 lower addr bits
		.m_writedata(scs_dfe_writedata),
		.m_readdata(m2s_dfe_readdata),
		.m_waitrequest(m2s_dfe_waitrequest),
		// slave-side ports, from basic reconfig block
		.s_readdata(basic_readdata),
		.s_waitrequest(basic_waitrequest),
		.s_read(m2s_dfe_read),
		.s_write(m2s_dfe_write),
		.s_address(m2s_dfe_address),
		.s_writedata(m2s_dfe_writedata)
	);


	///////////////////////////////////////////
	// Outputs to basic block
	///////////////////////////////////////////
	assign basic_address = m2s_analog_address | m2s_offset_address | m2s_eyemon_address | m2s_dfe_address;
	assign basic_read = m2s_analog_read | m2s_offset_read | m2s_eyemon_read | m2s_dfe_read;
	assign basic_write = m2s_analog_write | m2s_offset_write | m2s_eyemon_write | m2s_dfe_write;
	assign basic_writedata = m2s_analog_writedata | m2s_offset_writedata | m2s_eyemon_writedata | m2s_dfe_writedata;

	wire	[number_of_reconfig_interfaces*8 - 1 : 0] aeq_fromgxb_data=0;	
	wire	[number_of_reconfig_interfaces*24 - 1 : 0] aeq_togxb_data;

	alt_xcvr_reconfig_basic_tgx #(
		.number_of_reconfig_interfaces(number_of_reconfig_interfaces)
	) sc_basic (
		.reconfig_clk(mgmt_clk_clk),
		.reset(mgmt_rst_reset),
		.basic_reconfig_write(basic_write),
		.basic_reconfig_read(basic_read),
		.basic_reconfig_writedata(basic_writedata),
		.basic_reconfig_address(basic_address),
		.basic_reconfig_fromgxb_data(reconfig_fromgxb),
		.aeq_fromgxb_data(aeq_fromgxb_data),
		.basic_reconfig_readdata(basic_readdata),
		.basic_reconfig_waitrequest(basic_waitrequest),
		.basic_reconfig_togxb_data(reconfig_togxb),
		.aeq_togxb_data(aeq_togxb_data),
		.testbus_data(testbus_data),
		.basic_reconfig_irq(basic_irq)
	);


	///////////////////////////////////////////
	// Status to external mgmt interface
	///////////////////////////////////////////
	assign reconfig_done = analog_reconfig_done | offset_cancellation_done | eyemon_done | dfe_done;

endmodule
