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


`timescale 1 ps / 1 ps
//-----------------------------------------------------------------------------
// Title         : PCI Express BFM Root Port Avalon-ST128 VC Interface
// Project       : PCI Express MegaCore function
//-----------------------------------------------------------------------------
// File          : altpcietb_bfm_vc_intf_128.v
// Author        : Altera Corporation
//-----------------------------------------------------------------------------
// Description :
// This entity interfaces between the root port transaction list processor
// and the root port module single VC interface. It handles the following basic
// functions:
// * Formating Tx Descriptors 
// * Retrieving Tx Data as needed from the shared memory
// * Decoding Rx Descriptors 
// * Storing Rx Data as needed to the shared memory
//-----------------------------------------------------------------------------
// Copyright (c) 2008 Altera Corporation. All rights reserved.  Altera products are
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
module altpcietb_bfm_vc_intf_128 (clk_in, rstn, rx_mask,  rx_be,  rx_st_sop, rx_st_eop, rx_st_empty, rx_st_data, rx_st_valid, rx_st_ready, rx_ecrc_err,
                                  tx_cred,  tx_err, 
                                  tx_st_ready, tx_st_sop, tx_st_eop, tx_st_empty, tx_st_valid, tx_st_data, tx_fifo_empty, cfg_io_bas, cfg_np_bas, cfg_pr_bas);

   parameter VC_NUM  = 0;
   parameter DISABLE_RX_BE_CHECK  = 1;      
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

      reg [9*8:1]  prefix ;
      reg [80*8:1] amsg;
      reg sup;
      reg stp;
      reg dummy ;
      integer i ;
      time ctime ;
      integer itime ;

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
     input  [32:1]  num ;
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

   task shmem_write;
      input addr;
      integer addr;
      input [63:0] data;
      input leng;
      integer leng;

      integer rleng;
      integer i ;

      reg dummy ;

      begin
         if (leng > 8)
           begin
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,"Task SHMEM_WRITE only accepts write lengths up to 8") ;
              rleng = 8 ;
           end
/*         else if ( addr < BAR_TABLE_POINTER + BAR_TABLE_SIZE & addr >= CFG_SCRATCH_SPACE & bfm_shmem_common.protect_bfm_shmem )
            begin
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,"Task SHMEM_WRITE attempted to overwrite the write protected area of the shared memory") ;
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,"This protected area contains the following data critical to the operation of the BFM:") ;
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,{"The BFM internal memory area, 64B located at ", himage8(CFG_SCRATCH_SPACE)}) ;
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,{"The BAR Table, 64B located at ", himage8(BAR_TABLE_POINTER)}) ;
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,{"All other locations in the shared memory are available from 0 to ", himage8(CFG_SCRATCH_SPACE - 1)}) ;
              dummy = ebfm_display(EBFM_MSG_ERROR_INFO,"Please change your SHMEM_WRITE call to a different memory location") ;
              dummy = ebfm_display(EBFM_MSG_ERROR_FATAL,"Halting Simulation") ;
            end
*/         else
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
      input leng;
      integer leng;

      reg[63:0] rdata;
      integer rleng ;
      integer i ;

      reg dummy ;

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
      input leng;
      integer leng;
      input word_size;
      integer word_size;
      input flag_addr;
      integer flag_addr;
      input msg_type;
      integer msg_type;

      integer iaddr;
      reg [60*8:1] oneline ;
      reg [128:1] data_str[0:15] ;
      reg [8*5:1] flag ;
      integer i ;

      reg dummy ;

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
      input mode;
      integer mode;
      input leng; // Length to fill in bytes
      integer leng;
      input[63:0] init;

      integer rembytes;
      reg[63:0] data;
      integer uaddr;
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
      input mode;
      integer mode;
      input leng; // Length to fill in bytes
      integer leng;
      input[63:0] init;
      input display_error;
      integer display_error;

      reg dummy ;

      integer rembytes;
      reg[63:0] data;
      reg[63:0] actual;
      integer uaddr;
      integer daddr;
      integer dlen;
      integer incr_count;
      parameter[7:0] ZDATA = {8{1'b0}};
      parameter[7:0] ODATA = {8{1'b1}};
      reg [36*8:1] actline;
      reg [36*8:1] expline;
      integer word_size;

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
      input ep_max_rd_req; // 0 means use max_payload_size
      integer ep_max_rd_req;
      input rp_max_rd_req;
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
      input need_handle;
      input lcl_addr;
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

      integer vcnum;

      reg dummy ;

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

      reg dummy ;

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
      output[2:0] compl_status;
      input keep_handle;

      reg dummy ;

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
      output req_valid;
      output[127:0] req_desc;
      output lcladdr;
      integer lcladdr;
      output imm_valid;
      output[31:0] imm_data;

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

      reg dummy ;

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
      input[2:0] status;

      reg dummy ;

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
   reg   [EBFM_MSG_MAX_LEN*8:1] message;
   integer i;
   integer dummy;
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

//`endif

   input clk_in; 
   input rstn;   
   output rx_mask; 
   reg rx_mask; 
   input[15:0] rx_be;  
   input[35:0] tx_cred;    
   output tx_err; 
   reg tx_err; 
   input[19:0] cfg_io_bas; 
   input[11:0] cfg_np_bas; 
   input[43:0] cfg_pr_bas; 
   input rx_st_sop;
   input rx_st_valid;
   output rx_st_ready;
   reg rx_st_ready;
   input rx_st_eop;
   input rx_st_empty;
   input[127:0] rx_st_data;
   input rx_ecrc_err;
   input tx_st_ready;
   output tx_st_sop;
   reg tx_st_sop;
   output tx_st_eop;
   reg tx_st_eop;
   output tx_st_empty;
   reg tx_st_empty;
   output tx_st_valid;
   reg tx_st_valid;
   output[127:0] tx_st_data;
   reg[127:0] tx_st_data;
   input tx_fifo_empty;

   parameter[2:0] RXST_IDLE = 0; 
   parameter[2:0] RXST_DESC_ACK = 1; 
   parameter[2:0] RXST_DATA_WRITE = 2; 
   parameter[2:0] RXST_DATA_NONP_WRITE = 3; 
   parameter[2:0] RXST_DATA_COMPL = 4; 
   parameter[2:0] RXST_NONP_REQ = 5; 
   parameter[1:0] TXST_IDLE = 0; 
   parameter[1:0] TXST_DESC = 1; 
   parameter[1:0] TXST_DATA = 2; 
   reg[2:0] rx_state; 
   reg[1:0] tx_state; 
   

   
   
   // Communication signals between main Tx State Machine and main Rx State Machine
   // to indicate when completions are expected
   integer exp_compl_tag; 
   integer exp_compl_bcount; 
   
   // Communication signals between Rx State Machine and Tx State Machine
   // for requesting completions
   reg rx_tx_req; 
   reg[127:0] rx_tx_desc; 
   integer rx_tx_shmem_addr; 
   integer rx_tx_bcount; 
   reg[7:0] rx_tx_byte_enb; 
   reg tx_rx_ack; 
 
   
   // Communication Signals for PErf Monitoring
   reg[10:0] tx_payld_length;  
   reg[10:0] rx_payld_length; 
   reg       rx_update_pkt_count;   
   reg       tx_update_pkt_count;   
   
   // support for streaming interface
   reg[135:0] rx_desc_int;
   wire[135:0] rx_desc_int_v;   
   wire[127:0] rx_st_data_128;
   
   
 
   ///////////////////////////////////////////////////
   // Common functions and tasks used in this module
   

