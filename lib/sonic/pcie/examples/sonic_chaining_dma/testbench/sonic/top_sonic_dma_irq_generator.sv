/*****************************************************************

 top.sv module

******************************************************************

 UC Davis Confidential Copyright © 2011 ECE Department 

******************************************************************

 created on:	5/3/2011 
 created by:	hwang
 last edit on:	$DateTime: $ 
 last edit by:	$Author: $
 revision:	$Revision: $
 comments:	Generated

******************************************************************
 //Project// (//Number//)

 This module tests the ../../sonic_dma_irq_generator.sv module.

******************************************************************/
`include "../sonic_dma_irq_generator.sv"
`timescale        1ns/1ps

module top;  // top-level netlist to connect testbench to dut
  
timeunit 1ns; timeprecision 1ps;

// *** Input to UUT ***
logic            clk_in;
logic  [12:0]    rp;
logic  [12:0]    wp;

// *** Outputs from UUT ***
logic  [31:0]    data_available;
logic            irq;
logic            rstn;

// *** Instantiate the sonic_dma_irq_generator module ***
sonic_dma_irq_generator _sonic_dma_irq_generator(
	.clk_in (clk_in),
	.rstn(rstn),
    .rp (rp),
    .wp (wp),
    .data_available (data_available),
    .irq (irq)
	);


// ** Instantiate the Test module **
test_sonic_dma_irq_generator test(
	.clk_in (clk_in),
    .data_available (data_available),
    .irq (irq),
	.rstn(rstn),
    .rp (rp),
    .wp (wp)
	);

// clk generators
initial begin
  clk_in <= 1'b1;
end

// Generate clock:
always #4 clk_in <= ~clk_in;


endmodule : top




