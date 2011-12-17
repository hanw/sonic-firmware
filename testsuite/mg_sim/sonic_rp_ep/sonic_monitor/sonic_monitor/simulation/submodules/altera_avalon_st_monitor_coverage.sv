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


// $File: //acds/main/ip/sopc/components/verification/altera_avalon_st_monitor_bfm/altera_avalon_st_monitor_coverage.sv $
// $Revision: #7 $
// $Date: 2009/04/16 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_avalon_st_monitor_coverage
// =head1 SYNOPSIS
// Streaming Avalon Bus Protocol Checker
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This module implements Avalon ST protocol coverage processing for simulation.
//-----------------------------------------------------------------------------

`timescale 1ns / 1ns

module altera_avalon_st_monitor_coverage(
                                          clk,
                                          reset,
                                          tap
                                         );

   // =head1 PARAMETERS
   parameter ST_SYMBOL_W       = 8;  // number of bits in one symbols    
   parameter ST_NUMSYMBOLS     = 4;  // number of symbols in one data  
   parameter ST_CHANNEL_W      = 0;  // width of channel signal
   parameter ST_ERROR_W        = 0;  // width of error signal
   parameter ST_EMPTY_W        = 0;  // width of empty signal
   
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

   function automatic int __floor1(
      bit [31:0] arg
   );
      __floor1 = (arg <1) ? 1 : arg;
   endfunction

   
   //-------------------------------------------------------------------------- 
   // synthesis translate_off

   import verbosity_pkg::*;
   
   typedef bit [lindex(ST_DATA_W)     :0] STData_t;
   typedef bit [lindex(ST_CHANNEL_W)  :0] STChannel_t;
   typedef bit [lindex(ST_EMPTY_W)    :0] STEmpty_t;
   typedef bit [lindex(ST_ERROR_W)    :0] STError_t;

   string                       message       = "*unitialized*";
   
   bit                          covergroup_settings_changed_flag = 0;
   bit                          enable_c_packet_no_idles_no_back_pressure = 1;
   bit                          enable_c_packet_with_idles = 1;
   bit                          enable_c_packet_with_back_pressure = 1;
   bit                          enable_c_channel_change_in_packet = 1;
   bit                          enable_c_empty = 1;
   bit                          enable_c_transfer = 1;
   bit                          enable_c_error = 1;
   bit                          enable_c_packet = 1;
   bit                          enable_c_b2b_packet_different_channel = 1;
   bit                          enable_c_b2b_packet_same_channel = 1;
   bit                          enable_c_b2b_data_different_channel = 1;
   bit                          enable_c_b2b_data_same_channel = 1;
   bit                          enable_c_valid_non_ready = 1;
   bit                          enable_c_non_valid_ready = 1;
   bit                          enable_c_non_valid_non_ready = 1;
   bit                          enable_c_transaction_after_reset = 1;
   bit                          enable_c_packet_size = 1;
   bit                          enable_c_multiple_packet_per_cycle = 1;
   bit                          enable_c_single_packet_per_cycle = 1;
   bit                          enable_c_idle_beat_between_packet = 1;
   bit                          enable_c_all_idle_beats = 1;
   bit                          enable_c_all_valid_beats = 1;
   bit                          enable_c_partial_valid_beats = 1;
   bit                          enable_c_b2b_packet_within_single_cycle = 1;
   bit                          enable_c_b2b_packet_in_different_cycle = 1;
   bit                          enable_c_error_in_middle_of_packet = 1;
   
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
                        lindex(ST_ERROR_W*ST_BEATSPERCYCLE)+lindex(ST_EMPTY_W*ST_BEATSPERCYCLE)+2*ST_BEATSPERCYCLE+3] :
                        (reset == 1)? 'x: 1;
      
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

   logic [31:0]   clock_counter;
   logic [31:0]   sop_counter;
   logic [31:0]   eop_counter;

   logic          sop_counter_reset = 0;
   logic          eop_counter_reset = 0;

   logic [lindex(NUM_CHANNEL):0]                               packet_no_idles_no_back_pressure_flag = '1;
   logic [lindex(NUM_CHANNEL):0]                               packet_with_back_pressure_flag = 0;
   logic [lindex(NUM_CHANNEL):0]                               channel_change_in_packet_flag = 0;
   logic [lindex(NUM_CHANNEL):0]                               packet_with_idles_flag = 0;
   logic [31:0]                                                idles_between_b2b_packet_same_channel_counter = 0;
   logic [31:0]                                                idles_between_b2b_packet_different_channel_counter = 0;
   logic [31:0]                                                idles_between_b2b_data_same_channel_counter = 0;
   logic [31:0]                                                idles_between_b2b_data_different_channel_counter = 0;
   logic [lindex(NUM_CHANNEL):0]                               current_packet = 0;
   logic [lindex(ST_BEATSPERCYCLE):0][lindex(ST_CHANNEL_W):0]  past_channel = 0;
   logic [lindex(ST_BEATSPERCYCLE):0]                          past_endofpacket = 0;
   logic                                                       idles_between_packet_same_channel_sampled = 0;
   logic                                                       idles_between_packet_different_channel_sampled = 0;
   logic                                                       non_valid_ready_sampled = 0;
   logic                                                       non_valid_non_ready_sampled = 0;
   logic [lindex(ST_BEATSPERCYCLE):0]                          current_beat = 0;
   logic [lindex(ST_BEATSPERCYCLE):0]                          current_beat_2 = 0;
   logic [31:0]                                                error_bit_num = 0;
   logic [31:0]                                                changed_channel = 0;
   logic                                                       transaction_after_reset = 0;
   logic                                                       all_valid_beats_flag = 0;
   logic                                                       all_invalid_beats_flag = 0;
   logic                                                       partial_valid_beats_flag = 0;
   logic [31:0]                                                idles_between_b2b_packet_transaction_counter = 0;
   logic [31:0]                                                idles_between_packet_within_single_transaction_sampled = 0;
   logic [31:0]                                                packet_per_transaction = 0;
   logic [lindex(NUM_CHANNEL):0][31:0]                         packet_size = 0;
   logic [31:0]                                                error_in_middle_of_packet = 0;
   logic [31:0]                                                idles_between_packet_in_different_transaction_sampled = 0;
   logic [31:0]                                                invalid_beat_between_packet = 0;
   logic                                                       packet_per_transaction_flag = 0;
   logic                                                       channel_change = 0;
   logic                                                       reset_status = 0;
   
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
         sop_counter <= (USE_PACKET && valid && startofpacket) ? 
         sop_counter + 1 : 
         sop_counter;
      end
   end

   always @(posedge clk) begin
      if (reset) begin
         eop_counter <= 0;
      end else if (eop_counter_reset) begin
         eop_counter_reset <= 0;
         eop_counter <= 0;
      end else begin
         eop_counter <= (USE_PACKET && valid && endofpacket) ? 
                           eop_counter + 1 : eop_counter;
      end
   end

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

   // ST Coverage API
   function automatic void set_enable_c_packet_no_idles_no_back_pressure( // public
      bit     cover_enable
   );
      // enable or disable c_packet_no_idles_no_back_pressure cover group
   
      enable_c_packet_no_idles_no_back_pressure = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_packet_no_idles_no_back_pressure");
   endfunction

   function automatic void set_enable_c_packet_with_idles( // public
      bit     cover_enable
   );
      // enable or disable c_packet_with_idles cover group
   
      enable_c_packet_with_idles = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_packet_with_idles");
   endfunction

   function automatic void set_enable_c_packet_with_back_pressure( // public
      bit     cover_enable
   );
      // enable or disable c_packet_with_back_pressure cover group
   
      enable_c_packet_with_back_pressure = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_packet_with_back_pressure");
   endfunction
   
   function automatic void set_enable_c_channel_change_in_packet( // public
      bit     cover_enable
   );
      // enable or disable c_channel_change_in_packet cover group
   
      enable_c_channel_change_in_packet = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_channel_change_in_packet");
   endfunction

   function automatic void set_enable_c_empty( // public
      bit     cover_enable
   );
      // enable or disable c_empty cover group
   
      enable_c_empty = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_empty");
   endfunction

   function automatic void set_enable_c_transfer( // public
      bit     cover_enable
   );
      // enable or disable c_transfer cover group
   
      enable_c_transfer = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_transfer");
   endfunction
   
   function automatic void set_enable_c_error( // public
      bit     cover_enable
   );
      // enable or disable c_error cover group
   
      enable_c_error = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_error");
   endfunction
   
   function automatic void set_enable_c_packet( // public
      bit     cover_enable
   );
      // enable or disable c_packet cover group
   
      enable_c_packet = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_packet");
   endfunction
   
   function automatic void set_enable_c_b2b_packet_different_channel( // public
      bit     cover_enable
   );
      // enable or disable c_b2b_packet_different_channel cover group
   
      enable_c_b2b_packet_different_channel = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_b2b_packet_different_channel");
   endfunction
   
   function automatic void set_enable_c_b2b_packet_same_channel( // public
      bit     cover_enable
   );
      // enable or disable c_b2b_packet_same_channel cover group
   
      enable_c_b2b_packet_same_channel = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_b2b_packet_same_channel");
   endfunction
   
   function automatic void set_enable_c_b2b_data_different_channel( // public
      bit     cover_enable
   );
      // enable or disable c_b2b_data_different_channel cover group
   
      enable_c_b2b_data_different_channel = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_b2b_data_different_channel");
   endfunction
   
   function automatic void set_enable_c_b2b_data_same_channel( // public
      bit     cover_enable
   );
      // enable or disable c_b2b_data_same_channel cover group
   
      enable_c_b2b_data_same_channel = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_b2b_data_same_channel");
   endfunction
   
   function automatic void set_enable_c_valid_non_ready( // public
      bit     cover_enable
   );
      // enable or disable c_valid_non_ready cover group
   
      enable_c_valid_non_ready = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_valid_non_ready");
   endfunction
   
   function automatic void set_enable_c_non_valid_ready( // public
      bit     cover_enable
   );
      // enable or disable c_non_valid_ready cover group
   
      enable_c_non_valid_ready = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_non_valid_ready");
   endfunction
   
   function automatic void set_enable_c_non_valid_non_ready( // public
      bit     cover_enable
   );
      // enable or disable c_non_valid_non_ready cover group
   
      enable_c_non_valid_non_ready = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_non_valid_non_ready");
   endfunction

   function automatic void set_enable_c_transaction_after_reset( // public
      bit     cover_enable
   );
      // enable or disable transaction_after_reset cover group
   
      enable_c_transaction_after_reset = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_transaction_after_reset");
   endfunction
   
   function automatic void set_enable_c_packet_size( // public
      bit     cover_enable
   );
      // enable or disable c_packet_size cover group
   
      enable_c_packet_size = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_packet_size");
   endfunction
   
   function automatic void set_enable_c_multiple_packet_per_cycle( // public
      bit     cover_enable
   );
      // enable or disable c_multiple_packet_per_cycle cover group
   
      enable_c_multiple_packet_per_cycle = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_multiple_packet_per_cycle");
   endfunction
   
   function automatic void set_enable_c_single_packet_per_cycle( // public
      bit     cover_enable
   );
      // enable or disable c_single_packet_per_cycle cover group
   
      enable_c_single_packet_per_cycle = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_single_packet_per_cycle");
   endfunction
   
   function automatic void set_enable_c_idle_beat_between_packet( // public
      bit     cover_enable
   );
      // enable or disable c_idle_beat_between_packet cover group
   
      enable_c_idle_beat_between_packet = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_idle_beat_between_packet");
   endfunction
   
   function automatic void set_enable_c_all_valid_beats( // public
      bit     cover_enable
   );
      // enable or disable c_all_valid_beats cover group
   
      enable_c_all_valid_beats = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_all_valid_beats");
   endfunction
   
   function automatic void set_enable_c_all_idle_beats( // public
      bit     cover_enable
   );
      // enable or disable c_all_idle_beats cover group
   
      enable_c_all_idle_beats = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_all_idle_beats");
   endfunction
   
   function automatic void set_enable_c_partial_valid_beats( // public
      bit     cover_enable
   );
      // enable or disable c_partial_valid_beats cover group
   
      enable_c_partial_valid_beats = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_partial_valid_beats");
   endfunction
   
   function automatic void set_enable_c_b2b_packet_within_single_cycle( // public
      bit     cover_enable
   );
      // enable or disable c_b2b_packet_within_single_cycle cover group
   
      enable_c_b2b_packet_within_single_cycle = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_b2b_packet_within_single_cycle");
   endfunction
   
   function automatic void set_enable_c_b2b_packet_in_different_transaction( // public
      bit     cover_enable
   );
      // enable or disable c_b2b_packet_in_different_transaction cover group
   
      enable_c_b2b_packet_in_different_cycle = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_b2b_packet_in_different_cycle");
   endfunction
   
   function automatic void set_enable_c_error_in_middle_of_packet( // public
      bit     cover_enable
   );
      // enable or disable c_error_in_middle_of_packet cover group
   
      enable_c_error_in_middle_of_packet = cover_enable;
      coverage_settings_check(covergroup_settings_changed_flag, "c_error_in_middle_of_packet");
   endfunction
   
   // =cut
   
   function automatic logic [31:0] get_sop_counter(); 
      return sop_counter;      
      if (USE_PACKET == 0) begin  
         $sformat(message, "%m: No packet signals in this stream (USE_PACKET = 0).");
         print(VERBOSITY_WARNING, message);	 
      end 
   endfunction

   function automatic void reset_sop_counter();
      sop_counter_reset = 1'b1;      
   endfunction
   
   function automatic logic [31:0] get_eop_counter();
      return eop_counter;
      if (USE_PACKET == 0) begin  
         $sformat(message, "%m: No packet signals in this stream (USE_PACKET = 0).");
         print(VERBOSITY_WARNING, message);	 
      end       
   endfunction 

   function automatic void reset_eop_counter();
      eop_counter_reset = 1'b1;      
   endfunction
   
   function void coverage_settings_check(
      bit cover_flag,
      string cover_name
   );
      string message;
      if (cover_flag) begin
         $sformat(message, "%m: - Changing %s covergroup settings during run-time will not be reflected",
                  cover_name);
         print(VERBOSITY_WARNING, message);
      end
   endfunction
   
   `ifdef DISABLE_ALTERA_AVALON_SIM_SVA
   // SVA coverage code is disabled when this macro is defined
   `else
   //--------------------------------------------------------------------------
   // COVERAGE CODE BEGIN
   //--------------------------------------------------------------------------

   function automatic void print_assertion( //private
      string message_in
   );
      string message_out;
      $sformat(message_out, "ASSERTION: %s", message_in);
      print(VERBOSITY_FAILURE, message_out);      
   endfunction

   function logic [1023:0] pow( //private
      input int power_value
   ); 
      // This method return the maximum supported value for the port width.
      pow = (2**(power_value) - 1);
   endfunction
   
   function automatic logic [31:0] count_ones ( //private
      input logic [1023:0] value 
   );
      // This method return number of 1 bits
      if (value == 0)
         count_ones = 0;
      else if (value == 'x) begin
         count_ones = 'x;
      end else begin
         for( count_ones = 0; value!= 0; value = value >> 1 )
            count_ones += value & 1'b1;
      end
   endfunction
   
  function integer log2( //private
     input int value
  );
     // Mathematic logarithm function with base as 2.
        value = value-1;
        for (log2=0; value>0; log2=log2+1)
        begin
            value = value>>1;
        end
   endfunction

   task sample_non_valid_ready();
      fork
         begin
            repeat(ST_READY_LATENCY) begin
               @(posedge clk);
            end
            non_valid_ready_sampled = 1;
         end
      join_none
   endtask
   
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

  
   always @(posedge clk) 
   begin
      if (!reset) begin
         for (int i=0; i<ST_BEATSPERCYCLE; i++) begin
            current_beat = i;
            //counter for general coverage
            if (((USE_VALID && valid[i]) || !USE_VALID)) begin
               if ((ST_READY_LATENCY > 0) || (USE_READY && (ST_READY_LATENCY == 0) && ready) || !USE_READY) begin

                  if (enable_c_transaction_after_reset && USE_VALID) begin
                     c_transaction_after_reset.sample();
                     transaction_after_reset = 0;
                  end
               
                  if (enable_c_transfer && USE_VALID && USE_READY) begin
                     c_transfer.sample();
                  end

                  if (enable_c_empty && USE_EMPTY) begin
                     c_empty.sample();
                  end
               
                  if (enable_c_error && USE_ERROR) begin
                     for (int j = 0; j < ST_ERROR_W; j++) begin
                        if (error[current_beat][j] == 1) begin
                           error_bit_num = j;
                           c_error.sample();
                        end
                     end
                  end

                  if (startofpacket[i]) begin
                     if (!endofpacket[i]) begin
                        current_packet[channel[i]] = 1;
                     end else begin
                        packet_size[channel[i]]++;
                     end
                     
                     if (error[i] > 0) begin
                        error_in_middle_of_packet = 1;
                     end else begin
                        error_in_middle_of_packet = 0;
                     end
                     
                     if (enable_c_error_in_middle_of_packet && USE_ERROR && USE_PACKET) begin
                        c_error_in_middle_of_packet.sample();
                        error_in_middle_of_packet = 0;
                     end
                     
                     packet_no_idles_no_back_pressure_flag[channel[i]] = 1;
                     
                     //counter to determine time to sample signal
                     if (i == 0) begin
                        if (channel[i]  != past_channel[ST_BEATSPERCYCLE-1]) begin
                           idles_between_packet_same_channel_sampled = 0;
                           if (past_endofpacket[ST_BEATSPERCYCLE-1] == 1) begin
                              idles_between_packet_different_channel_sampled = 1;
                              idles_between_packet_in_different_transaction_sampled = 1;
                           end else begin
                              idles_between_packet_different_channel_sampled = 0;
                              idles_between_packet_in_different_transaction_sampled = 0;
                           end
                        end else begin
                           idles_between_packet_different_channel_sampled = 0;
                           if (past_endofpacket[ST_BEATSPERCYCLE-1] == 1) begin
                              idles_between_packet_same_channel_sampled = 1;
                              idles_between_packet_in_different_transaction_sampled = 1;
                           end else begin
                              idles_between_packet_same_channel_sampled = 0;
                              idles_between_packet_in_different_transaction_sampled = 0;
                           end
                        end
                        idles_between_packet_within_single_transaction_sampled = 0;
                     end else begin
                        if (channel[i]  != channel[i-1]) begin 
                           idles_between_packet_same_channel_sampled = 0;
                           if (endofpacket[i-1] == 1) begin
                              idles_between_packet_different_channel_sampled = 1;
                              idles_between_packet_within_single_transaction_sampled = 1;
                           end else begin
                              idles_between_packet_different_channel_sampled = 0;
                              idles_between_packet_within_single_transaction_sampled = 0;
                           end
                        end else begin
                           idles_between_packet_different_channel_sampled = 0;
                           if (endofpacket[i-1] == 1) begin
                              idles_between_packet_same_channel_sampled = 1;
                              idles_between_packet_within_single_transaction_sampled = 1;
                           end else begin
                              idles_between_packet_same_channel_sampled = 0;
                              idles_between_packet_within_single_transaction_sampled = 0;
                           end
                        end
                        idles_between_packet_in_different_transaction_sampled = 0;
                     end
                     
                     if (enable_c_b2b_packet_different_channel && USE_CHANNEL && USE_PACKET && USE_VALID && (ST_MAX_CHANNELS > 1)) begin
                        if (idles_between_packet_different_channel_sampled) begin
                           c_b2b_packet_different_channel.sample();
                        end
                     end

                     if (enable_c_b2b_packet_same_channel && USE_PACKET && USE_VALID) begin
                        if (idles_between_packet_same_channel_sampled) begin
                           c_b2b_packet_same_channel.sample();
                        end
                     end
                     
                     if (enable_c_b2b_packet_within_single_cycle && USE_PACKET && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
                        if (idles_between_packet_within_single_transaction_sampled) begin
                           c_b2b_packet_within_single_cycle.sample();
                        end
                     end
                     
                     if (enable_c_b2b_packet_in_different_cycle && USE_PACKET && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
                        if (idles_between_packet_in_different_transaction_sampled) begin
                           c_b2b_packet_in_different_cycle.sample();
                        end
                     end

                     if ((count_ones(current_packet) == 1) || ((count_ones(current_packet) == 0) &&(endofpacket[i]))) begin                     
                        if (enable_c_idle_beat_between_packet && USE_VALID && USE_PACKET && (ST_BEATSPERCYCLE > 1)) begin
                           c_idle_beat_between_packet.sample();
                           invalid_beat_between_packet = 0;
                        end
                     end
                  end
                  
                  for (int j = 0; j <NUM_CHANNEL; j++) begin
                     if (current_packet[j] == 1) begin
                        packet_size[j]++;
                     end
                  end
                  
                  if (endofpacket[i]) begin

                     invalid_beat_between_packet = 0;
                     current_packet[channel[i]]  = 0;
                     if (enable_c_packet && USE_PACKET) begin
                        c_packet.sample();
                     end

                     if (enable_c_packet_no_idles_no_back_pressure && USE_READY && USE_VALID && USE_PACKET) begin
                        c_packet_no_idles_no_back_pressure.sample();
                     end
                     
                     if (enable_c_packet_with_idles && USE_PACKET && USE_VALID) begin
                        c_packet_with_idles.sample();
                        packet_with_idles_flag[channel[i]] = 0;
                     end
                     
                     if (enable_c_channel_change_in_packet && USE_CHANNEL && USE_PACKET && (ST_MAX_CHANNELS > 1)) begin
                        c_channel_change_in_packet.sample();
                        channel_change_in_packet_flag[channel[i]] = 0;
                     end
                     
                     if (enable_c_packet_with_back_pressure && USE_READY && USE_PACKET) begin
                        c_packet_with_back_pressure.sample();
                        packet_with_back_pressure_flag[channel[i]] = 0;
                     end
                     
                     if (enable_c_packet_size && USE_PACKET) begin
                        c_packet_size.sample();
                        packet_size[channel[i]] = 0;
                     end
                     
                  end
                  
                  if (i == 0) begin
                     if (channel[i]  != past_channel[ST_BEATSPERCYCLE-1]) begin
                        if (((count_ones(current_packet) == 1) && !startofpacket[i]) ||
                           (count_ones(current_packet) > 1)) begin
                           if(current_packet[past_channel[ST_BEATSPERCYCLE-1]] == 1) begin
                              channel_change_in_packet_flag[past_channel[ST_BEATSPERCYCLE-1]] = 1;
                           end
                        end
                     end
                  end else begin
                     if (channel[i]  != channel[i-1]) begin
                         if (((count_ones(current_packet) == 1) && !startofpacket[i]) ||
                            (count_ones(current_packet) > 1)) begin
                           if(current_packet[channel[i-1]] == 1) begin
                              channel_change_in_packet_flag[channel[i-1]] = 1;
                           end
                        end
                     end
                  end
                  
               end else begin
                  if (count_ones(current_packet) == 0) begin
                     invalid_beat_between_packet = 1;
                  end
               end
            end else if (USE_VALID && (valid[i] == 0)) begin
               if (count_ones(current_packet) == 0) begin
                  invalid_beat_between_packet = 1;
               end
            end

            //counter for idles transaction
            if (!valid[i]) begin
               for (int j = 0; j <NUM_CHANNEL; j++) begin
                  if (current_packet[j] == 1) begin
                     packet_with_idles_flag[j] = 1;
                     packet_no_idles_no_back_pressure_flag[j] = 0;
                  end
               end
            end
            
            // counter for back-pressure transaction
            if (USE_READY && !ready) begin
               for (int j = 0; j <NUM_CHANNEL; j++) begin
                  if (current_packet[j] == 1) begin
                     packet_no_idles_no_back_pressure_flag[j] = 0;
                     packet_with_back_pressure_flag[j] = 1;
                  end
               end
            end
            
            //counter for b2b transfer
            if ((USE_VALID && !valid[i]) || ((USE_READY && (ST_READY_LATENCY == 0) && !ready))) begin
               if (current_packet[channel[i]] == 0) begin
                  idles_between_b2b_packet_same_channel_counter++;
               end 
               idles_between_b2b_packet_different_channel_counter++;
               idles_between_b2b_packet_transaction_counter++;
               for (int j = 0; j <NUM_CHANNEL; j++) begin
                  if (current_packet[j] == 1) begin
                     packet_size[j]++;
                  end
               end
            end
                  
            if (i == 0) begin
               if ((USE_VALID && !valid[i]) || (past_channel[ST_BEATSPERCYCLE-1] != channel[i]) || 
                  ((USE_READY && (ST_READY_LATENCY == 0) && !ready))) begin
                  idles_between_b2b_data_same_channel_counter++;
               end
               if ((USE_VALID && !valid[i]) || (past_channel[ST_BEATSPERCYCLE-1] == channel[i]) || 
                  ((USE_READY && (ST_READY_LATENCY == 0) && !ready))) begin
                  idles_between_b2b_data_different_channel_counter++;
               end
            end else begin
               if ((USE_VALID && !valid[i]) || (channel[i-1] != channel[i]) || ((USE_READY && (ST_READY_LATENCY == 0) && !ready))) begin
                  idles_between_b2b_data_same_channel_counter++;
               end
               if ((USE_VALID && !valid[i]) || (channel[i-1] == channel[i]) || ((USE_READY && (ST_READY_LATENCY == 0) && !ready))) begin
                  idles_between_b2b_data_different_channel_counter++;
               end
            end
            
            if (((USE_VALID && valid[i]) || !USE_VALID)) begin
               if ((ST_READY_LATENCY > 0) || (USE_READY && (ST_READY_LATENCY == 0) && ready) || !USE_READY) begin
                  if (endofpacket[i]) begin
                     idles_between_b2b_packet_same_channel_counter = 0;
                     idles_between_b2b_packet_different_channel_counter = 0;
                     idles_between_b2b_packet_transaction_counter = 0;
                  end
               end
               
               if ((!startofpacket[i] && !endofpacket[i]) || (USE_READY && (ST_READY_LATENCY == 0) && !ready)) begin
                  idles_between_b2b_packet_different_channel_counter++;
                  idles_between_b2b_packet_transaction_counter++;
               end
            end
            
            if (((USE_VALID && valid[i]) || !USE_VALID)) begin
               if ((ST_READY_LATENCY > 0) || (USE_READY && (ST_READY_LATENCY == 0) && ready) || !USE_READY) begin
                  if (enable_c_b2b_data_different_channel && USE_CHANNEL && USE_VALID && (ST_MAX_CHANNELS > 1)) begin
                     c_b2b_data_different_channel.sample();
                     idles_between_b2b_data_different_channel_counter = 0;
                  end
                  
                  if (enable_c_b2b_data_same_channel && USE_VALID) begin
                     c_b2b_data_same_channel.sample();
                     idles_between_b2b_data_same_channel_counter = 0;
                  end
               end
            end

            if (!reset_status)
               transaction_after_reset = 0;
         end
         
         // counter to capture previous cycle signal value
         for (int i=0; i<ST_BEATSPERCYCLE; i++) begin
            if((USE_VALID && valid[i]) || !USE_VALID) begin
               if ((ST_READY_LATENCY > 0) || (USE_READY && (ST_READY_LATENCY == 0) && ready) || !USE_READY) begin
                  past_endofpacket[i] <= endofpacket[i];
                  for (int k = i; k < ST_BEATSPERCYCLE; k++) begin
                     past_channel[k] <= channel[k];
                  end
               end else 
                  past_endofpacket[i] <= 0;
            end else begin
               past_endofpacket[i] <= 0;
            end
         end
         reset_status = 0;
      end
   end
   
   always @(posedge clk) 
   begin
      if (!reset) begin
         if (ready) begin
            if (ST_READY_LATENCY == 0) begin
               non_valid_ready_sampled = 1;
            end else begin
               sample_non_valid_ready();
            end
         end 

         if (enable_c_valid_non_ready && USE_READY && USE_VALID && (ST_READY_LATENCY == 0)) begin
            for (int i=0; i<ST_BEATSPERCYCLE; i++) begin
               if (valid[i]) begin
                  c_valid_non_ready.sample();
               end
            end
         end
         
         if (enable_c_non_valid_ready && USE_READY && USE_VALID) begin
            for (int i=0; i<ST_BEATSPERCYCLE; i++) begin
            current_beat_2 = i;
               if (non_valid_ready_sampled) begin
                  c_non_valid_ready.sample();
               end
            end
            non_valid_ready_sampled = 0;
         end
         
         if (enable_c_non_valid_non_ready && USE_READY && USE_VALID) begin
            for (int i=0; i<ST_BEATSPERCYCLE; i++) begin
               if (!valid[i] && non_valid_non_ready_sampled) begin
                  c_non_valid_non_ready.sample();
               end
            end
         end
         
         if (USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
            if ((ST_READY_LATENCY > 0) || (USE_READY && (ST_READY_LATENCY == 0) && ready) || !USE_READY) begin
               if (count_ones(valid) == ST_BEATSPERCYCLE) begin
                  all_valid_beats_flag = 1;
               end else begin
                  all_valid_beats_flag = 0;
               end
               
               if ((count_ones(valid) == 0) && (valid[0] == 0)) begin
                  all_invalid_beats_flag = 1;
               end else begin
                  all_invalid_beats_flag = 0;
               end
               
               if ((count_ones(valid) > 0) && (count_ones(valid) < ST_BEATSPERCYCLE)) begin
                  partial_valid_beats_flag = 1;
               end else begin
                  partial_valid_beats_flag = 0;
               end
               
               if (enable_c_all_valid_beats && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
                  c_all_valid_beats.sample();
               end
               if (enable_c_all_idle_beats && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
                  c_all_idle_beats.sample();
               end
               if (enable_c_partial_valid_beats && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
                  c_partial_valid_beats.sample();
               end
            end
         end
         
         if (USE_PACKET && (ST_BEATSPERCYCLE > 1)) begin
            for (int i=0; i<ST_BEATSPERCYCLE; i++) begin 
               if ((ST_READY_LATENCY > 0) || (USE_READY && (ST_READY_LATENCY == 0) && ready) || !USE_READY) begin
                  if (((USE_VALID && valid[i]) || !USE_VALID)) begin
                     if (i > 0) begin
                        for (int j = 0; j < i; j++) begin
                           if (valid[j] == 1) begin
                              packet_per_transaction_flag = 1;
                           end
                           if ((channel[i] != channel[j]) && valid[j]) begin
                              channel_change = 1;
                           end
                        end
                        if (channel_change && packet_per_transaction_flag) begin
                           packet_per_transaction++;
                        end else begin
                           if ((startofpacket[i]) && packet_per_transaction_flag) begin
                              packet_per_transaction++;
                           end
                        end
                        channel_change = 0;
                     end
                  end

                  if (i == (ST_BEATSPERCYCLE-1)) begin
                     if (enable_c_multiple_packet_per_cycle && USE_PACKET && (ST_BEATSPERCYCLE > 1)) begin
                        c_multiple_packet_per_cycle.sample();
                     end
                           
                     if (enable_c_single_packet_per_cycle && USE_PACKET && (ST_BEATSPERCYCLE > 1)) begin
                        if ((valid > 0)) begin
                           c_single_packet_per_cycle.sample();
                        end
                     end
                     packet_per_transaction = 0;
                  end
               end
            end
            packet_per_transaction_flag = 0;
         end
      end
   end
   
   
   always @(negedge reset) 
   begin
      non_valid_non_ready_sampled = 1;
   end
   
   //counter while reset
   always @(posedge clk) 
   begin
      if (reset) begin
         non_valid_ready_sampled = 0;
         non_valid_non_ready_sampled = 0;
         packet_no_idles_no_back_pressure_flag = '1;
         packet_with_back_pressure_flag = 0;
         idles_between_b2b_packet_same_channel_counter = 0;
         idles_between_b2b_packet_different_channel_counter = 0;
         channel_change_in_packet_flag = 0;
         packet_with_idles_flag = 0;
         idles_between_packet_same_channel_sampled = 0;
         idles_between_packet_different_channel_sampled = 0;
         current_packet = 0;
         idles_between_b2b_data_same_channel_counter = 0;
         idles_between_b2b_data_different_channel_counter = 0;
         past_channel = 0;
         past_endofpacket = 0;
         transaction_after_reset = 1;
         current_beat = 0;
         current_beat_2 = 0;
         changed_channel = 0;
         all_valid_beats_flag = 0;
         all_invalid_beats_flag = 0;
         partial_valid_beats_flag = 0;
         idles_between_b2b_packet_transaction_counter = 0;
         idles_between_packet_within_single_transaction_sampled = 0;
         packet_per_transaction = 0;
         packet_size = 0;
         error_in_middle_of_packet = 0;
         idles_between_packet_in_different_transaction_sampled = 0;
         invalid_beat_between_packet = 0;
         packet_per_transaction_flag = 0;
         reset_status = 1;
         channel_change = 0;
      end
   end
   
   // Flag for initial coverage settings
   initial begin
      #1 covergroup_settings_changed_flag = 1;
   end

   //-------------------------------------------------------------------------------
   // =head2 Streaming Coverages
   // The following are the cover group code focus on ST Monitor component coverage
   //-------------------------------------------------------------------------------
    
   //-------------------------------------------------------------------------------
   // =head3 c_empty 
   // This cover group covers the different empty value
   //-------------------------------------------------------------------------------

   covergroup cg_empty;
      cp_empty: coverpoint empty[current_beat]
      {
         bins cg_empty_cp_empty [] = {[0:ST_MAX_EMPTY]};
      }
      option.per_instance = 1;
   endgroup

   cg_empty c_empty;

   initial begin
      #1 if (enable_c_empty && USE_EMPTY) begin
         c_empty = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_error 
   // This cover group covers the different error value
   //-------------------------------------------------------------------------------

   covergroup cg_error;
      cp_error: coverpoint error_bit_num
      {
         bins cg_error_cp_error [] = {[0:(ST_ERROR_W-1)]};
      }
      option.per_instance = 1;
   endgroup

   cg_error c_error;

   initial begin
      #1 if (enable_c_error && USE_ERROR) begin
         c_error = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_transfer 
   // This cover group covers valid is asserted for different channel.
   //-------------------------------------------------------------------------------

   covergroup cg_transfer;
      cp_transfer: coverpoint (channel[current_beat])
      {
         bins cg_transfer_cp_transfer [] = {[0:(USE_CHANNEL == 0? 0:NUM_CHANNEL-1)]};
      }
      option.per_instance = 1;
   endgroup

   cg_transfer c_transfer;

   initial begin
      #1 if (enable_c_transfer && USE_VALID && USE_READY) begin
         c_transfer = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_packet 
   // This cover group covers packet transfer for different channel.
   //-------------------------------------------------------------------------------

   covergroup cg_packet;
      cp_packet: coverpoint (channel[current_beat])
      {
         bins cg_packet_cp_packet [] = {[0:(USE_CHANNEL == 0? 0:NUM_CHANNEL-1)]};
      }
      option.per_instance = 1;
   endgroup

   cg_packet c_packet;

   initial begin
      #1 if (enable_c_packet && USE_PACKET) begin
         c_packet = new();
      end
   end
   
   //-------------------------------------------------------------------------------
   // =head3 c_valid_non_ready 
   // This cover group covers valid is asserted while ready is deasserted.
   //-------------------------------------------------------------------------------

   covergroup cg_valid_non_ready;
      cp_valid_non_ready: coverpoint ready
      {
         bins cg_valid_non_ready_cp_valid_non_ready = {0};
      }
      option.per_instance = 1;
   endgroup

   cg_valid_non_ready c_valid_non_ready;

   initial begin
      #1 if (enable_c_valid_non_ready && USE_READY 
          && USE_VALID && (ST_READY_LATENCY == 0)) begin
         c_valid_non_ready = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_non_valid_ready  
   // This cover group covers valid is deasserted at the N+ST_READ_LATENCY 
   // clock cycle if ready is asserted at N clock cycle. 
   //-------------------------------------------------------------------------------

   covergroup cg_non_valid_ready;
      cp_non_valid_ready: coverpoint valid[current_beat_2]
      {
         bins cg_non_valid_ready_cp_non_valid_ready = {0};
      }
      option.per_instance = 1;
   endgroup

   cg_non_valid_ready c_non_valid_ready;

   initial begin
      #1 if (enable_c_non_valid_ready && USE_READY && USE_VALID) begin
         c_non_valid_ready = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_non_valid_non_ready 
   // This cover group covers idle cycle.
   //-------------------------------------------------------------------------------

   covergroup cg_non_valid_non_ready;
      cp_non_valid_non_ready: coverpoint ready
      {
         bins cg_non_valid_non_ready_cp_non_valid_non_ready = {0};
      }
      option.per_instance = 1;
   endgroup

   cg_non_valid_non_ready c_non_valid_non_ready;

   initial begin
      #1 if (enable_c_non_valid_non_ready && USE_READY && USE_VALID) begin
         c_non_valid_non_ready = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_packet_no_idles_no_back_pressure 
   // This cover group covers packet transaction without back pressure and idle 
   // cycles.
   //-------------------------------------------------------------------------------

   covergroup cg_packet_no_idles_no_back_pressure;
      cp_packet_no_idles_no_back_pressure: coverpoint packet_no_idles_no_back_pressure_flag[channel[current_beat]]
      {
         bins cg_packet_no_idles_no_back_pressure_cp_packet_no_idles_no_back_pressure = {1};
      }
      option.per_instance = 1;
   endgroup

   cg_packet_no_idles_no_back_pressure c_packet_no_idles_no_back_pressure;

   initial begin
      #1 if (enable_c_packet_no_idles_no_back_pressure && USE_READY && USE_VALID && USE_PACKET) begin
         c_packet_no_idles_no_back_pressure = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_packet_with_back_pressure 
   // This cover group covers packet transaction being back pressured.
   //-------------------------------------------------------------------------------

   covergroup cg_packet_with_back_pressure;
      cp_packet_with_back_pressure: coverpoint packet_with_back_pressure_flag[channel[current_beat]]
      {
         bins cg_packet_with_back_pressure_cp_packet_with_back_pressure = {1};
      }
      option.per_instance = 1;
   endgroup

   cg_packet_with_back_pressure c_packet_with_back_pressure;
   
   initial begin
      #1 if (enable_c_packet_with_back_pressure && USE_READY && USE_PACKET) begin
         c_packet_with_back_pressure = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_packet_with_idles 
   // This cover group covers covers packet transaction with idle cycles
   //-------------------------------------------------------------------------------

   covergroup cg_packet_with_idles;
      cp_packet_with_idles: coverpoint packet_with_idles_flag[channel[current_beat]]
      {
         bins cg_packet_with_idles_cp_packet_with_idles = {1};
      }
      option.per_instance = 1;
   endgroup

   cg_packet_with_idles c_packet_with_idles;

   initial begin
      #1 if (enable_c_packet_with_idles && USE_PACKET && USE_VALID) begin
         c_packet_with_idles = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_channel_change_in_packet
   // This cover group covers changing channel within a packet transaction.
   //-------------------------------------------------------------------------------

   covergroup cg_channel_change_in_packet;
      cp_channel_change_in_packet: coverpoint channel_change_in_packet_flag[channel[current_beat]]
      {
         bins cg_channel_change_in_packet_cp_channel_change_in_packet = {1};
      }
      option.per_instance = 1;
   endgroup

   cg_channel_change_in_packet c_channel_change_in_packet;

   initial begin
      #1 if (enable_c_channel_change_in_packet && USE_CHANNEL && USE_PACKET && (ST_MAX_CHANNELS > 1)) begin
         c_channel_change_in_packet = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_b2b_packet_different_channel 
   // This cover group covers back to back packet transfer for different channel.
   //-------------------------------------------------------------------------------

   covergroup cg_b2b_packet_different_channel;
      cp_b2b_packet_different_channel: coverpoint idles_between_b2b_packet_different_channel_counter
      {
         bins cg_b2b_packet_different_channel_cp_b2b_packet_different_channel = {0};
      }
      option.per_instance = 1;
   endgroup

   cg_b2b_packet_different_channel c_b2b_packet_different_channel;

   initial begin
      #1 if (enable_c_b2b_packet_different_channel && USE_CHANNEL && USE_PACKET && USE_VALID && (ST_MAX_CHANNELS > 1)) begin
         c_b2b_packet_different_channel = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_b2b_packet_same_channel 
   // This cover group covers back to back packet transfer for same channel.
   //-------------------------------------------------------------------------------

   covergroup cg_b2b_packet_same_channel;
      cp_b2b_packet_same_channel: coverpoint idles_between_b2b_packet_same_channel_counter
      {
         bins cg_b2b_packet_same_channel_cp_b2b_packet_same_channel = {0};
      }
      option.per_instance = 1;
   endgroup

   cg_b2b_packet_same_channel c_b2b_packet_same_channel;

   initial begin
      #1 if (enable_c_b2b_packet_same_channel && USE_PACKET && USE_VALID) begin
         c_b2b_packet_same_channel = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_b2b_data_different_channel 
   // This cover group covers back to back data transfer for different channel.
   //-------------------------------------------------------------------------------

   covergroup cg_b2b_data_different_channel;
      cp_b2b_data_different_channel: coverpoint idles_between_b2b_data_different_channel_counter
      {
         bins cg_b2b_data_different_channel_cp_b2b_data_different_channel = {0};
      }
      option.per_instance = 1;
   endgroup

   cg_b2b_data_different_channel c_b2b_data_different_channel;

   initial begin
      #1 if (enable_c_b2b_data_different_channel && USE_CHANNEL && USE_VALID && (ST_MAX_CHANNELS > 1)) begin
         c_b2b_data_different_channel = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_b2b_data_same_channel 
   // This cover group covers back to back data transfer for same channel.
   //-------------------------------------------------------------------------------

   covergroup cg_b2b_data_same_channel;
      cp_b2b_data_same_channel: coverpoint idles_between_b2b_data_same_channel_counter
      {
         bins cg_b2b_data_same_channel_cp_b2b_data_same_channel = {0};
      }
      option.per_instance = 1;
   endgroup

   cg_b2b_data_same_channel c_b2b_data_same_channel;

   initial begin
      #1 if (enable_c_b2b_data_same_channel && USE_VALID) begin
         c_b2b_data_same_channel = new();
      end
   end
   
   //-------------------------------------------------------------------------------
   // =head3 c_transaction_after_reset 
   // This cover group covers first transaction after reset.
   //-------------------------------------------------------------------------------

   covergroup cg_transaction_after_reset;
      cp_transaction_after_reset: coverpoint transaction_after_reset
      {
         bins cg_transaction_after_reset_cp_transaction_after_reset = {1};
      }
      option.per_instance = 1;
   endgroup

   cg_transaction_after_reset c_transaction_after_reset;

   initial begin
      #1 if (enable_c_transaction_after_reset && USE_VALID) begin
         c_transaction_after_reset = new();
      end
   end
   
   //-------------------------------------------------------------------------------
   // =head3 c_packet_size 
   // This covers different size of packet from one until parameter 
   // ST_MAX_PACKET_SIZE. For the transaction larger than ST_MAX_PACKET_SIZE will 
   // count into another bin.
   //-------------------------------------------------------------------------------

   covergroup cg_packet_size;
      cp_packet_size: coverpoint packet_size[channel[current_beat]]
      {
         bins cg_packet_size_cp_packet_size [] = {[1:(ST_MAX_PACKET_SIZE < 1)? 1:ST_MAX_PACKET_SIZE]};
         bins cg_packet_size_cp_packet_size_high = {[(ST_MAX_PACKET_SIZE < 1)? 2:ST_MAX_PACKET_SIZE+1:$]};
      }
      option.per_instance = 1;
   endgroup

   cg_packet_size c_packet_size;

   initial begin
      #1 if (enable_c_packet_size && USE_PACKET) begin
         c_packet_size = new();
      end
   end

   //-------------------------------------------------------------------------------
   // =head3 c_multiple_packet_per_cycle
   // This cover group covers number of transactions that carry multiple packets
   // per single cycle.
   //-------------------------------------------------------------------------------

   covergroup cg_multiple_packet_per_cycle;
      cp_multiple_packet_per_cycle: coverpoint packet_per_transaction
      {
         bins cg_multiple_packet_per_cycle_cp_multiple_packet_per_cycle = {[1:(ST_BEATSPERCYCLE > 1)?ST_BEATSPERCYCLE:1]};
      }
      option.per_instance = 1;
   endgroup

   cg_multiple_packet_per_cycle c_multiple_packet_per_cycle;

   initial begin
      #1 if (enable_c_multiple_packet_per_cycle && USE_PACKET && ST_BEATSPERCYCLE > 1) begin
         c_multiple_packet_per_cycle = new();
      end
   end
   
   //-------------------------------------------------------------------------------
   // =head3 c_single_packet_per_cycle
   // This cover group covers number of transactions that carry one packet
   // per single cycle.
   //-------------------------------------------------------------------------------

   covergroup cg_single_packet_per_cycle;
      cp_single_packet_per_cycle: coverpoint packet_per_transaction
      {
         bins cg_single_packet_per_cycle_cp_single_packet_per_cycle = {0};
      }
      option.per_instance = 1;
   endgroup

   cg_single_packet_per_cycle c_single_packet_per_cycle;

   initial begin
      #1 if (enable_c_single_packet_per_cycle && USE_PACKET && ST_BEATSPERCYCLE > 1) begin
         c_single_packet_per_cycle = new();
      end
   end
   
   //-------------------------------------------------------------------------------
   // =head3 c_idle_beat_between_packet
   // This cover group covers packet transaction that owns idle beats in between.
   //-------------------------------------------------------------------------------

   covergroup cg_idle_beat_between_packet;
      cp_idle_beat_between_packet: coverpoint invalid_beat_between_packet
      {
         bins cg_idle_beat_between_packet_cp_idle_beat_between_packet = {1};
      }
      option.per_instance = 1;
   endgroup

   cg_idle_beat_between_packet c_idle_beat_between_packet;

   initial begin
      #1 if (enable_c_idle_beat_between_packet && USE_PACKET && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
         c_idle_beat_between_packet = new();
      end
   end
   
   //-------------------------------------------------------------------------------
   // =head3 c_all_valid_beats
   // This cover group covers number of transaction with all beats are valid.
   //-------------------------------------------------------------------------------

   covergroup cg_all_valid_beats;
      cp_all_valid_beats: coverpoint all_valid_beats_flag
      {
         bins cg_all_valid_beats_cp_all_valid_beats = {1};
      }
      option.per_instance = 1;
   endgroup

   cg_all_valid_beats c_all_valid_beats;

   initial begin
      #1 if (enable_c_all_valid_beats && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
         c_all_valid_beats = new();
      end
   end
   
   //-------------------------------------------------------------------------------
   // =head3 c_all_idle_beats
   // This cover group covers number of transaction with all beats are idle.
   //-------------------------------------------------------------------------------

   covergroup cg_all_idle_beats;
      cp_all_idle_beats: coverpoint all_invalid_beats_flag
      {
         bins cg_all_idle_beats_cp_all_idle_beats = {1};
      }
      option.per_instance = 1;
   endgroup

   cg_all_idle_beats c_all_idle_beats;

   initial begin
      #1 if (enable_c_all_idle_beats && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
         c_all_idle_beats = new();
      end
   end
   
   //-------------------------------------------------------------------------------
   // =head3 c_partial_valid_beats
   // This cover group covers number of transaction with some beats are invalid and
   // some beats are valid.
   //-------------------------------------------------------------------------------

   covergroup cg_partial_valid_beats;
      cp_partial_valid_beats: coverpoint partial_valid_beats_flag
      {
         bins cg_partial_valid_beats_cp_partial_valid_beats = {1};
      }
      option.per_instance = 1;
   endgroup

   cg_partial_valid_beats c_partial_valid_beats;

   initial begin
      #1 if (enable_c_partial_valid_beats && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
         c_partial_valid_beats = new();
      end
   end
   
   //-------------------------------------------------------------------------------
   // =head3 c_b2b_packet_within_single_cycle 
   // This cover group covers back to back packet transfer within single cycle.
   //-------------------------------------------------------------------------------

   covergroup cg_b2b_packet_within_single_cycle;
      cp_b2b_packet_within_single_cycle: coverpoint idles_between_b2b_packet_transaction_counter
      {
         bins cg_b2b_packet_within_single_cycle_cp_b2b_packet_within_single_cycle = {0};
      }
      option.per_instance = 1;
   endgroup

   cg_b2b_packet_within_single_cycle c_b2b_packet_within_single_cycle;

   initial begin
      #1 if (enable_c_b2b_packet_within_single_cycle && USE_PACKET && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
         c_b2b_packet_within_single_cycle = new();
      end
   end
   
   
   //-------------------------------------------------------------------------------
   // =head3 c_b2b_packet_in_different_cycle
   // This cover group covers back to back packet transfer in different cycle.
   //-------------------------------------------------------------------------------

   covergroup cg_b2b_packet_in_different_cycle;
      cp_b2b_packet_in_different_cycle: coverpoint idles_between_b2b_packet_transaction_counter
      {
         bins cg_b2b_packet_in_different_cycle_cp_b2b_packet_in_different_cycle = {0};
      }
      option.per_instance = 1;
   endgroup

   cg_b2b_packet_in_different_cycle c_b2b_packet_in_different_cycle;

   initial begin
      #1 if (enable_c_b2b_packet_in_different_cycle && USE_PACKET && USE_VALID && (ST_BEATSPERCYCLE > 1)) begin
         c_b2b_packet_in_different_cycle = new();
      end
   end
   
   //-------------------------------------------------------------------------------
   // =head3 c_error_in_middle_of_packet 
   // This cover group covers assert error in the middle of a packet.
   //-------------------------------------------------------------------------------

   covergroup cg_error_in_middle_of_packet;
      cp_error_in_middle_of_packet: coverpoint error_in_middle_of_packet
      {
         bins cg_error_in_middle_of_packet_cp_error_in_middle_of_packet = {1};
      }
      option.per_instance = 1;
   endgroup

   cg_error_in_middle_of_packet c_error_in_middle_of_packet;

   initial begin
      #1 if (enable_c_error_in_middle_of_packet && USE_PACKET && USE_ERROR) begin
         c_error_in_middle_of_packet = new();
      end
   end
   
   // =cut
   
   //--------------------------------------------------------------------------
   // COVERAGE CODE END
   //--------------------------------------------------------------------------   
   `endif 
   // synthesis translate_on
   
endmodule


