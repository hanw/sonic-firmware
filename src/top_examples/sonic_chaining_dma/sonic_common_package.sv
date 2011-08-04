`ifndef __SONIC_COMMON__
`define __SONIC_COMMON__

package sonic_common;

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

function integer wide_enough_for;
	input [31:0] Depth;
	integer i;
	begin
		i = Depth;
		for (wide_enough_for = 0; i > 0 ; wide_enough_for = wide_enough_for + 1)
			i = i >> 1;
	end
endfunction 

function int maximum;
input int a, b;
begin
	if (a > b)
		maximum = a;
	else
		maximum = b;
end
endfunction 

endpackage: sonic_common

`endif
