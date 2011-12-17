//                              -*- Mode: Verilog -*-
// Filename        : sonic_rp_top.sv
// Description     : root port simulation model, contains rp application and vc_intf_128
// Author          : Han Wang
// Created On      : Sun Dec  4 18:37:03 2011
// Last Modified By: Han Wang
// Last Modified On: Sun Dec  4 18:37:03 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!

/*
 * This is a wrapper over the root port application and bfm_vc_intf_128 module.
 * The root port application implements the testing program, such as dma read and write.
 * The bfm_vc_intf_128 convert packets to Avalon ST transactions, and handles read, write
 * requests and completions. 
 */

module sonic_rp_top (/*AUTOARG*/
   // Outputs
   rx_st_ready, rx_st_mask, tx_st_sop, tx_st_eop, tx_st_empty,
   tx_st_valid, tx_st_data,
   // Inputs
   pld_clk, rstn, cfg_io_bas, cfg_np_bas, cfg_pr_bas, rx_st_sop,
   rx_st_valid, rx_st_eop, rx_st_empty, rx_st_data, rx_st_be,
   tx_st_ready, tx_fifo_empty
   ) ;

   input pld_clk;
   input rstn;
   input [19:0] cfg_io_bas;  // from tl_cfg_sample, we use const.
   input [11:0] cfg_np_bas;
   input [43:0] cfg_pr_bas;
   input 	rx_st_sop;
   input 	rx_st_valid;
   output 	rx_st_ready;
   input 	rx_st_eop;
   input 	rx_st_empty;
   input [127:0] rx_st_data;
   input [15:0]  rx_st_be;
   output 	 rx_st_mask;
   input 	 tx_st_ready;
   output 	 tx_st_sop;
   output 	 tx_st_eop;
   output 	 tx_st_empty;
   output 	 tx_st_valid;
   output [127:0] tx_st_data;
   input 	  tx_fifo_empty;   // const '1'
   
   /*
    * Drivers and Monitors
    */
   wire 	   bfm_log_common_dummy_out;
   wire 	   driver_rp_dummy_out;
   wire 	   bfm_req_intf_common_dummy_out;
   wire 	   bfm_shmem_common_dummy_out;
   wire 	   ltssm_dummy_out;
   wire [127:0]    tx_st_data_int;
  
   altpcietb_bfm_log_common bfm_log_common ( .dummy_out (bfm_log_common_dummy_out));
   altpcietb_bfm_req_intf_common bfm_req_intf_common ( .dummy_out (bfm_req_intf_common_dummy_out));
   altpcietb_bfm_shmem_common bfm_shmem_common ( .dummy_out (bfm_shmem_common_dummy_out));

   // delay reset for RP
   reg 		   srstn_r, srstn_rr;
   initial begin
      srstn_r  = 1'b0;
      srstn_rr = 1'b0;
   end
   
   always @(posedge pld_clk or negedge rstn) begin
      if (rstn == 1'b0) begin
         srstn_r <= 0;
         srstn_rr <= 0;
      end
      else begin
         srstn_r <= 1;
         srstn_rr <= srstn_r;
      end
   end
   
   // Use chaining DMA driver in Root Port application
   altpcietb_bfm_driver_chaining # (
				    .TEST_LEVEL(1),
				    .USE_CDMA  (1),
				    .USE_TARGET (0)
				    ) drvr (
					    .INTA (1),
					    .INTB (0),
					    .INTC (0),
					    .INTD (0),
					    .clk_in (pld_clk), //FIX: confirm.
					    .dummy_out (driver_rp_dummy_out),
					    .rstn (rstn));

/*
   altpcietb_bfm_driver_rp # (
				    .TEST_LEVEL(1)
				    ) drvr (
					    .INTA (1),
					    .INTB (0),
					    .INTC (0),
					    .INTD (0),
					    .clk_in (pld_clk), //FIX: confirm.
					    .dummy_out (driver_rp_dummy_out),
					    .rstn (rstn));
*/
   // Convert BFM to AST
   altpcietb_bfm_vc_intf_ast  # (
				 .AVALON_ST_128       (1),
				 .ECRC_FORWARD_CHECK  (0),
				 .ECRC_FORWARD_GENER  (0),
				 .VC_NUM              (0)
				 ) app_vc0 (
					    // input from tl_cfg_sample
					    .cfg_io_bas    (cfg_io_bas),
					    .cfg_np_bas    (cfg_np_bas),
					    .cfg_pr_bas    (cfg_pr_bas),
					    .clk_in        (pld_clk),
					    .rstn          (srstn_rr),
					    .rx_mask       (rx_st_mask),
					    .rx_st_be      (rx_st_be),
					    .rx_st_data    (rx_st_data),
					    .rx_st_empty   (rx_st_empty),
					    .rx_st_eop     (rx_st_eop),
					    .rx_st_ready   (rx_st_ready),
					    .rx_st_sop     (rx_st_sop),
					    .rx_st_valid   (rx_st_valid),
					    .tx_cred       (36'hFFFFFFFFF),
					    .tx_fifo_empty (1'b1),
					    .tx_st_data    (tx_st_data),
					    .tx_st_empty   (tx_st_empty),
					    .tx_st_eop     (tx_st_eop),
					    .tx_st_ready   (tx_st_ready),
					    .tx_st_sop     (tx_st_sop),
					    .tx_st_valid   (tx_st_valid)
					    );
   assign tx_st_err = 1'b0;   
      
endmodule // sonic_root_port_top

