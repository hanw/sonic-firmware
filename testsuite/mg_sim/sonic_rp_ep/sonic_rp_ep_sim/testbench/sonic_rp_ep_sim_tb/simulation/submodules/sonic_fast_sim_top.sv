//                              -*- Mode: Verilog -*-
// Filename        : sonic_fast_sim_top.sv
// Description     : Fast simulation without PCIe Root Port and Endpoint
// Author          : Han Wang
// Created On      : Sun Dec  4 17:51:22 2011
// Last Modified By: Han Wang
// Last Modified On: Sun Dec  4 17:51:22 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!

/*
 * This simulation is fast because we did not simulate root port and endpoint.
 * We also skipped the link training and endpoint configuration simulation.
 * 

                     rp_rx_st
     +--------+   +----------------+--------+      +--------+
     |        |   |    +-----+              |      |        |
     |  EP    |   |    |MON  | rp_rx_st_mon v  mux |  RP    |
     |        |+--+---->     |+------------------->|        |
     |        |        |     |                     |        |
     |        |        +-----+      ep_rx_st       |        |
     |        |                   +------------+   |        |
     |        |                   |            |   |        |
     |        |        +-----+mux v  +-----+   |   |        |
     |        |<-------+ BAR |<------+MON  |<--+---+        |
     |        |ep_rx_r +     |   mon |     |       +        |
     |        |        +-----+       +-----+       |        |
     |        |                                    |        |
     +--------+                                    +--------+
 
 */

