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


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_rx_st_misc_bfm
// role:width:direction:                              stream_mask0:1:input,st_be0:16:output,st_bardec0:8:output
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ns

module sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_rx_st_misc_bfm
(
   sig_stream_mask0,
   sig_st_be0,
   sig_st_bardec0
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   input sig_stream_mask0;
   output [15 : 0] sig_st_be0;
   output [7 : 0] sig_st_bardec0;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   localparam VERSION = "__ACDS_VERSION_SHORT__";
   
   typedef logic ROLE_stream_mask0_t;
   typedef logic [15 : 0] ROLE_st_be0_t;
   typedef logic [7 : 0] ROLE_st_bardec0_t;

   logic [0 : 0] stream_mask0_local;
   reg [15 : 0] st_be0_temp;
   reg [7 : 0] st_bardec0_temp;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_input_stream_mask0_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "10.1";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // stream_mask0
   // -------------------------------------------------------
   function automatic ROLE_stream_mask0_t get_stream_mask0();
   
      // Gets the stream_mask0 input value.
      $sformat(message, "%m: called get_stream_mask0");
      print(VERBOSITY_DEBUG, message);
      return sig_stream_mask0;
      
   endfunction

   // -------------------------------------------------------
   // st_be0
   // -------------------------------------------------------

   function automatic void set_st_be0 (
      ROLE_st_be0_t new_value
   );
      // Drive the new value to st_be0.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      st_be0_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // st_bardec0
   // -------------------------------------------------------

   function automatic void set_st_bardec0 (
      ROLE_st_bardec0_t new_value
   );
      // Drive the new value to st_bardec0.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      st_bardec0_temp = new_value;
   endfunction

   assign sig_st_be0 = st_be0_temp;
   assign sig_st_bardec0 = st_bardec0_temp;

   always @(sig_stream_mask0) begin
      if (stream_mask0_local != sig_stream_mask0)
         -> signal_input_stream_mask0_change;
      stream_mask0_local = sig_stream_mask0;
   end
   


// synthesis translate_on

endmodule


