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


// $Id: //acds/rel/11.0/ip/sopc/components/verification/altera_avalon_st_monitor_bfm/altera_avalon_st_monitor.sv#1 $
// $Revision: #1 $
// $Date: 2011/02/14 $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_avalon_st_monitor
// =head1 SYNOPSIS
// Bridge with Avalon Bus Protocol Assertion Checker
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This module implements Avalon ST protocol assertion checking for simulation.
// The component acts as a simple repeater with Avalon bus signals 
// passed through from the sink to source interface.
// The instantiated altera_avalon_st_monitor snoops all passing Avalon
// bus signals and performs assertion checking and measures coverage on
// Avalon Streaming protocol properties.
// Transactions in transit may also be captured in a transaction buffer and
// extracted from the monitor via the API.
// The macro ALTERA_AVALON_SIM_SVA is defined to disable SVA processing
// The macro ENABLE_ALTERA_AVALON_TRANSACTION_RECORDING must be defined to 
// enable transaction monitoring
//-----------------------------------------------------------------------------

`timescale 1ns / 1ns

module altera_avalon_st_monitor(
                                clk,   
                               	reset,

                               	sink_data,
                               	sink_channel,
                               	sink_valid,
                               	sink_startofpacket,
                               	sink_endofpacket,
                               	sink_error,
                               	sink_empty, 
                               	sink_ready,
                               
                               	src_data,
                               	src_channel,
                               	src_valid,
                               	src_startofpacket,
                               	src_endofpacket,
                               	src_error,
                               	src_empty,
                               	src_ready
                               );
   
   // =head1 PARAMETERS
   parameter ST_SYMBOL_W       = 8;  // number of bits in one symbols    
   parameter ST_NUMSYMBOLS     = 4;  // number of symbols in one data  
   parameter ST_CHANNEL_W      = 0;  // width of channel signal
   parameter ST_ERROR_W        = 0;  // width of error signal
   parameter ST_EMPTY_W        = 0;  // width of empty signal, ST_EMPTY_W = log2(`ST_NUMSYMBOLS)
   
   parameter ST_READY_LATENCY  = 0;  // fixed ready latency in cycles
   parameter ST_MAX_CHANNELS   = 1;  // maximum number of channels 
   
   parameter USE_PACKET        = 0;  // data transfer in packet format
   parameter USE_CHANNEL       = 0;  // use channel port
   parameter USE_ERROR         = 0;  // use error port
   parameter USE_READY         = 1;  // use ready port
   parameter USE_VALID         = 1;  // use valid port
   parameter USE_EMPTY         = 0;  // use empty port
   parameter ST_BEATSPERCYCLE  = 1;  // Max number of packets per cycle
   
   parameter ST_MAX_PACKET_SIZE = 1; // Max number of packet size covered
   
   localparam ST_DATA_W        = ST_SYMBOL_W * ST_NUMSYMBOLS;
   localparam ST_MDATA_W       = ST_BEATSPERCYCLE * ST_DATA_W;
   localparam ST_MCHANNEL_W    = ST_BEATSPERCYCLE * ST_CHANNEL_W;
   localparam ST_MERROR_W      = ST_BEATSPERCYCLE * ST_ERROR_W;
   localparam ST_MEMPTY_W      = ST_BEATSPERCYCLE * ST_EMPTY_W;   
   
   localparam TAP_W = ((ST_DATA_W == 0)? 1:ST_DATA_W) +        // data
                      ((ST_CHANNEL_W == 0)? 1:ST_CHANNEL_W) +  // channel
                      1 +                                      // valid
                      1 +                                      // startofpacket
                      1 +                                      // endofpacket
                      ((ST_ERROR_W == 0)? 1:ST_ERROR_W) +      // error
                      ((ST_EMPTY_W == 0)? 1:ST_EMPTY_W) +      // empty
                      1;                                       // ready
   
   localparam MTAP_W = ST_BEATSPERCYCLE*TAP_W; 
      
   // =head1 PINS   
   // =head2 Clock Interface
   input                            clk;
   input                            reset;

   // =head2 Avalon Streaming Sink Interface    
   input [lindex(ST_MDATA_W)        : 0]  sink_data;
   input [lindex(ST_MCHANNEL_W)     : 0]  sink_channel;
   input [lindex(ST_BEATSPERCYCLE)  : 0]  sink_valid;
   input [lindex(ST_BEATSPERCYCLE)  : 0]  sink_startofpacket;
   input [lindex(ST_BEATSPERCYCLE)  : 0]  sink_endofpacket;
   input [lindex(ST_MERROR_W)       : 0]  sink_error;
   input [lindex(ST_MEMPTY_W)       : 0]  sink_empty; 
   output                                 sink_ready;

   // =head2 Avalon Streaming Source Interface 
   output [lindex(ST_MDATA_W)       : 0]  src_data;
   output [lindex(ST_MCHANNEL_W)    : 0]  src_channel;
   output [lindex(ST_BEATSPERCYCLE) : 0]  src_valid;
   output [lindex(ST_BEATSPERCYCLE) : 0]  src_startofpacket;
   output [lindex(ST_BEATSPERCYCLE) : 0]  src_endofpacket;
   output [lindex(ST_MERROR_W)      : 0]  src_error;
   output [lindex(ST_MEMPTY_W)      : 0]  src_empty;    
   input                                  src_ready;          

   // =cut

   function int lindex;
      // returns the left index for a vector having a declared width 
      // when width is 0, then the left index is set to 0 rather than -1
      input [31:0] width;
      lindex = (width > 0) ? (width-1) : 0;
   endfunction   

   // outputs
   logic                                  sink_ready;
   logic [lindex(ST_MDATA_W)        : 0]  src_data;
   logic [lindex(ST_MCHANNEL_W)     : 0]  src_channel;
   logic [lindex(ST_BEATSPERCYCLE)  : 0]  src_valid;
   logic [lindex(ST_BEATSPERCYCLE)  : 0]  src_startofpacket;
   logic [lindex(ST_BEATSPERCYCLE)  : 0]  src_endofpacket;
   logic [lindex(ST_MERROR_W)       : 0]  src_error;
   logic [lindex(ST_MEMPTY_W)       : 0]  src_empty;    
   
   logic [(MTAP_W)-ST_BEATSPERCYCLE : 0]  tap;
   
   always @(*) begin
      sink_ready        <= src_ready;
      src_data          <= sink_data; 
      src_channel       <= sink_channel;
      src_valid         <= sink_valid;
      src_startofpacket <= sink_startofpacket;
      src_endofpacket   <= sink_endofpacket;
      src_error         <= sink_error;
      src_empty         <= sink_empty;

      tap <=  {
              sink_data,
              sink_channel,
              sink_valid,
              sink_startofpacket,
              sink_endofpacket,
              sink_error,
              sink_empty,
              src_ready 
              };        
   end
   
   //--------------------------------------------------------------------------
   // =head1 ALTERA_AVALON_ST_MONITOR_ASSERTION
   // This module implements Avalon-ST protocol simulation assertion checkers
   // =cut
   //--------------------------------------------------------------------------
   altera_avalon_st_monitor_assertion
     #(
       .ST_SYMBOL_W     (ST_SYMBOL_W),
       .ST_NUMSYMBOLS   (ST_NUMSYMBOLS),
       .ST_CHANNEL_W    (ST_CHANNEL_W),
       .ST_ERROR_W      (ST_ERROR_W),
       .ST_EMPTY_W      (ST_EMPTY_W),

       .ST_READY_LATENCY(ST_READY_LATENCY),
       .ST_MAX_CHANNELS (ST_MAX_CHANNELS),
       .ST_BEATSPERCYCLE(ST_BEATSPERCYCLE),

       .USE_PACKET      (USE_PACKET),
       .USE_CHANNEL     (USE_CHANNEL),    
       .USE_ERROR       (USE_ERROR),   
       .USE_READY       (USE_READY),     
       .USE_VALID       (USE_VALID),     
       .USE_EMPTY       (USE_EMPTY)
       )
     monitor_assertion (
                        .clk    (clk),
                        .reset  (reset),
                        .tap    (tap)
                       );

   //--------------------------------------------------------------------------
   // =head1 ALTERA_AVALON_ST_MONITOR_COVERAGE
   // This module implements Avalon-ST protocol functional coverage measurements
   // =cut
   //--------------------------------------------------------------------------
   altera_avalon_st_monitor_coverage
     #(
       .ST_SYMBOL_W        (ST_SYMBOL_W),
       .ST_NUMSYMBOLS      (ST_NUMSYMBOLS),
       .ST_CHANNEL_W       (ST_CHANNEL_W),
       .ST_ERROR_W         (ST_ERROR_W),
       .ST_EMPTY_W         (ST_EMPTY_W),
       .ST_BEATSPERCYCLE   (ST_BEATSPERCYCLE),
       
       .ST_READY_LATENCY   (ST_READY_LATENCY),
       .ST_MAX_CHANNELS    (ST_MAX_CHANNELS),

       .USE_PACKET         (USE_PACKET),
       .USE_CHANNEL        (USE_CHANNEL),    
       .USE_ERROR          (USE_ERROR),   
       .USE_READY          (USE_READY),     
       .USE_VALID          (USE_VALID),     
       .USE_EMPTY          (USE_EMPTY),
       .ST_MAX_PACKET_SIZE (ST_MAX_PACKET_SIZE)
       )
     monitor_coverage (
                        .clk    (clk),
                        .reset  (reset),
                        .tap    (tap)
                       );

   //--------------------------------------------------------------------------
   // =head1 ALTERA_AVALON_ST_MONITOR_TRANSACTIONS
   // This module implements Avalon-ST the transaction recorder.
   // =cut
   //--------------------------------------------------------------------------

   `ifdef ENABLE_ALTERA_AVALON_TRANSACTION_RECORDING
   altera_avalon_st_monitor_transactions
     #(
       .ST_SYMBOL_W        (ST_SYMBOL_W),
       .ST_NUMSYMBOLS      (ST_NUMSYMBOLS),
       .ST_CHANNEL_W       (ST_CHANNEL_W),
       .ST_ERROR_W         (ST_ERROR_W),
       .ST_EMPTY_W         (ST_EMPTY_W),
       .ST_BEATSPERCYCLE   (ST_BEATSPERCYCLE),
       
       .ST_READY_LATENCY   (ST_READY_LATENCY),
       .ST_MAX_CHANNELS    (ST_MAX_CHANNELS),

       .USE_PACKET         (USE_PACKET),
       .USE_CHANNEL        (USE_CHANNEL),    
       .USE_ERROR          (USE_ERROR),   
       .USE_READY          (USE_READY),     
       .USE_VALID          (USE_VALID),     
       .USE_EMPTY          (USE_EMPTY),
       .ST_MAX_PACKET_SIZE (ST_MAX_PACKET_SIZE)
       )
     monitor_trans (
                    .clk    (clk),
                    .reset  (reset),
                    .tap    (tap)
                    );
   `endif
   
   // synthesis translate_off
   import verbosity_pkg::*;

   localparam VERSION = "__ACDS_VERSION_SHORT__";

   function automatic void hello();
      // introduction message to the console      
      string message;
      $sformat(message, "%m: - Hello from altera_avalon_st_monitor");
      print(VERBOSITY_INFO, message);            
      `ifdef DISABLE_ALTERA_AVALON_SIM_SVA
      $sformat(message, "%m: -   Assertions disabled (DISABLE_ALTERA_AVALON_SIM_SVA defined)");
      `else
      $sformat(message, "%m: -   Assertions enabled (DISABLE_ALTERA_AVALON_SIM_SVA undefined)");      
      `endif
      print(VERBOSITY_INFO, message);      
      $sformat(message, "%m: -   $Revision: #1 $");
      print(VERBOSITY_INFO, message);            
      $sformat(message, "%m: -   $Date: 2011/02/14 $");
      print(VERBOSITY_INFO, message);      
      print_divider(VERBOSITY_INFO);
   endfunction

   initial begin
      hello();
   end
   
   // synthesis translate_on
   
endmodule 
