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
// Title         : SoNIC command register setting (sonic_cmd_prg_reg)
// Project       : PCI Express MegaCore function
//-----------------------------------------------------------------------------
// File          : sonic_cmd_prg_reg.v
// Author        : Han Wang
//-----------------------------------------------------------------------------
//
//	See Sonic Specification for register definitions
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
module sonic_cmd_prg_reg #(
   parameter RC_64BITS_ADDR = 0,
   parameter AVALON_ST_128  = 0   )
   (
   input          clk_in,
   input          rstn,
   input          sonic_cmd_prg_wrena,
   input[31:0]    sonic_cmd_prg_wrdata,
   input[7:0]     sonic_cmd_prg_addr,
   output reg [31:0] sonic_cmd_prg_rddata,

   output reg [31:0] cmd_type,
   output reg [31:0] cmd_param0,
   output reg [31:0] cmd_param1,
   output reg [31:0] cmd_param2,
   output reg  [63:0] cmd_base_rc,       // Descriptor table base address in the RC site
   output reg         cmd_3dw_rcadd,     // Return 1 if cmd_base_rc[63:32] == 0
   output reg         init              // high when reset state or before any transaction
   );

   // Register Address Decode
   localparam EP_ADDR_DW0 = `SONIC_REG_CMD_DW0;		//CMD_TYPE
   localparam EP_ADDR_DW1 = `SONIC_REG_CMD_DW1;		//CMD_PARAM0
   localparam EP_ADDR_DW2 = `SONIC_REG_CMD_DW2;		//CMD_PARAM1
   localparam EP_ADDR_DW3 = `SONIC_REG_CMD_DW3;		//CMD_PARAM2
   localparam EP_ADDR_DW4 = `SONIC_REG_CMD_DW4;		//RESP_ADDR_HI
   localparam EP_ADDR_DW5 = `SONIC_REG_CMD_DW5;		//RESP_ADDR_LO

   // soft_cmd_reset : DMA reset controlled by software
   reg        soft_cmd_reset;
   reg        init_shift;
   reg [31:0] prg_reg_DW0;
   reg [31:0] prg_reg_DW1;
   reg [31:0] prg_reg_DW2;
   reg [31:0] prg_reg_DW3;
   reg [31:0] prg_reg_DW4;
   reg [31:0] prg_reg_DW5;
   reg        prg_reg_DW4_is_zero;

   reg        sonic_cmd_prg_wrena_reg;
   reg[31:0]  sonic_cmd_prg_wrdata_reg;
   reg[7:0]   sonic_cmd_prg_addr_reg;

   // Generate DMA resets
   always @ (negedge rstn or posedge clk_in) begin
      if (rstn==1'b0) begin
         soft_cmd_reset <= 1'b1;
         init_shift     <= 1'b1;
         init           <= 1'b1;
         sonic_cmd_prg_wrena_reg  <= 1'b0;
         sonic_cmd_prg_wrdata_reg <= 32'h0;
         sonic_cmd_prg_addr_reg   <= 4'h0;
      end
      else begin
         init              <= init_shift;
         sonic_cmd_prg_wrena_reg  <= sonic_cmd_prg_wrena;
         sonic_cmd_prg_wrdata_reg <= sonic_cmd_prg_wrdata;
         sonic_cmd_prg_addr_reg   <= sonic_cmd_prg_addr;

         // write 1's to Address 0 to clear all regs
         soft_cmd_reset <= (sonic_cmd_prg_wrena_reg==1'b1) & (sonic_cmd_prg_addr_reg[7:0]==EP_ADDR_DW0) & (sonic_cmd_prg_wrdata_reg[15:0]==16'hFFFF);

         // assert init on a reset
         // deassert init when the last (3rd) Prg Reg is written
         if (soft_cmd_reset==1'b1)
             init_shift <= 1'b1;
         else if ((sonic_cmd_prg_wrena_reg==1'b1) & (sonic_cmd_prg_addr_reg[7:0]==EP_ADDR_DW0))
             init_shift <= 1'b0;
      end
   end

   // DMA Programming Register Write
   always @ (posedge clk_in) begin
      if (soft_cmd_reset == 1'b1) begin
         prg_reg_DW0         <= 32'h0;
         prg_reg_DW1         <= 32'h0;
         prg_reg_DW2         <= 32'h0;
         prg_reg_DW3         <= 32'h0;
         prg_reg_DW4         <= 32'h0;
         prg_reg_DW5         <= 32'h0;
         prg_reg_DW4_is_zero <= 1'b1;
		 cmd_type			 <= 32'h0;
		 cmd_param0			 <= 32'h0;
		 cmd_param1			 <= 32'h0;
		 cmd_param2			 <= 32'h0;
         cmd_base_rc          <= 64'h0;
         cmd_3dw_rcadd        <= 1'b0;
         sonic_cmd_prg_rddata      <= 32'h0;
      end
      else begin
          // Registers
          prg_reg_DW0 <= ((sonic_cmd_prg_wrena_reg==1'b1) & (sonic_cmd_prg_addr_reg[7:0] == EP_ADDR_DW0)) ? sonic_cmd_prg_wrdata_reg : prg_reg_DW0; // Header register DW0
          prg_reg_DW1 <= ((sonic_cmd_prg_wrena_reg==1'b1) & (sonic_cmd_prg_addr_reg[7:0] == EP_ADDR_DW1)) ? sonic_cmd_prg_wrdata_reg : prg_reg_DW1; // Header register DW1
          prg_reg_DW2 <= ((sonic_cmd_prg_wrena_reg==1'b1) & (sonic_cmd_prg_addr_reg[7:0] == EP_ADDR_DW2)) ? sonic_cmd_prg_wrdata_reg : prg_reg_DW2; // Header register DW2
          prg_reg_DW3 <= ((sonic_cmd_prg_wrena_reg==1'b1) & (sonic_cmd_prg_addr_reg[7:0] == EP_ADDR_DW3)) ? sonic_cmd_prg_wrdata_reg : prg_reg_DW3; // Header register DW3
          prg_reg_DW4 <= ((sonic_cmd_prg_wrena_reg==1'b1) & (sonic_cmd_prg_addr_reg[7:0] == EP_ADDR_DW4)) ? sonic_cmd_prg_wrdata_reg : prg_reg_DW4; // Header register DW3
          prg_reg_DW5 <= ((sonic_cmd_prg_wrena_reg==1'b1) & (sonic_cmd_prg_addr_reg[7:0] == EP_ADDR_DW5)) ? sonic_cmd_prg_wrdata_reg : prg_reg_DW5; // Header register DW3

          case (sonic_cmd_prg_addr_reg[7:0])
              EP_ADDR_DW0: sonic_cmd_prg_rddata <= prg_reg_DW0;
              EP_ADDR_DW1: sonic_cmd_prg_rddata <= prg_reg_DW1;
              EP_ADDR_DW2: sonic_cmd_prg_rddata <= prg_reg_DW2;
              EP_ADDR_DW3: sonic_cmd_prg_rddata <= prg_reg_DW3;
              EP_ADDR_DW4: sonic_cmd_prg_rddata <= prg_reg_DW4;
              EP_ADDR_DW5: sonic_cmd_prg_rddata <= prg_reg_DW5;
          endcase

          // outputs
		  cmd_type			 <= prg_reg_DW0;
		  cmd_param0		 <= prg_reg_DW1; 
		  cmd_param1		 <= prg_reg_DW2;
		  cmd_param2		 <= prg_reg_DW3;
          cmd_base_rc[63:32] <= prg_reg_DW4;
          cmd_3dw_rcadd      <= (prg_reg_DW4==32'h0) ? 1'b1 : 1'b0;
          cmd_base_rc[31:0]  <= prg_reg_DW5;
      end
   end

endmodule
