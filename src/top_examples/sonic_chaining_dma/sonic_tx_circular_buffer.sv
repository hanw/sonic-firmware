// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

`include "sonic_constants.sv"
// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030
//-----------------------------------------------------------------------------
// Title         : 
// Project       : 
//-----------------------------------------------------------------------------
// File          : sonic_circular_buffer.v
// Author        : 
//-----------------------------------------------------------------------------
// Description : circular buffer that inputs 128 bits every clk_in, and generate 
// 				  40 bit every clk_out.
// 
//-----------------------------------------------------------------------------

module sonic_tx_circular_buffer # (
		parameter INPUT_WIDTH		= 128,
		parameter BUFFER_WIDTH		= 64,
		parameter OUTPUT_WIDTH		= 40
	)(
		// avalon slave port
		input logic [INPUT_WIDTH-1:0]	   write_data,
		input logic [`TX_WRITE_ADDR_WIDTH-1:0] wr_address_owords,
		input logic	wrena,
		input logic	wrreq,
		input logic rdena,

		input logic	waitrequest,
		
		input logic	tag_cpl,  // triggers the fifo output
	
		// clock and reset
		input logic reset,
		input logic rdclock,
		input logic wrclock,

		output logic [OUTPUT_WIDTH-1:0] data_out,
		// monitor signals	
		output logic empty,
		output logic full,
		output logic almost_full,
		output logic almost_empty,

		output logic [`TX_READ_ADDR_WIDTH-1:0] tx_ring_rptr
	);
	
	localparam WRITE_BYTE_WIDTH	= INPUT_WIDTH/8;
	logic [`TX_READ_ADDR_WIDTH-1:0]	 rdptr_qwords;
	logic							 rdreq;	
	logic [BUFFER_WIDTH-1:0]		 dpram_out;
	logic							 gearbox_rdreq;

	//dpram has one cycle of read delay.
	sonic_dpram_async_128_64 circbuf_dpram(
		.data(write_data),
		.rdaddress(rdptr_qwords),
		.rdclock(rdclock),
		.rden(1'b1),
		.wraddress(wr_address_owords),
		.wrclock(wrclock),
		.wren(1'b1),		//TODO: fixme
		.q(dpram_out)
	);	

	always @ (posedge reset or posedge rdclock) begin
		if (reset == 1'b1) begin
			// start at zero - pointers equal meaning empty
			rdptr_qwords <= 0;
		end
		else if ((rdreq == 1'b1) && (gearbox_rdreq == 1'b1)) begin
			rdptr_qwords <= rdptr_qwords + 1;
		end
	end	

	wire [`USED_QWORDS_WIDTH-1:0] wrusedqwords;
	wire [`USED_QWORDS_WIDTH-1:0] rdusedqwords;

	// instantiate a standard usedw calculator to do the usedw, empty, etc.
	// fifo enabled before dma starts.
	
	sonic_common_fifo_usedw_calculator usedw_calculator (
		.rdclock(rdclock),
		.wrclock(wrclock),
		.reset(reset),
		.wrreq(wrreq),
		.wrena(wrena),
//		.rdreq(rdreq),
		.rdreq(gearbox_rdreq & rdreq),
		.rdena(rdena),
		.wrusedqwords(wrusedqwords),
		.full(full),
		.almost_full(almost_full),
		.rdusedqwords(rdusedqwords),
		.clock_crossed_wptr(),
		.clock_crossed_rptr(tx_ring_rptr),
		.empty(empty),
		.almost_empty(almost_empty)
	);
	defparam usedw_calculator.WIDTH = `USED_QWORDS_WIDTH,
			 usedw_calculator.QWORD_DEPTH = `RING_DEPTH_QWORDS,
			 usedw_calculator.UPSTREAM = 0,
			 usedw_calculator.READ_TO_WRITE_DELAY = 0,
			 usedw_calculator.WRITE_TO_READ_DELAY = 0;	//covered by crossing domain delay
	
	// -------------------------------------------------------
	// Stuff in the RD clock domain
	// -------------------------------------------------------
	// Cross clock domain fifo, as synchronizer, 
	// Reuse the gray code crosser, with WIDTH=1.
	wire rd_tag_cpl;
	
	sonic_common_signal_clock_crosser cpl_crosser(
		.inclock(wrclock),
		.outclock(rdclock),
		.inena(1'b1),
		.outena(1'b1),
		.reset(reset),
		.data(tag_cpl),
		.q(rd_tag_cpl)
	);
	defparam cpl_crosser.WIDTH=1,
			 cpl_crosser.SHIFT_REGISTER_LENGTH=8;

	reg [`USED_QWORDS_WIDTH-1:0] rd_cpld_qword_count;
	
	always @ (posedge rdclock or posedge reset) begin
		if (reset == 1'b1) begin
			rd_cpld_qword_count <= 0;
		end
		else begin
			if(rd_tag_cpl == 1'b1) begin
				if(gearbox_rdreq == 1'b1) begin
					//prevent rd_cpld_qword_count from underflow
					if (rdusedqwords - 1 > rdusedqwords)
						rd_cpld_qword_count <= rdusedqwords;
					else
						rd_cpld_qword_count <= rdusedqwords - 1;
				end
				else begin
					rd_cpld_qword_count <= rdusedqwords;
				end
			end
			else begin
				if (gearbox_rdreq == 1'b1) begin
					//prevent rd_cpld_qword_count from underflow
					if (rd_cpld_qword_count - 1 > rd_cpld_qword_count)
						rd_cpld_qword_count <= rd_cpld_qword_count;
					else
						rd_cpld_qword_count <= rd_cpld_qword_count - 1;
				end
			end
		end
	end

	always @ (posedge rdclock or posedge reset) begin
		if (reset == 1'b1) begin
			rdreq <= 1'b0;
		end 
		else begin
			if (rd_cpld_qword_count > 0)
				rdreq <= 1'b1;
			else
				rdreq <= 1'b0;
		end
	end

	// ----------------------------------------------------------
	// Gearbox 64 to 40
	// ----------------------------------------------------------
	
	reg gearbox_ena;
	
	always @ (posedge rdclock) begin
		gearbox_ena <= rdreq;
	end

	sonic_downstream_gearbox gearbox_downstream (
		.clk(rdclock),
		.reset(reset),
		.rdreq(gearbox_rdreq),
		.ena(gearbox_ena),
		.data_in(dpram_out),
		.data_out(data_out)
	);
	defparam gearbox_downstream.INPUT_WIDTH=BUFFER_WIDTH,
			 gearbox_downstream.OUTPUT_WIDTH=OUTPUT_WIDTH;

endmodule

