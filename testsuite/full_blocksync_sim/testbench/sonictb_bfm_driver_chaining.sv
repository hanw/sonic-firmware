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


// (C) 2001-2010 Altera Corporation. All rights reserved.
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


// (C) 2001-2010 Altera Corporation. All rights reserved.
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


// /**
//  * This Verilog HDL file is used for simulation in
//  * the chained DMA design example.
//  */
`timescale 1 ps / 1 ps
//-----------------------------------------------------------------------------
// Title         : PCI Express BFM Root Port Driver for the chained DMA
//                 design example
// Project       : PCI Express MegaCore function
//-----------------------------------------------------------------------------
// File          : altpcietb_bfm_driver.v
// Author        : Altera Corporation
//-----------------------------------------------------------------------------
// Description : This module is driver for the Root Port BFM for the chained DMA
//               design example.
//     The main process (begin : main) operates in two stages:
//        - EP configuration using the task ebfm_cfg_rp_ep
//        - Run a chained DMA transfer with the task chained_dma_test
//
//    Chained DMA operation:
//       The chained DMA consist of a DMA Write and a DMA Read sub-module
//       Each DMA use a separate descriptor table mapped in the share memeory
//       The descriptor table contains a header with 3 DWORDs (DW0, DW1, DW2)
//
//       |31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16|15 .................0
//   ----|---------------------------------------------------------------------
//       | R|        |         |              |  | E|M| D |
//   DW0 | E| MSI    |         |              |  | P|S| I |
//       | S|TRAFFIC |         |              |  | L|I| R |
//       | E|CLASS   | RESERVED|  MSI         |1 | A| | E |      SIZE:Number
//       | R|        |         |  NUMBER      |  | S| | C |   of DMA descriptor
//       | V|        |         |              |  | T| | T |
//       | E|        |         |              |  |  | | I |
//       | D|        |         |              |  |  | | O |
//       |  |        |         |              |  |  | | N |
//   ----|---------------------------------------------------------------------
//   DW1 |                                       BDT_MSB
//   ----|---------------------------------------------------------------------
//   DW2 |                                       BDT_LSB
//   ----|---------------------------------------------------------------------
//
// RC memory map Overview - Descriptor section
//
//   RC memory  : 2Mbyte 0h -> 200000h
//   BRC+00000h : Descriptor table write
//   BRC+00100h : Descriptor table read
//   BRC+01000h : Data for write
//   BRC+05000h : Data for read
//
//-----------------------------------------------------------------------------
//
// Abreviation:
//     EP      : End Point
//     RC      : Root complex
//     DT      : Descriptor Table
//     MWr     : Memory write
//     MRd     : Memory read
//     CPLD    : Completion with data
//     MSI     : PCIe Message Signaled Interrupt
//     BDT     : Base address of the descriptor header table in RC memory
//     BDT_LSB : Base address of the descriptor header table in RC memory
//     BDT_MSB : Base address of the descriptor header table in RC memory
//     BRC     : [BDT_MSB:BDT_LSB]
//     DW0     : First DWORD of the descriptor table header
//     DW1     : Second DWORD of the descriptor table header
//     DW2     : Third DWORD of the descriptor table header
//     RCLAST  : RC MWr RCLAST in EP memeory to reflects the number
//               of DMA transfers ready to start
//     EPLAST  : EP MWr EPLAST in shared memeory to reflects the number
//               of completed DMA transfers
//
//-----------------------------------------------------------------------------
// Copyright � 2009 Altera Corporation. All rights reserved.  Altera products are
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
`include "sonic_constants.sv"
`define STR_SEP "---------"

module sonictb_bfm_driver_chaining (input clk_in,
				    input INTA,
				    input INTB,
				    input INTC,
				    input INTD,
				    input rstn,
				    output dummy_out);

   // TEST_LEVEL is a parameter passed in from the top level test bench that
   // could control the amount of testing done. It is not currently used.

   // Global parameter
   parameter  TEST_LEVEL            = 1;
   parameter  USE_CDMA              = 1;     // When set enable EP upstream MRd/MWr test
   parameter  USE_TARGET            = 1;     // When set enable target test
   localparam DISPLAY_ALL           = 1;
   localparam NUMBER_OF_DESCRIPTORS = 3;
   localparam SCR_MEM               = 2048;  // Share memory base address used by DMA
   localparam SCR_MEMSLAVE          = 64;    // Share memory base address used by RC Slave module
   localparam SCR_MEM_DOWNSTREAM_WR = SCR_MEMSLAVE;
   localparam SCR_MEM_DOWNSTREAM_RD = SCR_MEMSLAVE+2048;
   localparam MAX_RCPAYLOAD         = 128;
   localparam RCSLAVE_MAXLEN = 10;  // maximum number of read/write

   localparam TIMEOUT_POLLING       = 2048;  // number of clock' for timout
   // using the chaining DMA module 

   localparam TC_CLASS_P0 = 0;
   localparam TC_CLASS_P1 = 0;
   
   // Descriptor Table Parameters
   localparam DT_EPLAST = 4'hc;
   localparam MEM_DESCR_LENGTH_INC = 2;
   localparam DMA_CONTINOUS_LOOP = 0;

   // Write DMA DESCRIPTOR TABLE Content, Port 0
   /*
    * Write DMA Memory allocation.
    * 0x0000_0001_0000_1800
    * 0x0000_0001_0000_2800
    * 0x0000_0001_0000_3800
    */
   localparam integer 			   WR_DIRECTION        = 1;
   localparam integer 			   WR_DESCRIPTOR_DEPTH = 4;        // 4 DWORDS
   localparam integer 			   WR_BDT_LSB          = SCR_MEM;
   localparam integer 			   WR_BDT_MSB          = 0;
   localparam integer 			   WR_FIRST_DESCRIPTOR = WR_BDT_LSB+16;

   localparam integer 			   WR_DESC0_CTL_MSI      = 0;
   localparam integer 			   WR_DESC0_CTL_EPLAST   = 1;      // send EPLast update when done with this descriptor
   localparam integer 			   WR_DESC0_LENGTH       = 8192;
//   localparam integer 			   WR_DESC0_LENGTH       = 4096;
   localparam integer 			   WR_DESC0_EPADDR       = 0;
   localparam integer 			   WR_DESC0_RCADDR_MSB   = 1;
   localparam integer 			   WR_DESC0_RCADDR_LSB   = WR_BDT_LSB+4096;
   localparam integer 			   WR_DESC0_INIT_BFM_MEM = 64'h0000_0000_1515_0001;

   localparam integer 			   WR_DESC1_CTL_MSI      = 0;
   localparam integer 			   WR_DESC1_CTL_EPLAST   = 0;
//   localparam integer 			   WR_DESC1_LENGTH       = 4096;
   localparam integer 			   WR_DESC1_LENGTH       = 8192;
   localparam integer 			   WR_DESC1_EPADDR       = 8192;
   localparam integer 			   WR_DESC1_RCADDR_MSB   = 1;
   localparam integer 			   WR_DESC1_RCADDR_LSB   = WR_BDT_LSB+12288;
   localparam integer 			   WR_DESC1_INIT_BFM_MEM = 64'h0000_0000_2525_0001;

   localparam integer 			   WR_DESC2_CTL_MSI      = 1;     // send MSI when done with this descriptor
   localparam integer 			   WR_DESC2_CTL_EPLAST   = 1;     // send EPLast update when done with this descriptor
//   localparam integer 			   WR_DESC2_LENGTH       = 4096;
   localparam integer 			   WR_DESC2_LENGTH       = 8192;
   localparam integer 			   WR_DESC2_EPADDR       = 0;
   localparam integer 			   WR_DESC2_RCADDR_MSB   = 1;
   localparam integer 			   WR_DESC2_RCADDR_LSB   = WR_BDT_LSB+20480;
   localparam integer 			   WR_DESC2_INIT_BFM_MEM = 64'h0000_0000_3535_0001;

   // READ DMA DESCRIPTOR TABLE Content, Port 0
   /*
    * Read DMA memory allocation
    * 0x0000_0001_0000_1900
    * 0x0000_0001_0000_2900
    * 0x0000_0001_0000_3900
    */
   localparam integer 			   RD_DIRECTION        = 0;
   localparam integer 			   RD_DESCRIPTOR_DEPTH = 4;
   localparam integer 			   RD_BDT_LSB          = SCR_MEM+20480;
   localparam integer 			   RD_BDT_MSB          = 0;
   localparam integer 			   RD_FIRST_DESCRIPTOR = RD_BDT_LSB+16;

   localparam integer 			   RD_DESC0_CTL_MSI      = WR_DESC0_CTL_MSI;
   localparam integer 			   RD_DESC0_CTL_EPLAST   = WR_DESC0_CTL_EPLAST;
//   localparam integer 			   RD_DESC0_LENGTH       = 4096;
   localparam integer 			   RD_DESC0_LENGTH       = 8192;
   localparam integer 			   RD_DESC0_EPADDR       = 0;
   localparam integer 			   RD_DESC0_RCADDR_MSB   = 1;
   localparam integer 			   RD_DESC0_RCADDR_LSB   = RD_BDT_LSB+4096;
   localparam integer 			   RD_DESC0_INIT_BFM_MEM = 64'h0000_0000_AAA0_0001;

   localparam integer 			   RD_DESC1_CTL_MSI      = WR_DESC1_CTL_MSI;
   localparam integer 			   RD_DESC1_CTL_EPLAST   = WR_DESC1_CTL_EPLAST;
//   localparam integer 			   RD_DESC1_LENGTH       = 4096;
   localparam integer 			   RD_DESC1_LENGTH       = 8192;
   localparam integer 			   RD_DESC1_EPADDR       = 8192;
   localparam integer 			   RD_DESC1_RCADDR_MSB   = 1;
   localparam integer 			   RD_DESC1_RCADDR_LSB   = RD_BDT_LSB+12288;
   localparam integer 			   RD_DESC1_INIT_BFM_MEM = 64'h0000_0000_BBBB_0001;

   localparam integer 			   RD_DESC2_CTL_MSI      = WR_DESC2_CTL_MSI;
   localparam integer 			   RD_DESC2_CTL_EPLAST   = WR_DESC2_CTL_EPLAST;
   localparam integer 			   RD_DESC2_LENGTH       = 8192;
//   localparam integer 			   RD_DESC2_LENGTH       = 4096;
   localparam integer 			   RD_DESC2_EPADDR       = 0;
   localparam integer 			   RD_DESC2_RCADDR_MSB   = 1;
   localparam integer 			   RD_DESC2_RCADDR_LSB   = RD_BDT_LSB+20480;
   localparam integer 			   RD_DESC2_INIT_BFM_MEM = 64'h0000_0000_CCCC_0001;

   // Information used by driver for polling Chaining DMA status for completion.
   // These must correspond to the _DESCx_CTL_MSI and _DESCx_CTL_EPLAST parameters above.

   localparam EPLAST_DONE_VALUE   = 2;                                                                  // The EPLast Number that the driver expects to receive from each DMA after all data transfers have completed
   localparam NUM_EPLAST_EXPECTED = WR_DESC0_CTL_EPLAST + WR_DESC1_CTL_EPLAST + WR_DESC2_CTL_EPLAST;    // Number of Descriptors programmed to send EPLAST status update to root port
   localparam NUM_MSI_EXPECTED    = WR_DESC0_CTL_MSI + WR_DESC1_CTL_MSI + WR_DESC2_CTL_MSI;             // Number of MSI's that the driver expects to receive from each DMA after all data transfers have completed


   localparam DEBUG_PRG = 0;

   // Root Port Primary Side Bus Number and Device Number
   localparam [7:0] RP_PRI_BUS_NUM = 8'h00 ;
   localparam [4:0] RP_PRI_DEV_NUM = 5'b00000 ;
   // Root Port Requester ID
   localparam[15:0] RP_REQ_ID = {RP_PRI_BUS_NUM, RP_PRI_DEV_NUM , 3'b000}; // used in the Requests sent out
   // 2MB of memory
   localparam SHMEM_ADDR_WIDTH = 21;
   // The first section of the PCI Express I/O Space will be reserved for
   // addressing the Root Port's Shared Memory. PCI Express I/O Initiators
   // would use an I/O address in this range to access the shared memory.
   // Likewise the first section of the PCI Express Memory Space will be
   // reserved for accessing the Root Port's Shared Memory. PCI Express
   // Memory Initiators will use this range to access this memory.
   // These values here set the range that can be used to assign the
   // EP BARs to.
   localparam[31:0] EBFM_BAR_IO_MIN = 32'b1 << SHMEM_ADDR_WIDTH ;
   localparam[31:0] EBFM_BAR_IO_MAX = {32{1'b1}};
   localparam[31:0] EBFM_BAR_M32_MIN = 32'b1 << SHMEM_ADDR_WIDTH ;
   localparam[31:0] EBFM_BAR_M32_MAX = {32{1'b1}};
   localparam[63:0] EBFM_BAR_M64_MIN = 64'h0000000100000000 ;
   localparam[63:0] EBFM_BAR_M64_MAX = {64{1'b1}};
   localparam EBFM_NUM_VC = 4; // Number of VC's implemented in the Root Port BFM
   localparam EBFM_NUM_TAG = 32; // Number of TAG's used by Root Port BFM

   // Constants for the logging package
   localparam EBFM_MSG_DEBUG = 0;
   localparam EBFM_MSG_INFO = 1;
   localparam EBFM_MSG_WARNING = 2;
   localparam EBFM_MSG_ERROR_INFO = 3; // Preliminary Error Info Message
   localparam EBFM_MSG_ERROR_CONTINUE = 4;
   // Fatal Error Messages always stop the simulation
   localparam EBFM_MSG_ERROR_FATAL = 101;
   localparam EBFM_MSG_ERROR_FATAL_TB_ERR = 102;

   // Maximum Message Length in characters
   localparam EBFM_MSG_MAX_LEN = 100 ;

   /*
    * Resource Control Mutex, used for managing the PCIe bus between multiple threads.
    */
   semaphore 				   sem;
   event 				   idle;


   // purpose: sets the suppressed_msg_mask
   task ebfm_log_set_suppressed_msg_mask;
      input [EBFM_MSG_ERROR_CONTINUE:EBFM_MSG_DEBUG] msg_mask;

      begin
         // ebfm_log_set_suppressed_msg_mask
         bfm_log_common.suppressed_msg_mask = msg_mask;
      end
   endtask

   // purpose: sets the stop_on_msg_mask
   task ebfm_log_set_stop_on_msg_mask;
      input [EBFM_MSG_ERROR_CONTINUE:EBFM_MSG_DEBUG] msg_mask;

      begin
         // ebfm_log_set_stop_on_msg_mask
         bfm_log_common.stop_on_msg_mask = msg_mask;
      end
   endtask

   // purpose: Opens the Log File with the specified name
   task ebfm_log_open;
      input [200*8:1] fn; // Log File Name

      begin
         bfm_log_common.log_file = $fopen(fn);
      end
   endtask

   // purpose: Opens the Log File with the specified name
   task ebfm_log_close;

      begin
         // ebfm_log_close
         $fclose(bfm_log_common.log_file);
         bfm_log_common.log_file = 0;
      end
   endtask

   // purpose: stops the simulation, with flag to indicate success or not
   function ebfm_log_stop_sim;
      input success;
      integer success;

      begin
         if (success == 1)
           begin
              $display("SUCCESS: Simulation stopped due to successful completion!");
`ifdef VCS
              $finish;
`else
              $stop ;
`endif
           end
         else
           begin
              $display("FAILURE: Simulation stopped due to error!");
`ifdef VCS
              $finish;
`else
              $stop ;
