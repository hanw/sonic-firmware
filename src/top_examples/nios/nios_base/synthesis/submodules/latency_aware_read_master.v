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
	
	This latency aware read master is passed a word aligned address, length in bytes,
	and a 'go' bit.  The master will continue to post reads until the length register
	reaches a value of zero.  When all the reads return the done bit will be asserted. 

	To use this master you must simply drive the control signals into this block,
	and also read the data from the exposed read FIFO.  To read from the exposed FIFO
	use the 'user_read_buffer' signal to pop data from the FIFO 'user_buffer_data'.
	The signal 'user_data_available' is asserted whenever data is available from the
	exposed FIFO.
	
*/

// altera message_off 10230


module latency_aware_read_master (
	clk,
	reset,

	// control & status registers (CSR) slave
	avs_csr_address,
	avs_csr_readdata,
	avs_csr_write,
	avs_csr_read,
	avs_csr_writedata,

	// master inputs and outputs
	master_address,
	master_read,
	master_byteenable,
	master_readdata,
	master_readdatavalid,
	master_waitrequest
);

	parameter DATAWIDTH = 32;
	parameter BYTEENABLEWIDTH = 4;
	parameter ADDRESSWIDTH = 32;
	parameter FIFODEPTH = 32;
	parameter FIFODEPTH_LOG2 = 5;
	parameter FIFOUSEMEMORY = 1;  // set to 0 to use LEs instead
	
	localparam AVL_CONTROL = 0;
	localparam AVL_STATUS  = 1;
	localparam AVL_READ_ADDR_BASE = 2;
	localparam AVL_USER_DATA = 4;
	localparam AVL_READ_BUFFER = 5;

	input clk;
	input reset;

	// control and status register
	input [3:0]				avs_csr_address;
	input					avs_csr_write;
	input					avs_csr_read;
	input [31:0]		avs_csr_writedata;
	output reg [31:0] 	avs_csr_readdata;

	// master inputs and outputs
	input master_waitrequest;
	input master_readdatavalid;
    input [DATAWIDTH-1:0] master_readdata;
	output wire [ADDRESSWIDTH-1:0] master_address;
	output wire master_read;
	output wire [BYTEENABLEWIDTH-1:0] master_byteenable;
	
	reg control_fixed_location;
	reg [ADDRESSWIDTH-1:0] control_read_base;
	reg [ADDRESSWIDTH-1:0] control_read_length;
	reg control_go;
	wire control_done;
	wire control_early_done;  // don't use this unless you know what you are doing!
	
	// user logic inputs and outputs
	reg user_read_buffer;
	wire [DATAWIDTH-1:0] user_buffer_data;
	wire user_data_available;

	// internal control signals
	reg control_fixed_location_d1;
	wire fifo_empty;
	reg [ADDRESSWIDTH-1:0] address;
	reg [ADDRESSWIDTH-1:0] length;
	reg [FIFODEPTH_LOG2-1:0] reads_pending;
	wire increment_address;
	wire too_many_pending_reads;
	reg too_many_pending_reads_d1;
	wire [FIFODEPTH_LOG2-1:0] fifo_used;

	// filter the noise on csr bus
	reg			avs_csr_read_reg;
	reg			avs_csr_write_reg;
	reg [3:0]	avs_csr_address_reg;

	always @ (posedge clk or posedge reset) begin
		if (reset == 1) begin
			avs_csr_read_reg <= 0;
			avs_csr_write_reg <= 0;
		end
		else begin
			avs_csr_read_reg <= avs_csr_read;
			avs_csr_write_reg <= avs_csr_write;
		end
	end

