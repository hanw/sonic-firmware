//                              -*- Mode: Verilog -*-
// Filename        : sonic_data_ring_64_128.sv
// Description     : break large 128-bit memory into smaller 32-bit memory 
//                   for better resource utilization.
// Author          : Han Wang
// Created On      : Wed Jan 11 11:58:00 2012
// Last Modified By: Han Wang
// Last Modified On: Wed Jan 11 11:58:00 2012
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "sonic_constants.sv"

module sonic_data_ring_64_128 (/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   data, wraddress, wrclock, wren, rdaddress, rdclock, rden
   ) ;
   input [63:0] data;
   input [`RX_WRITE_ADDR_WIDTH-1:0] wraddress;
   input 			    wrclock;
   input 			    wren;
   input [`RX_READ_ADDR_WIDTH-1:0]  rdaddress;
   input 			    rdclock;
   input 			    rden;
   output [127:0] 		    q;

   wire [31:0] 			    q0, q1, q2, q3;
   wire [31:0] 			    data0, data1;
   
   assign q = {q3, q2, q1, q0};
   assign {data0, data1} = data;
   
   /*
    * 64-bit input data,
    * 32-bit output data.
    * 
    * Write address:
    * Data 00 goes to ring0, 1.
    * Data 01 goes to ring2, 3.
    * Data 10 goes to ring0, 1.
    * Data 11 goes to ring2, 3.
    * 
    * Read address:
    * Data 0b00 gets from ring0, 1, 2, 3.
    * Data 0b01 gets from ring0, 1, 2, 3.
    */
   
   sonic_dpram_async_32_32 ring0 (.data(data0),
				  .wraddress({1'b0, wraddress[`RX_WRITE_ADDR_WIDTH-1:1]}),
				  .wrclock(wrclock),
				  .wren(wren && ~wraddress[0]), //0b00.
				  .rdaddress(rdaddress),
				  .rdclock(rdclock),
				  .rden(rden), 
				  .q(q0)
				  );

   sonic_dpram_async_32_32 ring1 (.data(data1),
				  .wraddress({1'b0, wraddress[`RX_WRITE_ADDR_WIDTH-1:1]}),
				  .wrclock(wrclock),
				  .wren(wren && ~wraddress[0]),  //0b00 
				  .rdaddress(rdaddress),
				  .rdclock(rdclock),
				  .rden(rden), 
				  .q(q1)
				  );

   sonic_dpram_async_32_32 ring2 (.data(data0),
				  .wraddress({1'b0, wraddress[`RX_WRITE_ADDR_WIDTH-1:1]}),
				  .wrclock(wrclock),
				  .wren(wren && wraddress[0]),   //0b01
				  .rdaddress(rdaddress),
				  .rdclock(rdclock),
				  .rden(rden), 
				  .q(q2)
				  );

   sonic_dpram_async_32_32 ring3 (.data(data1),
				  .wraddress({1'b0, wraddress[`RX_WRITE_ADDR_WIDTH-1:1]}),
				  .wrclock(wrclock),
				  .wren(wren && wraddress[0]),   //0b01. 
				  .rdaddress(rdaddress),
				  .rdclock(rdclock),
				  .rden(rden), 
				  .q(q3)
				  );
   
endmodule // sonic_data_ring_64_128
