// sonic_application_top_testbench_tb_sonic_application_top_testbench_inst.v


`timescale 1 ps / 1 ps
module sonic_application_top_testbench_tb_sonic_application_top_testbench_inst (
		output wire         cpl_pending_export,      //      cpl_pending.export
		input  wire [35:0]  tx_st_cred_export,       //       tx_st_cred.export
		input  wire         pma_tx_ready_export,     //     pma_tx_ready.export
		output wire [127:0] tx_st_data,              //            tx_st.data
		output wire         tx_st_empty,             //                 .empty
		output wire         tx_st_endofpacket,       //                 .endofpacket
		output wire         tx_st_error,             //                 .error
		input  wire         tx_st_ready,             //                 .ready
		output wire         tx_st_startofpacket,     //                 .startofpacket
		output wire         tx_st_valid,             //                 .valid
		input  wire         tx_st_fifo_empty_export, // tx_st_fifo_empty.export
		input  wire [31:0]  cfg_linkcsr_export,      //      cfg_linkcsr.export
		input  wire [15:0]  rx_st_misc_st_be0,       //       rx_st_misc.st_be0
		input  wire [7:0]   rx_st_misc_st_bardec0,   //                 .st_bardec0
		output wire         rx_st_misc_stream_mask0, //                 .stream_mask0
		input  wire         xcvr_rx_clkout_clk,      //   xcvr_rx_clkout.clk
		input  wire         clk_clk,                 //              clk.clk
		output wire         gen2_speed_export,       //       gen2_speed.export
		input  wire [127:0] rx_st_data,              //            rx_st.data
		input  wire         rx_st_empty,             //                 .empty
		input  wire         rx_st_endofpacket,       //                 .endofpacket
		input  wire         rx_st_error,             //                 .error
		input  wire         rx_st_startofpacket,     //                 .startofpacket
		input  wire         rx_st_valid,             //                 .valid
		output wire         rx_st_ready,             //                 .ready
		input  wire         legacy_irq_ack,          //       legacy_irq.ack
		output wire         legacy_irq_sts,          //                 .sts
		input  wire [31:0]  tl_cfg_prmcsr,           //           tl_cfg.prmcsr
		input  wire [31:0]  tl_cfg_devcsr,           //                 .devcsr
		input  wire [23:0]  tl_cfg_tcvcmap,          //                 .tcvcmap
		input  wire [15:0]  tl_cfg_msicsr,           //                 .msicsr
		input  wire [12:0]  tl_cfg_busdev,           //                 .busdev
		input  wire         msi_irq_ack,             //          msi_irq.ack
		output wire [4:0]   msi_irq_num,             //                 .num
		output wire         msi_irq_req,             //                 .req
		output wire [2:0]   msi_irq_tc,              //                 .tc
		input  wire         pma_rx_ready_export,     //     pma_rx_ready.export
		input  wire         reset_reset_n,           //            reset.reset_n
		output wire [4:0]   pex_msi_num_export,      //      pex_msi_num.export
		output wire [127:0] err_desc_export,         //         err_desc.export
		output wire [6:0]   cpl_err_export,          //          cpl_err.export
		input  wire         xcvr_tx_clkout_clk       //   xcvr_tx_clkout.clk
	);

	wire  [39:0] sonic_application_top_0_xcvr_tx_datain_export; // sonic_application_top_0:xcvr_tx_datain -> sonic_application_top_0:xcvr_rx_dataout
	wire         rst_controller_reset_out_reset;                // rst_controller:reset_out -> sonic_application_top_0:rstn

	sonic_application_top sonic_application_top_0 (
		.clk_in                (clk_clk),                                       //                      clk.clk
		.app_int_ack           (legacy_irq_ack),                                //               legacy_irq.export
		.app_int_sts           (legacy_irq_sts),                                //                         .export
		.app_msi_ack           (msi_irq_ack),                                   //                  msi_irq.export
		.app_msi_num           (msi_irq_num),                                   //                         .export
		.app_msi_req           (msi_irq_req),                                   //                         .export
		.app_msi_tc            (msi_irq_tc),                                    //                         .export
		.err_desc              (err_desc_export),                               //                 err_desc.export
		.pex_msi_num           (pex_msi_num_export),                            //              pex_msi_num.export
		.rx_st_data0           (rx_st_data),                                    //                    rx_st.data
		.rx_st_empty0          (rx_st_empty),                                   //                         .empty
		.rx_st_eop0            (rx_st_endofpacket),                             //                         .endofpacket
		.rx_st_err0            (rx_st_error),                                   //                         .error
		.rx_st_sop0            (rx_st_startofpacket),                           //                         .startofpacket
		.rx_st_valid0          (rx_st_valid),                                   //                         .valid
		.rx_st_ready0          (rx_st_ready),                                   //                         .ready
		.tx_st_data0           (tx_st_data),                                    //                    tx_st.data
		.tx_st_empty0          (tx_st_empty),                                   //                         .empty
		.tx_st_eop0            (tx_st_endofpacket),                             //                         .endofpacket
		.tx_st_err0            (tx_st_error),                                   //                         .error
		.tx_st_ready0          (tx_st_ready),                                   //                         .ready
		.tx_st_sop0            (tx_st_startofpacket),                           //                         .startofpacket
		.tx_st_valid0          (tx_st_valid),                                   //                         .valid
		.rx_st_bardec0         (rx_st_misc_st_bardec0),                         // rx_st_component_specific.export
		.rx_st_be0             (rx_st_misc_st_be0),                             //                         .export
		.rx_stream_mask0       (rx_st_misc_stream_mask0),                       //                         .export
		.cpl_err               (cpl_err_export),                                //                  cpl_err.export
		.cpl_pending           (cpl_pending_export),                            //              cpl_pending.export
		.cfg_busdev            (tl_cfg_busdev),                                 //     tl_cfg_app_interface.export
		.cfg_devcsr            (tl_cfg_devcsr),                                 //                         .export
		.cfg_msicsr            (tl_cfg_msicsr),                                 //                         .export
		.cfg_prmcsr            (tl_cfg_prmcsr),                                 //                         .export
		.cfg_tcvcmap           (tl_cfg_tcvcmap),                                //                         .export
		.tx_stream_cred0       (tx_st_cred_export),                             //          tx_stream_cred0.export
		.tx_stream_fifo_empty0 (tx_st_fifo_empty_export),                       //     tx_stream_fifo_empty.export
		.xcvr_rx_clkout        (xcvr_rx_clkout_clk),                            //           xcvr_rx_clkout.clk
		.xcvr_tx_clkout        (xcvr_tx_clkout_clk),                            //           xcvr_tx_clkout.clk
		.cfg_linkcsr           (cfg_linkcsr_export),                            //              cfg_linkcsr.export
		.gen2_speed            (gen2_speed_export),                             //               gen2_speed.export
		.xcvr_rx_dataout       (sonic_application_top_0_xcvr_tx_datain_export), //          xcvr_rx_dataout.export
		.xcvr_tx_datain        (sonic_application_top_0_xcvr_tx_datain_export), //           xcvr_tx_datain.export
		.rstn                  (~rst_controller_reset_out_reset),               //                  reset_n.reset_n
		.pma_tx_ready          (pma_tx_ready_export),                           //             pma_tx_ready.export
		.pma_rx_ready          (pma_rx_ready_export)                            //             pma_rx_ready.export
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~reset_reset_n),                 // reset_in0.reset
		.clk        (clk_clk),                        //       clk.clk
		.reset_out  (rst_controller_reset_out_reset), // reset_out.reset
		.reset_in1  (1'b0),                           // (terminated)
		.reset_in2  (1'b0),                           // (terminated)
		.reset_in3  (1'b0),                           // (terminated)
		.reset_in4  (1'b0),                           // (terminated)
		.reset_in5  (1'b0),                           // (terminated)
		.reset_in6  (1'b0),                           // (terminated)
		.reset_in7  (1'b0),                           // (terminated)
		.reset_in8  (1'b0),                           // (terminated)
		.reset_in9  (1'b0),                           // (terminated)
		.reset_in10 (1'b0),                           // (terminated)
		.reset_in11 (1'b0),                           // (terminated)
		.reset_in12 (1'b0),                           // (terminated)
		.reset_in13 (1'b0),                           // (terminated)
		.reset_in14 (1'b0),                           // (terminated)
		.reset_in15 (1'b0)                            // (terminated)
	);

endmodule