//-----------------------------------------------------------------------------
// Title         : PCI Express BFM Root Port VC Interface Common Tasks
// Project       : PCI Express MegaCore function
//-----------------------------------------------------------------------------
// File          : altpcietb_bfm_vc_intf_ast_common.v
// Author        : Altera Corporation
//-----------------------------------------------------------------------------
// Description :
// This file contains tasks common to the 64 and 128 bit Avalon-ST vc_intf files:
// altpcietb_bfm_vc_intf_64.v and altpcietb_bfm_vc_intf_128.v
//-----------------------------------------------------------------------------
// Copyright (c) 2008 Altera Corporation. All rights reserved.  Altera products are
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
 

   function [0:0] is_request;
      input[135:0] rx_desc; 

      reg dummy ;
      
      begin
         case (rx_desc[124:120])
            5'b00000 :
                     begin
                        is_request = 1'b1; // Memory Read or Write
                     end
            5'b00010 :
                     begin
                        is_request = 1'b1; // I/O Read or Write
                     end
            5'b01010 :
                     begin
                        is_request = 1'b0; // Completion
                     end
            default :
                     begin
                        // "00001" Memory Read Locked
                        // "00100" Config Type 0 Read or Write
                        // "00101" Config Type 1 Read or Write
                        // "10rrr" Message (w/Data)
                        // "01011" Completion Locked
                        dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, 
                                     {"Root Port VC", dimage1(VC_NUM), 
                                      " Recevied unsupported TLP, Fmt/Type: ", himage2(rx_desc[127:120])}); 
                        is_request = 1'b0; 
                     end
         endcase 
      end
   endfunction

   function [0:0] is_3dw_nonaligned;
      input[127:0] desc; 

      begin
         is_3dw_nonaligned = (desc[125]==1'b0) && (desc[34]==1'b1);
 
      end
   endfunction

   function [0:0] is_non_posted;
      input[127:0] desc; 

      begin
         case (desc[124:120])
            5'b00000 :
                     begin
                        // Memory Read or Write
                        if ((desc[126]) == 1'b0)
                        begin
                           // No Data, Must be non-posted read
                           is_non_posted = 1'b1; 
                        end
                        else
                        begin
                           is_non_posted = 1'b0; 
                        end 
                     end
            5'b00100 :
                     begin
                        is_non_posted = 1'b1; // Config Type 0 Read or Write
                     end
            5'b00101 :
                     begin
                        is_non_posted = 1'b1; // Config Type 1 Read or Write
                     end
            5'b00010 :
                     begin
                        is_non_posted = 1'b1; // I/O Read or Write
                     end
            5'b01010 :
                     begin
                        is_non_posted = 1'b0; // Completion
                     end
            default :
                     begin
                        // "00001" Memory Read Locked
                        // "10rrr" Message (w/Data)
                        // "01011" Completion Locked
                        is_non_posted = 1'b0; 
                     end
         endcase 
      end
   endfunction

   function [0:0] has_data;
      input[127:0] desc; 

      begin
         if ((desc[126]) == 1'b1)
         begin
            has_data = 1'b1; 
         end
         else
         begin
            has_data = 1'b0; 
         end 
      end
   endfunction

   function integer calc_byte_count;
      input[127:0] desc; 

      integer bcount; 

      begin
         // Number of DWords * 4 gives bytes
         bcount = desc[105:96] * 4; 
         if (bcount > 4)
         begin
            if ((desc[71]) == 1'b0)
            begin
               bcount = bcount - 1; 
               if ((desc[70]) == 1'b0)
               begin
                  bcount = bcount - 1; 
                  // If more than 1 DW
                  if ((desc[69]) == 1'b0)
                  begin
                     bcount = bcount - 1; 
                     // Adjust if the last Dword is not full
                     if ((desc[68]) == 1'b0)
                     begin
                        // Handle the case of no bytes in last DW
                        bcount = bcount - 1; 
                     end 
                  end 
               end 
            end 
            if ((desc[64]) == 1'b0)
            begin
               bcount = bcount - 1; 
               if ((desc[65]) == 1'b0)
               begin
                  bcount = bcount - 1; 
                  if ((desc[66]) == 1'b0)
                  begin
                     bcount = bcount - 1; 
                     // Now adjust if the first Dword is not full
                     if ((desc[67]) == 1'b0)
                     begin
                        // Handle the case of no bytes in first DW
                        bcount = bcount - 1; 
                     end 
                  end 
               end 
            end 
         end
         else
         begin
            // Only one DW, need to adjust based on
            // First Byte Enables could be any subset
            if ((desc[64]) == 1'b0)
            begin
               bcount = bcount - 1; 
            end 
            if ((desc[65]) == 1'b0)
            begin
               bcount = bcount - 1; 
            end 
            if ((desc[66]) == 1'b0)
            begin
               bcount = bcount - 1; 
            end 
            if ((desc[67]) == 1'b0)
            begin
               bcount = bcount - 1; 
            end 
         end 
         calc_byte_count = bcount; 
      end
   endfunction

   function [7:0] calc_first_byte_enb;
      input[127:0] desc; 

      reg[7:0] byte_enb; 

      begin
         // calc_first_byte_enb
         if ((((desc[125]) == 1'b1) & ((desc[2]) == 1'b1)) | (((desc[125]) == 1'b0) & ((desc[34]) == 1'b1)))
         begin
            byte_enb = {desc[67:64], 4'b0000}; 
         end
         else
         begin
            byte_enb = {4'b1111, desc[67:64]}; 
         end 
         calc_first_byte_enb = byte_enb; 
      end
   endfunction

   function integer calc_lcl_addr;
      input[135:0] rx_desc; 

      reg[63:0] req_addr; 

      begin
         // We just use the lower bits of the address to for the memory address 
         if ((rx_desc[125]) == 1'b1)
         begin
            // 4 DW Header
            req_addr[63:2] = rx_desc[63:2]; 
         end
         else
         begin
            // 3 DW Header
            req_addr[31:2] = rx_desc[63:34]; 
         end 
         if ((rx_desc[64]) == 1'b1)
         begin
            req_addr[1:0] = 2'b00; 
         end
         else
         begin
            if ((rx_desc[65]) == 1'b1)
            begin
               req_addr[1:0] = 2'b01; 
            end
            else
            begin
               // Calculate Byte Address from Byte Enables
               if ((rx_desc[66]) == 1'b1)
               begin
                  req_addr[1:0] = 2'b10; 
               end
               else
               begin
                  // Last Byte should be enabled (or we are not accessing anything so
                  // it is a don't care)
                  req_addr[1:0] = 2'b11; 
               end 
            end 
         end 
         calc_lcl_addr = req_addr[SHMEM_ADDR_WIDTH - 1:0]; 
      end
   endfunction

   task rx_write_req_setup;
      input[135:0] rx_desc; 
      output addr; 
      integer addr;
      output[7:0] byte_enb; 
      output bcount; 
      integer bcount;

      begin
         addr = calc_lcl_addr(rx_desc); 
         byte_enb = calc_first_byte_enb(rx_desc[127:0]); 
         bcount = calc_byte_count(rx_desc[127:0]); 
      end
   endtask

   task rx_compl_setup;
      input[135:0] rx_desc; 
      output base_addr; 
      integer base_addr;
      output[7:0] byte_enb; 
      output bcount; 
      integer bcount;
      output tag; 
      integer tag;
      output[2:0] status; 

      integer tagi; 
      integer bcounti; 

      begin
         // lcl_compl_addr
         tagi = rx_desc[47:40]; 
         if ((rx_desc[126]) == 1'b1)
         begin
            base_addr = vc_intf_get_lcl_addr(tagi); 
         end
         else
         begin
            base_addr = 2 ** SHMEM_ADDR_WIDTH; 
         end 
         tag = tagi; 
         // Calculate the byte-count from Length field
         bcounti = rx_desc[105:96] * 4; 
         // Calculate the byte-enables from the Lower Address field
         // Also modify the byte count 
         case (rx_desc[34:32])
            3'b111 :
                     begin
                        byte_enb = 8'b10000000; 
                        bcounti = bcounti - 3; 
                     end
            3'b110 :
                     begin
                        byte_enb = 8'b11000000; 
                        bcounti = bcounti - 2; 
                     end
            3'b101 :
                     begin
                        byte_enb = 8'b11100000; 
                        bcounti = bcounti - 1; 
                     end
            3'b100 :
                     begin
                        byte_enb = 8'b11110000; 
                        bcounti = bcounti - 0; 
                     end
            3'b011 :
                     begin
                        byte_enb = 8'b11111000; 
                        bcounti = bcounti - 3; 
                     end
            3'b010 :
                     begin
                        byte_enb = 8'b11111100; 
                        bcounti = bcounti - 2; 
                     end
            3'b001 :
                     begin
                        byte_enb = 8'b11111110; 
                        bcounti = bcounti - 1; 
                     end
            default :
                     begin
                        byte_enb = {8{1'b1}}; 
                        bcounti = bcounti - 0; 
                     end
         endcase 
         // Now if the remaining byte-count from the header is less than that
         // calculated above, that means there are some last data phase
         // byte enables that are not on, update bcounti to reflect that
         if (rx_desc[75:64] < bcounti)
         begin
            bcounti = rx_desc[75:64]; 
         end 
         bcount = bcounti; 
         status = rx_desc[79:77]; 
      end
   endtask


   // Setup the Completion Info for the received request
   task rx_nonp_req_setup_compl;
      input[135:0] rx_desc; 
      output[127:0] rx_tx_desc; 
      output rx_tx_shmem_addr; 
      integer rx_tx_shmem_addr;
      output[7:0] rx_tx_byte_enb; 
      output rx_tx_bcount; 
      integer rx_tx_bcount;

      integer temp_bcount; 
      integer temp_shmem_addr; 

      begin
         temp_shmem_addr = calc_lcl_addr(rx_desc[135:0]); 
         rx_tx_shmem_addr = temp_shmem_addr; 
         rx_tx_byte_enb = calc_first_byte_enb(rx_desc[127:0]); 
         temp_bcount = calc_byte_count(rx_desc[127:0]); 
         rx_tx_bcount = temp_bcount; 
         rx_tx_desc = {128{1'b0}}; 
         rx_tx_desc[126] = ~rx_desc[126]; // Completion Data is opposite of Request
         rx_tx_desc[125] = 1'b0; // FMT bit 0 always 0
         rx_tx_desc[124:120] = 5'b01010; // Completion
         // TC,TD,EP,Attr,Length (and reserved bits) same as request:
         rx_tx_desc[119:96] = rx_desc[119:96]; 
         rx_tx_desc[95:80] = RP_REQ_ID; // Completer ID
         rx_tx_desc[79:77] = 3'b000; // Completion Status
         rx_tx_desc[76] = 1'b0; // Byte Count Modified
         rx_tx_desc[75:64] = temp_bcount; 
         rx_tx_desc[63:48] = rx_desc[95:80]; // Requester ID
         rx_tx_desc[47:40] = rx_desc[79:72]; // Tag
         // Lower Address: 
         rx_tx_desc[38:32] = temp_shmem_addr; 
      end
   endtask
 
   function [0:0] tx_fc_check;
      input[127:0] desc; 
      input[21:0] cred; 

      integer data_cred; 
 
      begin
         // tx_fc_check
         case (desc[126:120])
            7'b1000100, 7'b0000100 :
                     begin
                        // Config Write Type 0
                        // Config Read Type 0
                        // Type 0 Config issued to RP get handled internally,
                        // so we can issue even if no Credits
                        tx_fc_check = 1'b1; 
                     end
            7'b0000000, 7'b0100000, 7'b0000010, 7'b0000101 :
                     begin
                        // Memory Read (3DW, 4DW)
                        // IO Read
                        // Config Read Type 1
                        // Non-Posted Request without Data 
                        if ((cred[17:15]>0) == 1'b1)
                        begin
                           tx_fc_check = 1'b1; 
                        end
                        else
                        begin
                           tx_fc_check = 1'b0; 
                        end 
                     end
            7'b1000010, 7'b1000101 :
                     begin
                        // IO Write
                        // Config Write Type 1
                        // Non-Posted Request with Data 
                        if ((cred[17:15]>0) & ((cred[20:18]>0)))
                        begin
                           tx_fc_check = 1'b1; 
                        end
                        else
                        begin
                           tx_fc_check = 1'b0; 
                        end 
                     end
            7'b1000000, 7'b1100000 :
                     begin
                        // check for Posted header cred
                        if (cred[2:0]>1)
                        begin
                           data_cred = desc[105:96];  
                           // MemWr   
                           // check for Posted data creds
                           if (data_cred <= cred[14:3])
                           begin
                              tx_fc_check = 1'b1; 
                           end
                           else
                           begin
                              tx_fc_check = 1'b0; 
                           end 
                        end
                        else
                        begin
                           tx_fc_check = 1'b0; 
                        end 
                     end
            default :
                     begin
                        tx_fc_check = 1'b0; 
                     end
         endcase 
 
      end
   endfunction

   task tx_setup_data;
      input lcl_addr; 
      integer lcl_addr;
      input bcount; 
      integer bcount;
      input[7:0] byte_enb; 
      output[32767:0] data_pkt; 
      output dphases; 
      integer dphases;
      input imm_valid; 
      input[31:0] imm_data; 

      reg [63:0] data_pkt_xhdl ;
      
      integer dphasesi; 
      integer bcount_v; 
      integer lcl_addr_v; 
      integer nb; 
      integer fb; 

      integer i ;
      
      begin
         dphasesi = 0 ;
         // tx_setup_data
         if (imm_valid == 1'b1)
           begin
              lcl_addr_v = 0 ;
           end
         else
           begin
              lcl_addr_v = lcl_addr;
           end 
         bcount_v = bcount; 
         // Setup the first data phase, find the first byte
         begin : xhdl_0
            integer i;
            for(i = 0; i <= 7; i = i + 1)
            begin : byte_loop
               if ((byte_enb[i]) == 1'b1)
               begin
                  fb = i; 
                  disable xhdl_0 ; 
               end 
            end
         end 
         // first data phase figure out number of bytes
         nb = 8 - fb; 
         if (nb > bcount_v)
         begin
            nb = bcount_v; 
         end 
         // first data phase get bytes
         data_pkt_xhdl = {64{1'b0}};
         for (i = 0 ; i < nb ; i = i + 1)
           begin
              if (imm_valid == 1'b1)
                begin
                   data_pkt_xhdl[((fb+i) * 8)+:8] = imm_data[(i*8)+:8]; 
                end
              else
                begin
                   data_pkt_xhdl[((fb+i) * 8)+:8] = shmem_read((lcl_addr_v+i), 1); 
                end
           end 
         data_pkt[(dphasesi*64)+:64] = data_pkt_xhdl;
         bcount_v = bcount_v - nb; 
         lcl_addr_v = lcl_addr_v + nb; 
         dphasesi = dphasesi + 1; 
         // Setup the remaining data phases
         while (bcount_v > 0)
         begin
            data_pkt_xhdl = {64{1'b0}}; 
            if (bcount_v < 8)
            begin
               nb = bcount_v; 
            end
            else
            begin
               nb = 8; 
            end
            for (i = 0 ; i < nb ; i = i + 1 )
              begin
                 if (imm_valid == 1'b1)
                   begin
                      // Offset into remaining immediate data
                      data_pkt_xhdl[(i*8)+:8] = imm_data[(lcl_addr_v + (i*8))+:8]; 
                   end
                 else
                   begin
                      data_pkt_xhdl[(i*8)+:8] = shmem_read(lcl_addr_v + i, 1); 
                   end
              end
            data_pkt[(dphasesi*64)+:64] = data_pkt_xhdl;
            bcount_v = bcount_v - nb; 
            lcl_addr_v = lcl_addr_v + nb; 
            dphasesi = dphasesi + 1; 
         end 
         dphases = dphasesi; 
      end
   endtask

   task tx_setup_req;
      input[127:0] req_desc; 
      input lcl_addr; 
      integer lcl_addr;
      input imm_valid; 
      input[31:0] imm_data; 
      output[32767:0] data_pkt; 
      output dphases; 
      integer dphases;

      integer bcount_v; 
      reg[7:0] byte_enb_v; 

      begin
         // tx_setup_req
         if (has_data(req_desc))
         begin
            bcount_v = calc_byte_count(req_desc); 
            byte_enb_v = calc_first_byte_enb(req_desc); 
            tx_setup_data(lcl_addr, bcount_v, byte_enb_v, data_pkt, dphases, imm_valid, imm_data); 
         end
         else
         begin
            dphases = 0; 
         end 
      end
   endtask
   
 

   // purpose: This reflects the reset value in shared variables
   always 
   begin : reset_flag
      // process reset_flag
      if (VC_NUM > 0)
      begin
         forever #100000; // Only one VC needs to do this
      end
      else
      begin
         vc_intf_reset_flag(rstn); 
      end 
      @(rstn); 
   end 

  integer tx_pkts ;
  integer tx_qwords ;
  integer tx_dwords ;
  integer rx_pkts ;
  integer rx_qwords ;
  integer rx_dwords ; 
  reg clr_pndg ;

/*
  initial
  begin
    clr_pndg = 1;              
    @ (posedge clk_in);         
    @ (posedge clk_in);        
    @ (posedge clk_in);         
    clr_pndg = 0;
  end
*/

  always@(posedge clk_in)
  begin
     if (vc_intf_sample_perf(VC_NUM) == 1'b1)
     begin
        if (clr_pndg == 1'b0)
        begin
           vc_intf_set_perf(VC_NUM,tx_pkts,tx_qwords,rx_pkts,rx_qwords);
           tx_pkts   = 0 ;
           tx_qwords = 0 ;
           tx_dwords = 0;
           rx_pkts   = 0 ;
           rx_qwords = 0 ;
           rx_dwords = 0 ;
           clr_pndg  = 1'b1 ;
        end
     end
     else
     begin
        if (clr_pndg == 1'b1)
           begin
              vc_intf_clr_perf(VC_NUM) ;
              clr_pndg = 1'b0 ;
           end
     end
     if (tx_update_pkt_count == 1'b1)
     begin
        tx_dwords = tx_dwords + tx_payld_length;
        tx_qwords = tx_dwords/2;
     end
     if (tx_update_pkt_count == 1'b1)
     begin
        tx_pkts = tx_pkts + 1;
     end
     if (rx_update_pkt_count == 1'b1)
     begin
        rx_dwords = rx_dwords + rx_payld_length;
        rx_qwords = rx_dwords/2;
     end
     if (rx_update_pkt_count == 1'b1)
     begin
        rx_pkts = rx_pkts + 1;
     end 
  end
 

   
   
   
   ///////////////////////////////////////////////////
   // RX and TX processing
   
   assign rx_st_data_128 = rx_st_data;  // H3H2H1H0, D3D2D1D0. 
   assign rx_desc_int_v = ((rx_st_sop==1'b1) & (rx_st_valid==1'b1)) ?  {rx_st_data_128[31:0], rx_st_data_128[63:32], rx_st_data_128[95:64], rx_st_data_128[127:96]} : rx_desc_int;


   // behavioral
   always @(clk_in)
   begin : main_rx_state
      integer compl_received_v[0:EBFM_NUM_TAG - 1]; 
      integer compl_expected_v[0:EBFM_NUM_TAG - 1]; 
      reg[2:0] rx_state_v;            
      reg rx_st_ready_v;// pops data from RX FIFO (lookahead)  
      integer shmem_addr_v; 
      integer rx_compl_tag_v; 
      reg[SHMEM_ADDR_WIDTH - 1:0] rx_compl_baddr_v; 
      reg[2:0] rx_compl_sts_v; 
      reg[7:0] byte_enb_v; 
      reg[15:0] byte_enb_128_v;
      integer bcount_v; 
      reg rx_tx_req_v; 
      reg[127:0] rx_tx_desc_v; 
      integer rx_tx_shmem_addr_v; 
      integer rx_tx_bcount_v; 
      reg[7:0] rx_tx_byte_enb_v; 
      reg rx_update_pkt_count_v; 
      reg[10:0]   rx_payld_length_v; 
      reg      dummy ; 
      reg     rx_ecrc_err_reg;
      
      integer  shmem_addr0_debug;   
      reg[15:0] byte_en_debug;    
      reg[127:0] data_debug;      
      
      integer      i ;
      if (clk_in == 1'b1)
      begin
         if (rstn != 1'b1)
         begin
            rx_state_v = RXST_IDLE;  
            rx_compl_tag_v = -1; 
            rx_compl_sts_v = {3{1'b1}}; 
            rx_tx_req_v = 1'b0; 
            rx_tx_desc_v = {128{1'b0}}; 
            rx_tx_shmem_addr_v = 0; 
            rx_tx_bcount_v = 0; 
            rx_tx_bcount_v = 0;  
            rx_payld_length_v = 11'h0;
            rx_update_pkt_count_v = 11'b0;
            rx_ecrc_err_reg = 1'b0;
            for (i = 0 ; i < EBFM_NUM_TAG ; i = i + 1)
              begin
                 compl_expected_v[i] = -1; 
                 compl_received_v[i] = -1;
              end
         end
         else
         begin 
            // See if the Transmit side is transmitting a Non-Posted Request
            // that we need to expect a completion for and if so record it
            if (exp_compl_tag > -1)
            begin
               compl_expected_v[exp_compl_tag] = exp_compl_bcount; 
               compl_received_v[exp_compl_tag] = 0; 
            end 
            rx_state_v = rx_state;  
            rx_tx_req_v = 1'b0;   
            
            // for performance monitor
            rx_update_pkt_count_v = (rx_st_eop == 1'b1) & (rx_st_valid == 1'b1);
            if (rx_desc_int_v[126]==1'b1) begin
                if (rx_desc_int_v[105:96]==10'h0)
                    rx_payld_length_v <= 11'h400;   // 1024 DWs
                else
                    rx_payld_length_v <= {1'b0, rx_desc_int_v[105:96]};
            end 
            
            rx_ecrc_err_reg <= rx_ecrc_err;
            if ((rx_ecrc_err_reg == 0) & (rx_ecrc_err==1)) begin
               dummy = ebfm_display(EBFM_MSG_ERROR_CONTINUE, 
                         {"Root Port VC", dimage1(VC_NUM), 
                          " Detected ECRC Error " }); 
            end
            
            case (rx_state) 
               RXST_IDLE, RXST_DESC_ACK, RXST_DATA_COMPL, RXST_DATA_WRITE, RXST_DATA_NONP_WRITE :
                        begin   
                           rx_st_ready_v = 1'b1; 
                           
                           if ((rx_state == RXST_IDLE) && (rx_st_sop == 1'b1) && (rx_st_valid==1'b1))
                           begin   
                              if (is_request(rx_desc_int_v))
                              begin
                                 // All of these states are handled together since they can all
                                 // involve data transfer and we need to share that code.
                                 //
                                 // If this is the cycle where the descriptor is being ack'ed we
                                 // need to complete the descriptor decode first so that we can
                                 // be prepared for the Data Transfer that might happen in the same
                                 // cycle. 
                                 if (is_non_posted(rx_desc_int_v))
                                 begin
                                    // Non-Posted Request
                                    rx_nonp_req_setup_compl(rx_desc_int_v, rx_tx_desc_v, rx_tx_shmem_addr_v, rx_tx_byte_enb_v, rx_tx_bcount_v); 
                                    // Request
                                    if (has_data(rx_desc_int_v))
                                    begin
                                       // Non-Posted Write Request
                                       rx_write_req_setup(rx_desc_int_v, shmem_addr_v, byte_enb_v, bcount_v); 
                                       rx_state_v = RXST_DATA_NONP_WRITE; 
                                       rx_st_ready_v = 1'b1;
                                       if (is_3dw_nonaligned(rx_desc_int_v))
                                           byte_enb_128_v = {byte_enb_v, 8'h0};
                                       else
                                           byte_enb_128_v = {8'hff, byte_enb_v};
                                    end
                                    else
                                    begin
                                       // Non-Posted Read Request
                                       rx_st_ready_v = 1'b0;
                                       rx_state_v = RXST_NONP_REQ; 
                                    end 
                                 end
                                 else
                                 begin
                                    // Posted Request
                                    rx_tx_desc_v = {128{1'b0}}; 
                                    rx_tx_shmem_addr_v = 0; 
                                    rx_tx_byte_enb_v = {8{1'b0}}; 
                                    rx_tx_bcount_v = 0; 
                                    // Begin Lengthy decode and checking of the Rx Descriptor
                                    // First Determine if it is a completion or a request
                                    if (has_data(rx_desc_int_v))
                                    begin
                                       // Posted Write Request
                                       rx_write_req_setup(rx_desc_int_v, shmem_addr_v, byte_enb_v, bcount_v); 
                                       rx_st_ready_v = 1'b1;
                                       rx_state_v = RXST_DATA_WRITE; 
                                       if (is_3dw_nonaligned(rx_desc_int_v))
                                           byte_enb_128_v = {byte_enb_v, 8'h0};
                                       else
                                           byte_enb_128_v = {8'hff, byte_enb_v};
                                    end
                                    else
                                    begin
                                       // Posted Message without Data
                                       // Not currently supported.
                                       rx_st_ready_v = 1'b1;
                                       rx_state_v = RXST_IDLE; 
                                    end 
                                 end 
                              end
                              else // is_request == 0
                              begin
                                 // Completion
                                 rx_compl_setup(rx_desc_int_v, shmem_addr_v, byte_enb_v, bcount_v, 
                                                rx_compl_tag_v, rx_compl_sts_v); 
                                 if (compl_expected_v[rx_compl_tag_v] < 0)
                                 begin
                                    dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, 
                                                 {"Root Port VC", dimage1(VC_NUM), 
                                                  " Recevied unexpected completion TLP, Fmt/Type: ", 
                                                  himage2(rx_desc_int[127:120]), 
                                                  " Tag: ", himage2(rx_desc_int[47:40])}); 
                                 end 
                                 if (has_data(rx_desc_int_v))
                                 begin
                                    rx_st_ready_v = 1'b1;
                                    rx_state_v = RXST_DATA_COMPL; 
                                    // Increment for already received data phases
                                    shmem_addr_v = shmem_addr_v + compl_received_v[rx_compl_tag_v]; 
                                    if (is_3dw_nonaligned(rx_desc_int_v))
                                        byte_enb_128_v = {byte_enb_v, 8'h0};
                                    else
                                        byte_enb_128_v = {8'hff, byte_enb_v};
                                 end
                                 else
                                 begin
                                    rx_state_v = RXST_IDLE; 
                                    rx_st_ready_v = 1'b1;
                                    if ((compl_received_v[rx_compl_tag_v] < compl_expected_v[rx_compl_tag_v]) & 
                                        (rx_compl_sts_v == 3'b000))
                                    begin
                                       dummy = ebfm_display(EBFM_MSG_ERROR_CONTINUE, 
                                                    {"Root Port VC", dimage1(VC_NUM), 
                                                     " Did not receive all expected completion data. Expected: ", 
                                                     dimage4(compl_expected_v[rx_compl_tag_v]), 
                                                     " Received: ", dimage4(compl_received_v[rx_compl_tag_v])}); 
                                    end 
                                    // Report that it is complete to the Driver
                                    vc_intf_rpt_compl(rx_compl_tag_v, rx_compl_sts_v); 
                                    // Clear out that we expect anymore
                                    compl_received_v[rx_compl_tag_v] = -1; 
                                    compl_expected_v[rx_compl_tag_v] = -1; 
                                    rx_compl_tag_v = -1; 
                                 end 
                              end 
                           end 
                           // Collect Payload when
                           //    - in any state after the Descriptor phase or
                           //    - during descriptor phase, but only if it is a 3DW Header, Non-QWord aligned packet
                           if ((rx_st_valid == 1'b1) && (rx_desc_int_v[126]==1'b1) && 
                                     (    (rx_state!=RXST_IDLE) || 
                                          ((rx_state == RXST_IDLE) && (rx_st_sop == 1'b1) && (is_3dw_nonaligned(rx_desc_int_v))) ))    
                           begin
                           
                              begin : xhdl_3
                                 integer i;   
                                 for(i = 0; i <= 15; i = i + 1)               // process 128 bytes
                                 begin  
                                 
                                    if (i==0) 
                                       shmem_addr0_debug = shmem_addr_v; 
                                       
                                    byte_en_debug[i] = byte_enb_128_v[i];      
                                    data_debug[(i * 8)+:8] = rx_st_data_128[(i * 8)+:8];
                                    
                                    if (((byte_enb_128_v[i]) == 1'b1) & (bcount_v > 0))
                                    begin 
                                       shmem_write(shmem_addr_v, rx_st_data_128[(i * 8)+:8], 1); 
                                       shmem_addr_v = shmem_addr_v + 1; 
                                       bcount_v = bcount_v - 1; 
                                       // Byte Enables only valid on first data phase, bcount_v covers
                                       // the last data phase
                                       if ((bcount_v == 0) & (i < 15))        // mask out all bytes after last byte
                                       begin
                                          begin : xhdl_4
                                             integer j;
                                             for(j = i + 1; j <= 15; j = j + 1)
                                             begin
                                                byte_enb_128_v[j] = 1'b0; 
                                             end
                                          end // j
                                       end 
                                       // Now Handle the case if we are receiving data in this cycle
                                       if (rx_state_v == RXST_DATA_COMPL)
                                       begin
                                          compl_received_v[rx_compl_tag_v] = compl_received_v[rx_compl_tag_v] + 1; 
                                       end 
                                       if (((rx_be[i]) != 1'b1) & (DISABLE_RX_BE_CHECK == 0))
                                       begin
                                          dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, 
                                                       {"Root Port VC", dimage1(VC_NUM), 
                                                        " rx_be field: ", himage2(rx_be), 
                                                        " Mismatch. Expected: ", himage2(byte_enb_v)}); 
                                       end 
                                    end
                                    else
                                    begin
                                       if (((rx_be[i]) != 1'b0) & (DISABLE_RX_BE_CHECK == 0))
                                       begin
                                          dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, 
                                                       {"Root Port VC", dimage1(VC_NUM), 
                                                        " rx_be field: ", himage2(rx_be), 
                                                        " Mismatch. Expected: ", himage2(byte_enb_v)}); 
                                       end 
                                    end 
                                 end
                              end // i
                              // Enable all bytes in subsequent data phases
                              byte_enb_128_v = {16{1'b1}};  // 128 bit mode
                              // Last Packet phase
                              if ((rx_st_eop == 1'b1) && (rx_st_valid==1'b1))
                              begin   
                                 if (bcount_v > 0)
                                 begin
                                    dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, 
                                                 {"Root Port VC", dimage1(VC_NUM), 
                                                  " Rx Byte Count did not go to zero in last data phase. Remaining Bytes: ", 
                                                  dimage4(bcount_v)}); 
                                 end 
                                 if (rx_state_v == RXST_DATA_COMPL)
                                 begin
                                    rx_state_v = RXST_IDLE; 
                                    rx_st_ready_v = 1'b1;
                                    // If we have received all of the data (or more) 
                                    if (compl_received_v[rx_compl_tag_v] >= compl_expected_v[rx_compl_tag_v])
                                    begin
                                       // Error if more than expected
                                       if (compl_received_v[rx_compl_tag_v] > compl_expected_v[rx_compl_tag_v])
                                       begin
                                          dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, 
                                                       {"Root Port VC", dimage1(VC_NUM), 
                                                        " Received more completion data than expected. Expected: ", 
                                                        dimage4(compl_expected_v[rx_compl_tag_v]), 
                                                        " Received: ", dimage4(compl_received_v[rx_compl_tag_v])}); 
                                       end 
                                       // Report that it is complete to the Driver
                                       vc_intf_rpt_compl(rx_compl_tag_v, rx_compl_sts_v); 
                                       // Clear out that we expect anymore
                                       compl_received_v[rx_compl_tag_v] = -1; 
                                       compl_expected_v[rx_compl_tag_v] = -1; 
                                       rx_compl_tag_v = -1; 
                                    end
                                    else
                                    begin
                                       // Have not received all of the data yet, but if the
                                       // completion status is not Successful Completion then we
                                       // need to treat as done
                                       if (rx_compl_sts_v != 3'b000)
                                       begin
                                          // Report that it is complete to the Driver
                                          vc_intf_rpt_compl(rx_compl_tag_v, rx_compl_sts_v); 
                                          // Clear out that we expect anymore
                                          compl_received_v[rx_compl_tag_v] = -1; 
                                          compl_expected_v[rx_compl_tag_v] = -1; 
                                          rx_compl_tag_v = -1; 
                                       end 
                                    end
                                    // Otherwise keep going and wait for more data in another completion 
                                 end
                                 else 
                                 begin
                                    if (rx_state_v == RXST_DATA_NONP_WRITE)
                                    begin
                                       rx_st_ready_v = 1'b0;
                                       rx_state_v = RXST_NONP_REQ; 
                                    end
                                    else
                                    begin
                                       rx_state_v = RXST_IDLE; 
                                       rx_st_ready_v = 1'b1;
                                    end 
                                 end 
                              end
                              else
                              begin
                                 if (bcount_v == 0)
                                 begin
                                    dummy = ebfm_display(EBFM_MSG_ERROR_FATAL, 
                                                 {"Root Port VC", dimage1(VC_NUM), 
                                                  " Rx Byte Count went to zero before last data phase."}); 
                                 end 
                              end 
                           end 
                        end
               RXST_NONP_REQ :
                        begin
                           if (tx_rx_ack == 1'b1)
                           begin
                              rx_state_v = RXST_IDLE; 
                              rx_tx_req_v = 1'b0; 
                              rx_st_ready_v = 1'b1; 
                           end
                           else
                           begin
                              rx_tx_req_v = 1'b1; 
                              rx_state_v = RXST_NONP_REQ; 
                              rx_st_ready_v = 1'b0; 
                           end  
                        end
               default :
                        begin
                        end
            endcase 
         end 
         rx_state         <= rx_state_v ;   
         rx_tx_req        <= rx_tx_req_v ; 
         rx_tx_desc       <= rx_tx_desc_v ; 
         rx_tx_shmem_addr <= rx_tx_shmem_addr_v ; 
         rx_tx_bcount     <= rx_tx_bcount_v ; 
         rx_tx_byte_enb   <= rx_tx_byte_enb_v ; 
         rx_desc_int      <= rx_desc_int_v;
         rx_st_ready      <= rx_st_ready_v; 
         rx_update_pkt_count <= rx_update_pkt_count_v;
         rx_payld_length     <= rx_payld_length_v;
      end 
   end 

   always @(clk_in)
     begin : main_tx_state
      reg[32767:0] data_pkt_v; 
      integer dphases_v; 
      integer dptr_v; 
      reg[1:0] tx_state_v; 
      reg rx_mask_v;  
      reg[127:0] tx_desc_v; 
      reg[127:0] tx_desc;
      reg[127:0] tx_st_data_v;  
      reg tx_err_v; 
      reg tx_rx_ack_v; 
      integer lcladdr_v; 
      reg req_ack_cleared_v; 
      reg[127:0] req_desc_v; 
      reg req_valid_v; 
      reg[31:0] imm_data_v; 
      reg imm_valid_v; 
      integer exp_compl_tag_v; 
      integer exp_compl_bcount_v; 
      reg tx_st_sop_v;
      reg tx_st_eop_v;
      reg tx_st_valid_v;  
      reg last_req_was_cfg0;
      reg[4:0] time_from_last_sop;
      reg okay_to_transmit;
      reg [9:0] tx_payld_length_v;  
      reg[127:0] data_pkt_v_128;
      reg tx_st_empty_v;
      reg[11:0] tx_update_pkt_count_v;
      
      if (clk_in == 1'b1)
      begin
         // rising clock edge
         exp_compl_tag_v = -1; 
         exp_compl_bcount_v = 0; 
         if (rstn == 1'b0)
         begin
            // synchronous reset (active low)
            tx_state_v = TXST_IDLE; 
            rx_mask_v = 1'b1;  
            tx_desc_v = {128{1'b0}};  
            tx_st_data_v = {128{1'b0}};  
            tx_err_v = 1'b0; 
            tx_rx_ack_v = 1'b0;
            req_ack_cleared_v = 1'b1;
            tx_st_sop_v = 1'b0;
            tx_st_eop_v = 1'b0;
            tx_st_valid_v = 1'b0;
            last_req_was_cfg0 = 1'b0;
            time_from_last_sop = 5'h0;
            okay_to_transmit = 1'b0;
            tx_payld_length_v = 11'h0; 
            tx_update_pkt_count_v = 1'b0;
         end
         else
         begin 
            // for performance monitor
            tx_update_pkt_count_v = (tx_st_eop == 1'b1) & (tx_st_valid == 1'b1);
            if (tx_desc_v[126]==1'b1) begin
                if (tx_desc_v[105:96]==10'h0)
                    tx_payld_length_v <= 11'h400;   // 1024 DWs
                else
                    tx_payld_length_v <= {1'b0, tx_desc_v[105:96]};
            end 
            
            // Clear any previous acknowledgement if needed
            if (req_ack_cleared_v == 1'b0)
            begin
               req_ack_cleared_v = vc_intf_clr_ack(VC_NUM); 
            end 
             
            rx_mask_v = 1'b1; // This is on in most states 
            tx_rx_ack_v = 1'b0;  
            tx_st_valid_v = 1'b0;
            
            // keep track of the number of clk cycles
            // from the time an sop was transmitted.  
           
            if ((tx_st_sop==1'b1) & (tx_st_valid==1'b1)) 
                time_from_last_sop = 5'h0;
            else if (time_from_last_sop==5'h1F)
                time_from_last_sop = time_from_last_sop;
            else
                time_from_last_sop = time_from_last_sop + 1; 
            
            // after a CFG0 is transmitted, wait some time for
            // the tx_fifo_empty flag to respond.   
            okay_to_transmit=((last_req_was_cfg0==1'b0) | ((tx_fifo_empty==1'b1)& (time_from_last_sop > 5'd20)));

            
            case (tx_state_v)
               TXST_IDLE :
                        begin
                           if (tx_st_ready == 1'b1)
                           begin
                              tx_st_sop_v = 1'b0; 
                              tx_st_eop_v = 1'b0;
                              tx_st_empty_v = 1'b0;
                              if  ((rx_tx_req == 1'b1) & (okay_to_transmit==1'b1) )
                              begin 
                                 rx_mask_v = 1'b0; 
                                 tx_state_v = TXST_DESC; 
                                 tx_desc_v = rx_tx_desc;   
                                 tx_rx_ack_v = 1'b1; 
                                 // Assumes we are getting infinite credits!!!!!
                                 if (rx_tx_bcount > 0)
                                 begin
                                    tx_setup_data(rx_tx_shmem_addr, rx_tx_bcount, rx_tx_byte_enb, data_pkt_v, 
                                                  dphases_v, 1'b0, 32'h00000000); 
                                    dptr_v = 0;  
                                 end
                                 else
                                 begin  
                                    dphases_v = 0; 
                                 end 
                              end 
                              else begin
                                 vc_intf_get_req(VC_NUM, req_valid_v, req_desc_v, lcladdr_v, imm_valid_v, imm_data_v); 
                                 // wait for enough credits for all requests. 
                                 // if the last request was a CFG0, then also wait for the tx_fifo to empty 
                                 // before sending the next request.  
                                 if ((tx_fc_check(req_desc_v, tx_cred)) & (req_valid_v == 1'b1) & (req_ack_cleared_v == 1'b1) & 
                                     (okay_to_transmit==1'b1) )
                                 begin
                                    last_req_was_cfg0 = (req_desc_v[124:120]==5'b00100);
                                    vc_intf_set_ack(VC_NUM); 
                                    req_ack_cleared_v = vc_intf_clr_ack(VC_NUM); 
                                    tx_setup_req(req_desc_v, lcladdr_v, imm_valid_v, imm_data_v, data_pkt_v, dphases_v); 
                                    tx_state_v = TXST_DESC; 
                                    tx_desc_v = req_desc_v;    
                                    if (dphases_v > 0)
                                       dptr_v = 0; 

                                    if (is_non_posted(req_desc_v))
                                    begin
                                       exp_compl_tag_v = req_desc_v[79:72]; 
                                       if (has_data(req_desc_v))
                                       begin
                                          exp_compl_bcount_v = 0; 
                                       end
                                       else
                                       begin
                                          exp_compl_bcount_v = calc_byte_count(req_desc_v); 
                                       end 
                                    end 
                                 end
                                 else
                                 begin
                                    tx_state_v = TXST_IDLE; 
                                    rx_mask_v = 1'b0; 
                                 end 
                              end 
                           end 
                        end 
               TXST_DESC: begin   
                        if (tx_st_ready == 1'b1) begin 
                             tx_st_sop_v = 1'b1;
                             tx_st_valid_v = 1'b1;
                             // Payload with 3DW header, NonQW aligned address, 
                             // pack the first cycle of data with the 2nd 
                             // descriptor cycle
                             if ((dphases_v > 0) & (is_3dw_nonaligned(tx_desc_v))) begin 
                                 tx_st_data_v = {data_pkt_v[63:32], tx_desc_v[63:32], tx_desc_v[95:64], tx_desc_v[127:96]};   
                                 if (dphases_v > 1) begin
                                     tx_state_v = TXST_DATA;
                                 end
                                 else begin
                                     tx_state_v = TXST_IDLE;
                                     tx_st_eop_v = 1'b1;
                                 end
                                 dphases_v = dphases_v - 1;  
                                 dptr_v    = 0;  
                                 data_pkt_v = {64'h0, data_pkt_v[32767:64]};
                             end
                             // Payload with 4DW header, or QW aligned address,
                             // no desc/data packing
                             else if (dphases_v > 0) begin
                                 tx_st_data_v  = {tx_desc_v[31:0], tx_desc_v[63:32], tx_desc_v[95:64], tx_desc_v[127:96]};
                                 tx_state_v = TXST_DATA;   
                             end 
                             // No payload
                             else begin
                                 tx_st_data_v   = {tx_desc_v[31:0], tx_desc_v[63:32], tx_desc_v[95:64], tx_desc_v[127:96]};
                                 tx_state_v  = TXST_IDLE;  
                                 tx_st_eop_v = 1'b1;
                             end 
                        end 
               end
               TXST_DATA :
                        begin 
                           tx_st_sop_v = 1'b0; 
                           // Handle the Tx Data Signals 
                           if (dphases_v > 0)
                           begin
                              data_pkt_v_128 = data_pkt_v[(dptr_v*128)+:128];    
                              tx_st_data_v  = data_pkt_v_128;  
                              tx_state_v    = TXST_DATA; 
                              tx_st_eop_v   = (dphases_v<3) ? 1'b1 : 1'b0;
                              tx_st_valid_v = (tx_st_ready == 1'b1) ? 1'b1 : 1'b0;
                              tx_st_empty_v = (dphases_v==1) ? 1'b1 : 1'b0; 
                           end
                           else
                           begin
                              tx_st_data_v  = {128{1'b0}};  
                              tx_state_v = TXST_IDLE;   
                              tx_st_eop_v = 1'b0;
                              tx_st_valid_v = 1'b0;
                              tx_st_empty_v = 1'b0;
                           end  
                            
                           if (tx_st_ready == 1'b1) begin 
                               dphases_v     = (dphases_v<2) ? 0 : dphases_v - 2;   
                               dptr_v        = dptr_v + 1; 
                           end 
                           
                        
                       end
               default :
                        begin 
                        end
            endcase 
         end 
         tx_state <= tx_state_v ; 
         rx_mask <= rx_mask_v ;   
         tx_desc <= tx_desc_v ;    
         tx_err <= tx_err_v ; 
         tx_rx_ack <= tx_rx_ack_v ; 
         exp_compl_tag <= exp_compl_tag_v ; 
         exp_compl_bcount <= exp_compl_bcount_v ; 
         tx_st_eop <= tx_st_eop_v;
         tx_st_sop <= tx_st_sop_v;
         tx_st_empty <= tx_st_empty_v;
         tx_st_valid <= tx_st_valid_v;
         tx_st_data <= tx_st_data_v;
         tx_payld_length <= tx_payld_length_v; 
         tx_update_pkt_count <= tx_update_pkt_count_v;
      end 
   end 
 
endmodule