module sonic_fast_sim_top (/*AUTOARG*/
   // Outputs
   xcvr_tx_datain,
   // Inputs
   pld_clk, rstn, xcvr_rx_clkout, xcvr_tx_clkout, xcvr_rx_dataout
   ) ;
   parameter USE_MON = 1;
      
   input pld_clk;
   input rstn;
   input 	  xcvr_rx_clkout;
   input 	  xcvr_tx_clkout;
   input [39:0]   xcvr_rx_dataout;
   output [39:0]  xcvr_tx_datain;

   logic [19:0] cfg_io_bas;  // from tl_cfg_sample, we use const.
   logic [11:0] cfg_np_bas;
   logic [43:0] cfg_pr_bas;
   logic [12:0] cfg_busdev;
   logic [31:0] cfg_devcsr;
   logic [31:0] cfg_prmcsr;
   logic [23:0] cfg_tcvcmap;
   logic [31:0] cfg_linkcsr;
   logic [15:0] cfg_msicsr;
   logic 	cpl_pending;
   logic [6:0] 	cpl_err;
   logic [127:0] err_desc;

   // RP Rx AST interface signals
   logic 	rp_rx_st_sop;
   logic 	rp_rx_st_eop;
   logic [127:0] rp_rx_st_data;
   logic 	 rp_rx_st_valid;
   logic 	 rp_rx_st_ready;
   logic 	 rp_rx_st_empty;
   logic 	 rp_rx_st_err;
   
   logic 	 rp_rx_st_sop_mon;
   logic 	 rp_rx_st_eop_mon;
   logic [127:0] rp_rx_st_data_mon;
   logic 	 rp_rx_st_valid_mon;
   logic 	 rp_rx_st_ready_mon;
   logic 	 rp_rx_st_empty_mon;
   logic 	 rp_rx_st_err_mon;

   logic 	 rp_rx_st_sop_mux;
   logic 	 rp_rx_st_eop_mux;
   logic [127:0] rp_rx_st_data_mux;
   logic 	 rp_rx_st_valid_mux;
   logic 	 rp_rx_st_ready_mux;
   logic 	 rp_rx_st_empty_mux;
   logic 	 rp_rx_st_err_mux;

   assign rp_rx_st_sop_mux = (USE_MON == 1) ? rp_rx_st_sop_mon : rp_rx_st_sop ;
   assign rp_rx_st_eop_mux = (USE_MON == 1) ? rp_rx_st_eop_mon : rp_rx_st_eop ;
   assign rp_rx_st_data_mux = (USE_MON == 1) ? rp_rx_st_data_mon : rp_rx_st_data ;
   assign rp_rx_st_valid_mux = (USE_MON == 1) ? rp_rx_st_valid_mon : rp_rx_st_valid ;
   assign rp_rx_st_ready_mux = (USE_MON == 1) ? rp_rx_st_ready_mon : rp_rx_st_ready ;
   assign rp_rx_st_empty_mux = (USE_MON == 1) ? rp_rx_st_empty_mon : rp_rx_st_empty ;
   assign rp_rx_st_err_mux = (USE_MON == 1) ? rp_rx_st_err_mon : rp_rx_st_err ;
      
   logic [15:0]  rp_rx_st_be;
   logic [7:0] 	 rp_rx_st_bardec;
   logic 	 rp_rx_st_mask;

   // EP Rx AST interface signals
   logic 	 ep_rx_st_sop;
   logic 	 ep_rx_st_eop;
   logic [127:0] ep_rx_st_data;
   logic 	 ep_rx_st_err;
   logic 	 ep_rx_st_ready;
   logic 	 ep_rx_st_empty;
   logic 	 ep_rx_st_valid;
   
   logic 	 ep_rx_st_sop_mon;
   logic 	 ep_rx_st_eop_mon;
   logic [127:0] ep_rx_st_data_mon;
   logic 	 ep_rx_st_err_mon;
   logic 	 ep_rx_st_ready_mon;
   logic 	 ep_rx_st_empty_mon;
   logic 	 ep_rx_st_valid_mon;

   logic 	 ep_rx_st_sop_mux;
   logic 	 ep_rx_st_eop_mux;
   logic [127:0] ep_rx_st_data_mux;
   logic 	 ep_rx_st_err_mux;
   logic 	 ep_rx_st_ready_mux;
   logic 	 ep_rx_st_empty_mux;
   logic 	 ep_rx_st_valid_mux;
   
   assign ep_rx_st_sop_mux = (USE_MON == 1) ? ep_rx_st_sop_mon : ep_rx_st_sop ;
   assign ep_rx_st_eop_mux = (USE_MON == 1) ? ep_rx_st_eop_mon : ep_rx_st_eop ;
   assign ep_rx_st_data_mux = (USE_MON == 1) ? ep_rx_st_data_mon : ep_rx_st_data ;
   assign ep_rx_st_err_mux = (USE_MON == 1) ? ep_rx_st_err_mon : ep_rx_st_err ;
   assign ep_rx_st_ready_mux = (USE_MON == 1) ? ep_rx_st_ready_mon : ep_rx_st_ready ;
   assign ep_rx_st_empty_mux = (USE_MON == 1) ? ep_rx_st_empty_mon : ep_rx_st_empty ;
   assign ep_rx_st_valid_mux = (USE_MON == 1) ? ep_rx_st_valid_mon : ep_rx_st_valid ;
   
   logic 	 ep_rx_st_sop_r;
   logic 	 ep_rx_st_eop_r;
   logic [127:0] ep_rx_st_data_r;
   logic 	 ep_rx_st_err_r;
   logic 	 ep_rx_st_empty_r;
   logic 	 ep_rx_st_valid_r;
   
   logic [15:0]   ep_rx_st_be;
   logic [7:0] 	  ep_rx_st_bardec;
   logic 	  tx_fifo_empty;   // const '1'
   
   logic [4:0] 	  pex_msi_num;
   logic 	  app_msi_req;
   logic [2:0] 	  app_msi_tc;
   logic [4:0] 	  app_msi_num;
   logic 	  app_int_sts;
   
   logic 	  pma_tx_ready;
   logic 	  pma_rx_ready;
   
   logic tx_stream_mask;
   /*
    * Root port: 
    * - root port bfm application
    * - bfm_vc_intf_128
    * - 
    */

   sonic_hard_ip_custom rp_tx_st (.clk_in(pld_clk),
				  .rstn(rstn),
				  .tx_st_data(ep_rx_st_data_mux),
				  .tx_st_sop(ep_rx_st_sop_mux),
				  .tx_st_eop(ep_rx_st_eop_mux),
				  .tx_st_valid(ep_rx_st_valid_mux),
				  .tx_st_err(ep_rx_st_err_mux),
				  .tx_st_empty(ep_rx_st_empty_mux),

				  .tx_st_data_r(ep_rx_st_data_r),
				  .tx_st_sop_r(ep_rx_st_sop_r),
				  .tx_st_eop_r(ep_rx_st_eop_r),
				  .tx_st_valid_r(ep_rx_st_valid_r),
				  .tx_st_err_r(ep_rx_st_err_r),
				  .tx_st_empty_r(ep_rx_st_empty_r),
				  .tx_st_be(ep_rx_st_be),
				  .tx_st_bardec(ep_rx_st_bardec)
				  );
      
   sonic_rp_top rp_top (
			       .pld_clk(pld_clk),
			       .rstn(rstn),
			       .cfg_io_bas(cfg_io_bas),
			       .cfg_np_bas(cfg_np_bas),
			       .cfg_pr_bas(cfg_pr_bas),
			       .rx_st_sop(rp_rx_st_sop_mux),
			       .rx_st_eop(rp_rx_st_eop_mux),
			       .rx_st_data(rp_rx_st_data_mux),
			       .rx_st_valid(rp_rx_st_valid_mux),
			       .rx_st_ready(rp_rx_st_ready),
			       .rx_st_empty(rp_rx_st_empty_mux),
			       .rx_st_be(rp_rx_st_be),
			       .rx_st_mask(rp_rx_st_mask),
			       .tx_st_sop(ep_rx_st_sop),
			       .tx_st_eop(ep_rx_st_eop),
			       .tx_st_data(ep_rx_st_data),
			       .tx_st_ready(ep_rx_st_ready_mux),
			       .tx_st_empty(ep_rx_st_empty),
			       .tx_st_valid(ep_rx_st_valid),
			       .tx_fifo_empty(tx_fifo_empty)
			       );

   assign cfg_io_bas = 20'h0;
   assign cfg_np_bas = 12'h0;
   assign cfg_pr_bas = 44'h0;
   assign rp_rx_st_empty = 0;
   
   /*
    * End point:
    * - sonic_application_top
    * - one channel or two channel with arbitration.
    */
   assign ep_rx_st_err = 0;
         
   sonic_application_top ep_top (
				 // AST Rx
				 .rx_st_sop0(ep_rx_st_sop_r),
				 .rx_st_eop0(ep_rx_st_eop_r),
				 .rx_st_data0(ep_rx_st_data_r),
				 .rx_st_valid0(ep_rx_st_valid_r),
				 .rx_st_ready0(ep_rx_st_ready),
				 .rx_st_empty0(ep_rx_st_empty_r),
				 .rx_st_err0(ep_rx_st_err_r),
				 .rx_st_be0(ep_rx_st_be),
				 .rx_st_bardec0(ep_rx_st_bardec),

				 // AST Tx
				 .tx_st_sop0(rp_rx_st_sop),
				 .tx_st_eop0(rp_rx_st_eop),
				 .tx_st_data0(rp_rx_st_data),
			//	 .tx_st_empty(tx_st_empty),
				 .tx_st_valid0(rp_rx_st_valid),
				 .tx_st_ready0(rp_rx_st_ready_mux),

				 // IRQ
				 .pex_msi_num(pex_msi_num),
				 .app_msi_req(app_msi_req),
				 .app_msi_ack(1'b1),  // instant ack
				 .app_msi_tc(app_msi_tc),
				 .app_msi_num(app_msi_num),

				 .app_int_sts(app_int_sts),
				 .app_int_ack(1'b1), // instant ack

				 .rx_stream_mask0(tx_stream_mask),
				 .tx_stream_cred0(36'hFFFFFFFFF),
				 .tx_stream_fifo_empty0(1'b1), //const.

				 // from tl_cfg_sample module
				 .cfg_busdev(cfg_busdev),
				 .cfg_devcsr(cfg_devcsr),
				 .cfg_prmcsr(cfg_prmcsr),
				 .cfg_tcvcmap(cfg_tcvcmap),
				 .cfg_linkcsr(cfg_linkcsr),
				 .cfg_msicsr(cfg_msicsr),

				 .cpl_pending(cpl_pending), 
				 .cpl_err(cpl_err),
				 .err_desc(err_desc),

				 // XCVR, need a random source.
				 .xcvr_rx_clkout(xcvr_rx_clkout),
				 .xcvr_tx_clkout(xcvr_tx_clkout),
				 .xcvr_rx_dataout(xcvr_rx_dataout),
				 .xcvr_tx_datain(xcvr_tx_datain),
				 .pma_tx_ready(pma_tx_ready),
				 .pma_rx_ready(pma_rx_ready),
				 .gen2_speed(),

				 .clk_in(pld_clk), // same as pld_clk, 250 Mhz
				 .rstn(rstn)
				 );

   assign pma_tx_ready = 1'b1;
   assign pma_rx_ready = 1'b1;
   assign cfg_busdev = 12'h21;
   assign cfg_devcsr = 32'h1030;
   assign cfg_prmcsr = 32'h6;
   assign cfg_tcvcmap = 24'h0;
   assign cfg_linkcsr = 32'h10820040;
   assign cfg_msicsr = 32'ha5;

   /*
    * SoNIC Rx/Tx AST monitor
    */

   sonic_monitor sonic_mon (
			    .clk_in_clk(pld_clk),                          //                clk_in.clk
			    .reset_reset_n(rstn),                          //                 reset.reset_n	

			    /* rp_rx */
			    .sonic_tx_monitor_sink_data(rp_rx_st_data),          // sonic_tx_monitor_sink.data
			    .sonic_tx_monitor_sink_valid(rp_rx_st_valid),         //                      .valid
			    .sonic_tx_monitor_sink_ready(rp_rx_st_ready_mon),         //                      .ready
			    .sonic_tx_monitor_sink_startofpacket(rp_rx_st_sop), //                      .startofpacket
			    .sonic_tx_monitor_sink_endofpacket(rp_rx_st_eop),   //                      .endofpacket
			    .sonic_tx_monitor_sink_empty(rp_rx_st_empty),         //                      .empty
			    .sonic_tx_monitor_sink_error(rp_rx_st_err),         //                      .error

			    .sonic_tx_monitor_src_data(rp_rx_st_data_mon),           //  sonic_tx_monitor_src.data
			    .sonic_tx_monitor_src_valid(rp_rx_st_valid_mon),          //                      .valid
			    .sonic_tx_monitor_src_ready(rp_rx_st_ready),          //                      .ready
			    .sonic_tx_monitor_src_startofpacket(rp_rx_st_sop_mon),  //                      .startofpacket
			    .sonic_tx_monitor_src_endofpacket(rp_rx_st_eop_mon),    //                      .endofpacket
			    .sonic_tx_monitor_src_empty(rp_rx_st_empty_mon),          //                      .empty
			    .sonic_tx_monitor_src_error(rp_rx_st_err_mon),          //                      .error
      
			    /* ep_rx */
			    .sonic_rx_monitor_src_data(ep_rx_st_data_mon),           //  sonic_rx_monitor_src.data
			    .sonic_rx_monitor_src_valid(ep_rx_st_valid_mon),          //                      .valid
			    .sonic_rx_monitor_src_ready(ep_rx_st_ready),          //                      .ready
			    .sonic_rx_monitor_src_startofpacket(ep_rx_st_sop_mon),  //                      .startofpacket
			    .sonic_rx_monitor_src_endofpacket(ep_rx_st_eop_mon),    //                      .endofpacket
			    .sonic_rx_monitor_src_empty(ep_rx_st_empty_mon),          //                      .empty
			    .sonic_rx_monitor_src_error(ep_rx_st_err_mon),          //                      .error
      
			    .sonic_rx_monitor_sink_data(ep_rx_st_data),          // sonic_rx_monitor_sink.data
			    .sonic_rx_monitor_sink_valid(ep_rx_st_valid),         //                      .valid
			    .sonic_rx_monitor_sink_ready(ep_rx_st_ready_mon),         //                      .ready
			    .sonic_rx_monitor_sink_startofpacket(ep_rx_st_sop), //                      .startofpacket
			    .sonic_rx_monitor_sink_endofpacket(ep_rx_st_eop),   //                      .endofpacket
			    .sonic_rx_monitor_sink_empty(ep_rx_st_empty),         //                      .empty
			    .sonic_rx_monitor_sink_error(ep_rx_st_err)          //                      .error
			    );
      
endmodule // sonic_fast_sim_top
