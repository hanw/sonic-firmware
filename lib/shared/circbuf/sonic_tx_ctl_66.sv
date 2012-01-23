//                              -*- Mode: Verilog -*-
// Filename        : sonic_tx_ctl_66.sv
// Description     : combines tx_circular_buffer_66 and gearbox_66_40
// Author          : Han Wang
// Created On      : Sun Nov 20 21:52:52 2011
// Last Modified By: Han Wang
// Last Modified On: Sun Nov 20 21:52:52 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "sonic_constants.sv"

module sonic_tx_ctl_66 (/*AUTOARG*/
   // Outputs
   data_out, gearbox_ena, tx_ring_rptr,
   // Inputs
   data_in, wr_address, wr_clock, rd_clock, reset, wrena, rdreq,
   wrreq, rdena, tag_cpl
   ) ;

   input [127:0] data_in;
   input [`TX_WRITE_ADDR_WIDTH-1:0]  wr_address;
   input 	 wr_clock;
   input 	 rd_clock;
   input 	 reset;
   input 	 wrena;
   input 	 rdreq; // gearbox_rdreq
   input 	 wrreq; // DMA: write_dmard.
   input 	 rdena;
   
   input 	 tag_cpl;

   output [65:0] data_out;
   output 	 gearbox_ena;
   output [`TX_READ_ADDR_WIDTH-1:0] tx_ring_rptr;
   
   logic 	 rd_ready;
   logic 	 rx_empty;
   logic 	 rx_full;
   logic 	 rx_almost_empty;
   logic 	 rx_almost_full;

   logic 	 rx_cbuf_rdena;
   logic 	 rx_cbuf_rdreq;
   logic 	 rx_cbuf_wrena;
      
   /*
    * Only enable tx gearbox when data are ready to send.
    * ELSE, gearbox is disabled and sends zero
    */
   assign gearbox_ena = rd_ready;
   
   wire rd_tag_cpl;
   
   sonic_common_signal_clock_crosser cpl_crosser(
						 .inclock(wr_clock),
						 .outclock(rd_clock),
						 .inena(1'b1),
						 .outena(1'b1),
						 .reset(reset),
						 .data(tag_cpl),
						 .q(rd_tag_cpl)
						 );
   defparam cpl_crosser.WIDTH=1,
     cpl_crosser.SHIFT_REGISTER_LENGTH=8;
   
   reg [`USED_QWORDS_WIDTH-1:0]  rd_cpld_qword_count;
   wire [`USED_QWORDS_WIDTH-1:0] wrusedqwords;
   wire [`USED_QWORDS_WIDTH-1:0] rdusedqwords;

   always @ (posedge rd_clock or posedge reset) begin
      if (reset == 1'b1) begin
	 rd_cpld_qword_count <= 0;
      end
      else begin
	 if(rd_tag_cpl == 1'b1) begin
	    if(rdreq == 1'b1) begin 
	       //prevent rd_cpld_qword_count from underflow
	       if (rdusedqwords - 1 > rdusedqwords)
		 rd_cpld_qword_count <= rdusedqwords;
	       else
		 rd_cpld_qword_count <= rdusedqwords - 14'h1;
	    end
	    else begin
	       rd_cpld_qword_count <= rdusedqwords;
	    end
	 end
	 else begin
	    if (rdreq == 1'b1) begin 
	       //prevent rd_cpld_qword_count from underflow
	       if (rd_cpld_qword_count - 1 > rd_cpld_qword_count)
		 rd_cpld_qword_count <= rd_cpld_qword_count;
	       else
		 rd_cpld_qword_count <= rd_cpld_qword_count - 14'h1;
	    end
	 end
      end
   end

   always @ (posedge rd_clock or posedge reset) begin
      if (reset == 1'b1) begin
	 rd_ready <= 1'b0;
      end 
      else begin
	 /* Heuristic solution :
	  * When gearbox_ena = 0, if we have rd_cpld_qword_count >= 0x200, gearbox_ena = 1.
	  * When gearbox_ena = 1, if we have rd_cpld_qword_count = 0, gearbox_ena 0.
	  */
	 if (gearbox_ena == 0) begin
	    if (rd_cpld_qword_count >= 14'h200) begin
	       rd_ready <= 1'b1;
	    end
	 end
	 else begin
	    if (rd_cpld_qword_count == 0) begin
	       rd_ready <= 1'b0;
	    end
	 end
      end
   end

   assign rx_cbuf_rdena = rdena && rd_ready; // enable_sfp && tx_ready && stuff to read
   assign rx_cbuf_rdreq = rdreq && rd_ready && ~rx_empty; // gearbox_rdreq && local_rd_ready
   assign rx_cbuf_wrena = wrena && ~rx_full;
   
   /*
    * sonic_tx_circular_buffer_66
    */
   sonic_tx_circular_buffer_66 tx_cbuf (
					.data_in(data_in),
					.wr_address(wr_address),
					.wr_clk(wr_clock),
					.rd_clk(rd_clock),
					.reset(reset),
					.wrreq(wrreq),
					.rdena(rx_cbuf_rdena),
					.rdreq(rx_cbuf_rdreq),
					.data_out(data_out),
					.clock_crossed_rd_address(tx_ring_rptr)
					);


   // instantiate a standard usedw calculator to do the usedw, empty, etc.
   // fifo enabled before dma starts.
	
   sonic_common_fifo_usedw_calculator usedw_calculator (
							.rdclock(rd_clock),
							.wrclock(wr_clock),
							.reset(reset),
							.wrreq(wrreq),
							.wrena(rx_cbuf_wrena), 
							.rdreq(rx_cbuf_rdreq),
							.rdena(rx_cbuf_rdena),
							.wrusedqwords(wrusedqwords),
							.full(rx_full),
							.almost_full(rx_almost_full),
							.rdusedqwords(rdusedqwords),
							.clock_crossed_wptr(),
							.clock_crossed_rptr(),
							.empty(rx_empty),
							.almost_empty(rx_almost_empty)
							);
   defparam usedw_calculator.WIDTH = `USED_QWORDS_WIDTH,
     usedw_calculator.QWORD_DEPTH = 15'h7C00, //NOTE: smaller than mem size.
     usedw_calculator.UPSTREAM = 0,
     usedw_calculator.READ_TO_WRITE_DELAY = 0,
     usedw_calculator.WRITE_TO_READ_DELAY = 0;	//covered by crossing domain delay


   
endmodule // sonic_tx_ctl_66


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
