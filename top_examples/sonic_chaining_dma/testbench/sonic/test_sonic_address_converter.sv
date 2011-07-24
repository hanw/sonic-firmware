/*****************************************************************

 test_sonic_address_converter.sv module

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

 This module implements the test bench for the ../../sonic_address_converter.sv module.

	// enter detailed description here;


******************************************************************/
`timescale        1ns/1ps

module test_sonic_address_converter (
	input logic clk,
	output logic [12:0] address_out,
	AddressConverterInterface.TB ac_intf
	);
	event           start_Monitor;
	logic rst_n;

	// *** Local Integer Declarations ***
	integer		results_file;	// for writing signal values
	int  cnt;
	logic [12:0] address;

	// initial block
	initial
	begin
		// initialize signals
		$display("Initialize Signals");
		rst_n <= 0;
		
		$display("Wait for 100 ns");
		#100
		->start_Monitor;              //trigger routine to monitor 
		CpuReset;
		
		// open results file, write header
		results_file=$fopen("../out/top_results.txt");
		$fdisplay(results_file, " test_sonic_address_converter testbench results");
		$fwrite(results_file, "\n");
		DisplayHeader;
		
		// Add more test bench stuff here
		for (cnt = 0; cnt < 1000; cnt = cnt+1) begin
			GenerateAddress(cnt, address);	
		end
		
		$fclose(results_file);
		$stop;
	end

	// Add more test bench stuff here as well
	always 
	begin: Monitor
	  $timeformat(-9, 0, " ns", 9);
	  @(start_Monitor)
	  forever @(negedge clk)
	  begin
		//$fstrobe(results_file,"At %t:    \t%h\t%h",$realtime, data_in, data_out);
	  end
	end

	always @(posedge clk) begin
		address_out <= address;
	end

	// Test Bench Tasks
	task DisplayHeader;
	  $fdisplay(results_file,"                       data_in      data_out ");
	  $fdisplay(results_file,"                 ============================");
	endtask    

	task CpuReset;
	begin
		@ (posedge clk);
		rst_n = 0;
		@ (posedge clk);
		rst_n = 1;
		@ (posedge clk);
	end
	endtask

	task GenerateAddress(input int count, output [12:0] address);
	begin
		address = count;
		@ (posedge clk);
	end
	endtask

endmodule : test_sonic_address_converter



