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


// $File: //acds/main/ip/sopc/components/verification/altera_avalon_st_monitor_bfm/altera_avalon_st_monitor_tap.sv $
// $Revision: #7 $
// $Date: 2009/04/16 $
// $Author: pscheidt $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_avalon_st_monitor_assertion
// =head1 SYNOPSIS
// Streaming Avalon Bus Protocol Checker
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This module implements Avalon ST protocol assertion checking for simulation.
//-----------------------------------------------------------------------------

`timescale 1ns / 1ns

module altera_avalon_st_monitor_assertion(
                                          clk,
                                          reset,
                                          tap
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
   
   localparam ST_DATA_W        = ST_SYMBOL_W * ST_NUMSYMBOLS;
   localparam ST_MAX_EMPTY     = 2**(ST_EMPTY_W) - 1;
   localparam NUM_CHANNEL      = (ST_MAX_CHANNELS > 1)? ST_MAX_CHANNELS:1;

   localparam TAP_W = ((ST_DATA_W == 0)? 1:ST_DATA_W) +        // data
                      ((ST_CHANNEL_W == 0)? 1:ST_CHANNEL_W) +  // channel
                      1 +                                      // valid
                      1 +                                      // startofpacket
                      1 +                                      // endofpacket
                      ((ST_ERROR_W == 0)? 1:ST_ERROR_W) +      // error
                      ((ST_EMPTY_W == 0)? 1:ST_EMPTY_W) +      // empty
                      1;                                       // ready
   
   // =head1 PINS   
   // =head2 Clock Interface
   input                                             clk;
   input                                             reset; 

   // =head2 Avalon Monitor Interface - will be defined as Streaming Sink
   input  [(TAP_W*ST_BEATSPERCYCLE)-ST_BEATSPERCYCLE:0]         tap;        

   // =cut

   function int lindex;
      // returns the left index for a vector having a declared width 
      // when width is 0, then the left index is set to 0 rather than -1
      input [31:0] width;
      lindex = (width > 0) ? (width-1) : 0;
   endfunction  

   //-------------------------------------------------------------------------- 
   // synthesis translate_off

   import verbosity_pkg::*;
   
   typedef bit [lindex(ST_DATA_W)     :0] STData_t;
   typedef bit [lindex(ST_CHANNEL_W)  :0] STChannel_t;
   typedef bit [lindex(ST_EMPTY_W)    :0] STEmpty_t;
   typedef bit [lindex(ST_ERROR_W)    :0] STError_t;

   event                        signal_fatal_error; 

   event                        event_a_valid_legal;
   event                        event_a_empty_legal;
   event                        event_a_no_data_outside_packet;
   event                        event_a_non_missing_endofpacket;
   event                        event_a_non_missing_startofpacket;
   event                        event_a_less_than_max_channel;

   string                       fatal_message = "*unitialized*";
   string                       message       = "*unitialized*";

   bit                          enable_a_valid_legal = 1;
   bit                          enable_a_empty_legal = 1;
   bit                          enable_a_no_data_outside_packet = 1;
   bit                          enable_a_non_missing_endofpacket = 1;
   bit                          enable_a_non_missing_startofpacket = 1;
   bit                          enable_a_less_than_max_channel = 1;

   //--------------------------------------------------------------------------
   // unpack Avalon bus interface tap into individual port signals
   logic                                                       ready;
   logic [lindex(ST_BEATSPERCYCLE):0][lindex(ST_DATA_W):0]     data;
   logic [lindex(ST_BEATSPERCYCLE):0][lindex(ST_CHANNEL_W):0]  channel;
   logic [lindex(ST_BEATSPERCYCLE):0]                          valid;
   logic [lindex(ST_BEATSPERCYCLE):0]                          startofpacket;
   logic [lindex(ST_BEATSPERCYCLE):0]                          endofpacket;
   logic [lindex(ST_BEATSPERCYCLE):0][lindex(ST_ERROR_W):0]    error;
   logic [lindex(ST_BEATSPERCYCLE):0][lindex(ST_EMPTY_W):0]    empty;    

   always_comb begin
      data           <= tap[lindex(ST_DATA_W*ST_BEATSPERCYCLE)+lindex(ST_CHANNEL_W*ST_BEATSPERCYCLE)+
                        lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+3*ST_BEATSPERCYCLE+4:
                        lindex(ST_CHANNEL_W*ST_BEATSPERCYCLE)+lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+3*ST_BEATSPERCYCLE+4];
      
      channel        <= (USE_CHANNEL == 1)? 
                        tap[lindex(ST_CHANNEL_W*ST_BEATSPERCYCLE)+lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+
                        lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+3*ST_BEATSPERCYCLE+3:
                        lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+3*ST_BEATSPERCYCLE+3] : 0;
      
      valid          <= (USE_VALID == 1)? 
                        tap[lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+3*ST_BEATSPERCYCLE+2:
                        lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+2*ST_BEATSPERCYCLE+3] : 1;
      
      startofpacket  <= (USE_PACKET == 1)? 
                        tap[lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+2*ST_BEATSPERCYCLE+2:
                        lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+ST_BEATSPERCYCLE+3] : 0;
      
      endofpacket    <= (USE_PACKET == 1)? 
                        tap[lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+ST_BEATSPERCYCLE+2:
                        lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+3] : 0;
      
      error          <= (USE_ERROR == 1)? 
                        tap[lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+2:
                        lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+2] : 0;
      
      empty          <= (USE_EMPTY == 1)? tap[lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+1:1] : 0;
      
      ready          <= (USE_READY == 1)? tap[0:0] : 1;
   end

   //--------------------------------------------------------------------------   
   // General Statistics Counters
   //--------------------------------------------------------------------------   

   logic [31:0]                        clock_counter;
   logic [31:0]                        sop_counter;
   logic [31:0]                        eop_counter;

   logic                               sop_counter_reset = 0;
   logic                               eop_counter_reset = 0;
   logic [255:0]                       sop_channel_used = '0;
   logic [255:0]                       eop_channel_used = '1;
   logic [lindex(ST_BEATSPERCYCLE):0]  sop_error_in_channel = '0;
   logic [lindex(ST_BEATSPERCYCLE):0]  eop_error_in_channel = '0;
   logic [lindex(ST_BEATSPERCYCLE):0]  data_outside_packet = '0;

   always @(posedge clk) begin
      if (reset) 
         clock_counter <= 0;
      else
         clock_counter <= clock_counter + 1;
   end

   always @(posedge clk) begin
      if (reset) begin
         sop_counter <= 0;
      end else if (sop_counter_reset) begin
         sop_counter_reset <= 0;
         sop_counter <= 0;	 
      end else begin
         for (int i=0; i<ST_BEATSPERCYCLE; i++) begin
            if ((USE_VALID && valid[i]) || !USE_VALID) begin
               if ((ST_READY_LATENCY > 0) || (USE_READY && (ST_READY_LATENCY == 0) && ready) || !USE_READY) begin
                  sop_counter <= (USE_PACKET && valid[i] && startofpacket[i]) ? sop_counter + 1 : sop_counter;
               end
            end
         end
      end
   end

   always @(posedge clk) begin
      if (reset) begin
         eop_counter <= 0;
      end else if (eop_counter_reset) begin
         eop_counter_reset <= 0;
         eop_counter <= 0;
      end else begin
         for (int i=0; i<ST_BEATSPERCYCLE; i++) begin
            if ((USE_VALID && valid[i]) || !USE_VALID) begin
               if ((ST_READY_LATENCY > 0) || (USE_READY && (ST_READY_LATENCY == 0) && ready) || !USE_READY) begin
                  eop_counter <= (USE_PACKET && valid[i] && endofpacket[i]) ? eop_counter + 1 : eop_counter;
               end
            end
         end
      end
   end

   //--------------------------------------------------------------------------
   // Private Methods
   //--------------------------------------------------------------------------

   //--------------------------------------------------------------------------
   // =head1 Public Methods API 
   // This section describes the public methods in the application programming
   // interface (API). In this case the application program is the test bench
   // which instantiates and controls and queries state of this component.
   // Test programs must only use these public access methods and events to 
   // communicate with this BFM component. The API and the module pins
   // are the only interfaces in this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------   
   // Master Assertions API
   function automatic void set_enable_a_valid_legal( // public
      bit     assert_enable
   );
   // enable or disable a_valid_legal assertion
   
      enable_a_valid_legal = assert_enable;
   endfunction

   function automatic void set_enable_a_empty_legal( // public
      bit     assert_enable
   );
   // enable or disable a_empty_legal assertion
   
      enable_a_empty_legal = assert_enable;
   endfunction

   function automatic void set_enable_a_no_data_outside_packet( // public
      bit     assert_enable
   );
   // enable or disable a_no_data_outside_packet assertion
   
      enable_a_no_data_outside_packet = assert_enable;
   endfunction
   
   function automatic void set_enable_a_non_missing_endofpacket( // public
      bit     assert_enable
   );
   // enable or disable a_non_missing_endofpacket assertion
   
      enable_a_non_missing_endofpacket = assert_enable;
   endfunction

   function automatic void set_enable_a_non_missing_startofpacket( // public
      bit     assert_enable
   );
   // enable or disable a_non_missing_startofpacket assertion
   
      enable_a_non_missing_startofpacket = assert_enable;
   endfunction

   function automatic void set_enable_a_less_than_max_channel( // public
      bit     assert_enable
   );
   // enable or disable a_less_than_max_channel assertion
   
      enable_a_less_than_max_channel = assert_enable;
   endfunction
   // =cut
   
   function automatic logic [31:0] get_sop_counter();
      return sop_counter;      
      if (USE_PACKET == 0) begin  
         $sformat(message, "%m: No packet signals in this stream (USE_PACKET=0).");
         print(VERBOSITY_WARNING, message);	 
      end 
   endfunction

   function automatic void reset_sop_counter();
      sop_counter_reset = 1'b1;      
   endfunction
   
   function automatic logic [31:0] get_eop_counter();
      return eop_counter;
      if (USE_PACKET == 0) begin  
         $sformat(message, "%m: No packet signals in this stream (USE_PACKET=0).");
         print(VERBOSITY_WARNING, message);	 
      end       
   endfunction 

   function automatic void reset_eop_counter();
      eop_counter_reset = 1'b1;      
   endfunction

   // remaining API declarations will go here   
   //--------------------------------------------------------------------------
   event fatal_error;
   
   always @(fatal_error) begin
      $sformat(message, "%m: Terminate simulation.");
      print(VERBOSITY_FAILURE, message);
      $finish;
   end
   
   //--------------------------------------------------------------------------      
   // =head1 Assertion Checkers and Coverage Monitors
   // The assertion checkers in this module are only executable on simulators 
   // supporting the SystemVerilog Assertion (SVA) language. 
   // Mentor Modelsim AE and SE do not support this.
   // Simulators that are supported include: Synopsys VCS and Mentor questasim.
   // The assertion checking logic in this module must be explicitly enabled
   // so that designs using this module can still be compiled on Modelsim without
   // changes. To disable assertions define the following macro in the testbench
   // or on the command line with: +define+DISABLE_ALTERA_AVALON_SIM_SVA.
   // =cut
   //--------------------------------------------------------------------------   
   
   function automatic void print_assertion(
      string message_in
   );
      string message_out;
      $sformat(message_out, "ASSERTION: %s", message_in);
      print(VERBOSITY_FAILURE, message_out);      
   endfunction


   // Counter for general assertion counters
   always @(posedge clk)
   begin
      for (int i=0; i<ST_BEATSPERCYCLE; i++) begin
         if ((USE_VALID && valid[i]) || !USE_VALID) begin
            if ((ST_READY_LATENCY > 0) || (USE_READY && (ST_READY_LATENCY == 0) && ready) || !USE_READY) begin
               check_sop_eop_valid(i);
            end
         end else begin
            data_outside_packet[i] = 0;
         end
      end
   end
   
   always @(posedge clk) 
   begin
      if (reset) begin
         sop_channel_used = '0;
         eop_channel_used = '1;
         sop_error_in_channel = '0;
         eop_error_in_channel = '0;
         data_outside_packet = '0;
      end
   end
   
   task automatic check_sop_eop_valid(int current_beat);
      if (startofpacket[current_beat]) begin
         if (sop_channel_used[channel[current_beat]] == 1)
            sop_error_in_channel[current_beat] = 1;
         else begin
            sop_channel_used[channel[current_beat]] = 1;
            sop_error_in_channel[current_beat] = 0;
         end
         eop_channel_used[channel[current_beat]] = 0;
      end
        
      if (endofpacket[current_beat]) begin
         if (eop_channel_used[channel[current_beat]] == 1)
            eop_error_in_channel[current_beat] = 1;
         else begin
            eop_channel_used[channel[current_beat]] = 1;
            eop_error_in_channel[current_beat] = 0;
         end
         sop_channel_used[channel[current_beat]] = 0;
      end
      
      if (!startofpacket[current_beat] && !endofpacket[current_beat]) begin
         if (!sop_channel_used[channel[current_beat]]) begin
            data_outside_packet[current_beat] = 1;
         end else begin
            data_outside_packet[current_beat] = 0;
         end
      end else begin
         data_outside_packet[current_beat] = 0;
      end
      
   endtask 
    
   
   // SVA assertion code lives within the following section block 
   // which is disabled when the macro DISABLE_ALTERA_AVALON_SIM_SVA is defined

   `ifdef DISABLE_ALTERA_AVALON_SIM_SVA
   // SVA assertion code has been disabled

   `else
   //--------------------------------------------------------------------------
   // ASSERTION CODE BEGIN
   //-------------------------------------------------------------------------- 
   //-------------------------------------------------------------------------------
   // =head2 Avalon Streaming Assertions
   // The following are the assertions code focus on Streaming Source and Sink
   // component checking
   //-------------------------------------------------------------------------------
    
   //------------------------------------------------------------------------------------
   // =head3 p_valid_legal
   // This property check if valid is not deasserted ST_READY_LATENCY cycle after ready 
   // is deasserted.
   //------------------------------------------------------------------------------------
   property p_valid_legal(current_beat);
      @(posedge clk && enable_a_valid_legal && USE_VALID && USE_READY && ST_READY_LATENCY > 0)
      disable iff (reset)
         !ready |-> ##ST_READY_LATENCY !valid[current_beat];
   endproperty

   genvar i;
   for (i=0; i<ST_BEATSPERCYCLE; i++) begin: st_monitor_assertion_01
   a_valid_legal: assert property(p_valid_legal(i))
      else begin
         -> event_a_valid_legal;
         print_assertion("valid asserted after ready deasserted");
      end
   end
   
   //------------------------------------------------------------------------------------
   // =head3 p_empty_legal
   // This property check if empty non zero while endofpacket is asserted or empty value 
   // larger or equal to ST_NUMSYMBOLS
   //------------------------------------------------------------------------------------
   property p_empty_legal(current_beat);
      @(posedge clk && enable_a_empty_legal && USE_EMPTY && USE_PACKET)
      disable iff (reset)
         valid[current_beat] && (empty[current_beat] > 0) && (clock_counter > 0) && 
         ((USE_READY && (ST_READY_LATENCY == 0) && ready) ||
         !USE_READY || (ST_READY_LATENCY > 0))
         |-> endofpacket[current_beat] && (empty[current_beat] < ST_NUMSYMBOLS);
   endproperty

   for (i=0; i<ST_BEATSPERCYCLE; i++) begin: st_monitor_assertion_02
      a_empty_legal: assert property(p_empty_legal(i))
         else begin
            -> event_a_empty_legal;
            print_assertion("illegal empty value");
         end
   end
   
   //------------------------------------------------------------------------------------
   // =head3 p_no_data_outside_packet
   // This property check if that valid is asserted outside the packet transfer
   //------------------------------------------------------------------------------------
   property p_no_data_outside_packet(current_beat);
      @(posedge clk && enable_a_no_data_outside_packet && USE_VALID && USE_PACKET)
      disable iff (reset)
         valid[current_beat] && !startofpacket[current_beat] && !endofpacket[current_beat] &&
         ((USE_READY && (ST_READY_LATENCY == 0) && ready) ||
         !USE_READY || (ST_READY_LATENCY > 0))
         |-> ##1 !data_outside_packet[current_beat];
   endproperty

   for (i=0; i<ST_BEATSPERCYCLE; i++) begin: st_monitor_assertion_03
      a_no_data_outside_packet: assert property(p_no_data_outside_packet(i))
         else begin
            -> event_a_no_data_outside_packet;
            print_assertion("valid is asserted outside the packet transfer");
         end
   end
   
   //------------------------------------------------------------------------------------
   // =head3 p_non_missing_endofpacket
   // This property check if consecutive startofpacket without endofpacket occurs
   //------------------------------------------------------------------------------------
   property p_non_missing_endofpacket(current_beat);
      @(posedge clk && enable_a_non_missing_endofpacket && USE_PACKET)
      disable iff (reset)
         startofpacket[current_beat] && valid[current_beat] && 
         ((USE_READY && (ST_READY_LATENCY == 0) && ready) ||
         !USE_READY || (ST_READY_LATENCY > 0))
         |-> ##1 !sop_error_in_channel[current_beat];
   endproperty

   for (i=0; i<ST_BEATSPERCYCLE; i++) begin: st_monitor_assertion_04
      a_non_missing_endofpacket: assert property(p_non_missing_endofpacket(i))
         else begin
            -> event_a_non_missing_endofpacket;
            print_assertion("consecutive startofpacket without endofpacket");
         end
   end
      
   //------------------------------------------------------------------------------------
   // =head3 p_non_missing_startofpacket
   // This property check if consecutive endofpacket without endofpacket occurs
   //------------------------------------------------------------------------------------
   property p_non_missing_startofpacket(current_beat);
      @(posedge clk && enable_a_non_missing_startofpacket && USE_PACKET)
      disable iff (reset)
         endofpacket[current_beat] && valid[current_beat] && !startofpacket[current_beat] &&
         ((USE_READY && (ST_READY_LATENCY == 0) && ready) ||
         !USE_READY || (ST_READY_LATENCY > 0))
         |-> ##1 !eop_error_in_channel[current_beat];
   endproperty

   for (i=0; i<ST_BEATSPERCYCLE; i++) begin: st_monitor_assertion_05
      a_non_missing_startofpacket: assert property(p_non_missing_startofpacket(i))
         else begin
            -> event_a_non_missing_startofpacket;
            print_assertion("consecutive endofpacket without startofpacket");
         end
   end
   
   //------------------------------------------------------------------------------------
   // =head3 p_less_than_max_channel
   // This property checks if channel size is less than ST_MAX_CHANNELS
   //------------------------------------------------------------------------------------
   property p_less_than_max_channel(current_beat);
      @(posedge clk && enable_a_less_than_max_channel && USE_CHANNEL)   
      disable iff (reset)
         valid[current_beat] && (channel[current_beat] > 0) && (clock_counter > 0) && 
         ((USE_READY && (ST_READY_LATENCY == 0) && ready) ||
         !USE_READY || (ST_READY_LATENCY > 0))
         |-> (channel[current_beat] <= ST_MAX_CHANNELS);
   endproperty

   for (i=0; i<ST_BEATSPERCYCLE; i++) begin: st_monitor_assertion_06
      a_less_than_max_channel: assert property(p_less_than_max_channel(i))
         else begin
            -> event_a_less_than_max_channel;
            print_assertion("channel size must be within ST_MAX_CHANNELS");
         end
   end
   
   // =cut
   
   //--------------------------------------------------------------------------
   // ASSERTION CODE END
   //--------------------------------------------------------------------------   
   `endif   

   // synthesis translate_on   

endmodule


