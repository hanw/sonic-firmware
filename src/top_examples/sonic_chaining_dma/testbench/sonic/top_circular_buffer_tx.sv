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

 This module tests the ../../sonic_dma_circular_buffer_tx.sv module.

******************************************************************/
`include "../sonic_dma_circular_buffer_tx.sv"
`include "../definitions.sv"
`timescale        1ns/1ps

module top;  // top-level netlist to connect testbench to dut
  
timeunit 1ns; timeprecision 1ps;

logic clk_rd;
logic clk_wr;
// *** Input to UUT ***
CircularBufferInterface #(
	.DATA_IN_WIDTH(128),
	.DATA_OUT_WIDTH(40)
	) cb_intf(
	.clk_rd(clk_rd), 
	.clk_wr(clk_wr)
	);

// *** Instantiate the sonic_dma_circular_buffer_tx module ***
sonic_dma_circular_buffer_tx _sonic_dma_circular_buffer_tx(
	.cb_intf(cb_intf.DUT)
	);

// ** Instantiate the Test module **
test_sonic_dma_circular_buffer_tx test (
	.cb_intf(cb_intf.TB)
	);

// clk generators
initial begin
  clk_wr <= 1'b1;
  clk_rd <= 1'b1;
end

// Generate clock:
always begin
  #4 clk_wr <= ~clk_wr; clk_rd <= ~clk_rd;
end

endmodule : top




