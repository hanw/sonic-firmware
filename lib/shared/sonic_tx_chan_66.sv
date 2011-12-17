//                              -*- Mode: Verilog -*-
// Filename        : sonic_tx_chan_66.sv
// Description     : combines tx_cbuf and gearbox_66_40
// Author          : Han Wang
// Created On      : Sat Nov 26 22:35:34 2011
// Last Modified By: Han Wang
// Last Modified On: Sat Nov 26 22:35:34 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!

module sonic_tx_chan_66 (/*AUTOARG*/
   // Outputs
   data_out, tx_ring_rptr,
   // Inputs
   data_in, rd_clock, wr_clock, reset, wr_address, wrreq, enable_sfp,
   xcvr_tx_ready, tag_cpl
   ) ;

   input [127:0] data_in;
   output [39:0] data_out;
   input 	 rd_clock;
   input 	 wr_clock;
   input 	 reset;

   input [12:0]  wr_address;
   input 	 wrreq;
   input 	 enable_sfp;
   input 	 xcvr_tx_ready;
   input 	 tag_cpl;
   output [13:0] tx_ring_rptr;
   
   logic 	 gearbox_rdreq;
   logic [65:0]  tx_cbuf_data_out;
   
   logic 	 tx_cbuf_wrena;
   logic 	 tx_cbuf_wrreq;
   logic 	 tx_cbuf_rdreq;
   logic 	 tx_cbuf_rdena;
   logic 	 gearbox_ena;
      
   sonic_tx_ctl_66 tx_cbuf (.data_in(data_in),
			    .wr_address(wr_address),
			    .wr_clock(wr_clock),
			    .rd_clock(rd_clock),
			    .reset(reset),
			    .wrena(tx_cbuf_wrena),
			    .wrreq(tx_cbuf_wrreq),
			    .rdreq(tx_cbuf_rdreq),
			    .rdena(tx_cbuf_rdena),
			    .tag_cpl(tag_cpl),
			    .gearbox_ena(gearbox_ena),
			    .data_out(tx_cbuf_data_out),
			    .tx_ring_rptr(tx_ring_rptr)
			    );
   
   sonic_gearbox_66_40 gearbox (.data_in(tx_cbuf_data_out),
				.clk_in(rd_clock),
				.reset(reset),
				.ena(gearbox_ena),
				.data_out(data_out),
				.rd_req_out(gearbox_rdreq)
				);

   assign tx_cbuf_wrena = enable_sfp && xcvr_tx_ready;
   assign tx_cbuf_wrreq = wrreq;
   assign tx_cbuf_rdena = enable_sfp && xcvr_tx_ready;
   assign tx_cbuf_rdreq = gearbox_rdreq;
      
endmodule // sonic_tx_chan_66

