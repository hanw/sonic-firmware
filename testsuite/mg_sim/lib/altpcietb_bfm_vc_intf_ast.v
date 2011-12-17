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
// Title         : PCI Express BFM with Avalon-ST Root Port
// Project       : PCI Express MegaCore function
//-----------------------------------------------------------------------------
// File          : altpcietb_bfm_vc_intf_ast.v
// Author        : Altera Corporation
//-----------------------------------------------------------------------------
// Description :
// This entity is the entire PCI Ecpress Root Port BFM
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

module altpcietb_bfm_vc_intf_ast (clk_in, rstn,
                                  rx_mask,  rx_st_be,  rx_st_sop, rx_st_eop, rx_st_empty, rx_st_data, rx_st_valid, rx_st_ready,
                                  tx_cred, tx_st_ready, tx_st_sop, tx_st_eop, tx_st_empty, tx_st_valid, tx_st_data, tx_fifo_empty,
                                  cfg_io_bas, cfg_np_bas, cfg_pr_bas);


   parameter VC_NUM = 0;
   parameter AVALON_ST_128 = 0;
   parameter ECRC_FORWARD_CHECK = 1;
   parameter ECRC_FORWARD_GENER = 1;

   input            clk_in;
   input            rstn;
   output           rx_mask;
   input[35:0]      tx_cred;
   input[19:0]      cfg_io_bas;
   input[11:0]      cfg_np_bas;
   input[43:0]      cfg_pr_bas;
   input            rx_st_sop;
   input            rx_st_valid;
   output           rx_st_ready;
   input            rx_st_eop;
   input            rx_st_empty;
   input[127:0]     rx_st_data;
   input[15:0]      rx_st_be;
   input            tx_st_ready;
   output           tx_st_sop;
   output           tx_st_eop;
   output           tx_st_empty;
   output           tx_st_valid;
   output[127:0]    tx_st_data;
   input            tx_fifo_empty;

   wire    [ 81: 0] rx_stream_data_0;
   wire    [ 81: 0] rx_stream_data_1;

   // RX FIFO
   wire             rx_st_sop_int;
   wire             rx_st_eop_int;
   wire             rx_st_empty_int;
   wire[127:0]      rx_st_data_int;
   wire[15:0]       rx_st_be_int;
   wire             rx_st_ready_int;
   wire             rx_valid_int;
   wire[7:0]        rx_st_bardec;
   wire             empty;
   wire             almost_full;
   wire[19:0]       unused_st;

   wire             tx_st_ready_int;
   wire[127:0]      tx_st_data_int;
   wire             tx_st_sop_int;
   wire             tx_st_eop_int;
   wire             tx_st_empty_int;
   wire             tx_st_valid_int;

   wire    [ 81: 0] rx_stream_data_0_int;
   wire    [ 81: 0] rx_stream_data_1_int;
   wire             rx_st_valid_int;

   wire             rx_ecrc_check_valid;
   wire[15:0]       ecrc_bad_cnt;
   reg              ecrc_err;

   assign rx_st_bardec = 8'h0;

   always @ (posedge clk_in or negedge rstn) begin
       if (rstn==1'b0)
           ecrc_err <= 1'b0;
       else begin
           if (ecrc_bad_cnt > 0)
               ecrc_err <= 1'b1;    // assert and hold when ecrc error is detected
       end

   end



  //////////////////////////////////////////////////////////////
  // RECEIVE RX AVALON-ST INPUT
  // If ECRC Forwarding is enabled, then first route thru the
  // ECRC checker to remove ECRC from data stream.
  //////////////////////////////////////////////////////////////

   generate begin: rx_ecrc_genblk

       wire    [ 81: 0] rx_stream_data_0_ecrc;
       wire    [ 81: 0] rx_stream_data_1_ecrc;
       wire             rx_st_valid_ecrc;
       wire             rx_st_ready_ecrc;
       wire[15:0]       rx_st_be_ecrc;
       wire[7:0]        rx_st_bardec_ecrc;
       wire             rx_st_sop_ecrc;
       wire             rx_st_eop_ecrc;
       wire             rx_st_empty_ecrc;
       wire [139:0]     rx_st_data_ecrc;

       ///////////////////////////////////////////////
       // RX ECRC CHECKING
       // ECRC is checked and removed from the data
       ///////////////////////////////////////////////
       if (ECRC_FORWARD_CHECK==1) begin: rx_ecrc

           altpcierd_cdma_ecrc_check #(.AVALON_ST_128(AVALON_ST_128)) cdma_ecrc_check(
                // Input Avalon-ST prior to check ECRC
                .rxdata                ({rx_st_sop, 1'b0, rx_st_empty, rx_st_eop, rx_st_bardec, rx_st_data}),
                .rxdata_be             (rx_st_be),
                .rx_stream_ready0      (~almost_full),
                .rx_stream_valid0      (rx_st_valid),

                // Output Avalon-ST after checking ECRC
                .rxdata_ecrc           (rx_st_data_ecrc),
                .rxdata_be_ecrc        (rx_st_be_ecrc),
                .rx_stream_ready0_ecrc (rx_st_ready_ecrc),
                .rx_stream_valid0_ecrc (rx_st_valid_ecrc),

                .rx_ecrc_check_valid   (rx_ecrc_check_valid),
                .ecrc_bad_cnt          (ecrc_bad_cnt),
                .clk_in                (clk_in),
                .srst                  (~rstn)
               );

 /*
          // Simulation Monitor
           initial begin
               wait (rstn==1);
               wait (ecrc_bad_cnt==0);
               wait (ecrc_bad_cnt>0);
               $display (" >>>>  RP:  BAD ECRC RECEIVED <<<<");
           end
*/
           ///////////////////////////////////////////////
           // ECRC sources data to VCINTF (via RX FIFO)

           assign rx_st_bardec_ecrc = rx_st_data_ecrc[135:128];
           assign rx_st_sop_ecrc    = rx_st_data_ecrc[139];
           assign rx_st_eop_ecrc    = rx_st_data_ecrc[136];
           assign rx_st_empty_ecrc  = rx_st_data_ecrc[137];

           assign rx_stream_data_0_int =  {rx_st_be_ecrc[7:0], rx_st_sop_ecrc, rx_st_eop_ecrc, rx_st_bardec_ecrc, rx_st_data_ecrc[63:0]};
           assign rx_stream_data_1_int =  {rx_st_be_ecrc[15:8], 1'b0, rx_st_empty_ecrc, 8'h0, rx_st_data_ecrc[127:64]};
           assign rx_st_valid_int      =  rx_st_valid_ecrc;
           assign rx_st_ready          =  rx_st_ready_ecrc;

       end

       ///////////////////////////
       //  NO ECRC FORWARDING
       ///////////////////////////
       else begin
           /////////////////////////////////////////////////////////////
           // Avalon-ST IO sources data to VCINTF (via RX FIFO)

           assign rx_stream_data_0_int =  {rx_st_be[7:0], rx_st_sop, rx_st_eop, rx_st_bardec, rx_st_data[63:0]};
           assign rx_stream_data_1_int =  {rx_st_be[15:8], 1'b0, rx_st_empty, 8'h0, rx_st_data[127:64]};
           assign rx_st_valid_int      =  rx_st_valid;
           assign rx_st_ready          =  ~almost_full;
           assign rx_ecrc_check_valid  = 0;
           assign ecrc_bad_cnt         = 0;
       end
       end
   endgenerate


   //////////////////////////////////////////////////////////////////////
   // RX FIFO
   // Avalon-ST data is held in a FIFO until RP (VC INTF) can process it
   //////////////////////////////////////////////////////////////////////


   // FIFO parameters
   parameter  RXFIFO_DEPTH = 32;
   parameter  RXFIFO_WIDTH = 164;
   parameter  RXFIFO_WIDTHU = 5;

   scfifo # (
             .add_ram_output_register ("OFF")          ,
             .intended_device_family  ("Stratix II GX"),
             .lpm_numwords            (RXFIFO_DEPTH),
             .lpm_showahead           ("ON")          ,
             .lpm_type                ("scfifo")       ,
             .lpm_width               (RXFIFO_WIDTH) ,
             .lpm_widthu              (RXFIFO_WIDTHU),
             .overflow_checking       ("OFF")           ,
             .underflow_checking      ("OFF")           ,
             .almost_full_value       (RXFIFO_DEPTH/2) ,
             .use_eab                 ("OFF")

             ) rx_data_fifo (
            .clock ( clk_in),
            .sclr  (~rstn ),

            .data  ({rx_stream_data_1_int, rx_stream_data_0_int}),
            .wrreq (rx_st_valid_int),

            .rdreq (rx_st_ready_int & ~empty),
            .q     ({  rx_st_be_int[15:8], unused_st[16], rx_st_empty_int, unused_st[15:8], rx_st_data_int[127:64],
                       rx_st_be_int[7:0], rx_st_sop_int, rx_st_eop_int, unused_st[7:0], rx_st_data_int[63:0]

                    }),

            .empty (empty),
            .full  ( ),
            .usedw ()
            // synopsys translate_off
            ,
            .aclr (1'b0),
            .almost_empty (),
            .almost_full (almost_full)
            // synopsys translate_on
            );



   ////////////////////////////////////////////////////////////////////////
   // VC INTERFACE MODULE
   // Receives, Generates, and Processes RP traffic.
   //
   // Instantiate 128-bit Avalon-ST version, or 64-bit Avalon-ST version.
   /////////////////////////////////////////////////////////////////////////

     assign rx_valid_int = ~empty;

     generate begin: vc_intf_genblk

      if (AVALON_ST_128==1) begin: vc_intf_128_genblk

         altpcietb_bfm_vc_intf_128 #(.VC_NUM (VC_NUM)) vc_intf_128(
           .clk_in        (clk_in),
           .rstn          (rstn),
           .rx_mask       (rx_mask),
           .rx_be         (rx_st_be_int),
           .rx_ecrc_err   (ecrc_err),
           .tx_cred       (tx_cred),
           .tx_st_ready   (tx_st_ready_int),
           .cfg_io_bas    (cfg_io_bas),
           .cfg_np_bas    (cfg_np_bas),
           .cfg_pr_bas    (cfg_pr_bas),
           .rx_st_sop     (rx_st_sop_int),
           .rx_st_eop     (rx_st_eop_int),
           .rx_st_empty   (rx_st_empty_int),
           .rx_st_data    (rx_st_data_int[127:0]),
           .rx_st_valid   (rx_valid_int),
           .rx_st_ready   (rx_st_ready_int),
           .tx_st_sop     (tx_st_sop_int),
           .tx_st_eop     (tx_st_eop_int),
           .tx_st_empty   (tx_st_empty_int),
           .tx_st_data    (tx_st_data_int),
           .tx_st_valid   (tx_st_valid_int),
           .tx_fifo_empty (tx_fifo_empty)
        );

     end
     else begin: vc_intf_64_genblk

        altpcietb_bfm_vc_intf_64 #(.VC_NUM (VC_NUM)) vc_intf_64(
           .clk_in        (clk_in),
           .rstn          (rstn),
           .rx_mask       (rx_mask),
           .rx_be         (rx_st_be_int),
           .rx_ecrc_err   (ecrc_err),
           .tx_cred       (tx_cred),
           .cfg_io_bas    (cfg_io_bas),
           .cfg_np_bas    (cfg_np_bas),
           .cfg_pr_bas    (cfg_pr_bas),
           .rx_st_sop     (rx_st_sop_int),
           .rx_st_eop     (rx_st_eop_int),
           .rx_st_empty   (rx_st_empty_int),
           .rx_st_data    (rx_st_data_int[63:0]),
           .rx_st_valid   (rx_valid_int),
           .rx_st_ready   (rx_st_ready_int),
           .tx_st_sop     (tx_st_sop_int),
           .tx_st_eop     (tx_st_eop_int),
           .tx_st_empty   (tx_st_empty_int),
           .tx_st_data    (tx_st_data_int[63:0]),
           .tx_st_valid   (tx_st_valid_int),
           .tx_st_ready   ((tx_st_ready_int)),
           .tx_fifo_empty (tx_fifo_empty)
        );

     end
    end
  endgenerate



  ////////////////////////////////////////////////////////////////
  // DRIVE AVALON-ST TX OUTPUT
  // If ECRC FORWARDING is enabled, then calculate and append
  // the ECRC to the Avalon-ST output.
  ///////////////////////////////////////////////////////////////

   generate begin: tx_ecrc_genblk
      ////////////////////////////////////////////////////////////
      // ECRC FORWARDING
      // ECRC is calculated and appended to the VC INTF traffic
      // if ECRC forwarding is enabled.

      if (ECRC_FORWARD_GENER==1) begin: tx_ecrc
          // ECRC output side
          wire[127:0] tx_st_data_ecrc;
          wire        tx_st_sop_ecrc;
          wire        tx_st_eop_ecrc;
          wire        tx_st_empty_ecrc;
          wire[73:0]  tx_st_data_ecrc0;
          wire[73:0]  tx_st_data_ecrc1;
          wire        tx_st_ready_ecrc;
          wire        tx_st_valid_ecrc;

          // ECRC input side
          reg[127:0]  user_data_reg;
          reg         user_valid_reg;
          reg         user_sop_reg;
          reg         user_eop_reg;
          reg         user_empty_reg;

          wire[127:0] user_data_ecrc;
          wire        user_valid_ecrc;
          wire        user_sop_ecrc;
          wire        user_eop_ecrc;
          wire        user_empty_ecrc;
          reg         tx_st_ready_ecrc_reg;

          ///////////////////////////////////////////////////////////////
          // Glue logic to hold the vc_intf signals until it is 'acked'
          // by the ecrc module  (via tx_st_ready_ecrc).
          /*
                   ECRC Interface:
                                        ________     ________________
                       tx_st_ready_ecrc (ack)   |___|
                                             ________________________
                       user_valid_ecrc  ____|
                                        ______________________________
                       user_data_ecrc   ____|_0_|_1_____|_2_|_3_|_4_|_
          */

          always @ (posedge clk_in or negedge rstn) begin
              if (rstn==1'b0) begin
                      user_data_reg  <= 0;
                      user_valid_reg <= 0;
                      user_sop_reg  <= 0;
                      user_eop_reg  <= 0;
                      user_empty_reg  <= 0;
                      tx_st_ready_ecrc_reg <= 0;
              end
              else begin
                  if ((tx_st_ready_ecrc==1'b0) & (tx_st_ready_ecrc_reg==1'b1)) begin
                      user_data_reg  <= {tx_st_data_int[31:0],tx_st_data_int[63:32], tx_st_data_int[95:64],tx_st_data_int[127:96]};
                      user_valid_reg <= tx_st_valid_int;
                      user_sop_reg   <= tx_st_sop_int;
                      user_eop_reg   <= tx_st_eop_int;
                      user_empty_reg <= tx_st_empty_int;
                  end
                  tx_st_ready_ecrc_reg <= tx_st_ready_ecrc;
              end
          end

          assign user_data_ecrc  = ((tx_st_ready_ecrc_reg==0) & (tx_st_ready_ecrc==1'b1)) ? user_data_reg :
                                   {tx_st_data_int[31:0],tx_st_data_int[63:32], tx_st_data_int[95:64],tx_st_data_int[127:96]} ;

          assign user_valid_ecrc = ((tx_st_ready_ecrc_reg==0) & (tx_st_ready_ecrc==1'b1)) ?  user_valid_reg :  tx_st_valid_int;

          assign user_sop_ecrc   = ((tx_st_ready_ecrc_reg==0) & (tx_st_ready_ecrc==1'b1)) ?  user_sop_reg :  tx_st_sop_int;

          assign user_eop_ecrc   = ((tx_st_ready_ecrc_reg==0) & (tx_st_ready_ecrc==1'b1)) ? user_eop_reg  : tx_st_eop_int;
          assign user_empty_ecrc = ((tx_st_ready_ecrc_reg==0) & (tx_st_ready_ecrc==1'b1)) ? user_empty_reg  : tx_st_empty_int;


          /////////////////////////////
          // TX ECRC MODULE
          // ecrc generate and append

          altpcierd_cdma_ecrc_gen  #(.AVALON_ST_128(AVALON_ST_128))
             cdma_ecrc_gen (
               .clk               (clk_in),
               .rstn              (rstn),
               .user_rd_req       (tx_st_ready_ecrc),
               .user_sop          (user_sop_ecrc),
               .user_eop          ({user_eop_ecrc, user_empty_ecrc}),
               .user_data         (user_data_ecrc),
               .user_valid        (user_valid_ecrc),
               .tx_stream_ready0  (tx_st_ready),
               .tx_stream_data0_0 (tx_st_data_ecrc0),
               .tx_stream_data0_1 (tx_st_data_ecrc1),
               .tx_stream_valid0  (tx_st_valid_ecrc));

           ///////////////////////////
           // Drive Avalon-ST output

           assign tx_st_data[63:0]   = {tx_st_data_ecrc0[31:0], tx_st_data_ecrc0[63:32]};
           assign tx_st_empty        = tx_st_data_ecrc0[73];
           assign tx_st_sop          = tx_st_data_ecrc0[72];
          // assign tx_st_data[132]  = 1'b0;
           assign tx_st_eop          = tx_st_data_ecrc1[73];
          // assign tx_st_data[129]  = tx_st_data_ecrc1[72];
           assign tx_st_data[127:64] = {tx_st_data_ecrc1[31:0], tx_st_data_ecrc1[63:32]};
           assign tx_st_ready_int    = tx_st_ready_ecrc;
           assign tx_st_valid        = tx_st_valid_ecrc;
      end

      ////////////////////////////////////////////////////
      // NO ECRC FORWARDING
      // Wire directly from vc_intf

      else begin
           assign tx_st_data      =  tx_st_data_int;
           assign tx_st_eop       =  tx_st_eop_int;
           assign tx_st_sop       =  tx_st_sop_int;
           assign tx_st_empty     =  tx_st_empty_int;
           assign tx_st_ready_int =  tx_st_ready;
           assign tx_st_valid     =  tx_st_valid_int;
      end
   end
   endgenerate




endmodule


