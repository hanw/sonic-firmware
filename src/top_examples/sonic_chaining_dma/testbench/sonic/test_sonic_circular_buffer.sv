/*****************************************************************

 test_sonic_circular_buffer.sv module

******************************************************************

******************************************************************

 created on:	5/5/2011 
 created by:	hwang
 last edit on:	$DateTime: $ 
 last edit by:	$Author: $
 revision:	$Revision: $
 comments:	Generated

******************************************************************
 //Project// (//Number//)

 This module implements the test bench for the ../../sonic_circular_buffer.sv module.

	// enter detailed description here;


******************************************************************/
`timescale        1ns/1ps


module    test_sonic_circular_buffer (

		//** Inputs **                             
        input   logic            clk_read,                                             
		input   logic            clk_write,
        input   logic            almost_empty,
		input   logic            almost_full,
		input   logic            empty,
        input   logic            full,

        //** Outputs **
        output  logic [39:0]    data_in,
	    output  logic [127:0]     data_out,
        output  logic            read_enable,
        output  logic            reset,
        output  logic            write_enable
        );

	event           start_Monitor;

	integer		results_file;	// for writing signal values
	int cnt;

	// initial block
	initial
	begin
		// initialize signals
		$display("Initialize Signals");
		reset <= 0;

		$display("Wait for 100 ns");
		#100
		->start_Monitor;              //trigger routine to monitor 
		CpuReset;
		
		// open results file, write header
		results_file=$fopen("../out/top_results.txt");
		$fdisplay(results_file, " test_sonic_circular_buffer testbench results");
		$fwrite(results_file, "\n");
		DisplayHeader;
		
		// Write before read		
		for (cnt = 0; cnt <= 100; cnt = cnt + 1) begin
			write_enable = 1'b1;
			data_in = cnt + 128'h123456789ABCDEFFFFFFFF0000;
			@(posedge clk_write);
		end	

		for (cnt = 0; cnt <= 100; cnt = cnt + 1) begin
			if(empty == 0) read_enable = 1'b1;
			@(posedge clk_read);
		end

		
		$fclose(results_file);
		$stop;
	end

	// Add more test bench stuff here as well
	always 
	begin: Monitor
	  $timeformat(-9, 0, " ns", 9);
	  @(start_Monitor)
	  forever @(negedge clk_write)
	  begin
	//	$fstrobe(results_file,"At %t:    \t%h\t%h",$realtime, data_in, data_out);
	  end
	end


	// Test Bench Tasks
	task DisplayHeader;
	  $fdisplay(results_file,"                       data_in      data_out ");
	  $fdisplay(results_file,"                 ============================");
	endtask    

	task CpuReset;
	begin
		@ (posedge clk_write);
		reset = 0;
		@ (posedge clk_write);
		reset = 1;
		@ (posedge clk_write);
		reset = 0;
		@ (posedge clk_write);

	end
	endtask

endmodule : test_sonic_circular_buffer

