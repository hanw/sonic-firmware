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
// output_name:                                       sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_tl_cfg_bfm
// role:width:direction:                              msicsr:16:output,prmcsr:32:output,devcsr:32:output,busdev:13:output,tcvcmap:24:output
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ns

module sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_tl_cfg_bfm
(
   sig_msicsr,
   sig_prmcsr,
   sig_devcsr,
   sig_busdev,
   sig_tcvcmap
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   output [15 : 0] sig_msicsr;
   output [31 : 0] sig_prmcsr;
   output [31 : 0] sig_devcsr;
   output [12 : 0] sig_busdev;
   output [23 : 0] sig_tcvcmap;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   localparam VERSION = "__ACDS_VERSION_SHORT__";
   
   typedef logic [15 : 0] ROLE_msicsr_t;
   typedef logic [31 : 0] ROLE_prmcsr_t;
   typedef logic [31 : 0] ROLE_devcsr_t;
   typedef logic [12 : 0] ROLE_busdev_t;
   typedef logic [23 : 0] ROLE_tcvcmap_t;

   reg [15 : 0] msicsr_temp;
   reg [31 : 0] prmcsr_temp;
   reg [31 : 0] devcsr_temp;
   reg [12 : 0] busdev_temp;
   reg [23 : 0] tcvcmap_temp;

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
   
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "10.1";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // msicsr
   // -------------------------------------------------------

   function automatic void set_msicsr (
      ROLE_msicsr_t new_value
   );
      // Drive the new value to msicsr.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      msicsr_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // prmcsr
   // -------------------------------------------------------

   function automatic void set_prmcsr (
      ROLE_prmcsr_t new_value
   );
      // Drive the new value to prmcsr.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      prmcsr_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // devcsr
   // -------------------------------------------------------

   function automatic void set_devcsr (
      ROLE_devcsr_t new_value
   );
      // Drive the new value to devcsr.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      devcsr_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // busdev
   // -------------------------------------------------------

   function automatic void set_busdev (
      ROLE_busdev_t new_value
   );
      // Drive the new value to busdev.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      busdev_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // tcvcmap
   // -------------------------------------------------------

   function automatic void set_tcvcmap (
      ROLE_tcvcmap_t new_value
   );
      // Drive the new value to tcvcmap.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      tcvcmap_temp = new_value;
   endfunction

   assign sig_msicsr = msicsr_temp;
   assign sig_prmcsr = prmcsr_temp;
   assign sig_devcsr = devcsr_temp;
   assign sig_busdev = busdev_temp;
   assign sig_tcvcmap = tcvcmap_temp;



// synthesis translate_on

endmodule


