// /**
//  * This Verilog HDL file is used for simulation and synthesis in
//  * the chaining DMA design example. It contains the descriptor header
//  * table registers which get programmed by the software application.
//  */
// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on
`include "sonic_constants.sv"
// synthesis verilog_input_version verilog_2001
// turn off superfluous verilog processor warnings
// altera message_level Level1
// altera message_off 10034 10035 10036 10037 10230 10240 10030

//-----------------------------------------------------------------------------
// Title         : sonic_reg_access
// Project       : PCI Express MegaCore function
//-----------------------------------------------------------------------------
// File          : sonic_reg_access.v
// Author        : Altera Corporation
//-----------------------------------------------------------------------------
//
//  Description:  This module contains the Address decoding for BAR2/3
//                address space.
//-----------------------------------------------------------------------------
// Copyright (c) 2009 Altera Corporation. All rights reserved.  Altera products are
// protected under numerous U.S. and foreign patents, maskwork rights, copyrights and
// other intellectual property laws.
//
// This reference design file, and your use thereof, is subject to and governed by
// the terms and conditions of the applicable Altera Reference Design License Agreement.
// By using this reference design file, you indicate your acceptance of such terms and
// conditions between you and Altera Corporation.  In the event that you do not agree with
// such terms and conditions, you may not use the reference design file. Please promptly
// destroy any copies you have made.
//
// This reference design file being provided on an "as-is" basis and as an accommodation
// and therefore all warranties, representations or guarantees of any kind
// (whether express, implied or statutory) including, without limitation, warranties of
// merchantability, non-infringement, or fitness for a particular purpose, are
// specifically disclaimed.  By making this reference design file available, Altera
// expressly does not recommend, suggest or require that this reference design file be
// used in combination with any other product not provided by Altera.
//-----------------------------------------------------------------------------


module sonic_reg_access   (
	input             clk_in,
	input             rstn,
	input             sel_ep_reg,
	input             reg_wr_ena,         // pulse.  register write enable
	input             reg_rd_ena,
	input [7:0]       reg_rd_addr,        // register byte address (BAR 2/3 is 256 bytes)
	input [7:0]       reg_wr_addr,
	input [31:0]      reg_wr_data,        // register data to be written

	input [31:0]      dma_rd_prg_rddata,
	input [31:0]      dma_wr_prg_rddata,
	input [31:0]	  irq_prg_rddata,
	input [31:0]	  cmd_prg_rddata,
	
	input [15:0]      rx_ecrc_bad_cnt,
	input [63:0]      read_dma_status,
	input [63:0]      write_dma_status,

	output reg [31:0] prg_wrdata,		// data to write
	output reg [7:0]  prg_addr,			// address of reg to write (offset from BAR2 base)
	output reg [31:0] reg_rd_data,			// register read data
	output reg        reg_rd_data_valid,	// pulse.  means reg_rd_data is valid
	output reg        dma_rd_prg_wrena,		// wrena for dma_rd reg
	output reg        dma_wr_prg_wrena,		// wrena for dma_wr reg
	output reg		  irq_prg_wrena,		// wrena for rx irq generator
	output reg		  cmd_prg_wrena		// wrena for cmd module
	);

	// Module Address Decode - 2 MSB's
	localparam DMA_WRITE_PRG = 4'h0;
	localparam DMA_READ_PRG  = 4'h1;
	localparam MISC          = 4'h2;
	localparam ERR_STATUS    = 4'h3;
	localparam RX_IRQ		 = 4'h4;		
	localparam COMMAND		 = 4'h5;
	localparam CMD_RESP		 = 4'h6;

	// MISC address space
	localparam WRITE_DMA_STATUS_REG_HI = 4'h0;
	localparam WRITE_DMA_STATUS_REG_LO = 4'h4;
	localparam READ_DMA_STATUS_REG_HI  = 4'h8;
	localparam READ_DMA_STATUS_REG_LO  = 4'hc;

	// RX_IRQ address space
	localparam CNTL_FIELD	= 4'h0;
	localparam IRQ_ADDR_HI	= 4'h4;
	localparam IRQ_ADDR_LO	= 4'h8;
	localparam IRQ_SIZE		= 4'hC;

	// COMMAND address space
	localparam CMD_TYPE		= 4'h0;
	localparam CMD_PARAM0   = 4'h4;
	localparam CMD_PARAM1   = 4'h8;
	localparam CMD_PARAM2   = 4'hc;

	// CMD_RESP
	localparam ADDR_MSW     = 4'h0;
	localparam ADDR_LSW     = 4'h4;

	reg [31:0] err_status_reg;
	reg [63:0] read_dma_status_reg;
	reg [63:0] write_dma_status_reg;
	reg [31:0] dma_rd_prg_rddata_reg;
	reg [31:0] dma_wr_prg_rddata_reg;
	reg [31:0] irq_prg_rddata_reg;
	reg [31:0] cmd_prg_rddata_reg;

	reg             reg_wr_ena_reg;
	reg             reg_rd_ena_reg;
	reg [7:0]       reg_rd_addr_reg;
	reg [7:0]       reg_wr_addr_reg;
	reg [31:0]      reg_wr_data_reg;
	reg             sel_ep_reg_reg;
	reg             reg_rd_ena_reg2;
	reg             reg_rd_ena_reg3;

	// Pipeline input data for performance
	always @ (negedge rstn or posedge clk_in) begin
		if (rstn==1'b0) begin
			err_status_reg       <= 32'h0;
			read_dma_status_reg  <= 64'h0;
			write_dma_status_reg <= 64'h0;
			reg_wr_ena_reg       <= 1'b0;
			reg_rd_ena_reg       <= 1'b0;
			reg_rd_ena_reg2      <= 1'b0;
			reg_rd_ena_reg3      <= 1'b0;
			reg_rd_addr_reg      <= 8'h0;
			reg_wr_addr_reg      <= 8'h0;
			reg_wr_data_reg      <= 32'h0;
			sel_ep_reg_reg       <= 1'b0;
			dma_rd_prg_rddata_reg <= 32'h0;
			dma_wr_prg_rddata_reg <= 32'h0;
			irq_prg_rddata_reg	 <= 32'h0;
			cmd_prg_rddata_reg   <= 32'h0;
		end
		else begin
			err_status_reg       <= {16'h0, rx_ecrc_bad_cnt};
			read_dma_status_reg  <= read_dma_status;
			write_dma_status_reg <= write_dma_status;
			reg_wr_ena_reg       <= reg_wr_ena & sel_ep_reg;
			reg_rd_ena_reg       <= reg_rd_ena & sel_ep_reg;
			reg_rd_ena_reg2      <= reg_rd_ena_reg;
			reg_rd_ena_reg3      <= reg_rd_ena_reg2;
			reg_rd_addr_reg      <= reg_rd_addr;
			reg_wr_addr_reg      <= reg_wr_addr;
			reg_wr_data_reg      <= reg_wr_data;
			dma_rd_prg_rddata_reg <= dma_rd_prg_rddata;
			dma_wr_prg_rddata_reg <= dma_wr_prg_rddata;
			irq_prg_rddata_reg   <= irq_prg_rddata;
			cmd_prg_rddata_reg	 <= cmd_prg_rddata;
		end
	end

	// Register Access
	always @ (negedge rstn or posedge clk_in) begin
		if (rstn==1'b0) begin
			reg_rd_data       <= 32'h0;
			reg_rd_data_valid <= 1'b0;
			prg_wrdata    <= 32'h0;
			prg_addr      <= 8'h0;
			dma_rd_prg_wrena  <= 1'b0;
			dma_wr_prg_wrena  <= 1'b0;
			irq_prg_wrena <= 1'b0;
			cmd_prg_wrena <= 1'b0;
		end
		else begin
			//------------
			// REG WRITE
			//------------
			// DMA write/read control registers only need 4 DWords, as
			// a result, they only need 4 bits as register indices. However,
			// SoNIC command control registers need 6 Dwords, 4 bits is not
			// sufficient. We extends all control register modules to take
			// 8 bits of reg_wr_addr, which is the full address from rx_desc
			//
			prg_wrdata    <= reg_wr_data_reg;
			prg_addr      <= reg_wr_addr_reg[7:0];
			dma_rd_prg_wrena	<= ((reg_wr_ena_reg==1'b1) & (reg_wr_addr_reg[7:4] == DMA_READ_PRG))  ? 1'b1 : 1'b0;
			dma_wr_prg_wrena	<= ((reg_wr_ena_reg==1'b1) & (reg_wr_addr_reg[7:4] == DMA_WRITE_PRG)) ? 1'b1 : 1'b0;
			irq_prg_wrena		<= ((reg_wr_ena_reg==1'b1) & (reg_wr_addr_reg[7:4] == RX_IRQ))? 1'b1: 1'b0;
			cmd_prg_wrena		<= ((reg_wr_ena_reg==1'b1) & ((reg_wr_addr_reg[7:4] == COMMAND) || (reg_wr_addr_reg[7:4] == CMD_RESP)))?1'b1: 1'b0;
				
			//-----------
			// REG READ
			//-----------
			case (reg_rd_addr_reg[7:0])
				{MISC, WRITE_DMA_STATUS_REG_HI}	: reg_rd_data <= write_dma_status_reg[63:32];
				{MISC, WRITE_DMA_STATUS_REG_LO}	: reg_rd_data <= write_dma_status_reg[31:0];
				{MISC, READ_DMA_STATUS_REG_HI}	: reg_rd_data <= read_dma_status_reg[63:32];
				{MISC, READ_DMA_STATUS_REG_LO}	: reg_rd_data <= read_dma_status_reg[31:0];
				{ERR_STATUS, 4'h0}				: reg_rd_data <= err_status_reg;
				{DMA_WRITE_PRG, 4'h0},
				{DMA_WRITE_PRG, 4'h4},
				{DMA_WRITE_PRG, 4'h8},
				{DMA_WRITE_PRG, 4'hC}			: reg_rd_data <= dma_wr_prg_rddata_reg;
				{DMA_READ_PRG, 4'h0},
				{DMA_READ_PRG, 4'h4},
				{DMA_READ_PRG, 4'h8},
				{DMA_READ_PRG, 4'hC}			: reg_rd_data <= dma_rd_prg_rddata_reg;
				{RX_IRQ, CNTL_FIELD},			
				{RX_IRQ, IRQ_ADDR_HI},			
				{RX_IRQ, IRQ_ADDR_LO},			
				{RX_IRQ, IRQ_SIZE}				: reg_rd_data <= irq_prg_rddata_reg;
				{COMMAND, CMD_TYPE},			
				{COMMAND, CMD_PARAM0},			
				{COMMAND, CMD_PARAM1},			
				{COMMAND, CMD_PARAM2},		
				{CMD_RESP, ADDR_MSW},			
				{CMD_RESP, ADDR_LSW}			: reg_rd_data <= cmd_prg_rddata_reg;
				default							: reg_rd_data <= 32'h0;
			endcase

			case (reg_rd_addr_reg[7:4])
				DMA_WRITE_PRG: reg_rd_data_valid <= reg_rd_ena_reg3;
				DMA_READ_PRG : reg_rd_data_valid <= reg_rd_ena_reg3;
				RX_IRQ		 : reg_rd_data_valid <= reg_rd_ena_reg3;
				COMMAND		 : reg_rd_data_valid <= reg_rd_ena_reg3;
				CMD_RESP	 : reg_rd_data_valid <= reg_rd_ena_reg3;
				default      : reg_rd_data_valid <= reg_rd_ena_reg;
			endcase
		end
	end

endmodule