`endif
           end
         ebfm_log_stop_sim = 1'b0 ;
      end
   endfunction

   // purpose: This displays a message of the specified type
   function ebfm_display;
      input msg_type;
      integer msg_type;
      input [EBFM_MSG_MAX_LEN*8:1] message;

      reg [9*8:1] 		   prefix ;
      reg [80*8:1] 		   amsg;
      reg 			   sup;
      reg 			   stp;
      reg 			   dummy ;
      integer 			   i ;
      time 			   ctime ;
      integer 			   itime ;

      begin
         for (i = 0 ; i < EBFM_MSG_MAX_LEN ; i = i + 1)
           begin : msg_shift
              if (message[(EBFM_MSG_MAX_LEN*8)-:8] != 8'h00)
                begin
                   disable msg_shift ;
                end
              message = message << 8 ;
           end
         if (msg_type > EBFM_MSG_ERROR_CONTINUE)
           begin
              sup = 1'b0;
              stp = 1'b1;
              case (msg_type)
                EBFM_MSG_ERROR_FATAL :
                  begin
                     amsg   = "FAILURE: Simulation stopped due to Fatal error!" ;
                     prefix = "FATAL:   ";
                  end
                EBFM_MSG_ERROR_FATAL_TB_ERR :
                  begin
                     amsg   = "FAILURE: Simulation stopped due error in Testbench/BFM design!";
                     prefix = "FATAL:   ";
                  end
                default :
                  begin
                     amsg   = "FAILURE: Simulation stopped due to unknown message type!";
                     prefix = "FATAL:   ";
                  end
              endcase
           end
         else
           begin
              sup = bfm_log_common.suppressed_msg_mask[msg_type];
              stp = bfm_log_common.stop_on_msg_mask[msg_type];
              if (stp == 1'b1)
                begin
                   amsg   = "FAILURE: Simulation stopped due to enabled error!";
                end
              if (msg_type < EBFM_MSG_INFO)
                begin
                   prefix = "DEBUG:   ";
                end
              else
                begin
                   if (msg_type < EBFM_MSG_WARNING)
                     begin
                        prefix = "INFO:    ";
                     end
                   else
                     begin
                        if (msg_type > EBFM_MSG_WARNING)
                          begin
                             prefix = "ERROR:   ";
                          end
                        else
                          begin
                             prefix = "WARNING: ";
                          end
                     end
                end
           end // else: !if(msg_type > EBFM_MSG_ERROR_CONTINUE)
         itime = ($time/1000) ;
         // Display the message if not suppressed
         if (sup != 1'b1)
           begin
              if (bfm_log_common.log_file != 0)
                begin
                   $fdisplay(bfm_log_common.log_file,"%s %d %s %s",prefix,itime,"ns",message);
                end
              $display("%s %d %s %s",prefix,itime,"ns",message);
           end
         // Stop if requested
         if (stp == 1'b1)
           begin
              if (bfm_log_common.log_file != 0)
                begin
                   $fdisplay(bfm_log_common.log_file, "%s", amsg);
                end
              $display("%s",amsg);
              dummy = ebfm_log_stop_sim(0);
           end
         // Dummy function return so we can call from other functions
         ebfm_display = 1'b0 ;
      end
   endfunction

   // purpose: produce 1-digit hexadecimal string from a vector
   function [8:1] himage1;
      input [3:0] vec;

      begin
         case (vec)
           4'h0 : himage1 = "0" ;
           4'h1 : himage1 = "1" ;
           4'h2 : himage1 = "2" ;
           4'h3 : himage1 = "3" ;
           4'h4 : himage1 = "4" ;
           4'h5 : himage1 = "5" ;
           4'h6 : himage1 = "6" ;
           4'h7 : himage1 = "7" ;
           4'h8 : himage1 = "8" ;
           4'h9 : himage1 = "9" ;
           4'hA : himage1 = "A" ;
           4'hB : himage1 = "B" ;
           4'hC : himage1 = "C" ;
           4'hD : himage1 = "D" ;
           4'hE : himage1 = "E" ;
           4'hF : himage1 = "F" ;
           4'bzzzz : himage1 = "Z" ;
           default : himage1 = "X" ;
         endcase
      end
   endfunction // himage1

   // purpose: produce 2-digit hexadecimal string from a vector
   function [16:1] himage2 ;
      input [7:0] vec;
      begin
         himage2 = {himage1(vec[7:4]),himage1(vec[3:0])} ;
      end
   endfunction // himage2

   // purpose: produce 4-digit hexadecimal string from a vector
   function [32:1] himage4 ;
      input [15:0] vec;
      begin
         himage4 = {himage2(vec[15:8]),himage2(vec[7:0])} ;
      end
   endfunction // himage4

   // purpose: produce 8-digit hexadecimal string from a vector
   function [64:1] himage8 ;
      input [31:0] vec;
      begin
         himage8 = {himage4(vec[31:16]),himage4(vec[15:0])} ;
      end
   endfunction // himage8

   // purpose: produce 16-digit hexadecimal string from a vector
   function [128:1] himage16 ;
      input [63:0] vec;
      begin
         himage16 = {himage8(vec[63:32]),himage8(vec[31:0])} ;
      end
   endfunction // himage16

   // purpose: produce 1-digit decimal string from an integer
   function [8:1] dimage1 ;
      input [31:0] num ;
      begin
         case (num)
           0 : dimage1 = "0" ;
           1 : dimage1 = "1" ;
           2 : dimage1 = "2" ;
           3 : dimage1 = "3" ;
           4 : dimage1 = "4" ;
           5 : dimage1 = "5" ;
           6 : dimage1 = "6" ;
           7 : dimage1 = "7" ;
           8 : dimage1 = "8" ;
           9 : dimage1 = "9" ;
           default : dimage1 = "U" ;
         endcase // case(num)
      end
   endfunction // dimage1

   // purpose: produce 2-digit decimal string from an integer
   function [16:1] dimage2 ;
      input [31:0] num ;
      begin
         dimage2 = {dimage1(num/10),dimage1(num % 10)} ;
      end
   endfunction // dimage2

   // purpose: produce 3-digit decimal string from an integer
   function [24:1] dimage3 ;
      input [31:0] num ;
      begin
         dimage3 = {dimage1(num/100),dimage2(num % 100)} ;
      end
   endfunction // dimage3

   // purpose: produce 4-digit decimal string from an integer
   function [32:1] dimage4 ;
      input [31:0] num ;
      begin
         dimage4 = {dimage1(num/1000),dimage3(num % 1000)} ;
      end
   endfunction // dimage4

   // purpose: produce 5-digit decimal string from an integer
   function [40:1] dimage5 ;
      input [31:0] num ;
      begin
         dimage5 = {dimage1(num/10000),dimage4(num % 10000)} ;
      end
   endfunction // dimage5

   // purpose: produce 6-digit decimal string from an integer
   function [48:1] dimage6 ;
      input [31:0] num ;
      begin
         dimage6 = {dimage1(num/100000),dimage5(num % 100000)} ;
      end
   endfunction // dimage6

   // purpose: produce 7-digit decimal string from an integer
   function [56:1] dimage7 ;
      input [31:0] num ;
      begin
         dimage7 = {dimage1(num/1000000),dimage6(num % 1000000)} ;
      end
   endfunction // dimage7

   // purpose: select the correct dimage call for ascii conversion
   function  [800:1] image ;
      input  [800:1] msg ;
      input [32:1]   num ;
      begin
         if (num <= 10)
           begin
              image = {msg, dimage1(num)};
           end
         else if (num <= 100)
           begin
              image = {msg, dimage2(num)};
           end
         else if (num <= 1000)
           begin
              image = {msg, dimage3(num)};
           end
         else if (num <= 10000)
           begin
              image = {msg, dimage4(num)};
           end
         else if (num <= 100000)
           begin
              image = {msg, dimage5(num)};
           end
         else if (num <= 1000000)
           begin
              image = {msg, dimage6(num)};
           end
         else image = {msg, dimage7(num)};
      end
   endfunction

   // ebfm_display_verb
   // overload ebfm_display by turning on/off verbose when DISPLAY_ALL>0
   function ebfm_display_verb(
			      input integer msg_type,
			      input [EBFM_MSG_MAX_LEN*8:1] message);
      reg 						   unused_result;
      begin
	 if (DISPLAY_ALL==1)
           unused_result = ebfm_display(msg_type, message);
	 ebfm_display_verb = 1'b0 ;
      end
   endfunction // ebfm_display_verb
   
   // purpose: Describes the attributes of the BAR and the assigned address
   task describe_bar;
      input bar_num;
      integer bar_num;
      input   bar_lsb;
      integer bar_lsb;
      input [63:0] bar;
      input 	   addr_unused ;

      reg [(6)*8:1] bar_num_str;
      reg [(10)*8:1] bar_size_str;
      reg [(16)*8:1] bar_type_str;
      reg 	     bar_enabled;
      reg [(17)*8:1] addr_str;

      reg 	     dummy ;

      begin  // describe_bar
         bar_enabled  = 1'b1 ;
         case (bar_lsb)
           4  : bar_size_str = " 16 Bytes ";
           5  : bar_size_str = " 32 Bytes ";
           6  : bar_size_str = " 64 Bytes ";
           7  : bar_size_str = "128 Bytes ";
           8  : bar_size_str = "256 Bytes ";
           9  : bar_size_str = "512 Bytes ";
           10 : bar_size_str = "  1 KBytes";
           11 : bar_size_str = "  2 KBytes";
           12 : bar_size_str = "  4 KBytes";
           13 : bar_size_str = "  8 KBytes";
           14 : bar_size_str = " 16 KBytes";
           15 : bar_size_str = " 32 KBytes";
           16 : bar_size_str = " 64 KBytes";
           17 : bar_size_str = "128 KBytes";
           18 : bar_size_str = "256 KBytes";
           19 : bar_size_str = "512 KBytes";
           20 : bar_size_str = "  1 MBytes";
           21 : bar_size_str = "  2 MBytes";
           22 : bar_size_str = "  4 MBytes";
           23 : bar_size_str = "  8 MBytes";
           24 : bar_size_str = " 16 MBytes";
           25 : bar_size_str = " 32 MBytes";
           26 : bar_size_str = " 64 MBytes";
           27 : bar_size_str = "128 MBytes";
           28 : bar_size_str = "256 MBytes";
           29 : bar_size_str = "512 MBytes";
           30 : bar_size_str = "  1 GBytes";
           31 : bar_size_str = "  2 GBytes";
           32 : bar_size_str = "  4 GBytes";
           33 : bar_size_str = "  8 GBytes";
           34 : bar_size_str = " 16 GBytes";
           35 : bar_size_str = " 32 GBytes";
           36 : bar_size_str = " 64 GBytes";
           37 : bar_size_str = "128 GBytes";
           38 : bar_size_str = "256 GBytes";
           39 : bar_size_str = "512 GBytes";
           40 : bar_size_str = "  1 TBytes";
           41 : bar_size_str = "  2 TBytes";
           42 : bar_size_str = "  4 TBytes";
           43 : bar_size_str = "  8 TBytes";
           44 : bar_size_str = " 16 TBytes";
           45 : bar_size_str = " 32 TBytes";
           46 : bar_size_str = " 64 TBytes";
           47 : bar_size_str = "128 TBytes";
           48 : bar_size_str = "256 TBytes";
           49 : bar_size_str = "512 TBytes";
           50 : bar_size_str = "  1 PBytes";
           51 : bar_size_str = "  2 PBytes";
           52 : bar_size_str = "  4 PBytes";
           53 : bar_size_str = "  8 PBytes";
           54 : bar_size_str = " 16 PBytes";
           55 : bar_size_str = " 32 PBytes";
           56 : bar_size_str = " 64 PBytes";
           57 : bar_size_str = "128 PBytes";
           58 : bar_size_str = "256 PBytes";
           59 : bar_size_str = "512 PBytes";
           60 : bar_size_str = "  1 EBytes";
           61 : bar_size_str = "  2 EBytes";
           62 : bar_size_str = "  4 EBytes";
           63 : bar_size_str = "  8 EBytes";
           default :
             begin
                bar_size_str = "Disabled  ";
                bar_enabled = 0;
             end
         endcase
         if (bar_num == 6)
           begin
              bar_num_str = "ExpROM";
           end
         else
           begin
              bar_num_str = {"BAR", dimage1(bar_num), "  "};
           end
         if (bar_enabled)
           begin
              if ((bar[2]) == 1'b1)
		begin
		   bar_num_str = {"BAR", dimage1(bar_num+1), ":", dimage1(bar_num)};
		end
              if (addr_unused == 1'b1 )
		begin
                   addr_str = "Not used in RP   ";
		end
              else
		begin
                   if ( (bar[32] == 1'b0) | (bar[32] == 1'b1) )
                     begin
			if ((bar[2]) == 1'b1)
                          begin
                             addr_str[136:73] = himage8(bar[63:32]);
                          end
			else
                          begin
                             addr_str[136:73] = "        ";
                          end
			addr_str[72:65] = " ";
			addr_str[64:1] = himage8({bar[31:4], 4'b0000});
                     end
                   else
                     begin
			addr_str = "Unassigned!!!    ";
                     end // else: !if( (bar[32] == 1'b0) | (bar[32] == 1'b1) )
		end // else: !if(addr_unused == 1'b1 )
              if ((bar[0]) == 1'b1)
		begin
                   bar_type_str = "IO Space        ";
		end
              else
		begin
		   if ((bar[3]) == 1'b1)
		     begin
			bar_type_str = "Prefetchable    ";
		     end
		   else
		     begin
			bar_type_str = "Non-Prefetchable";
		     end
		end
              dummy = ebfm_display(EBFM_MSG_INFO, {bar_num_str, " ", bar_size_str,
						   " ", addr_str, " ", bar_type_str});
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, {bar_num_str, " ", bar_size_str});
           end
      end
   endtask

   parameter SHMEM_FILL_ZERO = 0;
   parameter SHMEM_FILL_BYTE_INC = 1;
   parameter SHMEM_FILL_WORD_INC = 2;
   parameter SHMEM_FILL_DWORD_INC = 4;
   parameter SHMEM_FILL_QWORD_INC = 8;
   parameter SHMEM_FILL_ONE = 15;
   parameter SHMEM_SIZE = 2 ** SHMEM_ADDR_WIDTH;
   parameter BAR_TABLE_SIZE = 64;
   parameter BAR_TABLE_POINTER = SHMEM_SIZE - BAR_TABLE_SIZE;
   parameter SCR_SIZE = 64;
   parameter CFG_SCRATCH_SPACE = SHMEM_SIZE - BAR_TABLE_SIZE - SCR_SIZE;

class dma_thread;
   
   task shmem_write;
      input addr;
      integer addr;
      input [63:0] data;
      input 	   leng;
      integer 	   leng;

      integer 	   rleng;
      integer 	   i ;

      reg 	   dummy ;

      begin
         if (leng > 8)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,"Task SHMEM_WRITE only accepts write lengths up to 8") ;
              rleng = 8 ;
           end
         else if ( addr < BAR_TABLE_POINTER + BAR_TABLE_SIZE & addr >= CFG_SCRATCH_SPACE & bfm_shmem_common.protect_bfm_shmem )
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,"Task SHMEM_WRITE attempted to overwrite the write protected area of the shared memory") ;
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,"This protected area contains the following data critical to the operation of the BFM:") ;
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,{"The BFM internal memory area, 64B located at ", himage8(CFG_SCRATCH_SPACE)}) ;
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,{"The BAR Table, 64B located at ", himage8(BAR_TABLE_POINTER)}) ;
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,{"All other locations in the shared memory are available from 0 to ", himage8(CFG_SCRATCH_SPACE - 1)}) ;
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,"Please change your SHMEM_WRITE call to a different memory location") ;
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,"Halting Simulation") ;
           end
         else
           begin
              rleng = leng ;
           end
         for(i = 0; i <= (rleng - 1); i = i + 1)
           begin
              bfm_shmem_common.shmem[addr + i] = data[(i*8)+:8];
           end
      end
   endtask

   function [63:0] shmem_read;
      input addr;
      integer addr;
      input   leng;
      integer leng;

      reg [63:0] rdata;
      integer 	 rleng ;
      integer 	 i ;

      reg 	 dummy ;

      begin
         rdata = {64{1'b0}} ;
         if (leng > 8)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,"Task SHMEM_READ only accepts read lengths up to 8") ;
              rleng = 8 ;
           end
         else
           begin
              rleng = leng ;
           end
         for(i = 0; i <= (rleng - 1); i = i + 1)
           begin
              rdata[(i * 8)+:8] = bfm_shmem_common.shmem[addr + i];
           end
         shmem_read = rdata;
      end
   endfunction

   // purpose: display shared memory data
   function shmem_display;
      input addr;
      integer addr;
      input   leng;
      integer leng;
      input   word_size;
      integer word_size;
      input   flag_addr;
      integer flag_addr;
      input   msg_type;
      integer msg_type;

      integer iaddr;
      reg [60*8:1] oneline ;
      reg [128:1]  data_str[0:15] ;
      reg [8*5:1]  flag ;
      integer 	   i ;

      reg 	   dummy ;

      begin
         // shmem_display
         iaddr = addr ;
         // Backup address to beginning of word if needed
         if (iaddr % word_size > 0)
           begin
              iaddr = iaddr - (iaddr % word_size);
           end
         dummy = ebfm_display(msg_type, "");
         dummy = ebfm_display(msg_type, "Shared Memory Data Display:");
         dummy = ebfm_display(msg_type, "Address  Data");
         dummy = ebfm_display(msg_type, "-------  ----");
         while (iaddr < (addr + leng))
           begin
              for (i = 0; i < 16 ; i = i + word_size)
                begin : one_line
                   if ( (iaddr + i) > (addr + leng) )
                     begin
                        data_str[i] = "        " ;
                     end
                   else
                     begin
                        case (word_size)
                          8       : data_str[i] = himage16(shmem_read(iaddr + i,8)) ;
                          4       : data_str[i] = {"            ",himage8(shmem_read(iaddr + i,4))} ;
                          2       : data_str[i] = {"                ",himage4(shmem_read(iaddr + i,2))} ;
                          default : data_str[i] = {"                  ",himage2(shmem_read(iaddr + i,1))} ;
                        endcase // case(word_size)
                     end
                end // block: one_line
              if ((flag_addr >= iaddr) & (flag_addr < (iaddr + 16)))
                begin
                   flag = " <===" ;
                end
              else
                begin
                   flag = "     " ;
                end
              // Now compile the whole line
              oneline = {480{1'b0}} ;
              case (word_size)
                8 : oneline = {himage8(iaddr),
                               " ",data_str[0]," ",data_str[8],flag} ;
                4 : oneline = {himage8(iaddr),
                               " ",data_str[0][64:1]," ",data_str[4][64:1],
                               " ",data_str[8][64:1]," ",data_str[12][64:1],
                               flag} ;
                2 : oneline = {himage8(iaddr),
                               " ",data_str[0][32:1]," ",data_str[2][32:1],
                               " ",data_str[4][32:1]," ",data_str[6][32:1],
                               " ",data_str[8][32:1]," ",data_str[10][32:1],
                               " ",data_str[12][32:1]," ",data_str[14][32:1],
                               flag} ;
                default : oneline = {himage8(iaddr),
				     " ",data_str[0][16:1]," ",data_str[1][16:1],
				     " ",data_str[2][16:1]," ",data_str[3][16:1],
				     " ",data_str[4][16:1]," ",data_str[5][16:1],
				     " ",data_str[6][16:1]," ",data_str[7][16:1],
				     " ",data_str[8][16:1]," ",data_str[9][16:1],
				     " ",data_str[10][16:1]," ",data_str[11][16:1],
				     " ",data_str[12][16:1]," ",data_str[13][16:1],
				     " ",data_str[14][16:1]," ",data_str[15][16:1],
				     flag} ;
              endcase
              dummy = ebfm_display(msg_type, oneline);
              iaddr = iaddr + 16;
           end // while (iaddr < (addr + leng))
         // Dummy return so we can call from other functions
         shmem_display = 1'b0 ;
      end
   endfunction

   task shmem_fill;
      input addr;
      integer addr;
      input   mode;
      integer mode;
      input   leng; // Length to fill in bytes
      integer leng;
      input [63:0] init;

      integer 	   rembytes;
      reg [63:0]   data;
      integer 	   uaddr;
      parameter[7:0] ZDATA = {8{1'b0}};
      parameter[7:0] ODATA = {8{1'b1}};

      begin
         rembytes = leng ;
         data = init ;
         uaddr = addr ;
         while (rembytes > 0)
           begin
              case (mode)
		SHMEM_FILL_ZERO :
                  begin
                     shmem_write(uaddr, ZDATA,1);
                     rembytes = rembytes - 1;
                     uaddr = uaddr + 1;
                  end
		SHMEM_FILL_BYTE_INC :
                  begin
                     shmem_write(uaddr, data, 1);
                     data[7:0] = data[7:0] + 1;
                     rembytes = rembytes - 1;
                     uaddr = uaddr + 1;
                  end
		SHMEM_FILL_WORD_INC :
                  begin
                     begin : xhdl_3
                        integer i;
                        for(i = 0; i <= 1; i = i + 1)
                          begin
                             if (rembytes > 0)
                               begin
                                  shmem_write(uaddr, data[(i*8)+:8], 1);
                                  rembytes = rembytes - 1;
                                  uaddr = uaddr + 1;
                               end
                          end
                     end // i
                     data[15:0] = data[15:0] + 1;
                  end
		SHMEM_FILL_DWORD_INC :
                  begin
                     begin : xhdl_4
                        integer i;
                        for(i = 0; i <= 3; i = i + 1)
                          begin
                             if (rembytes > 0)
                               begin
                                  shmem_write(uaddr, data[(i*8)+:8], 1);
                                  rembytes = rembytes - 1;
                                  uaddr = uaddr + 1;
                               end
                          end
                     end // i
                     data[31:0] = data[31:0] + 1 ;
                  end
		SHMEM_FILL_QWORD_INC :
                  begin
                     begin : xhdl_5
                        integer i;
                        for(i = 0; i <= 7; i = i + 1)
                          begin
                             if (rembytes > 0)
                               begin
                                  shmem_write(uaddr, data[(i*8)+:8], 1);
                                  rembytes = rembytes - 1;
                                  uaddr = uaddr + 1;
                               end
                          end
                     end // i
                     data[63:0] = data[63:0] + 1;
                  end
		SHMEM_FILL_ONE :
                  begin
                     shmem_write(uaddr, ODATA, 1);
                     rembytes = rembytes - 1;
                     uaddr = uaddr + 1;
                  end
		default :
                  begin
                  end
              endcase
           end
      end
   endtask

   // Returns 1 if okay
   function [0:0] shmem_chk_ok;
      input addr;
      integer addr;
      input   mode;
      integer mode;
      input   leng; // Length to fill in bytes
      integer leng;
      input [63:0] init;
      input 	   display_error;
      integer 	   display_error;

      reg 	   dummy ;

      integer 	   rembytes;
      reg [63:0]   data;
      reg [63:0]   actual;
      integer 	   uaddr;
      integer 	   daddr;
      integer 	   dlen;
      integer 	   incr_count;
      parameter[7:0] ZDATA = {8{1'b0}};
      parameter[7:0] ODATA = {8{1'b1}};
      reg [36*8:1] actline;
      reg [36*8:1] expline;
      integer 	   word_size;

      begin
         rembytes = leng ;
         uaddr = addr ;
         data = init ;
         actual = init ;
         incr_count = 0 ;
         case (mode)
           SHMEM_FILL_WORD_INC :
             begin
                word_size = 2;
             end
           SHMEM_FILL_DWORD_INC :
             begin
                word_size = 4;
             end
           SHMEM_FILL_QWORD_INC :
             begin
                word_size = 8;
             end
           default :
             begin
                word_size = 1;
             end
         endcase // case(mode)
         begin : compare_loop
            while (rembytes > 0)
              begin
		 case (mode)
		   SHMEM_FILL_ZERO :
                     begin
			actual[7:0] = shmem_read(uaddr, 1);
			if (actual[7:0] != ZDATA)
			  begin
                             expline = {"    Expected Data: ", himage2(ZDATA[7:0]), "              "};
                             actline = {"      Actual Data: ", himage2(actual[7:0]), "              "};
                             disable compare_loop;
			  end
			rembytes = rembytes - 1;
			uaddr = uaddr + 1;
                     end
		   SHMEM_FILL_BYTE_INC :
                     begin
			actual[7:0] = shmem_read(uaddr, 1);
			if (actual[7:0] != data[7:0])
			  begin
                             expline = {"    Expected Data: ", himage2(data[7:0]), "              "};
                             actline = {"      Actual Data: ", himage2(actual[7:0]), "              "};
                             disable compare_loop;
			  end
			data[7:0] = data[7:0] + 1;
			rembytes = rembytes - 1;
			uaddr = uaddr + 1;
                     end
		   SHMEM_FILL_WORD_INC :
                     begin
			actual[7:0] = shmem_read(uaddr, 1);
			if (actual[7:0] != data[(incr_count * 8)+:8])
			  begin
                             expline = {"    Expected Data: ", himage2(data[(incr_count * 8)+:8]), "              "};
                             actline = {"      Actual Data: ", himage2(actual[7:0]), "              "};
                             disable compare_loop;
			  end
			if (incr_count == 1)
			  begin
                             data[15:0] = data[15:0] + 1 ;
                             incr_count = 0;
			  end
			else
			  begin
                             incr_count = incr_count + 1;
			  end
			rembytes = rembytes - 1;
			uaddr = uaddr + 1;
                     end
		   SHMEM_FILL_DWORD_INC :
                     begin
			actual[7:0] = shmem_read(uaddr, 1);
			if (actual[7:0] != data[(incr_count * 8)+:8])
			  begin
                             expline = {"    Expected Data: ", himage2(data[(incr_count * 8)+:8]), "              "};
                             actline = {"      Actual Data: ", himage2(actual[7:0]), "              "};
                             disable compare_loop;
			  end
			if (incr_count == 3)
			  begin
                             data[31:0] = data[31:0] + 1;
                             incr_count = 0;
			  end
			else
			  begin
                             incr_count = incr_count + 1;
			  end
			rembytes = rembytes - 1;
			uaddr = uaddr + 1;
                     end
		   SHMEM_FILL_QWORD_INC :
                     begin
			actual[7:0] = shmem_read(uaddr, 1);
			if (actual[7:0] != data[(incr_count * 8)+:8])
			  begin
                             expline = {"    Expected Data: ", himage2(data[(incr_count * 8)+:8]), "              "};
                             actline = {"      Actual Data: ", himage2(actual[7:0]), "              "};
                             disable compare_loop;
			  end
			if (incr_count == 7)
			  begin
                             data[63:0] = data[63:0] + 1;
                             incr_count = 0;
			  end
			else
			  begin
                             incr_count = incr_count + 1;
			  end
			rembytes = rembytes - 1;
			uaddr = uaddr + 1;
                     end
		   SHMEM_FILL_ONE :
                     begin
			actual[7:0] = shmem_read(uaddr, 1);
			if (actual[7:0] != ODATA)
			  begin
                             expline = {"    Expected Data: ", himage2(ODATA[7:0]), "              "};
                             actline = {"      Actual Data: ", himage2(actual[7:0]), "              "};
                             disable compare_loop;
			  end
			rembytes = rembytes - 1;
			uaddr = uaddr + 1;
                     end
		   default :
                     begin
                     end
		 endcase
              end
         end // block: compare_loop
         if (rembytes > 0)
           begin
              if (display_error == 1)
		begin
		   dummy = ebfm_display(EBFM_MSG_ERROR_INFO, "");
		   dummy = ebfm_display(EBFM_MSG_ERROR_INFO, {"Shared memory data miscompare at address: ", himage8(uaddr)});
		   dummy = ebfm_display(EBFM_MSG_ERROR_INFO, expline);
		   dummy = ebfm_display(EBFM_MSG_ERROR_INFO, actline);
		   // Backup and display a little before the miscompare
		   // Figure amount to backup
		   daddr = uaddr % 32; // Back up no more than 32 bytes
		   // There was a miscompare, display an error message
		   if (daddr < 16)
		     begin
			// But at least 16
			daddr = daddr + 16;
		     end
		   // Backed up display address
		   daddr = uaddr - daddr;
		   // Don't backup more than start of compare
		   if (daddr < addr)
		     begin
			daddr = addr;
		     end
		   // Try to display 64 bytes
		   dlen = 64;
		   // But don't display beyond the end of the compare
		   if (daddr + dlen > addr + leng)
		     begin
			dlen = (addr + leng) - daddr;
		     end
		   dummy = shmem_display(daddr, dlen, word_size, uaddr, EBFM_MSG_ERROR_INFO);
		end
              shmem_chk_ok = 0;
           end
         else
           begin
              shmem_chk_ok = 1;
           end
      end
   endfunction
   //`endif
   // This constant defines how long to wait whenever waiting for some external event...
   localparam NUM_PS_TO_WAIT = 8000 ;

   // purpose: Sets the Max Payload size variables
   task req_intf_set_max_payload;
      input max_payload_size;
      integer max_payload_size;
      input   ep_max_rd_req; // 0 means use max_payload_size
      integer ep_max_rd_req;
      input   rp_max_rd_req;
      integer rp_max_rd_req;

      begin
         // 0 means use max_payload_size
         // set_max_payload
         bfm_req_intf_common.bfm_max_payload_size = max_payload_size;
         if (ep_max_rd_req > 0)
           begin
              bfm_req_intf_common.bfm_ep_max_rd_req = ep_max_rd_req;
           end
         else
           begin
              bfm_req_intf_common.bfm_ep_max_rd_req = max_payload_size;
           end
         if (rp_max_rd_req > 0)
           begin
              bfm_req_intf_common.bfm_rp_max_rd_req = rp_max_rd_req;
           end
         else
           begin
              bfm_req_intf_common.bfm_rp_max_rd_req = max_payload_size;
           end
      end
   endtask

   // purpose: Returns the stored max payload size
   function integer req_intf_max_payload_size;
      input dummy;
      begin
         req_intf_max_payload_size = bfm_req_intf_common.bfm_max_payload_size;
      end
   endfunction

   // purpose: Returns the stored end point max read request size
   function integer req_intf_ep_max_rd_req_size;
      input dummy;
      begin
         req_intf_ep_max_rd_req_size = bfm_req_intf_common.bfm_ep_max_rd_req;
      end
   endfunction

   // purpose: Returns the stored root port max read request size
   function integer req_intf_rp_max_rd_req_size;
      input dummy;
      begin
         req_intf_rp_max_rd_req_size = bfm_req_intf_common.bfm_rp_max_rd_req;
      end
   endfunction

   // purpose: procedure to wait until the root port is done being reset
   task req_intf_wait_reset_end;

      begin
         while (bfm_req_intf_common.reset_in_progress == 1'b1)
           begin
              #NUM_PS_TO_WAIT;
           end
      end
   endtask

   // purpose: procedure to get a free tag from the pool. Waits for one
   // to be free if none available initially
   task req_intf_get_tag;
      output tag;
      integer tag;
      input   need_handle;
      input   lcl_addr;
      integer lcl_addr;

      integer tag_v;

      begin
         tag_v = EBFM_NUM_TAG ;
         while ((tag_v > EBFM_NUM_TAG - 1) & (bfm_req_intf_common.reset_in_progress == 1'b0))
           begin : main_tloop
              // req_intf_get_tag
              // Find a tag to use
              begin : xhdl_0
		 integer i;
		 for(i = 0; i <= EBFM_NUM_TAG - 1; i = i + 1)
		   begin : sub_tloop
                      if (((bfm_req_intf_common.tag_busy[i]) == 1'b0) &
			  ((bfm_req_intf_common.hnd_busy[i]) == 1'b0))
			begin
			   bfm_req_intf_common.tag_busy[i] = 1'b1;
			   bfm_req_intf_common.hnd_busy[i] = need_handle;
			   bfm_req_intf_common.tag_lcl_addr[i] = lcl_addr;
			   tag_v = i;
			   disable main_tloop;
			end
		   end
              end // i
              #(NUM_PS_TO_WAIT);
           end
         if (bfm_req_intf_common.reset_in_progress == 1'b1)
           begin
              tag = EBFM_NUM_TAG;
           end
         else
           begin
              tag = tag_v;
           end
      end
   endtask

   // purpose: makes a request pending for the appropriate VC interface
   task req_intf_vc_req;
      input[192:0] info_v;

      integer 	   vcnum;

      reg 	   dummy ;

      begin
         // Get the Virtual Channel Number from the Traffic Class Number
         vcnum = bfm_req_intf_common.tc2vc_map[info_v[118:116]];
         if (vcnum >= EBFM_NUM_VC)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,
				   {"Attempt to transmit Packet with TC mapped to unsupported VC.",
				    "TC: ", dimage1(info_v[118:116]),
				    ", VC: ", dimage1(vcnum)});
           end
         // Make sure the ACK from any previous requests are cleared
         while (((bfm_req_intf_common.req_info_ack[vcnum]) == 1'b1) &
                (bfm_req_intf_common.reset_in_progress == 1'b0))
           begin
              #(NUM_PS_TO_WAIT);
           end
         if (bfm_req_intf_common.reset_in_progress == 1'b1)
           begin
              // Exit
              disable req_intf_vc_req ;
           end
         // Make the Request
         bfm_req_intf_common.req_info[vcnum] = info_v;
         bfm_req_intf_common.req_info_valid[vcnum] = 1'b1;
         // Now wait for it to be acknowledged
         while ((bfm_req_intf_common.req_info_ack[vcnum] == 1'b0) &
                (bfm_req_intf_common.reset_in_progress == 1'b0))
           begin
              #(NUM_PS_TO_WAIT);
           end
         // Clear the request
         bfm_req_intf_common.req_info[vcnum] = {193{1'b0}};
         bfm_req_intf_common.req_info_valid[vcnum] = 1'b0;
      end
   endtask

   // purpose: Releases a reserved handle
   task req_intf_release_handle;
      input handle;
      integer handle;

      reg     dummy ;

      begin
         // req_intf_release_handle
         if ((bfm_req_intf_common.hnd_busy[handle]) != 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,
				   {"Attempt to release Handle ",
				    dimage4(handle),
				    " that is not reserved."});
           end
         bfm_req_intf_common.hnd_busy[handle] = 1'b0;
      end
   endtask

   // purpose: Wait for completion on the specified handle
   task req_intf_wait_compl;
      input handle;
      integer handle;
      output [2:0] compl_status;
      input 	   keep_handle;

      reg 	   dummy ;

      begin
         if ((bfm_req_intf_common.hnd_busy[handle]) != 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,
				   {"Attempt to wait for completion on Handle ",
				    dimage4(handle),
				    " that is not reserved."});
           end
         while ((bfm_req_intf_common.reset_in_progress == 1'b0) &
                (bfm_req_intf_common.tag_busy[handle] == 1'b1))
           begin
              #(NUM_PS_TO_WAIT);
           end
         if ((bfm_req_intf_common.tag_busy[handle]) == 1'b0)
           begin
              compl_status = bfm_req_intf_common.tag_status[handle];
           end
         else
           begin
              compl_status = "UUU";
           end
         if (keep_handle != 1'b1)
           begin
              req_intf_release_handle(handle);
           end
      end
   endtask

   // purpose: This gets the pending request (if any) for the specified VC
   task vc_intf_get_req;
      input vc_num;
      integer vc_num;
      output  req_valid;
      output [127:0] req_desc;
      output 	     lcladdr;
      integer 	     lcladdr;
      output 	     imm_valid;
      output [31:0]  imm_data;

      begin
         // vc_intf_get_req
         req_desc  = bfm_req_intf_common.req_info[vc_num][127:0];
         lcladdr   = bfm_req_intf_common.req_info[vc_num][159:128];
         imm_data  = bfm_req_intf_common.req_info[vc_num][191:160];
         imm_valid = bfm_req_intf_common.req_info[vc_num][192];
         req_valid = bfm_req_intf_common.req_info_valid[vc_num];
      end
   endtask

   // purpose: This sets the acknowledgement for a pending request
   task vc_intf_set_ack;
      input vc_num;
      integer vc_num;

      reg     dummy ;

      begin
         if (bfm_req_intf_common.req_info_valid[vc_num] != 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,
				   {"VC Interface ",
				    dimage1(vc_num),
				    " tried to ACK a request that is not there."});
           end
         if (bfm_req_intf_common.req_info_ack[vc_num] != 1'b0)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,
				   {"VC Interface ",
				    dimage1(vc_num),
				    " tried to ACK a request second time."});
           end
         bfm_req_intf_common.req_info_ack[vc_num] = 1'b1;
      end
   endtask

   // purpose: This conditionally clears the acknowledgement for a pending request
   //          It only clears the ack if the req valid has been cleared.
   //          Returns '1' if the Ack was cleared, else returns '0'.
   function [0:0] vc_intf_clr_ack;
      input vc_num;
      integer vc_num;

      begin
         if ((bfm_req_intf_common.req_info_valid[vc_num]) == 1'b0)
           begin
              bfm_req_intf_common.req_info_ack[vc_num] = 1'b0;
              vc_intf_clr_ack = 1'b1;
           end
         else
           begin
              vc_intf_clr_ack = 1'b0;
           end
      end
   endfunction

   // purpose: This routine is to record the completion of a previous non-posted request
   task vc_intf_rpt_compl;
      input tag;
      integer tag;
      input [2:0] status;

      reg 	  dummy ;

      begin
         // vc_intf_rpt_compl
         bfm_req_intf_common.tag_status[tag] = status;
         if ((bfm_req_intf_common.tag_busy[tag]) != 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,
				   {"Tried to clear a tag that was not busy. Tag: ",
				    dimage4(tag)});
           end
         bfm_req_intf_common.tag_busy[tag] = 1'b0;
      end
   endtask

   task vc_intf_reset_flag;
      input rstn;

      begin
         bfm_req_intf_common.reset_in_progress = ~rstn;
      end
   endtask

   function integer vc_intf_get_lcl_addr;
      input tag;
      integer tag;

      begin
         // vc_intf_get_lcl_addr
         if ((bfm_req_intf_common.tag_lcl_addr[tag] != -1) &
             ((bfm_req_intf_common.tag_busy[tag] == 1'b1) |
              (bfm_req_intf_common.hnd_busy[tag] == 1'b1)))
           begin
              vc_intf_get_lcl_addr = bfm_req_intf_common.tag_lcl_addr[tag];
           end
         else
           begin
              vc_intf_get_lcl_addr = -1 ;
           end
      end
   endfunction

   function integer vc_intf_sample_perf;
      input vc_num;
      integer vc_num;
      begin
         vc_intf_sample_perf = bfm_req_intf_common.perf_req[vc_num];
      end
   endfunction

   task vc_intf_set_perf;
      input [31:0] vc_num;
      input [31:0] tx_pkts;
      input [31:0] tx_qwords;
      input [31:0] rx_pkts;
      input [31:0] rx_qwords;
      begin
	 bfm_req_intf_common.perf_tx_pkts[vc_num]   = tx_pkts ;
	 bfm_req_intf_common.perf_tx_qwords[vc_num] = tx_qwords ;
	 bfm_req_intf_common.perf_rx_pkts[vc_num]   = rx_pkts ;
	 bfm_req_intf_common.perf_rx_qwords[vc_num] = rx_qwords ;
	 bfm_req_intf_common.perf_ack[vc_num]       = 1'b1 ;
      end
   endtask

   task vc_intf_clr_perf;
      input vc_num;
      integer vc_num;
      begin
         bfm_req_intf_common.perf_ack[vc_num] = 1'b0;
      end
   endtask

   task req_intf_start_perf_sample;
      integer i;
      begin
	 bfm_req_intf_common.perf_req = {EBFM_NUM_VC{1'b1}};
	 bfm_req_intf_common.last_perf_timestamp = $time;
	 while (bfm_req_intf_common.perf_req != {EBFM_NUM_VC{1'b0}})
	   begin
              #NUM_PS_TO_WAIT;
              for (i = 1'b0 ; i < EBFM_NUM_VC ; i = i +1)
		begin
		   if (bfm_req_intf_common.perf_ack[i] == 1'b1)
		     begin
			bfm_req_intf_common.perf_req[i] = 1'b0;
		     end
		end
	   end
      end
   endtask

   task req_intf_disp_perf_sample;
      integer total_tx_qwords;
      integer total_tx_pkts;
      integer total_rx_qwords;
      integer total_rx_pkts;
      integer tx_mbyte_ps;
      integer rx_mbyte_ps;
      output  tx_mbit_ps;
      integer tx_mbit_ps;
      output  rx_mbit_ps;
      integer rx_mbit_ps;
      integer delta_time;
      integer delta_ns;
      output  bytes_transmitted;
      integer bytes_transmitted;
      reg [EBFM_MSG_MAX_LEN*8:1] message;
      integer 			 i;
      integer 			 dummy;
      begin
	 total_tx_qwords = 0;
	 total_tx_pkts   = 0;
	 total_rx_qwords = 0;
	 total_rx_pkts   = 0;
	 delta_time = $time - bfm_req_intf_common.last_perf_timestamp;
	 delta_ns = delta_time / 1000;
	 req_intf_start_perf_sample ;
	 for (i = 0; i < EBFM_NUM_VC; i = i + 1)
	   begin
              total_tx_qwords = total_tx_qwords + bfm_req_intf_common.perf_tx_qwords[i] ;
              total_tx_pkts   = total_tx_pkts   + bfm_req_intf_common.perf_tx_pkts[i];
              total_rx_qwords = total_rx_qwords + bfm_req_intf_common.perf_rx_qwords[i];
              total_rx_pkts   = total_rx_pkts   + bfm_req_intf_common.perf_rx_pkts[i];
	   end
	 tx_mbyte_ps = (total_tx_qwords * 8) / (delta_ns / 1000);
	 rx_mbyte_ps = (total_rx_qwords * 8) / (delta_ns / 1000);
	 tx_mbit_ps  = tx_mbyte_ps * 8;
	 rx_mbit_ps  = rx_mbyte_ps * 8;
	 bytes_transmitted = total_tx_qwords*8;

	 dummy = ebfm_display(EBFM_MSG_INFO, {image("PERF: Sample Duration: ", delta_ns)," ns"});
	 dummy = ebfm_display(EBFM_MSG_INFO, {image("PERF:      Tx Packets: ", total_tx_pkts)});
	 dummy = ebfm_display(EBFM_MSG_INFO, {image("PERF:        Tx Bytes: ", total_tx_qwords*8)});
	 dummy = ebfm_display(EBFM_MSG_INFO, {image("PERF:    Tx MByte/sec: ", tx_mbyte_ps)});
	 dummy = ebfm_display(EBFM_MSG_INFO, {image("PERF:     Tx Mbit/sec: ", tx_mbit_ps)});
	 dummy = ebfm_display(EBFM_MSG_INFO, {image("PERF:      Rx Packets: ", total_rx_pkts)});
	 dummy = ebfm_display(EBFM_MSG_INFO, {image("PERF:        Rx Bytes: ", total_rx_qwords*8)});
	 dummy = ebfm_display(EBFM_MSG_INFO, {image("PERF:    Rx MByte/sec: ", rx_mbyte_ps)});
	 dummy = ebfm_display(EBFM_MSG_INFO, {image("PERF:     Rx Mbit/sec: ", rx_mbit_ps)});
      end
   endtask


   function [3:0] ebfm_calc_firstbe;
      input byte_address;
      integer byte_address;
      input   byte_length;
      integer byte_length;

      begin
         case (byte_address % 4)
           0 :
             begin
                case (byte_length)
                  0 : ebfm_calc_firstbe = 4'b0000;
                  1 : ebfm_calc_firstbe = 4'b0001;
                  2 : ebfm_calc_firstbe = 4'b0011;
                  3 : ebfm_calc_firstbe = 4'b0111;
                  default : ebfm_calc_firstbe = 4'b1111;
                endcase
             end
           1 :
             begin
                case (byte_length)
                  0 : ebfm_calc_firstbe = 4'b0000;
                  1 : ebfm_calc_firstbe = 4'b0010;
                  2 : ebfm_calc_firstbe = 4'b0110;
                  default : ebfm_calc_firstbe = 4'b1110;
                endcase
             end
           2 :
             begin
                case (byte_length)
                  0 : ebfm_calc_firstbe = 4'b0000;
                  1 : ebfm_calc_firstbe = 4'b0100;
                  default : ebfm_calc_firstbe = 4'b1100;
                endcase
             end
           3 :
             begin
                case (byte_length)
                  0 : ebfm_calc_firstbe = 4'b0000;
                  default : ebfm_calc_firstbe = 4'b1000;
                endcase
             end
           default :
             begin
                ebfm_calc_firstbe = 4'b0000;
             end
         endcase
      end
   endfunction

   function [3:0] ebfm_calc_lastbe;
      input byte_address;
      integer byte_address;
      input   byte_length;
      integer byte_length;

      begin
         if ((byte_address % 4) + byte_length > 4)
           begin
              case ((byte_address + byte_length) % 4)
		0 : ebfm_calc_lastbe = 4'b1111;
		3 : ebfm_calc_lastbe = 4'b0111;
		2 : ebfm_calc_lastbe = 4'b0011;
		1 : ebfm_calc_lastbe = 4'b0001;
		default : ebfm_calc_lastbe = 4'bXXXX;
              endcase
           end
         else
           begin
              ebfm_calc_lastbe = 4'b0000;
           end
      end
   endfunction

   // purpose: This is the full featured configuration read that has all
   // optional behavior via the arguments
   task ebfm_cfgrd;
      input bus_num;
      integer bus_num;
      input   dev_num;
      integer dev_num;
      input   fnc_num;
      integer fnc_num;
      input   regb_ad;
      integer regb_ad;
      input   regb_ln;
      integer regb_ln;
      input   lcladdr;
      integer lcladdr;
      input   compl_wait;
      input   need_handle;
      output [2:0] compl_status;
      output 	   handle;
      integer 	   handle;

      reg [192:0]  info_v;
      integer 	   tag_v;
      reg 	   i_need_handle;

      begin
         info_v = {193{1'b0}} ;

         // Get a TAG
	 sem.get(1);
         i_need_handle = compl_wait | need_handle;
         req_intf_get_tag(tag_v, i_need_handle, lcladdr);
	 
         // Assemble the request
         if ((bus_num == RP_PRI_BUS_NUM) & (dev_num == RP_PRI_DEV_NUM))
           begin
              info_v[127:120] = 8'h04; // CfgRd0
           end
         else
           begin
              info_v[127:120] = 8'h05; // CfgRd1
           end
         info_v[119:112] = 8'h00; // R, TC, RRRR fields all 0
         info_v[111:104] = 8'h00; // TD, EP, Attr, RR, LL all 0
         info_v[103:96] = 8'h01; // Length 1 DW
         info_v[95:80] = RP_REQ_ID; // Requester ID
         info_v[79:72] = tag_v ;
         info_v[71:68] = 4'h0; // Last DW BE
         info_v[67:64] = ebfm_calc_firstbe(regb_ad, regb_ln);
         info_v[63:56] = bus_num[7:0] ;
         info_v[55:51] = dev_num[4:0] ;
         info_v[50:48] = fnc_num[2:0] ;
         info_v[47:44] = 4'h0; // RRRR
         info_v[43:34] = (regb_ad / 4) ;
         info_v[33:32] = 2'b00; // RR
         // Make the request
         req_intf_vc_req(info_v);

         // Wait for completion if specified to do so
         if (compl_wait == 1'b1)
           begin
              req_intf_wait_compl(tag_v, compl_status, need_handle);
           end
         else
           begin
              compl_status = "UUU";
           end	 
         // Return the handle
         if (need_handle == 1'b0)
           begin
              handle = -1;
           end
         else
           begin
              handle = tag_v;
           end
	 sem.put(1);
      end
   endtask

   // purpose: Configuration Read that waits for completion automatically
   task ebfm_cfgrd_wait;
      input bus_num;
      integer bus_num;
      input   dev_num;
      integer dev_num;
      input   fnc_num;
      integer fnc_num;
      input   regb_ad;
      integer regb_ad;
      input   regb_ln;
      integer regb_ln;
      input   lcladdr;
      integer lcladdr;
      output [2:0] compl_status;

      integer 	   dum_hnd;

      begin
         ebfm_cfgrd(bus_num, dev_num, fnc_num, regb_ad, regb_ln, lcladdr,
		    1'b1, 1'b0, compl_status, dum_hnd);
      end
   endtask

   // purpose: Configuration Read that does not wait, does not return handle
   //          Need to assume completes okay and is known to be done by the
   //          time a subsequent read completes.
   task ebfm_cfgrd_nowt;
      input bus_num;
      integer bus_num;
      input   dev_num;
      integer dev_num;
      input   fnc_num;
      integer fnc_num;
      input   regb_ad;
      integer regb_ad;
      input   regb_ln;
      integer regb_ln;
      input   lcladdr;
      integer lcladdr;

      integer dum_hnd;
      reg [2:0] dum_sts;

      begin
         ebfm_cfgrd(bus_num, dev_num, fnc_num, regb_ad, regb_ln, lcladdr,
		    1'b0, 1'b0, dum_sts, dum_hnd);
      end
   endtask

   // purpose: This is the full featured configuration write that has all
   // optional behavior via the arguments
   task ebfm_cfgwr;
      input bus_num;
      integer bus_num;
      input   dev_num;
      integer dev_num;
      input   fnc_num;
      integer fnc_num;
      input   regb_ad;
      integer regb_ad;
      input   regb_ln;
      integer regb_ln;
      input   lcladdr;
      integer lcladdr;
      input   imm_valid;
      input [31:0] imm_data;
      input 	   compl_wait;
      input 	   need_handle;
      output [2:0] compl_status;
      output 	   handle;
      integer 	   handle;

      reg [192:0]  info_v;
      integer 	   tag_v;
      reg 	   i_need_handle;

      begin
         info_v = {193{1'b0}} ;
         // Get a TAG
	 sem.get(1);
         i_need_handle = compl_wait | need_handle;
         req_intf_get_tag(tag_v, i_need_handle, -1);
	 
         // Assemble the request
         info_v[192] = imm_valid;
         info_v[191:160] = imm_data;
         info_v[159:128] = lcladdr;
         if ((bus_num == RP_PRI_BUS_NUM) & (dev_num == RP_PRI_DEV_NUM))
           begin
              info_v[127:120] = 8'h44; // CfgWr0
           end
         else
           begin
              info_v[127:120] = 8'h45; // CfgWr1
           end
         info_v[119:112] = 8'h00; // R, TC, RRRR fields all 0
         info_v[111:104] = 8'h00; // TD, EP, Attr, RR, LL all 0
         info_v[103:96] = 8'h01; // Length 1 DW
         info_v[95:80] = RP_REQ_ID; // Requester ID
         info_v[79:72] = tag_v ;
         info_v[71:68] = 4'h0; // Last DW BE
         info_v[67:64] = ebfm_calc_firstbe(regb_ad, regb_ln);
         info_v[63:56] = bus_num[7:0] ;
         info_v[55:51] = dev_num[4:0] ;
         info_v[50:48] = fnc_num[2:0] ;
         info_v[47:44] = 4'h0; // RRRR
         info_v[43:34] = (regb_ad / 4) ;
         info_v[33:32] = 2'b00; // RR
         // Make the request
	 
         req_intf_vc_req(info_v);
         // Wait for completion if specified to do so
         if (compl_wait == 1'b1)
           begin
              req_intf_wait_compl(tag_v, compl_status, need_handle);
           end
         else
           begin
              compl_status = "UUU";
           end
         // Return the handle
         if (need_handle == 1'b0)
           begin
              handle = -1;
           end
         else
           begin
              handle = tag_v;
           end
	 sem.put(1);
	 
      end
   endtask

   // purpose: Configuration Write, Immediate Data, that waits for completion automatically
   task ebfm_cfgwr_imm_wait;
      input bus_num;
      integer bus_num;
      input   dev_num;
      integer dev_num;
      input   fnc_num;
      integer fnc_num;
      input   regb_ad;
      integer regb_ad;
      input   regb_ln;
      integer regb_ln;
      input [31:0] imm_data;
      output [2:0] compl_status;

      integer 	   dum_hnd;

      begin
         ebfm_cfgwr(bus_num, dev_num, fnc_num, regb_ad, regb_ln, 0, 1'b1,
		    imm_data, 1'b1, 1'b0, compl_status, dum_hnd);
      end
   endtask

   // purpose: Configuration Write, Immediate Data, no wait, no handle
   task ebfm_cfgwr_imm_nowt;
      input bus_num;
      integer bus_num;
      input   dev_num;
      integer dev_num;
      input   fnc_num;
      integer fnc_num;
      input   regb_ad;
      integer regb_ad;
      input   regb_ln;
      integer regb_ln;
      input [31:0] imm_data;

      reg [2:0]    dum_sts;
      integer 	   dum_hnd;

      begin
         ebfm_cfgwr(bus_num, dev_num, fnc_num, regb_ad, regb_ln, 0, 1'b1,
		    imm_data, 1'b0, 1'b0, dum_sts, dum_hnd);
      end
   endtask

   function [9:0] calc_dw_len;
      input byte_adr;
      integer byte_adr;
      input   byte_len;
      integer byte_len;

      integer adr_len;
      reg [9:0] dw_len;

      begin
         // calc_dw_len
         adr_len = byte_len + (byte_adr % 4);
         if (adr_len % 4 == 0)
           begin
              dw_len = (adr_len / 4);
           end
         else
           begin
              dw_len = ((adr_len / 4) + 1);
           end
         calc_dw_len = dw_len;
      end
   endfunction

   task ebfm_memwr;
      input[63:0] pcie_addr;
      input 	  lcladdr;
      integer 	  lcladdr;
      input 	  byte_len;
      integer 	  byte_len;
      input 	  tclass;
      integer 	  tclass;

      reg [192:0] info_v;
      integer 	  baddr_v;

      begin
         info_v = {193{1'b0}} ;
         // ebfm_memwr
         baddr_v = pcie_addr[11:0] ;
         // Assemble the request
         info_v[159:128] = lcladdr ;
         if (pcie_addr[63:32] == 32'h00000000)
           begin
              info_v[127:120] = 8'h40; // 3DW Header w/Data MemWr
              info_v[63:34] = pcie_addr[31:2];
              info_v[31:0] = {32{1'b0}};
           end
         else
           begin
              info_v[127:120] = 8'h60; // 4DW Header w/Data MemWr
              info_v[63:2] = pcie_addr[63:2];
           end
         info_v[119] = 1'b0; // Reserved bit
         info_v[118:116] = tclass;
         info_v[115:112] = 4'h0; // Reserved bits all 0
         info_v[111:106] = 6'b000000; // TD, EP, Attr, RR all 0
         info_v[105:96] = calc_dw_len(baddr_v, byte_len);
         info_v[95:80] = RP_REQ_ID; // Requester ID
         info_v[79:72] = 8'h00;
         info_v[71:68] = ebfm_calc_lastbe(baddr_v, byte_len);
         info_v[67:64] = ebfm_calc_firstbe(baddr_v, byte_len);
         // Make the request
	 sem.get(1);
	 
         req_intf_vc_req(info_v);

	 sem.put(1);
	 
      end
   endtask

   task ebfm_memwr_imm;
      input[63:0] pcie_addr;
      input [31:0] imm_data;
      input 	   byte_len;
      integer 	   byte_len;
      input 	   tclass;
      integer 	   tclass;

      reg [192:0]  info_v;
      integer 	   baddr_v;

      begin

         info_v = {193{1'b0}} ;
         // ebfm_memwr_imm
         baddr_v = pcie_addr[11:0];
         // Assemble the request
         info_v[192] = 1'b1;
         info_v[191:160] = imm_data ;
         if (pcie_addr[63:32] == 32'h00000000)
           begin
              info_v[127:120] = 8'h40; // 3DW Header w/Data MemWr
              info_v[63:34] = pcie_addr[31:2];
              info_v[31:0] = {32{1'b0}};
           end
         else
           begin
              info_v[127:120] = 8'h60; // 4DW Header w/Data MemWr
              info_v[63:2] = pcie_addr[63:2];
           end
         info_v[119] = 1'b0; // Reserved bit
         info_v[118:116] = tclass ;
         info_v[115:112] = 4'h0; // Reserved bits all 0
         info_v[111:106] = 6'b000000; // TD, EP, Attr, RR all 0
         info_v[105:96] = calc_dw_len(baddr_v, byte_len);
         info_v[95:80] = RP_REQ_ID; // Requester ID
         info_v[79:72] = 8'h00 ;
         info_v[71:68] = ebfm_calc_lastbe(baddr_v, byte_len);
         info_v[67:64] = ebfm_calc_firstbe(baddr_v, byte_len);

         // Make the request
	 sem.get(1);
         req_intf_vc_req(info_v);
	 sem.put(1);
	 
      end
   endtask

   // purpose: This is the full featured memory read that has all
   // optional behavior via the arguments
   task ebfm_memrd;
      input[63:0] pcie_addr;
      input 	  lcladdr;
      integer 	  lcladdr;
      input 	  byte_len;
      integer 	  byte_len;
      input 	  tclass;
      integer 	  tclass;
      input 	  compl_wait;
      input 	  need_handle;
      output [2:0] compl_status;
      output 	   handle;
      integer 	   handle;

      reg [192:0]  info_v;
      integer 	   tag_v;
      reg 	   i_need_handle;
      integer 	   baddr_v;

      begin
         info_v = {193{1'b0}} ;
         // Get a TAG
	 sem.get(1);
         i_need_handle = compl_wait | need_handle;
         req_intf_get_tag(tag_v, i_need_handle, lcladdr);
	 sem.put(1);
	 
         baddr_v = pcie_addr[11:0];
         // Assemble the request
         info_v[159:128] = lcladdr ;
         if (pcie_addr[63:32] == 32'h00000000)
           begin
              info_v[127:120] = 8'h00; // 3DW Header w/o Data MemWr
              info_v[63:34] = pcie_addr[31:2];
              info_v[31:0] = {32{1'b0}};
           end
         else
           begin
              info_v[127:120] = 8'h20; // 4DW Header w/o Data MemWr
              info_v[63:2] = pcie_addr[63:2];
           end
         info_v[119] = 1'b0; // Reserved bit
         info_v[118:116] = tclass ;
         info_v[115:112] = 4'h0; // Reserved bits all 0
         info_v[111:106] = 6'b000000; // TD, EP, Attr, RR all 0
         info_v[105:96] = calc_dw_len(baddr_v, byte_len);
         info_v[95:80] = RP_REQ_ID; // Requester ID
         info_v[79:72] = tag_v ;
         info_v[71:68] = ebfm_calc_lastbe(baddr_v, byte_len);
         info_v[67:64] = ebfm_calc_firstbe(baddr_v, byte_len);
         // Make the request
	 sem.get(1);
	 
         req_intf_vc_req(info_v);
         // Wait for completion if specified to do so
         if (compl_wait == 1'b1)
           begin
              req_intf_wait_compl(tag_v, compl_status, need_handle);
           end
         else
           begin
              compl_status = "UUU";
           end
         // Return the handle
         if (need_handle == 1'b0)
           begin
              handle = -1;
           end
         else
           begin
              handle = tag_v;
           end
	 sem.put(1);
	 
      end
   endtask

   task ebfm_barwr;
      input bar_table;
      integer bar_table;
      input   bar_num;
      integer bar_num;
      input   pcie_offset;
      integer pcie_offset;
      input   lcladdr;
      integer lcladdr;
      input   byte_len;
      integer byte_len;
      input   tclass;
      integer tclass;

      reg [63:0] cbar;
      integer 	 rem_len;
      integer 	 offset;
      integer 	 cur_len;
      reg [63:0] paddr;

      reg 	 dummy ;

      begin
         rem_len = byte_len ;
         offset = 0 ;
         cbar = shmem_read(bar_table + (bar_num * 4), 8);
         if (((cbar[0]) == 1'b1) | ((cbar[2]) == 1'b0))
           begin
              cbar[63:32] = {32{1'b0}};
           end
         paddr = ({cbar[63:4], 4'b0000}) + pcie_offset;
         while (rem_len > 0)
           begin
              if ((cbar[0]) == 1'b1)
		begin
		   dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, "Accessing I/O or Expansion ROM BAR is unsupported");
		end
              else
		begin
		   cur_len = req_intf_max_payload_size(1'b0) - paddr[1:0];
		   if (cur_len > rem_len)
		     begin
			cur_len = rem_len;
		     end
		   if (((paddr % 4096) + cur_len) > 4096)
		     begin
			cur_len = 4096 - (paddr % 4096);
		     end
		   ebfm_memwr( paddr, lcladdr + offset, cur_len, tclass);
		end
              offset = offset + cur_len;
              rem_len = rem_len - cur_len;
              paddr = paddr + cur_len;
           end
      end
   endtask

   task ebfm_barwr_imm;
      input bar_table;
      integer bar_table;
      input   bar_num;
      integer bar_num;
      input   pcie_offset;
      integer pcie_offset;
      input [31:0] imm_data;
      input 	   byte_len;
      integer 	   byte_len;
      input 	   tclass;
      integer 	   tclass;

      reg [63:0]   cbar;

      reg 	   dummy ;

      begin
         cbar = shmem_read(bar_table + (bar_num * 4), 8);
         if (((cbar[0]) == 1'b1) | ((cbar[2]) == 1'b0))
           begin
              cbar[63:32] = {32{1'b0}};
           end
         if ((cbar[0]) == 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, "Accessing I/O or Expansion ROM BAR is unsupported");
           end
         else
           begin
              cbar[3:0] = 4'b0000;
              cbar = cbar + pcie_offset;
              ebfm_memwr_imm(cbar, imm_data, byte_len,
			     tclass);
           end // else: !if((cbar[0]) == 1'b1)
      end
   endtask

   task ebfm_barrd;
      input bar_table;
      integer bar_table;
      input   bar_num;
      integer bar_num;
      input   pcie_offset;
      integer pcie_offset;
      input   lcladdr;
      integer lcladdr;
      input   byte_len;
      integer byte_len;
      input   tclass;
      integer tclass;
      input   compl_wait;
      input   need_handle;
      output [2:0] compl_status;
      output 	   handle;
      integer 	   handle;

      reg [2:0]    dum_status;
      integer 	   dum_handle;
      reg [63:0]   cbar;
      integer 	   rem_len;
      integer 	   offset;
      integer 	   cur_len;
      reg [63:0]   paddr;

      reg 	   dummy ;

      begin
         rem_len = byte_len ;
         offset = 0 ;
         // ebfm_barrd
         cbar = shmem_read(bar_table + (bar_num * 4), 8);
         if (((cbar[0]) == 1'b1) | ((cbar[2]) == 1'b0))
           begin
              cbar[63:32] = {32{1'b0}};
           end
         paddr = ({cbar[63:4], 4'b0000}) + pcie_offset;
         while (rem_len > 0)
           begin
              if ((cbar[0]) == 1'b1)
		begin
		   dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, "Accessing I/O or Expansion ROM BAR is unsupported");
		end
              else
		begin
		   // Need to make sure we don't cross a DW boundary
		   cur_len = req_intf_rp_max_rd_req_size(1'b0) - paddr[1:0];
		   if (cur_len > rem_len)
		     begin
			cur_len = rem_len;
		     end
		   if (((paddr % 4096) + cur_len) > 4096)
		     begin
			cur_len = 4096 - (paddr % 4096);
		     end
		   if (rem_len == cur_len)
		     begin
			// If it is the last one use the passed in compl/handle parms
			ebfm_memrd(paddr, lcladdr + offset,
				   cur_len, tclass, compl_wait, need_handle, compl_status,
				   handle);
		     end
		   else
		     begin
			// Otherwise no wait, assume it all completes and the final one
			// pushes ahead
			ebfm_memrd(paddr, lcladdr + offset,
				   cur_len, tclass, 1'b0, 1'b0, dum_status, dum_handle);
		     end
		end
              offset = offset + cur_len;
              rem_len = rem_len - cur_len;
              paddr = paddr + cur_len;
           end
      end
   endtask

   task ebfm_barrd_wait;
      input bar_table;
      integer bar_table;
      input   bar_num;
      integer bar_num;
      input   pcie_offset;
      integer pcie_offset;
      input   lcladdr;
      integer lcladdr;
      input   byte_len;
      integer byte_len;
      input   tclass;
      integer tclass;

      reg [2:0] dum_status;
      integer 	dum_handle;

      begin
         // ebfm_barrd_wait
         ebfm_barrd(bar_table, bar_num, pcie_offset, lcladdr, byte_len,
		    tclass, 1'b1, 1'b0, dum_status, dum_handle);
      end
   endtask

   task ebfm_barrd_nowt;
      input bar_table;
      integer bar_table;
      input   bar_num;
      integer bar_num;
      input   pcie_offset;
      integer pcie_offset;
      input   lcladdr;
      integer lcladdr;
      input   byte_len;
      integer byte_len;
      input   tclass;
      integer tclass;

      reg [2:0] dum_status;
      integer 	dum_handle;

      begin
         // ebfm_barrd_nowt
         ebfm_barrd(bar_table, bar_num, pcie_offset, lcladdr, byte_len,
		    tclass, 1'b0, 1'b0, dum_status, dum_handle);
      end
   endtask

   task rdwr_start_perf_sample;
      begin
         req_intf_start_perf_sample;
      end
   endtask

   task rdwr_disp_perf_sample;
      output tx_mbit_ps;
      integer tx_mbit_ps;
      output  rx_mbit_ps;
      integer rx_mbit_ps;
      output  bytes_transmitted;
      integer bytes_transmitted;
      begin
         req_intf_disp_perf_sample(tx_mbit_ps, rx_mbit_ps, bytes_transmitted);
      end
   endtask

   // This is where the PCI Express Capability is for the MegaCore Function
   parameter PCIE_CAP_PTR = 128;

   task cfg_wr_bars;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   bar_base;
      integer bar_base;
      input   typ1;

      integer maxbar;
      integer rombar;
      reg [2:0] compl_status;

      begin
         if (typ1 == 1'b1)
           begin
              maxbar = 5;
              rombar = 14;
           end
         else
           begin
              maxbar = 9;
              rombar = 12;
           end
         begin : xhdl_0
            integer i;
            for(i = 4; i <= maxbar; i = i + 1)
              begin
		 ebfm_cfgwr_imm_nowt(bnm, dev, fnc, (i * 4), 4,
				     shmem_read(bar_base + ((i - 4) * 4), 4));
              end
         end // i
         ebfm_cfgwr_imm_wait(bnm, dev, fnc, (rombar * 4), 4,
			     shmem_read(bar_base + 24, 4), compl_status);
      end
   endtask

   task cfg_rd_bars;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   bar_base;
      integer bar_base;
      input   typ1;

      integer maxbar;
      integer rombar;
      reg [2:0] compl_status;

      begin
         if (typ1 == 1'b1)
           begin
              maxbar = 5;
              rombar = 14;
           end
         else
           begin
              maxbar = 9;
              rombar = 12;
           end
         begin : xhdl_1
            integer i;
            for(i = 4; i <= maxbar; i = i + 1)
              begin
		 ebfm_cfgrd_nowt(bnm, dev, fnc, (i * 4), 4, bar_base + ((i - 4) * 4));
              end
         end // i
         ebfm_cfgrd_wait(bnm, dev, fnc, (rombar * 4), 4, bar_base + 24, compl_status);
      end
   endtask

   // purpose: Configures the Address Window Registers in the Root Port
   task ebfm_cfg_rp_addr;
      // Prefetchable Base and Limits  must be supplied
      input[63:0] pci_pref_base;
      input [63:0] pci_pref_limit;
      // Non-Prefetchable Space Base and Limits are optional
      input [31:0] pci_nonp_base;
      input [31:0] pci_nonp_limit;
      // IO Space Base and Limits are optional
      input [31:0] pci_io_base;
      input [31:0] pci_io_limit;

      parameter bnm = RP_PRI_BUS_NUM;
      parameter dev = RP_PRI_DEV_NUM;

      begin  // ebfm_cfg_rp_addr
         // Configure the I/O Base and Limit Registers
         ebfm_cfgwr_imm_nowt(bnm, dev, 0, 28, 4,
                             {16'h0000,
                              pci_io_limit[15:12], 4'h0,
                              pci_io_base[15:12], 4'h0});
         // Configure the Non-Prefetchable Base & Limit Registers
         ebfm_cfgwr_imm_nowt(bnm, dev, 0, 32, 4,
                             {pci_nonp_limit[31:20], 4'h0,
                              pci_nonp_base[31:20], 4'h0});
         // Configure the Prefetchable Base & Limit Registers
         ebfm_cfgwr_imm_nowt(bnm, dev, 0, 36, 4,
                             {pci_pref_limit[31:20], 4'h0,
                              pci_pref_base[31:20], 4'h0});
         // Configure the Upper Prefetchable Base Register
         ebfm_cfgwr_imm_nowt(bnm, dev, 0, 40, 4,
                             pci_pref_base[63:32]);
         // Configure the Upper Prefetchable Limit Register
         ebfm_cfgwr_imm_nowt(bnm, dev, 0, 44, 4,
                             pci_pref_limit[63:32]);
         // Configure the Upper I/O Base and Limit Registers
         ebfm_cfgwr_imm_nowt(bnm, dev, 0, 48, 4,
                             {pci_io_limit[31:16],
                              pci_io_base[31:16]});

      end
   endtask

   task ebfm_cfg_rp_basic;
      // The Secondary Side Bus Number Defaults to 1 more than the Primary
      input sec_bnm_offset; // Secondary Side Bus Number
      // Offset from Primary
      // The number of subordinate busses defaults to 1
      integer sec_bnm_offset; // Number of Subordinate Busses
      input   num_sub_bus;
      integer num_sub_bus;

      reg [31:0] tmp_slv;
      parameter bnm = RP_PRI_BUS_NUM;
      parameter dev = RP_PRI_DEV_NUM;

      begin  // ebfm_cfg_rp_basic
         // Configure the command register
         ebfm_cfgwr_imm_nowt(bnm, dev, 0, 4, 4, 32'h00000006);
         // Configure the Bus number Registers
         // Primary BUS
         tmp_slv[7:0] = bnm ;
         // Secondary BUS (primary + offset)
         tmp_slv[15:8] = (bnm + sec_bnm_offset);
         // Maximum Subordinate BUS (primary + offset + num - 1)
         tmp_slv[23:16] = (bnm + sec_bnm_offset + num_sub_bus - 1);
         tmp_slv[31:24] = 8'h0;
         ebfm_cfgwr_imm_nowt(bnm, dev, 0, 24, 4, tmp_slv);

      end
   endtask

   task assign_bar;
      inout[63:0] bar;
      inout [63:0] amin; // amin = address minimum
      input [63:0] amax; // amax = address maximum

      reg [63:0]   tbar;   // tbar = temporary bar
      reg [63:0]   bsiz;   // bsiz = bar size

      begin
         tbar = {bar[63:4], 4'b0000};
         bsiz = (~tbar) + 1;
         // See if amin already on the boundary
         if ((amin & ~tbar) == 0)
           begin
              tbar = tbar & amin; // Lowest assignment
           end
         else
           begin
              // The lower bits were not 0, then we have to round up to the
              // next boundary
              tbar = (amin + bsiz) & tbar ;
           end
         if ((tbar + bsiz - 1) > amax)
           begin
              // We cant make the assignement
              bar[63:4] = {60{1'bx}};
           end
         else
           begin
              bar[63:4] = tbar[63:4];
              amin = tbar + bsiz;
           end
      end
   endtask

   task assign_bar_from_top;
      inout[63:0] bar;
      input [63:0] amin; // amin = address minimum
      inout [63:0] amax; // amax = address maximum

      reg [63:0]   tbar;   // tbar = temporary bar
      reg [63:0]   bsiz;   // bsiz = bar size

      begin
         bsiz = (~{bar[63:4], 4'b0000}) + 1;
         tbar = amax - bsiz + 1;  // Highest Assignment
         tbar = tbar & bar[63:0]; // Round Down
         if (tbar < amin)
           begin
              // We cant make the assignment
              bar[63:4] = {60{1'bx}};
           end
         else
           begin
              bar[63:4] = tbar[63:4];
              amax = tbar - 1;
           end
      end
   endtask


   // purpose: configure a set of bars
   task ebfm_cfg_bars;
      input bnm;         // Bus Number
      integer bnm;
      input   dev;         // Device Number
      integer dev;
      input   fnc;         // Function Number
      integer fnc;
      input   bar_table;   // Base Address in Shared Memory to
      integer bar_table; // store programmed value of BARs
      output  bar_ok;
      inout [31:0] io_min;
      inout [31:0] io_max;
      inout [63:0] m32min;
      inout [63:0] m32max;
      inout [63:0] m64min;
      inout [63:0] m64max;
      input 	   display;
      integer 	   display;
      input 	   addr_map_4GB_limit;

      reg [63:0]   io_min_v;
      reg [63:0]   io_max_v;
      reg [63:0]   m32min_v;
      reg [63:0]   m32max_v;
      reg [63:0]   m64min_v;
      reg [63:0]   m64max_v;
      reg 	   typ1;
      reg [2:0]    compl_status;
      integer 	   nbar;
      reg [63:0]   bars[0:6];
      integer 	   sm_bar[0:6];
      integer 	   bar_lsb[0:6];

      reg [7:0]    htype ;

      reg 	   dummy ;

      reg [63:0]   bars_xhdl ;

      begin  // ebfm_cfg_bars
         io_min_v = {32'h00000000,io_min} ;
         io_max_v = {32'h00000000,io_max} ;
         m32min_v = m32min ;
         m32max_v = m32max ;
         m64min_v = m64min ;
         m64max_v = m64max ;
         sm_bar[0] = 0 ;
         sm_bar[1] = 1 ;
         sm_bar[2] = 2 ;
         sm_bar[3] = 3 ;
         sm_bar[4] = 4 ;
         sm_bar[5] = 5 ;
         sm_bar[6] = 6 ;

         bar_ok = 1'b1;
         shmem_fill(bar_table, SHMEM_FILL_ONE, 32, {64{1'b0}});
         // Clear the last bit of the ROMBAR which is the enable bit...
         shmem_write(bar_table + 24, 8'hFE, 1) ;
         // Read Header Type Field into last DWORD
         ebfm_cfgrd_wait(bnm, dev, fnc, 12, 4, bar_table + 28, compl_status);
         htype = shmem_read(bar_table + 30, 1) ;
         if (htype[6:0] == 7'b0000001)
           begin
              typ1 = 1'b1;
           end
         else
           begin
              typ1 = 1'b0;
           end
         cfg_wr_bars(bnm, dev, fnc, bar_table, typ1);
         shmem_fill(bar_table, SHMEM_FILL_ZERO, 28, {64{1'b0}});
         shmem_fill(bar_table + 32, SHMEM_FILL_ZERO, 32, {64{1'b0}});
         cfg_rd_bars(bnm, dev, fnc, bar_table + 32, typ1);
         // Load each BAR into the local BAR array
         // Find the Least Significant Writable bit in each BAR
         nbar = 0;
         while (nbar < 7)
           begin
              bars[nbar] = shmem_read((bar_table + 32 + (nbar * 4)), 8);
              bars_xhdl = bars[nbar];
              if ((bars_xhdl[2]) == 1'b0)
                begin
                   // 32 bit
                   if ((bars_xhdl[31]) == 1'b1)
                     begin
                        // if valid
                        bars_xhdl[63:32] = {32{1'b1}};
                     end
                   else
                     begin
                        // if not valid
                        bars_xhdl[63:32] = {32{1'b0}};
                     end
                end
              else
                begin
                   // 64-bit BAR, mark the next one invalid
                   bar_lsb[nbar + 1] = 64;
                end

              bars[nbar] = bars_xhdl ;
              if (bars_xhdl[63:4] == 0)
                begin
                   bar_lsb[nbar] = 64;
                end
              else
                begin
                   begin : xhdl_3
                      integer j;
                      for(j = 4; j <= 63; j = j + 1)
                        begin : lsb_loop
                           if ((bars_xhdl[j]) == 1'b1)
                             begin
                                bar_lsb[nbar] = j;
                                disable xhdl_3 ;
                             end
                        end
                   end // j
                end

              // Increment 1 for 32bit BARs or 2 for 64bit BARs.
              bars_xhdl = bars[nbar];
              if ((bars_xhdl[2]) == 1'b0)
                begin
                   nbar = nbar + 1;
                end
              else
                begin
                   nbar = nbar + 2;
                end
           end // i

         begin : xhdl_4
            integer i;
            for(i = 0; i <= 5; i = i + 1)
              begin
                 // Sort the BARs in order smallest to largest
                 begin : xhdl_5
                    integer j;
                    for(j = i + 1; j <= 6; j = j + 1)
                      begin
                         if (bar_lsb[sm_bar[j]] < bar_lsb[sm_bar[i]])
                           begin
                              nbar = sm_bar[i];
                              sm_bar[i] = sm_bar[j];
                              sm_bar[j] = nbar;
                           end
                      end
                 end // j
              end
         end // i

         // Fill all of the I/O BARs First, Smallest to Largest
         begin : xhdl_6
            integer i;
            for(i = 0; i <= 6; i = i + 1)
              begin
		 if (bar_lsb[sm_bar[i]] < 64)
                   begin
                      bars_xhdl = bars[sm_bar[i]];
                      if ((bars_xhdl[0]) == 1'b1)
			begin
                           assign_bar(bars[sm_bar[i]], io_min_v, io_max_v);
			end
                   end
              end
         end // i
         // Now fill all of the 32-bit Non-Prefetchable BARs, Smallest to Largest
         begin : xhdl_7
            integer i;
            for(i = 0; i <= 6; i = i + 1)
              begin
                 if (bar_lsb[sm_bar[i]] < 64)
                   begin
                      bars_xhdl = bars[sm_bar[i]];
                      if (bars_xhdl[3:0] == 4'b0000)
                        begin
                           assign_bar(bars[sm_bar[i]], m32min_v, m32max_v);
                        end
                   end
              end
         end // i
         // Now fill all of the 32-bit Prefetchable BARs (and 64-bit Prefetchable BARs if addr_map_4GB_limit is set),
         // Largest to Smallest. From the top of memory.
         begin : xhdl_8
            integer i;
            for(i = 6; i >= 0; i = i - 1)
              begin
                 if (bar_lsb[sm_bar[i]] < 64)
                   begin
                      bars_xhdl = bars[sm_bar[i]];
                      if (bars_xhdl[3:0] == 4'b1000 ||
                          (addr_map_4GB_limit && bars_xhdl[3:0] == 4'b1100))
                        begin
                           assign_bar_from_top(bars[sm_bar[i]], m32min_v, m32max_v);
                        end
                   end
              end
         end // i
         // Now fill all of the 64-bit Prefetchable BARs, Smallest to Largest, if addr_map_4GB_limit is not set.
         if (addr_map_4GB_limit == 1'b0)
           begin : xhdl_9
              integer i;
              for(i = 0; i <= 6; i = i + 1)
		begin
		   if (bar_lsb[sm_bar[i]] < 64)
                     begin
			bars_xhdl = bars[sm_bar[i]];
			if (bars_xhdl[3:0] == 4'b1100)
			  begin
                             assign_bar(bars[sm_bar[i]], m64min_v, m64max_v);
			  end
                     end
		end
           end // i
         // Now put all of the BARs back in memory
         nbar = 0;
         if (display == 1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "");
              dummy = ebfm_display(EBFM_MSG_INFO, "BAR Address Assignments:");
              dummy = ebfm_display(EBFM_MSG_INFO, {"BAR   ", " ", "Size      ", " ", "Assigned Address ", " ", "Type"});
              dummy = ebfm_display(EBFM_MSG_INFO, {"---   ", " ", "----      ", " ", "---------------- ", " "});
           end
         while (nbar < 7)
           begin
              if (display == 1)
                begin
                   // Show the user what we have done
                   describe_bar(nbar, bar_lsb[nbar], bars[nbar],1'b0) ;
                end
              bars_xhdl = bars[nbar];
              // Check and see if the BAR was unabled to be assigned!!
              if (bars_xhdl[32] === 1'bx)
                begin
                   bar_ok = 1'b0;
                   // Clean up the X's...
                   bars[nbar] = {{60{1'b0}},bars[nbar][3:0]} ;
                end
              bars_xhdl = bars[nbar];
              if ((bars_xhdl[2]) != 1'b1)
                begin
                   shmem_write(bar_table + (nbar * 4), bars_xhdl[31:0], 4);
                   nbar = nbar + 1;
                end
              else
		begin
                   shmem_write(bar_table + (nbar * 4), bars_xhdl[63:0], 8);
                   nbar = nbar + 2;
		end
           end
         // Temporarily turn on the lowest bit of the ExpROM BAR so it is enabled
         shmem_write(bar_table + 24, 8'h01, 1) ;
         cfg_wr_bars(bnm, dev, fnc, bar_table, typ1);
         // Turn off the lowest bit of the ExpROM BAR so rest of the BFM knows it is a memory BAR
         shmem_write(bar_table + 24, 8'h00, 1) ;
         if (display == 1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "");
           end
         m64max = m64max_v;
         m64min = m64min_v;
         m32max = m32max_v;
         m32min = m32min_v;
         io_max = io_max_v[31:0];
         io_min = io_min_v[31:0];
      end
   endtask

   task ebfm_display_link_status_reg;
      input root_port;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;

      reg [2:0] compl_status;
      reg [15:0] link_sts;
      reg [15:0] link_ctrl;
      reg [15:0] link_cap;

      reg 	 dummy ;

      begin
         ebfm_cfgrd_wait(bnm, dev, fnc, PCIE_CAP_PTR + 16, 4, CFG_SCRATCH_SPACE, compl_status);
         link_sts  = shmem_read(CFG_SCRATCH_SPACE + 2, 2);
         link_ctrl = shmem_read(CFG_SCRATCH_SPACE,2);
         ebfm_cfgrd_wait(bnm, dev, fnc, PCIE_CAP_PTR + 12, 4, CFG_SCRATCH_SPACE, compl_status);
         link_cap = shmem_read(CFG_SCRATCH_SPACE ,2);
         if (root_port==1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"  RP PCI Express Link Status Register (", himage4(link_sts), "):"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"  EP PCI Express Link Status Register (", himage4(link_sts), "):"});

         dummy = ebfm_display(EBFM_MSG_INFO, {"    Negotiated Link Width: x", dimage1(link_sts[9:4])}) ;

         if ((link_sts[12]) == 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "        Slot Clock Config: System Reference Clock Used");
              // Setting common clk cfg bit
              link_ctrl = 16'h0040 | link_ctrl;
              ebfm_cfgwr_imm_wait(bnm,dev,fnc,144,2, {16'h0000, link_ctrl}, compl_status);
	      // retrain the link
	      ebfm_cfgwr_imm_wait(RP_PRI_BUS_NUM,RP_PRI_DEV_NUM,fnc,144,2, 32'h0000_0060, compl_status);
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "        Slot Clock Config: Local Clock Used");
           end

         if (root_port==1) // dummy read to wait for link to come up
           ebfm_cfgrd_wait(1, 1, fnc, PCIE_CAP_PTR + 16, 4, CFG_SCRATCH_SPACE, compl_status);

         // check link speed
         ebfm_cfgrd_wait(bnm, dev, fnc, PCIE_CAP_PTR + 16, 4, CFG_SCRATCH_SPACE, compl_status);
         link_sts  = shmem_read(CFG_SCRATCH_SPACE + 2, 2);
         if (link_sts[3:0] == 4'h1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"       Current Link Speed: 2.5GT/s"}) ;
         else if (link_sts[3:0] == 4'h2)
           dummy = ebfm_display(EBFM_MSG_INFO, {"       Current Link Speed: 5.0GT/s"}) ;
         else
           dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, {"       Current Link Speed is Unsupported"}) ;

         if (link_sts[3:0] != link_cap[3:0]) // link is not at its full speed
	   begin
	      ebfm_cfgwr_imm_wait(RP_PRI_BUS_NUM,RP_PRI_DEV_NUM,fnc,144,2, 32'h0000_0020, compl_status);
              ebfm_cfgrd_wait(bnm, dev, fnc, PCIE_CAP_PTR + 16, 4, CFG_SCRATCH_SPACE, compl_status);

              if (root_port==1) // dummy read to wait for link to come up
		ebfm_cfgrd_wait(1, 1, fnc, PCIE_CAP_PTR + 16, 4, CFG_SCRATCH_SPACE, compl_status);
	      // Make sure the config Rd is not sent before the retraining starts
              ebfm_cfgrd_wait(bnm, dev, fnc, PCIE_CAP_PTR + 16, 4, CFG_SCRATCH_SPACE, compl_status);
              link_sts  = shmem_read(CFG_SCRATCH_SPACE + 2, 2);
              if (link_sts[3:0] == 4'h1)
		dummy = ebfm_display(EBFM_MSG_INFO, {"           New Link Speed: 2.5GT/s"}) ;
              else if (link_sts[3:0] == 4'h2)
		dummy = ebfm_display(EBFM_MSG_INFO, {"           New Link Speed: 5.0GT/s"}) ;
	      else
		dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, {"       New Link Speed is Unsupported"}) ;

	   end

         if (link_sts[3:0] != link_cap[3:0])
           dummy = ebfm_display(EBFM_MSG_INFO, "           Link fails to operate at Maximum Rate") ;




	 dummy = ebfm_display(EBFM_MSG_INFO,"");


      end
   endtask

   task ebfm_display_link_control_reg;
      input root_port;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;
      reg [2:0] compl_status;
      reg [15:0] link_ctrl;
      reg 	 dummy;
      begin
         ebfm_cfgrd_wait(bnm,dev,fnc,PCIE_CAP_PTR+16,4,CFG_SCRATCH_SPACE,compl_status);
	 link_ctrl = shmem_read(CFG_SCRATCH_SPACE,2);
	 if (root_port==1)
           dummy = ebfm_display(EBFM_MSG_INFO,{"  RP PCI Express Link Control Register (", himage4(link_ctrl), "):"} );
	 else
           dummy = ebfm_display(EBFM_MSG_INFO,{"  EP PCI Express Link Control Register (", himage4(link_ctrl), "):"} );

	 if (link_ctrl[6] == 1'b1)
	   begin
              dummy = ebfm_display(EBFM_MSG_INFO,"      Common Clock Config: System Reference Clock Used") ;
	   end
	 else
	   begin
              dummy = ebfm_display(EBFM_MSG_INFO,"      Common Clock Config: Local Clock Used") ;
	   end
	 dummy = ebfm_display(EBFM_MSG_INFO,"");
      end
   endtask

   task ebfm_display_dev_control_status_reg;
      input root_port;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;

      reg [2:0] compl_status;
      reg [31:0] dev_cs;

      reg 	 dummy ;

      begin
         ebfm_cfgrd_wait(bnm, dev, fnc, PCIE_CAP_PTR + 8, 4,
			 CFG_SCRATCH_SPACE, compl_status);
         dev_cs = shmem_read(CFG_SCRATCH_SPACE, 4);
         dummy = ebfm_display(EBFM_MSG_INFO, "");
         if (root_port==1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"  RP PCI Express Device Control Register (",
                                                himage4(dev_cs[15:0]), "):"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"  EP PCI Express Device Control Register (",
                                                himage4(dev_cs[15:0]), "):"});

         dummy = ebfm_display(EBFM_MSG_INFO, {"  Error Reporting Enables: ",
                                              himage1(dev_cs[3:0])});
         if ((dev_cs[4]) == 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "         Relaxed Ordering: Enabled");
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "         Relaxed Ordering: Disabled");
           end
         case (dev_cs[7:5])
           3'b000 : dummy = ebfm_display(EBFM_MSG_INFO, "              Max Payload: 128 Bytes");
           3'b001 : dummy = ebfm_display(EBFM_MSG_INFO, "              Max Payload: 256 Bytes");
           3'b010 : dummy = ebfm_display(EBFM_MSG_INFO, "              Max Payload: 512 Bytes");
           3'b011 : dummy = ebfm_display(EBFM_MSG_INFO, "              Max Payload: 1KBytes");
           3'b100 : dummy = ebfm_display(EBFM_MSG_INFO, "              Max Payload: 2KBytes");
           3'b101 : dummy = ebfm_display(EBFM_MSG_INFO, "              Max Payload: 4KBytes");
           default :
             begin
                dummy = ebfm_display(EBFM_MSG_INFO,
                                     {"              Max Payload: Unknown",
                                      himage1(dev_cs[2:0])});
             end
         endcase
         if ((dev_cs[8]) == 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "             Extended Tag: Enabled");
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "             Extended Tag: Disabled");
           end
         case (dev_cs[14:12])
           3'b000 : dummy = ebfm_display(EBFM_MSG_INFO, "         Max Read Request: 128 Bytes");
           3'b001 : dummy = ebfm_display(EBFM_MSG_INFO, "         Max Read Request: 256 Bytes");
           3'b010 : dummy = ebfm_display(EBFM_MSG_INFO, "         Max Read Request: 512 Bytes");
           3'b011 : dummy = ebfm_display(EBFM_MSG_INFO, "         Max Read Request: 1KBytes");
           3'b100 : dummy = ebfm_display(EBFM_MSG_INFO, "         Max Read Request: 2KBytes");
           3'b101 : dummy = ebfm_display(EBFM_MSG_INFO, "         Max Read Request: 4KBytes");
           default :
             begin
                dummy = ebfm_display(EBFM_MSG_INFO, {"         Max Read Request: Unknown",
                                                     himage1(dev_cs[2:0])});
             end
         endcase
         dummy = ebfm_display(EBFM_MSG_INFO, "");
         if (root_port==1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"  RP PCI Express Device Status Register (",
                                                himage4(dev_cs[31:16]), "):"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"  EP PCI Express Device Status Register (",
                                                himage4(dev_cs[31:16]), "):"});
         dummy = ebfm_display(EBFM_MSG_INFO, "");
      end
   endtask

   // purpose: display PCI Express Capability Info
   task display_pcie_cap;
      input       root_port;
      input [31:0] pcie_cap;
      input [31:0] dev_cap;
      input [31:0] link_cap;
      input [31:0] dev_cap2;

      integer 	   pwr_limit;
      reg 	   l;

      reg 	   dummy ;




      begin
         // display_pcie_cap
         dummy = ebfm_display(EBFM_MSG_INFO, "");
         if (root_port==1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"  RP PCI Express Capabilities Register (",
                                                himage4(pcie_cap[31:16]), "):"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"  EP PCI Express Capabilities Register (",
                                                himage4(pcie_cap[31:16]), "):"});

         dummy = ebfm_display(EBFM_MSG_INFO, {"       Capability Version: ",
                                              himage1(pcie_cap[19:16])});
         case (pcie_cap[23:20])
           4'b0000 : dummy = ebfm_display(EBFM_MSG_INFO, "                Port Type: Native Endpoint");
           4'b0001 : dummy = ebfm_display(EBFM_MSG_INFO, "                Port Type: Legacy Endpoint");
           4'b0100 : dummy = ebfm_display(EBFM_MSG_INFO, "                Port Type: Root Port");
           4'b0101 : dummy = ebfm_display(EBFM_MSG_INFO, "                Port Type: Switch Upstream port");
           4'b0110 : dummy = ebfm_display(EBFM_MSG_INFO, "                Port Type: Switch Downstream port");
           4'b0111 : dummy = ebfm_display(EBFM_MSG_INFO, "                Port Type: Express-to-PCI bridge");
           4'b1000 : dummy = ebfm_display(EBFM_MSG_INFO, "                Port Type: PCI-to-Express bridge");
           default : dummy = ebfm_display(EBFM_MSG_INFO, {"                Port Type: UNKNOWN", himage1(pcie_cap[23:20])});
         endcase
         dummy = ebfm_display(EBFM_MSG_INFO, "");
         if (root_port==1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"  RP PCI Express Device Capabilities Register (",
                                                himage8(dev_cap), "):"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"  EP PCI Express Device Capabilities Register (",
                                                himage8(dev_cap), "):"});

         case (dev_cap[2:0])
           3'b000 : dummy = ebfm_display(EBFM_MSG_INFO, "    Max Payload Supported: 128 Bytes");
           3'b001 : dummy = ebfm_display(EBFM_MSG_INFO, "    Max Payload Supported: 256 Bytes");
           3'b010 : dummy = ebfm_display(EBFM_MSG_INFO, "    Max Payload Supported: 512 Bytes");
           3'b011 : dummy = ebfm_display(EBFM_MSG_INFO, "    Max Payload Supported: 1KBytes");
           3'b100 : dummy = ebfm_display(EBFM_MSG_INFO, "    Max Payload Supported: 2KBytes");
           3'b101 : dummy = ebfm_display(EBFM_MSG_INFO, "    Max Payload Supported: 4KBytes");
           default : dummy = ebfm_display(EBFM_MSG_INFO, {"    Max Payload Supported: Unknown", himage1(dev_cap[2:0])});
         endcase
         if ((dev_cap[5]) == 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "             Extended Tag: Supported");
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "             Extended Tag: Not Supported");
           end
         case (dev_cap[8:6])
           3'b000 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L0s Latency: Less Than 64 ns");
           3'b001 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L0s Latency: 64 ns to 128 ns");
           3'b010 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L0s Latency: 128 ns to 256 ns");
           3'b011 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L0s Latency: 256 ns to 512 ns");
           3'b100 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L0s Latency: 512 ns to 1 us");
           3'b101 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L0s Latency: 1 us to 2 us");
           3'b110 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L0s Latency: 2 us to 4 us");
           3'b111 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L0s Latency: More than 4 us");
           default :
             begin
             end
         endcase
         case (dev_cap[11:9])
           3'b000 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L1  Latency: Less Than 1 us");
           3'b001 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L1  Latency: 1 us to 2 us");
           3'b010 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L1  Latency: 2 us to 4 us");
           3'b011 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L1  Latency: 4 us to 8 us");
           3'b100 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L1  Latency: 8 us to 16 us");
           3'b101 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L1  Latency: 16 us to 32 us");
           3'b110 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L1  Latency: 32 us to 64 us");
           3'b111 : dummy = ebfm_display(EBFM_MSG_INFO, "   Acceptable L1  Latency: More than 64 us");
           default :
             begin
             end
         endcase
         if ((dev_cap[12]) == 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "         Attention Button: Present");
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "         Attention Button: Not Present");
           end
         if ((dev_cap[13]) == 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "      Attention Indicator: Present");
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "      Attention Indicator: Not Present");
           end
         if ((dev_cap[14]) == 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "          Power Indicator: Present");
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "          Power Indicator: Not Present");
           end
         dummy = ebfm_display(EBFM_MSG_INFO, "");

         if (root_port==1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"  RP PCI Express Link Capabilities Register (",
                                                himage8(link_cap), "):"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"  EP PCI Express Link Capabilities Register (",
                                                himage8(link_cap), "):"});

         dummy = ebfm_display(EBFM_MSG_INFO, {"       Maximum Link Width: x",
                                              dimage1(link_cap[9:4])}) ;

         if (link_cap[3:0] == 4'h1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"     Supported Link Speed: 2.5GT/s"}) ;
         else if (link_cap[3:0] == 4'h2)
           dummy = ebfm_display(EBFM_MSG_INFO, {"     Supported Link Speed: 5.0GT/s or 2.5GT/s"}) ;
         else
           dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, {"     Supported Link Speed: Undefined"}) ;

         if ((link_cap[10]) == 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "                L0s Entry: Supported");
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "                L0s Entry: Not Supported");
           end
         if ((link_cap[11]) == 1'b1)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "                L1  Entry: Supported");
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, "                L1  Entry: Not Supported");
           end
         case (link_cap[14:12])
           3'b000 : dummy = ebfm_display(EBFM_MSG_INFO, "         L0s Exit Latency: Less Than 64 ns");
           3'b001 : dummy = ebfm_display(EBFM_MSG_INFO, "         L0s Exit Latency: 64 ns to 128 ns");
           3'b010 : dummy = ebfm_display(EBFM_MSG_INFO, "         L0s Exit Latency: 128 ns to 256 ns");
           3'b011 : dummy = ebfm_display(EBFM_MSG_INFO, "         L0s Exit Latency: 256 ns to 512 ns");
           3'b100 : dummy = ebfm_display(EBFM_MSG_INFO, "         L0s Exit Latency: 512 ns to 1 us");
           3'b101 : dummy = ebfm_display(EBFM_MSG_INFO, "         L0s Exit Latency: 1 us to 2 us");
           3'b110 : dummy = ebfm_display(EBFM_MSG_INFO, "         L0s Exit Latency: 2 us to 4 us");
           3'b111 : dummy = ebfm_display(EBFM_MSG_INFO, "         L0s Exit Latency: More than 4 us");
           default :
             begin
             end
         endcase
         case (link_cap[17:15])
           3'b000 : dummy = ebfm_display(EBFM_MSG_INFO, "         L1  Exit Latency: Less Than 1 us");
           3'b001 : dummy = ebfm_display(EBFM_MSG_INFO, "         L1  Exit Latency: 1 us to 2 us");
           3'b010 : dummy = ebfm_display(EBFM_MSG_INFO, "         L1  Exit Latency: 2 us to 4 us");
           3'b011 : dummy = ebfm_display(EBFM_MSG_INFO, "         L1  Exit Latency: 4 us to 8 us");
           3'b100 : dummy = ebfm_display(EBFM_MSG_INFO, "         L1  Exit Latency: 8 us to 16 us");
           3'b101 : dummy = ebfm_display(EBFM_MSG_INFO, "         L1  Exit Latency: 16 us to 32 us");
           3'b110 : dummy = ebfm_display(EBFM_MSG_INFO, "         L1  Exit Latency: 32 us to 64 us");
           3'b111 : dummy = ebfm_display(EBFM_MSG_INFO, "         L1  Exit Latency: More than 64 us");
           default :
             begin
             end
         endcase
         dummy = ebfm_display(EBFM_MSG_INFO, {"              Port Number: ", himage2(link_cap[31:24])});


	 if (link_cap[19] == 1'b1)
           dummy = ebfm_display(EBFM_MSG_INFO, "  Surprise Dwn Err Report: Supported");
	 else
           dummy = ebfm_display(EBFM_MSG_INFO, "  Surprise Dwn Err Report: Not Supported");

	 if (link_cap[20] == 1'b1)
           dummy = ebfm_display(EBFM_MSG_INFO, "   DLL Link Active Report: Supported");
	 else
           dummy = ebfm_display(EBFM_MSG_INFO, "   DLL Link Active Report: Not Supported");


         dummy = ebfm_display(EBFM_MSG_INFO, "");


         // Spec 2.0 Caps
         if (pcie_cap[19:16] == 4'h2)
	   begin

	      if (root_port==1)
		dummy = ebfm_display(EBFM_MSG_INFO, {"  RP PCI Express Device Capabilities 2 Register (",
						     himage8(dev_cap2), "):"});
	      else
		dummy = ebfm_display(EBFM_MSG_INFO, {"  EP PCI Express Device Capabilities 2 Register (",
						     himage8(dev_cap2), "):"});

	      if (dev_cap2[4] == 1'b1)
		case (dev_cap2[3:0])
		  4'h0: dummy = ebfm_display(EBFM_MSG_INFO, "  Completion Timeout Rnge: Not Supported");
		  4'h1: dummy = ebfm_display(EBFM_MSG_INFO, "  Completion Timeout Rnge: A (50us to 10ms)");
		  4'h2: dummy = ebfm_display(EBFM_MSG_INFO, "  Completion Timeout Rnge: B (10ms to 250ms)");
		  4'h3: dummy = ebfm_display(EBFM_MSG_INFO, "  Completion Timeout Rnge: AB (50us to 250ms)");
		  4'h6: dummy = ebfm_display(EBFM_MSG_INFO, "  Completion Timeout Rnge: BC (10ms to 4s)");
		  4'h7: dummy = ebfm_display(EBFM_MSG_INFO, "  Completion Timeout Rnge: ABC (50us to 4s)");
		  4'hE: dummy = ebfm_display(EBFM_MSG_INFO, "  Completion Timeout Rnge: BCD (10ms to 64s)");
		  4'hF: dummy = ebfm_display(EBFM_MSG_INFO, "  Completion Timeout Rnge: ABCD (50us to 64s)");
		  default: dummy = ebfm_display(EBFM_MSG_INFO, "  Completion Timeout Rnge: Reserved");
		endcase
	      else
		dummy = ebfm_display(EBFM_MSG_INFO, "  Completion Timeout Rnge: Not Supported");

	   end






      end
   endtask



   // purpose: configure the PCI Express Capabilities
   task ebfm_cfg_pcie_cap;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;
      input   rp_max_rd_req_size;
      integer rp_max_rd_req_size;
      input   display;
      integer display;
      input   display_rp_config;
      integer display_rp_config;


      reg [2:0] compl_status;
      integer 	EP_PCIE_CAP ;
      integer 	EP_DEV_CAP ;
      integer 	EP_DEV_CAP2 ;
      integer 	EP_DEV_CTRL2 ;
      integer 	EP_LINK_CTRL2 ;
      integer 	EP_LINK_CAP ;
      integer 	RP_PCIE_CAP ;
      integer 	RP_DEV_CAP ;
      integer 	RP_DEV_CS;
      integer 	RP_LINK_CTRL;
      integer 	RP_DEV_CAP2;
      integer 	RP_LINK_CAP;
      reg [31:0] ep_pcie_cap_r;
      reg [31:0] rp_pcie_cap_r;
      reg [31:0] ep_dev_cap_r;
      reg [31:0] rp_dev_cap_r;
      reg [15:0] ep_dev_control;
      reg [15:0] rp_dev_control;
      reg [15:0] rp_dev_cs;
      integer 	 max_size;

      reg 	 dummy ;

      begin // ebfm_cfg_pcie_cap
         ep_dev_control = {16{1'b0}} ;
         rp_dev_control = {16{1'b0}} ;
         EP_PCIE_CAP = CFG_SCRATCH_SPACE + 0;
         EP_DEV_CAP  = CFG_SCRATCH_SPACE + 4;
         EP_LINK_CAP = CFG_SCRATCH_SPACE + 8;
         RP_PCIE_CAP = CFG_SCRATCH_SPACE + 16;
         RP_DEV_CAP  = CFG_SCRATCH_SPACE + 20;
         EP_DEV_CAP2  = CFG_SCRATCH_SPACE + 24;
         RP_DEV_CS   = CFG_SCRATCH_SPACE + 36;
         RP_LINK_CTRL = CFG_SCRATCH_SPACE + 40;
         RP_DEV_CAP2  = CFG_SCRATCH_SPACE + 44;
         RP_LINK_CAP  = CFG_SCRATCH_SPACE + 48;
         // Read the EP PCI Express Capabilities (at a known address in the MegaCore
         // function)
         if (display == 1)
           begin
              ebfm_display_link_status_reg(0, bnm,dev,fnc,CFG_SCRATCH_SPACE+32);
              ebfm_display_link_control_reg(0, bnm,dev,fnc,CFG_SCRATCH_SPACE+32);
           end
         if (display_rp_config==1) begin
            ebfm_display_link_status_reg(1, RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, RP_LINK_CTRL);
            ebfm_display_link_control_reg(1, RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, RP_LINK_CTRL);
         end



         ebfm_cfgrd_nowt(bnm, dev, fnc, PCIE_CAP_PTR, 4, EP_PCIE_CAP);
         ebfm_cfgrd_nowt(bnm, dev, fnc, PCIE_CAP_PTR + 4, 4, EP_DEV_CAP);
         ebfm_cfgrd_nowt(bnm, dev, fnc, PCIE_CAP_PTR + 36, 4, EP_DEV_CAP2);
         ebfm_cfgrd_wait(bnm, dev, fnc, PCIE_CAP_PTR + 12, 4, EP_LINK_CAP, compl_status);
         ebfm_cfgrd_nowt(RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, 128, 4, RP_PCIE_CAP);
	 //  ebfm_cfgrd_nowt(RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, 128, 4, RP_DEV_CS);
         ebfm_cfgrd_nowt(RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, 128 + 36, 4, RP_DEV_CAP2);
         ebfm_cfgrd_nowt(RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, 128 + 12, 4, RP_LINK_CAP);
         ebfm_cfgrd_wait(RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, 132 , 4, RP_DEV_CAP, compl_status);
         ep_pcie_cap_r = shmem_read(EP_PCIE_CAP, 4);
         rp_pcie_cap_r = shmem_read(RP_PCIE_CAP, 4);
         ep_dev_cap_r = shmem_read(EP_DEV_CAP, 4);
         rp_dev_cap_r = shmem_read(RP_DEV_CAP, 4);
         if (ep_pcie_cap_r[7:0] != 8'h10)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, "PCI Express Capabilities not at expected Endpoint config address");
           end
         if (rp_pcie_cap_r[7:0] != 8'h10)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL_TB_ERR, "PCI Express Capabilities not at expected Root Port config address");
           end
         if (display == 1)
           begin
              display_pcie_cap(
			       0,
			       ep_pcie_cap_r,
			       ep_dev_cap_r,
			       shmem_read(EP_LINK_CAP, 4),
			       shmem_read(EP_DEV_CAP2, 4)
			       );
           end
         if (display_rp_config==1) begin
            display_pcie_cap(
			     1,
			     rp_pcie_cap_r,
			     rp_dev_cap_r,
			     shmem_read(RP_LINK_CAP, 4),
			     shmem_read(RP_DEV_CAP2, 4)
			     );
         end


         // Error Reporting Enables (RP BFM does not handle for now)
         ep_dev_control[3:0] = {4{1'b0}};
         rp_dev_control[3:0] = {4{1'b0}};
         // Enable Relaxed Ordering
         ep_dev_control[4] = 1'b1;
         rp_dev_control[4] = 1'b1;
         // Enable Extended Tag if requested for EP
         ep_dev_control[8] = ep_dev_cap_r[5];
         if (EBFM_NUM_TAG > 32)
           begin
              rp_dev_control[8] = 1'b1;
           end
         else
           begin
              rp_dev_control[8] = 1'b0;
           end
         // Disable Phantom Functions
         ep_dev_control[9] = 1'b0;
         rp_dev_control[9] = 1'b0;
         // Disable Aux Power PM Enable
         ep_dev_control[10] = 1'b0;
         rp_dev_control[10] = 1'b0;
         // Disable No Snoop
         ep_dev_control[11] = 1'b0;
         rp_dev_control[11] = 1'b0;
         if (ep_dev_cap_r[2:0] < rp_dev_cap_r[2:0])
           begin
              // Max Payload Size
              ep_dev_control[7:5] = ep_dev_cap_r[2:0];
              rp_dev_control[7:5] = ep_dev_cap_r[2:0];
              // Max Read Request Size
              // Note the reference design can break up the read requests into smaller
              // completion packets, so we can go for the full 4096 bytes. But the
              // root port BFM can't create multiple completions, so tell the endpoint
              // to be restricted to the max payload size
              ep_dev_control[14:12] = ep_dev_cap_r[2:0];
              rp_dev_control[14:12] = 3'b101;
           end
         else
           begin
              // Max Payload Size
              ep_dev_control[7:5] = rp_dev_cap_r[2:0];
              rp_dev_control[7:5] = rp_dev_cap_r[2:0];
              // Max Read Request Size
              // Note the reference design can break up the read requests into smaller
              // completion packets, so we can go for the full 4096 bytes. But the
              // root port BFM can't create multiple completions, so tell the endpoint
              // to be restricted to the max payload size
              ep_dev_control[14:12] = rp_dev_cap_r[2:0];
              rp_dev_control[14:12] = 3'b101;
           end
         case (ep_dev_control[7:5])
           3'b000 : max_size = 128;
           3'b001 : max_size = 256;
           3'b010 : max_size = 512;
           3'b011 : max_size = 1024;
           3'b100 : max_size = 2048;
           3'b101 : max_size = 4096;
           default : max_size = 128;
         endcase
         // Tell the BFM what the limits are...
         req_intf_set_max_payload(max_size, max_size, rp_max_rd_req_size);
         ebfm_cfgwr_imm_nowt(bnm, dev, fnc, PCIE_CAP_PTR + 8, 4, {16'h0000, ep_dev_control});
         ebfm_cfgwr_imm_nowt(RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, PCIE_CAP_PTR + 8, 4, {16'h0000, rp_dev_control});

         if (display == 1)
           begin
              ebfm_display_dev_control_status_reg(0, bnm, dev, fnc, CFG_SCRATCH_SPACE + 32);
              ebfm_display_vc(0, bnm,dev,fnc,CFG_SCRATCH_SPACE + 32) ;
           end
         if (display_rp_config==1) begin
            ebfm_display_dev_control_status_reg(1, RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, RP_LINK_CTRL);
            ebfm_display_vc(1, RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, RP_LINK_CTRL) ;
         end

      end
   endtask

   // purpose: Display the "critical" BARs
   task ebfm_display_read_only;
      input root_port;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;

      reg [2:0] compl_status;

      reg 	dummy ;

      begin



         // ebfm_display_read_only
         ebfm_cfgrd_nowt(bnm, dev, fnc, 0, 4, CFG_SCRATCH_SPACE);
         ebfm_cfgrd_nowt(bnm, dev, fnc, 8, 4, CFG_SCRATCH_SPACE + 8);
         ebfm_cfgrd_nowt(bnm, dev, fnc, 44, 4, CFG_SCRATCH_SPACE + 4);
         ebfm_cfgrd_nowt(bnm, dev, fnc, 60, 4, CFG_SCRATCH_SPACE + 16);
         ebfm_cfgrd_wait(bnm, dev, fnc, 12, 4, CFG_SCRATCH_SPACE + 12, compl_status);
         dummy = ebfm_display(EBFM_MSG_INFO, "");
         dummy = ebfm_display(EBFM_MSG_INFO, {"Configuring Bus ", dimage3(bnm),
                                              ", Device ", dimage3(dev),
                                              ", Function ", dimage2(fnc)});

         if (root_port==1)
           dummy = ebfm_display(EBFM_MSG_INFO, "  RP Read Only Configuration Registers:");
         else
           dummy = ebfm_display(EBFM_MSG_INFO, "  EP Read Only Configuration Registers:");

         dummy = ebfm_display(EBFM_MSG_INFO, {"                Vendor ID: ",
					      himage4(shmem_read(CFG_SCRATCH_SPACE, 2))});
         dummy = ebfm_display(EBFM_MSG_INFO, {"                Device ID: ",
					      himage4(shmem_read(CFG_SCRATCH_SPACE + 2, 2))});
         dummy = ebfm_display(EBFM_MSG_INFO, {"              Revision ID: ",
					      himage2(shmem_read(CFG_SCRATCH_SPACE + 8, 1))});
         dummy = ebfm_display(EBFM_MSG_INFO, {"               Class Code: ",
                                              himage2(shmem_read(CFG_SCRATCH_SPACE + 11, 1)),
                                              himage4(shmem_read(CFG_SCRATCH_SPACE + 9, 2))});
         if (shmem_read(CFG_SCRATCH_SPACE + 14, 1) == 8'h00)
           begin
              dummy = ebfm_display(EBFM_MSG_INFO, {"      Subsystem Vendor ID: ",
                                                   himage4(shmem_read(CFG_SCRATCH_SPACE + 4, 2))});
              dummy = ebfm_display(EBFM_MSG_INFO, {"             Subsystem ID: ",
                                                   himage4(shmem_read(CFG_SCRATCH_SPACE + 6, 2))});
           end
         case (shmem_read(CFG_SCRATCH_SPACE + 17,1))
           8'h00 : dummy = ebfm_display(EBFM_MSG_INFO,"            Interrupt Pin: No INTx# pin used");
           8'h01 : dummy = ebfm_display(EBFM_MSG_INFO,"            Interrupt Pin: INTA# used");
           8'h02 : dummy = ebfm_display(EBFM_MSG_INFO,"            Interrupt Pin: INTB# used");
           8'h03 : dummy = ebfm_display(EBFM_MSG_INFO,"            Interrupt Pin: INTC# used");
           8'h04 : dummy = ebfm_display(EBFM_MSG_INFO,"            Interrupt Pin: INTD# used");
           default: dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,"            Interrupt Pin: Interrupt Pin Register has Illegal Value.");
         endcase
         dummy = ebfm_display(EBFM_MSG_INFO, "");
      end
   endtask

   // purpose: Display the root port BARs
   task ebfm_display_rp_bar;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;

      reg [2:0] compl_status;

      reg 	dummy ;
      reg [63:0] bar;
      integer 	 i,j,k,bar_lsb;

      begin

         // find bar size
         ebfm_cfgwr_imm_wait(bnm,dev,fnc,16,4, 32'hFFFF_FFFF, compl_status);
         ebfm_cfgwr_imm_wait(bnm,dev,fnc,20,4, 32'hFFFF_FFFF, compl_status);
         // don't enable expansion ROM BAR
         ebfm_cfgwr_imm_wait(bnm,dev,fnc,56,4, 32'hFFFF_FFFE, compl_status);
         // I/O base and limit
         ebfm_cfgwr_imm_wait(bnm,dev,fnc,28,2, 16'hFFFF, compl_status);
         // Prefet base and limit
         ebfm_cfgwr_imm_wait(bnm,dev,fnc,36,4, 32'hFFFF_FFFF, compl_status);

         ebfm_cfgrd_wait(bnm, dev, fnc, 16, 4, CFG_SCRATCH_SPACE, compl_status);
         ebfm_cfgrd_wait(bnm, dev, fnc, 20, 4, CFG_SCRATCH_SPACE + 4, compl_status);
         ebfm_cfgrd_wait(bnm, dev, fnc, 56, 4, CFG_SCRATCH_SPACE + 8, compl_status);
         ebfm_cfgrd_wait(bnm, dev, fnc, 28, 4, CFG_SCRATCH_SPACE + 12, compl_status);
         ebfm_cfgrd_wait(bnm, dev, fnc, 36, 4, CFG_SCRATCH_SPACE + 16, compl_status);

         dummy = ebfm_display(EBFM_MSG_INFO, "  RP Base Address Registers:");

         dummy = ebfm_display(EBFM_MSG_INFO, "");
         dummy = ebfm_display(EBFM_MSG_INFO, "BAR Address Assignments:");
         dummy = ebfm_display(EBFM_MSG_INFO, {"BAR   ", " ", "Size      ", " ", "Assigned Address ", " ", "Type"});
         dummy = ebfm_display(EBFM_MSG_INFO, {"---   ", " ", "----      ", " ", "---------------- ", " "});
         bar = shmem_read(CFG_SCRATCH_SPACE, 8);

         for (i = 0; i < 2; i = i + 1)
           begin
              bar_lsb = 64;

              if (bar[2] == 1'b1) // extend the end limit for 64 bit BAR
                k = 1;
              else
                k = 0;

              // find first one
              begin : find_first
                 for(j = 4; j <= k*32 + 31; j = j + 1)
                   begin : lsb_loop
                      if ((bar[j]) == 1'b1)
                        begin
                           bar_lsb = j ;
                           disable find_first ;
                        end
                   end
              end

              describe_bar(i,bar_lsb,bar,1'b1);
              if (bar[2] == 1'b1)  // Found 64 bit BAR
                i = i + 1;
              else
                // Move the second BAR to first position for second time around
                bar[31:0] = bar[63:32] ;

           end // for (i = 0; i < 2; i = i + 1)

         // expansion rom
         bar = 0;
         bar = shmem_read(CFG_SCRATCH_SPACE + 8, 4);
         bar_lsb = 64;

         begin : ff_eeprom
            for(j = 4 ; j <= 31; j = j + 1)
              begin : loop_eeprom
                 if ((bar[j]) == 1'b1)
                   begin
                      bar_lsb = j;
                      disable ff_eeprom ;
                   end
              end
         end
         describe_bar(6,bar_lsb,bar,1'b1);
         dummy = ebfm_display(EBFM_MSG_INFO, "");

         // check IO base/limit
         bar = 0;
         bar = shmem_read(CFG_SCRATCH_SPACE +12, 2);
         if (bar[31:0] == 0)
           dummy = ebfm_display(EBFM_MSG_INFO,"   I/O Base and Limit Register: Disable ");
         else if (bar[0] == 0)
           dummy = ebfm_display(EBFM_MSG_INFO,"   I/O Base and Limit Register: 16Bit ");
         else if (bar[0] == 1)
           dummy = ebfm_display(EBFM_MSG_INFO,"   I/O Base and Limit Register: 32Bit ");
         else
           dummy = ebfm_display(EBFM_MSG_INFO,"   I/O Base and Limit Register: Reserved ");

         // check Prefetchable Memory base/limit
         bar = 0;
         bar = shmem_read(CFG_SCRATCH_SPACE + 16, 4);
         if (bar[31:0] == 0)
           dummy = ebfm_display(EBFM_MSG_INFO,"   Prefetchable Base and Limit Register: Disable ");
         else if (bar[3:0] == 0) //
           dummy = ebfm_display(EBFM_MSG_INFO,"   Prefetchable Base and Limit Register: 32Bit ");
         else if (bar[3:0] == 1)
           dummy = ebfm_display(EBFM_MSG_INFO,"   Prefetchable Base and Limit Register: 64Bit ");
         else
           dummy = ebfm_display(EBFM_MSG_INFO,"   Prefetchable Base and Limit Register: Reserved ");

         dummy = ebfm_display(EBFM_MSG_INFO, "");


      end
   endtask


   // purpose: Display the MSI Information
   task ebfm_display_msi;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;

      reg [2:0] compl_status;
      reg [15:0] message_control_r;

      reg 	 dummy ;

      begin
         ebfm_cfgrd_wait(bnm, dev, fnc, 80, 4, CFG_SCRATCH_SPACE, compl_status);
         dummy = ebfm_display(EBFM_MSG_INFO,"  PCI MSI Capability Register:") ;
         message_control_r = shmem_read(CFG_SCRATCH_SPACE+2,2) ;
         if (message_control_r[7] == 1'b1)
           dummy = ebfm_display(EBFM_MSG_INFO,"   64-Bit Address Capable: Supported");
         else
           dummy = ebfm_display(EBFM_MSG_INFO,"   64-Bit Address Capable: Not Supported");
         case (message_control_r[3:1])
           3'b000 : dummy = ebfm_display(EBFM_MSG_INFO,"       Messages Requested:  1") ;
           3'b001 : dummy = ebfm_display(EBFM_MSG_INFO,"       Messages Requested:  2") ;
           3'b010 : dummy = ebfm_display(EBFM_MSG_INFO,"       Messages Requested:  4") ;
           3'b011 : dummy = ebfm_display(EBFM_MSG_INFO,"       Messages Requested:  8") ;
           3'b100 : dummy = ebfm_display(EBFM_MSG_INFO,"       Messages Requested: 16") ;
           3'b101 : dummy = ebfm_display(EBFM_MSG_INFO,"       Messages Requested: 32") ;
           default: dummy = ebfm_display(EBFM_MSG_INFO,"       Messages Requested: Reserved") ;
         endcase
	 dummy = ebfm_display(EBFM_MSG_INFO,"") ;
      end
   endtask

   // purpose: Display the MSI-X Information
   task ebfm_display_msix;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;

      reg [2:0] compl_status;
      reg [31:0] dword;

      reg 	 dummy ;

      begin
         ebfm_cfgwr_imm_wait(bnm,dev,fnc,104,4, 32'h8000_0000, compl_status);
         ebfm_cfgrd_wait(bnm, dev, fnc, 104, 4, CFG_SCRATCH_SPACE, compl_status);
         dword = shmem_read(CFG_SCRATCH_SPACE,4) ;
         if (dword[31] == 1'b1) // check for implementation
           begin
              dummy = ebfm_display(EBFM_MSG_INFO,"  PCI MSI-X Capability Register:") ;
              dummy = ebfm_display(EBFM_MSG_INFO, {"               Table Size: ", himage4(dword[26:16])});

              ebfm_cfgrd_wait(bnm, dev, fnc, 108, 4, CFG_SCRATCH_SPACE, compl_status);
              dword = shmem_read(CFG_SCRATCH_SPACE,4) ;
              dummy = ebfm_display(EBFM_MSG_INFO, {"                Table BIR: ", himage1(dword[2:0])});
              dummy = ebfm_display(EBFM_MSG_INFO, {"             Table Offset: ", himage8(dword[31:3])});

              ebfm_cfgrd_wait(bnm, dev, fnc, 112, 4, CFG_SCRATCH_SPACE, compl_status);
              dword = shmem_read(CFG_SCRATCH_SPACE,4) ;
              dummy = ebfm_display(EBFM_MSG_INFO, {"                  PBA BIR: ", himage1(dword[2:0])});
              dummy = ebfm_display(EBFM_MSG_INFO, {"               PBA Offset: ", himage8(dword[31:3])});

              dummy = ebfm_display(EBFM_MSG_INFO,"") ;

              // Disable MSIX
              ebfm_cfgwr_imm_wait(bnm,dev,fnc,104,4, 32'h0000_0000, compl_status);
           end
      end
   endtask

   // purpose: Display the Advance Error Reporting Information
   task ebfm_display_aer;
      input root_port;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;

      reg [2:0] compl_status;
      reg [31:0] dword;

      reg 	 dummy ;

      begin
         ebfm_cfgrd_wait(bnm, dev, fnc, 2048, 4, CFG_SCRATCH_SPACE, compl_status);
         dword = shmem_read(CFG_SCRATCH_SPACE,4) ;
         if (dword[15:0] == 16'h0001) // check for implementation
           begin
              if (root_port==1)
                dummy = ebfm_display(EBFM_MSG_INFO,"  RP PCI Express AER Capability Register:") ;
              else
                dummy = ebfm_display(EBFM_MSG_INFO,"  EP PCI Express AER Capability Register:") ;

              // turn on check and gen on root port
              ebfm_cfgwr_imm_wait(RP_PRI_BUS_NUM,RP_PRI_DEV_NUM,fnc,2072,2, 16'h0140, compl_status);

              ebfm_cfgrd_wait(bnm, dev, fnc, 2072, 4, CFG_SCRATCH_SPACE, compl_status);
              dword = shmem_read(CFG_SCRATCH_SPACE,4) ;

              ebfm_cfgwr_imm_wait(bnm,dev,fnc,2072,2, {dword[14:0],1'b0}, compl_status);
              if (dword[7] == 1'b1)
		dummy = ebfm_display(EBFM_MSG_INFO, {"       ECRC Check Capable: Supported"});
              else
		dummy = ebfm_display(EBFM_MSG_INFO, {"       ECRC Check Capable: Not Supported"});

              if (dword[5] == 1'b1)
		dummy = ebfm_display(EBFM_MSG_INFO, {"  ECRC Generation Capable: Supported"});
              else
		dummy = ebfm_display(EBFM_MSG_INFO, {"  ECRC Generation Capable: Not Supported"});

              dummy = ebfm_display(EBFM_MSG_INFO,"") ;
           end

      end
   endtask


   // purpose: Display the Advance Error Reporting Information
   task ebfm_display_slot_cap;
      input root_port;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;

      reg [2:0] compl_status;
      reg [31:0] dword;

      reg 	 dummy ;

      begin
         // read the Slot Capability Register
         ebfm_cfgrd_wait(bnm, dev, fnc, PCIE_CAP_PTR + 20, 4, CFG_SCRATCH_SPACE, compl_status);
         dword = shmem_read(CFG_SCRATCH_SPACE,4) ;


         if (root_port==1)
           dummy = ebfm_display(EBFM_MSG_INFO,{"   RP PCI Express Slot Capability Register (", himage8(dword), "):"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO,{"   EP PCI Express Slot Capability Register (", himage8(dword), "):"});


         if (dword[0] == 1'b1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"       Attention Button: Present"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"       Attention Button: Not Present"});


         if (dword[1] == 1'b1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"       Power Controller: Present"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"       Power Controller: Not Present"});


         if (dword[2] == 1'b1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"             MRL Sensor: Present"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"             MRL Sensor: Not Present"});


         if (dword[3] == 1'b1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"    Attention Indicator: Present"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"    Attention Indicator: Not Present"});

         if (dword[4] == 1'b1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"        Power Indicator: Present"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"        Power Indicator: Not Present"});

         if (dword[5] == 1'b1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"      Hot-Plug Surprise: Supported"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"      Hot-Plug Surprise: Not Supported"});

         if (dword[6] == 1'b1)
           dummy = ebfm_display(EBFM_MSG_INFO, {"       Hot-Plug Capable: Supported"});
         else
           dummy = ebfm_display(EBFM_MSG_INFO, {"       Hot-Plug Capable: Not Supported"});


         dummy = ebfm_display(EBFM_MSG_INFO,{"        Slot Power Limit Value: ", himage1(dword[14:7])}) ;

         dummy = ebfm_display(EBFM_MSG_INFO,{"        Slot Power Limit Scale: ", himage1(dword[16:15])}) ;

         dummy = ebfm_display(EBFM_MSG_INFO,{"          Physical Slot Number: ", himage1(dword[31:19])}) ;

         dummy = ebfm_display(EBFM_MSG_INFO,"") ;


      end
   endtask

   task ebfm_display_vc_regs;
      input root_port;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;

      reg [2:0] compl_status;
      reg [15:0] reg_word;
      reg [32:0] reg_dword;
      reg [2:0]  low_vc;

      reg 	 dummy ;

      begin  // ebfm_display_all_vc_regs

	 ebfm_cfgrd_wait(bnm,dev,fnc,16'h100,4,CFG_SCRATCH_SPACE, compl_status);
	 reg_dword = shmem_read(CFG_SCRATCH_SPACE, 4);
	 if (root_port == 1) 
	   dummy = ebfm_display(EBFM_MSG_INFO, {"     RP Virtual Channel Extended Capability Header ( ", himage8(reg_dword[31:0]), " )"} );
	 else
	   dummy = ebfm_display(EBFM_MSG_INFO, {"     EP Virtual Channel Extended Capability Header ( ", himage8(reg_dword[31:0]), " )"} );
	 
	 ebfm_cfgrd_wait(bnm,dev,fnc,16'h104,4,CFG_SCRATCH_SPACE, compl_status);
	 reg_word = shmem_read(CFG_SCRATCH_SPACE, 2);
	 dummy = ebfm_display(EBFM_MSG_INFO,{"       VC count ( ", himage1(reg_word[1:0]), " ), Low Priority Extended VC Count ( ", himage1(reg_word[6:4]), " )" });

	 //0x108
	 ebfm_cfgrd_wait(bnm,dev,fnc,16'h108,4,CFG_SCRATCH_SPACE, compl_status);
	 reg_dword = shmem_read(CFG_SCRATCH_SPACE, 4);
	 if (reg_dword[0] == 1)
	   dummy = ebfm_display(EBFM_MSG_INFO,{"      Hardware fixed arbitration scheme : Round Robin  " });
	 else if (reg_dword[1] == 1)
	   dummy = ebfm_display(EBFM_MSG_INFO,{"      Weighted Round Robin (WRR) arbitration, 32 phases. " });
	 else if (reg_dword[2] == 1)
	   dummy = ebfm_display(EBFM_MSG_INFO,{"      Weighted Round Robin (WRR) arbitration, 64 phases. " });
	 else if (reg_dword[3] == 1)
	   dummy = ebfm_display(EBFM_MSG_INFO,{"      Weighted Round Robin (WRR) arbitration, 128 phases. " });
	 
	 //0x110
	 ebfm_cfgrd_wait(bnm,dev,fnc,16'h110,4,CFG_SCRATCH_SPACE, compl_status);
	 reg_dword = shmem_read(CFG_SCRATCH_SPACE, 4);
	 dummy = ebfm_display(EBFM_MSG_INFO,{"  Virtual Channel 0: " });
	 dummy = ebfm_display(EBFM_MSG_INFO,{"       PAT offset: ( ", himage2(reg_dword[31:24]), " )", "Port Arbitration Capabiliity ( ", himage4(reg_dword[7:0]), " ) " });

	 //0x114
	 ebfm_cfgrd_wait(bnm,dev,fnc,16'h114,4,CFG_SCRATCH_SPACE, compl_status);
	 reg_dword = shmem_read(CFG_SCRATCH_SPACE, 4);
	 dummy = ebfm_display(EBFM_MSG_INFO,{"       Resource Control: TC/VC map (", himage2(reg_dword[7:0]), ")", " VC ID: ( ", himage1(reg_dword[26:24]), " )" });
	 if (reg_dword[31] == 1)
	   dummy = ebfm_display(EBFM_MSG_INFO,{"       VC 0 enabled." });
	 else
	   dummy = ebfm_display(EBFM_MSG_INFO,{"       VC 0 disabled." });
	 
	 //0x118
	 ebfm_cfgrd_wait(bnm,dev,fnc,16'h118,4,CFG_SCRATCH_SPACE, compl_status);
	 reg_dword = shmem_read(CFG_SCRATCH_SPACE, 4);
	 dummy = ebfm_display(EBFM_MSG_INFO,{"         VC 0 Resource Status regs ( ", himage8(reg_dword[31:0]), " )"});
	 
	 //0x11C
	 ebfm_cfgrd_wait(bnm,dev,fnc,16'h11C,4,CFG_SCRATCH_SPACE, compl_status);
	 reg_dword = shmem_read(CFG_SCRATCH_SPACE, 4);
	 dummy = ebfm_display(EBFM_MSG_INFO,{"  Virtual Channel 1: " });
	 dummy = ebfm_display(EBFM_MSG_INFO,{"       PAT offset: ( ", himage2(reg_dword[31:24]), " )", "Port Arbitration Capabiliity ( ", himage4(reg_dword[7:0]), " ) " });

	 //0x120
	 ebfm_cfgrd_wait(bnm,dev,fnc,16'h120,4,CFG_SCRATCH_SPACE, compl_status);
	 reg_dword = shmem_read(CFG_SCRATCH_SPACE, 4);
	 dummy = ebfm_display(EBFM_MSG_INFO,{"       Resource Control: TC/VC map (", himage2(reg_dword[7:0]), ")", " VC ID: ( ", himage1(reg_dword[26:24]), " )" });
	 if (reg_dword[31] == 1)
	   dummy = ebfm_display(EBFM_MSG_INFO,{"       VC 1 enabled." });
	 else
	   dummy = ebfm_display(EBFM_MSG_INFO,{"       VC 1 disabled." });

	 //0x124
	 ebfm_cfgrd_wait(bnm,dev,fnc,16'h124,4,CFG_SCRATCH_SPACE, compl_status);
	 reg_dword = shmem_read(CFG_SCRATCH_SPACE, 4);
	 dummy = ebfm_display(EBFM_MSG_INFO,{"         VC 1 Resource Status regs(", himage8(reg_dword[31:0]), ")"});
	 
      end
   endtask // ebfm_display_all_vc_regs

   task ebfm_cfg_vc;
      input   bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   n_vc;
      integer n_vc;
      input   enable;
      integer enable;
      input   tcvcmap;
      integer tcvcmap;

      reg     dummy;
      reg [31:0] val;
      reg [2:0]  compl_status;
      
      begin
	 // VC Resource Control Registers.
	 val[31] = (enable == 1) ? 1 : 0;
	 val[30:27] = 0;
	 val[26:24] = n_vc;
	 val[23:8] = 0;
	 val[7:0] = tcvcmap;
	 dummy = ebfm_display(EBFM_MSG_INFO,{"Val: ", himage8(val)});
	 
	 if (n_vc == 0)
	   ebfm_cfgwr_imm_wait(bnm,dev,fnc,16'h114,4, val, compl_status);
	 else if (n_vc == 1)
	   ebfm_cfgwr_imm_wait(bnm,dev,fnc,16'h120,4, val, compl_status);
	 else
           dummy = ebfm_display(EBFM_MSG_INFO,"  Only Support VC0 and VC1.") ;
      end
      
   endtask // enable_vc
   
   // purpose: Display the Virtual Channel Capabilities
   task ebfm_display_vc;
      input root_port;
      input bnm;
      integer bnm;
      input   dev;
      integer dev;
      input   fnc;
      integer fnc;
      input   CFG_SCRATCH_SPACE;
      integer CFG_SCRATCH_SPACE;

      reg [2:0] compl_status;
      reg [15:0] port_vc_cap_r;
      reg [2:0]  low_vc;

      reg 	 dummy ;

      begin  // ebfm_display_vc
         ebfm_cfgrd_wait(bnm,dev,fnc,260,4,CFG_SCRATCH_SPACE, compl_status);

         port_vc_cap_r = shmem_read(CFG_SCRATCH_SPACE,2) ;
         // Low priority VC = 0 means there is no Low priority VC
         // Low priority VC = 1 means there are 2 Low priority VCs etc
	 if (port_vc_cap_r[6:4] == 3'b000)
	   begin
              low_vc = 3'b000;
	   end
	 else
	   begin
              low_vc = port_vc_cap_r[6:4] + 1;
	   end
         if (root_port==1)
           dummy = ebfm_display(EBFM_MSG_INFO,"  RP PCI Express Virtual Channel Capability:") ;
         else
           dummy = ebfm_display(EBFM_MSG_INFO,"  EP PCI Express Virtual Channel Capability:") ;

         dummy = ebfm_display(EBFM_MSG_INFO,{"         Virtual Channel: ", himage1({1'b0,port_vc_cap_r[2:0]} +1)}) ;
         dummy = ebfm_display(EBFM_MSG_INFO,{"         Low Priority VC: ", himage1({1'b0,low_vc})}) ;
         dummy = ebfm_display(EBFM_MSG_INFO,"") ;
      end
   endtask

   // purpose: Performs all of the steps neccesary to configure the
   // root port and the endpoint on the link
   task ebfm_cfg_rp_ep_main;
      input bar_table;
      integer bar_table;
      // Constant Display the Config Spaces of the EP after config setup
      input   ep_bus_num;
      integer ep_bus_num;
      input   ep_dev_num;
      integer ep_dev_num;
      input   rp_max_rd_req_size;
      integer rp_max_rd_req_size;
      input   display_ep_config;    // 1 to display
      integer display_ep_config;
      input   display_rp_config;    // 1 to display
      integer display_rp_config;
      input   addr_map_4GB_limit;


      reg [31:0] io_min_v;
      reg [31:0] io_max_v;
      reg [63:0] m32min_v;
      reg [63:0] m32max_v;
      reg [63:0] m64min_v;
      reg [63:0] m64max_v;
      reg [2:0]  compl_status;
      reg 	 bar_ok;

      reg 	 dummy ;

      integer 	 i ;

      begin  // ebfm_cfg_rp_ep_main
         io_min_v = EBFM_BAR_IO_MIN ;
         io_max_v = EBFM_BAR_IO_MAX ;
         m32min_v = {32'h00000000,EBFM_BAR_M32_MIN};
         m32max_v = {32'h00000000,EBFM_BAR_M32_MAX};
         m64min_v = EBFM_BAR_M64_MIN;
         m64max_v = EBFM_BAR_M64_MAX;
         if  (display_rp_config == 1'b1) // Limit the BAR allocation to less than 4GB
	   begin
              m32max_v[31:0] = m32max_v[31:0] & 32'h7fff_ffff;
              m64min_v = 64'h0000_0000_8000_0000;
	   end

         // Wait until the Root Port is done being reset before proceeding further
         #10;

         req_intf_wait_reset_end;

         // Unlock the bfm shared memory for initialization
         bfm_shmem_common.protect_bfm_shmem = 1'b0;

         // Perform the basic configuration of the Root Port
         ebfm_cfg_rp_basic((ep_bus_num - RP_PRI_BUS_NUM), 1);

         if ((display_ep_config == 1) | (display_rp_config == 1)) begin
            dummy = ebfm_display(EBFM_MSG_INFO, "Completed initial configuration of Root Port.");
         end

         if (display_ep_config == 1)
           begin
              ebfm_display_read_only(0, (ep_bus_num - RP_PRI_BUS_NUM), 1, 0, CFG_SCRATCH_SPACE);
              ebfm_display_msi(ep_bus_num,1,0,CFG_SCRATCH_SPACE) ;
              ebfm_display_msix(ep_bus_num,1,0,CFG_SCRATCH_SPACE) ;
              ebfm_display_aer(0, ep_bus_num,1,0,CFG_SCRATCH_SPACE) ;
           end

         if (display_rp_config == 1) begin
            // dummy write to ensure link is at L0
            ebfm_cfgwr_imm_wait(ep_bus_num, ep_dev_num, 0, 4, 4, 32'h00000007, compl_status);

            ebfm_display_read_only(1, RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, CFG_SCRATCH_SPACE);
            ebfm_display_rp_bar(RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, CFG_SCRATCH_SPACE);
            ebfm_display_msi(RP_PRI_BUS_NUM,RP_PRI_DEV_NUM,0,CFG_SCRATCH_SPACE) ;
            ebfm_display_aer(1, RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, CFG_SCRATCH_SPACE) ;
            ebfm_display_slot_cap (1, RP_PRI_BUS_NUM, RP_PRI_DEV_NUM, 0, CFG_SCRATCH_SPACE) ;
         end

         ebfm_cfg_pcie_cap((ep_bus_num - RP_PRI_BUS_NUM), 1, 0, CFG_SCRATCH_SPACE, rp_max_rd_req_size, display_ep_config, display_rp_config);

         // Configure BARs (Throw away the updated min/max addresses)
         ebfm_cfg_bars(ep_bus_num, ep_dev_num, 0, bar_table, bar_ok,
                       io_min_v, io_max_v, m32min_v, m32max_v, m64min_v, m64max_v,
                       display_ep_config, addr_map_4GB_limit);
         if (bar_ok == 1'b1)
           begin
              if ((display_ep_config == 1) | (display_rp_config == 1))
		begin
		   dummy = ebfm_display(EBFM_MSG_INFO, "Completed configuration of Endpoint BARs.");
		end
           end
         else
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, "Unable to assign all of the Endpoint BARs.");
           end

         // Configure Root Port Address Windows
         ebfm_cfg_rp_addr(
			  (m32max_v + 1),    // Pref32 grew down
			  (m64min_v - 1),    // Pref64 grew up
			  (EBFM_BAR_M32_MIN),    // NonP started here
			  (m32min_v[31:0] - 1),  // NonP ended here
			  (EBFM_BAR_IO_MIN), // I/O Started Here
			  (io_min_v - 1));   // I/O ended Here

         ebfm_cfgwr_imm_wait(ep_bus_num, ep_dev_num, 0, 4, 4, 32'h00000007, compl_status);
	 
	 ebfm_cfg_vc(1/*bus*/, 1/*dev*/, 0/*func*/, 0/*n_vc*/, 1/*enable*/, 8'hFF/*tcvcmap*/);
	 ebfm_cfg_vc(1/*bus*/, 1/*dev*/, 0/*func*/, 1/*n_vc*/, 1/*enable*/, 8'h00/*tcvcmap*/);
	 ebfm_cfg_vc(0/*bus*/, 0/*dev*/, 0/*func*/, 0/*n_vc*/, 1/*enable*/, 8'hFF/*tcvcmap*/);
	 ebfm_cfg_vc(0/*bus*/, 0/*dev*/, 0/*func*/, 1/*n_vc*/, 1/*enable*/, 8'h00/*tcvcmap*/);
	 	  
	 ebfm_display_vc_regs(0/*rp*/, 1/*bnm*/, 1/*dev*/, 0/*func*/, CFG_SCRATCH_SPACE + 32);
	 ebfm_display_vc_regs(1/*rp*/, 0/*bnm*/, 0/*dev*/, 0/*func*/, CFG_SCRATCH_SPACE + 32);
	 
         // Protect the critical BFM data from being accidentally overwritten.
         bfm_shmem_common.protect_bfm_shmem = 1'b1; 

      end
   endtask

   task ebfm_cfg_rp_ep;   // Wrapper task called by End Point
      input bar_table;
      integer bar_table;
      // Constant Display the Config Spaces of the EP after config setup
      input   ep_bus_num;
      integer ep_bus_num;
      input   ep_dev_num;
      integer ep_dev_num;
      input   rp_max_rd_req_size;
      integer rp_max_rd_req_size;
      input   display_ep_config;    // 1 to display
      integer display_ep_config;
      input   addr_map_4GB_limit;

      ebfm_cfg_rp_ep_main (bar_table, ep_bus_num, ep_dev_num, rp_max_rd_req_size, display_ep_config, 0, addr_map_4GB_limit);

   endtask


   task ebfm_cfg_rp_ep_rootport;   // Wrapper task called by Root Port
      input bar_table;
      integer bar_table;
      // Constant Display the Config Spaces of the EP after config setup
      input   ep_bus_num;
      integer ep_bus_num;
      input   ep_dev_num;
      integer ep_dev_num;
      input   rp_max_rd_req_size;
      integer rp_max_rd_req_size;
      input   display_ep_config;    // 1 to display
      integer display_ep_config;
      input   display_rp_config;    // 1 to display
      integer display_rp_config;
      input   addr_map_4GB_limit;

      ebfm_cfg_rp_ep_main (bar_table, ep_bus_num, ep_dev_num, rp_max_rd_req_size, display_ep_config, display_rp_config, addr_map_4GB_limit);

   endtask


   // purpose: returns whether specified BAR is memory or I/O and the size
   task ebfm_cfg_decode_bar;
      input bar_table;   // Pointer to BAR info
      integer bar_table;
      input   bar_num;     // bar number to check
      integer bar_num;
      output  log2_size;  // Log base 2 of the Size
      integer log2_size;
      output  is_mem;     // Is memory (not I/O)
      output  is_pref;    // Is prefetchable
      output  is_64b;     // Is 64bit

      reg [63:0] bar64;
      parameter[31:0] ZERO32 = {32{1'b0}};
      integer 	 maxlsb;

      begin
         bar64 = shmem_read((bar_table + 32 + (bar_num * 4)), 8);
         // Check if BAR is unassigned
         if (bar64[31:0] == ZERO32)
           begin
              log2_size = 0;
              is_mem = 1'b0;
              is_pref = 1'b0;
              is_64b = 1'b0;
           end
         else
           begin
              is_mem = ~bar64[0];
              is_pref = (~bar64[0]) & bar64[3];
              is_64b = (~bar64[0]) & bar64[2];
              if (((bar64[0]) == 1'b1) | ((bar64[2]) == 1'b0))
		begin
		   maxlsb = 31;
		end
              else
		begin
		   maxlsb = 63;
		end
              begin : xhdl_10
		 integer i;
		 for(i = 4; i <= maxlsb; i = i + 1)
		   begin : check_loop
                      if ((bar64[i]) == 1'b1)
			begin
			   log2_size = i;
			   disable xhdl_10 ;
			end
		   end
              end // i in 4 to maxlsb
           end
      end
   endtask

   // The clk_in and rstn signals are provided for possible use in controlling
   // the transactions issued, they are not currently used.



   /////////////////////////////////////////////////////////////////////////
   //
   // TASK:dma_set_msi:
   //
   // Setup native PCIe MSI for DMA read and DMA write.
   // Retrieve MSI capabilities of EP, program EP MSI cfg register
   // with msi_address and msi_data
   //
   // input argument:
   //        bar_table    : Pointer to the BAR sizing and
   //        setup_bar    : BAR to be used for setting up
   //        bus_num      : default 1
   //        dev_num      : default 0
   //        fnc_num      : default 0
   //        dt_direction : Read or write
   //        msi_address  : RC Mem MSI address
   //        msi_data     : MSI cgf data
   //
   // returns:
   //       msi_number (default : 1 for write , 0 for read)
   //       msi_traffic_class MSI traffic class (default 0)
   //       msi_expected Expected data written by MSI to RC Host memory
   //
   task dma_set_msi (
		     input integer bar_table    ,
		     input integer setup_bar    ,
		     input integer bus_num      ,
		     input integer dev_num      ,
		     input integer fnc_num      ,
		     input integer dt_direction ,
		     input integer msi_address  ,
		     input integer msi_data     ,

		     output reg [4:0] msi_number       ,
		     output reg [2:0] msi_traffic_class,
		     output reg [2:0] multi_message_enable,
		     output integer msi_expected
		     );

      localparam msi_capabilities  = 32'h50;
      // The Root Complex BFM has 2MB of address space
      localparam msi_upper_address = 32'h0000_0000;

      reg [15:0] 		    msi_control_register;
      reg 			    msi_64b_capable;
      reg [2:0] 		    multi_message_capable;
      reg 			    msi_enable;
      reg [2:0] 		    compl_status;
      reg 			    unused_result ;

      begin

	 // MSI
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 if (dt_direction==RD_DIRECTION)
           unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_set_msi READ");
	 else
           unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_set_msi WRITE");

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO,
					   " Message Signaled Interrupt Configuration");
	 // Read the contents of the MSI Control register
	 msi_traffic_class = 0; //TODO make it an input argument

	 unused_result = ebfm_display(EBFM_MSG_INFO, {"  msi_address (RC memory)= 0x",
                                                      himage4(msi_address)});

	 // RC Reading MSI capabilities of the EP
	 // to get msi_control_register
	 ebfm_cfgrd_wait(bus_num, dev_num, fnc_num,
			 msi_capabilities, 4,
			 msi_address,
			 compl_status);
	 msi_control_register  = shmem_read(msi_address+2, 2);

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, {"  msi_control_register = 0x",
							   himage4(msi_control_register)});

	 // Program the MSI Message Control register for testing
	 msi_64b_capable       = msi_control_register[7];
	 // Enable the MSI with Maximum Number of Supported Messages
	 multi_message_capable = msi_control_register[3:1];
	 multi_message_enable  = multi_message_capable;
	 msi_enable            = 1'b1;
	 ebfm_cfgwr_imm_wait(bus_num, dev_num, fnc_num,
                             msi_capabilities, 4,
                             {8'h00, msi_64b_capable,
                              multi_message_enable,
                              multi_message_capable,
                              msi_enable, 16'h0000},
                             compl_status);

	 msi_number[4:0]= (1==dt_direction)?5'h1:5'h0;

	 // Retrieve msi_expected
	 if (multi_message_enable==3'b000)
           begin
              unused_result = ebfm_display(EBFM_MSG_WARNING,
					   "The chained DMA example design required at least 2 MSI ");
              unused_result = ebfm_log_stop_sim(1);
           end
	 else
           begin
              case (multi_message_enable)
		3'b000:  msi_expected =  msi_data[15:0];
		3'b001:  msi_expected = {msi_data[15:1], msi_number[0]  };
		3'b010:  msi_expected = {msi_data[15:2], msi_number[1:0]};
		3'b011:  msi_expected = {msi_data[15:3], msi_number[2:0]};
		3'b100:  msi_expected = {msi_data[15:4], msi_number[3:0]};
		3'b101:  msi_expected = {msi_data[15:5], msi_number[4:0]};
		default: unused_result = ebfm_display(EBFM_MSG_ERROR_FATAL,
						      "Illegal multi_message_enable value detected. MSI test fails.");
              endcase
           end

	 // Write the rest of the MSI Capabilities Structure:
	 //            Address and Data Fields
	 if (msi_64b_capable) // 64-bit Addressing
           begin
              // Specify the RC lower Address where the MSI need to be written
              // when EP issues MSI (msi_address= dt_bdt_lsb-16)
              // 4 DWORD bellow the descriptor table
              ebfm_cfgwr_imm_wait(bus_num, dev_num, fnc_num,
                                  msi_capabilities + 4'h4, 4,
                                  msi_address,
                                  compl_status);
              // Specify the RC Upper Address where the MSI need to be written
              // when EP issues MSI
              ebfm_cfgwr_imm_wait(bus_num, dev_num, fnc_num,
                                  msi_capabilities + 4'h8, 4,
                                  msi_upper_address,
                                  compl_status);
              // Specify the data to be written in the RC Memeoryr MSI location
              // when EP issues MSI
              // (msi_data = 16'hb0fe)
              ebfm_cfgwr_imm_wait(bus_num, dev_num, fnc_num,
                                  msi_capabilities + 4'hC, 4,
                                  msi_data,
                                  compl_status);
           end
	 else // 32-bit Addressing
           begin
              // Specify the RC lower Address where the MSI need to be written
              // when EP issues MSI (msi_address= dt_bdt_lsb-16)
              // 4 DWORD bellow the descriptor table
              ebfm_cfgwr_imm_wait(bus_num, dev_num, fnc_num,
                                  msi_capabilities + 4'h4, 4,
                                  msi_address, compl_status);
              // Specify the data to be written in the RC Memeoryr MSI location
              // when EP issues MSI
              // (msi_data = 16'hb0fe)
              ebfm_cfgwr_imm_wait(bus_num, dev_num, fnc_num,
                                  msi_capabilities + 4'h8, 4,
                                  msi_data, compl_status);
           end

	 // Clear RC memory MSI Location
	 shmem_write(msi_address,  32'h1111_FADE,4);

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, {"  msi_expected = 0x",
							   himage4(msi_expected)});

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, {"  msi_capabilities address = 0x",
							   himage4(msi_capabilities)});

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, {"  multi_message_enable = 0x",
							   himage4(multi_message_enable)});

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, {"  msi_number = ",
							   dimage4(msi_number)});

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, {"  msi_traffic_class = ",
							   dimage4(msi_traffic_class)});

      end


   endtask

   /////////////////////////////////////////////////////////////////////////
   //
   // TASK:dma_set_header :
   //
   // RC issues MWr to write Descriptor table header DW0, DW1, DW2
   // RC initializaed RC shared memory with MSI_DATA, DW0, DW1, DW2
   //
   // Descriptor header table in EP shared memory :
   //
   //  |----------------------------------------------
   //  | DMA Write
   //  |----------------------------------------------
   //  | 0h     | DW0
   //  |--------|-------------------------------------
   //  | 04h    | DW1
   //  |--------|-------------------------------------
   //  | 08h    | DW2
   //  |--------|-------------------------------------
   //  | 0ch    | RCLast
   //  |        | RC MWr RCLast : Available DMA number
   //  |----------------------------------------------
   //  | DMA Read
   //  |----------------------------------------------
   //  |10h     | DW0
   //  |--------|-------------------------------------
   //  |14h     | DW1
   //  |--------|-------------------------------------
   //  |18h     | DW2
   //  |--------|-------------------------------------
   //  |1ch     | RCLast
   //  |        | RC MWr RCLast : Available DMA number
   //  |----------------------------------------------
   //
   // Descriptor header table in RC shared memory :
   //
   //  |--------|----------------------------------------------
   //  | -10h   | MSI_DATA
   //  |        | EP MWr MSI at the end of DMA transfer
   //  |--------|----------------------------------------------
   //  |BDT LSB | DW0
   //  |--------|----------------------------------------------
   //  |+04h    | DW1
   //  |--------|----------------------------------------------
   //  |+08h    | DW2
   //  |--------|----------------------------------------------
   //  |+0ch    | EPLAST
   //  |        | EP MWr EPLAST to reflects DMA transfer number
   //  |-------------------------------------------------------
   //
   task dma_set_header (
			input integer bar_table    , // Pointer to the BAR sizing and
			input integer setup_bar    , // BAR to be used for setting up
			input integer dt_size      , // total number of descriptors in the descriptor table
			input integer dt_direction , // Specifies which descriptor table to set up:  DMA Read or write
			input integer dt_msi       , // control bit which specifies to use MSI for all descriptors
			input integer dt_eplast    , // control bit which specifies to use EPLast for all descriptors
			input integer dt_bdt_msb   , // upper 32 bits base address of the descriptor table location in Root Port memory space
			input integer dt_bdt_lsb   ,  //lower 32 bits base address of the descriptor table location in Root Port memory space

			input [4:0] msi_number       ,    // MSI
			input [2:0] msi_traffic_class,    // MSI
			input [2:0] multi_message_enable, // MSI
			input stop_dma_loop,
			input integer num_port
			);

      reg [31:0] 	      dt_dw0;
      integer 		      dt_dw1,dt_dw2 ;
      integer 		      ep_offset ;
      reg 		      unused_result ;
      integer 		      tc_class;
      
      begin

	 tc_class = (num_port == 1) ? TC_CLASS_P1 : TC_CLASS_P0;
	 
	 // Constructing header dsecriptor table DWORDS DW0
	 dt_dw0[15:0]  = dt_size;
	 dt_dw0[16]    = 1'b0;
	 dt_dw0[17]    = (dt_msi    ==0)?1'b0:1'b1;
	 dt_dw0[18]    = (dt_eplast ==0)?1'b0:1'b1;
	 dt_dw0[19]    = 1'b0;
	 dt_dw0[24:20] = msi_number[4:0];
	 dt_dw0[27:25] = 3'b000;
	 dt_dw0[30:28] = msi_traffic_class;
	 dt_dw0[31]    = ((DMA_CONTINOUS_LOOP>0)&&(stop_dma_loop==1'b0))?1'b1:1'b0;

	 // Constructing header dsecriptor table DWORDS DW1
	 dt_dw1 = dt_bdt_msb;

	 // Constructing header dsecriptor table DWORDS DW2
	 dt_dw2 = dt_bdt_lsb;

	 // DMA Write ep_offset /BAR = 0;
	 // DMA Read ep_offset  /BAR = 16 (4 DWORDs);
	 ep_offset = (WR_DIRECTION==dt_direction)?0:16;

	 // display section
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 if (dt_direction==RD_DIRECTION)
           unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_set_header READ");
	 else
           unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_set_header WRITE");

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, "Writing Descriptor header");

	 // RC writes EP DMA register (for module altpcie_dma_prg_reg)
	 if (DEBUG_PRG==0) begin
            ebfm_barwr_imm(bar_table, setup_bar, 0+ep_offset, dt_dw0, 4, tc_class);
            ebfm_barwr_imm(bar_table, setup_bar, 4+ep_offset, dt_dw1, 4, tc_class);
            ebfm_barwr_imm(bar_table, setup_bar, 8+ep_offset, dt_dw2, 4, tc_class);
	 end
	 else begin
            ebfm_barwr_imm(bar_table, setup_bar, 0+ep_offset, 32'hC1FE_FADE, 4, tc_class);
            ebfm_barwr_imm(bar_table, setup_bar, 4+ep_offset, 32'hC2FE_FADE, 4, tc_class);
            ebfm_barwr_imm(bar_table, setup_bar, 8+ep_offset, 32'hC3FE_FADE, 4, tc_class);
	 end
	 // RC writes RC Memory
	 shmem_write(dt_bdt_lsb  , dt_dw0,4);
	 shmem_write(dt_bdt_lsb+4, dt_dw1,4);
	 shmem_write(dt_bdt_lsb+8, dt_dw2,4);
	 shmem_write(dt_bdt_lsb+12, 32'hCAFE_FADE,4);

	 shmem_fill(dt_bdt_lsb+12,SHMEM_FILL_DWORD_INC,4,32'hCAFE_FADE);

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, "data content of the DT header");
	 if (DISPLAY_ALL==1)
           unused_result =shmem_display(dt_bdt_lsb,4*4,4,dt_bdt_lsb+(4*4),EBFM_MSG_INFO);
      end

   endtask

   /////////////////////////////////////////////////////////////////////////
   //
   // TASK:dma_set_rclast :
   //    RC issues MWr RCLast to EP at address C on the EP site
   //    RCLast is a WORD which represent the number of the DMA descriptor
   //    ready for transfer.
   //    Writing RCLast to EP trigger the start of the DMA transfer
   //
   // input argument
   //    bar_table    : Pointer to the BAR sizing and
   //    setup_bar    : BAR to be used for setting up
   //    dt_direction : Read (0) or Write (1)
   //    dt_rclast    : status bit to write back ep_counter info
   //
   task dma_set_rclast (
			input integer bar_table    ,
			input integer setup_bar    ,
			input integer dt_direction ,
			input integer dt_rclast
			);

      reg [31:0] 		      dt_dw4 ;
      integer 			      ep_offset ;
      reg 			      unused_result ;
      integer 			      tc_class;
      integer  			      num_port;
      
      begin

	 num_port = setup_bar - 2;
	 
	 tc_class = (num_port == 1) ? TC_CLASS_P1 : TC_CLASS_P0;
	 
	 // DMA Write ep_offset /BAR = 0;
	 // DMA Read ep_offset  /BAR = 16 (4 DWORDs);
	 ep_offset = (WR_DIRECTION==dt_direction)?0:16;
	 dt_dw4[15:0]    = dt_rclast;
	 dt_dw4[31:16]   = 0;

	 // display section
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_set_rclast");

	 if (dt_direction==RD_DIRECTION)
           unused_result = ebfm_display_verb(EBFM_MSG_INFO,
					     {"   Start READ DMA : RC issues MWr (RCLast=",
					      dimage4(dt_rclast), ")"});
	 else
           unused_result = ebfm_display_verb(EBFM_MSG_INFO,
					     {"   Start WRITE DMA : RC issues MWr (RCLast=",
					      dimage4(dt_rclast), ")"});

	 // RC writes EP DMA register
	 ebfm_barwr_imm(bar_table, setup_bar, 12+ep_offset, dt_dw4, 4, tc_class);
      end
   endtask

   /////////////////////////////////////////////////////////////////////////
   //
   // TASK: dma_set_wr_desc_data :
   //
   //  write 'write descriptor table in the RC Memory
   //
   /////////////////////////////////////////////////////
   //           |-------------------------------------
   //           | header write
   //           |-------------------------------------
   // BRC+0h    | DW0: number of descriptor
   // BRC+4h    | DW1: BDT MSB
   // BRC+8h    | DW2: BDT LSB
   // BRC+ch    | DW3: EP Last
   //           |-------------------------------------
   //           | desc0 write
   //           |-------------------------------------
   // BRC+10h   | DW0: length        : 256 DWORDS
   // BRC+14h   | DW1: EP ADDR       : 0h
   // BRC+18h   | DW2: RC ADDR MSB   : BDT_MSB
   // BRC+1ch   | DW3: RC ADDR LSB   : BRC+01000h
   //           |-------------------------------------
   //           | desc1 write
   //           |-------------------------------------
   // BRC+20h   | DW0: length        : 512 DWORDS
   // BRC+24h   | DW1: EP ADDR       : 0h
   // BRC+28h   | DW2: RC ADDR MSB   : BDT_MSB
   // BRC+2ch   | DW3: RC ADDR LSB   : BRC+02000h
   //           |-------------------------------------
   //           | desc2 write
   //           |-------------------------------------
   // BRC+30h   | DW0: length        : 1024 DWORDS
   // BRC+34h   | DW1: EP ADDR       : 0h
   // BRC+38h   | DW2: RC ADDR MSB   : BDT_MSB
   // BRC+3ch   | DW3: RC ADDR LSB   : BRC+03000h
   //           |-------------------------------------
   //
   // input arguments
   //   bar_table : Pointer to the BAR sizing and
   //   setup_bar : BAR to be used for setting up
   //
   task dma_set_wr_desc_data (
			      input integer bar_table    ,
			      input integer setup_bar
			      );

      reg 				    unused_result ;
      integer 				    descriptor_addr,i;

      integer 				    loop_DW0;
      integer 				    loop_DW1;
      integer 				    loop_DW2;
      integer 				    loop_DW3;
      integer 				    loop_control_field;

      integer 				    wr_first_descriptor ;
      integer 				    wr_desc0_rcaddr_lsb   ;
      integer 				    wr_desc0_init_bfm_mem ;

      integer 				    wr_desc1_rcaddr_lsb   ;
      integer 				    wr_desc1_init_bfm_mem ;

      integer 				    wr_desc2_rcaddr_lsb   ;
      integer 				    wr_desc2_init_bfm_mem ;
      
      begin

	 //program BFM share memeory
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_set_wr_desc_data");



	 if (setup_bar == 2) begin
	    wr_first_descriptor = WR_FIRST_DESCRIPTOR;
	    wr_desc0_rcaddr_lsb = WR_DESC0_RCADDR_LSB;
	    wr_desc0_init_bfm_mem = WR_DESC0_INIT_BFM_MEM;

	    wr_desc1_rcaddr_lsb = WR_DESC1_RCADDR_LSB;
	    wr_desc1_init_bfm_mem = WR_DESC1_INIT_BFM_MEM;

	    wr_desc2_rcaddr_lsb = WR_DESC2_RCADDR_LSB;
	    wr_desc2_init_bfm_mem = WR_DESC2_INIT_BFM_MEM;
	 end // if (setup_bar == 2)
	 else if (setup_bar == 3) begin
	    wr_first_descriptor = WR_FIRST_DESCRIPTOR + 16'h3000;
	    wr_desc0_rcaddr_lsb = WR_DESC0_RCADDR_LSB + 16'h3000;
	    wr_desc0_init_bfm_mem = WR_DESC0_INIT_BFM_MEM;

	    wr_desc1_rcaddr_lsb = WR_DESC1_RCADDR_LSB + 16'h3000;
	    wr_desc1_init_bfm_mem = WR_DESC1_INIT_BFM_MEM;

	    wr_desc2_rcaddr_lsb = WR_DESC2_RCADDR_LSB + 16'h3000;
	    wr_desc2_init_bfm_mem = WR_DESC2_INIT_BFM_MEM;
	 end

	 // First Descriptor
	 descriptor_addr = wr_first_descriptor; //
	 loop_control_field = ((2**17) * WR_DESC0_CTL_EPLAST) + ((2**16) * WR_DESC0_CTL_MSI);   // Assemble Descriptor Control Field
	 shmem_write(descriptor_addr  ,  (loop_control_field + WR_DESC0_LENGTH)     ,4);
	 shmem_write(descriptor_addr+4,  WR_DESC0_EPADDR     ,4);
	 shmem_write(descriptor_addr+8,  WR_DESC0_RCADDR_MSB ,4);
	 shmem_write(descriptor_addr+12, wr_desc0_rcaddr_lsb ,4);
	 shmem_fill(wr_desc0_rcaddr_lsb,SHMEM_FILL_DWORD_INC,
                    WR_DESC0_LENGTH*4,WR_DESC0_INIT_BFM_MEM);
	 // Display descriptor table of DMA Write
	 if (NUMBER_OF_DESCRIPTORS>3)
	   begin
              for (i=1;i<NUMBER_OF_DESCRIPTORS-1;i=i+1)
		begin
		   descriptor_addr = wr_first_descriptor + 16*i;
		   loop_control_field = ((2**17) * WR_DESC1_CTL_EPLAST) + ((2**16) * WR_DESC1_CTL_MSI);   // Assemble Descriptor Control Field
		   loop_DW0        = loop_control_field + WR_DESC1_LENGTH + i*MEM_DESCR_LENGTH_INC;
		   loop_DW1        = WR_DESC1_EPADDR ;
		   loop_DW2        = WR_DESC1_RCADDR_MSB;
		   loop_DW3        = wr_desc1_rcaddr_lsb;
		   shmem_write(descriptor_addr  ,  loop_DW0 ,4);
		   shmem_write(descriptor_addr+4,  loop_DW1 ,4);
		   shmem_write(descriptor_addr+8,  loop_DW2 ,4);
		   shmem_write(descriptor_addr+12, loop_DW3 ,4);
		   if (i==1)
		     shmem_fill(wr_desc1_rcaddr_lsb,SHMEM_FILL_DWORD_INC, loop_DW0*4,
				WR_DESC1_INIT_BFM_MEM);
		end
              i = NUMBER_OF_DESCRIPTORS-2;
	   end
	 else
	   begin
              i = 1;
              // Descriptor 1
              descriptor_addr = wr_first_descriptor+16;
              loop_control_field = ((2**17) * WR_DESC1_CTL_EPLAST) + ((2**16) * WR_DESC1_CTL_MSI);   // Assemble Descriptor Control Field
              shmem_write(descriptor_addr  ,  loop_control_field + WR_DESC1_LENGTH     ,4);
              shmem_write(descriptor_addr+4,  WR_DESC1_EPADDR     ,4);
              shmem_write(descriptor_addr+8,  WR_DESC1_RCADDR_MSB ,4);
              shmem_write(descriptor_addr+12, wr_desc1_rcaddr_lsb ,4);
              shmem_fill(wr_desc1_rcaddr_lsb,SHMEM_FILL_DWORD_INC,
			 WR_DESC1_LENGTH*4,WR_DESC1_INIT_BFM_MEM);
	   end

	 // Last Descriptor
	 descriptor_addr = wr_first_descriptor+16*(i+1);
	 loop_control_field = ((2**17) * WR_DESC2_CTL_EPLAST) + ((2**16) * WR_DESC2_CTL_MSI);   // Assemble Descriptor Control Field
	 shmem_write(descriptor_addr  ,  loop_control_field + WR_DESC2_LENGTH     ,4);
	 shmem_write(descriptor_addr+4,  WR_DESC2_EPADDR     ,4);
	 shmem_write(descriptor_addr+8,  WR_DESC2_RCADDR_MSB ,4);
	 shmem_write(descriptor_addr+12, wr_desc2_rcaddr_lsb ,4);
	 shmem_fill(wr_desc2_rcaddr_lsb,SHMEM_FILL_DWORD_INC,
                    WR_DESC2_LENGTH*4,WR_DESC2_INIT_BFM_MEM);
      end
   endtask


   /////////////////////////////////////////////////////////////////////////
   //
   // TASK:dma_set_rd_desc_data : write 'read descriptor table in the RC Memory
   //
   //           |-------------------------------------
   //           | header read
   //           |-------------------------------------
   // BRC+100h  | DW0: number of descriptor
   // BRC+104h  | DW1: BDT MSB
   // BRC+108h  | DW2: BDT LSB
   // BRC+10ch  | DW3: EP Last
   //           |-------------------------------------
   //           | desc0 read
   //           |-------------------------------------
   // BRC+110h  | DW0: length
   // BRC+114h  | DW1: EP ADDR       : 0h
   // BRC+118h  | DW2: RC ADDR MSB   : BDT_MSB
   // BRC+11ch  | DW3: RC ADDR LSB   : BRC+05000h
   //           |-------------------------------------
   //           | desc1 read
   //           |-------------------------------------
   // BRC+120h  | DW0: length
   // BRC+124h  | DW1: EP ADDR       : 0h
   // BRC+128h  | DW2: RC ADDR MSB   : BDT_MSB
   // BRC+12ch  | DW3: RC ADDR LSB   :
   //           |-------------------------------------
   //           | desc2 read
   //           |-------------------------------------
   // BRC+130h  | DW0: length
   // BRC+134h  | DW1: EP ADDR       : 0h
   // BRC+138h  | DW2: RC ADDR MSB   : BDT_MSB
   // BRC+13ch  | DW3: RC ADDR LSB   :
   //           |-------------------------------------
   //
   // input arguments
   //   bar_table : Pointer to the BAR sizing and
   //   setup_bar : BAR to be used for setting up
   //
   task dma_set_rd_desc_data
     (
      input integer bar_table,
      input integer setup_bar
      );
      // HEADER PARAMETERS

      reg 	    unused_result ;
      integer 	    descriptor_addr,i;

      integer 	    loop_DW0;
      integer 	    loop_DW1;
      integer 	    loop_DW2;
      integer 	    loop_DW3;
      integer 	    loop_control_field;

      integer 	    rd_first_descriptor ;
      integer 	    rd_desc0_rcaddr_lsb   ;
      integer 	    rd_desc0_init_bfm_mem ;

      integer 	    rd_desc1_rcaddr_lsb   ;
      integer 	    rd_desc1_init_bfm_mem ;

      integer 	    rd_desc2_rcaddr_lsb   ;
      integer 	    rd_desc2_init_bfm_mem ;

      begin

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_set_rd_desc_data");
	 
	 if (setup_bar == 2) begin
	    rd_first_descriptor = RD_FIRST_DESCRIPTOR;
	    rd_desc0_rcaddr_lsb = RD_DESC0_RCADDR_LSB;
	    rd_desc0_init_bfm_mem = RD_DESC0_INIT_BFM_MEM;

	    rd_desc1_rcaddr_lsb = RD_DESC1_RCADDR_LSB;
	    rd_desc1_init_bfm_mem = RD_DESC1_INIT_BFM_MEM;

	    rd_desc2_rcaddr_lsb = RD_DESC2_RCADDR_LSB;
	    rd_desc2_init_bfm_mem = RD_DESC2_INIT_BFM_MEM;
	 end // if (setup_bar == 2)
	 else if (setup_bar == 3) begin
	    rd_first_descriptor = RD_FIRST_DESCRIPTOR + 16'h3000;
	    rd_desc0_rcaddr_lsb = RD_DESC0_RCADDR_LSB + 16'h3000;
	    rd_desc0_init_bfm_mem = RD_DESC0_INIT_BFM_MEM;

	    rd_desc1_rcaddr_lsb = RD_DESC1_RCADDR_LSB + 16'h3000;
	    rd_desc1_init_bfm_mem = RD_DESC1_INIT_BFM_MEM;

	    rd_desc2_rcaddr_lsb = RD_DESC2_RCADDR_LSB + 16'h3000;
	    rd_desc2_init_bfm_mem = RD_DESC2_INIT_BFM_MEM;
	 end // if (setup_bar == 3)
	 
	 //program BFM share memory :

	 // First Descriptor
	 descriptor_addr = rd_first_descriptor;
	 loop_control_field = ((2**17) * RD_DESC0_CTL_EPLAST) + ((2**16) * RD_DESC0_CTL_MSI);   // Assemble Descriptor Control Field
	 shmem_write(descriptor_addr  ,  loop_control_field + RD_DESC0_LENGTH     ,4);
	 shmem_write(descriptor_addr+4,  RD_DESC0_EPADDR     ,4);
	 shmem_write(descriptor_addr+8,  RD_DESC0_RCADDR_MSB ,4);
	 shmem_write(descriptor_addr+12, rd_desc0_rcaddr_lsb ,4);
	 shmem_fill(rd_desc0_rcaddr_lsb,SHMEM_FILL_DWORD_INC,RD_DESC0_LENGTH*4,
                    RD_DESC0_INIT_BFM_MEM);

	 if (NUMBER_OF_DESCRIPTORS>3)
	   begin
              for (i=1;i<NUMBER_OF_DESCRIPTORS-1;i=i+1)
		begin
		   descriptor_addr = rd_first_descriptor + 16*i;
		   loop_control_field = ((2**17) * RD_DESC1_CTL_EPLAST) + ((2**16) * RD_DESC1_CTL_MSI);   // Assemble Descriptor Control Field
		   loop_DW0        = loop_control_field + RD_DESC1_LENGTH + i*MEM_DESCR_LENGTH_INC;
		   loop_DW1        = RD_DESC1_EPADDR ;
		   loop_DW2        = RD_DESC1_RCADDR_MSB;
		   loop_DW3        = rd_desc1_rcaddr_lsb;
		   shmem_write(descriptor_addr  ,  loop_DW0 ,4);
		   shmem_write(descriptor_addr+4,  loop_DW1 ,4);
		   shmem_write(descriptor_addr+8,  loop_DW2 ,4);
		   shmem_write(descriptor_addr+12, loop_DW3 ,4);
		   if (i==1)
		     shmem_fill(rd_desc1_rcaddr_lsb,SHMEM_FILL_DWORD_INC, loop_DW0*4,
				RD_DESC1_INIT_BFM_MEM);
		end
              i = NUMBER_OF_DESCRIPTORS-2;
	   end
	 else
	   begin
              // Descriptor 1
              i = 1;
              descriptor_addr = rd_first_descriptor+16;
              loop_control_field = ((2**17) * RD_DESC1_CTL_EPLAST) + ((2**16) * RD_DESC1_CTL_MSI);   // Assemble Descriptor Control Field
              shmem_write(descriptor_addr  ,  loop_control_field + RD_DESC1_LENGTH     ,4);
              shmem_write(descriptor_addr+4,  RD_DESC1_EPADDR     ,4);
              shmem_write(descriptor_addr+8,  RD_DESC1_RCADDR_MSB ,4);
              shmem_write(descriptor_addr+12, rd_desc1_rcaddr_lsb ,4);
              shmem_fill(rd_desc1_rcaddr_lsb, SHMEM_FILL_DWORD_INC,
			 RD_DESC1_LENGTH*4,RD_DESC1_INIT_BFM_MEM);
	   end

	 // Last Descriptor
	 descriptor_addr = rd_first_descriptor+16*(i+1);
	 loop_control_field = ((2**17) * RD_DESC2_CTL_EPLAST) + ((2**16) * RD_DESC2_CTL_MSI);   // Assemble Descriptor Control Field
	 shmem_write(descriptor_addr  ,  loop_control_field + RD_DESC2_LENGTH     ,4);
	 shmem_write(descriptor_addr+4,  RD_DESC2_EPADDR     ,4);
	 shmem_write(descriptor_addr+8,  RD_DESC2_RCADDR_MSB ,4);
	 shmem_write(descriptor_addr+12, rd_desc2_rcaddr_lsb ,4);
	 shmem_fill(rd_desc2_rcaddr_lsb,SHMEM_FILL_DWORD_INC,
                    RD_DESC2_LENGTH*4,RD_DESC2_INIT_BFM_MEM);
      end
   endtask


   /////////////////////////////////////////////////////////////////////////
   //
   // TASK:msi_poll
   //   Polling process to track in shared memeory received MSI from EP
   //
   // input argument
   //    max_number_of_msi  : Total Number of MSI to track
   //    msi_address        : MSI Address in shared memeory
   //    msi_expected_dmawr : Expected MSI when dma_write is set
   //    msi_expected_dmard : Expected MSI when dma_read is set
   //    dma_write          : Set dma_write
   //    dma_read           : set dma_read
   task msi_poll(
		 input integer max_number_of_msi,
		 input integer msi_address,
		 input integer msi_expected_dmawr,
		 input integer msi_expected_dmard,
		 input integer dma_write,
		 input integer dma_read
		 );

      reg 		       unused_result ;
      integer 		       msi_received;
      integer 		       msi_count;
      reg 		       pol_ip;

      begin
	 //  unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 //   unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:msi_poll Start polling");
	 for (msi_count=0; msi_count < max_number_of_msi;msi_count=msi_count+1)

	   begin
              pol_ip=0;
              fork
		 // Set timeout failure if expected MSI is not received
		 begin:timeout_msi
		    repeat (100000) @(posedge clk_in);
		    unused_result = ebfm_display(EBFM_MSG_ERROR_FATAL,
						 "MSI timeout occured, MSI never received, Test Fails");
		    disable wait_for_msi;
		 end
		 // Polling memory for expected MSI data value
		 // at the assigned MSI address location
		 begin:wait_for_msi
		    forever
		      begin
			 repeat (4) @(posedge clk_in);
			 msi_received = shmem_read (msi_address, 2);
			 if (pol_ip==0)
			   unused_result = ebfm_display(EBFM_MSG_INFO,{
								       "TASK:msi_poll    Polling MSI Address:",
								       himage4(msi_address),
								       "---> Data:",
								       himage4(msi_received),
								       "......"});

			 pol_ip=1;
			 if ((msi_received == msi_expected_dmawr) && (dma_write==1))
			   begin
                              unused_result = ebfm_display(EBFM_MSG_INFO,
							   {"TASK:msi_poll    Received DMA Write MSI(",
							    dimage4(msi_count),
							    ") : ",
							    himage4(msi_received)});
                              shmem_write( msi_address , 32'h1111_FADE, 4);
                              disable timeout_msi;
                              disable wait_for_msi;
			   end

			 if ((msi_received == msi_expected_dmard) && (dma_read==1))
			   begin
                              unused_result = ebfm_display(EBFM_MSG_INFO,
							   {"TASK:msi_poll    Received DMA Read MSI(",
							    dimage4(msi_count),
							    ") : ",
							    himage4(msi_received)});
                              shmem_write( msi_address , 32'h1111_FADE, 4);
                              disable timeout_msi;
                              disable wait_for_msi;
			   end
		      end

		 end
              join

	   end
      end
   endtask

   /////////////////////////////////////////////////////////////////////////
   //
   // rcmem_poll
   //
   // Polling routine waiting for rc_data at location rc_addr
   //
   task rcmem_poll(
		   input integer rc_addr,
		   input integer rc_data,
		   input integer rc_data_mask);

      reg 			 unused_result ;
      integer 			 rc_current;
      integer 			 rc_last;
      reg [31:0] 		 timout_limit;
      reg 			 pol_ip;

      begin

	 //  unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 //  unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:rcmem_poll  Start polling");
	 pol_ip=0;
	 timout_limit[31:0]=0;

	 fork

	    begin:wait_for_rcmem
               forever
		 begin
		    repeat (50) @(posedge clk_in);
		    rc_current = (shmem_read (rc_addr, 4) & (rc_data_mask));
		    if (pol_ip==0) begin
                       timout_limit[31:0]=0;
                       rc_last    = rc_current;
                       unused_result = ebfm_display_verb(EBFM_MSG_INFO,
							 {"TASK:rcmem_poll  Polling RC Address"   ,himage8(rc_addr),
							  "   current data (" ,himage8(rc_current),
							  ")  expected data (",himage8(rc_data),")"});
		    end
		    if (rc_current != rc_last ) begin
                       unused_result = ebfm_display(EBFM_MSG_INFO,
						    {"TASK:rcmem_poll  Polling RC Address"   ,himage8(rc_addr),
						     "   current data (" ,himage8(rc_current),
						     ")  expected data (",himage8(rc_data),")"});
                       timout_limit[31:0]=0;
		    end
		    else
                      timout_limit[31:0]=timout_limit[31:0]+1;

		    rc_last    = rc_current;
		    pol_ip=1;

		    if (timout_limit[31:0]>TIMEOUT_POLLING) begin
                       unused_result = ebfm_display(EBFM_MSG_INFO,
						    "   ---> TASK:rcmem_poll timeout occured");
                       unused_result = ebfm_display(EBFM_MSG_ERROR_FATAL,
						    {"   ---> Test Fails: RC Address:",
						     himage8(rc_addr)," contains ", himage8(rc_current)});
                       disable wait_for_rcmem;
		    end
		    if (rc_current == rc_data)
                      begin
			 unused_result = ebfm_display(EBFM_MSG_INFO,
						      {"TASK:rcmem_poll   ---> Received Expected Data (",himage8(rc_current),")"});
			 disable wait_for_rcmem;
                      end
		 end
	    end
	 join
      end
   endtask

   /////////////////////////////////////////////////////////////////////////
   //
   // TASK:dma_rd_test
   //
   // Run the chained DMA read
   //
   // Input argument
   //     bar_table :  Pointer to the BAR sizing and
   //     setup_bar :  BAR to be used for setting up
   //                  4 Write then Read
   //     use_global_msi   :  When set, use global msi
   //     use_global_eplast:  When set, use global eplast
   //
   // Since our simplified simulation does not model configuration space registers.
   // Routines that access configuration space must be skipped. This includes,
   // dma_set_msi, 
   //
   task dma_rd_test(
		    input integer bar_table,
		    input integer setup_bar,
		    input integer use_global_msi,
		    input integer use_global_eplast,
		    input integer num_port);

      localparam integer 	  MSI_ADDRESS     = SCR_MEM-16;
      localparam integer 	  MSI_DATA        = 16'hb0fe;

      reg 			  unused_result ;
      integer 			  RCLast;

      reg [4:0] 		  msi_number          ;
      reg [2:0] 		  msi_traffic_class   ;
      reg [2:0] 		  multi_message_enable;
      integer 			  msi_address         ;

      integer 			  msi_expected_dmawr ;
      integer 			  msi_expected_dmard ;

      integer 			  msi_received ;
      integer 			  msi_count    ;
      integer 			  max_count    ;
      integer 			  i;
      reg [31:0] 		  track_rclast_loop;

      reg 			  use_msi;
      reg 			  use_eplast;

      reg [4:0] 		  msi_number_int          ;
      reg [2:0] 		  msi_traffic_class_int   ;
      reg [2:0] 		  multi_message_enable_int;

      integer 			  rd_bdt_lsb;
      integer 			  tc_class;
      
      begin

	 if (setup_bar == 2) begin
	    rd_bdt_lsb = RD_BDT_LSB;
	 end
	 else if (setup_bar == 3) begin
	    rd_bdt_lsb = RD_BDT_LSB + 16'h3000;
	 end

	 tc_class = (num_port == 1) ? TC_CLASS_P1 : TC_CLASS_P0;
	 
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_rd_test");

	 // Read descriptor table in the RC Memory
	 dma_set_rd_desc_data(bar_table, setup_bar);

	 use_msi    = use_global_msi    | (NUM_MSI_EXPECTED > 0);
	 use_eplast = use_global_eplast | (NUM_EPLAST_EXPECTED > 0);


	 // Set MSI for DMA Read
	 // Issue configuration read and write requests.
	 // Consider skip...
	 if (use_msi==1)
           dma_set_msi(   bar_table,            // Pointer to the BAR sizing and
                          setup_bar,            // BAR to be used for setting up
                          1,                    // bus_num
                          1,                    // dev_num
                          0,                    // fnc_num
                          RD_DIRECTION,         // Direction
                          MSI_ADDRESS,          // MSI RC memeory address
                          MSI_DATA,             // MSI Cfg data value
                          msi_number,           // msi_number
                          msi_traffic_class,    //msi traffic class
                          multi_message_enable, // number of msi
                          msi_expected_dmard    // expexted MSI data value
			  );

	 msi_number_int           = (use_msi == 1'b1) ? msi_number : 5'h0;
	 msi_traffic_class_int    = (use_msi == 1'b1) ? msi_number : 3'h0;
	 multi_message_enable_int = (use_msi == 1'b1) ? msi_number : 3'h0;

	 // Read Descriptor header in EP memory PRG
	 dma_set_header( bar_table,               // Pointer to the BAR sizing and
			 setup_bar,               // BAR to be used for setting up
			 NUMBER_OF_DESCRIPTORS,   // number of descriptor
			 RD_DIRECTION,            // Direction read
			 use_global_msi,          // global MSI control
			 use_global_eplast,       // global eplast control
			 RD_BDT_MSB,              // RC upper 32 bits of bdt
			 rd_bdt_lsb,              // RC lower 32 bits of bdt
			 msi_number_int,
			 msi_traffic_class_int,
			 multi_message_enable_int,
			 0,
			 num_port);

	 //Program RP RCLast
	 RCLast = NUMBER_OF_DESCRIPTORS-1; // 3 descriptor, written 0,1,2

	 // Start read DMA
	 dma_set_rclast(bar_table, setup_bar, RD_DIRECTION, RCLast);

	 fork  // polling
	    unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	    // Monitor MSI - Polling MSI
	    if (use_msi==1)
              if (use_global_msi==1)
		msi_poll(NUMBER_OF_DESCRIPTORS,MSI_ADDRESS,0, msi_expected_dmard,0,1);
              else
		msi_poll(NUM_MSI_EXPECTED,MSI_ADDRESS,0, msi_expected_dmard,0,1);


	    // Polling EP Last
	    if (use_eplast==1) begin
               if (DMA_CONTINOUS_LOOP==0)
		 rcmem_poll(rd_bdt_lsb+DT_EPLAST, RCLast,32'h0000FFFF);
               else begin
		  for (i=0;i<DMA_CONTINOUS_LOOP;i=i+1) begin
		     unused_result = ebfm_display(EBFM_MSG_INFO, { "   Running DMA loop ", dimage4(i), " : "});
		     shmem_write(rd_bdt_lsb+DT_EPLAST, 32'hCAFE_FADE,4);
		     rcmem_poll(rd_bdt_lsb+DT_EPLAST, RCLast,32'h0000FFFF);
		  end
		  shmem_write(rd_bdt_lsb+DT_EPLAST, 32'hCAFE_FADE,4);
		  dma_set_header( bar_table,              // Pointer to the BAR sizing and
				  setup_bar,               // BAR to be used for setting up
				  NUMBER_OF_DESCRIPTORS,   // number of descriptor
				  RD_DIRECTION,            // Direction read
				  use_global_msi,          // global MSI control
				  use_global_eplast,       // global eplast control
				  RD_BDT_MSB,              // RC upper 32 bits of bdt
				  rd_bdt_lsb,              // RC lower 32 bits of bdt
				  msi_number_int,
				  msi_traffic_class_int,
				  multi_message_enable_int,
				  1,
				  num_port); // stop_loop
		  track_rclast_loop[15:0] = (use_global_eplast==1'b1) ? RCLast : EPLAST_DONE_VALUE;
		  track_rclast_loop[31:16] = 1 ;
		  unused_result = ebfm_display(EBFM_MSG_INFO, "   Flushing DMA loop");
		  rcmem_poll(rd_bdt_lsb+DT_EPLAST, track_rclast_loop,32'h0001ffff);
               end
	    end

	 join  // polling

	 ebfm_barwr_imm(bar_table, setup_bar, 16, 32'h0000_FFFF, 4, tc_class);
	 
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, "Completed DMA Read");


      end

   endtask

   /////////////////////////////////////////////////////////////////////////
   //
   // TASK:dma_wr_test
   //
   // Run the chained DMA write
   //
   // Input argument
   //     bar_table :  Pointer to the BAR sizing and
   //     setup_bar :  BAR to be used for setting up
   //                  4 Write then Read
   //     use_global_msi   :  When set, use msi
   //     use_global_eplast:  When set, poll for ep last
   //
   task dma_wr_test(
		    input integer bar_table,
		    input integer setup_bar,
		    input integer use_global_msi,
		    input integer use_global_eplast,
		    input integer num_port);

      localparam integer 	  MSI_ADDRESS = SCR_MEM-16;
      localparam integer 	  MSI_DATA    = 16'hb0fe;

      reg 			  unused_result ;
      integer 			  RCLast;

      reg [4:0] 		  msi_number          ;
      reg [2:0] 		  msi_traffic_class   ;
      reg [2:0] 		  multi_message_enable;
      integer 			  msi_address         ;

      integer 			  msi_expected_dmawr ;
      integer 			  msi_expected_dmard ;

      integer 			  msi_received ;
      integer 			  msi_count    ;
      integer 			  max_count    ;
      integer 			  i    ;
      reg [31:0] 		  track_rclast_loop;

      reg 			  use_msi;
      reg 			  use_eplast;

      reg [4:0] 		  msi_number_int          ;
      reg [2:0] 		  msi_traffic_class_int   ;
      reg [2:0] 		  multi_message_enable_int;

      integer 			  wr_bdt_lsb;
      integer 			  tc_class;
      
      begin

	 if (setup_bar == 2) begin
	    wr_bdt_lsb = WR_BDT_LSB;
	 end
	 else if (setup_bar == 3) begin
	    wr_bdt_lsb = WR_BDT_LSB + 16'h3000;
	 end

	 tc_class = (num_port == 1) ? TC_CLASS_P1 : TC_CLASS_P0;
	 	 
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_wr_test");
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO,"   DMA: Write");

	 // write 'write descriptor table in the RC Memory
	 dma_set_wr_desc_data(bar_table, setup_bar);

	 use_msi    = use_global_msi    | (NUM_MSI_EXPECTED > 0);
	 use_eplast = use_global_eplast | (NUM_EPLAST_EXPECTED > 0);

	 // Set MSI for DMA Writew
	 if (use_msi==1)
           dma_set_msi( bar_table,  // Pointer to the BAR sizing and
                        setup_bar,  // BAR to be used for setting up
                        1,          // bus_num
                        1,          // dev_num
                        0,          // fnc_num
                        WR_DIRECTION,          // Direction
                        MSI_ADDRESS,// MSI RC memeory address
                        MSI_DATA,   // MSI Cfg data value
                        msi_number, // msi_number
                        msi_traffic_class, //msi traffic class
                        multi_message_enable,// number of msi
                        msi_expected_dmawr // expexted MSI data value
                        );
	 msi_number_int           = (use_msi == 1'b1) ? msi_number : 5'h0;
	 msi_traffic_class_int    = (use_msi == 1'b1) ? msi_number : 3'h0;
	 multi_message_enable_int = (use_msi == 1'b1) ? msi_number : 3'h0;

	 // Write Descriptor header in EP memory PRG
	 dma_set_header( bar_table,               // Pointer to the BAR sizing and
			 setup_bar,               // BAR to be used for setting up
			 NUMBER_OF_DESCRIPTORS,   // number of descriptor
			 WR_DIRECTION,            // Direction = Write
			 use_global_msi,          // global MSI control
			 use_global_eplast,       // global eplast control
			 WR_BDT_MSB,              // RC upper 32 bits of bdt
			 wr_bdt_lsb,              // RC lower 32 bits of bdt
			 msi_number_int,
			 msi_traffic_class_int,
			 multi_message_enable_int,
			 0,
			 num_port);

	 //Program RP RCLast
	 RCLast = NUMBER_OF_DESCRIPTORS-1;

	 // Start write DMA
	 dma_set_rclast(bar_table, setup_bar, WR_DIRECTION, RCLast);

	 fork // polling
	    unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	    // Monitor MSI - Polling MSI
	    if (use_msi==1)
              if (use_global_msi==1)
		msi_poll(NUMBER_OF_DESCRIPTORS,MSI_ADDRESS, msi_expected_dmawr,0,1,0);
              else
		msi_poll(NUM_MSI_EXPECTED,MSI_ADDRESS, msi_expected_dmawr,0,1,0);

	    if (use_eplast==1) begin
               if (DMA_CONTINOUS_LOOP==0)
		 rcmem_poll(wr_bdt_lsb+DT_EPLAST, EPLAST_DONE_VALUE,32'h0000ffff);
               else begin
		  for (i=0;i<DMA_CONTINOUS_LOOP;i=i+1) begin
		     unused_result = ebfm_display(EBFM_MSG_INFO, { "   Running DMA loop ", dimage4(i), " : "});
		     shmem_write(wr_bdt_lsb+DT_EPLAST, 32'hCAFE_FADE,4);
		     rcmem_poll(wr_bdt_lsb+DT_EPLAST, EPLAST_DONE_VALUE,32'h0000ffff);
		  end
		  shmem_write(wr_bdt_lsb+DT_EPLAST, 32'hCAFE_FADE,4);
		  dma_set_header( bar_table,               // Pointer to the BAR sizing and
				  setup_bar,               // BAR to be used for setting up
				  NUMBER_OF_DESCRIPTORS,   // number of descriptor
				  WR_DIRECTION,            // Direction = Write
				  use_global_msi,          // global MSI control
				  use_global_eplast,       // global eplast control
				  WR_BDT_MSB,              // RC upper 32 bits of bdt
				  wr_bdt_lsb,              // RC lower 32 bits of bdt
				  msi_number_int,
				  msi_traffic_class_int,
				  multi_message_enable_int,
				  1,
				  num_port);
		  track_rclast_loop[15:0] = (use_global_eplast==1'b1) ? RCLast : EPLAST_DONE_VALUE;
		  track_rclast_loop[31:16] = 1 ;
		  unused_result = ebfm_display(EBFM_MSG_INFO, "   Flushing DMA loop");
		  rcmem_poll(wr_bdt_lsb+DT_EPLAST, track_rclast_loop,32'h0001ffff);
               end
	    end

	 join // polling

	 ebfm_barwr_imm(bar_table, setup_bar, 0, 32'h0000_FFFF, 4, tc_class);
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, "Completed DMA Write");

      end

   endtask

   /////////////////////////////////////////////////////////////////////////
   //
   // TASK:chained_dma_test
   //
   //    task to run the chained DMA read/Write
   //
   // Input argument
   //     bar_table :  Pointer to the BAR sizing and
   //     setup_bar :  BAR to be used for setting up
   //     direction :  0 read,
   //                  1 write,
   //                  2 read and write simulataneous
   //                  3 Read then Write
   //                  4 Write then Read
   //
   task chained_dma_test(
			 input integer bar_table ,
			 input integer setup_bar ,
			 input integer direction ,
			 input integer use_global_msi   ,
			 input integer use_global_eplast
			 );

      reg 			       unused_result ;
      integer 			       num_port;
      
      begin

	 num_port = setup_bar - 2;
	 
	 unused_result = ebfm_display(EBFM_MSG_INFO, `STR_SEP);
	 unused_result = ebfm_display(EBFM_MSG_INFO, "TASK:chained_dma_test");
	 case (direction)
           0: begin
              unused_result = ebfm_display(EBFM_MSG_INFO,"   DMA: Read");
              dma_rd_test(bar_table, setup_bar, use_global_msi, use_global_eplast, num_port);
           end
           1: begin
              unused_result = ebfm_display(EBFM_MSG_INFO,"   DMA: Write");
              dma_wr_test(bar_table, setup_bar, use_global_msi, use_global_eplast, num_port);
           end
           default: unused_result = ebfm_display(EBFM_MSG_INFO,"   Incorrect direction");

	 endcase
      end
   endtask // chained_dma_test
   
   /*
    * SoNIC Command test routines 
    */

   function integer sonic_compute_cmd_resp (input integer n_chan);
      integer cmd_addr_lsw;
      
      cmd_addr_lsw = SCR_MEM + 512 + 512 * n_chan;
      
      return cmd_addr_lsw;
   endfunction // sonic_compute_cmd_resp

   function integer sonic_compute_irq_resp (input integer n_chan);
      integer irq_addr_lsw;
      
      irq_addr_lsw = SCR_MEM + 4096 + 512 * n_chan;
      
      return irq_addr_lsw;
   endfunction // sonic_compute_irq_resp
   
   task sonic_cmd_issue(
			input time bar_table,
			input time setup_bar,
			input time command,
			input time param0,
			input time param1,
			input time param2
			);
      reg 			   unused_result;
      integer 			   cmd_offset;
      integer 			   cmd_addr_msw;
      integer 			   cmd_addr_lsw;
      integer 			   tc_class;
      
      begin
	 cmd_offset = `SONIC_REG_CMD_DW0;	
	 cmd_addr_msw = 0;
	 cmd_addr_lsw = sonic_compute_cmd_resp (setup_bar - 2); // n_chan == n_bar - 2 

	 tc_class = (setup_bar == 3) ? TC_CLASS_P1 : TC_CLASS_P0;
	 	 
	 ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+16, cmd_addr_msw, 4, tc_class);
	 ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+20, cmd_addr_lsw, 4, tc_class);

	 case (command)
	   `SONIC_CMD_RESET,
	   `SONIC_CMD_GET_RX_OFFSET,
	   `SONIC_CMD_GET_RX_OFFSET2,
	   `SONIC_CMD_GET_RX_SIZE,
	   `SONIC_CMD_GET_RX_BLOCK_SIZE,
	   `SONIC_CMD_STOP_SFP1,
	   `SONIC_CMD_START_SFP1,
	   `SONIC_CMD_STOP_SFP2,
	   `SONIC_CMD_START_SFP2: begin
	      ebfm_barwr_imm(bar_table, setup_bar, cmd_offset, command, 4, tc_class);
	   end
	   `SONIC_CMD_CONFIG_IRQ: begin
	      ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+4, param0, 4, tc_class);
	      ebfm_barwr_imm(bar_table, setup_bar, cmd_offset, command, 4, tc_class);
	   end
	   `SONIC_CMD_SET_ADDR_IRQ: begin
	      ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+4, param0, 4, tc_class);
	      ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+8, param1, 4, tc_class);
	      ebfm_barwr_imm(bar_table, setup_bar, cmd_offset, command, 4, tc_class);
	   end
	   `SONIC_CMD_SET_RX_BLOCK_SIZE: begin
	      ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+4, param0, 4, tc_class);
	      ebfm_barwr_imm(bar_table, setup_bar, cmd_offset, command, 4, tc_class);
	   end
	   default:
	     unused_result = ebfm_display_verb(EBFM_MSG_INFO, "CMD not supported!");	
	 endcase
      end
   endtask

   task sonic_cmd_poll(
		       input time cmd_address
		       );
      reg 			  unused_result;
      time 			  cmd_received;
      begin

	 begin
	    fork
	       //set timeout failure if expected reponse not received
	       begin: timeout_cmd
		  repeat(100000) @ (posedge clk_in);
		  unused_result = ebfm_display(EBFM_MSG_INFO,
					       "cmd response timedout, Test fails");
		  disable wait_for_cmd;
	       end
	       //Polling memory for cmd response
	       begin: wait_for_cmd
		  forever begin
		     repeat (400) @ (posedge clk_in);
		     cmd_received = shmem_read(cmd_address, 8);
		     unused_result = ebfm_display(EBFM_MSG_INFO,
						  {"Task: cmd_poll	Received cmd reponse",
						   himage8(cmd_address),
						   "---> data:",
						   himage8(cmd_received),
						   "......."});
		     if (cmd_received == 32'h0) begin
			disable timeout_cmd;
			disable wait_for_cmd;
		     end
		  end
	       end
	    join
	 end
      end
   endtask


   /*
    * cmd_response_address, 
    * irq_response_address, should be separate from DMA descriptor and data.
    * 
    * cmd_response_address = 0xA00 + bar * 512
    * irq_response_address = 0x1800 + bar * 512
    * 
    * NOTE: sonic_cmd_issue computes the cmd_response_address again, make sure they are consistent.
    */

   task sonic_cmd_test (
			input time bar_table,
			input time setup_bar
			);
      time 			   cmd_response_address;

      integer 			   rc_addr_lsb;
      integer 			   rc_addr_msb;
      integer 			   rx_msi_ctrl;
      reg 			   unused_result;

      integer 			   i;
      integer 			   num_port ;
      
      begin
	 // BAR 2 for channel 0, BAR 3 for channel 1.
	 num_port = setup_bar - 2;
	 	 
	 //CMD Resp Address = SCR_MEM + 512
	 cmd_response_address = sonic_compute_cmd_resp(setup_bar - 2);
	 
	 unused_result = ebfm_display(EBFM_MSG_INFO, { "CMD_TEST: cmd_response_address 0x", himage8(cmd_response_address) } );
	 
	 //issue sonic_cmd_reset
	 shmem_write(cmd_response_address, 32'hFFFF_FFFF, 4);
	 sonic_cmd_issue (bar_table, setup_bar, `SONIC_CMD_RESET, 0, 0, 0);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);
	 sonic_cmd_poll(cmd_response_address);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);

	 // set rx block size
	 shmem_write(cmd_response_address, 32'hFFFF_FFFF, 4);
	 sonic_cmd_issue (bar_table, setup_bar, `SONIC_CMD_SET_RX_BLOCK_SIZE, 32'h400, 0, 0);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);
	 sonic_cmd_poll(cmd_response_address);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);

	 shmem_write(cmd_response_address, 32'hFFFF_FFFF, 4);
	 sonic_cmd_issue (bar_table, setup_bar, `SONIC_CMD_GET_RX_SIZE, 64, 0, 0);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);
	 sonic_cmd_poll(cmd_response_address);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);

	 // set irq data in rc memory, was SCR_MEM + 4096 = based at 0x1800.
	 // Now: SCR_MEM + 4096
	 rc_addr_lsb = sonic_compute_irq_resp(setup_bar - 2);
	 //rc_addr_msb = 1;
	 rc_addr_msb = 0;	

	 unused_result = ebfm_display(EBFM_MSG_INFO, { "CMD_TEST: rc_response_address 0x", himage8(rc_addr_msb), " " , himage8(rc_addr_lsb) } );
	 
	 sonic_cmd_issue (bar_table, setup_bar, `SONIC_CMD_SET_ADDR_IRQ, rc_addr_msb, rc_addr_lsb, 0);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);
	 sonic_cmd_poll(cmd_response_address);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);

	 rx_msi_ctrl = 0;
	 rx_msi_ctrl |= 1 << 17;	//set msi_enable

	 shmem_write(cmd_response_address, 32'hFFFF_FFFF, 4);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);
	 sonic_cmd_issue (bar_table, setup_bar, `SONIC_CMD_CONFIG_IRQ, rx_msi_ctrl, 0, 0);
	 sonic_cmd_poll(cmd_response_address);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);

	 // enable sfp1
	 shmem_write(cmd_response_address, 32'hFFFF_FFFF, 4);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);
	 sonic_cmd_issue (bar_table, setup_bar, `SONIC_CMD_START_SFP1, 0, 0, 0);
	 sonic_cmd_poll(cmd_response_address);
	 unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);

	 // msi polling for RX data.
	 
	 repeat (500) @(posedge clk_in);
	 // upon receiving msi interrupt, 
	 // setup dma transaction to read data from EP.
	 
	 // polling for DT finish.

      end
   endtask
   
   /*
    * SoNIC Receive Test:
    * XCVR BFM generates data stream xcvr_rx_datain. SoNIC application generates MSI signals.
    * Test driver should poll on MSI and fetch incoming data from it.
    * This task implements one port version.
    */
 
   task set_mem_bar;
      output sel_bar;
      integer sel_bar;
      input   n_bar;
      integer n_bar;
      
      reg     unused_result;
      
      unused_result = ebfm_display_verb(EBFM_MSG_INFO, {"set BAR to 0x", himage8(n_bar)});
      sel_bar = n_bar;
   endtask // set_mem_bar
   
   
   // purpose: Examine the DUT's BAR setup and pick a reasonable BAR to use
   task find_mem_bar;
      input bar_table;
      integer bar_table;
      input [5:0] allowed_bars;
      input 	  min_log2_size;
      integer 	  min_log2_size;
      output 	  sel_bar;
      integer 	  sel_bar;

      integer 	  cur_bar;
      reg [31:0]  bar32;
      integer 	  log2_size;
      reg 	  is_mem;
      reg 	  is_pref;
      reg 	  is_64b;
      reg 	  unused_result;
      

      begin
	 // We know what BAR to use, set them manually here.
	 cur_bar = 2;
	 sel_bar = 2;  // BAR 2 mapped to control registers.

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, {"bar table at 0x", himage8(bar_table)});
	 /*
	  // find_mem_bar
	  cur_bar = 0;
	  begin : sel_bar_loop
          while (cur_bar < 6)
          begin
          ebfm_cfg_decode_bar(bar_table, cur_bar,
          log2_size, is_mem, is_pref, is_64b);
          if ((is_mem == 1'b1) &
          (log2_size >= min_log2_size) &
          ((allowed_bars[cur_bar]) == 1'b1))
          begin
          sel_bar = cur_bar;
          disable sel_bar_loop ;
            end
          if (is_64b == 1'b1)
          begin
          cur_bar = cur_bar + 2;
            end
          else
          begin
          cur_bar = cur_bar + 1;
            end
         end
          sel_bar = 7 ; // Invalid BAR if we get this far...
      end
	  */
      end
   endtask

   // memory content checking - check data transferred for specified descriptor
   task check_dma_data;
      reg unused_result ;
      integer i;
      reg [31:0] dmaread_data;
      reg [31:0] dmawrite_data;
      integer 	 dmaread_addr;
      integer 	 dmawrite_addr;
      input [31:0] wr_desc_length;        // WR_DESC2_LENGTH
      input [31:0] rd_desc_length;        // RD_DESC2_LENGTH
      input [31:0] wr_desc_rcaddr_lsb;    // WR_DESC2_RCADDR_LSB
      input [31:0] rd_desc_rcaddr_lsb;    // RD_DESC2_RCADDR_LSB

      begin
	 if ((wr_desc_length == rd_desc_length ) || (wr_desc_length < rd_desc_length ))  begin
            unused_result = ebfm_display(EBFM_MSG_INFO, `STR_SEP);
            unused_result = ebfm_display(EBFM_MSG_INFO, "TASK:check_dma_data ");
            for (i=0;i<wr_desc_length;i=i+1) begin
               dmaread_addr  = rd_desc_rcaddr_lsb+4*i;
               dmaread_data  = shmem_read(dmaread_addr,4);
               dmawrite_addr = wr_desc_rcaddr_lsb+4*i;
               dmawrite_data = shmem_read(dmawrite_addr,4);
               if (dmaread_data != dmawrite_data) begin
		  if (DISPLAY_ALL>0) begin
                     unused_result = ebfm_display_verb(EBFM_MSG_INFO,  " DMA read BFM memory");
                     unused_result = shmem_display    (rd_desc_rcaddr_lsb, rd_desc_length*4,4, rd_desc_rcaddr_lsb+(rd_desc_length*4), EBFM_MSG_INFO);
                     unused_result = ebfm_display_verb(EBFM_MSG_INFO,  " DMA write BFM memory");
                     unused_result = shmem_display    (wr_desc_rcaddr_lsb,wr_desc_length*4,4, wr_desc_rcaddr_lsb+(wr_desc_length*4),EBFM_MSG_INFO);
		  end
		  unused_result = ebfm_display(EBFM_MSG_ERROR_FATAL,
					       {" DMA Read : Address ("   ,himage8(dmaread_addr),
						") Data ("   ,himage8(dmaread_data),
						") -------> DMA Write : Address (",himage8(dmawrite_addr),
						") Data (" ,himage8(dmawrite_data),")"});
               end
            end
            unused_result = ebfm_display(EBFM_MSG_INFO, {"  Passed : ",dimage4(wr_desc_length),
							 " identical dwords."});
	 end
      end
   endtask


   task scr_memory_compare(
			   input integer byte_length,     // downstream wr/rd length in byte
			   input integer scr_memorya,     //
			   input integer scr_memoryb);     //
      integer 				 i;
      reg [7:0] 			 bytea;
      reg [7:0] 			 byteb;
      reg [31:0] 			 addra;
      reg [31:0] 			 addrb;
      reg 				 unused_result ;

      begin

	 //unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:scr_memory_compare");
	 addra = scr_memorya;
	 addrb = scr_memoryb;

	 for (i=0;i<byte_length;i=i+1) begin
            bytea=shmem_read(addra,1);
            byteb=shmem_read(addrb,1);
            addra=addra+1;
            addrb=addrb+1;
            if (bytea!=byteb) begin

               unused_result = ebfm_display_verb(EBFM_MSG_INFO, "Content of the RC memory A");
               unused_result =shmem_display(scr_memorya,byte_length,4,scr_memorya+byte_length,EBFM_MSG_INFO);
               unused_result = ebfm_display_verb(EBFM_MSG_INFO, "Content of the RC memory B");
               unused_result =shmem_display(scr_memoryb,byte_length,4,scr_memoryb+byte_length,EBFM_MSG_INFO);

               unused_result = ebfm_display(EBFM_MSG_INFO,
					    {" A: 0x", himage8(addra), ": ",himage8(bytea)});
               unused_result = ebfm_display(EBFM_MSG_INFO,
					    {" B: 0x", himage8(addrb), ": ",himage8(byteb)});
               unused_result = ebfm_display(EBFM_MSG_ERROR_FATAL, {"Different memory content for ",
								   dimage4(byte_length), " bytes test"});
            end
	 end

	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, {"Passed: ",dimage4(byte_length),
							   " same bytes in BFM mem addr 0x", himage8(scr_memorya),
							   " and 0x", himage8(scr_memoryb)});

      end
   endtask
   task downstream_loop(
			input integer bar_table,       // Pointer to the BAR sizing and
			input integer setup_bar,       // Pointer to the BAR sizing and
			input  integer loop,           // Number of Write/read iteration
			input integer byte_length,     // downstream wr/rd length in byte
			input integer epmem_address,   // Downstream EP memory address in byte
			input  [63:0] start_val);      // Starting write data value

      reg 			      unused_result ;
      reg [63:0] 		      Istart_val;
      reg [31:0] 		      Iepmem_address;
      integer 			      i;
      reg [31:0] 		      Ibyte_length;

      reg [31:0] 		      cfg_reg ;
      reg [31:0] 		      cfg_maxpload_byte ;
      reg [7:0] 		      avalon_waddr ;
      reg [31:0] 		      avalon_waddr_qw_max;
      reg [31:0] 		      avalon_waddr_qw_min;
      reg [31:0] 		      cfg_dw1 ;


      begin
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
	 unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:downstream_loop ");


	 cfg_maxpload_byte = 0;
	 // Retrieve Device cfg from RC Slave
	 // Set EP MWr mode

	 cfg_reg = 32'h0;

	 case (cfg_reg[7:5])
           3'b000 :cfg_maxpload_byte[12:7 ] = 6'b000001;// 128B
           3'b001 :cfg_maxpload_byte[12:7 ] = 6'b000010;// 256B
           3'b010 :cfg_maxpload_byte[12:7 ] = 6'b000100;// 512B
           3'b011 :cfg_maxpload_byte[12:7 ] = 6'b001000;// 1024B
           3'b100 :cfg_maxpload_byte[12:7 ] = 6'b010000;// 2048B
           default:cfg_maxpload_byte[12:7 ] = 6'b100000;// 4096B
	 endcase

	 Ibyte_length = ((byte_length>cfg_maxpload_byte)||
                         (byte_length<4))?4:byte_length;
	 Istart_val   = start_val;
	 for (i=0;i<loop;i=i+1) begin
            downstream_write( bar_table,
                              setup_bar,
                              epmem_address,
                              Istart_val,
                              Ibyte_length);
            downstream_read ( bar_table,
                              setup_bar,
                              epmem_address,
                              Ibyte_length);
            scr_memory_compare(Ibyte_length,
                               SCR_MEM_DOWNSTREAM_WR,
                               SCR_MEM_DOWNSTREAM_RD);
            Istart_val   = Istart_val+cfg_maxpload_byte;
            Ibyte_length = ((Ibyte_length>cfg_maxpload_byte-4)||
                            (Ibyte_length<4))?4:Ibyte_length+4;
	 end
      end
   endtask

   /////////////////////////////////////////////////////////////////////////
   //
   // TASK:downstream_write
   // Prior to run DMA test, this task clears the performance counters
   //
   task downstream_write(
			 input integer bar_table,          // Pointer to the BAR sizing and
			 input integer setup_bar,          // Pointer to the BAR sizing and
			 input integer address,            // Downstream EP memeory address in byte
			 input [63:0] data,
			 input integer byte_length);      // BAR to be used for setting up

      reg 			       unused_result ;

      begin

	 // Write a data
	 shmem_fill(SCR_MEM_DOWNSTREAM_WR,SHMEM_FILL_QWORD_INC,byte_length,data);
	 ebfm_barwr(bar_table,setup_bar,address,SCR_MEM_DOWNSTREAM_WR,byte_length,0);

      end

   endtask

   /////////////////////////////////////////////////////////////////////////
   //
   // TASK:downstream_read
   // Prior to run DMA test, this task clears the performance counters
   //
   task downstream_read(
			input integer bar_table,          // Pointer to the BAR sizing and
			input integer setup_bar,          // Pointer to the BAR sizing and
			input integer address,            // Downstream EP memeory address in byte
			input integer byte_length);      // BAR to be used for setting up

      reg 			      unused_result ;
      begin
	 // read a data
	 shmem_fill(SCR_MEM_DOWNSTREAM_RD,SHMEM_FILL_QWORD_INC,byte_length,64'hFADE_FADE_FADE_FADE);
	 ebfm_barrd_wait(bar_table,setup_bar,address,SCR_MEM_DOWNSTREAM_RD,byte_length,0);
      end

   endtask // downstream_read

   task config_ep;
      reg     unused_result;
      reg     addr_map_4GB_limit;
      // Setup the Root Port and Endpoint Configuration Spaces
      addr_map_4GB_limit = 1'b0;
      unused_result = ebfm_display_verb(EBFM_MSG_WARNING,
					"----> Starting ebfm_cfg_rp_ep task 0");
      ebfm_cfg_rp_ep(
                     BAR_TABLE_POINTER,         // BAR Size/Address info for Endpoint
                     1,                 // Bus Number for Endpoint Under Test
                     1,                 // Device Number for Endpoint Under Test
                     512,               // Maximum Read Request Size for Root Port
                     1,                 // Display EP Config Space after setup
                     addr_map_4GB_limit // Limit the BAR assignments to 4GB address map
                     );
//      activity_toggle <= ~activity_toggle ;

   endtask // config_ep
   
   /*
    * Simple Sequential Test
    */
   task simple_sequential_test;

      // If you want to relocate the bar_table, modify the BAR_TABLE_POINTER in altpcietb_bfm_shmem.
      // Directly modifying the bar_table at this location may disable overwrite protection for the bar_table
      // If the bar_table is overwritten incorrectly, this will break the testbench functionality.
      parameter bar_table = BAR_TABLE_POINTER; // Default BAR_TABLE_SIZE is 64 bytes
      integer tgt_bar;
      integer dma_bar, rc_slave_bar;
      reg     addr_map_4GB_limit;
      reg     unused_result ;
      reg [15:0] msi_control_register;

      // This constant defines where we save the sizes and programmed addresses
      // of the Endpoint Device Under Test BARs
      // tgt_bar indicates which bar to use for testing the target memory of the
      // reference design.

      // Setup the Root Port and Endpoint Configuration Spaces
      addr_map_4GB_limit = 1'b0;
      unused_result = ebfm_display_verb(EBFM_MSG_WARNING,
					"----> Starting test");
      
      //find_mem_bar(bar_table, 6'b001100, 8, dma_bar);
      // BAR was set via physical address that ebfm_memwr write to.
      // Since we did not configure the BAR, we don't have the phy_addr.
      set_mem_bar(dma_bar, 2);  
      
      display_fake_bar();
      
      #3000; //wait 30000ns for link training to be done.
      
      if ((dma_bar < 6) && (USE_CDMA>0)) begin
         chained_dma_test(bar_table, dma_bar,0,0,0);  // Read  DMA
         //time_stamp = $time ;
         chained_dma_test(bar_table, dma_bar,1,0,0);  // Write DMA

	 //set_mem_bar(dma_bar, 3);

         //time_stamp = $time ;
         chained_dma_test(bar_table, dma_bar,0,0,0);  // Read  DMA
         //time_stamp = $time ;
         chained_dma_test(bar_table, dma_bar,1,0,0);  // Write DMA

	 sonic_cmd_test(bar_table, 3);
	 sonic_cmd_test(bar_table, 2);
	 
	 // sonic_rx_test
	 
	 // sonic_tx_test
	 
      end
      else if (USE_CDMA>0)
        unused_result = ebfm_display_verb(EBFM_MSG_WARNING,
					  "Unable to find a 256B BAR to setup the chaining DMA DUT; skipping test.");

   endtask // simple_sequential_test

   task display_fake_bar ;
      integer nbar;
      integer dummy;
      integer bar_lsb[0:6];
      reg [63:0] bars [0:6];
      reg [63:0] bars_xhdl;
      
      bar_lsb[0] = 28;
      bar_lsb[1] = 0;
      bar_lsb[2] = 18;
      bar_lsb[3] = 18;
      bar_lsb[4] = 28;
      bar_lsb[5] = 0;
      bar_lsb[6] = 64;
      
      // Now put all of the BARs back in memory
      nbar = 0;
      dummy = ebfm_display(EBFM_MSG_INFO, "");
      dummy = ebfm_display(EBFM_MSG_INFO, "BAR Address Assignments:");
      dummy = ebfm_display(EBFM_MSG_INFO, {"BAR   ", " ", "Size      ", " ", "Assigned Address ", " ", "Type"});
      dummy = ebfm_display(EBFM_MSG_INFO, {"---   ", " ", "----      ", " ", "---------------- ", " "});

      nbar = 0;
      while (nbar < 7)
        begin
	   bars[nbar] = shmem_read((BAR_TABLE_POINTER + (nbar * 4)), 8);
           begin
              // Show the user what we have done
              describe_bar(nbar, bar_lsb[nbar], bars[nbar],1'b0) ;
           end
	   nbar++;
	end
      
   endtask // display_fake_bar

   
//class dma_thread;
   integer bar_table;
   integer n_chan; // either zero or one.
   integer n_bar;
   integer rw;
   string  description;
   
   function new (integer bar_table, integer n_chan, integer rw);
      this.description = (rw == 0) ? "read" : "write";
      this.rw = rw;
      this.bar_table = bar_table;
      this.n_chan = n_chan;
      this.n_bar = n_chan + 2;
      $display("created %s thread %d.", this.description, n_chan);
   endfunction // new
   
   task run;
      #($urandom_range(0, 10000)); // wait for some random time.
      repeat (1) begin
	 $display("%s dma test started at bar %d ...", this.description, this.n_bar);
	 chained_dma_test(bar_table, this.n_bar, this.rw, 0, 0);
	 $display("%s dma test finished at bar %d ...", this.description, this.n_bar);
      end
   endtask; // run

   
endclass // dma_thread
   
   reg activity_toggle;
   reg timer_toggle ;
   time time_stamp ;

   dma_thread config_thread;
   
   dma_thread rd_thread_p0;
   dma_thread wr_thread_p0;
   dma_thread rd_thread_p1;
   dma_thread wr_thread_p1;
   
   /*
    * Two threads, one for dma rd, the other for dma wr.
    */
   task concurrent_chan_zero_test;
      #3000; //wait 3ns for system to finish reset.
      fork
	 rd_thread_p0.run;
	 wr_thread_p0.run;
      join
   endtask // concurr_dma

   task concurrent_chan_one_test;
      #3000; //wait 3ns for system to finish reset.
      fork 
	 rd_thread_p1.run;
	 wr_thread_p1.run;
      join
   endtask // concurrent_chan_one_test

   task mix_ports;
      #3000;
      fork
	 rd_thread_p1.run;
	 wr_thread_p0.run;
      join
   endtask // mix_ports

   task mix_read_ports;
      #3000;
      fork
	 rd_thread_p1.run;
	 rd_thread_p0.run;
      join
   endtask // mix_read_ports

   task mix_write_ports;
      #3000;
         fork
	 wr_thread_p0.run;
	 wr_thread_p1.run;
      join
   endtask // mix_write_ports
      
   task mix_one_and_half_ports;
      #3000;
      fork
	 rd_thread_p0.run;
	 wr_thread_p0.run;
	 rd_thread_p1.run;
      join
   endtask // mix_one_and_half_ports
      
   task concurrent_two_ports;
      #3000;
      fork
	 rd_thread_p1.run;
	 rd_thread_p0.run;
	 wr_thread_p1.run;
	 wr_thread_p0.run;
      join
   endtask // dma_two_port_test
   

   ///////////////////////////////////////////////////////////////////////////////
   //
   //
   // Main Program
   //
   // Start of the test bench driver altpcietb_bfm_driver
   //
   localparam TIMEOUT = 2000000000;
   integer    in;
   integer    i;
   reg [7:0]  mem;
   reg 	      unused_result;
   
   initial
     begin
	sem = new(1); // only 1 threads allowed in critical section.
	
        time_stamp = $time ;
        activity_toggle = 1'b0;
        timer_toggle    = 1'b0;
	/*
	 in = $fopen("list.log", "r");
	 for (i = 1; i < 64; i++) begin
	 $fscanf(in, "%h", mem);
	 shmem_write(BAR_TABLE_POINTER + i - 1, mem, 1);
	end
	 */
	rd_thread_p0 = new (BAR_TABLE_POINTER, 0, 0);  // zero for read
	wr_thread_p0 = new (BAR_TABLE_POINTER, 0, 1);  // one for write
	rd_thread_p1 = new (BAR_TABLE_POINTER, 1, 0);  // zero for read
	wr_thread_p1 = new (BAR_TABLE_POINTER, 1, 1);  // one for write

	config_thread = new (BAR_TABLE_POINTER, 0, 0);
		
     end

   // behavioral
   always
     begin : main

	config_thread.config_ep();
	
//	config_thread.simple_sequential_test();
	
	config_thread.sonic_cmd_test(BAR_TABLE_POINTER, 2);
	config_thread.sonic_cmd_test(BAR_TABLE_POINTER, 3);

	//concurrent_chan_zero_test();
	//concurrent_chan_one_test();
	//mix_ports();
	rd_thread_p0.run;
	 
	//We still have problems with mixed two read threads together.
	//mix_write_ports();
	//mix_read_ports();
	
	//mix_one_and_half_ports();
	//concurrent_two_ports();

	unused_result = ebfm_log_stop_sim(1);
     end
   
   always
     begin
        #(TIMEOUT)
        timer_toggle <= ! timer_toggle ;
     end

   // purpose: this is a watchdog timer, if it sees no activity on the activity
   // toggle signal for 200 us it ends the simulation
   always @(activity_toggle or timer_toggle)
     begin : watchdog
        reg unused_result ;

        if ( ($time - time_stamp) >= TIMEOUT)
          begin
             unused_result = ebfm_display(EBFM_MSG_ERROR_FATAL, "Simulation stopped due to inactivity!");
          end
        time_stamp <= $time ;
     end

endmodule
