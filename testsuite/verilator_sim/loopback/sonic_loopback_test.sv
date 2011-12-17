/*
 * Test Bench: Connect rx_chan and tx_chan with loopback module
 * NOTE: This testbench execise the loopback mode with rx_chan and 
 * tx_chan. Data are injected to tx_chan and received on the rx_chan.
 * It verifies the functionality of rx_chan and tx_chan without the
 * involvement of DMA and XCVR.
 */

module sonic_loopback_test (/*AUTOARG*/
   // Outputs
   tx_ring_rptr, rx_data_out, rx_ring_wptr, data_out_xcvr,
   // Inputs
   tx_data_in, tx_wr_address, tx_wrreq, tx_tag_cpl, rx_rd_address,
   rx_dma_rdreq, loopback_en, data_in_xcvr, rd_clock, wr_clock, reset,
   enable_sfp, xcvr_tx_ready, xcvr_rx_ready
   ) ;

   /*
    * tx_chan inputs
    */
   input [127:0] tx_data_in;
   input [12:0]  tx_wr_address;
   input 	 tx_wrreq;
   input 	 tx_tag_cpl;
   output [13:0] tx_ring_rptr;
   
   /*
    * rx_chan inputs
    */
   output [127:0] rx_data_out;
   input [12:0]   rx_rd_address;
   input 	  rx_dma_rdreq;
   output [13:0]  rx_ring_wptr;
   
   /*
    * loopback 
    */
   input 	  loopback_en;
   input [39:0]   data_in_xcvr;
   output [39:0]  data_out_xcvr;
   
   /*
    * shared
    */
   input rd_clock;
   input wr_clock;
   input reset;
   
   input enable_sfp;
   input xcvr_tx_ready;
   input xcvr_rx_ready;

   logic [39:0] tx_data_out;
   logic [39:0] rx_data_in;
   
   /*
    * sonic_rx_chan
    */
   sonic_rx_chan_66 rx_chan (.data_in(rx_data_in),
			     .rd_clock(rd_clock),
			     .wr_clock(wr_clock),
			     .reset(reset),
			     .rd_address(rx_rd_address),
			     .enable_sfp(enable_sfp),
			     .xcvr_rx_ready(xcvr_rx_ready),
			     .dma_rdreq(rx_dma_rdreq),
			     .data_out(rx_data_out),
			     .rx_ring_wptr(rx_ring_wptr)
			     );
      
   /*
    * sonic_tx_chan
    */
   sonic_tx_chan_66 tx_chan (.data_in(tx_data_in),
			     .rd_clock(rd_clock),
			     .wr_clock(wr_clock),
			     .reset(reset),
			     .wr_address(tx_wr_address),
			     .wrreq(tx_wrreq),
			     .enable_sfp(enable_sfp),
			     .xcvr_tx_ready(xcvr_tx_ready),
			     .tag_cpl(tx_tag_cpl),
			     .tx_ring_rptr(tx_ring_rptr),
			     .data_out(tx_data_out)
			     );
      
   /*
    * sonic_rxtx_loopback
    */
   sonic_rxtx_loopback loopback (.clk_in(rd_clock),
				 .reset(reset),
				 .loopback_en(loopback_en),
				 .data_in_chan(tx_data_out),
				 .data_in_xcvr(data_in_xcvr),
				 .data_out_chan(rx_data_in),
				 .data_out_xcvr(data_out_xcvr)
				 );
      
endmodule // sonic_loopback_test
