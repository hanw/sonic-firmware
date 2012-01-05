// sonic_vc.v


`timescale 1 ps / 1 ps
module sonic_vc (
		output wire         rx_vc_out0_valid,         //        rx_vc_out0.valid
		input  wire         rx_vc_out0_ready,         //                  .ready
		output wire [127:0] rx_vc_out0_data,          //                  .data
		output wire         rx_vc_out0_startofpacket, //                  .startofpacket
		output wire         rx_vc_out0_endofpacket,   //                  .endofpacket
		output wire         rx_vc_out0_empty,         //                  .empty
		output wire         rx_vc_out1_valid,         //        rx_vc_out1.valid
		input  wire         rx_vc_out1_ready,         //                  .ready
		output wire [127:0] rx_vc_out1_data,          //                  .data
		output wire         rx_vc_out1_startofpacket, //                  .startofpacket
		output wire         rx_vc_out1_endofpacket,   //                  .endofpacket
		output wire         rx_vc_out1_empty,         //                  .empty
		output wire [7:0]   rx_vc_out0_bardec_export, // rx_vc_out0_bardec.export
		input  wire [7:0]   rx_vc_in_bardec_export,   //   rx_vc_in_bardec.export
		input  wire         clk_clk,                  //               clk.clk
		input  wire         rx_vc_in_valid,           //          rx_vc_in.valid
		output wire         rx_vc_in_ready,           //                  .ready
		input  wire [127:0] rx_vc_in_data,            //                  .data
		input  wire         rx_vc_in_startofpacket,   //                  .startofpacket
		input  wire         rx_vc_in_endofpacket,     //                  .endofpacket
		input  wire         rx_vc_in_empty,           //                  .empty
		input  wire         rx_vc_in_channel,         //                  .channel
		input  wire [127:0] tx_vc_in0_data,           //         tx_vc_in0.data
		input  wire         tx_vc_in0_valid,          //                  .valid
		output wire         tx_vc_in0_ready,          //                  .ready
		input  wire         tx_vc_in0_startofpacket,  //                  .startofpacket
		input  wire         tx_vc_in0_endofpacket,    //                  .endofpacket
		input  wire         tx_vc_in0_empty,          //                  .empty
		input  wire         tx_vc_in0_error,          //                  .error
		input  wire [127:0] tx_vc_in1_data,           //         tx_vc_in1.data
		input  wire         tx_vc_in1_valid,          //                  .valid
		output wire         tx_vc_in1_ready,          //                  .ready
		input  wire         tx_vc_in1_startofpacket,  //                  .startofpacket
		input  wire         tx_vc_in1_endofpacket,    //                  .endofpacket
		input  wire         tx_vc_in1_empty,          //                  .empty
		input  wire         tx_vc_in1_error,          //                  .error
		input  wire         tx_vc_out_ready,          //         tx_vc_out.ready
		output wire         tx_vc_out_valid,          //                  .valid
		output wire [127:0] tx_vc_out_data,           //                  .data
		output wire         tx_vc_out_channel,        //                  .channel
		output wire         tx_vc_out_error,          //                  .error
		output wire         tx_vc_out_startofpacket,  //                  .startofpacket
		output wire         tx_vc_out_endofpacket,    //                  .endofpacket
		output wire         tx_vc_out_empty,          //                  .empty
		input  wire         reset_reset_n,            //             reset.reset_n
		output wire [15:0]  rx_vc_out0_be_export,     //     rx_vc_out0_be.export
		output wire [7:0]   rx_vc_out1_bardec_export, // rx_vc_out1_bardec.export
		input  wire [15:0]  rx_vc_in_be_export,       //       rx_vc_in_be.export
		output wire [15:0]  rx_vc_out1_be_export      //     rx_vc_out1_be.export
	);

	wire          multiplexer_0_out_endofpacket;   // multiplexer_0:out_endofpacket -> multiplexer_adapter:in_endofpacket
	wire          multiplexer_0_out_valid;         // multiplexer_0:out_valid -> multiplexer_adapter:in_valid
	wire          multiplexer_0_out_startofpacket; // multiplexer_0:out_startofpacket -> multiplexer_adapter:in_startofpacket
	wire    [0:0] multiplexer_0_out_error;         // multiplexer_0:out_error -> multiplexer_adapter:in_error
	wire          multiplexer_0_out_empty;         // multiplexer_0:out_empty -> multiplexer_adapter:in_empty
	wire  [127:0] multiplexer_0_out_data;          // multiplexer_0:out_data -> multiplexer_adapter:in_data
	wire          multiplexer_0_out_ready;         // multiplexer_adapter:in_ready -> multiplexer_0:out_ready
	wire          multiplexer_0_out_channel;       // multiplexer_0:out_channel -> multiplexer_adapter:in_channel
	wire          tx_fifo_p0_out_endofpacket;      // tx_fifo_p0:out_endofpacket -> multiplexer_0:in0_endofpacket
	wire          tx_fifo_p0_out_valid;            // tx_fifo_p0:out_valid -> multiplexer_0:in0_valid
	wire          tx_fifo_p0_out_startofpacket;    // tx_fifo_p0:out_startofpacket -> multiplexer_0:in0_startofpacket
	wire          tx_fifo_p0_out_error;            // tx_fifo_p0:out_error -> multiplexer_0:in0_error
	wire          tx_fifo_p0_out_empty;            // tx_fifo_p0:out_empty -> multiplexer_0:in0_empty
	wire  [127:0] tx_fifo_p0_out_data;             // tx_fifo_p0:out_data -> multiplexer_0:in0_data
	wire          tx_fifo_p0_out_ready;            // multiplexer_0:in0_ready -> tx_fifo_p0:out_ready
	wire          tx_fifo_p1_out_endofpacket;      // tx_fifo_p1:out_endofpacket -> multiplexer_0:in1_endofpacket
	wire          tx_fifo_p1_out_valid;            // tx_fifo_p1:out_valid -> multiplexer_0:in1_valid
	wire          tx_fifo_p1_out_startofpacket;    // tx_fifo_p1:out_startofpacket -> multiplexer_0:in1_startofpacket
	wire          tx_fifo_p1_out_error;            // tx_fifo_p1:out_error -> multiplexer_0:in1_error
	wire          tx_fifo_p1_out_empty;            // tx_fifo_p1:out_empty -> multiplexer_0:in1_empty
	wire  [127:0] tx_fifo_p1_out_data;             // tx_fifo_p1:out_data -> multiplexer_0:in1_data
	wire          tx_fifo_p1_out_ready;            // multiplexer_0:in1_ready -> tx_fifo_p1:out_ready
	wire          rst_controller_reset_out_reset;  // rst_controller:reset_out -> [multiplexer_0:reset_n, multiplexer_adapter:reset_n, sonic_vc_demultiplexer_custom_0:reset_n, tx_fifo_p0:reset, tx_fifo_p1:reset]

	sonic_vc_multiplexer_0 multiplexer_0 (
		.clk               (clk_clk),                         //   clk.clk
		.reset_n           (~rst_controller_reset_out_reset), // reset.reset_n
		.in0_valid         (tx_fifo_p0_out_valid),            //   in0.valid
		.in0_ready         (tx_fifo_p0_out_ready),            //      .ready
		.in0_data          (tx_fifo_p0_out_data),             //      .data
		.in0_error         (tx_fifo_p0_out_error),            //      .error
		.in0_startofpacket (tx_fifo_p0_out_startofpacket),    //      .startofpacket
		.in0_endofpacket   (tx_fifo_p0_out_endofpacket),      //      .endofpacket
		.in0_empty         (tx_fifo_p0_out_empty),            //      .empty
		.in1_valid         (tx_fifo_p1_out_valid),            //   in1.valid
		.in1_ready         (tx_fifo_p1_out_ready),            //      .ready
		.in1_data          (tx_fifo_p1_out_data),             //      .data
		.in1_error         (tx_fifo_p1_out_error),            //      .error
		.in1_startofpacket (tx_fifo_p1_out_startofpacket),    //      .startofpacket
		.in1_endofpacket   (tx_fifo_p1_out_endofpacket),      //      .endofpacket
		.in1_empty         (tx_fifo_p1_out_empty),            //      .empty
		.out_channel       (multiplexer_0_out_channel),       //   out.channel
		.out_valid         (multiplexer_0_out_valid),         //      .valid
		.out_ready         (multiplexer_0_out_ready),         //      .ready
		.out_data          (multiplexer_0_out_data),          //      .data
		.out_error         (multiplexer_0_out_error),         //      .error
		.out_startofpacket (multiplexer_0_out_startofpacket), //      .startofpacket
		.out_endofpacket   (multiplexer_0_out_endofpacket),   //      .endofpacket
		.out_empty         (multiplexer_0_out_empty)          //      .empty
	);

	sonic_vc_multiplexer_adapter multiplexer_adapter (
		.clk               (clk_clk),                         //   clk.clk
		.reset_n           (~rst_controller_reset_out_reset), // reset.reset_n
		.in_ready          (multiplexer_0_out_ready),         //    in.ready
		.in_valid          (multiplexer_0_out_valid),         //      .valid
		.in_data           (multiplexer_0_out_data),          //      .data
		.in_channel        (multiplexer_0_out_channel),       //      .channel
		.in_error          (multiplexer_0_out_error),         //      .error
		.in_startofpacket  (multiplexer_0_out_startofpacket), //      .startofpacket
		.in_endofpacket    (multiplexer_0_out_endofpacket),   //      .endofpacket
		.in_empty          (multiplexer_0_out_empty),         //      .empty
		.out_ready         (tx_vc_out_ready),                 //   out.ready
		.out_valid         (tx_vc_out_valid),                 //      .valid
		.out_data          (tx_vc_out_data),                  //      .data
		.out_channel       (tx_vc_out_channel),               //      .channel
		.out_error         (tx_vc_out_error),                 //      .error
		.out_startofpacket (tx_vc_out_startofpacket),         //      .startofpacket
		.out_endofpacket   (tx_vc_out_endofpacket),           //      .endofpacket
		.out_empty         (tx_vc_out_empty)                  //      .empty
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (2),
		.BITS_PER_SYMBOL     (64),
		.FIFO_DEPTH          (8192),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (1),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (3),
		.USE_MEMORY_BLOCKS   (1),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_fifo_p0 (
		.clk               (clk_clk),                              //       clk.clk
		.reset             (rst_controller_reset_out_reset),       // clk_reset.reset
		.in_data           (tx_vc_in0_data),                       //        in.data
		.in_valid          (tx_vc_in0_valid),                      //          .valid
		.in_ready          (tx_vc_in0_ready),                      //          .ready
		.in_startofpacket  (tx_vc_in0_startofpacket),              //          .startofpacket
		.in_endofpacket    (tx_vc_in0_endofpacket),                //          .endofpacket
		.in_empty          (tx_vc_in0_empty),                      //          .empty
		.in_error          (tx_vc_in0_error),                      //          .error
		.out_data          (tx_fifo_p0_out_data),                  //       out.data
		.out_valid         (tx_fifo_p0_out_valid),                 //          .valid
		.out_ready         (tx_fifo_p0_out_ready),                 //          .ready
		.out_startofpacket (tx_fifo_p0_out_startofpacket),         //          .startofpacket
		.out_endofpacket   (tx_fifo_p0_out_endofpacket),           //          .endofpacket
		.out_empty         (tx_fifo_p0_out_empty),                 //          .empty
		.out_error         (tx_fifo_p0_out_error),                 //          .error
		.csr_address       (2'b00),                                // (terminated)
		.csr_read          (1'b0),                                 // (terminated)
		.csr_write         (1'b0),                                 // (terminated)
		.csr_readdata      (),                                     // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000), // (terminated)
		.almost_full_data  (),                                     // (terminated)
		.almost_empty_data (),                                     // (terminated)
		.in_channel        (1'b0),                                 // (terminated)
		.out_channel       ()                                      // (terminated)
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (2),
		.BITS_PER_SYMBOL     (64),
		.FIFO_DEPTH          (8192),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (1),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (3),
		.USE_MEMORY_BLOCKS   (1),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_fifo_p1 (
		.clk               (clk_clk),                              //       clk.clk
		.reset             (rst_controller_reset_out_reset),       // clk_reset.reset
		.in_data           (tx_vc_in1_data),                       //        in.data
		.in_valid          (tx_vc_in1_valid),                      //          .valid
		.in_ready          (tx_vc_in1_ready),                      //          .ready
		.in_startofpacket  (tx_vc_in1_startofpacket),              //          .startofpacket
		.in_endofpacket    (tx_vc_in1_endofpacket),                //          .endofpacket
		.in_empty          (tx_vc_in1_empty),                      //          .empty
		.in_error          (tx_vc_in1_error),                      //          .error
		.out_data          (tx_fifo_p1_out_data),                  //       out.data
		.out_valid         (tx_fifo_p1_out_valid),                 //          .valid
		.out_ready         (tx_fifo_p1_out_ready),                 //          .ready
		.out_startofpacket (tx_fifo_p1_out_startofpacket),         //          .startofpacket
		.out_endofpacket   (tx_fifo_p1_out_endofpacket),           //          .endofpacket
		.out_empty         (tx_fifo_p1_out_empty),                 //          .empty
		.out_error         (tx_fifo_p1_out_error),                 //          .error
		.csr_address       (2'b00),                                // (terminated)
		.csr_read          (1'b0),                                 // (terminated)
		.csr_write         (1'b0),                                 // (terminated)
		.csr_readdata      (),                                     // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000), // (terminated)
		.almost_full_data  (),                                     // (terminated)
		.almost_empty_data (),                                     // (terminated)
		.in_channel        (1'b0),                                 // (terminated)
		.out_channel       ()                                      // (terminated)
	);

	sonic_vc_demultiplexer_0 sonic_vc_demultiplexer_custom_0 (
		.clk                (clk_clk),                         //       clock.clk
		.in_valid           (rx_vc_in_valid),                  //          in.valid
		.in_ready           (rx_vc_in_ready),                  //            .ready
		.in_data            (rx_vc_in_data),                   //            .data
		.in_startofpacket   (rx_vc_in_startofpacket),          //            .startofpacket
		.in_endofpacket     (rx_vc_in_endofpacket),            //            .endofpacket
		.in_empty           (rx_vc_in_empty),                  //            .empty
		.in_channel         (rx_vc_in_channel),                //            .channel
		.out0_valid         (rx_vc_out0_valid),                //        out0.valid
		.out0_ready         (rx_vc_out0_ready),                //            .ready
		.out0_data          (rx_vc_out0_data),                 //            .data
		.out0_startofpacket (rx_vc_out0_startofpacket),        //            .startofpacket
		.out0_endofpacket   (rx_vc_out0_endofpacket),          //            .endofpacket
		.out0_empty         (rx_vc_out0_empty),                //            .empty
		.out1_valid         (rx_vc_out1_valid),                //        out1.valid
		.out1_ready         (rx_vc_out1_ready),                //            .ready
		.out1_data          (rx_vc_out1_data),                 //            .data
		.out1_startofpacket (rx_vc_out1_startofpacket),        //            .startofpacket
		.out1_endofpacket   (rx_vc_out1_endofpacket),          //            .endofpacket
		.out1_empty         (rx_vc_out1_empty),                //            .empty
		.in_bardec          (rx_vc_in_bardec_export),          //   in_bardec.export
		.in_be              (rx_vc_in_be_export),              //       in_be.export
		.out0_bardec        (rx_vc_out0_bardec_export),        // out0_bardec.export
		.out0_be            (rx_vc_out0_be_export),            //     out0_be.export
		.out1_bardec        (rx_vc_out1_bardec_export),        // out1_bardec.export
		.out1_be            (rx_vc_out1_be_export),            //     out1_be.export
		.reset_n            (~rst_controller_reset_out_reset)  //     reset_n.reset_n
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
