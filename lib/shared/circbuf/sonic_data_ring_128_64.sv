//                              -*- Mode: Verilog -*-
// Filename        : sonic_data_ring_128_64.sv
// Description     : break down 128-bit memory to 64 bit to improve memory utilization.
// Author          : Han Wang
// Created On      : Wed Jan 11 12:31:00 2012
// Last Modified By: Han Wang
// Last Modified On: Wed Jan 11 12:31:00 2012
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "sonic_constants.sv"

module sonic_data_ring_128_64 (/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   data, rdaddress, rdclock, rden, wraddress, wrclock, wren
   ) ;

   input [127:0] data;
   input [`TX_READ_ADDR_WIDTH-1:0] rdaddress;
   input 			   rdclock;
   input 			   rden;
   input [`TX_WRITE_ADDR_WIDTH-1:0] wraddress;
   input 			    wrclock;
   input 			    wren;
   output [63:0] 		    q;

   wire [31:0] 			    data0, data1, data2, data3;
   wire [31:0] 			    q0, q1, q2, q3;
   
   assign {data3, data2, data1, data0} = data;

   assign q = (rdaddress[0] == 1'b0) ? {q1, q0} : {q3, q2};
   
   /*
    * input 00 goes to ring0, 1, 2, 3.
    * input 01 goes to ring0, 1, 2, 3.
    * 
    * output 00 from ring 0, 1
    * output 01 from ring 2, 3
    * output 10 from ring 0, 1
    * output 11 from ring 2, 3
    */
   
   sonic_dpram_async_32_32 ring0 (.data(data0),
				  .rdaddress(rdaddress[`TX_READ_ADDR_WIDTH-1:1]),
				  .rdclock(rdclock),
				  .rden(rden),
				  .wraddress(wraddress),
				  .wrclock(wrclock),
				  .wren(wren),
				  .q(q0)
				  );

   sonic_dpram_async_32_32 ring1 (.data(data1),
				  .rdaddress(rdaddress[`TX_READ_ADDR_WIDTH-1:1]),
				  .rdclock(rdclock),
				  .rden(rden),
				  .wraddress(wraddress),
				  .wrclock(wrclock),
				  .wren(wren),
				  .q(q1)
				  );

   sonic_dpram_async_32_32 ring2 (.data(data2),
				  .rdaddress(rdaddress[`TX_READ_ADDR_WIDTH-1:1]),
				  .rdclock(rdclock),
				  .rden(rden),
				  .wraddress(wraddress),
				  .wrclock(wrclock),
				  .wren(wren),
				  .q(q2)
				  );

   sonic_dpram_async_32_32 ring3 (.data(data3),
				  .rdaddress(rdaddress[`TX_READ_ADDR_WIDTH-1:1]),
				  .rdclock(rdclock),
				  .rden(rden),
				  .wraddress(wraddress),
				  .wrclock(wrclock),
				  .wren(wren),
				  .q(q3)
				  );

   
endmodule // sonic_data_ring_128_64
