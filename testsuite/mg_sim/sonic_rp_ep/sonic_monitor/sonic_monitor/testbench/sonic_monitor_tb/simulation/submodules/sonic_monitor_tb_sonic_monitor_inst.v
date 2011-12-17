// sonic_monitor_tb_sonic_monitor_inst.v


`timescale 1 ps / 1 ps
module sonic_monitor_tb_sonic_monitor_inst (
		input  wire [127:0] sonic_tx_monitor_sink_data,          // sonic_tx_monitor_sink.data
		input  wire         sonic_tx_monitor_sink_valid,         //                      .valid
		output wire         sonic_tx_monitor_sink_ready,         //                      .ready
		input  wire         sonic_tx_monitor_sink_startofpacket, //                      .startofpacket
		input  wire         sonic_tx_monitor_sink_endofpacket,   //                      .endofpacket
		input  wire [1:0]   sonic_tx_monitor_sink_empty,         //                      .empty
		input  wire         sonic_tx_monitor_sink_error,         //                      .error
		output wire [127:0] sonic_rx_monitor_src_data,           //  sonic_rx_monitor_src.data
		output wire         sonic_rx_monitor_src_valid,          //                      .valid
		input  wire         sonic_rx_monitor_src_ready,          //                      .ready
		output wire         sonic_rx_monitor_src_startofpacket,  //                      .startofpacket
		output wire         sonic_rx_monitor_src_endofpacket,    //                      .endofpacket
		output wire [1:0]   sonic_rx_monitor_src_empty,          //                      .empty
		output wire         sonic_rx_monitor_src_error,          //                      .error
		input  wire         clk_in_clk,                          //                clk_in.clk
		output wire [127:0] sonic_tx_monitor_src_data,           //  sonic_tx_monitor_src.data
		output wire         sonic_tx_monitor_src_valid,          //                      .valid
		input  wire         sonic_tx_monitor_src_ready,          //                      .ready
		output wire         sonic_tx_monitor_src_startofpacket,  //                      .startofpacket
		output wire         sonic_tx_monitor_src_endofpacket,    //                      .endofpacket
		output wire [1:0]   sonic_tx_monitor_src_empty,          //                      .empty
		output wire         sonic_tx_monitor_src_error,          //                      .error
		input  wire         reset_reset_n,                       //                 reset.reset_n
		input  wire [127:0] sonic_rx_monitor_sink_data,          // sonic_rx_monitor_sink.data
		input  wire         sonic_rx_monitor_sink_valid,         //                      .valid
		output wire         sonic_rx_monitor_sink_ready,         //                      .ready
		input  wire         sonic_rx_monitor_sink_startofpacket, //                      .startofpacket
		input  wire         sonic_rx_monitor_sink_endofpacket,   //                      .endofpacket
		input  wire [1:0]   sonic_rx_monitor_sink_empty,         //                      .empty
		input  wire         sonic_rx_monitor_sink_error          //                      .error
	);

	wire    rst_controller_reset_out_reset; // rst_controller:reset_out -> [sonic_rx_monitor:reset, sonic_tx_monitor:reset]

	altera_avalon_st_monitor #(
		.USE_PACKET         (1),
		.USE_CHANNEL        (0),
		.USE_ERROR          (1),
		.USE_READY          (1),
		.USE_VALID          (1),
		.USE_EMPTY          (1),
		.ST_SYMBOL_W        (32),
		.ST_NUMSYMBOLS      (4),
		.ST_CHANNEL_W       (1),
		.ST_ERROR_W         (1),
		.ST_EMPTY_W         (2),
		.ST_READY_LATENCY   (0),
		.ST_BEATSPERCYCLE   (1),
		.ST_MAX_CHANNELS    (0),
		.ST_MAX_PACKET_SIZE (1000)
	) sonic_rx_monitor (
		.clk                (clk_in_clk),                          //       clk.clk
		.reset              (rst_controller_reset_out_reset),      // clk_reset.reset
		.src_data           (sonic_rx_monitor_src_data),           //       src.data
		.src_valid          (sonic_rx_monitor_src_valid),          //          .valid
		.src_ready          (sonic_rx_monitor_src_ready),          //          .ready
		.src_startofpacket  (sonic_rx_monitor_src_startofpacket),  //          .startofpacket
		.src_endofpacket    (sonic_rx_monitor_src_endofpacket),    //          .endofpacket
		.src_empty          (sonic_rx_monitor_src_empty),          //          .empty
		.src_error          (sonic_rx_monitor_src_error),          //          .error
		.sink_data          (sonic_rx_monitor_sink_data),          //      sink.data
		.sink_valid         (sonic_rx_monitor_sink_valid),         //          .valid
		.sink_ready         (sonic_rx_monitor_sink_ready),         //          .ready
		.sink_startofpacket (sonic_rx_monitor_sink_startofpacket), //          .startofpacket
		.sink_endofpacket   (sonic_rx_monitor_sink_endofpacket),   //          .endofpacket
		.sink_empty         (sonic_rx_monitor_sink_empty),         //          .empty
		.sink_error         (sonic_rx_monitor_sink_error),         //          .error
		.src_channel        (),                                    // (terminated)
		.sink_channel       (1'b0)                                 // (terminated)
	);

	altera_avalon_st_monitor #(
		.USE_PACKET         (1),
		.USE_CHANNEL        (0),
		.USE_ERROR          (1),
		.USE_READY          (1),
		.USE_VALID          (1),
		.USE_EMPTY          (1),
		.ST_SYMBOL_W        (32),
		.ST_NUMSYMBOLS      (4),
		.ST_CHANNEL_W       (1),
		.ST_ERROR_W         (1),
		.ST_EMPTY_W         (2),
		.ST_READY_LATENCY   (0),
		.ST_BEATSPERCYCLE   (1),
		.ST_MAX_CHANNELS    (0),
		.ST_MAX_PACKET_SIZE (1000)
	) sonic_tx_monitor (
		.clk                (clk_in_clk),                          //       clk.clk
		.reset              (rst_controller_reset_out_reset),      // clk_reset.reset
		.src_data           (sonic_tx_monitor_src_data),           //       src.data
		.src_valid          (sonic_tx_monitor_src_valid),          //          .valid
		.src_ready          (sonic_tx_monitor_src_ready),          //          .ready
		.src_startofpacket  (sonic_tx_monitor_src_startofpacket),  //          .startofpacket
		.src_endofpacket    (sonic_tx_monitor_src_endofpacket),    //          .endofpacket
		.src_empty          (sonic_tx_monitor_src_empty),          //          .empty
		.src_error          (sonic_tx_monitor_src_error),          //          .error
		.sink_data          (sonic_tx_monitor_sink_data),          //      sink.data
		.sink_valid         (sonic_tx_monitor_sink_valid),         //          .valid
		.sink_ready         (sonic_tx_monitor_sink_ready),         //          .ready
		.sink_startofpacket (sonic_tx_monitor_sink_startofpacket), //          .startofpacket
		.sink_endofpacket   (sonic_tx_monitor_sink_endofpacket),   //          .endofpacket
		.sink_empty         (sonic_tx_monitor_sink_empty),         //          .empty
		.sink_error         (sonic_tx_monitor_sink_error),         //          .error
		.src_channel        (),                                    // (terminated)
		.sink_channel       (1'b0)                                 // (terminated)
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~reset_reset_n),                 // reset_in0.reset
		.clk        (clk_in_clk),                     //       clk.clk
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
