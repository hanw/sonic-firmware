/*
  Legal Notice: (C)2007 Altera Corporation. All rights reserved.  Your
  use of Altera Corporation's design tools, logic functions and other
  software and tools, and its AMPP partner logic functions, and any
  output files any of the foregoing (including device programming or
  simulation files), and any associated documentation or information are
  expressly subject to the terms and conditions of the Altera Program
  License Subscription Agreement or other applicable license agreement,
  including, without limitation, that your use is for the sole purpose
  of programming logic devices manufactured by Altera and sold by Altera
  or its authorized distributors.  Please refer to the applicable
  agreement for further details.
*/

/*

	Author:  JCJB
	Date:  11/04/2007
	
	This simple write master is passed a word aligned address, length in bytes,
	and a 'go' bit.  The master will continue to post writes until the length register
	reaches zero.  When the length register reaches zero the 'done' bit is asserted. 

	To use this master you must simply drive the control signals into this block,
	and also write the data to the exposed write FIFO.  To read from the exposed FIFO
	use the 'user_write_buffer' signal to push data into the FIFO 'user_buffer_data'.
	The signal 'user_buffer_full' is asserted whenever the exposed buffer is full.
	You should not attempt to write data to the exposed FIFO if it is full.
	
*/


// altera message_off 10230

module write_master (
	clk,
	reset,
	
	// control inputs and outputs
/*
	control_fixed_location,
	control_write_base,
	control_write_length,
	control_go,
	control_done,
	
	// user logic inputs and outputs
	user_write_buffer,
	user_buffer_data,
	user_buffer_full,
*/	
	// control & status registers (CSR) slave
	avs_csr_address,
	avs_csr_readdata,
	avs_csr_write,
	avs_csr_writedata,

	// master inputs and outputs
	master_address,
	master_write,
	master_byteenable,
	master_writedata,
	master_waitrequest
);


	parameter DATAWIDTH = 32;
	parameter BYTEENABLEWIDTH = 4;
	parameter ADDRESSWIDTH = 32;
	parameter FIFODEPTH = 32;
	parameter FIFODEPTH_LOG2 = 5;
	parameter FIFOUSEMEMORY = 1;  // set to 0 to use LEs instead
	
	localparam AVL_CONTROL			= 4'h0;
	localparam AVL_STATUS			= 4'h1;
	localparam AVL_WRITE_ADDR_BASE	= 4'h3;
	localparam AVL_USER_DATA		= 4'h4;
	localparam AVL_WRITE_BUFFER		= 4'h5;
	
	input clk;
	input reset;

	// control and status register
	input [3:0]			avs_csr_address;
	input				avs_csr_write;
	input [31:0]		avs_csr_writedata;
	output reg [31:0] 	avs_csr_readdata;
	// master inputs and outputs
	input master_waitrequest;
	output wire [ADDRESSWIDTH-1:0] master_address;
	output wire master_write;
	output wire [BYTEENABLEWIDTH-1:0] master_byteenable;
	output wire [DATAWIDTH-1:0] master_writedata;

	reg control_fixed_location;  // this only makes sense to enable when MAXBURSTCOUNT = 1
	reg [ADDRESSWIDTH-1:0] control_write_base;
	reg [ADDRESSWIDTH-1:0] control_write_length;
	reg control_go;
	wire control_done;
	
	// user logic inputs and outputs
	reg user_write_buffer;
	reg [DATAWIDTH-1:0] user_buffer_data;
	wire user_buffer_full;
	
	// internal control signals
	reg control_fixed_location_d1;
	reg [ADDRESSWIDTH-1:0] address;  // this increments for each word
	reg [ADDRESSWIDTH-1:0] length;
	wire increment_address;  // this increments the 'address' register when write is asserted and waitrequest is de-asserted
	wire read_fifo;
    wire user_buffer_empty;

	// write control of write address register
	always @ (posedge clk or posedge reset)
	begin
		if (reset == 1) begin
			control_write_base <= 32'h0;
		end
		else begin
			if (avs_csr_write == 1) begin
				case (avs_csr_address)
					AVL_WRITE_ADDR_BASE:
                        // write address is for 32-bit dwords.
						control_write_base <= avs_csr_writedata;
					AVL_USER_DATA:
						user_buffer_data <= avs_csr_writedata;
				endcase
			end
		end
	end

	always @ (posedge clk)
	begin
		control_fixed_location <= 1;
		control_write_length <= 4;
	end

	// write control of go flag
	// note that this is a pulsed signal rather than a registered control bit
