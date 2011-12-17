// sonic_rp_ep_sim_tb_sonic_rp_ep_sim_inst.v


`timescale 1 ps / 1 ps
module sonic_rp_ep_sim_tb_sonic_rp_ep_sim_inst (
		input  wire        reset_0_reset_n,      //         reset_0.reset_n
		output wire [39:0] xcvr_tx_datain_data,  //  xcvr_tx_datain.data
		input  wire        reset_reset_n,        //           reset.reset_n
		input  wire [39:0] xcvr_rx_dataout_data, // xcvr_rx_dataout.data
		input  wire        clk_clk,              //             clk.clk
		input  wire        clk_0_clk             //           clk_0.clk
	);

	wire    rst_controller_reset_out_reset; // rst_controller:reset_out -> sonic_rp_ep_top_0:rstn

	sonic_fast_sim_top sonic_rp_ep_top_0 (
		.pld_clk         (clk_clk),                         //    pld_clk.clk
		.rstn            (~rst_controller_reset_out_reset), //       rstn.reset_n
		.xcvr_rx_clkout  (clk_0_clk),                       //  rx_clkout.clk
		.xcvr_tx_clkout  (clk_0_clk),                       //  tx_clkout.clk
		.xcvr_tx_datain  (xcvr_tx_datain_data),             //  tx_datain.data
		.xcvr_rx_dataout (xcvr_rx_dataout_data)             // rx_dataout.data
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
