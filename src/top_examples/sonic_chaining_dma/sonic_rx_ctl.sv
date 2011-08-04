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
// File          : 
// Author        : 
//-----------------------------------------------------------------------------
// Description : This module contains the rx buffer, rx configuration
// registers and rx buffer control logic. 
// The following fuctions are supported via the register interface to command
// module:
// - Enable / disable Rx MSI interrupt
// - Enable / disable Rx circular buffer
// - Get the count of buffered data in Rx Ring
// - Get the count of dropped data in Rx Ring
// - 
// 
//-----------------------------------------------------------------------------

module sonic_rx_ctl (
	// data
	input logic								wr_clock,
	input logic								rd_clock,
	input logic								reset,
	input logic [`RX_READ_ADDR_WIDTH-1:0]	rd_address_owords,
	input logic								rd_req,
	output logic [127:0]					rd_data,
	input logic [39:0]						wr_data,

	// prg_reg
	input logic								enable_sfp,
	output logic [`USED_QWORDS_WIDTH-1:0]	rx_ring_wptr
/*	
	// PCIe
	output logic			tx_req,
	input  logic			tx_ack,
	output logic [127:0]	tx_desc,
	input  logic			tx_ws,
	output logic			tx_dfr,
	output logic			tx_dv,
	output logic [127:0]	tx_data,
	output logic			tx_err,
	
	input logic 			tx_sel,
	output logic			tx_busy,
	output logic			tx_ready,
	input logic				tx_ready_others,
	
	// MSI
	input logic				app_msi_ack,
	output logic			app_msi_req,
	output logic [2:0]		app_msi_tc,
	output logic [4:0]		app_msi_num,
	input logic				msi_sel,
	output					msi_ready,
	output					msi_busy,

	// TX info
	input logic [`TX_WRITE_ADDR_WIDTH-1:0]	tx_ring_wptr,

	output logic [31:0]			rx_block_size,


	input logic				irq_prg_wrena,
	input logic [31:0]		irq_prg_wrdata,
	input logic [7:0]		irq_prg_addr,
	output logic [31:0]		irq_prg_rddata

*/
	);

	// signals for controlling circular buffer
	wire rx_empty;
	wire rx_full;
	wire rx_almost_full;
	wire rx_almost_empty;

	wire wrena;
	wire wrreq;
	wire rdena;
	reg wrena_reg;
	reg wrreq_reg;
	reg rdena_reg;

/*
	wire [63:0] irq_base_rc;
	wire		irq_msi_enable;
*/

	assign wrena = wrena_reg;
	assign wrreq = wrreq_reg;
	assign rdena = rdena_reg;
	
	logic [`USED_QWORDS_WIDTH-1:0] rxusedqwords;
/*
	logic [`USED_QWORDS_WIDTH-1:0] rx_ring_wptr;
//	logic [31:0] rx_block_size;
	logic [31:0] rx_ring_size;
*/

	always @(posedge reset or posedge wr_clock) begin
		if (reset == 1'b1) begin
			wrena_reg		= 1'b0;
			wrreq_reg		= 1'b0;		
			rdena_reg		= 1'b0;
		end
		else begin
			wrena_reg		= 1'b1 & ~rx_full;
			wrreq_reg		= enable_sfp;
			rdena_reg		= 1'b1;
		end
	end

	// sonic circular buffer on rx path
	sonic_rx_circular_buffer ep_rx_dpram (
		.read_data		(rd_data),	
		.rd_address_owords	(rd_address_owords),	
		.rdena			(rdena),				 
		.rdreq			(rd_req & ~rx_empty),	//TODO: fix corner case				 
		.rdusedqwords	(rxusedqwords),
		.rx_ring_wptr	(rx_ring_wptr),
		.waitrequest	(),				 
		.reset			(reset | ~enable_sfp),  //reset sonic_rx_buffer if sfp not enabled.		
//		.reset			(1'b1),  //Hold rx circular buffer in reset, so we could debug other components.		
		.rdclock		(rd_clock),	
		.wrclock		(wr_clock),	
		.wrena			(wrena),		
		.wrreq			(wrreq),	
		.data_in		(wr_data),		
		.empty			(rx_empty),		
		.full			(rx_full),			
		.almost_full	(rx_almost_full),	
		.almost_empty	(rx_almost_empty)
	);
	defparam ep_rx_dpram.INPUT_WIDTH	= 40,
			 ep_rx_dpram.BUFFER_WIDTH	= 64,
			 ep_rx_dpram.OUTPUT_WIDTH	= 128;

/*

	wire init;
	// -----------------------------------------------------------
	//  rx irq generation
	// -----------------------------------------------------------
	sonic_irq_generator irq_gen(
		.clk_in(rd_clock),
		.reset(reset),
		.init(init),

		.tx_req(tx_req),
		.tx_ack(tx_ack),
		.tx_desc(tx_desc),
		.tx_dfr(tx_dfr),
		.tx_dv(tx_dv),
		.tx_ws(tx_ws),
		.tx_data(tx_data),
		.tx_err(tx_err),
		.tx_sel(tx_sel),
		.tx_busy(tx_busy),
		.tx_ready(tx_ready),
		.tx_ready_others(tx_ready_others),

		.app_msi_ack(app_msi_ack),	
		.app_msi_req(app_msi_req),
		.msi_sel(msi_sel),
		.msi_ready(msi_ready),
		.msi_busy(msi_busy),

		//send the count of current outstanding bytes,
		//equals the difference between current Wptr and last Mptr.
		.rx_ring_size(1 << `USED_QWORDS_WIDTH),
		.rx_ring_wptr(rx_ring_wptr),
		.rx_block_size(rx_block_size),
		.rdreq(rd_req),

		//Tx info
		.tx_ring_wptr(tx_ring_wptr),

		// prg_reg
		.irq_base_rc(irq_base_rc),
		.enable_sfp(enable_sfp),
		.irq_msi_enable(irq_msi_enable)
	);
	defparam irq_gen.USED_QWORDS_WIDTH = `USED_QWORDS_WIDTH,
			 irq_gen.USE_MSI	 = 1'b1;
		
	
	// -------------------------------------------------------
	// IRQ control registers
	//
	// -------------------------------------------------------
	sonic_irq_prg_reg irq_prg_reg (
		.clk_in(rd_clock),
		.rstn(rstn),
		.irq_prg_wrena(irq_prg_wrena),
		.irq_prg_wrdata(irq_prg_wrdata),
		.irq_prg_addr(irq_prg_addr),
		.irq_prg_rddata(irq_prg_rddata),
		.irq_base_rc(irq_base_rc),
		.irq_msi_enable(irq_msi_enable),
		.app_msi_num(app_msi_num),	
		.app_msi_tc(app_msi_tc),
		.rx_block_size(rx_block_size),
		.init(init)
	);
	defparam irq_prg_reg.RC_64BITS_ADDR = 1'b1,
			 irq_prg_reg.AVALON_ST_128 = 1'b1;

*/


endmodule
