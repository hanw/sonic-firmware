// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1 ps / 1 ps
module alt_mutex_acq #(
	parameter mutex_wait_time = 101,
	parameter mutex_wait_time_cntr_width = 7, // do we need this parameter?
	parameter addr_width = 5,
    parameter data_width = 32,
    parameter read_mutex_addr_offset = 0 // address of the mutex word
)
(

input wire clk,        // this will be the reconfig clk
input wire reset,

// Internal interface for the bigger controlling module, like analog reconfig
input wire [addr_width-1:0] address,             // MM address
input wire [data_width-1:0] writedata,
input wire write,
input wire read,
output reg waitrequest,    // can use to tell internal master to wait when auto-request+release
output wire [data_width-1:0] readdata,

 
// MM master external interface, that connects to mutex-slave, like the reconfig_basic block
output wire [addr_width-1:0] master_address,             // MM address
output wire [data_width-1:0] master_writedata,
output wire master_write,
output wire master_read,
input wire master_waitrequest,    // needed for a valid master interface
input wire [data_width-1:0] master_readdata,      // from mutex-slave

  

// request mutex access and should be held high as long as mutex is used
input wire mutex_req,
// output indicating whether mutex access was granted or not
output reg mutex_grant  

);



localparam IDLE = 2'b00;
localparam GET_MUTEX = 2'b01;
localparam RELEASE_MUTEX = 2'b10;

(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [1:0] state;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg  [9:0] mutex_timeout_cntr;

(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *) // should we make this variable
reg  [mutex_wait_time_cntr_width-1:0] mutex_wait_cntr;

(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [addr_width-1:0] mutex_int_address;             // MM address
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [data_width-1:0] mutex_int_writedata;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg mutex_int_write;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg mutex_int_read;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg do_base_readwrite;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=HIGH"} *)
reg mutex_mux_ctrl;

// synopsys translate_off
initial
begin
	mutex_grant = 0;
	mutex_mux_ctrl = 1'b1;
    mutex_timeout_cntr = 0;
    mutex_wait_cntr = 0;
    mutex_int_address = 0;
    mutex_int_writedata = 0;
    mutex_int_read = 0;
    mutex_int_write = 0;
    waitrequest = 0;
    do_base_readwrite = 0;
    state = 0;
end
// synopsys translate_on

always @(posedge clk or posedge reset)
begin
    if (reset === 1'b1)
    begin
		mutex_grant <= 0;
		mutex_mux_ctrl <= 1'b1;
		mutex_timeout_cntr <= 0;
		mutex_wait_cntr <= 0;
		mutex_int_address <= 'b0;
		mutex_int_writedata <= 'b0;
		mutex_int_read <= 'b0;
		mutex_int_write <= 'b0;
		waitrequest <= 'b0;
		do_base_readwrite <= 'b0;
		state <= 'b0;
    end
    else begin
		case (state)
		IDLE:begin  
// fix SPR:343567 - Avalon slaves are permitted to keep waitrequest asserted during idle cycles.
//                  The state machine will still work correctly by simply removing this condition.
//                  The next state is GET_MUTEX, and it will wait there if waitrequest is legitimately asserted.
//			if (master_waitrequest == 1'b1)
//				state <= IDLE; // wait till the waitrequest goes low
//			else if (mutex_grant == 0 &&
			if (mutex_grant == 0 &&
				(mutex_req == 1'b1 || write == 1'b1 || read == 1'b1))
			begin
				state <= GET_MUTEX;
				mutex_int_read <= 1'b1;
				mutex_int_address <= read_mutex_addr_offset;			
				mutex_int_write <= 1'b0;
				mutex_wait_cntr <= 0;
				mutex_mux_ctrl <= 1'b1;
				waitrequest <= 1'b1; // pull the waitrequest high
				if (write == 1'b1 || read == 1'b1)
					do_base_readwrite <= 1'b1;
				else
					do_base_readwrite <= 1'b0;
			end
			else if (mutex_grant == 1'b1)
			begin
				do_base_readwrite <= 1'b0;
				if (mutex_req == 1'b1 || write == 1'b1 || read == 1'b1)
				begin
					mutex_mux_ctrl <= 1'b0; // relinquish control of the mux
					if (write == 1'b1 || read == 1'b1)								
						waitrequest <= master_waitrequest;
					else
						waitrequest <= 1'b0;
					if (read == 1'b1 || write == 1'b1)
						mutex_timeout_cntr <= 0;
					else if (mutex_timeout_cntr == 10'd1000)
						state <= RELEASE_MUTEX;
					else
						mutex_timeout_cntr <= mutex_timeout_cntr[9:0] + 10'b1;
				end
				else
					state <= RELEASE_MUTEX;
			end
			else
			begin
				mutex_mux_ctrl <= 1'b1; // choke the inputs going to basic as mux is not available
				mutex_int_read <= 1'b0;
				mutex_int_write <= 1'b0;
				waitrequest <= 1'b0;
			end
		end
		RELEASE_MUTEX: begin
			// release the mutex
			mutex_mux_ctrl <= 1'b1;
			mutex_int_read <= 1'b0;
			mutex_int_write <= 1'b1;
			mutex_int_address <= read_mutex_addr_offset;
			mutex_int_writedata <= 16'b0;
			mutex_grant <= 1'b0;		
			state <= IDLE;
			mutex_timeout_cntr <= 0;
			waitrequest <= 1'b0;
		end
        GET_MUTEX: begin
			if (master_waitrequest == 1'b1) // wait in this state itself
			begin
				state <= GET_MUTEX;
			end
			else if (mutex_int_read == 1'b1 && master_readdata[0] == 1'b0)   // check mutex bit
			begin
   				mutex_grant <= 1; // mutex is available
       			state <= IDLE;
				mutex_int_read <= 1'b0; // reset the read and mux ctrl bits
				mutex_mux_ctrl <= 0;
				if (do_base_readwrite == 1'b1)
					waitrequest <= master_waitrequest;					
				else
					waitrequest <= 1'b0;
			end
			else if (mutex_wait_cntr != mutex_wait_time)
			begin // continue waiting till the wait time is hit
				mutex_wait_cntr <= mutex_wait_cntr[mutex_wait_time_cntr_width-1:0] + 1;
				mutex_int_read <= 1'b0; // pull down the read
				state <= GET_MUTEX;
			end
			else // try and read again
			begin
				mutex_wait_cntr <= 0; // reset the wait cntr and try and read again
				mutex_int_read <= 1'b1;
				state <= GET_MUTEX;
			end
        end
        default: begin
			state <= IDLE;
		end	
		endcase
    end
    
end


assign master_address = mutex_mux_ctrl ? mutex_int_address : address;
assign master_writedata = mutex_mux_ctrl ? mutex_int_writedata : writedata;
assign master_write = mutex_mux_ctrl ? mutex_int_write : write;
assign master_read = mutex_mux_ctrl ? mutex_int_read : read;
assign readdata = master_readdata; // pipe the readdata out

endmodule
