/*****************************************************************

 top.sv module

******************************************************************

 UC Davis Confidential Copyright © 2011 ECE Department 

******************************************************************

 created on:	5/7/2011 
 created by:	hwang
 last edit on:	$DateTime: $ 
 last edit by:	$Author: $
 revision:	$Revision: $
 comments:	Generated

******************************************************************
 //Project// (//Number//)

 This module tests the ../../sonic_custom_avalon_master.v module.

******************************************************************/
`include "../sonic_custom_avalon_master.v"
`timescale        1ns/1ps

module top;  // top-level netlist to connect testbench to dut
  
timeunit 1ns; timeprecision 1ps;

parameter DATA_WIDTH = 32;
parameter ADDRESS_WIDTH = 6;

reg clk;
reg reset;

wire control_mode;
wire control_fixed_location;
wire control_go;
wire control_done;
wire control_early_done;						// for read master

wire [ADDRESS_WIDTH-1:0] control_base;
wire [ADDRESS_WIDTH-1:0] control_length;

wire user_read_buffer;							// for read master
wire user_write_buffer;							// for write master
wire [DATA_WIDTH-1:0] user_buffer_input_data;	// for write master
wire [DATA_WIDTH-1:0] user_buffer_output_data;	// for read master
wire user_data_available;						// for read master
wire user_buffer_full;							// for write master

wire [ADDRESS_WIDTH-1:0] master_address;
wire master_read;								// for read master
wire master_write;								// for write master
wire [DATA_WIDTH-1:0] master_readdata;			// for read master
wire master_readdatavalid;						// for read master
wire [DATA_WIDTH-1:0] master_writedata;			// for write master

wire mdc;
wire mdio_in;
wire mdio_out;
wire mdio_oen;

// *** Instantiate the sonic_custom_avalon_master module ***
sonic_custom_avalon_master  _sonic_custom_avalon_master (
	.clk(clk),
	.reset(reset),

	.control_mode(control_mode),			//0 for read, 1 for write
	.control_fixed_location(control_fixed_location),
	.control_base(control_base),
	.control_length(control_length),
	.control_go(control_go),
	.control_done(control_done),
	.control_early_done(control_early_done),

	.user_read_buffer(user_read_buffer),
	.user_write_buffer(user_write_buffer),
	.user_buffer_input_data(user_buffer_input_data),
	.user_buffer_output_data(user_buffer_output_data),
	.user_data_available(user_data_available),
	.user_buffer_full(user_buffer_full),
	
	.master_address(master_address),
	.master_read(master_read),
	.master_write(master_write),
	.master_readdata(master_readdata),
	.master_readdatavalid(master_readdatavalid),
	.master_writedata(master_writedata),
	.master_waitrequest(master_waitrequest)
	);

sonic_eth_mdio mdio(
	.clk(clk),
	.reset(reset),

	.csr_read(master_read),
	.csr_write(master_write),
	.csr_address(master_address),
	.csr_writedata(master_writedata),
	.csr_readdata(master_readdata),
	.csr_waitrequest(master_waitrequest),

	.mdc(mdc),
	.mdio_in(mdio_in),
	.mdio_out(mdio_out),
	.mdio_oen(mdio_oen)
	);

// ** Instantiate the Test module **
test_sonic_custom_avalon_master test(                                                    
	.clk(clk),
	.reset(reset),

	.control_mode(control_mode),			//0 for read, 1 for write
	.control_fixed_location(control_fixed_location),
	.control_base(control_base),
	.control_length(control_length),
	.control_go(control_go),
	.control_done(control_done),
	.control_early_done(control_early_done),

	.user_read_buffer(user_read_buffer),
	.user_write_buffer(user_write_buffer),
	.user_buffer_input_data(user_buffer_input_data),
	.user_buffer_output_data(user_buffer_output_data),
	.user_data_available(user_data_available),
	.user_buffer_full(user_buffer_full),
	
	.mdc(mdc),
	.mdio_in(mdio_in),
	.mdio_out(mdio_out),
	.mdio_oen(mdio_oen)
	);

// clk generators
initial begin
  clk <= 1'b1;
end

// Generate clock:
always #4 clk <= ~clk;

endmodule : top




