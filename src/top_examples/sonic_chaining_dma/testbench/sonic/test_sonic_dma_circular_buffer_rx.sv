/*****************************************************************

 test_sonic_dma_circular_buffer_rx.sv module

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

 This module implements the test bench for the ../../sonic_dma_circular_buffer_rx.sv module.

	// enter detailed description here;


******************************************************************/
`timescale 1ns/1ps

module test_sonic_dma_circular_buffer_rx (//** Inputs **
	CircularBufferInterface cb_intf   
    );

	event           start_Monitor;

	// *** Local Integer Declarations ***
	integer		results_file;	// for writing signal values

	int cnt;
	int index;
	int result;
	logic [7:0] dt_in [0:4];
	// initial block
	initial
	begin
		// initialize signals
		$display("Initialize Signals");
		cb_intf.rstn <= 0;

		$display("Wait for 100 ns");
		#100
		->start_Monitor;              //trigger routine to monitor 
		//CpuReset;
		
		// open results file, write header
		results_file=$fopen("../out/top_results.txt");
		$fdisplay(results_file, " test_sonic_dma_circular_buffer_rx testbench results");
		$fwrite(results_file, "\n");
		DisplayHeader;

		cb_intf.data_in <= 0;
		cb_intf.rden <= 0;
		cb_intf.wren <= 0;		

		// Add more test bench stuff here
		for (cnt = 0; cnt < 100; cnt = cnt + 1) begin
			cb_intf.data_in[39:0] <= {dt_in[4], dt_in[3], dt_in[2], dt_in[1], dt_in[0]};
			
			dt_in[0] <= cnt[7:0] * 5;
			dt_in[1] <= cnt[7:0] * 5 + 1;
			dt_in[2] <= cnt[7:0] * 5 + 2;
			dt_in[3] <= cnt[7:0] * 5 + 3;
			dt_in[4] <= cnt[7:0] * 5 + 4;
			
			cb_intf.wren <= 1;
			@(posedge cb_intf.clk_wr);
		end
		
		$display("At: %t, finished writing", $realtime);
	
		repeat(10) @ (negedge cb_intf.clk_rd);

		for (cnt = 0; cnt < 100; cnt = cnt+1) begin
			result <= cb_intf.data_out;
			cb_intf.rden <= 1;
			@(posedge cb_intf.clk_rd);
		end
		$display("At: %t, finished reading", $realtime);	
	
		$fclose(results_file);
		$stop;
	end

	// Add more test bench stuff here as well
	always 
	begin: Monitor
	  $timeformat(-9, 0, " ns", 9);
	  @(start_Monitor)
	  forever @(negedge cb_intf.clk_wr)
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
		@ (posedge cb_intf.clk_wr);
		cb_intf.rstn = 0;
		@ (posedge cb_intf.clk_wr);
		cb_intf.rstn = 1;
		@ (posedge cb_intf.clk_wr);
	end
	endtask

endmodule : test_sonic_dma_circular_buffer_rx



