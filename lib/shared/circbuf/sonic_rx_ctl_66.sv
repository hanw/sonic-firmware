//                              -*- Mode: Verilog -*-
// Filename        : sonic_rx_ctl_66.sv
// Description     : combines rx_circular_buffer_66 with control logic,
//                   so that buffer never overflow or underflow.
// Author          : Han Wang
// Created On      : Sun Nov 20 21:54:14 2011
// Last Modified By: Han Wang
// Last Modified On: Sun Nov 20 21:54:14 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!
`include "sonic_constants.sv"
  
module sonic_rx_ctl_66 (/*AUTOARG*/
   // Outputs
   data_out, rx_ring_wptr,
   // Inputs
   data_in, rd_address, rd_clock, wr_clock, reset, rdena, rdreq,
   wrena, wrreq
   ) ;

   input [65:0] data_in;
   input [12:0] rd_address; // with rdreq to be DMA interface.
   input 	rd_clock;
   input 	wr_clock;
   input 	reset;
   input 	rdena; // enable_sfp, xcvr_ready
   input 	rdreq; // dma read from cbuf.
   input 	wrena; // enable_sfp, xcvr_ready
   input 	wrreq; // gearbox valid, block lock
   output [127:0] data_out;
   output [13:0]  rx_ring_wptr; // export write pointer of rx buffer to irq
   		
   logic 	  rx_full;
   logic 	  rx_empty;
   logic 	  rx_almost_full;
   logic 	  rx_almost_empty;
   logic 	  rx_cbuf_wrena;
   logic 	  rx_cbuf_rdena;
   
   // rx_cbuf_wrreq: '1' when data from gearbox is valid, and block sync is locked.
   // rx_cbuf_wrena: enabled when xcvr is enabled, and signal is good, and buffer not full.
   assign rx_cbuf_wrena = wrena && ~rx_full;
//   assign rx_cbuf_wrena = wrena;
   
   // rx_cbuf_rdreq: dma controlled.
   // rx_cbuf_rdena: enabled when xcvr is enabled, and signal is good, and buffer not empty.
   assign rx_cbuf_rdena = rdena && ~rx_empty;
   
   /*
    * sonic_rx_circular_buffer_66
    * 
    */
   sonic_rx_circular_buffer_66 rx_cbuf (.data_in(data_in),
					.rd_address(rd_address),
					.rd_clk(rd_clock),
					.reset(reset),
					.wr_clk(wr_clock),
					.wrena(rx_cbuf_wrena),
					.wrreq(wrreq),
					.data_out(data_out) 
					);
   
   /*
    * Keep track of full, empty signals
    * standard usedw calculator.
    */
   sonic_common_fifo_usedw_calculator usedw_calc (.rdclock(rd_clock),
						  .wrclock(wr_clock),
						  .reset(reset),
						  .wrena(rx_cbuf_wrena),
						  .wrreq(wrreq),
						  .rdreq(rdreq),
						  .rdena(rx_cbuf_rdena),
						  .wrusedqwords(),
						  .full(rx_full),
						  .almost_full(rx_almost_full),
						  .rdusedqwords(),
						  .clock_crossed_wptr(rx_ring_wptr),
						  .clock_crossed_rptr(),
						  .empty(rx_empty),
						  .almost_empty(rx_almost_empty)
						  );
   defparam usedw_calc.WIDTH = `USED_QWORDS_WIDTH,
     usedw_calc.QWORD_DEPTH = 14'h3E00,
     usedw_calc.UPSTREAM = 1,
     usedw_calc.READ_TO_WRITE_DELAY = 0,
     usedw_calc.WRITE_TO_READ_DELAY = 0;

endmodule // sonic_rx_ctl_66


//-----------------------------------------------------------------------------------------
// Copyright 2011 Cornell University. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of
// conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
// of conditions and the following disclaimer in the documentation and/or other materials
// provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY CORNELL UNIVERSITY ''AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
// ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// The views and conclusions contained in the software and documentation are those of the
// authors and should not be interpreted as representing official policies, either expressed
// or implied, of Cornell University.
//------------------------------------------------------------------------------------------