//	always @ (posedge clk or posedge avs_csr_read or posedge avs_csr_write or posedge reset) begin
	always @ (posedge avs_csr_read or posedge avs_csr_write or posedge reset) begin
		if (reset == 1) begin
			avs_csr_address_reg <= 0;
		end
		else begin
			avs_csr_address_reg <= avs_csr_address;
		end
	end

	// write control of read address register
	always @ (posedge clk or posedge reset)
	begin
		if (reset == 1) begin
			control_read_base <= 32'h0;
		end
		else begin
			if (avs_csr_write_reg == 1) begin
				case (avs_csr_address_reg)
					AVL_READ_ADDR_BASE:
						control_read_base <= {avs_csr_writedata[31:2],2'b00};
				endcase
			end
		end
	end

	always @ (posedge clk)
	begin
		control_fixed_location <= 1;
		control_read_length <= 4;
	end

	// write control of go flag
	// note that this is a pulsed signal rather than a registered control bit
	//always @ (posedge clk or posedge avs_csr_write_reg) begin
	always @ (posedge clk) begin
		if ((avs_csr_write_reg == 1) && (avs_csr_address_reg == AVL_CONTROL)) begin
			control_go <= avs_csr_writedata[0];
		end
		else begin
			control_go <= 0;
		end
	end

	// write control of fifo,
	// single clock pulse.
	//always @ (posedge clk or posedge avs_csr_read) begin
	always @ (posedge clk) begin
		if ((avs_csr_read == 1) && (avs_csr_address == AVL_USER_DATA) && (user_read_buffer == 0)) begin
			user_read_buffer <= 1;
		end
		else begin
			user_read_buffer <= 0;
		end
	end

	reg [DATAWIDTH-1:0] csr_status;
	
	always @ (posedge clk or posedge reset) begin
		if (reset == 1) begin
			csr_status <= 32'h0;
		end
		else begin
			csr_status <= {{30{1'b0}}, user_data_available, control_done};
		end
	end
	
	// readdata mux
	always @ (posedge avs_csr_read_reg or posedge reset) begin
		case (avs_csr_address_reg)
			AVL_READ_ADDR_BASE:
				avs_csr_readdata <= control_read_base;
			AVL_USER_DATA:
				avs_csr_readdata <= user_buffer_data;
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

	// master address logic 
	assign master_address = address;
	assign master_byteenable = -1;  // all ones, always performing word size accesses
	always @ (posedge clk or posedge reset)
	begin
		if (reset == 1)
		begin
			address <= 0;
		end
		else
		begin
			if(control_go == 1)
			begin
				address <= control_read_base;
			end
			else if((increment_address == 1) & (control_fixed_location_d1 == 0))
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
			if(control_go == 1)
			begin
				length <= control_read_length;
			end
			else if(increment_address == 1)
			begin
				length <= length - BYTEENABLEWIDTH;  // always performing word size accesses
			end
		end
	end	
	
	// control logic
	assign too_many_pending_reads = (fifo_used + reads_pending) >= (FIFODEPTH - 4);
	assign master_read = (length != 0) & (too_many_pending_reads_d1 == 0);
	assign increment_address = (length != 0) & (too_many_pending_reads_d1 == 0) & (master_waitrequest == 0);
	assign control_done = (reads_pending == 0) & (length == 0);  // master done posting reads and all reads have returned
	assign control_early_done = (length == 0);  // if you need all the pending reads to return then use 'control_done' instead of this signal

	always @ (posedge clk)
	begin
		if (reset == 1)
		begin
			too_many_pending_reads_d1 <= 0;
		end
		else
		begin
			too_many_pending_reads_d1 <= too_many_pending_reads;
		end
	end

	

	always @ (posedge clk or posedge reset)
	begin
		if (reset == 1)
		begin
			reads_pending <= 0;
		end
		else
		begin
			if(increment_address == 1)
			begin
				if(master_readdatavalid == 0)
				begin
					reads_pending <= reads_pending + 1;
				end
				else
				begin
					reads_pending <= reads_pending;  // a read was posted, but another returned
				end			
			end
			else
			begin
				if(master_readdatavalid == 0)
				begin
					reads_pending <= reads_pending;  // read was not posted and no read returned
				end
				else
				begin
					reads_pending <= reads_pending - 1;  // read was not posted but a read returned
				end				
			end
		end
	end

	
	// read data feeding user logic	
	assign user_data_available = !fifo_empty;
	scfifo the_master_to_user_fifo (
		.aclr (reset),
		.clock (clk),
		.data (master_readdata),
		.empty (fifo_empty),
		.q (user_buffer_data),
		.rdreq (user_read_buffer),
		.usedw (fifo_used),
		.wrreq (master_readdatavalid)
	);
	defparam the_master_to_user_fifo.lpm_width = DATAWIDTH;
	defparam the_master_to_user_fifo.lpm_widthu = FIFODEPTH_LOG2;
	defparam the_master_to_user_fifo.lpm_numwords = FIFODEPTH;
	defparam the_master_to_user_fifo.lpm_showahead = "ON";
	defparam the_master_to_user_fifo.use_eab = (FIFOUSEMEMORY == 1)? "ON" : "OFF";
	defparam the_master_to_user_fifo.add_ram_output_register = "OFF";
	defparam the_master_to_user_fifo.underflow_checking = "OFF";
	defparam the_master_to_user_fifo.overflow_checking = "OFF";

endmodule
