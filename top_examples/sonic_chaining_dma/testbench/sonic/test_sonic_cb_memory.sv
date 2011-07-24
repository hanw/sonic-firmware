/*****************************************************************

 test_sonic_cb_memory.sv module

******************************************************************

******************************************************************

 created on:	4/29/2011 
 created by:	hwang
 last edit on:	$DateTime: $ 
 last edit by:	$Author: $
 revision:	$Revision: $
 comments:	Generated

******************************************************************
 //Project// (//Number//)

 This module implements the test bench for the ../../sonic_cb_memory.sv module.

	// enter detailed description here;


******************************************************************/
`timescale        1ns/1ps

module    test_sonic_cb_memory        (
	MemoryInterface.reader reader,
	MemoryInterface.writer writer
    );

	logic rst_n;
	logic clk;
	event start_Monitor;

	// *** Local Integer Declarations ***
	integer		results_file;	// for writing signal values
	int cnt;
	logic [7:0] data_read ;

	assign clk = writer.clk;

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
		$fdisplay(results_file, " test_sonic_cb_memory testbench results");
		$fwrite(results_file, "\n");
		DisplayHeader;
		
		$display("At: %t: start writing", $realtime);
		// Add more test bench stuff here
		for(cnt = 0; cnt < 100; cnt++) begin
			WriteMem(cnt, cnt*2);
		end
		
	    $display("At: %t: start reading back", $realtime);
		for(cnt = 0; cnt < 100; cnt++) begin
			ReadMem(cnt, data_read);
			if (data_read != cnt*2) begin
				$display("Data error at cnt = %d, value = %d", cnt, data_read);
			end
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

	task WriteMem(input logic[12:0] address, input logic[7:0] data);
	begin
	  writer.address[4] = address;
	  writer.data[4] = data;
	  writer.enable[4] = 1'b1;
	  @(posedge writer.clk);
	end
	endtask

	task ReadMem(input logic[12:0] address, output logic[7:0] data);
	begin
	  reader.address[4] = address;
	  reader.enable[4] = 1'b1;
	  data = reader.data[4];
	  @(posedge reader.clk);
	end
	endtask


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

endmodule : test_sonic_cb_memory



