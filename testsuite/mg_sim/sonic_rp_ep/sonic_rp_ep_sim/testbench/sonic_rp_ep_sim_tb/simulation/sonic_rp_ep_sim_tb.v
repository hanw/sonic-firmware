// sonic_rp_ep_sim_tb.v


`timescale 1 ps / 1 ps
module sonic_rp_ep_sim_tb (
	);

	wire         sonic_rp_ep_sim_inst_clk_bfm_clk_clk;              // sonic_rp_ep_sim_inst_clk_bfm:clk -> [sonic_rp_ep_sim_inst:clk_clk, sonic_rp_ep_sim_inst_reset_0_bfm:clk, sonic_rp_ep_sim_inst_reset_bfm:clk]
	wire         sonic_rp_ep_sim_inst_clk_0_bfm_clk_clk;            // sonic_rp_ep_sim_inst_clk_0_bfm:clk -> [rst_controller:clk, sonic_rp_ep_sim_inst:clk_0_clk, sonic_rp_ep_sim_inst_xcvr_rx_dataout_bfm:clk, sonic_rp_ep_sim_inst_xcvr_tx_datain_bfm:clk]
	wire         sonic_rp_ep_sim_inst_reset_bfm_reset_reset;        // sonic_rp_ep_sim_inst_reset_bfm:reset -> [rst_controller:reset_in0, sonic_rp_ep_sim_inst:reset_reset_n]
	wire         sonic_rp_ep_sim_inst_reset_0_bfm_reset_reset;      // sonic_rp_ep_sim_inst_reset_0_bfm:reset -> sonic_rp_ep_sim_inst:reset_0_reset_n
	wire  [39:0] sonic_rp_ep_sim_inst_xcvr_tx_datain_data;          // sonic_rp_ep_sim_inst:xcvr_tx_datain_data -> sonic_rp_ep_sim_inst_xcvr_tx_datain_bfm:sink_data
	wire  [39:0] sonic_rp_ep_sim_inst_xcvr_rx_dataout_bfm_src_data; // sonic_rp_ep_sim_inst_xcvr_rx_dataout_bfm:src_data -> sonic_rp_ep_sim_inst:xcvr_rx_dataout_data
	wire         rst_controller_reset_out_reset;                    // rst_controller:reset_out -> [sonic_rp_ep_sim_inst_xcvr_rx_dataout_bfm:reset, sonic_rp_ep_sim_inst_xcvr_tx_datain_bfm:reset]

	sonic_rp_ep_sim_tb_sonic_rp_ep_sim_inst sonic_rp_ep_sim_inst (
		.clk_clk              (sonic_rp_ep_sim_inst_clk_bfm_clk_clk),              //             clk.clk
		.reset_reset_n        (sonic_rp_ep_sim_inst_reset_bfm_reset_reset),        //           reset.reset_n
		.clk_0_clk            (sonic_rp_ep_sim_inst_clk_0_bfm_clk_clk),            //           clk_0.clk
		.reset_0_reset_n      (sonic_rp_ep_sim_inst_reset_0_bfm_reset_reset),      //         reset_0.reset_n
		.xcvr_tx_datain_data  (sonic_rp_ep_sim_inst_xcvr_tx_datain_data),          //  xcvr_tx_datain.data
		.xcvr_rx_dataout_data (sonic_rp_ep_sim_inst_xcvr_rx_dataout_bfm_src_data)  // xcvr_rx_dataout.data
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (250)
	) sonic_rp_ep_sim_inst_clk_bfm (
		.clk (sonic_rp_ep_sim_inst_clk_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (156)
	) sonic_rp_ep_sim_inst_clk_0_bfm (
		.clk (sonic_rp_ep_sim_inst_clk_0_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) sonic_rp_ep_sim_inst_reset_bfm (
		.reset (sonic_rp_ep_sim_inst_reset_bfm_reset_reset), // reset.reset_n
		.clk   (sonic_rp_ep_sim_inst_clk_bfm_clk_clk)        //   clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) sonic_rp_ep_sim_inst_reset_0_bfm (
		.reset (sonic_rp_ep_sim_inst_reset_0_bfm_reset_reset), // reset.reset_n
		.clk   (sonic_rp_ep_sim_inst_clk_bfm_clk_clk)          //   clk.clk
	);

	altera_avalon_st_sink_bfm #(
		.USE_PACKET       (0),
		.USE_CHANNEL      (0),
		.USE_ERROR        (0),
		.USE_READY        (0),
		.USE_VALID        (0),
		.USE_EMPTY        (0),
		.ST_SYMBOL_W      (40),
		.ST_NUMSYMBOLS    (1),
		.ST_CHANNEL_W     (1),
		.ST_ERROR_W       (1),
		.ST_EMPTY_W       (1),
		.ST_READY_LATENCY (0),
		.ST_BEATSPERCYCLE (1),
		.ST_MAX_CHANNELS  (0)
	) sonic_rp_ep_sim_inst_xcvr_tx_datain_bfm (
		.clk                (sonic_rp_ep_sim_inst_clk_0_bfm_clk_clk),   //       clk.clk
		.reset              (rst_controller_reset_out_reset),           // clk_reset.reset
		.sink_data          (sonic_rp_ep_sim_inst_xcvr_tx_datain_data), //      sink.data
		.sink_valid         (1'b1),                                     // (terminated)
		.sink_ready         (),                                         // (terminated)
		.sink_startofpacket (1'b0),                                     // (terminated)
		.sink_endofpacket   (1'b0),                                     // (terminated)
		.sink_empty         (1'b0),                                     // (terminated)
		.sink_channel       (1'b0),                                     // (terminated)
		.sink_error         (1'b0)                                      // (terminated)
	);

	altera_avalon_st_source_bfm #(
		.USE_PACKET       (0),
		.USE_CHANNEL      (0),
		.USE_ERROR        (0),
		.USE_READY        (0),
		.USE_VALID        (0),
		.USE_EMPTY        (0),
		.ST_SYMBOL_W      (40),
		.ST_NUMSYMBOLS    (1),
		.ST_CHANNEL_W     (1),
		.ST_ERROR_W       (1),
		.ST_EMPTY_W       (1),
		.ST_READY_LATENCY (0),
		.ST_BEATSPERCYCLE (1),
		.ST_MAX_CHANNELS  (0)
	) sonic_rp_ep_sim_inst_xcvr_rx_dataout_bfm (
		.clk               (sonic_rp_ep_sim_inst_clk_0_bfm_clk_clk),            //       clk.clk
		.reset             (rst_controller_reset_out_reset),                    // clk_reset.reset
		.src_data          (sonic_rp_ep_sim_inst_xcvr_rx_dataout_bfm_src_data), //       src.data
		.src_valid         (),                                                  // (terminated)
		.src_ready         (1'b1),                                              // (terminated)
		.src_startofpacket (),                                                  // (terminated)
		.src_endofpacket   (),                                                  // (terminated)
		.src_empty         (),                                                  // (terminated)
		.src_channel       (),                                                  // (terminated)
		.src_error         ()                                                   // (terminated)
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~sonic_rp_ep_sim_inst_reset_bfm_reset_reset), // reset_in0.reset
		.clk        (sonic_rp_ep_sim_inst_clk_0_bfm_clk_clk),      //       clk.clk
		.reset_out  (rst_controller_reset_out_reset),              // reset_out.reset
		.reset_in1  (1'b0),                                        // (terminated)
		.reset_in2  (1'b0),                                        // (terminated)
		.reset_in3  (1'b0),                                        // (terminated)
		.reset_in4  (1'b0),                                        // (terminated)
		.reset_in5  (1'b0),                                        // (terminated)
		.reset_in6  (1'b0),                                        // (terminated)
		.reset_in7  (1'b0),                                        // (terminated)
		.reset_in8  (1'b0),                                        // (terminated)
		.reset_in9  (1'b0),                                        // (terminated)
		.reset_in10 (1'b0),                                        // (terminated)
		.reset_in11 (1'b0),                                        // (terminated)
		.reset_in12 (1'b0),                                        // (terminated)
		.reset_in13 (1'b0),                                        // (terminated)
		.reset_in14 (1'b0),                                        // (terminated)
		.reset_in15 (1'b0)                                         // (terminated)
	);

endmodule