//	always @ (posedge clk or posedge avs_csr_write) begin
	always @ (posedge clk) begin
		if ((avs_csr_write == 1) && (avs_csr_address == AVL_CONTROL)) begin
			control_go <= avs_csr_writedata[0];
		end
		else begin
			control_go <= 0;
		end
	end

	// write control of fifo
//	always @ (posedge clk or posedge avs_csr_write) begin
	always @ (posedge clk) begin
		if ((avs_csr_write == 1) && (avs_csr_address == AVL_WRITE_BUFFER)) begin
			user_write_buffer <= avs_csr_writedata[0];
		end
		else begin
			user_write_buffer <= 0;
		end
	end

	reg [DATAWIDTH-1:0] csr_status;
	
	always @ (posedge clk or posedge reset) begin
		if (reset == 1) begin
			csr_status <= 32'h0;
		end
		else begin
			csr_status <= {{29{1'b0}}, user_buffer_full, user_buffer_empty, control_done};
		end
	end

	// readdata mux
	always @ (avs_csr_address or csr_status or control_write_base) begin
	//always @ (posedge clk or posedge reset) begin
        case (avs_csr_address)
            AVL_WRITE_ADDR_BASE:
                avs_csr_readdata <= control_write_base;
            default:
                avs_csr_readdata <= csr_status;
        endcase
	end

	// registering the control_fixed_location bit
	always @ (posedge clk or posedge reset)
	begin
		if (reset == 1)
		begin
			control_fixed_location_d1 <= 0;
		end
		else
		begin
			if (control_go == 1)
			begin
				control_fixed_location_d1 <= control_fixed_location;
			end
		end
	end



	// master word increment counter
	always @ (posedge clk or posedge reset)
	begin
		if (reset == 1)
		begin
			address <= 0;
		end
		else
		begin
			if (control_go == 1)
			begin
				address <= control_write_base;
			end
			else if ((increment_address == 1) & (control_fixed_location_d1 == 0))
			begin
				address <= address + BYTEENABLEWIDTH;  // always performing word size accesses
			end
		end
	end


	// master length logic
	always @ (posedge clk or posedge reset)
	begin
		if (reset == 1)
		begin
			length <= 0;
		end
		else
		begin
			if (control_go == 1)
			begin
				length <= control_write_length;
			end
			else if (increment_address == 1)
			begin
				length <= length - BYTEENABLEWIDTH;  // always performing word size accesses
			end
		end
	end



	// controlled signals going to the master/control ports
	assign master_address = address;
	assign master_byteenable = -1;  // all ones, always performing word size accesses
	assign control_done = (length == 0);
	assign master_write = (user_buffer_empty == 0) & (control_done == 0);

	assign increment_address = (user_buffer_empty == 0) & (master_waitrequest == 0) & (control_done == 0);
	assign read_fifo = increment_address;

	// write data feed by user logic
	scfifo the_user_to_master_fifo (
		.aclr (reset),
		.clock (clk),
		.data (user_buffer_data),
		.full (user_buffer_full),
		.empty (user_buffer_empty),
		.q (master_writedata),
		.rdreq (read_fifo),
		.wrreq (user_write_buffer)
	);
	defparam the_user_to_master_fifo.lpm_width = DATAWIDTH;
	defparam the_user_to_master_fifo.lpm_numwords = FIFODEPTH;
	defparam the_user_to_master_fifo.lpm_showahead = "ON";
	defparam the_user_to_master_fifo.use_eab = (FIFOUSEMEMORY == 1)? "ON" : "OFF";
	defparam the_user_to_master_fifo.add_ram_output_register = "OFF";
	defparam the_user_to_master_fifo.underflow_checking = "OFF";
	defparam the_user_to_master_fifo.overflow_checking = "OFF";

endmodule
