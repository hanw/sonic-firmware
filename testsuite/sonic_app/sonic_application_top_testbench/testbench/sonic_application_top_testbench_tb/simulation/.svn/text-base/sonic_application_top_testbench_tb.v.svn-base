// sonic_application_top_testbench_tb.v


`timescale 1 ps / 1 ps
module sonic_application_top_testbench_tb (
	);

	wire          sonic_application_top_testbench_inst_xcvr_rx_clkout_bfm_clk_clk;          // sonic_application_top_testbench_inst_xcvr_rx_clkout_bfm:clk -> [sonic_application_top_testbench_inst:xcvr_rx_clkout_clk, sonic_application_top_testbench_inst_reset_bfm:clk]
	wire          sonic_application_top_testbench_inst_xcvr_tx_clkout_bfm_clk_clk;          // sonic_application_top_testbench_inst_xcvr_tx_clkout_bfm:clk -> sonic_application_top_testbench_inst:xcvr_tx_clkout_clk
	wire          sonic_application_top_testbench_inst_clk_bfm_clk_clk;                     // sonic_application_top_testbench_inst_clk_bfm:clk -> [rst_controller:clk, sonic_application_top_testbench_inst:clk_clk, sonic_application_top_testbench_inst_rx_st_bfm:clk, sonic_application_top_testbench_inst_tx_st_bfm:clk]
	wire          sonic_application_top_testbench_inst_reset_bfm_reset_reset;               // sonic_application_top_testbench_inst_reset_bfm:reset -> [rst_controller:reset_in0, sonic_application_top_testbench_inst:reset_reset_n]
	wire          sonic_application_top_testbench_inst_legacy_irq_bfm_conduit_ack;          // sonic_application_top_testbench_inst_legacy_irq_bfm:sig_ack -> sonic_application_top_testbench_inst:legacy_irq_ack
	wire          sonic_application_top_testbench_inst_legacy_irq_sts;                      // sonic_application_top_testbench_inst:legacy_irq_sts -> sonic_application_top_testbench_inst_legacy_irq_bfm:sig_sts
	wire    [4:0] sonic_application_top_testbench_inst_msi_irq_num;                         // sonic_application_top_testbench_inst:msi_irq_num -> sonic_application_top_testbench_inst_msi_irq_bfm:sig_num
	wire    [2:0] sonic_application_top_testbench_inst_msi_irq_tc;                          // sonic_application_top_testbench_inst:msi_irq_tc -> sonic_application_top_testbench_inst_msi_irq_bfm:sig_tc
	wire          sonic_application_top_testbench_inst_msi_irq_bfm_conduit_ack;             // sonic_application_top_testbench_inst_msi_irq_bfm:sig_ack -> sonic_application_top_testbench_inst:msi_irq_ack
	wire          sonic_application_top_testbench_inst_msi_irq_req;                         // sonic_application_top_testbench_inst:msi_irq_req -> sonic_application_top_testbench_inst_msi_irq_bfm:sig_req
	wire  [127:0] sonic_application_top_testbench_inst_err_desc_export;                     // sonic_application_top_testbench_inst:err_desc_export -> sonic_application_top_testbench_inst_err_desc_bfm:sig_export
	wire    [4:0] sonic_application_top_testbench_inst_pex_msi_num_export;                  // sonic_application_top_testbench_inst:pex_msi_num_export -> sonic_application_top_testbench_inst_pex_msi_num_bfm:sig_export
	wire          sonic_application_top_testbench_inst_rx_st_bfm_src_endofpacket;           // sonic_application_top_testbench_inst_rx_st_bfm:src_endofpacket -> sonic_application_top_testbench_inst:rx_st_endofpacket
	wire          sonic_application_top_testbench_inst_rx_st_bfm_src_valid;                 // sonic_application_top_testbench_inst_rx_st_bfm:src_valid -> sonic_application_top_testbench_inst:rx_st_valid
	wire          sonic_application_top_testbench_inst_rx_st_bfm_src_startofpacket;         // sonic_application_top_testbench_inst_rx_st_bfm:src_startofpacket -> sonic_application_top_testbench_inst:rx_st_startofpacket
	wire          sonic_application_top_testbench_inst_rx_st_bfm_src_error;                 // sonic_application_top_testbench_inst_rx_st_bfm:src_error -> sonic_application_top_testbench_inst:rx_st_error
	wire          sonic_application_top_testbench_inst_rx_st_bfm_src_empty;                 // sonic_application_top_testbench_inst_rx_st_bfm:src_empty -> sonic_application_top_testbench_inst:rx_st_empty
	wire  [127:0] sonic_application_top_testbench_inst_rx_st_bfm_src_data;                  // sonic_application_top_testbench_inst_rx_st_bfm:src_data -> sonic_application_top_testbench_inst:rx_st_data
	wire          sonic_application_top_testbench_inst_rx_st_bfm_src_ready;                 // sonic_application_top_testbench_inst:rx_st_ready -> sonic_application_top_testbench_inst_rx_st_bfm:src_ready
	wire          sonic_application_top_testbench_inst_tx_st_endofpacket;                   // sonic_application_top_testbench_inst:tx_st_endofpacket -> sonic_application_top_testbench_inst_tx_st_bfm:sink_endofpacket
	wire          sonic_application_top_testbench_inst_tx_st_valid;                         // sonic_application_top_testbench_inst:tx_st_valid -> sonic_application_top_testbench_inst_tx_st_bfm:sink_valid
	wire          sonic_application_top_testbench_inst_tx_st_startofpacket;                 // sonic_application_top_testbench_inst:tx_st_startofpacket -> sonic_application_top_testbench_inst_tx_st_bfm:sink_startofpacket
	wire          sonic_application_top_testbench_inst_tx_st_error;                         // sonic_application_top_testbench_inst:tx_st_error -> sonic_application_top_testbench_inst_tx_st_bfm:sink_error
	wire          sonic_application_top_testbench_inst_tx_st_empty;                         // sonic_application_top_testbench_inst:tx_st_empty -> sonic_application_top_testbench_inst_tx_st_bfm:sink_empty
	wire  [127:0] sonic_application_top_testbench_inst_tx_st_data;                          // sonic_application_top_testbench_inst:tx_st_data -> sonic_application_top_testbench_inst_tx_st_bfm:sink_data
	wire          sonic_application_top_testbench_inst_tx_st_ready;                         // sonic_application_top_testbench_inst_tx_st_bfm:sink_ready -> sonic_application_top_testbench_inst:tx_st_ready
	wire    [7:0] sonic_application_top_testbench_inst_rx_st_misc_bfm_conduit_st_bardec0;   // sonic_application_top_testbench_inst_rx_st_misc_bfm:sig_st_bardec0 -> sonic_application_top_testbench_inst:rx_st_misc_st_bardec0
	wire          sonic_application_top_testbench_inst_rx_st_misc_stream_mask0;             // sonic_application_top_testbench_inst:rx_st_misc_stream_mask0 -> sonic_application_top_testbench_inst_rx_st_misc_bfm:sig_stream_mask0
	wire   [15:0] sonic_application_top_testbench_inst_rx_st_misc_bfm_conduit_st_be0;       // sonic_application_top_testbench_inst_rx_st_misc_bfm:sig_st_be0 -> sonic_application_top_testbench_inst:rx_st_misc_st_be0
	wire    [6:0] sonic_application_top_testbench_inst_cpl_err_export;                      // sonic_application_top_testbench_inst:cpl_err_export -> sonic_application_top_testbench_inst_cpl_err_bfm:sig_export
	wire          sonic_application_top_testbench_inst_cpl_pending_export;                  // sonic_application_top_testbench_inst:cpl_pending_export -> sonic_application_top_testbench_inst_cpl_pending_bfm:sig_export
	wire   [31:0] sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_devcsr;           // sonic_application_top_testbench_inst_tl_cfg_bfm:sig_devcsr -> sonic_application_top_testbench_inst:tl_cfg_devcsr
	wire   [12:0] sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_busdev;           // sonic_application_top_testbench_inst_tl_cfg_bfm:sig_busdev -> sonic_application_top_testbench_inst:tl_cfg_busdev
	wire   [31:0] sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_prmcsr;           // sonic_application_top_testbench_inst_tl_cfg_bfm:sig_prmcsr -> sonic_application_top_testbench_inst:tl_cfg_prmcsr
	wire   [23:0] sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_tcvcmap;          // sonic_application_top_testbench_inst_tl_cfg_bfm:sig_tcvcmap -> sonic_application_top_testbench_inst:tl_cfg_tcvcmap
	wire   [15:0] sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_msicsr;           // sonic_application_top_testbench_inst_tl_cfg_bfm:sig_msicsr -> sonic_application_top_testbench_inst:tl_cfg_msicsr
	wire   [35:0] sonic_application_top_testbench_inst_tx_st_cred_bfm_conduit_export;       // sonic_application_top_testbench_inst_tx_st_cred_bfm:sig_export -> sonic_application_top_testbench_inst:tx_st_cred_export
	wire          sonic_application_top_testbench_inst_tx_st_fifo_empty_bfm_conduit_export; // sonic_application_top_testbench_inst_tx_st_fifo_empty_bfm:sig_export -> sonic_application_top_testbench_inst:tx_st_fifo_empty_export
	wire   [31:0] sonic_application_top_testbench_inst_cfg_linkcsr_bfm_conduit_export;      // sonic_application_top_testbench_inst_cfg_linkcsr_bfm:sig_export -> sonic_application_top_testbench_inst:cfg_linkcsr_export
	wire          sonic_application_top_testbench_inst_gen2_speed_export;                   // sonic_application_top_testbench_inst:gen2_speed_export -> sonic_application_top_testbench_inst_gen2_speed_bfm:sig_export
	wire          sonic_application_top_testbench_inst_pma_tx_ready_bfm_conduit_export;     // sonic_application_top_testbench_inst_pma_tx_ready_bfm:sig_export -> sonic_application_top_testbench_inst:pma_tx_ready_export
	wire          sonic_application_top_testbench_inst_pma_rx_ready_bfm_conduit_export;     // sonic_application_top_testbench_inst_pma_rx_ready_bfm:sig_export -> sonic_application_top_testbench_inst:pma_rx_ready_export
	wire          rst_controller_reset_out_reset;                                           // rst_controller:reset_out -> [sonic_application_top_testbench_inst_rx_st_bfm:reset, sonic_application_top_testbench_inst_tx_st_bfm:reset]

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst sonic_application_top_testbench_inst (
		.legacy_irq_sts          (sonic_application_top_testbench_inst_legacy_irq_sts),                      //       legacy_irq.sts
		.legacy_irq_ack          (sonic_application_top_testbench_inst_legacy_irq_bfm_conduit_ack),          //                 .ack
		.msi_irq_req             (sonic_application_top_testbench_inst_msi_irq_req),                         //          msi_irq.req
		.msi_irq_ack             (sonic_application_top_testbench_inst_msi_irq_bfm_conduit_ack),             //                 .ack
		.msi_irq_tc              (sonic_application_top_testbench_inst_msi_irq_tc),                          //                 .tc
		.msi_irq_num             (sonic_application_top_testbench_inst_msi_irq_num),                         //                 .num
		.err_desc_export         (sonic_application_top_testbench_inst_err_desc_export),                     //         err_desc.export
		.pex_msi_num_export      (sonic_application_top_testbench_inst_pex_msi_num_export),                  //      pex_msi_num.export
		.rx_st_data              (sonic_application_top_testbench_inst_rx_st_bfm_src_data),                  //            rx_st.data
		.rx_st_empty             (sonic_application_top_testbench_inst_rx_st_bfm_src_empty),                 //                 .empty
		.rx_st_endofpacket       (sonic_application_top_testbench_inst_rx_st_bfm_src_endofpacket),           //                 .endofpacket
		.rx_st_error             (sonic_application_top_testbench_inst_rx_st_bfm_src_error),                 //                 .error
		.rx_st_startofpacket     (sonic_application_top_testbench_inst_rx_st_bfm_src_startofpacket),         //                 .startofpacket
		.rx_st_valid             (sonic_application_top_testbench_inst_rx_st_bfm_src_valid),                 //                 .valid
		.rx_st_ready             (sonic_application_top_testbench_inst_rx_st_bfm_src_ready),                 //                 .ready
		.tx_st_data              (sonic_application_top_testbench_inst_tx_st_data),                          //            tx_st.data
		.tx_st_empty             (sonic_application_top_testbench_inst_tx_st_empty),                         //                 .empty
		.tx_st_endofpacket       (sonic_application_top_testbench_inst_tx_st_endofpacket),                   //                 .endofpacket
		.tx_st_error             (sonic_application_top_testbench_inst_tx_st_error),                         //                 .error
		.tx_st_ready             (sonic_application_top_testbench_inst_tx_st_ready),                         //                 .ready
		.tx_st_startofpacket     (sonic_application_top_testbench_inst_tx_st_startofpacket),                 //                 .startofpacket
		.tx_st_valid             (sonic_application_top_testbench_inst_tx_st_valid),                         //                 .valid
		.rx_st_misc_st_be0       (sonic_application_top_testbench_inst_rx_st_misc_bfm_conduit_st_be0),       //       rx_st_misc.st_be0
		.rx_st_misc_stream_mask0 (sonic_application_top_testbench_inst_rx_st_misc_stream_mask0),             //                 .stream_mask0
		.rx_st_misc_st_bardec0   (sonic_application_top_testbench_inst_rx_st_misc_bfm_conduit_st_bardec0),   //                 .st_bardec0
		.cpl_err_export          (sonic_application_top_testbench_inst_cpl_err_export),                      //          cpl_err.export
		.cpl_pending_export      (sonic_application_top_testbench_inst_cpl_pending_export),                  //      cpl_pending.export
		.tl_cfg_prmcsr           (sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_prmcsr),           //           tl_cfg.prmcsr
		.tl_cfg_devcsr           (sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_devcsr),           //                 .devcsr
		.tl_cfg_busdev           (sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_busdev),           //                 .busdev
		.tl_cfg_tcvcmap          (sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_tcvcmap),          //                 .tcvcmap
		.tl_cfg_msicsr           (sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_msicsr),           //                 .msicsr
		.tx_st_cred_export       (sonic_application_top_testbench_inst_tx_st_cred_bfm_conduit_export),       //       tx_st_cred.export
		.tx_st_fifo_empty_export (sonic_application_top_testbench_inst_tx_st_fifo_empty_bfm_conduit_export), // tx_st_fifo_empty.export
		.xcvr_rx_clkout_clk      (sonic_application_top_testbench_inst_xcvr_rx_clkout_bfm_clk_clk),          //   xcvr_rx_clkout.clk
		.xcvr_tx_clkout_clk      (sonic_application_top_testbench_inst_xcvr_tx_clkout_bfm_clk_clk),          //   xcvr_tx_clkout.clk
		.cfg_linkcsr_export      (sonic_application_top_testbench_inst_cfg_linkcsr_bfm_conduit_export),      //      cfg_linkcsr.export
		.gen2_speed_export       (sonic_application_top_testbench_inst_gen2_speed_export),                   //       gen2_speed.export
		.clk_clk                 (sonic_application_top_testbench_inst_clk_bfm_clk_clk),                     //              clk.clk
		.reset_reset_n           (sonic_application_top_testbench_inst_reset_bfm_reset_reset),               //            reset.reset_n
		.pma_tx_ready_export     (sonic_application_top_testbench_inst_pma_tx_ready_bfm_conduit_export),     //     pma_tx_ready.export
		.pma_rx_ready_export     (sonic_application_top_testbench_inst_pma_rx_ready_bfm_conduit_export)      //     pma_rx_ready.export
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (257)
	) sonic_application_top_testbench_inst_xcvr_rx_clkout_bfm (
		.clk (sonic_application_top_testbench_inst_xcvr_rx_clkout_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (257)
	) sonic_application_top_testbench_inst_xcvr_tx_clkout_bfm (
		.clk (sonic_application_top_testbench_inst_xcvr_tx_clkout_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (250)
	) sonic_application_top_testbench_inst_clk_bfm (
		.clk (sonic_application_top_testbench_inst_clk_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) sonic_application_top_testbench_inst_reset_bfm (
		.reset (sonic_application_top_testbench_inst_reset_bfm_reset_reset),      // reset.reset_n
		.clk   (sonic_application_top_testbench_inst_xcvr_rx_clkout_bfm_clk_clk)  //   clk.clk
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_legacy_irq_bfm sonic_application_top_testbench_inst_legacy_irq_bfm (
		.sig_sts (sonic_application_top_testbench_inst_legacy_irq_sts),             // conduit.sts
		.sig_ack (sonic_application_top_testbench_inst_legacy_irq_bfm_conduit_ack)  //        .ack
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_msi_irq_bfm sonic_application_top_testbench_inst_msi_irq_bfm (
		.sig_num (sonic_application_top_testbench_inst_msi_irq_num),             // conduit.num
		.sig_ack (sonic_application_top_testbench_inst_msi_irq_bfm_conduit_ack), //        .ack
		.sig_req (sonic_application_top_testbench_inst_msi_irq_req),             //        .req
		.sig_tc  (sonic_application_top_testbench_inst_msi_irq_tc)               //        .tc
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_err_desc_bfm sonic_application_top_testbench_inst_err_desc_bfm (
		.sig_export (sonic_application_top_testbench_inst_err_desc_export)  // conduit.export
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_pex_msi_num_bfm sonic_application_top_testbench_inst_pex_msi_num_bfm (
		.sig_export (sonic_application_top_testbench_inst_pex_msi_num_export)  // conduit.export
	);

	altera_avalon_st_source_bfm_custom #(
		.USE_PACKET       (1),
		.USE_CHANNEL      (0),
		.USE_ERROR        (1),
		.USE_READY        (1),
		.USE_VALID        (1),
		.USE_EMPTY        (1),
		.ST_SYMBOL_W      (128),
		.ST_NUMSYMBOLS    (1),
		.ST_CHANNEL_W     (1),
		.ST_ERROR_W       (1),
		.ST_EMPTY_W       (1),
		.ST_READY_LATENCY (0),
		.ST_BEATSPERCYCLE (1),
		.ST_MAX_CHANNELS  (0)
	) sonic_application_top_testbench_inst_rx_st_bfm (
		.clk               (sonic_application_top_testbench_inst_clk_bfm_clk_clk),             //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                   // clk_reset.reset
		.src_data          (sonic_application_top_testbench_inst_rx_st_bfm_src_data),          //       src.data
		.src_valid         (sonic_application_top_testbench_inst_rx_st_bfm_src_valid),         //          .valid
		.src_ready         (sonic_application_top_testbench_inst_rx_st_bfm_src_ready),         //          .ready
		.src_startofpacket (sonic_application_top_testbench_inst_rx_st_bfm_src_startofpacket), //          .startofpacket
		.src_endofpacket   (sonic_application_top_testbench_inst_rx_st_bfm_src_endofpacket),   //          .endofpacket
		.src_empty         (sonic_application_top_testbench_inst_rx_st_bfm_src_empty),         //          .empty
		.src_error         (sonic_application_top_testbench_inst_rx_st_bfm_src_error),         //          .error
        .src_be0       (sonic_application_top_testbench_inst_rx_st_misc_bfm_conduit_st_be0),
        .src_bardec0       (sonic_application_top_testbench_inst_rx_st_misc_bfm_conduit_st_bardec0),
		.src_channel       ()                                                                  // (terminated)
	);

	altera_avalon_st_sink_bfm #(
		.USE_PACKET       (1),
		.USE_CHANNEL      (0),
		.USE_ERROR        (1),
		.USE_READY        (1),
		.USE_VALID        (1),
		.USE_EMPTY        (1),
		.ST_SYMBOL_W      (128),
		.ST_NUMSYMBOLS    (1),
		.ST_CHANNEL_W     (1),
		.ST_ERROR_W       (1),
		.ST_EMPTY_W       (1),
		.ST_READY_LATENCY (0),
		.ST_BEATSPERCYCLE (1),
		.ST_MAX_CHANNELS  (0)
	) sonic_application_top_testbench_inst_tx_st_bfm (
		.clk                (sonic_application_top_testbench_inst_clk_bfm_clk_clk),     //       clk.clk
		.reset              (rst_controller_reset_out_reset),                           // clk_reset.reset
		.sink_data          (sonic_application_top_testbench_inst_tx_st_data),          //      sink.data
		.sink_valid         (sonic_application_top_testbench_inst_tx_st_valid),         //          .valid
		.sink_ready         (sonic_application_top_testbench_inst_tx_st_ready),         //          .ready
		.sink_startofpacket (sonic_application_top_testbench_inst_tx_st_startofpacket), //          .startofpacket
		.sink_endofpacket   (sonic_application_top_testbench_inst_tx_st_endofpacket),   //          .endofpacket
		.sink_empty         (sonic_application_top_testbench_inst_tx_st_empty),         //          .empty
		.sink_error         (sonic_application_top_testbench_inst_tx_st_error),         //          .error
		.sink_channel       (1'b0)                                                      // (terminated)
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_rx_st_misc_bfm sonic_application_top_testbench_inst_rx_st_misc_bfm (
		.sig_stream_mask0 (sonic_application_top_testbench_inst_rx_st_misc_stream_mask0),           // conduit.stream_mask0
		.sig_st_be0       (),     //        .st_be0
		.sig_st_bardec0   ()  //        .st_bardec0
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_cpl_err_bfm sonic_application_top_testbench_inst_cpl_err_bfm (
		.sig_export (sonic_application_top_testbench_inst_cpl_err_export)  // conduit.export
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_cpl_pending_bfm sonic_application_top_testbench_inst_cpl_pending_bfm (
		.sig_export (sonic_application_top_testbench_inst_cpl_pending_export)  // conduit.export
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_tl_cfg_bfm sonic_application_top_testbench_inst_tl_cfg_bfm (
		.sig_msicsr  (sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_msicsr),  // conduit.msicsr
		.sig_prmcsr  (sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_prmcsr),  //        .prmcsr
		.sig_devcsr  (sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_devcsr),  //        .devcsr
		.sig_busdev  (sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_busdev),  //        .busdev
		.sig_tcvcmap (sonic_application_top_testbench_inst_tl_cfg_bfm_conduit_tcvcmap)  //        .tcvcmap
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_tx_st_cred_bfm sonic_application_top_testbench_inst_tx_st_cred_bfm (
		.sig_export (sonic_application_top_testbench_inst_tx_st_cred_bfm_conduit_export)  // conduit.export
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_tx_st_fifo_empty_bfm sonic_application_top_testbench_inst_tx_st_fifo_empty_bfm (
		.sig_export (sonic_application_top_testbench_inst_tx_st_fifo_empty_bfm_conduit_export)  // conduit.export
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_cfg_linkcsr_bfm sonic_application_top_testbench_inst_cfg_linkcsr_bfm (
		.sig_export (sonic_application_top_testbench_inst_cfg_linkcsr_bfm_conduit_export)  // conduit.export
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_cpl_pending_bfm sonic_application_top_testbench_inst_gen2_speed_bfm (
		.sig_export (sonic_application_top_testbench_inst_gen2_speed_export)  // conduit.export
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_tx_st_fifo_empty_bfm sonic_application_top_testbench_inst_pma_tx_ready_bfm (
		.sig_export (sonic_application_top_testbench_inst_pma_tx_ready_bfm_conduit_export)  // conduit.export
	);

	sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_tx_st_fifo_empty_bfm sonic_application_top_testbench_inst_pma_rx_ready_bfm (
		.sig_export (sonic_application_top_testbench_inst_pma_rx_ready_bfm_conduit_export)  // conduit.export
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~sonic_application_top_testbench_inst_reset_bfm_reset_reset), // reset_in0.reset
		.clk        (sonic_application_top_testbench_inst_clk_bfm_clk_clk),        //       clk.clk
		.reset_out  (rst_controller_reset_out_reset),                              // reset_out.reset
		.reset_in1  (1'b0),                                                        // (terminated)
		.reset_in2  (1'b0),                                                        // (terminated)
		.reset_in3  (1'b0),                                                        // (terminated)
		.reset_in4  (1'b0),                                                        // (terminated)
		.reset_in5  (1'b0),                                                        // (terminated)
		.reset_in6  (1'b0),                                                        // (terminated)
		.reset_in7  (1'b0),                                                        // (terminated)
		.reset_in8  (1'b0),                                                        // (terminated)
		.reset_in9  (1'b0),                                                        // (terminated)
		.reset_in10 (1'b0),                                                        // (terminated)
		.reset_in11 (1'b0),                                                        // (terminated)
		.reset_in12 (1'b0),                                                        // (terminated)
		.reset_in13 (1'b0),                                                        // (terminated)
		.reset_in14 (1'b0),                                                        // (terminated)
		.reset_in15 (1'b0)                                                         // (terminated)
	);

endmodule
