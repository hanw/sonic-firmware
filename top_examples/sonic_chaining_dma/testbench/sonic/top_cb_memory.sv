/*****************************************************************

 top.sv module

******************************************************************


******************************************************************

 created on:	4/29/2011 
 created by:	hwang
 last edit on:	$DateTime: $ 
 last edit by:	$Author: $
 revision:	$Revision: $
 comments:	Generated

******************************************************************

 This module tests the ../../sonic_cb_memory.sv module.

******************************************************************/
`include "../sonic_cb_memory.sv"
`include "../definitions.sv"
//`include "test_sonic_cb_memory.sv"
`timescale        1ns/1ps

module top;  // top-level netlist to connect testbench to dut
  
timeunit 1ns; 
timeprecision 1ps;

logic clk_wr;
logic clk_rd;

// *** Input to UUT ***
MemoryInterface wr_intf(.clk(clk_wr));
MemoryInterface rd_intf(.clk(clk_rd));

// *** Instantiate the sonic_cb_memory module ***
sonic_cb_memory  _sonic_cb_memory ( 
	.write_intf(wr_intf.writeport),
	.read_intf(rd_intf.readport)
);

// ** Instantiate the Test module **
test_sonic_cb_memory _test (
	.reader(rd_intf.reader),
	.writer(wr_intf.writer)
);

// clk generators
initial begin
  clk_rd <= 1'b1;
  clk_wr <= 1'b1;
end

// Generate clock:
always #4 clk_rd <= ~clk_rd;

always #4 clk_wr <= ~clk_wr;

endmodule : top

