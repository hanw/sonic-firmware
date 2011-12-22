//                              -*- Mode: Verilog -*-
// Filename        : sonic_vc_rx_chan.sv
// Description     : extract channel signal from TC field of the TLP packet header.
// Author          : Han Wang
// Created On      : Mon Dec 19 10:29:33 2011
// Last Modified By: Han Wang
// Last Modified On: Mon Dec 19 10:29:33 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!

/*
 * We use the TC field as the channel signal for the demultiplexer.
 * This module tracks the input packet stream, and extract the TC
 * information from the stream.
 */

module sonic_vc_rx_chan (/*AUTOARG*/
   // Inputs
   clk_in, rx_st_sop, rx_st_eop, rx_st_data, rx_st_err
   ) ;
   input clk_in; //250MHz
   input rx_st_sop;
   input rx_st_eop;
   input rx_st_data;
   input rx_st_err;
   output rx_chan;
      
endmodule // sonic_vc_rx_chan

