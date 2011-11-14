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
// Common functions for PMA serdes
//
// $Header$
//
// PACKAGE DECLARATION
package alt_pma_functions;

    // convert "xx.xxx MHz"  to ps
    function integer freq2ps; 
    input [8*16:1] s;

    integer in_freq_khz;
    integer period_ps;
  
  	in_freq_khz =  mega2k(s);      
 	freq2ps = 1000000000/(in_freq_khz);
    endfunction


    // convert "xx.xxx MHz" string to integer with hz as unit
    function integer mega2k; 
    input [8*16:1] s;

    reg [8*16:1] reg_s;
    reg [8:1] digit;
    reg [8:1] tmp;
    integer m, magnitude;
    integer final_mag;
    integer unit_mag;
    integer point_pos;

    begin
        magnitude = 0;
        reg_s = s;
        unit_mag = 1000000;
        point_pos = 0;
        for (m=1; m<=16; m=m+1)
        begin
             tmp = reg_s[128:121];
            digit = tmp & 8'b00001111;
            reg_s = reg_s << 8;
            // Accumulate ascii digits 0-9 only.
            if (tmp == 77)
                unit_mag = 1000;  // Found a 'M' character, Mhz
            if (tmp == 46)
                point_pos = 1;  // Found a '.' character, point
            if ((tmp>=48) && (tmp<=57)) begin 
                magnitude = (magnitude * 10) + digit;
                point_pos = point_pos *10;
                end
        end
        if(point_pos > 0)
			mega2k = magnitude*unit_mag/point_pos;
		else
			mega2k = magnitude*unit_mag;
     end
    endfunction

endpackage
