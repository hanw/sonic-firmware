/*****************************************************************

 top.sv module

******************************************************************

 UC Davis Confidential Copyright © 2011 ECE Department 

******************************************************************

 created on:	5/1/2011 
 created by:	hwang
 last edit on:	$DateTime: $ 
 last edit by:	$Author: $
 revision:	$Revision: $
 comments:	Generated

******************************************************************
 //Project// (//Number//)

 This module tests the ../../sonic_address_converter.sv module.

******************************************************************/
`include "../sonic_address_converter.sv"
`include "../definitions.sv"
`timescale        1ns/1ps

module top;  // top-level netlist to connect testbench to dut
  
timeunit 1ns; timeprecision 1ps;

// *** Input to UUT ***
logic            clk_in;
logic   [12:0]   address_in;

AddressConverterInterface ac_intf();

// *** Instantiate the sonic_address_converter module ***
sonic_address_converter  _sonic_address_converter(
		.clk_in (clk_in),
        .address_in (address_in),
		.ac_intf(ac_intf.DUT)
		);

// ** Instantiate the Test module **
test_sonic_address_converter  test (
		.clk (clk_in),
        .address_out (address_in),
		.ac_intf(ac_intf.TB)
	);

// clk generators
initial begin
  clk_in <= 1'b1;
end

// Generate clock:
always #4 clk_in <= ~clk_in;

endmodule : top

