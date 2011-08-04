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
// output_name:                                       sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_cpl_err_bfm
// role:width:direction:                              export:7:input
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ns

module sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_cpl_err_bfm
(
   sig_export
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   input [6 : 0] sig_export;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   localparam VERSION = "__ACDS_VERSION_SHORT__";
   
   typedef logic [6 : 0] ROLE_export_t;

   logic [6 : 0] export_local;

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
   
   event signal_input_export_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "10.1";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // export
   // -------------------------------------------------------
   function automatic ROLE_export_t get_export();
   
      // Gets the export input value.
      $sformat(message, "%m: called get_export");
      print(VERBOSITY_DEBUG, message);
      return sig_export;
      
   endfunction


   always @(sig_export) begin
      if (export_local != sig_export)
         -> signal_input_export_change;
      export_local = sig_export;
   end
   


// synthesis translate_on

endmodule


