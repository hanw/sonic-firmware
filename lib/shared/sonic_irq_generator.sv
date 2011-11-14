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
// Description :
// 
// 
//-----------------------------------------------------------------------------

module sonic_irq_generator #(
	parameter USED_QWORDS_WIDTH = 13,
	parameter USE_MSI = 1'b1
	) (
	input			clk_in,
	input			reset,

	// software reset
	input			init,

	// PCIe backend transmit section
	output			tx_req,
	input			tx_ack,
	output [127:0]  tx_desc,
	input			tx_ws,
	output reg		tx_dv,
	output			tx_dfr,
	output [127:0]	tx_data,
	output			tx_err,
	
	// Used for arbitration with other DMA
	input			tx_sel,
	output reg		tx_busy, 
	output			tx_ready,
	input			tx_ready_others,
	
	// MSI signals
	input			app_msi_ack,
	output			app_msi_req,
	input			msi_sel   ,
	output			msi_ready ,
	output			msi_busy  ,
	
	// Rx buffer usedw
	input [31:0]					rx_block_size,
	input [31:0]					rx_ring_size,
	input [`RX_WRITE_ADDR_WIDTH-1:0]	rx_ring_wptr,
	input							rdreq,

	// Tx buffer info
	input [`TX_READ_ADDR_WIDTH-1:0] tx_ring_rptr,

	// Register Interface
	input logic [63:0]	irq_base_rc,
	input logic			enable_sfp,
	input logic			irq_msi_enable,

	// Trigger to flush RC values
	input logic			force_flush_rc
	);

	localparam INTR_DATA_DWORDS  = 4;
	localparam INTR_DATA_OWORDS  = INTR_DATA_DWORDS/4;	

	enum int unsigned {IDLE_UPD_IRQ = 0, START_TX_UPD_IRQ  = 1, MWR_REQ_UPD_IRQ   = 2,
				MWR_DV_UPD_IRQ = 3, START_INTR_MSI=4, MWR_INTR_REQ_MSI=5} cstate, nstate;

	reg		rx_rc_update_req;
	reg	[7:0] irq_generated_count;

	// If the difference between msi_ptr and write_ptr is
	// larger than rx_block_size, we issue another MSI interrupt,
	// We assume that the driver takes care of the previous
	// MSI interrupt by buffering it to another queue,
	// The MSI engine just overwrite the previous MSI interrupt
	// without checking whether it has been handled.
	reg [USED_QWORDS_WIDTH-1:0]  msi_ptr;
	reg [23:0]					 msi_offset;
	reg [23:0]					 temp;

	reg [USED_QWORDS_WIDTH-1:0] rx_block_size_reg;

	// --------------------------------------------
	// INTR RC update section
	// NOTE: send interrupt data to RC via
	// PCIe MWR TLP packets
	// --------------------------------------------
	always @ (*) begin
	case (cstate)
		IDLE_UPD_IRQ:
		begin
			if ((init==1'b0) && (rx_rc_update_req==1'b1 || force_flush_rc==1'b1))
				nstate = START_TX_UPD_IRQ;
			else
				nstate = IDLE_UPD_IRQ;
		end

		START_TX_UPD_IRQ:
		begin
			if (init==1'b1)
				nstate = IDLE_UPD_IRQ;
			else if ((tx_sel==1'b1) && (tx_ws==1'b0) && (tx_ready_others==1'b0))
				nstate = MWR_REQ_UPD_IRQ;
			else
				nstate = START_TX_UPD_IRQ;
		end

		MWR_REQ_UPD_IRQ:
		begin
			if (init==1'b1)
				nstate = IDLE_UPD_IRQ;
			else if (tx_ack==1'b1)
				nstate = MWR_DV_UPD_IRQ;
			else
				nstate = MWR_REQ_UPD_IRQ;
		end

		MWR_DV_UPD_IRQ:
		begin
			if ((tx_ws==1'b0) || (tx_dv==1'b0)) begin
				if (irq_generated_count == 1) begin
					nstate = START_INTR_MSI;
				end 
				else begin
					nstate = IDLE_UPD_IRQ;
				end
			end
			else begin
				nstate = MWR_DV_UPD_IRQ;
			end
		end

		START_INTR_MSI:		
		begin
			if ((msi_sel==1'b1) && (tx_ws==1'b0))
				nstate = MWR_INTR_REQ_MSI;
			else
				nstate = START_INTR_MSI;
		end

		MWR_INTR_REQ_MSI:
		begin
			if (app_msi_ack==1'b1)
				nstate = IDLE_UPD_IRQ;
			else
				nstate = MWR_INTR_REQ_MSI;
		end

		default:
			nstate = IDLE_UPD_IRQ;
	endcase
	end

	always @ (posedge reset or posedge clk_in)
	begin
		if (reset == 1'b1)
			cstate  = IDLE_UPD_IRQ;
		else
			cstate = nstate;
	end

	//Generate MSI signal
	assign app_msi_req = (USE_MSI==0)?1'b0:(cstate==MWR_INTR_REQ_MSI)?1'b1:1'b0;
	assign msi_ready   = (USE_MSI==0)?1'b0:(cstate==START_INTR_MSI)?1'b1:1'b0;
	assign msi_busy	   = (USE_MSI==0)?1'b0:(cstate==MWR_INTR_REQ_MSI)?1'b1:1'b0;

	// ------------------------------------------------------
	// PCIE backend RC update module.
	// The tx_data field is different for irq generator
	// and command control module.
	// ------------------------------------------------------
	
	sonic_rc_update rc_update(
		.clk_in(clk_in),
		.rstn(~reset),
		.init(init),
		.tx_req(tx_req),
		.tx_ack(tx_ack),
		.tx_desc(tx_desc),
		.tx_ws(tx_ws),
		.tx_dv(tx_dv),
		.tx_dfr(tx_dfr),
		.tx_data(tx_data),
		.tx_err(tx_err),
		.tx_sel(tx_sel),
		.tx_busy(tx_busy),
		.tx_ready(tx_ready),
		.tx_ready_others(tx_ready_others),
		.cstate(cstate),
		.nstate(nstate),
		.base_rc(irq_base_rc),
		//VHDL translation_off
		.cmd_response(),
		.cmd_error_code(),
		//VHDL translation_on
		.sfp1_on(enable_sfp),
		.sfp2_on(1'b0),			//TODO: fixme
		.byte_ready(msi_offset),
		.byte_sent(32'h0),		//TODO: fixme
		.byte_dropped_tx(32'h0),
		.byte_dropped_rx(32'h0),
		.rx_ring_wptr(rx_ring_wptr),
		.tx_ring_rptr(tx_ring_rptr)
	);
	defparam rc_update.START_TX = START_TX_UPD_IRQ,
			 rc_update.MWR_REQ = MWR_REQ_UPD_IRQ,
			 rc_update.MWR_DV = MWR_DV_UPD_IRQ,
			 rc_update.MODE = `RC_UPD_IRQ_MODE;

	
	// -------------------------------------------------------
	// IRQ generation logic 
	// It should generate an interrupt after the IRQ is enabled
	// And should generate no more interrupt, until the SFP is
	// disabled and enabled again.
	// -------------------------------------------------------
	// MSI generation logic
	always @ (posedge clk_in or posedge reset or posedge init) begin
		if ((reset == 1'b1) || (init == 1'b1)) begin
			rx_rc_update_req <= 0;
			irq_generated_count <= 0;
			rx_block_size_reg <= {USED_QWORDS_WIDTH{1'b1}};
			msi_ptr <= 0;
			msi_offset <= 0;
			temp <= 0;
		end
		else if ((irq_msi_enable == 1'b1) & (enable_sfp == 1'b1)) begin

			rx_block_size_reg <= rx_block_size[USED_QWORDS_WIDTH-1:0];

			// Calculate the offset between wptr and msi_ptr.
			if (rx_ring_wptr == msi_ptr) begin
				//assume nothing to send.
				temp <= 0;
			end
			else if (rx_ring_wptr > msi_ptr) begin
				//wptr ahead of msi_ptr, assume both wrap around properly.
				temp <= (rx_ring_wptr - msi_ptr) & 24'hFFFFFC;
			end
			else if (rx_ring_wptr < msi_ptr) begin
				//wptr behind msi_ptr, assume wptr wrap around, msi_ptr not.
				temp <= (rx_ring_wptr + rx_ring_size - msi_ptr) & 24'hFFFFFC;
			end

			// Generate MSI based on msi_offset
			if (temp >= rx_block_size_reg) begin
				// Only generate irq once.
				if (irq_generated_count < 2) begin
					irq_generated_count <= irq_generated_count + 1;
				end
				
				rx_rc_update_req <= 1;
				msi_offset <= temp; //msi offset must be aligned to qword boundary.
				temp <= 0;
				if (msi_ptr + temp >= rx_ring_size)
					msi_ptr <= msi_ptr + temp - rx_ring_size;
				else
					msi_ptr <= msi_ptr + temp;
			end
			else begin
				rx_rc_update_req <= 0;
			end
		end
	end
endmodule
