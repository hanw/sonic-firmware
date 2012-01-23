//                              -*- Mode: Verilog -*-
// Filename        : sonic_rx_chan_66.sv
// Description     : combines gearbox, blocksync, and cbuf.
//                   implement logic to indicate amount of available data.
// Author          : Han Wang
// Created On      : Sat Nov 26 15:27:23 2011
// Last Modified By: Han Wang
// Last Modified On: Sat Nov 26 15:27:23 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!


module sonic_rx_chan_66 (/*AUTOARG*/
   // Outputs
   data_out, rx_ring_wptr,
   // Inputs
   data_in, rd_clock, wr_clock, reset, rd_address, enable_sfp,
   xcvr_rx_ready, dma_rdreq
   ) ;

   input [39:0] data_in;
   input 	rd_clock;
   input 	wr_clock;
   input 	reset;
   input [`RX_READ_ADDR_WIDTH-1:0] rd_address;

   input 	enable_sfp;
   input 	xcvr_rx_ready;
   input 	dma_rdreq;
      
   output [127:0] data_out;
   output [`RX_WRITE_ADDR_WIDTH-1:0]  rx_ring_wptr;
   
   logic [65:0]   gearbox_data_out;
   logic [65:0]   blocksync_data_out;
   logic 	  gearbox_valid;
   logic 	  blocksync_lock;

   logic 	  rx_cbuf_rdena;
   logic 	  rx_cbuf_rdreq;
   logic 	  rx_cbuf_wrena;
   logic 	  rx_cbuf_wrreq;
   
   /*
    * gearbox
    */
   sonic_gearbox_40_66 gearbox (.data_in(data_in),
				.clk_in(wr_clock),
				.reset(reset),
				.data_out(gearbox_data_out),
				.data_valid(gearbox_valid)
				);
      
   /*
    * blocksync
    */
   sonic_blocksync_xg blocksync (.data_in(gearbox_data_out),
				 .clk(wr_clock),
				 .reset(reset),
				 .valid(gearbox_valid),
				 .data_out(blocksync_data_out),
				 .block_lock(blocksync_lock)
				 );
   
   /*
    * rx_cbuf
    */
   sonic_rx_ctl_66 rx_cbuf (.data_in(blocksync_data_out),
			    .rd_address(rd_address),
			    .rd_clock(rd_clock),
			    .wr_clock(wr_clock),
			    .reset(reset),
			    .rdena(rx_cbuf_rdena),
			    .rdreq(rx_cbuf_rdreq),
			    .wrena(rx_cbuf_wrena),
			    .wrreq(rx_cbuf_wrreq),
			    .data_out(data_out),
			    .rx_ring_wptr(rx_ring_wptr)
			    );
   /*
    * logics for rx datapath
    */
   assign rx_cbuf_rdena = enable_sfp & xcvr_rx_ready;
   assign rx_cbuf_rdreq = dma_rdreq;
   assign rx_cbuf_wrena = enable_sfp & xcvr_rx_ready;
   assign rx_cbuf_wrreq = gearbox_valid & blocksync_lock;
   
endmodule // sonic_rx_chan_66
