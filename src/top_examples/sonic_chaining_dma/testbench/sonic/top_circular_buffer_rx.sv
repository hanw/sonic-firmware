/*****************************************************************

 top.sv module

******************************************************************

 UC Davis Confidential Copyright © 2011 ECE Department 

******************************************************************

 created on:	5/2/2011 
 created by:	hwang
 last edit on:	$DateTime: $ 
 last edit by:	$Author: $
 revision:	$Revision: $
 comments:	Generated

******************************************************************
 //Project// (//Number//)

 This module tests the ../../sonic_dma_circular_buffer_rx.sv module.

******************************************************************/
`include "../sonic_rx_circular_buffer.sv"
`timescale 1ns/1ps

module top;  // top-level netlist to connect testbench to dut
  
timeunit 1ns; timeprecision 1ps;

// *** Input to UUT ***
logic            clk_rd;
logic            clk_wr;

// *** Instantiate the sonic_dma_circular_buffer_rx module ***
sonic_rx_circular_buffer ep_rx_dpram (
	.read_data(q_b),			// 128 bits, to pcie dma
	.read_address(address_b),	// pcie dma, 13 bits
	.rdena(1'b1),		// 
	.rdreq(rden_b),			// 
	.waitrequest(),		// 
	.reset(~phy_ready),		//
	.rdclock(clk_in),	//
	.wrclock(rx_clkout),			// xcvr clock
	.wrena(1'b1),			// controlled by xcvr_ena & full
	.wrreq(1'b1),			// controlled by xcvr_ena
	.data_in(rx_dataout),			// data from xcvr
	.empty(rx_empty),			// used for rd_ena
	.full(rx_full),			// used for wr_ena
	.almost_full(rx_almost_full),		// not used
	.almost_empty(rx_almost_empty)		// not used

// ** Instantiate the Test module **
test_sonic_circular_buffer test(

	);

// clk generators
initial begin
  clk_wr <= 1'b1;
  clk_rd <= 1'b1;
end

// Generate clock:
always #4 clk_wr <= ~clk_wr;
always #4 clk_rd <= ~clk_rd;


endmodule : top




