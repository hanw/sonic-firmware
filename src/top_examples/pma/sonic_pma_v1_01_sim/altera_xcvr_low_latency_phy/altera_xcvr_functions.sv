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


//
// Common functions for transceiver PHY IP
//
// $Header$
//
// PACKAGE DECLARATION
package altera_xcvr_functions;
	localparam integer MAX_CHARS = 32;
	localparam integer MAX_STRS = 16;

  // Reconfiguration bundle widths per family
  localparam integer W_S5_RECONFIG_BUNDLE_TO_XCVR    = 70;
  localparam integer W_S5_RECONFIG_BUNDLE_FROM_XCVR  = 46;
  localparam integer W_S4_RECONFIG_BUNDLE_TO_XCVR    = 4;
  localparam integer W_S4_RECONFIG_BUNDLE_FROM_XCVR  = 17;
  localparam integer W_C4_RECONFIG_BUNDLE_TO_XCVR    = 4;
  localparam integer W_C4_RECONFIG_BUNDLE_FROM_XCVR  = 17;

  // Reconfiguration bundle widths per family
  localparam integer W_S5_RECONFIG_BUNDLE_TO_GXB    = W_S5_RECONFIG_BUNDLE_TO_XCVR;
  localparam integer W_S5_RECONFIG_BUNDLE_FROM_GXB  = W_S5_RECONFIG_BUNDLE_FROM_XCVR;
  localparam integer W_S4_RECONFIG_BUNDLE_TO_GXB    = W_S4_RECONFIG_BUNDLE_TO_XCVR;
  localparam integer W_S4_RECONFIG_BUNDLE_FROM_GXB  = W_S4_RECONFIG_BUNDLE_FROM_XCVR;
  localparam integer W_C4_RECONFIG_BUNDLE_TO_GXB    = W_C4_RECONFIG_BUNDLE_TO_XCVR;
  localparam integer W_C4_RECONFIG_BUNDLE_FROM_GXB  = W_C4_RECONFIG_BUNDLE_FROM_XCVR;

	// convert frequency string into integer Hz.  Fractional Hz are truncated
	// Must remain a constant function - can't use string.atoi().
	function time str2hz (
		input [8*MAX_CHARS:1] s
	);

		integer i;
		integer c; // temp char storage for frequency conversion
		integer unit_tens; // assume already Hz
		integer is_numeric;
		integer saw_dot;
		
		reg [8:1] c_dot; // = ".";
		reg [8:1] c_space; // = " ";
		reg [8:1] c_a; // = 8'h61; //"a";
		reg [8:1] c_z; // = 8'h7a; //"z";
		reg [8*4:1] s_unit;
                reg [8*MAX_CHARS:1] s_shift;
		
		begin
			// frequency ratio calculations
			str2hz = 0;
			unit_tens = 0; // assume already Hz
			is_numeric = 1;
			saw_dot = 0;
			s_unit = "";
			
			// Modelsim optimizer bug forces us to initialize these non-statically
			c_dot = ".";
			c_space = " ";
			c_a = "a";
			c_z = "z";
			for (i=(MAX_CHARS-1); i>=0; i=i-1) begin
                                s_shift = (s >> (i*8));
				c = s_shift[8:1] & 8'hff;
				if (c > 0) begin
					//$display("[%d] => '%1s',", i, c);
					if (c >= 8'h30 && c <= 8'h39 && is_numeric) begin
						str2hz = (str2hz * 10) + (c & 8'h0f);
						if (saw_dot) unit_tens = unit_tens - 1;  // count digits after decimal point
					end else if (c == c_dot) saw_dot = 1;
					else if (c != c_space) begin
						is_numeric = 0;	// stop accepting new numeric digits in value
						// if it's a-z, convert to upper case A-Z
						if (c >= c_a && c <= c_z) c = (c & 8'h5f);	// convert a-z (lower) to A-Z (upper)
						s_unit = (s_unit << 8) | c;
					end
				end
			end
			//$display("numeric = %d x 10**(%2d), unit = '%0s'", str2hz, unit_tens, s_unit);
			
			// account for frequency unit
			if (s_unit == "GHZ" || s_unit == "GBPS") unit_tens = unit_tens + 9; // 10**9
			else if (s_unit == "MHZ" || s_unit == "MBPS") unit_tens = unit_tens + 6; // 10**6
			else if (s_unit == "KHZ" || s_unit == "KBPS") unit_tens = unit_tens + 3; // 10**3
			else if (s_unit != "HZ" && s_unit != "BPS") begin
				$display("Invalid frequency unit '%0s', assuming %d x 10**(%2d) 'Hz'", s_unit, str2hz, unit_tens);
			end
			//$display("numeric in Hz = %d x 10**(%2d)", str2hz, unit_tens);

			// align numeric to Hz
			if (unit_tens < 0) begin
				//str2hz = str2hz / (10**(-unit_tens));
				for (i=0; i>unit_tens; i=i-1) begin
					str2hz = str2hz / 10;
				end
			end else begin
				//str2hz = str2hz * (10**unit_tens);
				for (i=0; i<unit_tens; i=i+1) begin
					str2hz = str2hz * 10;
				end
			end
			//$display("%d Hz", str2hz);
		end
	endfunction
	
	// convert integer Hz to a frequency string
	// integer Hz as type time, and the frequency string will use MHz units
	// Must remain a constant function - can't use $sformat or string.itoa().
	function [MAX_CHARS*8-1:0] hz2str (
		input time hz
	);
		integer pos;
		integer f_unit;	// 10**f_unit is offset from Hz for larger unit
                time hz_mod_10;
		begin
			hz2str = "0.000000 MHz";	// minimum string value
			f_unit = 6;	// MHz offsets Hz value by 6 decimal digits

			// convert time back to string with frequency units
			// char positions 3 to 0 are used by " MHz", so start with digits at pos 4
			for (pos = 4; pos < MAX_CHARS && hz > 0; pos = pos + 1) begin
				if (f_unit == 0) begin
					hz2str[pos*8 +: 8] = 8'h2e;	// add "." character
					pos = pos + 1;
				end
				f_unit = f_unit - 1;
                                hz_mod_10 = (hz % 10);
				hz2str[pos*8 +: 8] = hz_mod_10[7:0] | 8'h30;
				hz = hz / 10;
				//$display("hz2str() => so far '%s', pos (%d), f_unit(%d) ", hz2str, pos, f_unit);
			end
			//$display("hz2str() returns '%s'", hz2str);
		end
	endfunction

	// function to convert at most 40-bit long string to binary
	function [39 : 0] m_str_to_bin;
	    input [40*8 : 1] s;
	    reg   [40*8 : 1] reg_s;
	    reg   [40:1]     res;
	
	    integer m;
	    begin
	      
	        reg_s = s;
	        for (m = 40; m > 0; m = m-1 )
	        begin
	            res[m] = reg_s[313];
	            reg_s = reg_s << 8;
	        end
	          
	        m_str_to_bin = res;
	    end   
	endfunction

	////////////////////////////////////////////////////////////////////
	// Verify that the string value is contained in the legal set.
	//
	// The 'set' can consist of a single string with no delimiters, e.g. "individual",
	// or multiple values, separated by commas, and surrounded by parens, e.g. "(one,two,three,four,five)"
	//
	// Returns 1 if the value is in the set, and 0 otherwise
	function integer is_in_legal_set(
		input [MAX_CHARS*8-1:0] value,
		input [MAX_STRS*MAX_CHARS*8-1:0] set
	);
		if (value == "<auto_any>")
			is_in_legal_set = 1;
		else if (value == "<auto_single>")
			is_in_legal_set = (set[7:0] == 8'h29) ? 0 : 1;  // 8'h29 is closing parenthesis char
		else if (value == set)
			is_in_legal_set = 1;  // value matches single value in set
		else begin
			// check value against each in set
			integer close_pos;	// end of string marker can be comma or closing paren
			integer open_pos;	// open paren is start of set, if appropriate
			reg [MAX_STRS*MAX_CHARS*8-1:0] legalstr;
			
			is_in_legal_set = 0;
			open_pos = MAX_STRS*MAX_CHARS-1;
			while (open_pos >= 1 && set[open_pos*8 +: 8] != 8'h28) // look for open paren (8'h28)
				open_pos = open_pos - 1;
			while (is_in_legal_set == 0 && open_pos > 1) begin
				close_pos = open_pos-1;
				while (close_pos >= 0
						 && set[close_pos*8 +: 8] != 8'h2c  // look for comma (8'h2c)
						 && set[close_pos*8 +: 8] != 8'h29) // or for closing paren (8'h29)
					close_pos = close_pos - 1;
				if (close_pos >= 0) begin
					legalstr = ((set & ((1'b1 << open_pos*8)-1)) >> close_pos*8+8);
					if (value == legalstr)
						is_in_legal_set = 1;
				end
				open_pos = close_pos;  // prepare to look for next legal string
			end
		end
		//$display("is_in_legal_set(): returns %d", is_in_legal_set);
	endfunction


	////////////////////////////////////////////////////////////////////////
	// Calculate the minimum number of bits needed to hold an integer value
	//
	// Returns ceil_log2() value
	localparam integer MAX_PRECISION = 32;	// VCS requires this declaration outside the function
	function integer ceil_log2;
		input [MAX_PRECISION-1:0] input_num;
		integer i;
		reg [MAX_PRECISION-1:0] try_result;
		begin
			i = 0;
			try_result = 1;
			while ((try_result << i) < input_num && i < MAX_PRECISION)
				i = i + 1;
			ceil_log2 = i;
		end
	endfunction

	////////////////////////////////////////////////////////////////////
	// Return current device family string for display purposes
	`ifndef XCVR_DEV_FAM
		`ifdef ALTERA_RESERVED_QIS_FAMILY
			`define XCVR_DEV_FAM `ALTERA_RESERVED_QIS_FAMILY	// synthesis: use QIS-defined value
		`else
			`define XCVR_DEV_FAM device_family	// simulation: use passed-in value
		`endif
	`endif
	function [MAX_CHARS*8-1:0] current_device_family (
		input [MAX_CHARS*8-1:0] device_family
	);
		current_device_family = `XCVR_DEV_FAM;
	endfunction

	////////////////////////////////////////////////////////////////////
	// Match device family against standard family name strings
	//
	// Returns 1 if the names feature is present in the given device family
	function integer has_s4_style_hssi (
		input [MAX_CHARS*8-1:0] device_family
	);
		has_s4_style_hssi = (  (`XCVR_DEV_FAM == "Stratix IV")
							|| (`XCVR_DEV_FAM == "Arria II")
							|| (`XCVR_DEV_FAM == "Cyclone IV GX")	// not exact, but close enough
							|| (`XCVR_DEV_FAM == "Arria II GX")
							|| (`XCVR_DEV_FAM == "Arria II GZ")
							|| (`XCVR_DEV_FAM == "HardCopy IV")
							) ? 1 : 0;
	endfunction

	////////////////////////////////////////////////////////////////////
	// Match device family against standard family name strings
	//
	// Returns 1 if the names feature is present in the given device family
	function integer has_s5_style_hssi (
		input [MAX_CHARS*8-1:0] device_family
	);
		has_s5_style_hssi = (  (`XCVR_DEV_FAM == "Stratix V")
							) ? 1 : 0;
	endfunction
	
	////////////////////////////////////////////////////////////////////
	// Match device family against standard family name strings
	//
	// Returns 1 if the names feature is present in the given device family
	function integer has_a5_style_hssi (
		input [MAX_CHARS*8-1:0] device_family
	);
		has_a5_style_hssi = (  (`XCVR_DEV_FAM == "ArriaV")
							) ? 1 : 0;
	endfunction

	////////////////////////////////////////////////////////////////////
	// Match device family against standard family name strings
	//
	// Returns 1 if the names feature is present in the given device family
	function integer has_c4_style_hssi (
		input [MAX_CHARS*8-1:0] device_family
	);
		has_c4_style_hssi = (  (`XCVR_DEV_FAM == "Cyclone IV GX")
							) ? 1 : 0;
	endfunction

  ////////////////////////////////////////////////////////////////////
  // Get reconfig_to_gxb bundle width for specified device family
  //
  // Returns 0 if the device_family argument is invalid, otherwise
  // it returns the width of the reconfig_to_gxb bundle for that family
  function integer get_reconfig_to_gxb_width (
    input [MAX_CHARS*8-1:0] device_family
  );
    if (has_s5_style_hssi(device_family))
      get_reconfig_to_gxb_width = W_S5_RECONFIG_BUNDLE_TO_XCVR;
    else if (has_s4_style_hssi(device_family))
      get_reconfig_to_gxb_width = W_S4_RECONFIG_BUNDLE_TO_XCVR;
   else if (has_c4_style_hssi(device_family))
      get_reconfig_to_gxb_width = W_C4_RECONFIG_BUNDLE_TO_XCVR;
    else
      get_reconfig_to_gxb_width = 0;
  endfunction

  ////////////////////////////////////////////////////////////////////
  // Get reconfig_from_gxb bundle width for specified device family
  //
  // Returns 0 if the device_family argument is invalid, otherwise
  // it returns the width of the reconfig_from_gxb bundle for that family
  function integer get_reconfig_from_gxb_width (
    input [MAX_CHARS*8-1:0] device_family
  );
    if (has_s5_style_hssi(device_family))
      get_reconfig_from_gxb_width = W_S5_RECONFIG_BUNDLE_FROM_XCVR;
    else if (has_s4_style_hssi(device_family))
      get_reconfig_from_gxb_width = W_S4_RECONFIG_BUNDLE_FROM_XCVR;
    else if (has_c4_style_hssi(device_family))
      get_reconfig_from_gxb_width = W_C4_RECONFIG_BUNDLE_FROM_XCVR;
    else
      get_reconfig_from_gxb_width = 0;
  endfunction
  
    ////////////////////////////////////////////////////////////////////
  // Get reconfig_to_xcvr total port width for specified device family
  //
  // Returns 0 if the device_family argument is invalid, otherwise
  // it returns the width of the reconfig_to_xcvr port for that family
  function integer get_reconfig_to_width (
    input [MAX_CHARS*8-1:0] device_family,
    input integer reconfig_interfaces
  );
    if (has_s5_style_hssi(device_family))
      get_reconfig_to_width = get_s5_reconfig_to_width(reconfig_interfaces);
    else if (has_s4_style_hssi(device_family))
      get_reconfig_to_width = W_S4_RECONFIG_BUNDLE_TO_XCVR;
    else if (has_c4_style_hssi(device_family))
      get_reconfig_to_width = W_C4_RECONFIG_BUNDLE_TO_XCVR;
    else
      get_reconfig_to_width = 0;
  endfunction

    ////////////////////////////////////////////////////////////////////
  // Get reconfig_to_xcvr total port width for Stratix V device family
  //
  function integer get_s5_reconfig_to_width (
    input integer reconfig_interfaces
  );
    get_s5_reconfig_to_width = reconfig_interfaces * get_reconfig_to_gxb_width("Stratix V");
  endfunction

    ////////////////////////////////////////////////////////////////////
  // Get reconfig_from_xcvr total port width for specified device family
  //
  // Returns 0 if the device_family argument is invalid, otherwise
  // it returns the width of the reconfig_from_xcvr port for that family
  function integer get_reconfig_from_width (
    input [MAX_CHARS*8-1:0] device_family,
    input integer reconfig_interfaces
  );
    if (has_s5_style_hssi(device_family))
      get_reconfig_from_width = reconfig_interfaces * get_reconfig_from_gxb_width(device_family);
    else if (has_s4_style_hssi(device_family))
      get_reconfig_from_width = reconfig_interfaces * get_reconfig_from_gxb_width(device_family);
    else if (has_c4_style_hssi(device_family))
      get_reconfig_from_width = reconfig_interfaces * get_reconfig_from_gxb_width(device_family);
    else
      get_reconfig_from_width = 0;
  endfunction

    ////////////////////////////////////////////////////////////////////
  // Get reconfig_from_xcvr total port width for Stratix V device family
  //
  function integer get_s5_reconfig_from_width (
    input integer reconfig_interfaces
  );
    get_s5_reconfig_from_width = reconfig_interfaces * get_reconfig_from_gxb_width("Stratix V");
  endfunction

    ////////////////////////////////////////////////////////////////////
  // Get number of reconfig interfaces for Custom PHY
  //
  // @param device_family - Desired device family
  // @param operation_mode - "Duplex","Rx","Tx" or "duplex", "rx_only", "tx_only" in 10gbaser
  // Returns 0 if the device_family argument is invalid, otherwise
  // it returns the width of the reconfig_from_xcvr port for that family
  function integer get_custom_reconfig_interfaces(
    input [MAX_CHARS*8-1:0] device_family,
    input [MAX_CHARS*8-1:0] operation_mode,
    input integer           lanes,
    input integer           plls,
    input integer           bonded_group_size
  );
    integer reconfig_interfaces;
    reconfig_interfaces = 0;
    if(has_s5_style_hssi(device_family)) begin
      if((operation_mode == "RX") || (operation_mode == "Rx") || (operation_mode == "rx_only"))
        reconfig_interfaces = lanes;
      else begin
        reconfig_interfaces = lanes+(plls*(lanes/bonded_group_size));
      end
    end
    get_custom_reconfig_interfaces = reconfig_interfaces;
  endfunction

    ////////////////////////////////////////////////////////////////////
  // Get reconfig_to_xcvr total port width for Custom PHY
  //
  // @param device_family - Desired device family
  // @param operation_mode - "Duplex","Rx","Tx" or "duplex", "rx_only", "tx_only" in 10gbaser
  // @param lanes - Number of transceiver channels
  // @param plls - Number of plls per bonded group
  // @param bonded_group_size - Size of bonded group (1 or lanes)
  // Returns 0 if the device_family argument is invalid, otherwise
  // it returns the width of the reconfig_from_xcvr port for that family
  function integer get_custom_reconfig_to_width(
    input [MAX_CHARS*8-1:0] device_family,
    input [MAX_CHARS*8-1:0] operation_mode,
    input integer           lanes,
    input integer           plls,
    input integer           bonded_group_size
  );
    integer reconfig_interfaces;
    reconfig_interfaces = get_custom_reconfig_interfaces(device_family,operation_mode,lanes,plls,bonded_group_size);
    get_custom_reconfig_to_width = get_s5_reconfig_to_width(reconfig_interfaces);
  endfunction

    ////////////////////////////////////////////////////////////////////
  // Get reconfig_from_xcvr total port width for Custom PHY
  //
  // @param device_family - Desired device family
  // @param operation_mode - "Duplex","Rx","Tx" or "duplex", "rx_only", "tx_only" in 10gbaser
  // Returns 0 if the device_family argument is invalid, otherwise
  // it returns the width of the reconfig_from_xcvr port for that family
  function integer get_custom_reconfig_from_width(
    input [MAX_CHARS*8-1:0] device_family,
    input [MAX_CHARS*8-1:0] operation_mode,
    input integer           lanes,
    input integer           plls,
    input integer           bonded_group_size
  );
    integer reconfig_interfaces;
    reconfig_interfaces = get_custom_reconfig_interfaces(device_family,operation_mode,lanes,plls,bonded_group_size);
    get_custom_reconfig_from_width = get_s5_reconfig_from_width(reconfig_interfaces);
  endfunction


   ////////////////////////////////////////////////////////////////////   
   // Start Interlaken Specific functions for calculating reconfig interfaces 
   // and reconfig_to_gxb, reconfig_from_gxb widths  

    ////////////////////////////////////////////////////////////////////
  // Get number of reconfig interfaces for Interlaken PHY
  //
  // @param device_family - Desired device family
  // @param operation_mode - "Duplex","Rx","Tx" or "duplex", "rx_only", "tx_only" in 10gbaser
  // Returns 0 if the device_family argument is invalid, otherwise
  // it returns the width of the reconfig_from_xcvr port for that family
  function integer get_interlaken_reconfig_interfaces(
    input [MAX_CHARS*8-1:0] device_family,
    input [MAX_CHARS*8-1:0] operation_mode,
    input integer 	    bonded_group_size,
    input integer           lanes
  );
     integer 		    reconfig_interfaces;
     integer 		    xslices;
     integer 		    xremain;
     integer 		    totalplls;
		    
    reconfig_interfaces = 0;
    if(has_s5_style_hssi(device_family)) begin
      if((operation_mode == "RX") || (operation_mode == "Rx") || (operation_mode == "rx_only"))
        reconfig_interfaces = lanes;
      else begin
	 xslices = lanes/bonded_group_size;
	 xremain = lanes % bonded_group_size;
	 
	 if (xremain >0)
	   totalplls = xslices +1;
	 else
	   totalplls = xslices;
         reconfig_interfaces = lanes+totalplls;
      end // else: !if((operation_mode == "RX") || (operation_mode == "Rx") || (operation_mode == "rx_only"))
    end // if (has_s5_style_hssi(device_family))
    get_interlaken_reconfig_interfaces = reconfig_interfaces;
  endfunction

    ////////////////////////////////////////////////////////////////////
  // Get reconfig_to_xcvr total port width for Interlaken PHY
  //
  // @param device_family - Desired device family
  // @param operation_mode - "Duplex","Rx","Tx" or "duplex", "rx_only", "tx_only" in 10gbaser
  // @param lanes - Number of transceiver channels
  // Returns 0 if the device_family argument is invalid, otherwise
  // it returns the width of the reconfig_from_xcvr port for that family
  function integer get_interlaken_reconfig_to_width(
    input [MAX_CHARS*8-1:0] device_family,
    input [MAX_CHARS*8-1:0] operation_mode,
    input integer 	    bonded_group_size,
    input integer           lanes
  );
    integer reconfig_interfaces;
    reconfig_interfaces = get_interlaken_reconfig_interfaces(device_family,operation_mode,bonded_group_size,lanes);
    get_interlaken_reconfig_to_width = get_s5_reconfig_to_width(reconfig_interfaces);
  endfunction

    ////////////////////////////////////////////////////////////////////
  // Get reconfig_from_xcvr total port width for Custom PHY
  //
  // @param device_family - Desired device family
  // @param operation_mode - "Duplex","Rx","Tx" or "duplex", "rx_only", "tx_only" in 10gbaser
  // Returns 0 if the device_family argument is invalid, otherwise
  // it returns the width of the reconfig_from_xcvr port for that family
  function integer get_interlaken_reconfig_from_width(
    input [MAX_CHARS*8-1:0] device_family,
    input [MAX_CHARS*8-1:0] operation_mode,
    input integer 	    bonded_group_size,          						      
    input integer           lanes
  );
    integer reconfig_interfaces;
    reconfig_interfaces = get_interlaken_reconfig_interfaces(device_family,operation_mode,bonded_group_size,lanes);
    get_interlaken_reconfig_from_width = get_s5_reconfig_from_width(reconfig_interfaces);
  endfunction

   // End Interlaken specific functions
   ////////////////////////////////////////////////////////////////////   




   
endpackage
