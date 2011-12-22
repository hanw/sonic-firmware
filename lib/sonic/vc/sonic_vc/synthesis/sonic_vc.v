// sonic_vc.v

// Generated using ACDS version 11.1 173 at 2011.12.22.03:14:08

`timescale 1 ps / 1 ps
module sonic_vc (
		input  wire         rx_vc_in_channel,         //   rx_vc_in.channel
		input  wire         rx_vc_in_valid,           //           .valid
		output wire         rx_vc_in_ready,           //           .ready
		input  wire [127:0] rx_vc_in_data,            //           .data
		input  wire         rx_vc_in_startofpacket,   //           .startofpacket
		input  wire         rx_vc_in_endofpacket,     //           .endofpacket
		input  wire [1:0]   rx_vc_in_empty,           //           .empty
		output wire         rx_vc_out0_valid,         // rx_vc_out0.valid
		input  wire         rx_vc_out0_ready,         //           .ready
		output wire [127:0] rx_vc_out0_data,          //           .data
		output wire         rx_vc_out0_startofpacket, //           .startofpacket
		output wire         rx_vc_out0_endofpacket,   //           .endofpacket
		output wire [1:0]   rx_vc_out0_empty,         //           .empty
		input  wire         tx_vc_in0_valid,          //  tx_vc_in0.valid
		input  wire [127:0] tx_vc_in0_data,           //           .data
		input  wire         tx_vc_in0_error,          //           .error
		input  wire         tx_vc_in0_startofpacket,  //           .startofpacket
		input  wire         tx_vc_in0_endofpacket,    //           .endofpacket
		input  wire [1:0]   tx_vc_in0_empty,          //           .empty
		output wire         tx_vc_in0_ready,          //           .ready
		input  wire         tx_vc_in1_valid,          //  tx_vc_in1.valid
		input  wire [127:0] tx_vc_in1_data,           //           .data
		input  wire         tx_vc_in1_error,          //           .error
		input  wire         tx_vc_in1_startofpacket,  //           .startofpacket
		input  wire         tx_vc_in1_endofpacket,    //           .endofpacket
		input  wire [1:0]   tx_vc_in1_empty,          //           .empty
		output wire         tx_vc_in1_ready,          //           .ready
		output wire         rx_vc_out1_valid,         // rx_vc_out1.valid
		input  wire         rx_vc_out1_ready,         //           .ready
		output wire [127:0] rx_vc_out1_data,          //           .data
		output wire         rx_vc_out1_startofpacket, //           .startofpacket
		output wire         rx_vc_out1_endofpacket,   //           .endofpacket
		output wire [1:0]   rx_vc_out1_empty,         //           .empty
		input  wire         tx_vc_out_ready,          //  tx_vc_out.ready
		output wire         tx_vc_out_valid,          //           .valid
		output wire [127:0] tx_vc_out_data,           //           .data
		output wire         tx_vc_out_channel,        //           .channel
		output wire         tx_vc_out_error,          //           .error
		output wire         tx_vc_out_startofpacket,  //           .startofpacket
		output wire         tx_vc_out_endofpacket,    //           .endofpacket
		output wire [1:0]   tx_vc_out_empty,          //           .empty
		input  wire         reset_reset_n,            //      reset.reset_n
		input  wire         clk_clk                   //        clk.clk
	);

	wire          multiplexer_0_out_endofpacket;        // multiplexer_0:out_endofpacket -> multiplexer_adapter:in_endofpacket
	wire          multiplexer_0_out_valid;              // multiplexer_0:out_valid -> multiplexer_adapter:in_valid
	wire          multiplexer_0_out_startofpacket;      // multiplexer_0:out_startofpacket -> multiplexer_adapter:in_startofpacket
	wire    [0:0] multiplexer_0_out_error;              // multiplexer_0:out_error -> multiplexer_adapter:in_error
	wire    [1:0] multiplexer_0_out_empty;              // multiplexer_0:out_empty -> multiplexer_adapter:in_empty
	wire  [127:0] multiplexer_0_out_data;               // multiplexer_0:out_data -> multiplexer_adapter:in_data
	wire          multiplexer_0_out_ready;              // multiplexer_adapter:in_ready -> multiplexer_0:out_ready
	wire          multiplexer_0_out_channel;            // multiplexer_0:out_channel -> multiplexer_adapter:in_channel
	wire          tx_fifo_p0_out_endofpacket;           // tx_fifo_p0:avalonst_source_endofpacket -> tx_fifo_p0_adapter:in_endofpacket
	wire          tx_fifo_p0_out_valid;                 // tx_fifo_p0:avalonst_source_valid -> tx_fifo_p0_adapter:in_valid
	wire          tx_fifo_p0_out_startofpacket;         // tx_fifo_p0:avalonst_source_startofpacket -> tx_fifo_p0_adapter:in_startofpacket
	wire          tx_fifo_p0_out_error;                 // tx_fifo_p0:avalonst_source_error -> tx_fifo_p0_adapter:in_error
	wire    [1:0] tx_fifo_p0_out_empty;                 // tx_fifo_p0:avalonst_source_empty -> tx_fifo_p0_adapter:in_empty
	wire  [127:0] tx_fifo_p0_out_data;                  // tx_fifo_p0:avalonst_source_data -> tx_fifo_p0_adapter:in_data
	wire          tx_fifo_p0_out_ready;                 // tx_fifo_p0_adapter:in_ready -> tx_fifo_p0:avalonst_source_ready
	wire          tx_fifo_p0_adapter_out_endofpacket;   // tx_fifo_p0_adapter:out_endofpacket -> multiplexer_0:in0_endofpacket
	wire          tx_fifo_p0_adapter_out_valid;         // tx_fifo_p0_adapter:out_valid -> multiplexer_0:in0_valid
	wire          tx_fifo_p0_adapter_out_startofpacket; // tx_fifo_p0_adapter:out_startofpacket -> multiplexer_0:in0_startofpacket
	wire          tx_fifo_p0_adapter_out_error;         // tx_fifo_p0_adapter:out_error -> multiplexer_0:in0_error
	wire    [1:0] tx_fifo_p0_adapter_out_empty;         // tx_fifo_p0_adapter:out_empty -> multiplexer_0:in0_empty
	wire  [127:0] tx_fifo_p0_adapter_out_data;          // tx_fifo_p0_adapter:out_data -> multiplexer_0:in0_data
	wire          tx_fifo_p0_adapter_out_ready;         // multiplexer_0:in0_ready -> tx_fifo_p0_adapter:out_ready
	wire          tx_fifo_p1_out_endofpacket;           // tx_fifo_p1:avalonst_source_endofpacket -> tx_fifo_p1_adapter:in_endofpacket
	wire          tx_fifo_p1_out_valid;                 // tx_fifo_p1:avalonst_source_valid -> tx_fifo_p1_adapter:in_valid
	wire          tx_fifo_p1_out_startofpacket;         // tx_fifo_p1:avalonst_source_startofpacket -> tx_fifo_p1_adapter:in_startofpacket
	wire          tx_fifo_p1_out_error;                 // tx_fifo_p1:avalonst_source_error -> tx_fifo_p1_adapter:in_error
	wire    [1:0] tx_fifo_p1_out_empty;                 // tx_fifo_p1:avalonst_source_empty -> tx_fifo_p1_adapter:in_empty
	wire  [127:0] tx_fifo_p1_out_data;                  // tx_fifo_p1:avalonst_source_data -> tx_fifo_p1_adapter:in_data
	wire          tx_fifo_p1_out_ready;                 // tx_fifo_p1_adapter:in_ready -> tx_fifo_p1:avalonst_source_ready
	wire          tx_fifo_p1_adapter_out_endofpacket;   // tx_fifo_p1_adapter:out_endofpacket -> multiplexer_0:in1_endofpacket
	wire          tx_fifo_p1_adapter_out_valid;         // tx_fifo_p1_adapter:out_valid -> multiplexer_0:in1_valid
	wire          tx_fifo_p1_adapter_out_startofpacket; // tx_fifo_p1_adapter:out_startofpacket -> multiplexer_0:in1_startofpacket
	wire          tx_fifo_p1_adapter_out_error;         // tx_fifo_p1_adapter:out_error -> multiplexer_0:in1_error
	wire    [1:0] tx_fifo_p1_adapter_out_empty;         // tx_fifo_p1_adapter:out_empty -> multiplexer_0:in1_empty
	wire  [127:0] tx_fifo_p1_adapter_out_data;          // tx_fifo_p1_adapter:out_data -> multiplexer_0:in1_data
	wire          tx_fifo_p1_adapter_out_ready;         // multiplexer_0:in1_ready -> tx_fifo_p1_adapter:out_ready
	wire          rst_controller_reset_out_reset;       // rst_controller:reset_out -> [demultiplexer_0:reset_n, multiplexer_0:reset_n, multiplexer_adapter:reset_n, tx_fifo_p0:reset_n, tx_fifo_p0_adapter:reset_n, tx_fifo_p1:reset_n, tx_fifo_p1_adapter:reset_n]

	sonic_vc_multiplexer_0 multiplexer_0 (
		.clk               (clk_clk),                              //   clk.clk
		.reset_n           (~rst_controller_reset_out_reset),      // reset.reset_n
		.in0_valid         (tx_fifo_p0_adapter_out_valid),         //   in0.valid
		.in0_ready         (tx_fifo_p0_adapter_out_ready),         //      .ready
		.in0_data          (tx_fifo_p0_adapter_out_data),          //      .data
		.in0_error         (tx_fifo_p0_adapter_out_error),         //      .error
		.in0_startofpacket (tx_fifo_p0_adapter_out_startofpacket), //      .startofpacket
		.in0_endofpacket   (tx_fifo_p0_adapter_out_endofpacket),   //      .endofpacket
		.in0_empty         (tx_fifo_p0_adapter_out_empty),         //      .empty
		.in1_valid         (tx_fifo_p1_adapter_out_valid),         //   in1.valid
		.in1_ready         (tx_fifo_p1_adapter_out_ready),         //      .ready
		.in1_data          (tx_fifo_p1_adapter_out_data),          //      .data
		.in1_error         (tx_fifo_p1_adapter_out_error),         //      .error
		.in1_startofpacket (tx_fifo_p1_adapter_out_startofpacket), //      .startofpacket
		.in1_endofpacket   (tx_fifo_p1_adapter_out_endofpacket),   //      .endofpacket
		.in1_empty         (tx_fifo_p1_adapter_out_empty),         //      .empty
		.out_channel       (multiplexer_0_out_channel),            //   out.channel
		.out_valid         (multiplexer_0_out_valid),              //      .valid
		.out_ready         (multiplexer_0_out_ready),              //      .ready
		.out_data          (multiplexer_0_out_data),               //      .data
		.out_error         (multiplexer_0_out_error),              //      .error
		.out_startofpacket (multiplexer_0_out_startofpacket),      //      .startofpacket
		.out_endofpacket   (multiplexer_0_out_endofpacket),        //      .endofpacket
		.out_empty         (multiplexer_0_out_empty)               //      .empty
	);

	sonic_vc_demultiplexer_0 demultiplexer_0 (
		.clk                (clk_clk),                         //   clk.clk
		.reset_n            (~rst_controller_reset_out_reset), // reset.reset_n
		.in_channel         (rx_vc_in_channel),                //    in.channel
		.in_valid           (rx_vc_in_valid),                  //      .valid
		.in_ready           (rx_vc_in_ready),                  //      .ready
		.in_data            (rx_vc_in_data),                   //      .data
		.in_startofpacket   (rx_vc_in_startofpacket),          //      .startofpacket
		.in_endofpacket     (rx_vc_in_endofpacket),            //      .endofpacket
		.in_empty           (rx_vc_in_empty),                  //      .empty
		.out0_valid         (rx_vc_out0_valid),                //  out0.valid
		.out0_ready         (rx_vc_out0_ready),                //      .ready
		.out0_data          (rx_vc_out0_data),                 //      .data
		.out0_startofpacket (rx_vc_out0_startofpacket),        //      .startofpacket
		.out0_endofpacket   (rx_vc_out0_endofpacket),          //      .endofpacket
		.out0_empty         (rx_vc_out0_empty),                //      .empty
		.out1_valid         (rx_vc_out1_valid),                //  out1.valid
		.out1_ready         (rx_vc_out1_ready),                //      .ready
		.out1_data          (rx_vc_out1_data),                 //      .data
		.out1_startofpacket (rx_vc_out1_startofpacket),        //      .startofpacket
		.out1_endofpacket   (rx_vc_out1_endofpacket),          //      .endofpacket
		.out1_empty         (rx_vc_out1_empty)                 //      .empty
	);

	sonic_vc_tx_fifo_p0 tx_fifo_p0 (
		.wrclock                       (clk_clk),                         //   clk_in.clk
		.reset_n                       (~rst_controller_reset_out_reset), // reset_in.reset_n
		.avalonst_sink_valid           (tx_vc_in0_valid),                 //       in.valid
		.avalonst_sink_data            (tx_vc_in0_data),                  //         .data
		.avalonst_sink_error           (tx_vc_in0_error),                 //         .error
		.avalonst_sink_startofpacket   (tx_vc_in0_startofpacket),         //         .startofpacket
		.avalonst_sink_endofpacket     (tx_vc_in0_endofpacket),           //         .endofpacket
		.avalonst_sink_empty           (tx_vc_in0_empty),                 //         .empty
		.avalonst_sink_ready           (tx_vc_in0_ready),                 //         .ready
		.avalonst_source_valid         (tx_fifo_p0_out_valid),            //      out.valid
		.avalonst_source_data          (tx_fifo_p0_out_data),             //         .data
		.avalonst_source_error         (tx_fifo_p0_out_error),            //         .error
		.avalonst_source_startofpacket (tx_fifo_p0_out_startofpacket),    //         .startofpacket
		.avalonst_source_endofpacket   (tx_fifo_p0_out_endofpacket),      //         .endofpacket
		.avalonst_source_empty         (tx_fifo_p0_out_empty),            //         .empty
		.avalonst_source_ready         (tx_fifo_p0_out_ready)             //         .ready
	);

	sonic_vc_tx_fifo_p1 tx_fifo_p1 (
		.wrclock                       (clk_clk),                         //   clk_in.clk
		.reset_n                       (~rst_controller_reset_out_reset), // reset_in.reset_n
		.avalonst_sink_valid           (tx_vc_in1_valid),                 //       in.valid
		.avalonst_sink_data            (tx_vc_in1_data),                  //         .data
		.avalonst_sink_error           (tx_vc_in1_error),                 //         .error
		.avalonst_sink_startofpacket   (tx_vc_in1_startofpacket),         //         .startofpacket
		.avalonst_sink_endofpacket     (tx_vc_in1_endofpacket),           //         .endofpacket
		.avalonst_sink_empty           (tx_vc_in1_empty),                 //         .empty
		.avalonst_sink_ready           (tx_vc_in1_ready),                 //         .ready
		.avalonst_source_valid         (tx_fifo_p1_out_valid),            //      out.valid
		.avalonst_source_data          (tx_fifo_p1_out_data),             //         .data
		.avalonst_source_error         (tx_fifo_p1_out_error),            //         .error
		.avalonst_source_startofpacket (tx_fifo_p1_out_startofpacket),    //         .startofpacket
		.avalonst_source_endofpacket   (tx_fifo_p1_out_endofpacket),      //         .endofpacket
		.avalonst_source_empty         (tx_fifo_p1_out_empty),            //         .empty
		.avalonst_source_ready         (tx_fifo_p1_out_ready)             //         .ready
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

	sonic_vc_tx_fifo_p0_adapter tx_fifo_p0_adapter (
		.clk               (clk_clk),                              //   clk.clk
		.reset_n           (~rst_controller_reset_out_reset),      // reset.reset_n
		.in_ready          (tx_fifo_p0_out_ready),                 //    in.ready
		.in_valid          (tx_fifo_p0_out_valid),                 //      .valid
		.in_data           (tx_fifo_p0_out_data),                  //      .data
		.in_error          (tx_fifo_p0_out_error),                 //      .error
		.in_startofpacket  (tx_fifo_p0_out_startofpacket),         //      .startofpacket
		.in_endofpacket    (tx_fifo_p0_out_endofpacket),           //      .endofpacket
		.in_empty          (tx_fifo_p0_out_empty),                 //      .empty
		.out_ready         (tx_fifo_p0_adapter_out_ready),         //   out.ready
		.out_valid         (tx_fifo_p0_adapter_out_valid),         //      .valid
		.out_data          (tx_fifo_p0_adapter_out_data),          //      .data
		.out_error         (tx_fifo_p0_adapter_out_error),         //      .error
		.out_startofpacket (tx_fifo_p0_adapter_out_startofpacket), //      .startofpacket
		.out_endofpacket   (tx_fifo_p0_adapter_out_endofpacket),   //      .endofpacket
		.out_empty         (tx_fifo_p0_adapter_out_empty)          //      .empty
	);

	sonic_vc_tx_fifo_p0_adapter tx_fifo_p1_adapter (
		.clk               (clk_clk),                              //   clk.clk
		.reset_n           (~rst_controller_reset_out_reset),      // reset.reset_n
		.in_ready          (tx_fifo_p1_out_ready),                 //    in.ready
		.in_valid          (tx_fifo_p1_out_valid),                 //      .valid
		.in_data           (tx_fifo_p1_out_data),                  //      .data
		.in_error          (tx_fifo_p1_out_error),                 //      .error
		.in_startofpacket  (tx_fifo_p1_out_startofpacket),         //      .startofpacket
		.in_endofpacket    (tx_fifo_p1_out_endofpacket),           //      .endofpacket
		.in_empty          (tx_fifo_p1_out_empty),                 //      .empty
		.out_ready         (tx_fifo_p1_adapter_out_ready),         //   out.ready
		.out_valid         (tx_fifo_p1_adapter_out_valid),         //      .valid
		.out_data          (tx_fifo_p1_adapter_out_data),          //      .data
		.out_error         (tx_fifo_p1_adapter_out_error),         //      .error
		.out_startofpacket (tx_fifo_p1_adapter_out_startofpacket), //      .startofpacket
		.out_endofpacket   (tx_fifo_p1_adapter_out_endofpacket),   //      .endofpacket
		.out_empty         (tx_fifo_p1_adapter_out_empty)          //      .empty
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