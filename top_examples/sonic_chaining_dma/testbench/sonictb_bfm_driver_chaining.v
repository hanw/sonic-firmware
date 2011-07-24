// /**
//  * This Verilog HDL file is used for simulation in
//  * the chained DMA design example.
//  */
`timescale 1 ps / 1 ps

`include "sonic_constants.sv"
//-----------------------------------------------------------------------------
// Title         : PCI Express BFM Root Port Driver for the chained DMA
//                 design example
// Project       : PCI Express MegaCore function
//-----------------------------------------------------------------------------
// File          : sonictb_bfm_driver.v
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
// Copyright ??? 2009 Altera Corporation. All rights reserved.  Altera products are
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
   localparam DISPLAY_ALL           = 1;
   localparam NUMBER_OF_DESCRIPTORS = 3;
   localparam SCR_MEM               = 2048;  // Share memory base address used by DMA
   //localparam SCR_MEM               = 64'h0000_0001_0000_0000;  // Share memory base address used by DMA
   localparam SCR_MEMSLAVE          = 64;    // Share memory base address used by RC Slave module
   localparam SCR_MEM_DOWNSTREAM_WR = SCR_MEMSLAVE;
   localparam SCR_MEM_DOWNSTREAM_RD = SCR_MEMSLAVE+2048;
   localparam MAX_RCPAYLOAD         = 128;
   localparam RCSLAVE_MAXLEN = 10;  // maximum number of read/write

   localparam TIMEOUT_POLLING       = 2048;  // number of clock' for timout
   localparam USE_CDMA              = 1;     // When set enable EP upstream MRd/MWr
                                             // using the chaining DMA module


   // Descriptor Table Parameters
   localparam DT_EPLAST = 4'hc;
   localparam MEM_DESCR_LENGTH_INC = 2;
   localparam DMA_CONTINOUS_LOOP = 0;

   // Write DMA DESCRIPTOR TABLE Content
   localparam time WR_DIRECTION        = 1;
   localparam time WR_DESCRIPTOR_DEPTH = 4;        // 4 DWORDS
   localparam time WR_BDT_LSB          = SCR_MEM;
   localparam time WR_BDT_MSB          = 0;
   localparam time WR_FIRST_DESCRIPTOR = WR_BDT_LSB+16;

   localparam time WR_DESC0_CTL_MSI      = 0;
   localparam time WR_DESC0_CTL_EPLAST   = 1;      // send EPLast update when done with this descriptor
   localparam time WR_DESC0_LENGTH       = 82;
   localparam time WR_DESC0_EPADDR       = 3;
   localparam time WR_DESC0_RCADDR_MSB   = 1;
   localparam time WR_DESC0_RCADDR_LSB   = WR_BDT_LSB+4096;
   localparam time WR_DESC0_INIT_BFM_MEM = 64'h0000_0000_1515_0001;

   localparam time WR_DESC1_CTL_MSI      = 0;
   localparam time WR_DESC1_CTL_EPLAST   = 0;
   localparam time WR_DESC1_LENGTH       = 1024;
   localparam time WR_DESC1_EPADDR       = 0;
   localparam time WR_DESC1_RCADDR_MSB   = 1;
   localparam time WR_DESC1_RCADDR_LSB   = WR_BDT_LSB+8192;
   localparam time WR_DESC1_INIT_BFM_MEM = 64'h0000_0000_2525_0001;

   localparam time WR_DESC2_CTL_MSI      = 1;     // send MSI when done with this descriptor
   localparam time WR_DESC2_CTL_EPLAST   = 1;     // send EPLast update when done with this descriptor
   localparam time WR_DESC2_LENGTH       = 644;
   localparam time WR_DESC2_EPADDR       = 0;
   localparam time WR_DESC2_RCADDR_MSB   = 1;
   localparam time WR_DESC2_RCADDR_LSB   = WR_BDT_LSB+20384;
   localparam time WR_DESC2_INIT_BFM_MEM = 64'h0000_0000_3535_0001;


   // READ DMA DESCRIPTOR TABLE Content
   localparam time RD_DIRECTION        = 0;
   localparam time RD_DESCRIPTOR_DEPTH = 4;
   localparam time RD_BDT_LSB          = SCR_MEM+256;
   localparam time RD_BDT_MSB          = 0;
   localparam time RD_FIRST_DESCRIPTOR = RD_BDT_LSB+16;

   localparam time RD_DESC0_CTL_MSI      = WR_DESC0_CTL_MSI;
   localparam time RD_DESC0_CTL_EPLAST   = WR_DESC0_CTL_EPLAST;
   localparam time RD_DESC0_LENGTH       = 4096;	//Number of words
   localparam time RD_DESC0_EPADDR       = 0;
   localparam time RD_DESC0_RCADDR_MSB   = 1;
   localparam time RD_DESC0_RCADDR_LSB   = RD_BDT_LSB+34032;
   localparam time RD_DESC0_INIT_BFM_MEM = 64'h0000_0000_AAA0_0001;

   localparam time RD_DESC1_CTL_MSI      = WR_DESC1_CTL_MSI;
   localparam time RD_DESC1_CTL_EPLAST   = WR_DESC1_CTL_EPLAST;
   localparam time RD_DESC1_LENGTH       = 4096;	//Number of words
   localparam time RD_DESC1_EPADDR       = 4096;
   localparam time RD_DESC1_RCADDR_MSB   = 1;
   localparam time RD_DESC1_RCADDR_LSB   = RD_BDT_LSB+65536;
   localparam time RD_DESC1_INIT_BFM_MEM = 64'h0000_0000_BBBB_0001;

   localparam time RD_DESC2_CTL_MSI      = WR_DESC2_CTL_MSI;
   localparam time RD_DESC2_CTL_EPLAST   = WR_DESC2_CTL_EPLAST;
   localparam time RD_DESC2_LENGTH       = 4096;	//Number of words.
   localparam time RD_DESC2_EPADDR       = 0;
   localparam time RD_DESC2_RCADDR_MSB   = 1;
   localparam time RD_DESC2_RCADDR_LSB   = RD_BDT_LSB+132592;
   localparam time RD_DESC2_INIT_BFM_MEM = 64'h0000_0000_CCCC_0001;

   integer debug_counter      = 1;

   // Information used by driver for polling Chaining DMA status for completion.
   // These must correspond to the _DESCx_CTL_MSI and _DESCx_CTL_EPLAST parameters above.

   localparam EPLAST_DONE_VALUE   = 2;                                                                  // The EPLast Number that the driver expects to receive from each DMA after all data transfers have completed
   localparam NUM_EPLAST_EXPECTED = WR_DESC0_CTL_EPLAST + WR_DESC1_CTL_EPLAST + WR_DESC2_CTL_EPLAST;    // Number of Descriptors programmed to send EPLAST status update to root port
   localparam NUM_MSI_EXPECTED    = WR_DESC0_CTL_MSI + WR_DESC1_CTL_MSI + WR_DESC2_CTL_MSI;             // Number of MSI's that the driver expects to receive from each DMA after all data transfers have completed


   localparam DEBUG_PRG = 0;

   `include "altpcietb_bfm_constants.v"
   `include "altpcietb_bfm_log.v"
   `include "altpcietb_bfm_shmem.v"
   `include "altpcietb_bfm_rdwr.v"
   `include "altpcietb_bfm_configure.v"

   // The clk_in and rstn signals are provided for possible use in controlling
   // the transactions issued, they are not currently used.

// ebfm_display_verb
// overload ebfm_display by turning on/off verbose when DISPLAY_ALL>0
function ebfm_display_verb(
   input time msg_type,
   input [EBFM_MSG_MAX_LEN*8:1] message);
   reg unused_result;
   begin
      if (DISPLAY_ALL==1)
         unused_result = ebfm_display(msg_type, message);
      ebfm_display_verb = 1'b0 ;
   end
endfunction

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
   input time bar_table    ,
   input time setup_bar    ,
   input time bus_num      ,
   input time dev_num      ,
   input time fnc_num      ,
   input time dt_direction ,
   input time msi_address  ,
   input time msi_data     ,

   output reg [4:0] msi_number       ,
   output reg [2:0] msi_traffic_class,
   output reg [2:0] multi_message_enable,
   output time msi_expected
   );

   localparam msi_capabilities  = 32'h50;
   // The Root Complex BFM has 2MB of address space
   localparam msi_upper_address = 32'h0000_0000;

   reg [15:0] msi_control_register;
   reg        msi_64b_capable;
   reg [2:0]  multi_message_capable;
   reg        msi_enable;
   reg [2:0]  compl_status;
   reg unused_result ;

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
            debug_counter = 3;
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


//   unused_result =shmem_display(0,16'h1000,4,0,EBFM_MSG_INFO);
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
   input time bar_table    , // Pointer to the BAR sizing and
   input time setup_bar    , // BAR to be used for setting up
   input time dt_size      , // total number of descriptors in the descriptor table
   input time dt_direction , // Specifies which descriptor table to set up:  DMA Read or write
   input time dt_msi       , // control bit which specifies to use MSI for all descriptors
   input time dt_eplast    , // control bit which specifies to use EPLast for all descriptors
   input time dt_bdt_msb   , // upper 32 bits base address of the descriptor table location in Root Port memory space
   input time dt_bdt_lsb   ,  //lower 32 bits base address of the descriptor table location in Root Port memory space

   input [4:0] msi_number       ,    // MSI
   input [2:0] msi_traffic_class,    // MSI
   input [2:0] multi_message_enable, // MSI
   input stop_dma_loop
   );

   reg [31:0] dt_dw0;
   time dt_dw1,dt_dw2 ;
   time ep_offset ;
   reg unused_result ;

   begin

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
         ebfm_barwr_imm(bar_table, setup_bar, 0+ep_offset, dt_dw0, 4, 0);
         ebfm_barwr_imm(bar_table, setup_bar, 4+ep_offset, dt_dw1, 4, 0);
         ebfm_barwr_imm(bar_table, setup_bar, 8+ep_offset, dt_dw2, 4, 0);
      end
      else begin
         ebfm_barwr_imm(bar_table, setup_bar, 0+ep_offset, 32'hC1FE_FADE, 4, 0);
         ebfm_barwr_imm(bar_table, setup_bar, 4+ep_offset, 32'hC2FE_FADE, 4, 0);
         ebfm_barwr_imm(bar_table, setup_bar, 8+ep_offset, 32'hC3FE_FADE, 4, 0);
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

	  debug_counter = 2;
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
   input time bar_table    ,
   input time setup_bar    ,
   input time dt_direction ,
   input time dt_rclast
   );

   reg [31:0] dt_dw4 ;
   time ep_offset ;
   reg unused_result ;

   begin

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
      ebfm_barwr_imm(bar_table, setup_bar, 12+ep_offset, dt_dw4, 4, 0);
      debug_counter = 4;
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
   input time bar_table    ,
   input time setup_bar
   );

   reg unused_result ;
   time descriptor_addr,i;

   time loop_DW0;
   time loop_DW1;
   time loop_DW2;
   time loop_DW3;
   time loop_control_field;

   begin

      //program BFM share memeory
      unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
      unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_set_wr_desc_data");
      // First Descriptor
      descriptor_addr = WR_FIRST_DESCRIPTOR;
      loop_control_field = ((2**17) * WR_DESC0_CTL_EPLAST) + ((2**16) * WR_DESC0_CTL_MSI);   // Assemble Descriptor Control Field
      shmem_write(descriptor_addr  ,  (loop_control_field + WR_DESC0_LENGTH)     ,4);
      shmem_write(descriptor_addr+4,  WR_DESC0_EPADDR     ,4);
      shmem_write(descriptor_addr+8,  WR_DESC0_RCADDR_MSB ,4);
      shmem_write(descriptor_addr+12, WR_DESC0_RCADDR_LSB ,4);
      shmem_fill(WR_DESC0_RCADDR_LSB,SHMEM_FILL_DWORD_INC,
                 WR_DESC0_LENGTH*4,WR_DESC0_INIT_BFM_MEM);
      // Display descriptor table of DMA Write
      if (NUMBER_OF_DESCRIPTORS>3)
      begin
         for (i=1;i<NUMBER_OF_DESCRIPTORS-1;i=i+1)
         begin
            descriptor_addr = WR_FIRST_DESCRIPTOR + 16*i;
            loop_control_field = ((2**17) * WR_DESC1_CTL_EPLAST) + ((2**16) * WR_DESC1_CTL_MSI);   // Assemble Descriptor Control Field
            loop_DW0        = loop_control_field + WR_DESC1_LENGTH + i*MEM_DESCR_LENGTH_INC;
            loop_DW1        = WR_DESC1_EPADDR ;
            loop_DW2        = WR_DESC1_RCADDR_MSB;
            loop_DW3        = WR_DESC1_RCADDR_LSB;
            shmem_write(descriptor_addr  ,  loop_DW0 ,4);
            shmem_write(descriptor_addr+4,  loop_DW1 ,4);
            shmem_write(descriptor_addr+8,  loop_DW2 ,4);
            shmem_write(descriptor_addr+12, loop_DW3 ,4);
            if (i==1)
               shmem_fill(WR_DESC1_RCADDR_LSB,SHMEM_FILL_DWORD_INC, loop_DW0*4,
                       WR_DESC1_INIT_BFM_MEM);
         end
         i = NUMBER_OF_DESCRIPTORS-2;
      end
      else
      begin
         i = 1;
         // Descriptor 1
         descriptor_addr = WR_FIRST_DESCRIPTOR+16;
         loop_control_field = ((2**17) * WR_DESC1_CTL_EPLAST) + ((2**16) * WR_DESC1_CTL_MSI);   // Assemble Descriptor Control Field
         shmem_write(descriptor_addr  ,  loop_control_field + WR_DESC1_LENGTH     ,4);
         shmem_write(descriptor_addr+4,  WR_DESC1_EPADDR     ,4);
         shmem_write(descriptor_addr+8,  WR_DESC1_RCADDR_MSB ,4);
         shmem_write(descriptor_addr+12, WR_DESC1_RCADDR_LSB ,4);
         shmem_fill(WR_DESC1_RCADDR_LSB,SHMEM_FILL_DWORD_INC,
                 WR_DESC1_LENGTH*4,WR_DESC1_INIT_BFM_MEM);
      end

      // Last Descriptor
      descriptor_addr = WR_FIRST_DESCRIPTOR+16*(i+1);
      loop_control_field = ((2**17) * WR_DESC2_CTL_EPLAST) + ((2**16) * WR_DESC2_CTL_MSI);   // Assemble Descriptor Control Field
      shmem_write(descriptor_addr  ,  loop_control_field + WR_DESC2_LENGTH     ,4);
      shmem_write(descriptor_addr+4,  WR_DESC2_EPADDR     ,4);
      shmem_write(descriptor_addr+8,  WR_DESC2_RCADDR_MSB ,4);
      shmem_write(descriptor_addr+12, WR_DESC2_RCADDR_LSB ,4);
      shmem_fill(WR_DESC2_RCADDR_LSB,SHMEM_FILL_DWORD_INC,
                 WR_DESC2_LENGTH*4,WR_DESC2_INIT_BFM_MEM);

      unused_result =shmem_display(0,16'h1000,4,0,EBFM_MSG_INFO);
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
   input time bar_table,
   input time setup_bar
   );
   // HEADER PARAMETERS

   reg unused_result ;
   time descriptor_addr,i;

   time loop_DW0;
   time loop_DW1;
   time loop_DW2;
   time loop_DW3;
   time loop_control_field;

   begin

      unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
      unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_set_rd_desc_data");

      //program BFM share memory :

      // First Descriptor
      descriptor_addr = RD_FIRST_DESCRIPTOR;
      loop_control_field = ((2**17) * RD_DESC0_CTL_EPLAST) + ((2**16) * RD_DESC0_CTL_MSI);   // Assemble Descriptor Control Field
      shmem_write(descriptor_addr  ,  loop_control_field + RD_DESC0_LENGTH     ,4);
      shmem_write(descriptor_addr+4,  RD_DESC0_EPADDR     ,4);
      shmem_write(descriptor_addr+8,  RD_DESC0_RCADDR_MSB ,4);
      shmem_write(descriptor_addr+12, RD_DESC0_RCADDR_LSB ,4);
      shmem_fill(RD_DESC0_RCADDR_LSB,SHMEM_FILL_DWORD_INC,RD_DESC0_LENGTH*4,
                 RD_DESC0_INIT_BFM_MEM);

      if (NUMBER_OF_DESCRIPTORS>3)
      begin
         for (i=1;i<NUMBER_OF_DESCRIPTORS-1;i=i+1)
         begin
            descriptor_addr = RD_FIRST_DESCRIPTOR + 16*i;
            loop_control_field = ((2**17) * RD_DESC1_CTL_EPLAST) + ((2**16) * RD_DESC1_CTL_MSI);   // Assemble Descriptor Control Field
            loop_DW0        = loop_control_field + RD_DESC1_LENGTH + i*MEM_DESCR_LENGTH_INC;
            loop_DW1        = RD_DESC1_EPADDR ;
            loop_DW2        = RD_DESC1_RCADDR_MSB;
            loop_DW3        = RD_DESC1_RCADDR_LSB;
            shmem_write(descriptor_addr  ,  loop_DW0 ,4);
            shmem_write(descriptor_addr+4,  loop_DW1 ,4);
            shmem_write(descriptor_addr+8,  loop_DW2 ,4);
            shmem_write(descriptor_addr+12, loop_DW3 ,4);
            if (i==1)
               shmem_fill(RD_DESC1_RCADDR_LSB,SHMEM_FILL_DWORD_INC, loop_DW0*4,
                              RD_DESC1_INIT_BFM_MEM);
         end
         i = NUMBER_OF_DESCRIPTORS-2;
      end
      else
      begin
         // Descriptor 1
         i = 1;
         descriptor_addr = RD_FIRST_DESCRIPTOR+16;
         loop_control_field = ((2**17) * RD_DESC1_CTL_EPLAST) + ((2**16) * RD_DESC1_CTL_MSI);   // Assemble Descriptor Control Field
         shmem_write(descriptor_addr  ,  loop_control_field + RD_DESC1_LENGTH     ,4);
         shmem_write(descriptor_addr+4,  RD_DESC1_EPADDR     ,4);
         shmem_write(descriptor_addr+8,  RD_DESC1_RCADDR_MSB ,4);
         shmem_write(descriptor_addr+12, RD_DESC1_RCADDR_LSB ,4);
         shmem_fill(RD_DESC1_RCADDR_LSB, SHMEM_FILL_DWORD_INC,
                 RD_DESC1_LENGTH*4,RD_DESC1_INIT_BFM_MEM);
      end

      // Last Descriptor
      descriptor_addr = RD_FIRST_DESCRIPTOR+16*(i+1);
      loop_control_field = ((2**17) * RD_DESC2_CTL_EPLAST) + ((2**16) * RD_DESC2_CTL_MSI);   // Assemble Descriptor Control Field
      shmem_write(descriptor_addr  ,  loop_control_field + RD_DESC2_LENGTH     ,4);
      shmem_write(descriptor_addr+4,  RD_DESC2_EPADDR     ,4);
      shmem_write(descriptor_addr+8,  RD_DESC2_RCADDR_MSB ,4);
      shmem_write(descriptor_addr+12, RD_DESC2_RCADDR_LSB ,4);
      shmem_fill(RD_DESC2_RCADDR_LSB,SHMEM_FILL_DWORD_INC,
                 RD_DESC2_LENGTH*4,RD_DESC2_INIT_BFM_MEM);

      unused_result =shmem_display(0,16'h1000,4,0,EBFM_MSG_INFO);
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
   input time max_number_of_msi,
   input time msi_address,
   input time msi_expected_dmawr,
   input time msi_expected_dmard,
   input time dma_write,
   input time dma_read
   );

   reg unused_result ;
   time msi_received;
   time msi_count;
   reg pol_ip;

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
				  debug_counter = 12;
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
   input time rc_addr,
   input time rc_data,
   input time rc_data_mask);

   reg unused_result ;
   time rc_current;
   time rc_last;
   reg [31:0] timout_limit;
   reg pol_ip;

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
               debug_counter = 14;
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
task dma_rd_test(
   input time bar_table,
   input time setup_bar,
   input time use_global_msi,
   input time use_global_eplast);

   localparam time MSI_ADDRESS     = SCR_MEM-16;
   localparam time MSI_DATA        = 16'hb0fe;

   reg unused_result ;
   time RCLast;

   reg [4:0] msi_number          ;
   reg [2:0] msi_traffic_class   ;
   reg [2:0] multi_message_enable;
   time   msi_address         ;

   time   msi_expected_dmawr ;
   time   msi_expected_dmard ;

   time msi_received ;
   time msi_count    ;
   time max_count    ;
   time i;
   reg [31:0] track_rclast_loop;

   reg     use_msi;
   reg     use_eplast;

   reg [4:0] msi_number_int          ;
   reg [2:0] msi_traffic_class_int   ;
   reg [2:0] multi_message_enable_int;

   begin

      unused_result = ebfm_display_verb(EBFM_MSG_INFO, `STR_SEP);
      unused_result = ebfm_display_verb(EBFM_MSG_INFO, "TASK:dma_rd_test");

      // Read descriptor table in the RC Memory
      dma_set_rd_desc_data(bar_table, setup_bar);

      use_msi    = use_global_msi    | (NUM_MSI_EXPECTED > 0);
      use_eplast = use_global_eplast | (NUM_EPLAST_EXPECTED > 0);


      // Set MSI for DMA Read
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
                      RD_BDT_LSB,              // RC lower 32 bits of bdt
                      msi_number_int,
                      msi_traffic_class_int,
                      multi_message_enable_int,
                      0);

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
         if (DMA_CONTINOUS_LOOP==0) begin
			unused_result = ebfm_display(EBFM_MSG_INFO, { "DEBUG: DMA_CONTINOUS_LOOP is zero." });
            rcmem_poll(RD_BDT_LSB+DT_EPLAST, RCLast,32'h0000FFFF);
		 end
         else begin
			unused_result = ebfm_display(EBFM_MSG_INFO, { "DEBUG: DMA_CONTINOUS_LOOP is ", dimage4(DMA_CONTINOUS_LOOP)});
            for (i=0;i<DMA_CONTINOUS_LOOP;i=i+1) begin
               unused_result = ebfm_display(EBFM_MSG_INFO, { "   Running DMA loop ", dimage4(i), " : "});
               shmem_write(RD_BDT_LSB+DT_EPLAST, 32'hCAFE_FADE,4);
               rcmem_poll(RD_BDT_LSB+DT_EPLAST, RCLast,32'h0000FFFF);
            end
            shmem_write(RD_BDT_LSB+DT_EPLAST, 32'hCAFE_FADE,4);
            dma_set_header( bar_table,              // Pointer to the BAR sizing and
                            setup_bar,               // BAR to be used for setting up
                            NUMBER_OF_DESCRIPTORS,   // number of descriptor
                            RD_DIRECTION,            // Direction read
                            use_global_msi,          // global MSI control
                            use_global_eplast,       // global eplast control
                            RD_BDT_MSB,              // RC upper 32 bits of bdt
                            RD_BDT_LSB,              // RC lower 32 bits of bdt
                            msi_number_int,
                            msi_traffic_class_int,
                            multi_message_enable_int,
                            1); // stop_loop
             track_rclast_loop[15:0] = (use_global_eplast==1'b1) ? RCLast : EPLAST_DONE_VALUE;
             track_rclast_loop[31:16] = 1 ;
             unused_result = ebfm_display(EBFM_MSG_INFO, "   Flushing DMA loop");
             rcmem_poll(RD_BDT_LSB+DT_EPLAST, track_rclast_loop,32'h0001ffff);
         end
      end

      join  // polling

      unused_result = ebfm_display(EBFM_MSG_INFO, "DEBUG:Finished Polling");
      ebfm_barwr_imm(bar_table, setup_bar, 16, 32'h0000_FFFF, 4, 0);
	  debug_counter = 6;
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
   input time bar_table,
   input time setup_bar,
   input time use_global_msi,
   input time use_global_eplast);

   localparam time MSI_ADDRESS = SCR_MEM-16;
   localparam time MSI_DATA    = 16'hb0fe;

   reg unused_result ;
   time RCLast;

   reg [4:0] msi_number          ;
   reg [2:0] msi_traffic_class   ;
   reg [2:0] multi_message_enable;
   time   msi_address         ;

   time   msi_expected_dmawr ;
   time   msi_expected_dmard ;

   time msi_received ;
   time msi_count    ;
   time max_count    ;
   time i    ;
   reg [31:0] track_rclast_loop;

   reg     use_msi;
   reg     use_eplast;

   reg [4:0] msi_number_int          ;
   reg [2:0] msi_traffic_class_int   ;
   reg [2:0] multi_message_enable_int;

   begin

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
                      WR_BDT_LSB,              // RC lower 32 bits of bdt
                      msi_number_int,
                      msi_traffic_class_int,
                      multi_message_enable_int,
                      0);

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
            rcmem_poll(WR_BDT_LSB+DT_EPLAST, EPLAST_DONE_VALUE,32'h0000ffff);
         else begin
            for (i=0;i<DMA_CONTINOUS_LOOP;i=i+1) begin
               unused_result = ebfm_display(EBFM_MSG_INFO, { "   Running DMA loop ", dimage4(i), " : "});
               shmem_write(WR_BDT_LSB+DT_EPLAST, 32'hCAFE_FADE,4);
               rcmem_poll(WR_BDT_LSB+DT_EPLAST, EPLAST_DONE_VALUE,32'h0000ffff);
            end
            shmem_write(WR_BDT_LSB+DT_EPLAST, 32'hCAFE_FADE,4);
            dma_set_header( bar_table,               // Pointer to the BAR sizing and
                            setup_bar,               // BAR to be used for setting up
                            NUMBER_OF_DESCRIPTORS,   // number of descriptor
                            WR_DIRECTION,            // Direction = Write
                            use_global_msi,          // global MSI control
                            use_global_eplast,       // global eplast control
                            WR_BDT_MSB,              // RC upper 32 bits of bdt
                            WR_BDT_LSB,              // RC lower 32 bits of bdt
                            msi_number_int,
                            msi_traffic_class_int,
                            multi_message_enable_int,
                            1);
             track_rclast_loop[15:0] = (use_global_eplast==1'b1) ? RCLast : EPLAST_DONE_VALUE;
             track_rclast_loop[31:16] = 1 ;
             unused_result = ebfm_display(EBFM_MSG_INFO, "   Flushing DMA loop");
             rcmem_poll(WR_BDT_LSB+DT_EPLAST, track_rclast_loop,32'h0001ffff);
         end
      end

      join // polling

      ebfm_barwr_imm(bar_table, setup_bar, 0, 32'h0000_FFFF, 4, 0);
	  debug_counter = 7;
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
    input time bar_table ,
    input time setup_bar ,
    input time direction ,
    input time use_global_msi   ,
    input time use_global_eplast
   );

   reg unused_result ;

   begin

      unused_result = ebfm_display(EBFM_MSG_INFO, `STR_SEP);
      unused_result = ebfm_display(EBFM_MSG_INFO, "TASK:chained_dma_test");
      case (direction)
         0: begin
               unused_result = ebfm_display(EBFM_MSG_INFO,"   DMA: Read");
               dma_rd_test(bar_table, setup_bar, use_global_msi, use_global_eplast);
            end
         1: begin
               unused_result = ebfm_display(EBFM_MSG_INFO,"   DMA: Write");
               dma_wr_test(bar_table, setup_bar, use_global_msi, use_global_eplast);
            end
          default: unused_result = ebfm_display(EBFM_MSG_INFO,"   Incorrect direction");

      endcase
  end
endtask

task init_msi(
	input time bar_table,
	input time setup_bar
	);
	begin

	localparam time MSI_ADDRESS = SCR_MEM-16;
	localparam time MSI_DATA    = 16'hb0fe;
	reg [4:0] msi_number          ;
	reg [2:0] msi_traffic_class   ;
	reg [2:0] multi_message_enable;
	time   msi_expected;

	dma_set_msi( bar_table,  // Pointer to the BAR sizing and
				 setup_bar,  // BAR to be used for setting up
				 1,          // bus_num
				 1,          // dev_num
				 0,          // fnc_num
				 RD_DIRECTION,          // Direction
				 MSI_ADDRESS,// MSI RC memeory address	 
				 MSI_DATA,   // MSI Cfg data value
				 msi_number, // msi_number
				 msi_traffic_class, //msi traffic class
				 multi_message_enable,// number of msi
				 msi_expected // expexted MSI data value
				 );
	end
endtask

task sonic_cmd_issue(
	input time bar_table,
	input time setup_bar,
	input time command,
	input time param0,
	input time param1,
	input time param2
	);
	reg unused_result;
	integer cmd_offset;
	integer cmd_addr_msw;
	integer cmd_addr_lsw;
	begin
		cmd_offset = `SONIC_REG_CMD_DW0;	
		cmd_addr_msw = 0;
		cmd_addr_lsw = SCR_MEM + 512;

		ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+16, cmd_addr_msw, 4, 0);
		ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+20, cmd_addr_lsw, 4, 0);

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
			ebfm_barwr_imm(bar_table, setup_bar, cmd_offset, command, 4, 0);
		end
		`SONIC_CMD_CONFIG_IRQ: begin
			ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+4, param0, 4, 0);
			ebfm_barwr_imm(bar_table, setup_bar, cmd_offset, command, 4, 0);
		end
		`SONIC_CMD_SET_ADDR_IRQ: begin
			ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+4, param0, 4, 0);
			ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+8, param1, 4, 0);
			ebfm_barwr_imm(bar_table, setup_bar, cmd_offset, command, 4, 0);
		end
		`SONIC_CMD_SET_RX_BLOCK_SIZE: begin
			ebfm_barwr_imm(bar_table, setup_bar, cmd_offset+4, param0, 4, 0);
			ebfm_barwr_imm(bar_table, setup_bar, cmd_offset, command, 4, 0);
		end
		default:
			unused_result = ebfm_display_verb(EBFM_MSG_INFO, "CMD not supported!");	
		endcase
	end
endtask

task sonic_cmd_poll(
	input time cmd_address
	);
	reg unused_result;
	time cmd_received;
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

task sonic_cmd_test (
	input time bar_table,
	input time setup_bar
	);
	time cmd_response_address;

	integer rc_addr_lsb;
	integer rc_addr_msb;
	integer rx_msi_ctrl;
	reg unused_result;

	integer i;
	begin
	cmd_response_address = SCR_MEM + 512;
	//issue sonic_cmd_reset
	shmem_write(cmd_response_address, 32'hFFFF_FFFF, 4);
	sonic_cmd_issue (bar_table, setup_bar, `SONIC_CMD_RESET, 0, 0, 0);
    unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);
	sonic_cmd_poll(cmd_response_address);
    unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);

	// set rx block size
	shmem_write(cmd_response_address, 32'hFFFF_FFFF, 4);
	sonic_cmd_issue (bar_table, setup_bar, `SONIC_CMD_SET_RX_BLOCK_SIZE, 32'h1000, 0, 0);
    unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);
	sonic_cmd_poll(cmd_response_address);
    unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);

	shmem_write(cmd_response_address, 32'hFFFF_FFFF, 4);
	sonic_cmd_issue (bar_table, setup_bar, `SONIC_CMD_GET_RX_SIZE, 64, 0, 0);
    unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);
	sonic_cmd_poll(cmd_response_address);
    unused_result =shmem_display(cmd_response_address,16'h32,4,cmd_response_address,EBFM_MSG_INFO);

	// set irq data in rc memory, based at 0x1800
	rc_addr_lsb = SCR_MEM+4096;
	//rc_addr_msb = 1;
	rc_addr_msb = 0;	
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


// purpose: Examine the DUT's BAR setup and pick a reasonable BAR to use
task find_mem_bar;
   input bar_table;
   time bar_table;
   input[5:0] allowed_bars;
   input min_log2_size;
   time min_log2_size;
   output sel_bar;
   time sel_bar;

   time cur_bar;
   reg[31:0] bar32;
   time log2_size;
   reg is_mem;
   reg is_pref;
   reg is_64b;

   begin
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
   end
endtask

// memory content checking - check data transferred for specified descriptor
task check_dma_data;
   reg unused_result ;
   time i;
   reg [31:0] dmaread_data;
   reg [31:0] dmawrite_data;
   time dmaread_addr;
   time dmawrite_addr;
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
   input time byte_length,     // downstream wr/rd length in byte
   input time scr_memorya,     //
   input time scr_memoryb);     //
   time i;
   reg [7:0] bytea;
   reg [7:0] byteb;
   reg [31:0] addra;
   reg [31:0] addrb;
   reg unused_result ;

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
   input time bar_table,       // Pointer to the BAR sizing and
   input time setup_bar,       // Pointer to the BAR sizing and
   input  time loop,           // Number of Write/read iteration
   input time byte_length,     // downstream wr/rd length in byte
   input time epmem_address,   // Downstream EP memory address in byte
   input  [63:0] start_val);      // Starting write data value

   reg unused_result ;
   reg [63:0] Istart_val;
   reg [31:0] Iepmem_address;
   time i;
   reg [31:0] Ibyte_length;

   reg [31:0] cfg_reg ;
   reg [31:0] cfg_maxpload_byte ;
   reg [7:0] avalon_waddr ;
   reg [31:0] avalon_waddr_qw_max;
   reg [31:0] avalon_waddr_qw_min;
   reg [31:0] cfg_dw1 ;


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
   input time bar_table,          // Pointer to the BAR sizing and
   input time setup_bar,          // Pointer to the BAR sizing and
   input time address,            // Downstream EP memeory address in byte
   input [63:0] data,
   input time byte_length);      // BAR to be used for setting up

   reg unused_result ;

   begin

      // Write a data
      shmem_fill(SCR_MEM_DOWNSTREAM_WR,SHMEM_FILL_QWORD_INC,byte_length,data);
      ebfm_barwr(bar_table,setup_bar,address,SCR_MEM_DOWNSTREAM_WR,byte_length,0);
	  debug_counter = 9;
   end

endtask

/////////////////////////////////////////////////////////////////////////
//
// TASK:downstream_read
// Prior to run DMA test, this task clears the performance counters
//
task downstream_read(
   input time bar_table,          // Pointer to the BAR sizing and
   input time setup_bar,          // Pointer to the BAR sizing and
   input time address,            // Downstream EP memeory address in byte
   input time byte_length);      // BAR to be used for setting up

   reg unused_result ;
   begin
      // read a data
      shmem_fill(SCR_MEM_DOWNSTREAM_RD,SHMEM_FILL_QWORD_INC,byte_length,64'hFADE_FADE_FADE_FADE);
      ebfm_barrd_wait(bar_table,setup_bar,address,SCR_MEM_DOWNSTREAM_RD,byte_length,0);
      debug_counter = 10;
   end

endtask

///////////////////////////////////////////////////////////////////////////////
//
//
// Main Program
//
// Start of the test bench driver sonictb_bfm_driver
//
   reg activity_toggle;
   reg timer_toggle ;
   time time_stamp ;
   localparam TIMEOUT = 2000000000;

   initial
     begin
        time_stamp = $time ;
        activity_toggle = 1'b0;
        timer_toggle    = 1'b0;
   end

   // behavioral
   always
   begin : main
      // If you want to relocate the bar_table, modify the BAR_TABLE_POINTER in sonictb_bfm_shmem.
      // Directly modifying the bar_table at this location may disable overwrite protection for the bar_table
      // If the bar_table is overwritten incorrectly, this will break the testbench functionality.

	  // BAR_TABLE_POINTER = 0x001FFFC0
      parameter bar_table = BAR_TABLE_POINTER; // Default BAR_TABLE_SIZE is 64 bytes
      time tgt_bar;
      time dma_bar, rc_slave_bar;
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
           "----> Starting ebfm_cfg_rp_ep task 0");
      ebfm_cfg_rp_ep(
                     bar_table,         // BAR Size/Address info for Endpoint
                     1,                 // Bus Number for Endpoint Under Test
                     1,                 // Device Number for Endpoint Under Test
                     512,               // Maximum Read Request Size for Root Port
                     1,                 // Display EP Config Space after setup
                     addr_map_4GB_limit // Limit the BAR assignments to 4GB address map
                     );
	  debug_counter = 0;
      activity_toggle <= ~activity_toggle ;

      // Find a memory BAR to use to setup the DMA channel
      // The reference design implements the DMA channel registers on BAR 2 or 3
      // BAR as to be at least 256 B
      find_mem_bar(bar_table, 6'b001100, 8, dma_bar);

      ///////////////////////////////////////////
      // Test the chained DMA example design
      //
      // We skipped the DMA write and read test

      if ((dma_bar < 6) && (USE_CDMA>0)) begin
       
		repeat (5000) @(posedge clk_in);
         init_msi(bar_table, dma_bar); 
	     sonic_cmd_test(bar_table, dma_bar);
	
		 chained_dma_test(bar_table, dma_bar,0,1,1);  // Read  DMA
		 unused_result =shmem_display(32'h1800,16'h32,4,32'h1800,EBFM_MSG_INFO);
         time_stamp = $time ;
         chained_dma_test(bar_table, dma_bar,0,1,1);  // Read  DMA
		 unused_result =shmem_display(32'h1800,16'h32,4,32'h1800,EBFM_MSG_INFO);

	/*   chained_dma_test(bar_table, dma_bar,1,0,0);  // Write DMA
         time_stamp = $time ;
         chained_dma_test(bar_table, dma_bar,0,0,0);  // Read  DMA
        // check the data transferred by the last descriptor
         
		check_dma_data( WR_DESC2_LENGTH,
                         RD_DESC2_LENGTH,
                         WR_DESC2_RCADDR_LSB,
                         RD_DESC2_RCADDR_LSB);
	*/

      end
      else if (USE_CDMA>0)
         unused_result = ebfm_display_verb(EBFM_MSG_WARNING,
     "Unable to find a 256B BAR to setup the chaining DMA DUT; skipping test.");
      // Stop the simulator and indicate successful completion


      //////////////////////////////////////////////////////
      // Test downstream access to the Chaining DMA Memory


      find_mem_bar(bar_table, 6'b110011, 8, rc_slave_bar);

      if ((rc_slave_bar<6)) begin
            downstream_loop(
               bar_table,               // Pointer to the BAR sizing and
               rc_slave_bar,            // Pointer to the BAR sizing and
               RCSLAVE_MAXLEN,          // Number of Write/read iteration
               4,                       // downstream wr/rd length in byte
               0,                       // Downstream EP memory address in byte
                                        // (need to be qword aligned)
               64'hBABA_0000_BEBE_0000);// Starting write data value

      end
      else
         unused_result = ebfm_display_verb(EBFM_MSG_WARNING,
            "Unable to find a 256B BAR to setup the RC Slave module ; skipping test.");
      unused_result = ebfm_log_stop_sim(1);

      forever #100000;
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
