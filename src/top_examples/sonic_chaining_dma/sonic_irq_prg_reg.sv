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
// Title         : SoNIC rx irq register setting (sonic_irq_prg_reg)
// Project       : PCI Express MegaCore function
//-----------------------------------------------------------------------------
// File          : sonic_irq_prg_reg.v
// Author        : Altera Corporation
//-----------------------------------------------------------------------------
//
// Refer to SoNIC specification for the register definitions
//
// Key signals:
//
//////////////////////////////////////////////////////////////////////////////
//
// NOTE:
//      1- This module always issues RX_ACK when RX TLP = Message Request
//         (TYPE[4:3] == 2'b10)
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
module sonic_irq_prg_reg #(
   parameter RC_64BITS_ADDR = 0,
   parameter AVALON_ST_128  = 0)
   (
   input          clk_in,
   input          rstn,
   input          irq_prg_wrena,
   input[31:0]    irq_prg_wrdata,
   input[7:0]     irq_prg_addr,
   output reg [31:0] irq_prg_rddata,

   output reg  [63:0] irq_base_rc,      // Descriptor table base address in the RC site
   output reg         irq_msi_enable,   // Status bit to reflect use of MSI
   output reg  [4:0]  app_msi_num,      // MSI TC and MSI Number
   output reg  [2:0]  app_msi_tc ,
   output reg  [31:0] rx_block_size,	
   output reg         init              // high when reset state or before any transaction
   );

   // Register Address Decode
   localparam EP_ADDR_DW0 = 2'b00;
   localparam EP_ADDR_DW1 = 2'b01;
   localparam EP_ADDR_DW2 = 2'b10;
   localparam EP_ADDR_DW3 = 2'b11;

   // soft_irq_reset : DMA reset controlled by software
   reg        soft_irq_reset;
   reg        init_shift;
   reg [31:0] prg_reg_DW0;
   reg [31:0] prg_reg_DW1;
   reg [31:0] prg_reg_DW2;
   reg [31:0] prg_reg_DW3;

   reg        irq_prg_wrena_reg;
   reg[31:0]  irq_prg_wrdata_reg;
   reg[7:0]   irq_prg_addr_reg;

   // Generate DMA resets
   always @ (negedge rstn or posedge clk_in) begin
      if (rstn==1'b0) begin
         soft_irq_reset <= 1'b1;
         init_shift     <= 1'b1;
         init           <= 1'b1;
         irq_prg_wrena_reg  <= 1'b0;
         irq_prg_wrdata_reg <= 32'h0;
         irq_prg_addr_reg   <= 4'h0;
      end
      else begin
         init              <= init_shift;
         irq_prg_wrena_reg  <= irq_prg_wrena;
         irq_prg_wrdata_reg <= irq_prg_wrdata;
         irq_prg_addr_reg   <= irq_prg_addr;

          // write 1's to Address 0 to clear all regs
          soft_irq_reset <= (irq_prg_wrena_reg==1'b1) & (irq_prg_addr_reg[3:2]==EP_ADDR_DW0) & (irq_prg_wrdata_reg[15:0]==16'hFFFF);

          // assert init on a reset
          // deassert init when the base address prg reg is written
          if (soft_irq_reset==1'b1)
              init_shift <= 1'b1;
          else if ((irq_prg_wrena_reg==1'b1) & (irq_prg_addr_reg[3:2]==EP_ADDR_DW2))
              init_shift <= 1'b0;
      end
   end

   // DMA Programming Register Write
   always @ (posedge clk_in or posedge soft_irq_reset) begin
      if (soft_irq_reset == 1'b1) begin
         prg_reg_DW0         <= 32'h0;
         prg_reg_DW1         <= 32'h0;
         prg_reg_DW2         <= 32'h0;
         prg_reg_DW3         <= 4096;
         irq_msi_enable      <= 1'b0;
         app_msi_num         <= 5'h0;
         app_msi_tc          <= 3'h0;
         irq_base_rc         <= 64'h0;
         irq_prg_rddata      <= 32'h0;
      end
      else begin
          // Registers
          prg_reg_DW0 <= ((irq_prg_wrena_reg==1'b1) & (irq_prg_addr_reg[3:2] == EP_ADDR_DW0)) ? irq_prg_wrdata_reg : prg_reg_DW0; // Header register DW0
          prg_reg_DW1 <= ((irq_prg_wrena_reg==1'b1) & (irq_prg_addr_reg[3:2] == EP_ADDR_DW1)) ? irq_prg_wrdata_reg : prg_reg_DW1; // Header register DW1
          prg_reg_DW2 <= ((irq_prg_wrena_reg==1'b1) & (irq_prg_addr_reg[3:2] == EP_ADDR_DW2)) ? irq_prg_wrdata_reg : prg_reg_DW2; // Header register DW2
          prg_reg_DW3 <= ((irq_prg_wrena_reg==1'b1) & (irq_prg_addr_reg[3:2] == EP_ADDR_DW3)) ? irq_prg_wrdata_reg : prg_reg_DW3; // Header register DW2

          case (irq_prg_addr_reg[3:2])
              EP_ADDR_DW0: irq_prg_rddata <= prg_reg_DW0;
              EP_ADDR_DW1: irq_prg_rddata <= prg_reg_DW1;
              EP_ADDR_DW2: irq_prg_rddata <= prg_reg_DW2;
              EP_ADDR_DW3: irq_prg_rddata <= prg_reg_DW3;
          endcase

          // outputs
          irq_msi_enable     <= prg_reg_DW0[17];
          app_msi_num        <= 5'h0;//prg_reg_DW0[24:20];	//FIXME
          app_msi_tc         <= 3'h0;//prg_reg_DW0[30:28];	//FIXME
          irq_base_rc[63:32] <= prg_reg_DW1;
          irq_base_rc[31:0]  <= prg_reg_DW2;
		  rx_block_size		 <= prg_reg_DW3;
      end
   end

endmodule
