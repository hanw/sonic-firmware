// sonic_monitor_tb.v


`timescale 1 ps / 1 ps
module sonic_monitor_tb (
	);

	wire          sonic_monitor_inst_clk_in_bfm_clk_clk;                          // sonic_monitor_inst_clk_in_bfm:clk -> [sonic_monitor_inst:clk_in_clk, sonic_monitor_inst_reset_bfm:clk, sonic_monitor_inst_sonic_rx_monitor_sink_bfm:clk, sonic_monitor_inst_sonic_rx_monitor_src_bfm:clk, sonic_monitor_inst_sonic_tx_monitor_sink_bfm:clk, sonic_monitor_inst_sonic_tx_monitor_src_bfm:clk]
	wire          sonic_monitor_inst_reset_bfm_reset_reset;                       // sonic_monitor_inst_reset_bfm:reset -> [sonic_monitor_inst:reset_reset_n, sonic_monitor_inst_sonic_rx_monitor_sink_bfm:reset, sonic_monitor_inst_sonic_rx_monitor_src_bfm:reset, sonic_monitor_inst_sonic_tx_monitor_sink_bfm:reset, sonic_monitor_inst_sonic_tx_monitor_src_bfm:reset]
	wire          sonic_monitor_inst_sonic_rx_monitor_src_endofpacket;            // sonic_monitor_inst:sonic_rx_monitor_src_endofpacket -> sonic_monitor_inst_sonic_rx_monitor_src_bfm:sink_endofpacket
	wire          sonic_monitor_inst_sonic_rx_monitor_src_valid;                  // sonic_monitor_inst:sonic_rx_monitor_src_valid -> sonic_monitor_inst_sonic_rx_monitor_src_bfm:sink_valid
	wire          sonic_monitor_inst_sonic_rx_monitor_src_startofpacket;          // sonic_monitor_inst:sonic_rx_monitor_src_startofpacket -> sonic_monitor_inst_sonic_rx_monitor_src_bfm:sink_startofpacket
	wire          sonic_monitor_inst_sonic_rx_monitor_src_error;                  // sonic_monitor_inst:sonic_rx_monitor_src_error -> sonic_monitor_inst_sonic_rx_monitor_src_bfm:sink_error
	wire    [1:0] sonic_monitor_inst_sonic_rx_monitor_src_empty;                  // sonic_monitor_inst:sonic_rx_monitor_src_empty -> sonic_monitor_inst_sonic_rx_monitor_src_bfm:sink_empty
	wire  [127:0] sonic_monitor_inst_sonic_rx_monitor_src_data;                   // sonic_monitor_inst:sonic_rx_monitor_src_data -> sonic_monitor_inst_sonic_rx_monitor_src_bfm:sink_data
	wire          sonic_monitor_inst_sonic_rx_monitor_src_ready;                  // sonic_monitor_inst_sonic_rx_monitor_src_bfm:sink_ready -> sonic_monitor_inst:sonic_rx_monitor_src_ready
	wire          sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_endofpacket;   // sonic_monitor_inst_sonic_rx_monitor_sink_bfm:src_endofpacket -> sonic_monitor_inst:sonic_rx_monitor_sink_endofpacket
	wire          sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_valid;         // sonic_monitor_inst_sonic_rx_monitor_sink_bfm:src_valid -> sonic_monitor_inst:sonic_rx_monitor_sink_valid
	wire          sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_startofpacket; // sonic_monitor_inst_sonic_rx_monitor_sink_bfm:src_startofpacket -> sonic_monitor_inst:sonic_rx_monitor_sink_startofpacket
	wire          sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_error;         // sonic_monitor_inst_sonic_rx_monitor_sink_bfm:src_error -> sonic_monitor_inst:sonic_rx_monitor_sink_error
	wire    [1:0] sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_empty;         // sonic_monitor_inst_sonic_rx_monitor_sink_bfm:src_empty -> sonic_monitor_inst:sonic_rx_monitor_sink_empty
	wire  [127:0] sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_data;          // sonic_monitor_inst_sonic_rx_monitor_sink_bfm:src_data -> sonic_monitor_inst:sonic_rx_monitor_sink_data
	wire          sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_ready;         // sonic_monitor_inst:sonic_rx_monitor_sink_ready -> sonic_monitor_inst_sonic_rx_monitor_sink_bfm:src_ready
	wire          sonic_monitor_inst_sonic_tx_monitor_src_endofpacket;            // sonic_monitor_inst:sonic_tx_monitor_src_endofpacket -> sonic_monitor_inst_sonic_tx_monitor_src_bfm:sink_endofpacket
	wire          sonic_monitor_inst_sonic_tx_monitor_src_valid;                  // sonic_monitor_inst:sonic_tx_monitor_src_valid -> sonic_monitor_inst_sonic_tx_monitor_src_bfm:sink_valid
	wire          sonic_monitor_inst_sonic_tx_monitor_src_startofpacket;          // sonic_monitor_inst:sonic_tx_monitor_src_startofpacket -> sonic_monitor_inst_sonic_tx_monitor_src_bfm:sink_startofpacket
	wire          sonic_monitor_inst_sonic_tx_monitor_src_error;                  // sonic_monitor_inst:sonic_tx_monitor_src_error -> sonic_monitor_inst_sonic_tx_monitor_src_bfm:sink_error
	wire    [1:0] sonic_monitor_inst_sonic_tx_monitor_src_empty;                  // sonic_monitor_inst:sonic_tx_monitor_src_empty -> sonic_monitor_inst_sonic_tx_monitor_src_bfm:sink_empty
	wire  [127:0] sonic_monitor_inst_sonic_tx_monitor_src_data;                   // sonic_monitor_inst:sonic_tx_monitor_src_data -> sonic_monitor_inst_sonic_tx_monitor_src_bfm:sink_data
	wire          sonic_monitor_inst_sonic_tx_monitor_src_ready;                  // sonic_monitor_inst_sonic_tx_monitor_src_bfm:sink_ready -> sonic_monitor_inst:sonic_tx_monitor_src_ready
	wire          sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_endofpacket;   // sonic_monitor_inst_sonic_tx_monitor_sink_bfm:src_endofpacket -> sonic_monitor_inst:sonic_tx_monitor_sink_endofpacket
	wire          sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_valid;         // sonic_monitor_inst_sonic_tx_monitor_sink_bfm:src_valid -> sonic_monitor_inst:sonic_tx_monitor_sink_valid
	wire          sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_startofpacket; // sonic_monitor_inst_sonic_tx_monitor_sink_bfm:src_startofpacket -> sonic_monitor_inst:sonic_tx_monitor_sink_startofpacket
	wire          sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_error;         // sonic_monitor_inst_sonic_tx_monitor_sink_bfm:src_error -> sonic_monitor_inst:sonic_tx_monitor_sink_error
	wire    [1:0] sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_empty;         // sonic_monitor_inst_sonic_tx_monitor_sink_bfm:src_empty -> sonic_monitor_inst:sonic_tx_monitor_sink_empty
	wire  [127:0] sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_data;          // sonic_monitor_inst_sonic_tx_monitor_sink_bfm:src_data -> sonic_monitor_inst:sonic_tx_monitor_sink_data
	wire          sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_ready;         // sonic_monitor_inst:sonic_tx_monitor_sink_ready -> sonic_monitor_inst_sonic_tx_monitor_sink_bfm:src_ready

	sonic_monitor_tb_sonic_monitor_inst sonic_monitor_inst (
		.clk_in_clk                          (sonic_monitor_inst_clk_in_bfm_clk_clk),                          //                clk_in.clk
		.reset_reset_n                       (sonic_monitor_inst_reset_bfm_reset_reset),                       //                 reset.reset_n
		.sonic_rx_monitor_src_data           (sonic_monitor_inst_sonic_rx_monitor_src_data),                   //  sonic_rx_monitor_src.data
		.sonic_rx_monitor_src_valid          (sonic_monitor_inst_sonic_rx_monitor_src_valid),                  //                      .valid
		.sonic_rx_monitor_src_ready          (sonic_monitor_inst_sonic_rx_monitor_src_ready),                  //                      .ready
		.sonic_rx_monitor_src_startofpacket  (sonic_monitor_inst_sonic_rx_monitor_src_startofpacket),          //                      .startofpacket
		.sonic_rx_monitor_src_endofpacket    (sonic_monitor_inst_sonic_rx_monitor_src_endofpacket),            //                      .endofpacket
		.sonic_rx_monitor_src_empty          (sonic_monitor_inst_sonic_rx_monitor_src_empty),                  //                      .empty
		.sonic_rx_monitor_src_error          (sonic_monitor_inst_sonic_rx_monitor_src_error),                  //                      .error
		.sonic_rx_monitor_sink_data          (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_data),          // sonic_rx_monitor_sink.data
		.sonic_rx_monitor_sink_valid         (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_valid),         //                      .valid
		.sonic_rx_monitor_sink_ready         (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_ready),         //                      .ready
		.sonic_rx_monitor_sink_startofpacket (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_startofpacket), //                      .startofpacket
		.sonic_rx_monitor_sink_endofpacket   (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_endofpacket),   //                      .endofpacket
		.sonic_rx_monitor_sink_empty         (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_empty),         //                      .empty
		.sonic_rx_monitor_sink_error         (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_error),         //                      .error
		.sonic_tx_monitor_src_data           (sonic_monitor_inst_sonic_tx_monitor_src_data),                   //  sonic_tx_monitor_src.data
		.sonic_tx_monitor_src_valid          (sonic_monitor_inst_sonic_tx_monitor_src_valid),                  //                      .valid
		.sonic_tx_monitor_src_ready          (sonic_monitor_inst_sonic_tx_monitor_src_ready),                  //                      .ready
		.sonic_tx_monitor_src_startofpacket  (sonic_monitor_inst_sonic_tx_monitor_src_startofpacket),          //                      .startofpacket
		.sonic_tx_monitor_src_endofpacket    (sonic_monitor_inst_sonic_tx_monitor_src_endofpacket),            //                      .endofpacket
		.sonic_tx_monitor_src_empty          (sonic_monitor_inst_sonic_tx_monitor_src_empty),                  //                      .empty
		.sonic_tx_monitor_src_error          (sonic_monitor_inst_sonic_tx_monitor_src_error),                  //                      .error
		.sonic_tx_monitor_sink_data          (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_data),          // sonic_tx_monitor_sink.data
		.sonic_tx_monitor_sink_valid         (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_valid),         //                      .valid
		.sonic_tx_monitor_sink_ready         (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_ready),         //                      .ready
		.sonic_tx_monitor_sink_startofpacket (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_startofpacket), //                      .startofpacket
		.sonic_tx_monitor_sink_endofpacket   (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_endofpacket),   //                      .endofpacket
		.sonic_tx_monitor_sink_empty         (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_empty),         //                      .empty
		.sonic_tx_monitor_sink_error         (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_error)          //                      .error
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (250)
	) sonic_monitor_inst_clk_in_bfm (
		.clk (sonic_monitor_inst_clk_in_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) sonic_monitor_inst_reset_bfm (
		.reset (sonic_monitor_inst_reset_bfm_reset_reset), // reset.reset_n
		.clk   (sonic_monitor_inst_clk_in_bfm_clk_clk)     //   clk.clk
	);

	altera_avalon_st_sink_bfm #(
		.USE_PACKET       (1),
		.USE_CHANNEL      (0),
		.USE_ERROR        (1),
		.USE_READY        (1),
		.USE_VALID        (1),
		.USE_EMPTY        (1),
		.ST_SYMBOL_W      (32),
		.ST_NUMSYMBOLS    (4),
		.ST_CHANNEL_W     (1),
		.ST_ERROR_W       (1),
		.ST_EMPTY_W       (2),
		.ST_READY_LATENCY (0),
		.ST_BEATSPERCYCLE (1),
		.ST_MAX_CHANNELS  (0)
	) sonic_monitor_inst_sonic_rx_monitor_src_bfm (
		.clk                (sonic_monitor_inst_clk_in_bfm_clk_clk),                 //       clk.clk
		.reset              (~sonic_monitor_inst_reset_bfm_reset_reset),             // clk_reset.reset
		.sink_data          (sonic_monitor_inst_sonic_rx_monitor_src_data),          //      sink.data
		.sink_valid         (sonic_monitor_inst_sonic_rx_monitor_src_valid),         //          .valid
		.sink_ready         (sonic_monitor_inst_sonic_rx_monitor_src_ready),         //          .ready
		.sink_startofpacket (sonic_monitor_inst_sonic_rx_monitor_src_startofpacket), //          .startofpacket
		.sink_endofpacket   (sonic_monitor_inst_sonic_rx_monitor_src_endofpacket),   //          .endofpacket
		.sink_empty         (sonic_monitor_inst_sonic_rx_monitor_src_empty),         //          .empty
		.sink_error         (sonic_monitor_inst_sonic_rx_monitor_src_error),         //          .error
		.sink_channel       (1'b0)                                                   // (terminated)
	);

	altera_avalon_st_source_bfm #(
		.USE_PACKET       (1),
		.USE_CHANNEL      (0),
		.USE_ERROR        (1),
		.USE_READY        (1),
		.USE_VALID        (1),
		.USE_EMPTY        (1),
		.ST_SYMBOL_W      (32),
		.ST_NUMSYMBOLS    (4),
		.ST_CHANNEL_W     (1),
		.ST_ERROR_W       (1),
		.ST_EMPTY_W       (2),
		.ST_READY_LATENCY (0),
		.ST_BEATSPERCYCLE (1),
		.ST_MAX_CHANNELS  (0)
	) sonic_monitor_inst_sonic_rx_monitor_sink_bfm (
		.clk               (sonic_monitor_inst_clk_in_bfm_clk_clk),                          //       clk.clk
		.reset             (~sonic_monitor_inst_reset_bfm_reset_reset),                      // clk_reset.reset
		.src_data          (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_data),          //       src.data
		.src_valid         (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_valid),         //          .valid
		.src_ready         (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_ready),         //          .ready
		.src_startofpacket (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_startofpacket), //          .startofpacket
		.src_endofpacket   (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_endofpacket),   //          .endofpacket
		.src_empty         (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_empty),         //          .empty
		.src_error         (sonic_monitor_inst_sonic_rx_monitor_sink_bfm_src_error),         //          .error
		.src_channel       ()                                                                // (terminated)
	);

	altera_avalon_st_sink_bfm #(
		.USE_PACKET       (1),
		.USE_CHANNEL      (0),
		.USE_ERROR        (1),
		.USE_READY        (1),
		.USE_VALID        (1),
		.USE_EMPTY        (1),
		.ST_SYMBOL_W      (32),
		.ST_NUMSYMBOLS    (4),
		.ST_CHANNEL_W     (1),
		.ST_ERROR_W       (1),
		.ST_EMPTY_W       (2),
		.ST_READY_LATENCY (0),
		.ST_BEATSPERCYCLE (1),
		.ST_MAX_CHANNELS  (0)
	) sonic_monitor_inst_sonic_tx_monitor_src_bfm (
		.clk                (sonic_monitor_inst_clk_in_bfm_clk_clk),                 //       clk.clk
		.reset              (~sonic_monitor_inst_reset_bfm_reset_reset),             // clk_reset.reset
		.sink_data          (sonic_monitor_inst_sonic_tx_monitor_src_data),          //      sink.data
		.sink_valid         (sonic_monitor_inst_sonic_tx_monitor_src_valid),         //          .valid
		.sink_ready         (sonic_monitor_inst_sonic_tx_monitor_src_ready),         //          .ready
		.sink_startofpacket (sonic_monitor_inst_sonic_tx_monitor_src_startofpacket), //          .startofpacket
		.sink_endofpacket   (sonic_monitor_inst_sonic_tx_monitor_src_endofpacket),   //          .endofpacket
		.sink_empty         (sonic_monitor_inst_sonic_tx_monitor_src_empty),         //          .empty
		.sink_error         (sonic_monitor_inst_sonic_tx_monitor_src_error),         //          .error
		.sink_channel       (1'b0)                                                   // (terminated)
	);

	altera_avalon_st_source_bfm #(
		.USE_PACKET       (1),
		.USE_CHANNEL      (0),
		.USE_ERROR        (1),
		.USE_READY        (1),
		.USE_VALID        (1),
		.USE_EMPTY        (1),
		.ST_SYMBOL_W      (32),
		.ST_NUMSYMBOLS    (4),
		.ST_CHANNEL_W     (1),
		.ST_ERROR_W       (1),
		.ST_EMPTY_W       (2),
		.ST_READY_LATENCY (0),
		.ST_BEATSPERCYCLE (1),
		.ST_MAX_CHANNELS  (0)
	) sonic_monitor_inst_sonic_tx_monitor_sink_bfm (
		.clk               (sonic_monitor_inst_clk_in_bfm_clk_clk),                          //       clk.clk
		.reset             (~sonic_monitor_inst_reset_bfm_reset_reset),                      // clk_reset.reset
		.src_data          (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_data),          //       src.data
		.src_valid         (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_valid),         //          .valid
		.src_ready         (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_ready),         //          .ready
		.src_startofpacket (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_startofpacket), //          .startofpacket
		.src_endofpacket   (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_endofpacket),   //          .endofpacket
		.src_empty         (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_empty),         //          .empty
		.src_error         (sonic_monitor_inst_sonic_tx_monitor_sink_bfm_src_error),         //          .error
		.src_channel       ()                                                                // (terminated)
	);

endmodule
