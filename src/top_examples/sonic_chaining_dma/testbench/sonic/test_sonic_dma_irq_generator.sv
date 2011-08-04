/*****************************************************************

 test_sonic_dma_irq_generator.sv module

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

 This module implements the test bench for the ../../sonic_dma_irq_generator.sv module.

	// enter detailed description here;


******************************************************************/
`timescale        1ns/1ps


module    test_sonic_dma_irq_generator	(
	//** Inputs **
	input   logic			clk_in,
	input   logic  [31:0]	data_available,
	input   logic			irq,

	//** Outputs **
	output  logic            rstn,
	output  logic  [12:0]    rp,	//max of 8000
	output  logic  [12:0]    wp		//max of 25600
	);

	event start_Monitor;

	// *** Local Integer Declarations ***
	integer		results_file;	// for writing signal values

	int cnt;

	// initial block
	initial
	begin
		// initialize signals
		$display("Initialize Signals");
		rstn <= 0;

		$display("Wait for 100 ns");
		#100
		//->start_Monitor;              //trigger routine to monitor 
		CpuReset;
		
		// open results file, write header
		results_file=$fopen("../out/top_results.txt");
		$fdisplay(results_file, " test_sonic_dma_irq_generator testbench results");
		$fwrite(results_file, "\n");
		DisplayHeader;
		
		rp = 0;
		wp = 0;
		for (cnt=0; cnt < 2000; cnt=cnt+1) begin
			if(wp == 25600) begin
				wp <= 0;
			end
			else begin
				wp <= wp+1;
			end
			@(posedge clk_in);
		end
	
		// Add more test bench stuff here
		for (cnt =0 ; cnt < 2000; cnt=cnt+1) begin
			if(rp == 8000) begin
				rp <= 0;
			end
			else begin
				rp <= rp+1;
			end
			@(posedge clk_in);
		end

		$fclose(results_file);
		$stop;
	end

	// Add more test bench stuff here as well
	always 
	begin: Monitor
	  $timeformat(-9, 0, " ns", 9);
	  @(start_Monitor)
	  forever @(negedge clk_in)
	  begin
		//$fstrobe(results_file,"At %t:    \t%h\t%h",$realtime, data_in, data_out);
	  end
	end


	// Test Bench Tasks
	task DisplayHeader;
	  $fdisplay(results_file,"                       data_in      data_out ");
	  $fdisplay(results_file,"                 ============================");
	endtask    

	task CpuReset;
	begin
		@ (posedge clk_in);
		rstn = 0;
		@ (posedge clk_in);
		rstn = 1;
		@ (posedge clk_in);
	end
	endtask

endmodule : test_sonic_dma_irq_generator



