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
// Description :  The RX buffer is a combination of 64-to-128 ring buffer
//				  and a 40-to-64 gearbox.
//
//				  Overall, the rx buffer receives 40 bits every clock tick
// 				  send 128 bits to RC.
// 
//-----------------------------------------------------------------------------

module sonic_rx_circular_buffer # (
		parameter INPUT_WIDTH		= 40,
		parameter BUFFER_WIDTH		= 64,
		parameter OUTPUT_WIDTH		= 128
	)(
		// xcvr_in
		input logic	wrena,
		input logic	wrreq,	
		input logic [INPUT_WIDTH-1:0] data_in,

		// Avalon slave port
		output logic [OUTPUT_WIDTH-1:0]	  read_data,	// output
		input logic [`RX_READ_ADDR_WIDTH-1:0] rd_address_owords,	// managed by the DMA block outside the Ring, sadly
		input logic rdena,		// serves as the clkena signal for RAM block, always 1
		input logic rdreq,		// for usedw counting
		input logic	waitrequest,	//this is driven to zero by the DMA write requester

		// clock and reset
		input logic reset,
		input logic rdclock,
		input logic wrclock,

		// monitors	
		output logic empty,
		output logic full,
		output logic almost_full,
		output logic almost_empty,

		// usedw
		output logic [`USED_QWORDS_WIDTH-1:0] rdusedqwords,
		output logic [`USED_QWORDS_WIDTH-1:0] rx_ring_wptr
	);
	
	localparam READ_BYTE_WIDTH	= OUTPUT_WIDTH/8;
	// note that address can be one bit narrower than usedw (if QWORD_DEPTH is
	// a power of two

	// pointers into the ram used for reading and writing
	logic [`RX_WRITE_ADDR_WIDTH-1:0] wrptr_qwords;
	
	logic [BUFFER_WIDTH-1:0] gearbox_out;

	logic gearbox_datavalid;

	// Writing to the receive ring is controlled by:
	// - the validity of data from xcvr
	// - the full signal of the buffer
	// - the enable signal from SoNIC
	sonic_dpram_async_64_128 circbuf_dpram(
		.data(gearbox_out),
		.wraddress(wrptr_qwords),		//FIX
		.wrclock(wrclock),
		.wren(gearbox_datavalid),
		.rdaddress(rd_address_owords),	//FIX
		.rdclock(rdclock),
		.rden(1'b1),				// Fix
		.q(read_data)
	);
	// Generate write address
	// Write address should be set by the DMA engine
	// Write address increments on every completion
	// the data in the ram does not move
	// two pointers, head and tail, chase each other through the ram
	// and define the extent of the fifo
	// if the read pointer catches up with the write pointer, then the fifo is
	// empty
	// if the write pointer catches up with the read pointer, then the fifo is
	// full
	// note that there is no protection here, reading from an empty fifo
	// or writing to a full one will cause undefined results.
	// two counters driven by different clock,
	// when comparing them, we use the upper 13 bits or so.
	// write address first
	always @ (posedge reset or posedge wrclock) begin
		if (reset == 1'b1) begin
			// start at zero - pointers equal meaning empty
			wrptr_qwords <= 0;	
		end
		else if ((wrena == 1'b1) && (wrreq == 1'b1) && (full != 1'b1) && gearbox_datavalid) begin
			wrptr_qwords <= wrptr_qwords + 1;
		end
	end

	wire [`USED_QWORDS_WIDTH-1:0] wrusedqwords;

	// instantiate a standard usedw calculator to do the usedw, empty, etc.
	// updating
	sonic_common_fifo_usedw_calculator usedw_calculator (
		.rdclock(rdclock),
		.wrclock(wrclock),
		.reset(reset),
		.wrena(wrena),
		.wrreq(wrreq & gearbox_datavalid),	
						//it should only increment when the data 
						//write to the fifo is valid.
		.rdreq(rdreq),
		.rdena(rdena),
		.wrusedqwords(wrusedqwords),
		.full(full),
		.almost_full(almost_full),
		.rdusedqwords(rdusedqwords),
		.clock_crossed_wptr(rx_ring_wptr),
		.clock_crossed_rptr(),
		.empty(empty),
		.almost_empty(almost_empty)
	);
	defparam usedw_calculator.WIDTH = `USED_QWORDS_WIDTH,
			 usedw_calculator.QWORD_DEPTH = `RING_DEPTH_QWORDS,
			 usedw_calculator.UPSTREAM = 1,
			 usedw_calculator.READ_TO_WRITE_DELAY = 0,
			 usedw_calculator.WRITE_TO_READ_DELAY = 0;	//covered by crossing domain delay
	
	// ----------------------------------------------------------
	// Rx Gearbox 
	// ----------------------------------------------------------
	sonic_upstream_gearbox gearbox_upstream (
		.clk(wrclock),
		.reset(reset),	
		.data_in(data_in),
		.data_out(gearbox_out),
		.data_valid(gearbox_datavalid)
	);
	defparam gearbox_upstream.INPUT_WIDTH=INPUT_WIDTH,
			 gearbox_upstream.OUTPUT_WIDTH=BUFFER_WIDTH;
endmodule
