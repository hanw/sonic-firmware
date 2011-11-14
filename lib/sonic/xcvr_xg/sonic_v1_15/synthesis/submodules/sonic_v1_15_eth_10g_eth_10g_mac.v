// sonic_v1_15_eth_10g_eth_10g_mac.v

// This file was auto-generated from altera_eth_10g_mac_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using SOPC Builder version 11.0 157 at 2011.07.26.17:41:08

`timescale 1 ps / 1 ps
module sonic_v1_15_eth_10g_eth_10g_mac (
		input  wire        csr_clk_clk,                     //                    csr_clk.clk
		input  wire        csr_reset_reset_n,               //                  csr_reset.reset_n
		input  wire [12:0] csr_address,                     //                        csr.address
		output wire        csr_waitrequest,                 //                           .waitrequest
		input  wire        csr_read,                        //                           .read
		output wire [31:0] csr_readdata,                    //                           .readdata
		input  wire        csr_write,                       //                           .write
		input  wire [31:0] csr_writedata,                   //                           .writedata
		input  wire        tx_clk_clk,                      //                     tx_clk.clk
		input  wire        tx_reset_reset_n,                //                   tx_reset.reset_n
		input  wire        avalon_st_tx_startofpacket,      //               avalon_st_tx.startofpacket
		input  wire        avalon_st_tx_valid,              //                           .valid
		input  wire [63:0] avalon_st_tx_data,               //                           .data
		input  wire [2:0]  avalon_st_tx_empty,              //                           .empty
		output wire        avalon_st_tx_ready,              //                           .ready
		input  wire        avalon_st_tx_error,              //                           .error
		input  wire        avalon_st_tx_endofpacket,        //                           .endofpacket
		input  wire [1:0]  avalon_st_pause_data,            //            avalon_st_pause.data
		output wire [71:0] xgmii_tx_data,                   //                   xgmii_tx.data
		output wire        avalon_st_txstatus_valid,        //         avalon_st_txstatus.valid
		output wire [39:0] avalon_st_txstatus_data,         //                           .data
		output wire [6:0]  avalon_st_txstatus_error,        //                           .error
		input  wire        rx_clk_clk,                      //                     rx_clk.clk
		input  wire        rx_reset_reset_n,                //                   rx_reset.reset_n
		input  wire [71:0] xgmii_rx_data,                   //                   xgmii_rx.data
		output wire        avalon_st_rx_startofpacket,      //               avalon_st_rx.startofpacket
		output wire        avalon_st_rx_endofpacket,        //                           .endofpacket
		output wire        avalon_st_rx_valid,              //                           .valid
		input  wire        avalon_st_rx_ready,              //                           .ready
		output wire [63:0] avalon_st_rx_data,               //                           .data
		output wire [2:0]  avalon_st_rx_empty,              //                           .empty
		output wire [5:0]  avalon_st_rx_error,              //                           .error
		output wire        avalon_st_rxstatus_valid,        //         avalon_st_rxstatus.valid
		output wire [39:0] avalon_st_rxstatus_data,         //                           .data
		output wire [6:0]  avalon_st_rxstatus_error,        //                           .error
		output wire [1:0]  link_fault_status_xgmii_rx_data  // link_fault_status_xgmii_rx.data
	);

	wire         tx_eth_packet_underflow_control_avalon_streaming_source_endofpacket;                                                 // tx_eth_packet_underflow_control:data_src_eop -> tx_eth_pad_inserter:data_sink_eop
	wire         tx_eth_packet_underflow_control_avalon_streaming_source_valid;                                                       // tx_eth_packet_underflow_control:data_src_valid -> tx_eth_pad_inserter:data_sink_valid
	wire         tx_eth_packet_underflow_control_avalon_streaming_source_startofpacket;                                               // tx_eth_packet_underflow_control:data_src_sop -> tx_eth_pad_inserter:data_sink_sop
	wire   [1:0] tx_eth_packet_underflow_control_avalon_streaming_source_error;                                                       // tx_eth_packet_underflow_control:data_src_error -> tx_eth_pad_inserter:data_sink_error
	wire   [2:0] tx_eth_packet_underflow_control_avalon_streaming_source_empty;                                                       // tx_eth_packet_underflow_control:data_src_empty -> tx_eth_pad_inserter:data_sink_empty
	wire  [63:0] tx_eth_packet_underflow_control_avalon_streaming_source_data;                                                        // tx_eth_packet_underflow_control:data_src_data -> tx_eth_pad_inserter:data_sink_data
	wire         tx_eth_packet_underflow_control_avalon_streaming_source_ready;                                                       // tx_eth_pad_inserter:data_sink_ready -> tx_eth_packet_underflow_control:data_src_ready
	wire         tx_eth_pause_beat_conversion_pause_beat_src_valid;                                                                   // tx_eth_pause_beat_conversion:pause_beat_src_valid -> tx_eth_pkt_backpressure_control:pausebeats_sink_valid
	wire  [31:0] tx_eth_pause_beat_conversion_pause_beat_src_data;                                                                    // tx_eth_pause_beat_conversion:pause_beat_src_data -> tx_eth_pkt_backpressure_control:pausebeats_sink_data
	wire         tx_eth_pad_inserter_avalon_st_source_data_endofpacket;                                                               // tx_eth_pad_inserter:data_src_eop -> tx_eth_pkt_backpressure_control:data_sink_eop
	wire         tx_eth_pad_inserter_avalon_st_source_data_valid;                                                                     // tx_eth_pad_inserter:data_src_valid -> tx_eth_pkt_backpressure_control:data_sink_valid
	wire         tx_eth_pad_inserter_avalon_st_source_data_startofpacket;                                                             // tx_eth_pad_inserter:data_src_sop -> tx_eth_pkt_backpressure_control:data_sink_sop
	wire   [1:0] tx_eth_pad_inserter_avalon_st_source_data_error;                                                                     // tx_eth_pad_inserter:data_src_error -> tx_eth_pkt_backpressure_control:data_sink_error
	wire   [2:0] tx_eth_pad_inserter_avalon_st_source_data_empty;                                                                     // tx_eth_pad_inserter:data_src_empty -> tx_eth_pkt_backpressure_control:data_sink_empty
	wire  [63:0] tx_eth_pad_inserter_avalon_st_source_data_data;                                                                      // tx_eth_pad_inserter:data_src_data -> tx_eth_pkt_backpressure_control:data_sink_data
	wire         tx_eth_pad_inserter_avalon_st_source_data_ready;                                                                     // tx_eth_pkt_backpressure_control:data_sink_ready -> tx_eth_pad_inserter:data_src_ready
	wire         tx_eth_pause_ctrl_gen_pause_packet_endofpacket;                                                                      // tx_eth_pause_ctrl_gen:pause_source_eop -> tx_st_pause_ctrl_error_adapter:in_endofpacket
	wire         tx_eth_pause_ctrl_gen_pause_packet_valid;                                                                            // tx_eth_pause_ctrl_gen:pause_source_valid -> tx_st_pause_ctrl_error_adapter:in_valid
	wire         tx_eth_pause_ctrl_gen_pause_packet_startofpacket;                                                                    // tx_eth_pause_ctrl_gen:pause_source_sop -> tx_st_pause_ctrl_error_adapter:in_startofpacket
	wire         tx_eth_pause_ctrl_gen_pause_packet_error;                                                                            // tx_eth_pause_ctrl_gen:pause_source_error -> tx_st_pause_ctrl_error_adapter:in_error
	wire   [2:0] tx_eth_pause_ctrl_gen_pause_packet_empty;                                                                            // tx_eth_pause_ctrl_gen:pause_source_empty -> tx_st_pause_ctrl_error_adapter:in_empty
	wire  [63:0] tx_eth_pause_ctrl_gen_pause_packet_data;                                                                             // tx_eth_pause_ctrl_gen:pause_source_data -> tx_st_pause_ctrl_error_adapter:in_data
	wire         tx_eth_pause_ctrl_gen_pause_packet_ready;                                                                            // tx_st_pause_ctrl_error_adapter:in_ready -> tx_eth_pause_ctrl_gen:pause_source_ready
	wire         tx_eth_pkt_backpressure_control_avalon_st_source_data_endofpacket;                                                   // tx_eth_pkt_backpressure_control:data_src_eop -> tx_st_mux_flow_control_user_frame:in0_endofpacket
	wire         tx_eth_pkt_backpressure_control_avalon_st_source_data_valid;                                                         // tx_eth_pkt_backpressure_control:data_src_valid -> tx_st_mux_flow_control_user_frame:in0_valid
	wire         tx_eth_pkt_backpressure_control_avalon_st_source_data_startofpacket;                                                 // tx_eth_pkt_backpressure_control:data_src_sop -> tx_st_mux_flow_control_user_frame:in0_startofpacket
	wire   [1:0] tx_eth_pkt_backpressure_control_avalon_st_source_data_error;                                                         // tx_eth_pkt_backpressure_control:data_src_error -> tx_st_mux_flow_control_user_frame:in0_error
	wire   [2:0] tx_eth_pkt_backpressure_control_avalon_st_source_data_empty;                                                         // tx_eth_pkt_backpressure_control:data_src_empty -> tx_st_mux_flow_control_user_frame:in0_empty
	wire  [63:0] tx_eth_pkt_backpressure_control_avalon_st_source_data_data;                                                          // tx_eth_pkt_backpressure_control:data_src_data -> tx_st_mux_flow_control_user_frame:in0_data
	wire         tx_eth_pkt_backpressure_control_avalon_st_source_data_ready;                                                         // tx_st_mux_flow_control_user_frame:in0_ready -> tx_eth_pkt_backpressure_control:data_src_ready
	wire         tx_st_pause_ctrl_error_adapter_out_endofpacket;                                                                      // tx_st_pause_ctrl_error_adapter:out_endofpacket -> tx_st_mux_flow_control_user_frame:in1_endofpacket
	wire         tx_st_pause_ctrl_error_adapter_out_valid;                                                                            // tx_st_pause_ctrl_error_adapter:out_valid -> tx_st_mux_flow_control_user_frame:in1_valid
	wire         tx_st_pause_ctrl_error_adapter_out_startofpacket;                                                                    // tx_st_pause_ctrl_error_adapter:out_startofpacket -> tx_st_mux_flow_control_user_frame:in1_startofpacket
	wire   [1:0] tx_st_pause_ctrl_error_adapter_out_error;                                                                            // tx_st_pause_ctrl_error_adapter:out_error -> tx_st_mux_flow_control_user_frame:in1_error
	wire   [2:0] tx_st_pause_ctrl_error_adapter_out_empty;                                                                            // tx_st_pause_ctrl_error_adapter:out_empty -> tx_st_mux_flow_control_user_frame:in1_empty
	wire  [63:0] tx_st_pause_ctrl_error_adapter_out_data;                                                                             // tx_st_pause_ctrl_error_adapter:out_data -> tx_st_mux_flow_control_user_frame:in1_data
	wire         tx_st_pause_ctrl_error_adapter_out_ready;                                                                            // tx_st_mux_flow_control_user_frame:in1_ready -> tx_st_pause_ctrl_error_adapter:out_ready
	wire         tx_st_mux_flow_control_user_frame_out_endofpacket;                                                                   // tx_st_mux_flow_control_user_frame:out_endofpacket -> tx_eth_address_inserter:data_sink_eop
	wire         tx_st_mux_flow_control_user_frame_out_valid;                                                                         // tx_st_mux_flow_control_user_frame:out_valid -> tx_eth_address_inserter:data_sink_valid
	wire         tx_st_mux_flow_control_user_frame_out_startofpacket;                                                                 // tx_st_mux_flow_control_user_frame:out_startofpacket -> tx_eth_address_inserter:data_sink_sop
	wire   [1:0] tx_st_mux_flow_control_user_frame_out_error;                                                                         // tx_st_mux_flow_control_user_frame:out_error -> tx_eth_address_inserter:data_sink_error
	wire   [2:0] tx_st_mux_flow_control_user_frame_out_empty;                                                                         // tx_st_mux_flow_control_user_frame:out_empty -> tx_eth_address_inserter:data_sink_empty
	wire  [63:0] tx_st_mux_flow_control_user_frame_out_data;                                                                          // tx_st_mux_flow_control_user_frame:out_data -> tx_eth_address_inserter:data_sink_data
	wire         tx_st_mux_flow_control_user_frame_out_ready;                                                                         // tx_eth_address_inserter:data_sink_ready -> tx_st_mux_flow_control_user_frame:out_ready
	wire         tx_eth_address_inserter_avalon_streaming_source_endofpacket;                                                         // tx_eth_address_inserter:data_src_eop -> tx_eth_crc_inserter:data_sink_eop
	wire         tx_eth_address_inserter_avalon_streaming_source_valid;                                                               // tx_eth_address_inserter:data_src_valid -> tx_eth_crc_inserter:data_sink_valid
	wire         tx_eth_address_inserter_avalon_streaming_source_startofpacket;                                                       // tx_eth_address_inserter:data_src_sop -> tx_eth_crc_inserter:data_sink_sop
	wire   [1:0] tx_eth_address_inserter_avalon_streaming_source_error;                                                               // tx_eth_address_inserter:data_src_error -> tx_eth_crc_inserter:data_sink_error
	wire   [2:0] tx_eth_address_inserter_avalon_streaming_source_empty;                                                               // tx_eth_address_inserter:data_src_empty -> tx_eth_crc_inserter:data_sink_empty
	wire  [63:0] tx_eth_address_inserter_avalon_streaming_source_data;                                                                // tx_eth_address_inserter:data_src_data -> tx_eth_crc_inserter:data_sink_data
	wire         tx_eth_address_inserter_avalon_streaming_source_ready;                                                               // tx_eth_crc_inserter:data_sink_ready -> tx_eth_address_inserter:data_src_ready
	wire         tx_eth_crc_inserter_avalon_streaming_source_endofpacket;                                                             // tx_eth_crc_inserter:data_src_eop -> tx_st_pipeline_stage_rs:in_endofpacket
	wire         tx_eth_crc_inserter_avalon_streaming_source_valid;                                                                   // tx_eth_crc_inserter:data_src_valid -> tx_st_pipeline_stage_rs:in_valid
	wire         tx_eth_crc_inserter_avalon_streaming_source_startofpacket;                                                           // tx_eth_crc_inserter:data_src_sop -> tx_st_pipeline_stage_rs:in_startofpacket
	wire   [2:0] tx_eth_crc_inserter_avalon_streaming_source_error;                                                                   // tx_eth_crc_inserter:data_src_error -> tx_st_pipeline_stage_rs:in_error
	wire   [2:0] tx_eth_crc_inserter_avalon_streaming_source_empty;                                                                   // tx_eth_crc_inserter:data_src_empty -> tx_st_pipeline_stage_rs:in_empty
	wire  [63:0] tx_eth_crc_inserter_avalon_streaming_source_data;                                                                    // tx_eth_crc_inserter:data_src_data -> tx_st_pipeline_stage_rs:in_data
	wire         tx_eth_crc_inserter_avalon_streaming_source_ready;                                                                   // tx_st_pipeline_stage_rs:in_ready -> tx_eth_crc_inserter:data_src_ready
	wire         tx_st_pipeline_stage_rs_source0_endofpacket;                                                                         // tx_st_pipeline_stage_rs:out_endofpacket -> tx_st_splitter_1:in0_endofpacket
	wire         tx_st_pipeline_stage_rs_source0_valid;                                                                               // tx_st_pipeline_stage_rs:out_valid -> tx_st_splitter_1:in0_valid
	wire         tx_st_pipeline_stage_rs_source0_startofpacket;                                                                       // tx_st_pipeline_stage_rs:out_startofpacket -> tx_st_splitter_1:in0_startofpacket
	wire   [2:0] tx_st_pipeline_stage_rs_source0_error;                                                                               // tx_st_pipeline_stage_rs:out_error -> tx_st_splitter_1:in0_error
	wire  [63:0] tx_st_pipeline_stage_rs_source0_data;                                                                                // tx_st_pipeline_stage_rs:out_data -> tx_st_splitter_1:in0_data
	wire   [2:0] tx_st_pipeline_stage_rs_source0_empty;                                                                               // tx_st_pipeline_stage_rs:out_empty -> tx_st_splitter_1:in0_empty
	wire         tx_st_pipeline_stage_rs_source0_ready;                                                                               // tx_st_splitter_1:in0_ready -> tx_st_pipeline_stage_rs:out_ready
	wire         tx_st_splitter_1_out0_endofpacket;                                                                                   // tx_st_splitter_1:out0_endofpacket -> tx_st_timing_adapter_frame_decoder:in_endofpacket
	wire         tx_st_splitter_1_out0_valid;                                                                                         // tx_st_splitter_1:out0_valid -> tx_st_timing_adapter_frame_decoder:in_valid
	wire         tx_st_splitter_1_out0_startofpacket;                                                                                 // tx_st_splitter_1:out0_startofpacket -> tx_st_timing_adapter_frame_decoder:in_startofpacket
	wire   [2:0] tx_st_splitter_1_out0_error;                                                                                         // tx_st_splitter_1:out0_error -> tx_st_timing_adapter_frame_decoder:in_error
	wire  [63:0] tx_st_splitter_1_out0_data;                                                                                          // tx_st_splitter_1:out0_data -> tx_st_timing_adapter_frame_decoder:in_data
	wire   [2:0] tx_st_splitter_1_out0_empty;                                                                                         // tx_st_splitter_1:out0_empty -> tx_st_timing_adapter_frame_decoder:in_empty
	wire         tx_st_splitter_1_out0_ready;                                                                                         // tx_st_timing_adapter_frame_decoder:in_ready -> tx_st_splitter_1:out0_ready
	wire         tx_st_splitter_1_out1_endofpacket;                                                                                   // tx_st_splitter_1:out1_endofpacket -> tx_eth_packet_formatter:data_sink_eop
	wire         tx_st_splitter_1_out1_valid;                                                                                         // tx_st_splitter_1:out1_valid -> tx_eth_packet_formatter:data_sink_valid
	wire         tx_st_splitter_1_out1_startofpacket;                                                                                 // tx_st_splitter_1:out1_startofpacket -> tx_eth_packet_formatter:data_sink_sop
	wire   [2:0] tx_st_splitter_1_out1_error;                                                                                         // tx_st_splitter_1:out1_error -> tx_eth_packet_formatter:data_sink_error
	wire  [63:0] tx_st_splitter_1_out1_data;                                                                                          // tx_st_splitter_1:out1_data -> tx_eth_packet_formatter:data_sink_data
	wire   [2:0] tx_st_splitter_1_out1_empty;                                                                                         // tx_st_splitter_1:out1_empty -> tx_eth_packet_formatter:data_sink_empty
	wire         tx_st_splitter_1_out1_ready;                                                                                         // tx_eth_packet_formatter:data_sink_ready -> tx_st_splitter_1:out1_ready
	wire         tx_st_timing_adapter_frame_decoder_out_endofpacket;                                                                  // tx_st_timing_adapter_frame_decoder:out_endofpacket -> tx_eth_frame_decoder:data_sink_eop
	wire         tx_st_timing_adapter_frame_decoder_out_valid;                                                                        // tx_st_timing_adapter_frame_decoder:out_valid -> tx_eth_frame_decoder:data_sink_valid
	wire         tx_st_timing_adapter_frame_decoder_out_startofpacket;                                                                // tx_st_timing_adapter_frame_decoder:out_startofpacket -> tx_eth_frame_decoder:data_sink_sop
	wire   [2:0] tx_st_timing_adapter_frame_decoder_out_error;                                                                        // tx_st_timing_adapter_frame_decoder:out_error -> tx_eth_frame_decoder:data_sink_error
	wire   [2:0] tx_st_timing_adapter_frame_decoder_out_empty;                                                                        // tx_st_timing_adapter_frame_decoder:out_empty -> tx_eth_frame_decoder:data_sink_empty
	wire  [63:0] tx_st_timing_adapter_frame_decoder_out_data;                                                                         // tx_st_timing_adapter_frame_decoder:out_data -> tx_eth_frame_decoder:data_sink_data
	wire         tx_eth_frame_decoder_avalon_st_rxstatus_src_valid;                                                                   // tx_eth_frame_decoder:rxstatus_src_valid -> tx_st_error_adapter_stat:in_valid
	wire   [5:0] tx_eth_frame_decoder_avalon_st_rxstatus_src_error;                                                                   // tx_eth_frame_decoder:rxstatus_src_error -> tx_st_error_adapter_stat:in_error
	wire  [39:0] tx_eth_frame_decoder_avalon_st_rxstatus_src_data;                                                                    // tx_eth_frame_decoder:rxstatus_src_data -> tx_st_error_adapter_stat:in_data
	wire         tx_st_error_adapter_stat_out_valid;                                                                                  // tx_st_error_adapter_stat:out_valid -> tx_st_timing_adapter_splitter_status_in:in_valid
	wire   [6:0] tx_st_error_adapter_stat_out_error;                                                                                  // tx_st_error_adapter_stat:out_error -> tx_st_timing_adapter_splitter_status_in:in_error
	wire  [39:0] tx_st_error_adapter_stat_out_data;                                                                                   // tx_st_error_adapter_stat:out_data -> tx_st_timing_adapter_splitter_status_in:in_data
	wire         tx_st_timing_adapter_splitter_status_in_out_valid;                                                                   // tx_st_timing_adapter_splitter_status_in:out_valid -> tx_st_status_splitter:in0_valid
	wire   [6:0] tx_st_timing_adapter_splitter_status_in_out_error;                                                                   // tx_st_timing_adapter_splitter_status_in:out_error -> tx_st_status_splitter:in0_error
	wire  [39:0] tx_st_timing_adapter_splitter_status_in_out_data;                                                                    // tx_st_timing_adapter_splitter_status_in:out_data -> tx_st_status_splitter:in0_data
	wire         tx_st_timing_adapter_splitter_status_in_out_ready;                                                                   // tx_st_status_splitter:in0_ready -> tx_st_timing_adapter_splitter_status_in:out_ready
	wire         tx_st_status_splitter_out0_valid;                                                                                    // tx_st_status_splitter:out0_valid -> tx_st_timing_adapter_splitter_status_statistics:in_valid
	wire   [6:0] tx_st_status_splitter_out0_error;                                                                                    // tx_st_status_splitter:out0_error -> tx_st_timing_adapter_splitter_status_statistics:in_error
	wire  [39:0] tx_st_status_splitter_out0_data;                                                                                     // tx_st_status_splitter:out0_data -> tx_st_timing_adapter_splitter_status_statistics:in_data
	wire         tx_st_status_splitter_out0_ready;                                                                                    // tx_st_timing_adapter_splitter_status_statistics:in_ready -> tx_st_status_splitter:out0_ready
	wire         tx_st_timing_adapter_splitter_status_statistics_out_valid;                                                           // tx_st_timing_adapter_splitter_status_statistics:out_valid -> tx_eth_statistics_collector:stat_sink_valid
	wire   [6:0] tx_st_timing_adapter_splitter_status_statistics_out_error;                                                           // tx_st_timing_adapter_splitter_status_statistics:out_error -> tx_eth_statistics_collector:stat_sink_error
	wire  [39:0] tx_st_timing_adapter_splitter_status_statistics_out_data;                                                            // tx_st_timing_adapter_splitter_status_statistics:out_data -> tx_eth_statistics_collector:stat_sink_data
	wire         tx_st_status_splitter_out1_valid;                                                                                    // tx_st_status_splitter:out1_valid -> tx_st_timing_adapter_splitter_status_output:in_valid
	wire   [6:0] tx_st_status_splitter_out1_error;                                                                                    // tx_st_status_splitter:out1_error -> tx_st_timing_adapter_splitter_status_output:in_error
	wire  [39:0] tx_st_status_splitter_out1_data;                                                                                     // tx_st_status_splitter:out1_data -> tx_st_timing_adapter_splitter_status_output:in_data
	wire         tx_st_status_splitter_out1_ready;                                                                                    // tx_st_timing_adapter_splitter_status_output:in_ready -> tx_st_status_splitter:out1_ready
	wire         tx_eth_packet_formatter_data_src_endofpacket;                                                                        // tx_eth_packet_formatter:data_src_eop -> tx_eth_xgmii_termination:data_sink_eop
	wire         tx_eth_packet_formatter_data_src_valid;                                                                              // tx_eth_packet_formatter:data_src_valid -> tx_eth_xgmii_termination:data_sink_valid
	wire         tx_eth_packet_formatter_data_src_startofpacket;                                                                      // tx_eth_packet_formatter:data_src_sop -> tx_eth_xgmii_termination:data_sink_sop
	wire   [2:0] tx_eth_packet_formatter_data_src_empty;                                                                              // tx_eth_packet_formatter:data_src_empty -> tx_eth_xgmii_termination:data_sink_empty
	wire  [71:0] tx_eth_packet_formatter_data_src_data;                                                                               // tx_eth_packet_formatter:data_src_data -> tx_eth_xgmii_termination:data_sink_data
	wire         tx_eth_packet_formatter_data_src_ready;                                                                              // tx_eth_xgmii_termination:data_sink_ready -> tx_eth_packet_formatter:data_src_ready
	wire  [71:0] tx_eth_xgmii_termination_avalon_streaming_source_data;                                                               // tx_eth_xgmii_termination:xgmii_src_data -> tx_eth_link_fault_generation:mii_sink_data
	wire         rx_st_timing_adapter_interface_conversion_out_valid;                                                                 // rx_st_timing_adapter_interface_conversion:out_valid -> rx_st_splitter_xgmii:in0_valid
	wire  [71:0] rx_st_timing_adapter_interface_conversion_out_data;                                                                  // rx_st_timing_adapter_interface_conversion:out_data -> rx_st_splitter_xgmii:in0_data
	wire         rx_st_timing_adapter_interface_conversion_out_ready;                                                                 // rx_st_splitter_xgmii:in0_ready -> rx_st_timing_adapter_interface_conversion:out_ready
	wire         rx_st_splitter_xgmii_out0_valid;                                                                                     // rx_st_splitter_xgmii:out0_valid -> rx_st_timing_adapter_lane_decoder:in_valid
	wire  [71:0] rx_st_splitter_xgmii_out0_data;                                                                                      // rx_st_splitter_xgmii:out0_data -> rx_st_timing_adapter_lane_decoder:in_data
	wire         rx_st_splitter_xgmii_out0_ready;                                                                                     // rx_st_timing_adapter_lane_decoder:in_ready -> rx_st_splitter_xgmii:out0_ready
	wire  [71:0] rx_st_timing_adapter_lane_decoder_out_data;                                                                          // rx_st_timing_adapter_lane_decoder:out_data -> rx_eth_lane_decoder:xgmii_sink_data
	wire         rx_st_splitter_xgmii_out1_valid;                                                                                     // rx_st_splitter_xgmii:out1_valid -> rx_st_timing_adapter_link_fault_detection:in_valid
	wire  [71:0] rx_st_splitter_xgmii_out1_data;                                                                                      // rx_st_splitter_xgmii:out1_data -> rx_st_timing_adapter_link_fault_detection:in_data
	wire         rx_st_splitter_xgmii_out1_ready;                                                                                     // rx_st_timing_adapter_link_fault_detection:in_ready -> rx_st_splitter_xgmii:out1_ready
	wire  [71:0] rx_st_timing_adapter_link_fault_detection_out_data;                                                                  // rx_st_timing_adapter_link_fault_detection:out_data -> rx_eth_link_fault_detection:mii_sink_data
	wire         rx_eth_pkt_backpressure_control_avalon_st_source_data_endofpacket;                                                   // rx_eth_pkt_backpressure_control:data_src_eop -> rx_st_timing_adapter_frame_status_in:in_endofpacket
	wire         rx_eth_pkt_backpressure_control_avalon_st_source_data_valid;                                                         // rx_eth_pkt_backpressure_control:data_src_valid -> rx_st_timing_adapter_frame_status_in:in_valid
	wire         rx_eth_pkt_backpressure_control_avalon_st_source_data_startofpacket;                                                 // rx_eth_pkt_backpressure_control:data_src_sop -> rx_st_timing_adapter_frame_status_in:in_startofpacket
	wire         rx_eth_pkt_backpressure_control_avalon_st_source_data_error;                                                         // rx_eth_pkt_backpressure_control:data_src_error -> rx_st_timing_adapter_frame_status_in:in_error
	wire   [2:0] rx_eth_pkt_backpressure_control_avalon_st_source_data_empty;                                                         // rx_eth_pkt_backpressure_control:data_src_empty -> rx_st_timing_adapter_frame_status_in:in_empty
	wire  [63:0] rx_eth_pkt_backpressure_control_avalon_st_source_data_data;                                                          // rx_eth_pkt_backpressure_control:data_src_data -> rx_st_timing_adapter_frame_status_in:in_data
	wire         rx_st_timing_adapter_frame_status_in_out_endofpacket;                                                                // rx_st_timing_adapter_frame_status_in:out_endofpacket -> rx_st_frame_status_splitter:in0_endofpacket
	wire         rx_st_timing_adapter_frame_status_in_out_valid;                                                                      // rx_st_timing_adapter_frame_status_in:out_valid -> rx_st_frame_status_splitter:in0_valid
	wire         rx_st_timing_adapter_frame_status_in_out_startofpacket;                                                              // rx_st_timing_adapter_frame_status_in:out_startofpacket -> rx_st_frame_status_splitter:in0_startofpacket
	wire         rx_st_timing_adapter_frame_status_in_out_error;                                                                      // rx_st_timing_adapter_frame_status_in:out_error -> rx_st_frame_status_splitter:in0_error
	wire   [2:0] rx_st_timing_adapter_frame_status_in_out_empty;                                                                      // rx_st_timing_adapter_frame_status_in:out_empty -> rx_st_frame_status_splitter:in0_empty
	wire  [63:0] rx_st_timing_adapter_frame_status_in_out_data;                                                                       // rx_st_timing_adapter_frame_status_in:out_data -> rx_st_frame_status_splitter:in0_data
	wire         rx_st_timing_adapter_frame_status_in_out_ready;                                                                      // rx_st_frame_status_splitter:in0_ready -> rx_st_timing_adapter_frame_status_in:out_ready
	wire         rx_st_frame_status_splitter_out0_endofpacket;                                                                        // rx_st_frame_status_splitter:out0_endofpacket -> rx_timing_adapter_frame_status_out_frame_decoder:in_endofpacket
	wire         rx_st_frame_status_splitter_out0_valid;                                                                              // rx_st_frame_status_splitter:out0_valid -> rx_timing_adapter_frame_status_out_frame_decoder:in_valid
	wire         rx_st_frame_status_splitter_out0_startofpacket;                                                                      // rx_st_frame_status_splitter:out0_startofpacket -> rx_timing_adapter_frame_status_out_frame_decoder:in_startofpacket
	wire         rx_st_frame_status_splitter_out0_error;                                                                              // rx_st_frame_status_splitter:out0_error -> rx_timing_adapter_frame_status_out_frame_decoder:in_error
	wire  [63:0] rx_st_frame_status_splitter_out0_data;                                                                               // rx_st_frame_status_splitter:out0_data -> rx_timing_adapter_frame_status_out_frame_decoder:in_data
	wire   [2:0] rx_st_frame_status_splitter_out0_empty;                                                                              // rx_st_frame_status_splitter:out0_empty -> rx_timing_adapter_frame_status_out_frame_decoder:in_empty
	wire         rx_st_frame_status_splitter_out0_ready;                                                                              // rx_timing_adapter_frame_status_out_frame_decoder:in_ready -> rx_st_frame_status_splitter:out0_ready
	wire         rx_timing_adapter_frame_status_out_frame_decoder_out_endofpacket;                                                    // rx_timing_adapter_frame_status_out_frame_decoder:out_endofpacket -> rx_eth_frame_decoder:data_sink_eop
	wire         rx_timing_adapter_frame_status_out_frame_decoder_out_valid;                                                          // rx_timing_adapter_frame_status_out_frame_decoder:out_valid -> rx_eth_frame_decoder:data_sink_valid
	wire         rx_timing_adapter_frame_status_out_frame_decoder_out_startofpacket;                                                  // rx_timing_adapter_frame_status_out_frame_decoder:out_startofpacket -> rx_eth_frame_decoder:data_sink_sop
	wire         rx_timing_adapter_frame_status_out_frame_decoder_out_error;                                                          // rx_timing_adapter_frame_status_out_frame_decoder:out_error -> rx_eth_frame_decoder:data_sink_error
	wire   [2:0] rx_timing_adapter_frame_status_out_frame_decoder_out_empty;                                                          // rx_timing_adapter_frame_status_out_frame_decoder:out_empty -> rx_eth_frame_decoder:data_sink_empty
	wire  [63:0] rx_timing_adapter_frame_status_out_frame_decoder_out_data;                                                           // rx_timing_adapter_frame_status_out_frame_decoder:out_data -> rx_eth_frame_decoder:data_sink_data
	wire         rx_eth_frame_decoder_avalon_st_data_src_endofpacket;                                                                 // rx_eth_frame_decoder:data_src_eop -> rx_eth_frame_status_merger:frame_decoder_data_sink_eop
	wire         rx_eth_frame_decoder_avalon_st_data_src_valid;                                                                       // rx_eth_frame_decoder:data_src_valid -> rx_eth_frame_status_merger:frame_decoder_data_sink_valid
	wire         rx_eth_frame_decoder_avalon_st_data_src_startofpacket;                                                               // rx_eth_frame_decoder:data_src_sop -> rx_eth_frame_status_merger:frame_decoder_data_sink_sop
	wire   [3:0] rx_eth_frame_decoder_avalon_st_data_src_error;                                                                       // rx_eth_frame_decoder:data_src_error -> rx_eth_frame_status_merger:frame_decoder_data_sink_error
	wire   [2:0] rx_eth_frame_decoder_avalon_st_data_src_empty;                                                                       // rx_eth_frame_decoder:data_src_empty -> rx_eth_frame_status_merger:frame_decoder_data_sink_empty
	wire  [63:0] rx_eth_frame_decoder_avalon_st_data_src_data;                                                                        // rx_eth_frame_decoder:data_src_data -> rx_eth_frame_status_merger:frame_decoder_data_sink_data
	wire         rx_eth_frame_decoder_avalon_st_pauselen_src_valid;                                                                   // rx_eth_frame_decoder:pauselen_src_valid -> rx_eth_frame_status_merger:pauselen_sink_valid
	wire  [15:0] rx_eth_frame_decoder_avalon_st_pauselen_src_data;                                                                    // rx_eth_frame_decoder:pauselen_src_data -> rx_eth_frame_status_merger:pauselen_sink_data
	wire         rx_st_frame_status_splitter_out1_endofpacket;                                                                        // rx_st_frame_status_splitter:out1_endofpacket -> rx_timing_adapter_frame_status_out_crc_checker:in_endofpacket
	wire         rx_st_frame_status_splitter_out1_valid;                                                                              // rx_st_frame_status_splitter:out1_valid -> rx_timing_adapter_frame_status_out_crc_checker:in_valid
	wire         rx_st_frame_status_splitter_out1_startofpacket;                                                                      // rx_st_frame_status_splitter:out1_startofpacket -> rx_timing_adapter_frame_status_out_crc_checker:in_startofpacket
	wire         rx_st_frame_status_splitter_out1_error;                                                                              // rx_st_frame_status_splitter:out1_error -> rx_timing_adapter_frame_status_out_crc_checker:in_error
	wire  [63:0] rx_st_frame_status_splitter_out1_data;                                                                               // rx_st_frame_status_splitter:out1_data -> rx_timing_adapter_frame_status_out_crc_checker:in_data
	wire   [2:0] rx_st_frame_status_splitter_out1_empty;                                                                              // rx_st_frame_status_splitter:out1_empty -> rx_timing_adapter_frame_status_out_crc_checker:in_empty
	wire         rx_st_frame_status_splitter_out1_ready;                                                                              // rx_timing_adapter_frame_status_out_crc_checker:in_ready -> rx_st_frame_status_splitter:out1_ready
	wire         rx_timing_adapter_frame_status_out_crc_checker_out_endofpacket;                                                      // rx_timing_adapter_frame_status_out_crc_checker:out_endofpacket -> rx_eth_crc_checker:data_sink_eop
	wire         rx_timing_adapter_frame_status_out_crc_checker_out_valid;                                                            // rx_timing_adapter_frame_status_out_crc_checker:out_valid -> rx_eth_crc_checker:data_sink_valid
	wire         rx_timing_adapter_frame_status_out_crc_checker_out_startofpacket;                                                    // rx_timing_adapter_frame_status_out_crc_checker:out_startofpacket -> rx_eth_crc_checker:data_sink_sop
	wire         rx_timing_adapter_frame_status_out_crc_checker_out_error;                                                            // rx_timing_adapter_frame_status_out_crc_checker:out_error -> rx_eth_crc_checker:data_sink_error
	wire   [2:0] rx_timing_adapter_frame_status_out_crc_checker_out_empty;                                                            // rx_timing_adapter_frame_status_out_crc_checker:out_empty -> rx_eth_crc_checker:data_sink_empty
	wire  [63:0] rx_timing_adapter_frame_status_out_crc_checker_out_data;                                                             // rx_timing_adapter_frame_status_out_crc_checker:out_data -> rx_eth_crc_checker:data_sink_data
	wire         rx_eth_frame_status_merger_data_src_endofpacket;                                                                     // rx_eth_frame_status_merger:data_src_eop -> rx_eth_crc_pad_rem:data_sink_eop
	wire         rx_eth_frame_status_merger_data_src_valid;                                                                           // rx_eth_frame_status_merger:data_src_valid -> rx_eth_crc_pad_rem:data_sink_valid
	wire         rx_eth_frame_status_merger_data_src_startofpacket;                                                                   // rx_eth_frame_status_merger:data_src_sop -> rx_eth_crc_pad_rem:data_sink_sop
	wire   [4:0] rx_eth_frame_status_merger_data_src_error;                                                                           // rx_eth_frame_status_merger:data_src_error -> rx_eth_crc_pad_rem:data_sink_error
	wire   [2:0] rx_eth_frame_status_merger_data_src_empty;                                                                           // rx_eth_frame_status_merger:data_src_empty -> rx_eth_crc_pad_rem:data_sink_empty
	wire  [63:0] rx_eth_frame_status_merger_data_src_data;                                                                            // rx_eth_frame_status_merger:data_src_data -> rx_eth_crc_pad_rem:data_sink_data
	wire         rx_eth_frame_decoder_avalon_st_pktinfo_src_valid;                                                                    // rx_eth_frame_decoder:pktinfo_src_valid -> rx_eth_crc_pad_rem:status_sink_valid
	wire  [22:0] rx_eth_frame_decoder_avalon_st_pktinfo_src_data;                                                                     // rx_eth_frame_decoder:pktinfo_src_data -> rx_eth_crc_pad_rem:status_sink_data
	wire         rx_eth_crc_pad_rem_avalon_streaming_source_data_endofpacket;                                                         // rx_eth_crc_pad_rem:data_source_eop -> rx_eth_packet_overflow_control:data_sink_eop
	wire         rx_eth_crc_pad_rem_avalon_streaming_source_data_valid;                                                               // rx_eth_crc_pad_rem:data_source_valid -> rx_eth_packet_overflow_control:data_sink_valid
	wire         rx_eth_crc_pad_rem_avalon_streaming_source_data_startofpacket;                                                       // rx_eth_crc_pad_rem:data_source_sop -> rx_eth_packet_overflow_control:data_sink_sop
	wire   [4:0] rx_eth_crc_pad_rem_avalon_streaming_source_data_error;                                                               // rx_eth_crc_pad_rem:data_source_error -> rx_eth_packet_overflow_control:data_sink_error
	wire   [2:0] rx_eth_crc_pad_rem_avalon_streaming_source_data_empty;                                                               // rx_eth_crc_pad_rem:data_source_empty -> rx_eth_packet_overflow_control:data_sink_empty
	wire  [63:0] rx_eth_crc_pad_rem_avalon_streaming_source_data_data;                                                                // rx_eth_crc_pad_rem:data_source_data -> rx_eth_packet_overflow_control:data_sink_data
	wire         rx_eth_crc_checker_avalon_streaming_source_endofpacket;                                                              // rx_eth_crc_checker:data_src_eop -> rx_eth_frame_status_merger:crc_checker_data_sink_eop
	wire         rx_eth_crc_checker_avalon_streaming_source_valid;                                                                    // rx_eth_crc_checker:data_src_valid -> rx_eth_frame_status_merger:crc_checker_data_sink_valid
	wire         rx_eth_crc_checker_avalon_streaming_source_startofpacket;                                                            // rx_eth_crc_checker:data_src_sop -> rx_eth_frame_status_merger:crc_checker_data_sink_sop
	wire   [1:0] rx_eth_crc_checker_avalon_streaming_source_error;                                                                    // rx_eth_crc_checker:data_src_error -> rx_eth_frame_status_merger:crc_checker_data_sink_error
	wire   [2:0] rx_eth_crc_checker_avalon_streaming_source_empty;                                                                    // rx_eth_crc_checker:data_src_empty -> rx_eth_frame_status_merger:crc_checker_data_sink_empty
	wire  [63:0] rx_eth_crc_checker_avalon_streaming_source_data;                                                                     // rx_eth_crc_checker:data_src_data -> rx_eth_frame_status_merger:crc_checker_data_sink_data
	wire         rx_eth_frame_decoder_avalon_st_rxstatus_src_valid;                                                                   // rx_eth_frame_decoder:rxstatus_src_valid -> rx_eth_frame_status_merger:rxstatus_sink_valid
	wire   [3:0] rx_eth_frame_decoder_avalon_st_rxstatus_src_error;                                                                   // rx_eth_frame_decoder:rxstatus_src_error -> rx_eth_frame_status_merger:rxstatus_sink_error
	wire  [39:0] rx_eth_frame_decoder_avalon_st_rxstatus_src_data;                                                                    // rx_eth_frame_decoder:rxstatus_src_data -> rx_eth_frame_status_merger:rxstatus_sink_data
	wire         rx_eth_frame_status_merger_rxstatus_src_valid;                                                                       // rx_eth_frame_status_merger:rxstatus_src_valid -> rx_st_error_adapter_stat:in_valid
	wire   [4:0] rx_eth_frame_status_merger_rxstatus_src_error;                                                                       // rx_eth_frame_status_merger:rxstatus_src_error -> rx_st_error_adapter_stat:in_error
	wire  [39:0] rx_eth_frame_status_merger_rxstatus_src_data;                                                                        // rx_eth_frame_status_merger:rxstatus_src_data -> rx_st_error_adapter_stat:in_data
	wire         rx_st_error_adapter_stat_out_valid;                                                                                  // rx_st_error_adapter_stat:out_valid -> rx_st_timing_adapter_splitter_status_in:in_valid
	wire   [6:0] rx_st_error_adapter_stat_out_error;                                                                                  // rx_st_error_adapter_stat:out_error -> rx_st_timing_adapter_splitter_status_in:in_error
	wire  [39:0] rx_st_error_adapter_stat_out_data;                                                                                   // rx_st_error_adapter_stat:out_data -> rx_st_timing_adapter_splitter_status_in:in_data
	wire         rx_st_timing_adapter_splitter_status_in_out_valid;                                                                   // rx_st_timing_adapter_splitter_status_in:out_valid -> rx_st_status_splitter:in0_valid
	wire   [6:0] rx_st_timing_adapter_splitter_status_in_out_error;                                                                   // rx_st_timing_adapter_splitter_status_in:out_error -> rx_st_status_splitter:in0_error
	wire  [39:0] rx_st_timing_adapter_splitter_status_in_out_data;                                                                    // rx_st_timing_adapter_splitter_status_in:out_data -> rx_st_status_splitter:in0_data
	wire         rx_st_timing_adapter_splitter_status_in_out_ready;                                                                   // rx_st_status_splitter:in0_ready -> rx_st_timing_adapter_splitter_status_in:out_ready
	wire         rx_st_status_splitter_out0_valid;                                                                                    // rx_st_status_splitter:out0_valid -> rx_st_timing_adapter_splitter_status_statistics:in_valid
	wire   [6:0] rx_st_status_splitter_out0_error;                                                                                    // rx_st_status_splitter:out0_error -> rx_st_timing_adapter_splitter_status_statistics:in_error
	wire  [39:0] rx_st_status_splitter_out0_data;                                                                                     // rx_st_status_splitter:out0_data -> rx_st_timing_adapter_splitter_status_statistics:in_data
	wire         rx_st_status_splitter_out0_ready;                                                                                    // rx_st_timing_adapter_splitter_status_statistics:in_ready -> rx_st_status_splitter:out0_ready
	wire         rx_st_timing_adapter_splitter_status_statistics_out_valid;                                                           // rx_st_timing_adapter_splitter_status_statistics:out_valid -> rx_st_status_statistics_delay:in0_valid
	wire   [6:0] rx_st_timing_adapter_splitter_status_statistics_out_error;                                                           // rx_st_timing_adapter_splitter_status_statistics:out_error -> rx_st_status_statistics_delay:in0_error
	wire  [39:0] rx_st_timing_adapter_splitter_status_statistics_out_data;                                                            // rx_st_timing_adapter_splitter_status_statistics:out_data -> rx_st_status_statistics_delay:in0_data
	wire         rx_st_status_statistics_delay_out_valid;                                                                             // rx_st_status_statistics_delay:out0_valid -> rx_eth_statistics_collector:stat_sink_valid
	wire   [6:0] rx_st_status_statistics_delay_out_error;                                                                             // rx_st_status_statistics_delay:out0_error -> rx_eth_statistics_collector:stat_sink_error
	wire  [39:0] rx_st_status_statistics_delay_out_data;                                                                              // rx_st_status_statistics_delay:out0_data -> rx_eth_statistics_collector:stat_sink_data
	wire         rx_st_status_splitter_out1_valid;                                                                                    // rx_st_status_splitter:out1_valid -> rx_st_timing_adapter_splitter_status_output:in_valid
	wire   [6:0] rx_st_status_splitter_out1_error;                                                                                    // rx_st_status_splitter:out1_error -> rx_st_timing_adapter_splitter_status_output:in_error
	wire  [39:0] rx_st_status_splitter_out1_data;                                                                                     // rx_st_status_splitter:out1_data -> rx_st_timing_adapter_splitter_status_output:in_data
	wire         rx_st_status_splitter_out1_ready;                                                                                    // rx_st_timing_adapter_splitter_status_output:in_ready -> rx_st_status_splitter:out1_ready
	wire         rx_st_timing_adapter_splitter_status_output_out_valid;                                                               // rx_st_timing_adapter_splitter_status_output:out_valid -> rx_st_status_output_delay:in0_valid
	wire   [6:0] rx_st_timing_adapter_splitter_status_output_out_error;                                                               // rx_st_timing_adapter_splitter_status_output:out_error -> rx_st_status_output_delay:in0_error
	wire  [39:0] rx_st_timing_adapter_splitter_status_output_out_data;                                                                // rx_st_timing_adapter_splitter_status_output:out_data -> rx_st_status_output_delay:in0_data
	wire         rx_eth_lane_decoder_avalon_streaming_source_endofpacket;                                                             // rx_eth_lane_decoder:rxdata_src_eop -> rx_eth_pkt_backpressure_control:data_sink_eop
	wire         rx_eth_lane_decoder_avalon_streaming_source_valid;                                                                   // rx_eth_lane_decoder:rxdata_src_valid -> rx_eth_pkt_backpressure_control:data_sink_valid
	wire         rx_eth_lane_decoder_avalon_streaming_source_startofpacket;                                                           // rx_eth_lane_decoder:rxdata_src_sop -> rx_eth_pkt_backpressure_control:data_sink_sop
	wire         rx_eth_lane_decoder_avalon_streaming_source_error;                                                                   // rx_eth_lane_decoder:rxdata_src_error -> rx_eth_pkt_backpressure_control:data_sink_error
	wire   [2:0] rx_eth_lane_decoder_avalon_streaming_source_empty;                                                                   // rx_eth_lane_decoder:rxdata_src_empty -> rx_eth_pkt_backpressure_control:data_sink_empty
	wire  [63:0] rx_eth_lane_decoder_avalon_streaming_source_data;                                                                    // rx_eth_lane_decoder:rxdata_src_data -> rx_eth_pkt_backpressure_control:data_sink_data
	wire   [1:0] rx_eth_link_fault_detection_link_fault_src_data;                                                                     // rx_eth_link_fault_detection:link_fault_src_data -> txrx_timing_adapter_link_fault_status_rx:in_data
	wire         txrx_timing_adapter_link_fault_status_rx_out_valid;                                                                  // txrx_timing_adapter_link_fault_status_rx:out_valid -> txrx_st_splitter_link_fault_status:in0_valid
	wire   [1:0] txrx_timing_adapter_link_fault_status_rx_out_data;                                                                   // txrx_timing_adapter_link_fault_status_rx:out_data -> txrx_st_splitter_link_fault_status:in0_data
	wire         txrx_timing_adapter_link_fault_status_rx_out_ready;                                                                  // txrx_st_splitter_link_fault_status:in0_ready -> txrx_timing_adapter_link_fault_status_rx:out_ready
	wire         txrx_st_splitter_link_fault_status_out0_valid;                                                                       // txrx_st_splitter_link_fault_status:out0_valid -> txrx_timing_adapter_link_fault_status_export:in_valid
	wire   [1:0] txrx_st_splitter_link_fault_status_out0_data;                                                                        // txrx_st_splitter_link_fault_status:out0_data -> txrx_timing_adapter_link_fault_status_export:in_data
	wire         txrx_st_splitter_link_fault_status_out0_ready;                                                                       // txrx_timing_adapter_link_fault_status_export:in_ready -> txrx_st_splitter_link_fault_status:out0_ready
	wire         txrx_st_splitter_link_fault_status_out1_valid;                                                                       // txrx_st_splitter_link_fault_status:out1_valid -> rxtx_dc_fifo_link_fault_status:in_valid
	wire   [1:0] txrx_st_splitter_link_fault_status_out1_data;                                                                        // txrx_st_splitter_link_fault_status:out1_data -> rxtx_dc_fifo_link_fault_status:in_data
	wire         txrx_st_splitter_link_fault_status_out1_ready;                                                                       // rxtx_dc_fifo_link_fault_status:in_ready -> txrx_st_splitter_link_fault_status:out1_ready
	wire         rxtx_dc_fifo_link_fault_status_out_valid;                                                                            // rxtx_dc_fifo_link_fault_status:out_valid -> rxtx_timing_adapter_link_fault_status_tx:in_valid
	wire   [1:0] rxtx_dc_fifo_link_fault_status_out_data;                                                                             // rxtx_dc_fifo_link_fault_status:out_data -> rxtx_timing_adapter_link_fault_status_tx:in_data
	wire         rxtx_dc_fifo_link_fault_status_out_ready;                                                                            // rxtx_timing_adapter_link_fault_status_tx:in_ready -> rxtx_dc_fifo_link_fault_status:out_ready
	wire   [1:0] rxtx_timing_adapter_link_fault_status_tx_out_data;                                                                   // rxtx_timing_adapter_link_fault_status_tx:out_data -> tx_eth_link_fault_generation:link_fault_sink_data
	wire         rx_eth_frame_status_merger_pauselen_src_valid;                                                                       // rx_eth_frame_status_merger:pauselen_src_valid -> rxtx_timing_adapter_pauselen_rx:in_valid
	wire  [15:0] rx_eth_frame_status_merger_pauselen_src_data;                                                                        // rx_eth_frame_status_merger:pauselen_src_data -> rxtx_timing_adapter_pauselen_rx:in_data
	wire         rxtx_timing_adapter_pauselen_rx_out_valid;                                                                           // rxtx_timing_adapter_pauselen_rx:out_valid -> rxtx_dc_fifo_pauselen:in_valid
	wire  [15:0] rxtx_timing_adapter_pauselen_rx_out_data;                                                                            // rxtx_timing_adapter_pauselen_rx:out_data -> rxtx_dc_fifo_pauselen:in_data
	wire         rxtx_timing_adapter_pauselen_rx_out_ready;                                                                           // rxtx_dc_fifo_pauselen:in_ready -> rxtx_timing_adapter_pauselen_rx:out_ready
	wire         rxtx_dc_fifo_pauselen_out_valid;                                                                                     // rxtx_dc_fifo_pauselen:out_valid -> rxtx_timing_adapter_pauselen_tx:in_valid
	wire  [15:0] rxtx_dc_fifo_pauselen_out_data;                                                                                      // rxtx_dc_fifo_pauselen:out_data -> rxtx_timing_adapter_pauselen_tx:in_data
	wire         rxtx_dc_fifo_pauselen_out_ready;                                                                                     // rxtx_timing_adapter_pauselen_tx:in_ready -> rxtx_dc_fifo_pauselen:out_ready
	wire         rxtx_timing_adapter_pauselen_tx_out_valid;                                                                           // rxtx_timing_adapter_pauselen_tx:out_valid -> tx_eth_pause_beat_conversion:pause_quanta_sink_valid
	wire  [15:0] rxtx_timing_adapter_pauselen_tx_out_data;                                                                            // rxtx_timing_adapter_pauselen_tx:out_data -> tx_eth_pause_beat_conversion:pause_quanta_sink_data
	wire         merlin_master_translator_avalon_universal_master_0_waitrequest;                                                      // merlin_master_translator_avalon_universal_master_0_translator:av_waitrequest -> merlin_master_translator:uav_waitrequest
	wire   [2:0] merlin_master_translator_avalon_universal_master_0_burstcount;                                                       // merlin_master_translator:uav_burstcount -> merlin_master_translator_avalon_universal_master_0_translator:av_burstcount
	wire  [31:0] merlin_master_translator_avalon_universal_master_0_writedata;                                                        // merlin_master_translator:uav_writedata -> merlin_master_translator_avalon_universal_master_0_translator:av_writedata
	wire  [14:0] merlin_master_translator_avalon_universal_master_0_address;                                                          // merlin_master_translator:uav_address -> merlin_master_translator_avalon_universal_master_0_translator:av_address
	wire         merlin_master_translator_avalon_universal_master_0_lock;                                                             // merlin_master_translator:uav_lock -> merlin_master_translator_avalon_universal_master_0_translator:av_lock
	wire         merlin_master_translator_avalon_universal_master_0_write;                                                            // merlin_master_translator:uav_write -> merlin_master_translator_avalon_universal_master_0_translator:av_write
	wire         merlin_master_translator_avalon_universal_master_0_read;                                                             // merlin_master_translator:uav_read -> merlin_master_translator_avalon_universal_master_0_translator:av_read
	wire  [31:0] merlin_master_translator_avalon_universal_master_0_readdata;                                                         // merlin_master_translator_avalon_universal_master_0_translator:av_readdata -> merlin_master_translator:uav_readdata
	wire         merlin_master_translator_avalon_universal_master_0_debugaccess;                                                      // merlin_master_translator:uav_debugaccess -> merlin_master_translator_avalon_universal_master_0_translator:av_debugaccess
	wire   [3:0] merlin_master_translator_avalon_universal_master_0_byteenable;                                                       // merlin_master_translator:uav_byteenable -> merlin_master_translator_avalon_universal_master_0_translator:av_byteenable
	wire         merlin_master_translator_avalon_universal_master_0_readdatavalid;                                                    // merlin_master_translator_avalon_universal_master_0_translator:av_readdatavalid -> merlin_master_translator:uav_readdatavalid
	wire         tx_bridge_s0_translator_avalon_anti_slave_0_waitrequest;                                                             // tx_bridge:s0_waitrequest -> tx_bridge_s0_translator:av_waitrequest
	wire         tx_bridge_s0_translator_avalon_anti_slave_0_burstcount;                                                              // tx_bridge_s0_translator:av_burstcount -> tx_bridge:s0_burstcount
	wire  [31:0] tx_bridge_s0_translator_avalon_anti_slave_0_writedata;                                                               // tx_bridge_s0_translator:av_writedata -> tx_bridge:s0_writedata
	wire  [13:0] tx_bridge_s0_translator_avalon_anti_slave_0_address;                                                                 // tx_bridge_s0_translator:av_address -> tx_bridge:s0_address
	wire         tx_bridge_s0_translator_avalon_anti_slave_0_write;                                                                   // tx_bridge_s0_translator:av_write -> tx_bridge:s0_write
	wire         tx_bridge_s0_translator_avalon_anti_slave_0_read;                                                                    // tx_bridge_s0_translator:av_read -> tx_bridge:s0_read
	wire  [31:0] tx_bridge_s0_translator_avalon_anti_slave_0_readdata;                                                                // tx_bridge:s0_readdata -> tx_bridge_s0_translator:av_readdata
	wire         tx_bridge_s0_translator_avalon_anti_slave_0_debugaccess;                                                             // tx_bridge_s0_translator:av_debugaccess -> tx_bridge:s0_debugaccess
	wire         tx_bridge_s0_translator_avalon_anti_slave_0_readdatavalid;                                                           // tx_bridge:s0_readdatavalid -> tx_bridge_s0_translator:av_readdatavalid
	wire   [3:0] tx_bridge_s0_translator_avalon_anti_slave_0_byteenable;                                                              // tx_bridge_s0_translator:av_byteenable -> tx_bridge:s0_byteenable
	wire         rx_bridge_s0_translator_avalon_anti_slave_0_waitrequest;                                                             // rx_bridge:s0_waitrequest -> rx_bridge_s0_translator:av_waitrequest
	wire         rx_bridge_s0_translator_avalon_anti_slave_0_burstcount;                                                              // rx_bridge_s0_translator:av_burstcount -> rx_bridge:s0_burstcount
	wire  [31:0] rx_bridge_s0_translator_avalon_anti_slave_0_writedata;                                                               // rx_bridge_s0_translator:av_writedata -> rx_bridge:s0_writedata
	wire  [13:0] rx_bridge_s0_translator_avalon_anti_slave_0_address;                                                                 // rx_bridge_s0_translator:av_address -> rx_bridge:s0_address
	wire         rx_bridge_s0_translator_avalon_anti_slave_0_write;                                                                   // rx_bridge_s0_translator:av_write -> rx_bridge:s0_write
	wire         rx_bridge_s0_translator_avalon_anti_slave_0_read;                                                                    // rx_bridge_s0_translator:av_read -> rx_bridge:s0_read
	wire  [31:0] rx_bridge_s0_translator_avalon_anti_slave_0_readdata;                                                                // rx_bridge:s0_readdata -> rx_bridge_s0_translator:av_readdata
	wire         rx_bridge_s0_translator_avalon_anti_slave_0_debugaccess;                                                             // rx_bridge_s0_translator:av_debugaccess -> rx_bridge:s0_debugaccess
	wire         rx_bridge_s0_translator_avalon_anti_slave_0_readdatavalid;                                                           // rx_bridge:s0_readdatavalid -> rx_bridge_s0_translator:av_readdatavalid
	wire   [3:0] rx_bridge_s0_translator_avalon_anti_slave_0_byteenable;                                                              // rx_bridge_s0_translator:av_byteenable -> rx_bridge:s0_byteenable
	wire   [0:0] tx_bridge_m0_burstcount;                                                                                             // tx_bridge:m0_burstcount -> tx_bridge_m0_translator:av_burstcount
	wire         tx_bridge_m0_waitrequest;                                                                                            // tx_bridge_m0_translator:av_waitrequest -> tx_bridge:m0_waitrequest
	wire  [13:0] tx_bridge_m0_address;                                                                                                // tx_bridge:m0_address -> tx_bridge_m0_translator:av_address
	wire  [31:0] tx_bridge_m0_writedata;                                                                                              // tx_bridge:m0_writedata -> tx_bridge_m0_translator:av_writedata
	wire         tx_bridge_m0_write;                                                                                                  // tx_bridge:m0_write -> tx_bridge_m0_translator:av_write
	wire         tx_bridge_m0_read;                                                                                                   // tx_bridge:m0_read -> tx_bridge_m0_translator:av_read
	wire  [31:0] tx_bridge_m0_readdata;                                                                                               // tx_bridge_m0_translator:av_readdata -> tx_bridge:m0_readdata
	wire         tx_bridge_m0_debugaccess;                                                                                            // tx_bridge:m0_debugaccess -> tx_bridge_m0_translator:av_debugaccess
	wire   [3:0] tx_bridge_m0_byteenable;                                                                                             // tx_bridge:m0_byteenable -> tx_bridge_m0_translator:av_byteenable
	wire         tx_bridge_m0_readdatavalid;                                                                                          // tx_bridge_m0_translator:av_readdatavalid -> tx_bridge:m0_readdatavalid
	wire  [31:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_writedata;                                        // tx_eth_pkt_backpressure_control_csr_translator:av_writedata -> tx_eth_pkt_backpressure_control:csr_writedata
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_address;                                          // tx_eth_pkt_backpressure_control_csr_translator:av_address -> tx_eth_pkt_backpressure_control:csr_address
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_write;                                            // tx_eth_pkt_backpressure_control_csr_translator:av_write -> tx_eth_pkt_backpressure_control:csr_write
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_read;                                             // tx_eth_pkt_backpressure_control_csr_translator:av_read -> tx_eth_pkt_backpressure_control:csr_read
	wire  [31:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_readdata;                                         // tx_eth_pkt_backpressure_control:csr_readdata -> tx_eth_pkt_backpressure_control_csr_translator:av_readdata
	wire  [31:0] tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_writedata;                                                    // tx_eth_pad_inserter_csr_translator:av_writedata -> tx_eth_pad_inserter:csr_writedata
	wire         tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_address;                                                      // tx_eth_pad_inserter_csr_translator:av_address -> tx_eth_pad_inserter:csr_address
	wire         tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_write;                                                        // tx_eth_pad_inserter_csr_translator:av_write -> tx_eth_pad_inserter:csr_write
	wire         tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_read;                                                         // tx_eth_pad_inserter_csr_translator:av_read -> tx_eth_pad_inserter:csr_read
	wire  [31:0] tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_readdata;                                                     // tx_eth_pad_inserter:csr_readdata -> tx_eth_pad_inserter_csr_translator:av_readdata
	wire  [31:0] tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_writedata;                                                    // tx_eth_crc_inserter_csr_translator:av_writedata -> tx_eth_crc_inserter:csr_writedata
	wire         tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_address;                                                      // tx_eth_crc_inserter_csr_translator:av_address -> tx_eth_crc_inserter:csr_address
	wire         tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_write;                                                        // tx_eth_crc_inserter_csr_translator:av_write -> tx_eth_crc_inserter:csr_write
	wire         tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_read;                                                         // tx_eth_crc_inserter_csr_translator:av_read -> tx_eth_crc_inserter:csr_read
	wire  [31:0] tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_readdata;                                                     // tx_eth_crc_inserter:csr_readdata -> tx_eth_crc_inserter_csr_translator:av_readdata
	wire  [31:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_writedata;                                                  // tx_eth_pause_ctrl_gen_csr_translator:av_writedata -> tx_eth_pause_ctrl_gen:csr_writedata
	wire   [1:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_address;                                                    // tx_eth_pause_ctrl_gen_csr_translator:av_address -> tx_eth_pause_ctrl_gen:csr_address
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_write;                                                      // tx_eth_pause_ctrl_gen_csr_translator:av_write -> tx_eth_pause_ctrl_gen:csr_write
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_read;                                                       // tx_eth_pause_ctrl_gen_csr_translator:av_read -> tx_eth_pause_ctrl_gen:csr_read
	wire  [31:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_readdata;                                                   // tx_eth_pause_ctrl_gen:csr_readdata -> tx_eth_pause_ctrl_gen_csr_translator:av_readdata
	wire  [31:0] tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_writedata;                                                // tx_eth_address_inserter_csr_translator:av_writedata -> tx_eth_address_inserter:csr_writedata
	wire   [1:0] tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_address;                                                  // tx_eth_address_inserter_csr_translator:av_address -> tx_eth_address_inserter:csr_address
	wire         tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_write;                                                    // tx_eth_address_inserter_csr_translator:av_write -> tx_eth_address_inserter:csr_write
	wire         tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_read;                                                     // tx_eth_address_inserter_csr_translator:av_read -> tx_eth_address_inserter:csr_read
	wire  [31:0] tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_readdata;                                                 // tx_eth_address_inserter:csr_readdata -> tx_eth_address_inserter_csr_translator:av_readdata
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_anti_slave_0_address;                               // tx_eth_packet_underflow_control_avalon_slave_0_translator:av_address -> tx_eth_packet_underflow_control:csr_address
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_anti_slave_0_read;                                  // tx_eth_packet_underflow_control_avalon_slave_0_translator:av_read -> tx_eth_packet_underflow_control:csr_read
	wire  [31:0] tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_anti_slave_0_readdata;                              // tx_eth_packet_underflow_control:csr_readdata -> tx_eth_packet_underflow_control_avalon_slave_0_translator:av_readdata
	wire  [31:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_writedata;                                         // tx_eth_frame_decoder_avalom_mm_csr_translator:av_writedata -> tx_eth_frame_decoder:csr_writedata
	wire   [4:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_address;                                           // tx_eth_frame_decoder_avalom_mm_csr_translator:av_address -> tx_eth_frame_decoder:csr_address
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_write;                                             // tx_eth_frame_decoder_avalom_mm_csr_translator:av_write -> tx_eth_frame_decoder:csr_write
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_read;                                              // tx_eth_frame_decoder_avalom_mm_csr_translator:av_read -> tx_eth_frame_decoder:csr_read
	wire  [31:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_readdata;                                          // tx_eth_frame_decoder:csr_readdata -> tx_eth_frame_decoder_avalom_mm_csr_translator:av_readdata
	wire  [31:0] tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_writedata;                                            // tx_eth_statistics_collector_csr_translator:av_writedata -> tx_eth_statistics_collector:csr_writedata
	wire   [5:0] tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_address;                                              // tx_eth_statistics_collector_csr_translator:av_address -> tx_eth_statistics_collector:csr_address
	wire         tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_write;                                                // tx_eth_statistics_collector_csr_translator:av_write -> tx_eth_statistics_collector:csr_write
	wire         tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_read;                                                 // tx_eth_statistics_collector_csr_translator:av_read -> tx_eth_statistics_collector:csr_read
	wire  [31:0] tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_readdata;                                             // tx_eth_statistics_collector:csr_readdata -> tx_eth_statistics_collector_csr_translator:av_readdata
	wire   [0:0] rx_bridge_m0_burstcount;                                                                                             // rx_bridge:m0_burstcount -> rx_bridge_m0_translator:av_burstcount
	wire         rx_bridge_m0_waitrequest;                                                                                            // rx_bridge_m0_translator:av_waitrequest -> rx_bridge:m0_waitrequest
	wire  [13:0] rx_bridge_m0_address;                                                                                                // rx_bridge:m0_address -> rx_bridge_m0_translator:av_address
	wire  [31:0] rx_bridge_m0_writedata;                                                                                              // rx_bridge:m0_writedata -> rx_bridge_m0_translator:av_writedata
	wire         rx_bridge_m0_write;                                                                                                  // rx_bridge:m0_write -> rx_bridge_m0_translator:av_write
	wire         rx_bridge_m0_read;                                                                                                   // rx_bridge:m0_read -> rx_bridge_m0_translator:av_read
	wire  [31:0] rx_bridge_m0_readdata;                                                                                               // rx_bridge_m0_translator:av_readdata -> rx_bridge:m0_readdata
	wire         rx_bridge_m0_debugaccess;                                                                                            // rx_bridge:m0_debugaccess -> rx_bridge_m0_translator:av_debugaccess
	wire   [3:0] rx_bridge_m0_byteenable;                                                                                             // rx_bridge:m0_byteenable -> rx_bridge_m0_translator:av_byteenable
	wire         rx_bridge_m0_readdatavalid;                                                                                          // rx_bridge_m0_translator:av_readdatavalid -> rx_bridge:m0_readdatavalid
	wire  [31:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_writedata;                                        // rx_eth_pkt_backpressure_control_csr_translator:av_writedata -> rx_eth_pkt_backpressure_control:csr_writedata
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_address;                                          // rx_eth_pkt_backpressure_control_csr_translator:av_address -> rx_eth_pkt_backpressure_control:csr_address
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_write;                                            // rx_eth_pkt_backpressure_control_csr_translator:av_write -> rx_eth_pkt_backpressure_control:csr_write
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_read;                                             // rx_eth_pkt_backpressure_control_csr_translator:av_read -> rx_eth_pkt_backpressure_control:csr_read
	wire  [31:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_readdata;                                         // rx_eth_pkt_backpressure_control:csr_readdata -> rx_eth_pkt_backpressure_control_csr_translator:av_readdata
	wire  [31:0] rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_writedata;                                                     // rx_eth_crc_pad_rem_csr_translator:av_writedata -> rx_eth_crc_pad_rem:csr_writedata
	wire   [1:0] rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_address;                                                       // rx_eth_crc_pad_rem_csr_translator:av_address -> rx_eth_crc_pad_rem:csr_address
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_write;                                                         // rx_eth_crc_pad_rem_csr_translator:av_write -> rx_eth_crc_pad_rem:csr_write
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_read;                                                          // rx_eth_crc_pad_rem_csr_translator:av_read -> rx_eth_crc_pad_rem:csr_read
	wire  [31:0] rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_readdata;                                                      // rx_eth_crc_pad_rem:csr_readdata -> rx_eth_crc_pad_rem_csr_translator:av_readdata
	wire  [31:0] rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_writedata;                                                     // rx_eth_crc_checker_csr_translator:av_writedata -> rx_eth_crc_checker:csr_writedata
	wire         rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_address;                                                       // rx_eth_crc_checker_csr_translator:av_address -> rx_eth_crc_checker:csr_address
	wire         rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_write;                                                         // rx_eth_crc_checker_csr_translator:av_write -> rx_eth_crc_checker:csr_write
	wire         rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_read;                                                          // rx_eth_crc_checker_csr_translator:av_read -> rx_eth_crc_checker:csr_read
	wire  [31:0] rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_readdata;                                                      // rx_eth_crc_checker:csr_readdata -> rx_eth_crc_checker_csr_translator:av_readdata
	wire  [31:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_writedata;                                         // rx_eth_frame_decoder_avalom_mm_csr_translator:av_writedata -> rx_eth_frame_decoder:csr_writedata
	wire   [4:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_address;                                           // rx_eth_frame_decoder_avalom_mm_csr_translator:av_address -> rx_eth_frame_decoder:csr_address
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_write;                                             // rx_eth_frame_decoder_avalom_mm_csr_translator:av_write -> rx_eth_frame_decoder:csr_write
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_read;                                              // rx_eth_frame_decoder_avalom_mm_csr_translator:av_read -> rx_eth_frame_decoder:csr_read
	wire  [31:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_readdata;                                          // rx_eth_frame_decoder:csr_readdata -> rx_eth_frame_decoder_avalom_mm_csr_translator:av_readdata
	wire   [1:0] rx_eth_packet_overflow_control_csr_translator_avalon_anti_slave_0_address;                                           // rx_eth_packet_overflow_control_csr_translator:av_address -> rx_eth_packet_overflow_control:csr_address
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_anti_slave_0_read;                                              // rx_eth_packet_overflow_control_csr_translator:av_read -> rx_eth_packet_overflow_control:csr_read
	wire  [31:0] rx_eth_packet_overflow_control_csr_translator_avalon_anti_slave_0_readdata;                                          // rx_eth_packet_overflow_control:csr_readdata -> rx_eth_packet_overflow_control_csr_translator:av_readdata
	wire  [31:0] rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_writedata;                                            // rx_eth_statistics_collector_csr_translator:av_writedata -> rx_eth_statistics_collector:csr_writedata
	wire   [5:0] rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_address;                                              // rx_eth_statistics_collector_csr_translator:av_address -> rx_eth_statistics_collector:csr_address
	wire         rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_write;                                                // rx_eth_statistics_collector_csr_translator:av_write -> rx_eth_statistics_collector:csr_write
	wire         rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_read;                                                 // rx_eth_statistics_collector_csr_translator:av_read -> rx_eth_statistics_collector:csr_read
	wire  [31:0] rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_readdata;                                             // rx_eth_statistics_collector:csr_readdata -> rx_eth_statistics_collector_csr_translator:av_readdata
	wire  [31:0] rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_writedata;                                                    // rx_eth_lane_decoder_csr_translator:av_writedata -> rx_eth_lane_decoder:csr_writedata
	wire         rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_address;                                                      // rx_eth_lane_decoder_csr_translator:av_address -> rx_eth_lane_decoder:csr_address
	wire         rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_write;                                                        // rx_eth_lane_decoder_csr_translator:av_write -> rx_eth_lane_decoder:csr_write
	wire         rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_read;                                                         // rx_eth_lane_decoder_csr_translator:av_read -> rx_eth_lane_decoder:csr_read
	wire  [31:0] rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_readdata;                                                     // rx_eth_lane_decoder:csr_readdata -> rx_eth_lane_decoder_csr_translator:av_readdata
	wire         merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_waitrequest;                 // merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_waitrequest -> merlin_master_translator_avalon_universal_master_0_translator:uav_waitrequest
	wire   [2:0] merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_burstcount;                  // merlin_master_translator_avalon_universal_master_0_translator:uav_burstcount -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_writedata;                   // merlin_master_translator_avalon_universal_master_0_translator:uav_writedata -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_writedata
	wire  [14:0] merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_address;                     // merlin_master_translator_avalon_universal_master_0_translator:uav_address -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_address
	wire         merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_lock;                        // merlin_master_translator_avalon_universal_master_0_translator:uav_lock -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_lock
	wire         merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_write;                       // merlin_master_translator_avalon_universal_master_0_translator:uav_write -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_write
	wire         merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_read;                        // merlin_master_translator_avalon_universal_master_0_translator:uav_read -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_readdata;                    // merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_readdata -> merlin_master_translator_avalon_universal_master_0_translator:uav_readdata
	wire         merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_debugaccess;                 // merlin_master_translator_avalon_universal_master_0_translator:uav_debugaccess -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_byteenable;                  // merlin_master_translator_avalon_universal_master_0_translator:uav_byteenable -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_byteenable
	wire         merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_readdatavalid;               // merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_readdatavalid -> merlin_master_translator_avalon_universal_master_0_translator:uav_readdatavalid
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                               // tx_bridge_s0_translator:uav_waitrequest -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_burstcount;                                                // tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_burstcount -> tx_bridge_s0_translator:uav_burstcount
	wire  [31:0] tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_writedata;                                                 // tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_writedata -> tx_bridge_s0_translator:uav_writedata
	wire  [14:0] tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_address;                                                   // tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_address -> tx_bridge_s0_translator:uav_address
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_write;                                                     // tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_write -> tx_bridge_s0_translator:uav_write
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_lock;                                                      // tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_lock -> tx_bridge_s0_translator:uav_lock
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_read;                                                      // tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_read -> tx_bridge_s0_translator:uav_read
	wire  [31:0] tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdata;                                                  // tx_bridge_s0_translator:uav_readdata -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                             // tx_bridge_s0_translator:uav_readdatavalid -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                               // tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_debugaccess -> tx_bridge_s0_translator:uav_debugaccess
	wire   [3:0] tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_byteenable;                                                // tx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_byteenable -> tx_bridge_s0_translator:uav_byteenable
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                                        // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_valid;                                              // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_source_valid -> tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                                      // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [68:0] tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_data;                                               // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_source_data -> tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_ready;                                              // tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                                     // tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                                           // tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                                   // tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [68:0] tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                                            // tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                                           // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_sink_ready -> tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                                         // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:in_valid
	wire  [31:0] tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                                          // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:in_data
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                                         // tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:in_ready -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid;                                         // tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:out_valid -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data;                                          // tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:out_data -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready;                                         // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:out_ready
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                               // rx_bridge_s0_translator:uav_waitrequest -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_burstcount;                                                // rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_burstcount -> rx_bridge_s0_translator:uav_burstcount
	wire  [31:0] rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_writedata;                                                 // rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_writedata -> rx_bridge_s0_translator:uav_writedata
	wire  [14:0] rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_address;                                                   // rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_address -> rx_bridge_s0_translator:uav_address
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_write;                                                     // rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_write -> rx_bridge_s0_translator:uav_write
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_lock;                                                      // rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_lock -> rx_bridge_s0_translator:uav_lock
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_read;                                                      // rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_read -> rx_bridge_s0_translator:uav_read
	wire  [31:0] rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdata;                                                  // rx_bridge_s0_translator:uav_readdata -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                             // rx_bridge_s0_translator:uav_readdatavalid -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                               // rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_debugaccess -> rx_bridge_s0_translator:uav_debugaccess
	wire   [3:0] rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_byteenable;                                                // rx_bridge_s0_translator_avalon_universal_slave_0_agent:m0_byteenable -> rx_bridge_s0_translator:uav_byteenable
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                                        // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_valid;                                              // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_source_valid -> rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                                      // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [68:0] rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_data;                                               // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_source_data -> rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_ready;                                              // rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                                     // rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                                           // rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                                   // rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [68:0] rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                                            // rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                                           // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rf_sink_ready -> rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                                         // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:in_valid
	wire  [31:0] rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                                          // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:in_data
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                                         // rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:in_ready -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid;                                         // rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:out_valid -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data;                                          // rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:out_data -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready;                                         // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:out_ready
	wire         tx_bridge_m0_translator_avalon_universal_master_0_waitrequest;                                                       // tx_bridge_m0_translator_avalon_universal_master_0_agent:av_waitrequest -> tx_bridge_m0_translator:uav_waitrequest
	wire   [2:0] tx_bridge_m0_translator_avalon_universal_master_0_burstcount;                                                        // tx_bridge_m0_translator:uav_burstcount -> tx_bridge_m0_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] tx_bridge_m0_translator_avalon_universal_master_0_writedata;                                                         // tx_bridge_m0_translator:uav_writedata -> tx_bridge_m0_translator_avalon_universal_master_0_agent:av_writedata
	wire  [13:0] tx_bridge_m0_translator_avalon_universal_master_0_address;                                                           // tx_bridge_m0_translator:uav_address -> tx_bridge_m0_translator_avalon_universal_master_0_agent:av_address
	wire         tx_bridge_m0_translator_avalon_universal_master_0_lock;                                                              // tx_bridge_m0_translator:uav_lock -> tx_bridge_m0_translator_avalon_universal_master_0_agent:av_lock
	wire         tx_bridge_m0_translator_avalon_universal_master_0_write;                                                             // tx_bridge_m0_translator:uav_write -> tx_bridge_m0_translator_avalon_universal_master_0_agent:av_write
	wire         tx_bridge_m0_translator_avalon_universal_master_0_read;                                                              // tx_bridge_m0_translator:uav_read -> tx_bridge_m0_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] tx_bridge_m0_translator_avalon_universal_master_0_readdata;                                                          // tx_bridge_m0_translator_avalon_universal_master_0_agent:av_readdata -> tx_bridge_m0_translator:uav_readdata
	wire         tx_bridge_m0_translator_avalon_universal_master_0_debugaccess;                                                       // tx_bridge_m0_translator:uav_debugaccess -> tx_bridge_m0_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] tx_bridge_m0_translator_avalon_universal_master_0_byteenable;                                                        // tx_bridge_m0_translator:uav_byteenable -> tx_bridge_m0_translator_avalon_universal_master_0_agent:av_byteenable
	wire         tx_bridge_m0_translator_avalon_universal_master_0_readdatavalid;                                                     // tx_bridge_m0_translator_avalon_universal_master_0_agent:av_readdatavalid -> tx_bridge_m0_translator:uav_readdatavalid
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                        // tx_eth_pkt_backpressure_control_csr_translator:uav_waitrequest -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                         // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> tx_eth_pkt_backpressure_control_csr_translator:uav_burstcount
	wire  [31:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                          // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> tx_eth_pkt_backpressure_control_csr_translator:uav_writedata
	wire  [13:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_address;                            // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_address -> tx_eth_pkt_backpressure_control_csr_translator:uav_address
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_write;                              // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_write -> tx_eth_pkt_backpressure_control_csr_translator:uav_write
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_lock;                               // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_lock -> tx_eth_pkt_backpressure_control_csr_translator:uav_lock
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_read;                               // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_read -> tx_eth_pkt_backpressure_control_csr_translator:uav_read
	wire  [31:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                           // tx_eth_pkt_backpressure_control_csr_translator:uav_readdata -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                      // tx_eth_pkt_backpressure_control_csr_translator:uav_readdatavalid -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                        // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> tx_eth_pkt_backpressure_control_csr_translator:uav_debugaccess
	wire   [3:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                         // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> tx_eth_pkt_backpressure_control_csr_translator:uav_byteenable
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                 // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                       // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;               // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [71:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                        // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                       // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;              // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                    // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;            // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [71:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                     // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                    // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                  // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                   // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                  // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                    // tx_eth_pad_inserter_csr_translator:uav_waitrequest -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                     // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> tx_eth_pad_inserter_csr_translator:uav_burstcount
	wire  [31:0] tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                      // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> tx_eth_pad_inserter_csr_translator:uav_writedata
	wire  [13:0] tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_address;                                        // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_address -> tx_eth_pad_inserter_csr_translator:uav_address
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_write;                                          // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_write -> tx_eth_pad_inserter_csr_translator:uav_write
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                           // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_lock -> tx_eth_pad_inserter_csr_translator:uav_lock
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_read;                                           // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_read -> tx_eth_pad_inserter_csr_translator:uav_read
	wire  [31:0] tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                       // tx_eth_pad_inserter_csr_translator:uav_readdata -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                  // tx_eth_pad_inserter_csr_translator:uav_readdatavalid -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                    // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> tx_eth_pad_inserter_csr_translator:uav_debugaccess
	wire   [3:0] tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                     // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> tx_eth_pad_inserter_csr_translator:uav_byteenable
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                             // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                                   // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                           // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [71:0] tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                    // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                                   // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                          // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                                // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                        // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [71:0] tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                                 // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                                // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                              // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                               // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                              // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                    // tx_eth_crc_inserter_csr_translator:uav_waitrequest -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                     // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> tx_eth_crc_inserter_csr_translator:uav_burstcount
	wire  [31:0] tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                      // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> tx_eth_crc_inserter_csr_translator:uav_writedata
	wire  [13:0] tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_address;                                        // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_address -> tx_eth_crc_inserter_csr_translator:uav_address
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_write;                                          // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_write -> tx_eth_crc_inserter_csr_translator:uav_write
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                           // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_lock -> tx_eth_crc_inserter_csr_translator:uav_lock
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_read;                                           // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_read -> tx_eth_crc_inserter_csr_translator:uav_read
	wire  [31:0] tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                       // tx_eth_crc_inserter_csr_translator:uav_readdata -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                  // tx_eth_crc_inserter_csr_translator:uav_readdatavalid -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                    // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> tx_eth_crc_inserter_csr_translator:uav_debugaccess
	wire   [3:0] tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                     // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> tx_eth_crc_inserter_csr_translator:uav_byteenable
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                             // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                                   // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                           // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [71:0] tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                    // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                                   // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                          // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                                // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                        // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [71:0] tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                                 // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                                // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                              // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                               // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                              // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                  // tx_eth_pause_ctrl_gen_csr_translator:uav_waitrequest -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                   // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> tx_eth_pause_ctrl_gen_csr_translator:uav_burstcount
	wire  [31:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                    // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> tx_eth_pause_ctrl_gen_csr_translator:uav_writedata
	wire  [13:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_address;                                      // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_address -> tx_eth_pause_ctrl_gen_csr_translator:uav_address
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_write;                                        // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_write -> tx_eth_pause_ctrl_gen_csr_translator:uav_write
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                         // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_lock -> tx_eth_pause_ctrl_gen_csr_translator:uav_lock
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_read;                                         // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_read -> tx_eth_pause_ctrl_gen_csr_translator:uav_read
	wire  [31:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                     // tx_eth_pause_ctrl_gen_csr_translator:uav_readdata -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                // tx_eth_pause_ctrl_gen_csr_translator:uav_readdatavalid -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                  // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> tx_eth_pause_ctrl_gen_csr_translator:uav_debugaccess
	wire   [3:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                   // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> tx_eth_pause_ctrl_gen_csr_translator:uav_byteenable
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                           // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                                 // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                         // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [71:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                  // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                                 // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                        // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                              // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                      // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [71:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                               // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                              // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                            // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                             // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                            // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                // tx_eth_address_inserter_csr_translator:uav_waitrequest -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                 // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> tx_eth_address_inserter_csr_translator:uav_burstcount
	wire  [31:0] tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                  // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> tx_eth_address_inserter_csr_translator:uav_writedata
	wire  [13:0] tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_address;                                    // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_address -> tx_eth_address_inserter_csr_translator:uav_address
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_write;                                      // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_write -> tx_eth_address_inserter_csr_translator:uav_write
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                       // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_lock -> tx_eth_address_inserter_csr_translator:uav_lock
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_read;                                       // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_read -> tx_eth_address_inserter_csr_translator:uav_read
	wire  [31:0] tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                   // tx_eth_address_inserter_csr_translator:uav_readdata -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                              // tx_eth_address_inserter_csr_translator:uav_readdatavalid -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> tx_eth_address_inserter_csr_translator:uav_debugaccess
	wire   [3:0] tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                 // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> tx_eth_address_inserter_csr_translator:uav_byteenable
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                         // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                               // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                       // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [71:0] tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                               // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                      // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                            // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                    // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [71:0] tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                             // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                            // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                          // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                           // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                          // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_waitrequest;             // tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_waitrequest -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_burstcount;              // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_burstcount -> tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_burstcount
	wire  [31:0] tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_writedata;               // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_writedata -> tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_writedata
	wire  [13:0] tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_address;                 // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_address -> tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_address
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_write;                   // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_write -> tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_write
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_lock;                    // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_lock -> tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_lock
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_read;                    // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_read -> tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_read
	wire  [31:0] tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_readdata;                // tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_readdata -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_readdatavalid;           // tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_readdatavalid -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_debugaccess;             // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_debugaccess -> tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_debugaccess
	wire   [3:0] tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_byteenable;              // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:m0_byteenable -> tx_eth_packet_underflow_control_avalon_slave_0_translator:uav_byteenable
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;      // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_valid;            // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rf_source_valid -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;    // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [71:0] tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_data;             // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rf_source_data -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_ready;            // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;   // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;         // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket; // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [71:0] tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;          // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;         // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rf_sink_ready -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;       // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;        // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;       // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                         // tx_eth_frame_decoder_avalom_mm_csr_translator:uav_waitrequest -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                          // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> tx_eth_frame_decoder_avalom_mm_csr_translator:uav_burstcount
	wire  [31:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                           // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> tx_eth_frame_decoder_avalom_mm_csr_translator:uav_writedata
	wire  [13:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_address;                             // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_address -> tx_eth_frame_decoder_avalom_mm_csr_translator:uav_address
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_write;                               // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_write -> tx_eth_frame_decoder_avalom_mm_csr_translator:uav_write
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_lock -> tx_eth_frame_decoder_avalom_mm_csr_translator:uav_lock
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_read;                                // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_read -> tx_eth_frame_decoder_avalom_mm_csr_translator:uav_read
	wire  [31:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                            // tx_eth_frame_decoder_avalom_mm_csr_translator:uav_readdata -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                       // tx_eth_frame_decoder_avalom_mm_csr_translator:uav_readdatavalid -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                         // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> tx_eth_frame_decoder_avalom_mm_csr_translator:uav_debugaccess
	wire   [3:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                          // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> tx_eth_frame_decoder_avalom_mm_csr_translator:uav_byteenable
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                  // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                        // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [71:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                         // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                        // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;               // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                     // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;             // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [71:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                      // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                     // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                   // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                    // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                   // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                            // tx_eth_statistics_collector_csr_translator:uav_waitrequest -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                             // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> tx_eth_statistics_collector_csr_translator:uav_burstcount
	wire  [31:0] tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                              // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> tx_eth_statistics_collector_csr_translator:uav_writedata
	wire  [13:0] tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_address;                                // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_address -> tx_eth_statistics_collector_csr_translator:uav_address
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_write;                                  // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_write -> tx_eth_statistics_collector_csr_translator:uav_write
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                   // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_lock -> tx_eth_statistics_collector_csr_translator:uav_lock
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_read;                                   // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_read -> tx_eth_statistics_collector_csr_translator:uav_read
	wire  [31:0] tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                               // tx_eth_statistics_collector_csr_translator:uav_readdata -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                          // tx_eth_statistics_collector_csr_translator:uav_readdatavalid -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                            // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> tx_eth_statistics_collector_csr_translator:uav_debugaccess
	wire   [3:0] tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                             // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> tx_eth_statistics_collector_csr_translator:uav_byteenable
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                     // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                           // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                   // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [71:0] tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                            // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                           // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                  // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                        // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [71:0] tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                         // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                        // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                      // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                       // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                      // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         rx_bridge_m0_translator_avalon_universal_master_0_waitrequest;                                                       // rx_bridge_m0_translator_avalon_universal_master_0_agent:av_waitrequest -> rx_bridge_m0_translator:uav_waitrequest
	wire   [2:0] rx_bridge_m0_translator_avalon_universal_master_0_burstcount;                                                        // rx_bridge_m0_translator:uav_burstcount -> rx_bridge_m0_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] rx_bridge_m0_translator_avalon_universal_master_0_writedata;                                                         // rx_bridge_m0_translator:uav_writedata -> rx_bridge_m0_translator_avalon_universal_master_0_agent:av_writedata
	wire  [13:0] rx_bridge_m0_translator_avalon_universal_master_0_address;                                                           // rx_bridge_m0_translator:uav_address -> rx_bridge_m0_translator_avalon_universal_master_0_agent:av_address
	wire         rx_bridge_m0_translator_avalon_universal_master_0_lock;                                                              // rx_bridge_m0_translator:uav_lock -> rx_bridge_m0_translator_avalon_universal_master_0_agent:av_lock
	wire         rx_bridge_m0_translator_avalon_universal_master_0_write;                                                             // rx_bridge_m0_translator:uav_write -> rx_bridge_m0_translator_avalon_universal_master_0_agent:av_write
	wire         rx_bridge_m0_translator_avalon_universal_master_0_read;                                                              // rx_bridge_m0_translator:uav_read -> rx_bridge_m0_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] rx_bridge_m0_translator_avalon_universal_master_0_readdata;                                                          // rx_bridge_m0_translator_avalon_universal_master_0_agent:av_readdata -> rx_bridge_m0_translator:uav_readdata
	wire         rx_bridge_m0_translator_avalon_universal_master_0_debugaccess;                                                       // rx_bridge_m0_translator:uav_debugaccess -> rx_bridge_m0_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] rx_bridge_m0_translator_avalon_universal_master_0_byteenable;                                                        // rx_bridge_m0_translator:uav_byteenable -> rx_bridge_m0_translator_avalon_universal_master_0_agent:av_byteenable
	wire         rx_bridge_m0_translator_avalon_universal_master_0_readdatavalid;                                                     // rx_bridge_m0_translator_avalon_universal_master_0_agent:av_readdatavalid -> rx_bridge_m0_translator:uav_readdatavalid
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                        // rx_eth_pkt_backpressure_control_csr_translator:uav_waitrequest -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                         // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> rx_eth_pkt_backpressure_control_csr_translator:uav_burstcount
	wire  [31:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                          // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> rx_eth_pkt_backpressure_control_csr_translator:uav_writedata
	wire  [13:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_address;                            // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_address -> rx_eth_pkt_backpressure_control_csr_translator:uav_address
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_write;                              // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_write -> rx_eth_pkt_backpressure_control_csr_translator:uav_write
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_lock;                               // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_lock -> rx_eth_pkt_backpressure_control_csr_translator:uav_lock
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_read;                               // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_read -> rx_eth_pkt_backpressure_control_csr_translator:uav_read
	wire  [31:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                           // rx_eth_pkt_backpressure_control_csr_translator:uav_readdata -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                      // rx_eth_pkt_backpressure_control_csr_translator:uav_readdatavalid -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                        // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> rx_eth_pkt_backpressure_control_csr_translator:uav_debugaccess
	wire   [3:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                         // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> rx_eth_pkt_backpressure_control_csr_translator:uav_byteenable
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                 // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                       // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;               // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [69:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                        // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                       // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;              // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                    // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;            // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [69:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                     // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                    // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                  // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                   // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                  // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                     // rx_eth_crc_pad_rem_csr_translator:uav_waitrequest -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                      // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> rx_eth_crc_pad_rem_csr_translator:uav_burstcount
	wire  [31:0] rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                       // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> rx_eth_crc_pad_rem_csr_translator:uav_writedata
	wire  [13:0] rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_address;                                         // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_address -> rx_eth_crc_pad_rem_csr_translator:uav_address
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_write;                                           // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_write -> rx_eth_crc_pad_rem_csr_translator:uav_write
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                            // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_lock -> rx_eth_crc_pad_rem_csr_translator:uav_lock
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_read;                                            // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_read -> rx_eth_crc_pad_rem_csr_translator:uav_read
	wire  [31:0] rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                        // rx_eth_crc_pad_rem_csr_translator:uav_readdata -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                   // rx_eth_crc_pad_rem_csr_translator:uav_readdatavalid -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                     // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> rx_eth_crc_pad_rem_csr_translator:uav_debugaccess
	wire   [3:0] rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                      // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> rx_eth_crc_pad_rem_csr_translator:uav_byteenable
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                              // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                                    // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                            // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [69:0] rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                     // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                                    // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                           // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                                 // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                         // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [69:0] rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                                  // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                                 // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                               // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                                // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                               // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                     // rx_eth_crc_checker_csr_translator:uav_waitrequest -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                      // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> rx_eth_crc_checker_csr_translator:uav_burstcount
	wire  [31:0] rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                       // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> rx_eth_crc_checker_csr_translator:uav_writedata
	wire  [13:0] rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_address;                                         // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_address -> rx_eth_crc_checker_csr_translator:uav_address
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_write;                                           // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_write -> rx_eth_crc_checker_csr_translator:uav_write
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                            // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_lock -> rx_eth_crc_checker_csr_translator:uav_lock
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_read;                                            // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_read -> rx_eth_crc_checker_csr_translator:uav_read
	wire  [31:0] rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                        // rx_eth_crc_checker_csr_translator:uav_readdata -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                   // rx_eth_crc_checker_csr_translator:uav_readdatavalid -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                     // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> rx_eth_crc_checker_csr_translator:uav_debugaccess
	wire   [3:0] rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                      // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> rx_eth_crc_checker_csr_translator:uav_byteenable
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                              // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                                    // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                            // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [69:0] rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                     // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                                    // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                           // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                                 // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                         // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [69:0] rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                                  // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                                 // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                               // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                                // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                               // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                         // rx_eth_frame_decoder_avalom_mm_csr_translator:uav_waitrequest -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                          // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> rx_eth_frame_decoder_avalom_mm_csr_translator:uav_burstcount
	wire  [31:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                           // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> rx_eth_frame_decoder_avalom_mm_csr_translator:uav_writedata
	wire  [13:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_address;                             // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_address -> rx_eth_frame_decoder_avalom_mm_csr_translator:uav_address
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_write;                               // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_write -> rx_eth_frame_decoder_avalom_mm_csr_translator:uav_write
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_lock -> rx_eth_frame_decoder_avalom_mm_csr_translator:uav_lock
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_read;                                // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_read -> rx_eth_frame_decoder_avalom_mm_csr_translator:uav_read
	wire  [31:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                            // rx_eth_frame_decoder_avalom_mm_csr_translator:uav_readdata -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                       // rx_eth_frame_decoder_avalom_mm_csr_translator:uav_readdatavalid -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                         // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> rx_eth_frame_decoder_avalom_mm_csr_translator:uav_debugaccess
	wire   [3:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                          // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> rx_eth_frame_decoder_avalom_mm_csr_translator:uav_byteenable
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                  // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                        // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [69:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                         // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                        // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;               // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                     // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;             // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [69:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                      // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                     // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                   // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                    // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                   // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                         // rx_eth_packet_overflow_control_csr_translator:uav_waitrequest -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                          // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> rx_eth_packet_overflow_control_csr_translator:uav_burstcount
	wire  [31:0] rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                           // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> rx_eth_packet_overflow_control_csr_translator:uav_writedata
	wire  [13:0] rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_address;                             // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_address -> rx_eth_packet_overflow_control_csr_translator:uav_address
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_write;                               // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_write -> rx_eth_packet_overflow_control_csr_translator:uav_write
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_lock -> rx_eth_packet_overflow_control_csr_translator:uav_lock
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_read;                                // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_read -> rx_eth_packet_overflow_control_csr_translator:uav_read
	wire  [31:0] rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                            // rx_eth_packet_overflow_control_csr_translator:uav_readdata -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                       // rx_eth_packet_overflow_control_csr_translator:uav_readdatavalid -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                         // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> rx_eth_packet_overflow_control_csr_translator:uav_debugaccess
	wire   [3:0] rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                          // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> rx_eth_packet_overflow_control_csr_translator:uav_byteenable
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                  // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                        // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [69:0] rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                         // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                        // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;               // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                     // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;             // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [69:0] rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                      // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                     // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                   // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                    // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                   // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                            // rx_eth_statistics_collector_csr_translator:uav_waitrequest -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                             // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> rx_eth_statistics_collector_csr_translator:uav_burstcount
	wire  [31:0] rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                              // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> rx_eth_statistics_collector_csr_translator:uav_writedata
	wire  [13:0] rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_address;                                // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_address -> rx_eth_statistics_collector_csr_translator:uav_address
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_write;                                  // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_write -> rx_eth_statistics_collector_csr_translator:uav_write
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                   // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_lock -> rx_eth_statistics_collector_csr_translator:uav_lock
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_read;                                   // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_read -> rx_eth_statistics_collector_csr_translator:uav_read
	wire  [31:0] rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                               // rx_eth_statistics_collector_csr_translator:uav_readdata -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                          // rx_eth_statistics_collector_csr_translator:uav_readdatavalid -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                            // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> rx_eth_statistics_collector_csr_translator:uav_debugaccess
	wire   [3:0] rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                             // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> rx_eth_statistics_collector_csr_translator:uav_byteenable
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                     // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                           // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                   // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [69:0] rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                            // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                           // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                  // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                        // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [69:0] rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                         // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                        // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                      // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                       // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                      // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                    // rx_eth_lane_decoder_csr_translator:uav_waitrequest -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                     // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> rx_eth_lane_decoder_csr_translator:uav_burstcount
	wire  [31:0] rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                      // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> rx_eth_lane_decoder_csr_translator:uav_writedata
	wire  [13:0] rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_address;                                        // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_address -> rx_eth_lane_decoder_csr_translator:uav_address
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_write;                                          // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_write -> rx_eth_lane_decoder_csr_translator:uav_write
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                           // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_lock -> rx_eth_lane_decoder_csr_translator:uav_lock
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_read;                                           // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_read -> rx_eth_lane_decoder_csr_translator:uav_read
	wire  [31:0] rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                       // rx_eth_lane_decoder_csr_translator:uav_readdata -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                  // rx_eth_lane_decoder_csr_translator:uav_readdatavalid -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                    // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> rx_eth_lane_decoder_csr_translator:uav_debugaccess
	wire   [3:0] rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                     // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> rx_eth_lane_decoder_csr_translator:uav_byteenable
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                             // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                                   // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                           // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [69:0] rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                    // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                                   // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                          // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                                // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                        // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [69:0] rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                                 // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                                // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                              // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                               // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                              // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_endofpacket;        // merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router:sink_endofpacket
	wire         merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_valid;              // merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_valid -> addr_router:sink_valid
	wire         merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_startofpacket;      // merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router:sink_startofpacket
	wire  [67:0] merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_data;               // merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_data -> addr_router:sink_data
	wire         merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_ready;              // addr_router:sink_ready -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_ready
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                               // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router:sink_endofpacket
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_valid;                                                     // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rp_valid -> id_router:sink_valid
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                             // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router:sink_startofpacket
	wire  [67:0] tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_data;                                                      // tx_bridge_s0_translator_avalon_universal_slave_0_agent:rp_data -> id_router:sink_data
	wire         tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_ready;                                                     // id_router:sink_ready -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:rp_ready
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                               // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_001:sink_endofpacket
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_valid;                                                     // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_001:sink_valid
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                             // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_001:sink_startofpacket
	wire  [67:0] rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_data;                                                      // rx_bridge_s0_translator_avalon_universal_slave_0_agent:rp_data -> id_router_001:sink_data
	wire         rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_ready;                                                     // id_router_001:sink_ready -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:rp_ready
	wire         tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_endofpacket;                                              // tx_bridge_m0_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router_001:sink_endofpacket
	wire         tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_valid;                                                    // tx_bridge_m0_translator_avalon_universal_master_0_agent:cp_valid -> addr_router_001:sink_valid
	wire         tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_startofpacket;                                            // tx_bridge_m0_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router_001:sink_startofpacket
	wire  [70:0] tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_data;                                                     // tx_bridge_m0_translator_avalon_universal_master_0_agent:cp_data -> addr_router_001:sink_data
	wire         tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_ready;                                                    // addr_router_001:sink_ready -> tx_bridge_m0_translator_avalon_universal_master_0_agent:cp_ready
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                        // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_002:sink_endofpacket
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_valid;                              // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_002:sink_valid
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                      // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_002:sink_startofpacket
	wire  [70:0] tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_data;                               // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_002:sink_data
	wire         tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_ready;                              // id_router_002:sink_ready -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                    // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_003:sink_endofpacket
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                          // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_003:sink_valid
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                  // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_003:sink_startofpacket
	wire  [70:0] tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_data;                                           // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_003:sink_data
	wire         tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                          // id_router_003:sink_ready -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                    // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_004:sink_endofpacket
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                          // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_004:sink_valid
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                  // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_004:sink_startofpacket
	wire  [70:0] tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_data;                                           // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_004:sink_data
	wire         tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                          // id_router_004:sink_ready -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                  // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_005:sink_endofpacket
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                        // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_005:sink_valid
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_005:sink_startofpacket
	wire  [70:0] tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_data;                                         // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_005:sink_data
	wire         tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                        // id_router_005:sink_ready -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_006:sink_endofpacket
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                      // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_006:sink_valid
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                              // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_006:sink_startofpacket
	wire  [70:0] tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_data;                                       // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_006:sink_data
	wire         tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                      // id_router_006:sink_ready -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_endofpacket;             // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_007:sink_endofpacket
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_valid;                   // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_007:sink_valid
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_startofpacket;           // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_007:sink_startofpacket
	wire  [70:0] tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_data;                    // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rp_data -> id_router_007:sink_data
	wire         tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_ready;                   // id_router_007:sink_ready -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:rp_ready
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                         // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_008:sink_endofpacket
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_valid;                               // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_008:sink_valid
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                       // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_008:sink_startofpacket
	wire  [70:0] tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_data;                                // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_008:sink_data
	wire         tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_ready;                               // id_router_008:sink_ready -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                            // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_009:sink_endofpacket
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                  // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_009:sink_valid
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                          // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_009:sink_startofpacket
	wire  [70:0] tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_data;                                   // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_009:sink_data
	wire         tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                  // id_router_009:sink_ready -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_endofpacket;                                              // rx_bridge_m0_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router_002:sink_endofpacket
	wire         rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_valid;                                                    // rx_bridge_m0_translator_avalon_universal_master_0_agent:cp_valid -> addr_router_002:sink_valid
	wire         rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_startofpacket;                                            // rx_bridge_m0_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router_002:sink_startofpacket
	wire  [68:0] rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_data;                                                     // rx_bridge_m0_translator_avalon_universal_master_0_agent:cp_data -> addr_router_002:sink_data
	wire         rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_ready;                                                    // addr_router_002:sink_ready -> rx_bridge_m0_translator_avalon_universal_master_0_agent:cp_ready
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                        // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_010:sink_endofpacket
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_valid;                              // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_010:sink_valid
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                      // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_010:sink_startofpacket
	wire  [68:0] rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_data;                               // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_010:sink_data
	wire         rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_ready;                              // id_router_010:sink_ready -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                     // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_011:sink_endofpacket
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                           // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_011:sink_valid
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                   // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_011:sink_startofpacket
	wire  [68:0] rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_data;                                            // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_011:sink_data
	wire         rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                           // id_router_011:sink_ready -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                     // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_012:sink_endofpacket
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                           // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_012:sink_valid
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                   // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_012:sink_startofpacket
	wire  [68:0] rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_data;                                            // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_012:sink_data
	wire         rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                           // id_router_012:sink_ready -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                         // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_013:sink_endofpacket
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_valid;                               // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_013:sink_valid
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                       // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_013:sink_startofpacket
	wire  [68:0] rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_data;                                // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_013:sink_data
	wire         rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_ready;                               // id_router_013:sink_ready -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                         // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_014:sink_endofpacket
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_valid;                               // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_014:sink_valid
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                       // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_014:sink_startofpacket
	wire  [68:0] rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_data;                                // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_014:sink_data
	wire         rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_ready;                               // id_router_014:sink_ready -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                            // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_015:sink_endofpacket
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                  // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_015:sink_valid
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                          // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_015:sink_startofpacket
	wire  [68:0] rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_data;                                   // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_015:sink_data
	wire         rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                  // id_router_015:sink_ready -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                    // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_016:sink_endofpacket
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                          // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_016:sink_valid
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                  // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_016:sink_startofpacket
	wire  [68:0] rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_data;                                           // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_016:sink_data
	wire         rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                          // id_router_016:sink_ready -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         addr_router_src_endofpacket;                                                                                         // addr_router:src_endofpacket -> limiter:cmd_sink_endofpacket
	wire         addr_router_src_valid;                                                                                               // addr_router:src_valid -> limiter:cmd_sink_valid
	wire         addr_router_src_startofpacket;                                                                                       // addr_router:src_startofpacket -> limiter:cmd_sink_startofpacket
	wire  [67:0] addr_router_src_data;                                                                                                // addr_router:src_data -> limiter:cmd_sink_data
	wire   [1:0] addr_router_src_channel;                                                                                             // addr_router:src_channel -> limiter:cmd_sink_channel
	wire         addr_router_src_ready;                                                                                               // limiter:cmd_sink_ready -> addr_router:src_ready
	wire         limiter_rsp_src_endofpacket;                                                                                         // limiter:rsp_src_endofpacket -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_rsp_src_valid;                                                                                               // limiter:rsp_src_valid -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_rsp_src_startofpacket;                                                                                       // limiter:rsp_src_startofpacket -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [67:0] limiter_rsp_src_data;                                                                                                // limiter:rsp_src_data -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_data
	wire   [1:0] limiter_rsp_src_channel;                                                                                             // limiter:rsp_src_channel -> merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_rsp_src_ready;                                                                                               // merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_ready -> limiter:rsp_src_ready
	wire         addr_router_001_src_endofpacket;                                                                                     // addr_router_001:src_endofpacket -> limiter_001:cmd_sink_endofpacket
	wire         addr_router_001_src_valid;                                                                                           // addr_router_001:src_valid -> limiter_001:cmd_sink_valid
	wire         addr_router_001_src_startofpacket;                                                                                   // addr_router_001:src_startofpacket -> limiter_001:cmd_sink_startofpacket
	wire  [70:0] addr_router_001_src_data;                                                                                            // addr_router_001:src_data -> limiter_001:cmd_sink_data
	wire   [7:0] addr_router_001_src_channel;                                                                                         // addr_router_001:src_channel -> limiter_001:cmd_sink_channel
	wire         addr_router_001_src_ready;                                                                                           // limiter_001:cmd_sink_ready -> addr_router_001:src_ready
	wire         limiter_001_rsp_src_endofpacket;                                                                                     // limiter_001:rsp_src_endofpacket -> tx_bridge_m0_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_001_rsp_src_valid;                                                                                           // limiter_001:rsp_src_valid -> tx_bridge_m0_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_001_rsp_src_startofpacket;                                                                                   // limiter_001:rsp_src_startofpacket -> tx_bridge_m0_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [70:0] limiter_001_rsp_src_data;                                                                                            // limiter_001:rsp_src_data -> tx_bridge_m0_translator_avalon_universal_master_0_agent:rp_data
	wire   [7:0] limiter_001_rsp_src_channel;                                                                                         // limiter_001:rsp_src_channel -> tx_bridge_m0_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_001_rsp_src_ready;                                                                                           // tx_bridge_m0_translator_avalon_universal_master_0_agent:rp_ready -> limiter_001:rsp_src_ready
	wire         addr_router_002_src_endofpacket;                                                                                     // addr_router_002:src_endofpacket -> limiter_002:cmd_sink_endofpacket
	wire         addr_router_002_src_valid;                                                                                           // addr_router_002:src_valid -> limiter_002:cmd_sink_valid
	wire         addr_router_002_src_startofpacket;                                                                                   // addr_router_002:src_startofpacket -> limiter_002:cmd_sink_startofpacket
	wire  [68:0] addr_router_002_src_data;                                                                                            // addr_router_002:src_data -> limiter_002:cmd_sink_data
	wire   [6:0] addr_router_002_src_channel;                                                                                         // addr_router_002:src_channel -> limiter_002:cmd_sink_channel
	wire         addr_router_002_src_ready;                                                                                           // limiter_002:cmd_sink_ready -> addr_router_002:src_ready
	wire         limiter_002_rsp_src_endofpacket;                                                                                     // limiter_002:rsp_src_endofpacket -> rx_bridge_m0_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_002_rsp_src_valid;                                                                                           // limiter_002:rsp_src_valid -> rx_bridge_m0_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_002_rsp_src_startofpacket;                                                                                   // limiter_002:rsp_src_startofpacket -> rx_bridge_m0_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [68:0] limiter_002_rsp_src_data;                                                                                            // limiter_002:rsp_src_data -> rx_bridge_m0_translator_avalon_universal_master_0_agent:rp_data
	wire   [6:0] limiter_002_rsp_src_channel;                                                                                         // limiter_002:rsp_src_channel -> rx_bridge_m0_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_002_rsp_src_ready;                                                                                           // rx_bridge_m0_translator_avalon_universal_master_0_agent:rp_ready -> limiter_002:rsp_src_ready
	wire         rst_controller_reset_out_reset;                                                                                      // rst_controller:reset_out -> [addr_router:reset, cmd_xbar_demux:reset, crosser:in_reset, crosser_001:in_reset, crosser_002:out_reset, crosser_003:out_reset, limiter:reset, merlin_master_translator:reset, merlin_master_translator_avalon_universal_master_0_translator:reset, merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent:reset, rsp_xbar_mux:reset]
	wire         rst_controller_001_reset_out_reset;                                                                                  // rst_controller_001:reset_out -> [addr_router_001:reset, cmd_xbar_demux_001:reset, crosser:out_reset, crosser_002:in_reset, id_router:reset, id_router_002:reset, id_router_003:reset, id_router_004:reset, id_router_005:reset, id_router_006:reset, id_router_007:reset, id_router_008:reset, id_router_009:reset, limiter_001:reset, rsp_xbar_demux:reset, rsp_xbar_demux_002:reset, rsp_xbar_demux_003:reset, rsp_xbar_demux_004:reset, rsp_xbar_demux_005:reset, rsp_xbar_demux_006:reset, rsp_xbar_demux_007:reset, rsp_xbar_demux_008:reset, rsp_xbar_demux_009:reset, rsp_xbar_mux_001:reset, rxtx_dc_fifo_link_fault_status:out_reset_n, rxtx_dc_fifo_pauselen:out_reset_n, rxtx_timing_adapter_link_fault_status_tx:reset_n, rxtx_timing_adapter_pauselen_tx:reset_n, tx_bridge:reset, tx_bridge_m0_translator:reset, tx_bridge_m0_translator_avalon_universal_master_0_agent:reset, tx_bridge_s0_translator:reset, tx_bridge_s0_translator_avalon_universal_slave_0_agent:reset, tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:reset, tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, tx_eth_address_inserter:reset, tx_eth_address_inserter_csr_translator:reset, tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:reset, tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, tx_eth_crc_inserter:reset, tx_eth_crc_inserter_csr_translator:reset, tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:reset, tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, tx_eth_frame_decoder:reset, tx_eth_frame_decoder_avalom_mm_csr_translator:reset, tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:reset, tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, tx_eth_link_fault_generation:reset, tx_eth_packet_formatter:reset, tx_eth_packet_underflow_control:reset, tx_eth_packet_underflow_control_avalon_slave_0_translator:reset, tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:reset, tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, tx_eth_pad_inserter:reset, tx_eth_pad_inserter_csr_translator:reset, tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:reset, tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, tx_eth_pause_beat_conversion:reset, tx_eth_pause_ctrl_gen:reset, tx_eth_pause_ctrl_gen_csr_translator:reset, tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:reset, tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, tx_eth_pkt_backpressure_control:reset, tx_eth_pkt_backpressure_control_csr_translator:reset, tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:reset, tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, tx_eth_statistics_collector:reset, tx_eth_statistics_collector_csr_translator:reset, tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:reset, tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, tx_eth_xgmii_termination:reset, tx_st_error_adapter_stat:reset_n, tx_st_mux_flow_control_user_frame:reset_n, tx_st_pause_ctrl_error_adapter:reset_n, tx_st_pipeline_stage_rs:reset, tx_st_timing_adapter_frame_decoder:reset_n, tx_st_timing_adapter_splitter_status_in:reset_n, tx_st_timing_adapter_splitter_status_output:reset_n, tx_st_timing_adapter_splitter_status_statistics:reset_n]
	wire         rst_controller_002_reset_out_reset;                                                                                  // rst_controller_002:reset_out -> [addr_router_002:reset, cmd_xbar_demux_002:reset, crosser_001:out_reset, crosser_003:in_reset, id_router_001:reset, id_router_010:reset, id_router_011:reset, id_router_012:reset, id_router_013:reset, id_router_014:reset, id_router_015:reset, id_router_016:reset, limiter_002:reset, rsp_xbar_demux_001:reset, rsp_xbar_demux_010:reset, rsp_xbar_demux_011:reset, rsp_xbar_demux_012:reset, rsp_xbar_demux_013:reset, rsp_xbar_demux_014:reset, rsp_xbar_demux_015:reset, rsp_xbar_demux_016:reset, rsp_xbar_mux_002:reset, rx_bridge:reset, rx_bridge_m0_translator:reset, rx_bridge_m0_translator_avalon_universal_master_0_agent:reset, rx_bridge_s0_translator:reset, rx_bridge_s0_translator_avalon_universal_slave_0_agent:reset, rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo:reset, rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rx_eth_crc_checker:reset, rx_eth_crc_checker_csr_translator:reset, rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:reset, rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rx_eth_crc_pad_rem:reset, rx_eth_crc_pad_rem_csr_translator:reset, rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:reset, rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rx_eth_frame_decoder:reset, rx_eth_frame_decoder_avalom_mm_csr_translator:reset, rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:reset, rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rx_eth_frame_status_merger:reset, rx_eth_lane_decoder:reset, rx_eth_lane_decoder_csr_translator:reset, rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:reset, rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rx_eth_link_fault_detection:reset, rx_eth_packet_overflow_control:reset, rx_eth_packet_overflow_control_csr_translator:reset, rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:reset, rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rx_eth_pkt_backpressure_control:reset, rx_eth_pkt_backpressure_control_csr_translator:reset, rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:reset, rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rx_eth_statistics_collector:reset, rx_eth_statistics_collector_csr_translator:reset, rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:reset, rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rx_st_error_adapter_stat:reset_n, rx_st_status_output_delay:reset_n, rx_st_status_statistics_delay:reset_n, rx_st_timing_adapter_frame_status_in:reset_n, rx_st_timing_adapter_interface_conversion:reset_n, rx_st_timing_adapter_lane_decoder:reset_n, rx_st_timing_adapter_link_fault_detection:reset_n, rx_st_timing_adapter_splitter_status_in:reset_n, rx_st_timing_adapter_splitter_status_output:reset_n, rx_st_timing_adapter_splitter_status_statistics:reset_n, rx_timing_adapter_frame_status_out_crc_checker:reset_n, rx_timing_adapter_frame_status_out_frame_decoder:reset_n, rxtx_dc_fifo_link_fault_status:in_reset_n, rxtx_dc_fifo_pauselen:in_reset_n, rxtx_timing_adapter_pauselen_rx:reset_n, txrx_timing_adapter_link_fault_status_export:reset_n, txrx_timing_adapter_link_fault_status_rx:reset_n]
	wire         limiter_cmd_src_endofpacket;                                                                                         // limiter:cmd_src_endofpacket -> cmd_xbar_demux:sink_endofpacket
	wire         limiter_cmd_src_startofpacket;                                                                                       // limiter:cmd_src_startofpacket -> cmd_xbar_demux:sink_startofpacket
	wire  [67:0] limiter_cmd_src_data;                                                                                                // limiter:cmd_src_data -> cmd_xbar_demux:sink_data
	wire   [1:0] limiter_cmd_src_channel;                                                                                             // limiter:cmd_src_channel -> cmd_xbar_demux:sink_channel
	wire         limiter_cmd_src_ready;                                                                                               // cmd_xbar_demux:sink_ready -> limiter:cmd_src_ready
	wire         rsp_xbar_mux_src_endofpacket;                                                                                        // rsp_xbar_mux:src_endofpacket -> limiter:rsp_sink_endofpacket
	wire         rsp_xbar_mux_src_valid;                                                                                              // rsp_xbar_mux:src_valid -> limiter:rsp_sink_valid
	wire         rsp_xbar_mux_src_startofpacket;                                                                                      // rsp_xbar_mux:src_startofpacket -> limiter:rsp_sink_startofpacket
	wire  [67:0] rsp_xbar_mux_src_data;                                                                                               // rsp_xbar_mux:src_data -> limiter:rsp_sink_data
	wire   [1:0] rsp_xbar_mux_src_channel;                                                                                            // rsp_xbar_mux:src_channel -> limiter:rsp_sink_channel
	wire         rsp_xbar_mux_src_ready;                                                                                              // limiter:rsp_sink_ready -> rsp_xbar_mux:src_ready
	wire         crosser_out_ready;                                                                                                   // tx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_ready -> crosser:out_ready
	wire         id_router_src_endofpacket;                                                                                           // id_router:src_endofpacket -> rsp_xbar_demux:sink_endofpacket
	wire         id_router_src_valid;                                                                                                 // id_router:src_valid -> rsp_xbar_demux:sink_valid
	wire         id_router_src_startofpacket;                                                                                         // id_router:src_startofpacket -> rsp_xbar_demux:sink_startofpacket
	wire  [67:0] id_router_src_data;                                                                                                  // id_router:src_data -> rsp_xbar_demux:sink_data
	wire   [1:0] id_router_src_channel;                                                                                               // id_router:src_channel -> rsp_xbar_demux:sink_channel
	wire         id_router_src_ready;                                                                                                 // rsp_xbar_demux:sink_ready -> id_router:src_ready
	wire         crosser_001_out_ready;                                                                                               // rx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_ready -> crosser_001:out_ready
	wire         id_router_001_src_endofpacket;                                                                                       // id_router_001:src_endofpacket -> rsp_xbar_demux_001:sink_endofpacket
	wire         id_router_001_src_valid;                                                                                             // id_router_001:src_valid -> rsp_xbar_demux_001:sink_valid
	wire         id_router_001_src_startofpacket;                                                                                     // id_router_001:src_startofpacket -> rsp_xbar_demux_001:sink_startofpacket
	wire  [67:0] id_router_001_src_data;                                                                                              // id_router_001:src_data -> rsp_xbar_demux_001:sink_data
	wire   [1:0] id_router_001_src_channel;                                                                                           // id_router_001:src_channel -> rsp_xbar_demux_001:sink_channel
	wire         id_router_001_src_ready;                                                                                             // rsp_xbar_demux_001:sink_ready -> id_router_001:src_ready
	wire         cmd_xbar_demux_001_src0_endofpacket;                                                                                 // cmd_xbar_demux_001:src0_endofpacket -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src0_valid;                                                                                       // cmd_xbar_demux_001:src0_valid -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src0_startofpacket;                                                                               // cmd_xbar_demux_001:src0_startofpacket -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [70:0] cmd_xbar_demux_001_src0_data;                                                                                        // cmd_xbar_demux_001:src0_data -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src0_channel;                                                                                     // cmd_xbar_demux_001:src0_channel -> tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src1_endofpacket;                                                                                 // cmd_xbar_demux_001:src1_endofpacket -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src1_valid;                                                                                       // cmd_xbar_demux_001:src1_valid -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src1_startofpacket;                                                                               // cmd_xbar_demux_001:src1_startofpacket -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [70:0] cmd_xbar_demux_001_src1_data;                                                                                        // cmd_xbar_demux_001:src1_data -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src1_channel;                                                                                     // cmd_xbar_demux_001:src1_channel -> tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src2_endofpacket;                                                                                 // cmd_xbar_demux_001:src2_endofpacket -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src2_valid;                                                                                       // cmd_xbar_demux_001:src2_valid -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src2_startofpacket;                                                                               // cmd_xbar_demux_001:src2_startofpacket -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [70:0] cmd_xbar_demux_001_src2_data;                                                                                        // cmd_xbar_demux_001:src2_data -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src2_channel;                                                                                     // cmd_xbar_demux_001:src2_channel -> tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src3_endofpacket;                                                                                 // cmd_xbar_demux_001:src3_endofpacket -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src3_valid;                                                                                       // cmd_xbar_demux_001:src3_valid -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src3_startofpacket;                                                                               // cmd_xbar_demux_001:src3_startofpacket -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [70:0] cmd_xbar_demux_001_src3_data;                                                                                        // cmd_xbar_demux_001:src3_data -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src3_channel;                                                                                     // cmd_xbar_demux_001:src3_channel -> tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src4_endofpacket;                                                                                 // cmd_xbar_demux_001:src4_endofpacket -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src4_valid;                                                                                       // cmd_xbar_demux_001:src4_valid -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src4_startofpacket;                                                                               // cmd_xbar_demux_001:src4_startofpacket -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [70:0] cmd_xbar_demux_001_src4_data;                                                                                        // cmd_xbar_demux_001:src4_data -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src4_channel;                                                                                     // cmd_xbar_demux_001:src4_channel -> tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src5_endofpacket;                                                                                 // cmd_xbar_demux_001:src5_endofpacket -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src5_valid;                                                                                       // cmd_xbar_demux_001:src5_valid -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src5_startofpacket;                                                                               // cmd_xbar_demux_001:src5_startofpacket -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [70:0] cmd_xbar_demux_001_src5_data;                                                                                        // cmd_xbar_demux_001:src5_data -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src5_channel;                                                                                     // cmd_xbar_demux_001:src5_channel -> tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src6_endofpacket;                                                                                 // cmd_xbar_demux_001:src6_endofpacket -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src6_valid;                                                                                       // cmd_xbar_demux_001:src6_valid -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src6_startofpacket;                                                                               // cmd_xbar_demux_001:src6_startofpacket -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [70:0] cmd_xbar_demux_001_src6_data;                                                                                        // cmd_xbar_demux_001:src6_data -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src6_channel;                                                                                     // cmd_xbar_demux_001:src6_channel -> tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src7_endofpacket;                                                                                 // cmd_xbar_demux_001:src7_endofpacket -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_001_src7_valid;                                                                                       // cmd_xbar_demux_001:src7_valid -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_001_src7_startofpacket;                                                                               // cmd_xbar_demux_001:src7_startofpacket -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [70:0] cmd_xbar_demux_001_src7_data;                                                                                        // cmd_xbar_demux_001:src7_data -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [7:0] cmd_xbar_demux_001_src7_channel;                                                                                     // cmd_xbar_demux_001:src7_channel -> tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         rsp_xbar_demux_002_src0_endofpacket;                                                                                 // rsp_xbar_demux_002:src0_endofpacket -> rsp_xbar_mux_001:sink0_endofpacket
	wire         rsp_xbar_demux_002_src0_valid;                                                                                       // rsp_xbar_demux_002:src0_valid -> rsp_xbar_mux_001:sink0_valid
	wire         rsp_xbar_demux_002_src0_startofpacket;                                                                               // rsp_xbar_demux_002:src0_startofpacket -> rsp_xbar_mux_001:sink0_startofpacket
	wire  [70:0] rsp_xbar_demux_002_src0_data;                                                                                        // rsp_xbar_demux_002:src0_data -> rsp_xbar_mux_001:sink0_data
	wire   [7:0] rsp_xbar_demux_002_src0_channel;                                                                                     // rsp_xbar_demux_002:src0_channel -> rsp_xbar_mux_001:sink0_channel
	wire         rsp_xbar_demux_002_src0_ready;                                                                                       // rsp_xbar_mux_001:sink0_ready -> rsp_xbar_demux_002:src0_ready
	wire         rsp_xbar_demux_003_src0_endofpacket;                                                                                 // rsp_xbar_demux_003:src0_endofpacket -> rsp_xbar_mux_001:sink1_endofpacket
	wire         rsp_xbar_demux_003_src0_valid;                                                                                       // rsp_xbar_demux_003:src0_valid -> rsp_xbar_mux_001:sink1_valid
	wire         rsp_xbar_demux_003_src0_startofpacket;                                                                               // rsp_xbar_demux_003:src0_startofpacket -> rsp_xbar_mux_001:sink1_startofpacket
	wire  [70:0] rsp_xbar_demux_003_src0_data;                                                                                        // rsp_xbar_demux_003:src0_data -> rsp_xbar_mux_001:sink1_data
	wire   [7:0] rsp_xbar_demux_003_src0_channel;                                                                                     // rsp_xbar_demux_003:src0_channel -> rsp_xbar_mux_001:sink1_channel
	wire         rsp_xbar_demux_003_src0_ready;                                                                                       // rsp_xbar_mux_001:sink1_ready -> rsp_xbar_demux_003:src0_ready
	wire         rsp_xbar_demux_004_src0_endofpacket;                                                                                 // rsp_xbar_demux_004:src0_endofpacket -> rsp_xbar_mux_001:sink2_endofpacket
	wire         rsp_xbar_demux_004_src0_valid;                                                                                       // rsp_xbar_demux_004:src0_valid -> rsp_xbar_mux_001:sink2_valid
	wire         rsp_xbar_demux_004_src0_startofpacket;                                                                               // rsp_xbar_demux_004:src0_startofpacket -> rsp_xbar_mux_001:sink2_startofpacket
	wire  [70:0] rsp_xbar_demux_004_src0_data;                                                                                        // rsp_xbar_demux_004:src0_data -> rsp_xbar_mux_001:sink2_data
	wire   [7:0] rsp_xbar_demux_004_src0_channel;                                                                                     // rsp_xbar_demux_004:src0_channel -> rsp_xbar_mux_001:sink2_channel
	wire         rsp_xbar_demux_004_src0_ready;                                                                                       // rsp_xbar_mux_001:sink2_ready -> rsp_xbar_demux_004:src0_ready
	wire         rsp_xbar_demux_005_src0_endofpacket;                                                                                 // rsp_xbar_demux_005:src0_endofpacket -> rsp_xbar_mux_001:sink3_endofpacket
	wire         rsp_xbar_demux_005_src0_valid;                                                                                       // rsp_xbar_demux_005:src0_valid -> rsp_xbar_mux_001:sink3_valid
	wire         rsp_xbar_demux_005_src0_startofpacket;                                                                               // rsp_xbar_demux_005:src0_startofpacket -> rsp_xbar_mux_001:sink3_startofpacket
	wire  [70:0] rsp_xbar_demux_005_src0_data;                                                                                        // rsp_xbar_demux_005:src0_data -> rsp_xbar_mux_001:sink3_data
	wire   [7:0] rsp_xbar_demux_005_src0_channel;                                                                                     // rsp_xbar_demux_005:src0_channel -> rsp_xbar_mux_001:sink3_channel
	wire         rsp_xbar_demux_005_src0_ready;                                                                                       // rsp_xbar_mux_001:sink3_ready -> rsp_xbar_demux_005:src0_ready
	wire         rsp_xbar_demux_006_src0_endofpacket;                                                                                 // rsp_xbar_demux_006:src0_endofpacket -> rsp_xbar_mux_001:sink4_endofpacket
	wire         rsp_xbar_demux_006_src0_valid;                                                                                       // rsp_xbar_demux_006:src0_valid -> rsp_xbar_mux_001:sink4_valid
	wire         rsp_xbar_demux_006_src0_startofpacket;                                                                               // rsp_xbar_demux_006:src0_startofpacket -> rsp_xbar_mux_001:sink4_startofpacket
	wire  [70:0] rsp_xbar_demux_006_src0_data;                                                                                        // rsp_xbar_demux_006:src0_data -> rsp_xbar_mux_001:sink4_data
	wire   [7:0] rsp_xbar_demux_006_src0_channel;                                                                                     // rsp_xbar_demux_006:src0_channel -> rsp_xbar_mux_001:sink4_channel
	wire         rsp_xbar_demux_006_src0_ready;                                                                                       // rsp_xbar_mux_001:sink4_ready -> rsp_xbar_demux_006:src0_ready
	wire         rsp_xbar_demux_007_src0_endofpacket;                                                                                 // rsp_xbar_demux_007:src0_endofpacket -> rsp_xbar_mux_001:sink5_endofpacket
	wire         rsp_xbar_demux_007_src0_valid;                                                                                       // rsp_xbar_demux_007:src0_valid -> rsp_xbar_mux_001:sink5_valid
	wire         rsp_xbar_demux_007_src0_startofpacket;                                                                               // rsp_xbar_demux_007:src0_startofpacket -> rsp_xbar_mux_001:sink5_startofpacket
	wire  [70:0] rsp_xbar_demux_007_src0_data;                                                                                        // rsp_xbar_demux_007:src0_data -> rsp_xbar_mux_001:sink5_data
	wire   [7:0] rsp_xbar_demux_007_src0_channel;                                                                                     // rsp_xbar_demux_007:src0_channel -> rsp_xbar_mux_001:sink5_channel
	wire         rsp_xbar_demux_007_src0_ready;                                                                                       // rsp_xbar_mux_001:sink5_ready -> rsp_xbar_demux_007:src0_ready
	wire         rsp_xbar_demux_008_src0_endofpacket;                                                                                 // rsp_xbar_demux_008:src0_endofpacket -> rsp_xbar_mux_001:sink6_endofpacket
	wire         rsp_xbar_demux_008_src0_valid;                                                                                       // rsp_xbar_demux_008:src0_valid -> rsp_xbar_mux_001:sink6_valid
	wire         rsp_xbar_demux_008_src0_startofpacket;                                                                               // rsp_xbar_demux_008:src0_startofpacket -> rsp_xbar_mux_001:sink6_startofpacket
	wire  [70:0] rsp_xbar_demux_008_src0_data;                                                                                        // rsp_xbar_demux_008:src0_data -> rsp_xbar_mux_001:sink6_data
	wire   [7:0] rsp_xbar_demux_008_src0_channel;                                                                                     // rsp_xbar_demux_008:src0_channel -> rsp_xbar_mux_001:sink6_channel
	wire         rsp_xbar_demux_008_src0_ready;                                                                                       // rsp_xbar_mux_001:sink6_ready -> rsp_xbar_demux_008:src0_ready
	wire         rsp_xbar_demux_009_src0_endofpacket;                                                                                 // rsp_xbar_demux_009:src0_endofpacket -> rsp_xbar_mux_001:sink7_endofpacket
	wire         rsp_xbar_demux_009_src0_valid;                                                                                       // rsp_xbar_demux_009:src0_valid -> rsp_xbar_mux_001:sink7_valid
	wire         rsp_xbar_demux_009_src0_startofpacket;                                                                               // rsp_xbar_demux_009:src0_startofpacket -> rsp_xbar_mux_001:sink7_startofpacket
	wire  [70:0] rsp_xbar_demux_009_src0_data;                                                                                        // rsp_xbar_demux_009:src0_data -> rsp_xbar_mux_001:sink7_data
	wire   [7:0] rsp_xbar_demux_009_src0_channel;                                                                                     // rsp_xbar_demux_009:src0_channel -> rsp_xbar_mux_001:sink7_channel
	wire         rsp_xbar_demux_009_src0_ready;                                                                                       // rsp_xbar_mux_001:sink7_ready -> rsp_xbar_demux_009:src0_ready
	wire         limiter_001_cmd_src_endofpacket;                                                                                     // limiter_001:cmd_src_endofpacket -> cmd_xbar_demux_001:sink_endofpacket
	wire         limiter_001_cmd_src_startofpacket;                                                                                   // limiter_001:cmd_src_startofpacket -> cmd_xbar_demux_001:sink_startofpacket
	wire  [70:0] limiter_001_cmd_src_data;                                                                                            // limiter_001:cmd_src_data -> cmd_xbar_demux_001:sink_data
	wire   [7:0] limiter_001_cmd_src_channel;                                                                                         // limiter_001:cmd_src_channel -> cmd_xbar_demux_001:sink_channel
	wire         limiter_001_cmd_src_ready;                                                                                           // cmd_xbar_demux_001:sink_ready -> limiter_001:cmd_src_ready
	wire         rsp_xbar_mux_001_src_endofpacket;                                                                                    // rsp_xbar_mux_001:src_endofpacket -> limiter_001:rsp_sink_endofpacket
	wire         rsp_xbar_mux_001_src_valid;                                                                                          // rsp_xbar_mux_001:src_valid -> limiter_001:rsp_sink_valid
	wire         rsp_xbar_mux_001_src_startofpacket;                                                                                  // rsp_xbar_mux_001:src_startofpacket -> limiter_001:rsp_sink_startofpacket
	wire  [70:0] rsp_xbar_mux_001_src_data;                                                                                           // rsp_xbar_mux_001:src_data -> limiter_001:rsp_sink_data
	wire   [7:0] rsp_xbar_mux_001_src_channel;                                                                                        // rsp_xbar_mux_001:src_channel -> limiter_001:rsp_sink_channel
	wire         rsp_xbar_mux_001_src_ready;                                                                                          // limiter_001:rsp_sink_ready -> rsp_xbar_mux_001:src_ready
	wire         cmd_xbar_demux_001_src0_ready;                                                                                       // tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src0_ready
	wire         id_router_002_src_endofpacket;                                                                                       // id_router_002:src_endofpacket -> rsp_xbar_demux_002:sink_endofpacket
	wire         id_router_002_src_valid;                                                                                             // id_router_002:src_valid -> rsp_xbar_demux_002:sink_valid
	wire         id_router_002_src_startofpacket;                                                                                     // id_router_002:src_startofpacket -> rsp_xbar_demux_002:sink_startofpacket
	wire  [70:0] id_router_002_src_data;                                                                                              // id_router_002:src_data -> rsp_xbar_demux_002:sink_data
	wire   [7:0] id_router_002_src_channel;                                                                                           // id_router_002:src_channel -> rsp_xbar_demux_002:sink_channel
	wire         id_router_002_src_ready;                                                                                             // rsp_xbar_demux_002:sink_ready -> id_router_002:src_ready
	wire         cmd_xbar_demux_001_src1_ready;                                                                                       // tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src1_ready
	wire         id_router_003_src_endofpacket;                                                                                       // id_router_003:src_endofpacket -> rsp_xbar_demux_003:sink_endofpacket
	wire         id_router_003_src_valid;                                                                                             // id_router_003:src_valid -> rsp_xbar_demux_003:sink_valid
	wire         id_router_003_src_startofpacket;                                                                                     // id_router_003:src_startofpacket -> rsp_xbar_demux_003:sink_startofpacket
	wire  [70:0] id_router_003_src_data;                                                                                              // id_router_003:src_data -> rsp_xbar_demux_003:sink_data
	wire   [7:0] id_router_003_src_channel;                                                                                           // id_router_003:src_channel -> rsp_xbar_demux_003:sink_channel
	wire         id_router_003_src_ready;                                                                                             // rsp_xbar_demux_003:sink_ready -> id_router_003:src_ready
	wire         cmd_xbar_demux_001_src2_ready;                                                                                       // tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src2_ready
	wire         id_router_004_src_endofpacket;                                                                                       // id_router_004:src_endofpacket -> rsp_xbar_demux_004:sink_endofpacket
	wire         id_router_004_src_valid;                                                                                             // id_router_004:src_valid -> rsp_xbar_demux_004:sink_valid
	wire         id_router_004_src_startofpacket;                                                                                     // id_router_004:src_startofpacket -> rsp_xbar_demux_004:sink_startofpacket
	wire  [70:0] id_router_004_src_data;                                                                                              // id_router_004:src_data -> rsp_xbar_demux_004:sink_data
	wire   [7:0] id_router_004_src_channel;                                                                                           // id_router_004:src_channel -> rsp_xbar_demux_004:sink_channel
	wire         id_router_004_src_ready;                                                                                             // rsp_xbar_demux_004:sink_ready -> id_router_004:src_ready
	wire         cmd_xbar_demux_001_src3_ready;                                                                                       // tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src3_ready
	wire         id_router_005_src_endofpacket;                                                                                       // id_router_005:src_endofpacket -> rsp_xbar_demux_005:sink_endofpacket
	wire         id_router_005_src_valid;                                                                                             // id_router_005:src_valid -> rsp_xbar_demux_005:sink_valid
	wire         id_router_005_src_startofpacket;                                                                                     // id_router_005:src_startofpacket -> rsp_xbar_demux_005:sink_startofpacket
	wire  [70:0] id_router_005_src_data;                                                                                              // id_router_005:src_data -> rsp_xbar_demux_005:sink_data
	wire   [7:0] id_router_005_src_channel;                                                                                           // id_router_005:src_channel -> rsp_xbar_demux_005:sink_channel
	wire         id_router_005_src_ready;                                                                                             // rsp_xbar_demux_005:sink_ready -> id_router_005:src_ready
	wire         cmd_xbar_demux_001_src4_ready;                                                                                       // tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src4_ready
	wire         id_router_006_src_endofpacket;                                                                                       // id_router_006:src_endofpacket -> rsp_xbar_demux_006:sink_endofpacket
	wire         id_router_006_src_valid;                                                                                             // id_router_006:src_valid -> rsp_xbar_demux_006:sink_valid
	wire         id_router_006_src_startofpacket;                                                                                     // id_router_006:src_startofpacket -> rsp_xbar_demux_006:sink_startofpacket
	wire  [70:0] id_router_006_src_data;                                                                                              // id_router_006:src_data -> rsp_xbar_demux_006:sink_data
	wire   [7:0] id_router_006_src_channel;                                                                                           // id_router_006:src_channel -> rsp_xbar_demux_006:sink_channel
	wire         id_router_006_src_ready;                                                                                             // rsp_xbar_demux_006:sink_ready -> id_router_006:src_ready
	wire         cmd_xbar_demux_001_src5_ready;                                                                                       // tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src5_ready
	wire         id_router_007_src_endofpacket;                                                                                       // id_router_007:src_endofpacket -> rsp_xbar_demux_007:sink_endofpacket
	wire         id_router_007_src_valid;                                                                                             // id_router_007:src_valid -> rsp_xbar_demux_007:sink_valid
	wire         id_router_007_src_startofpacket;                                                                                     // id_router_007:src_startofpacket -> rsp_xbar_demux_007:sink_startofpacket
	wire  [70:0] id_router_007_src_data;                                                                                              // id_router_007:src_data -> rsp_xbar_demux_007:sink_data
	wire   [7:0] id_router_007_src_channel;                                                                                           // id_router_007:src_channel -> rsp_xbar_demux_007:sink_channel
	wire         id_router_007_src_ready;                                                                                             // rsp_xbar_demux_007:sink_ready -> id_router_007:src_ready
	wire         cmd_xbar_demux_001_src6_ready;                                                                                       // tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src6_ready
	wire         id_router_008_src_endofpacket;                                                                                       // id_router_008:src_endofpacket -> rsp_xbar_demux_008:sink_endofpacket
	wire         id_router_008_src_valid;                                                                                             // id_router_008:src_valid -> rsp_xbar_demux_008:sink_valid
	wire         id_router_008_src_startofpacket;                                                                                     // id_router_008:src_startofpacket -> rsp_xbar_demux_008:sink_startofpacket
	wire  [70:0] id_router_008_src_data;                                                                                              // id_router_008:src_data -> rsp_xbar_demux_008:sink_data
	wire   [7:0] id_router_008_src_channel;                                                                                           // id_router_008:src_channel -> rsp_xbar_demux_008:sink_channel
	wire         id_router_008_src_ready;                                                                                             // rsp_xbar_demux_008:sink_ready -> id_router_008:src_ready
	wire         cmd_xbar_demux_001_src7_ready;                                                                                       // tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_001:src7_ready
	wire         id_router_009_src_endofpacket;                                                                                       // id_router_009:src_endofpacket -> rsp_xbar_demux_009:sink_endofpacket
	wire         id_router_009_src_valid;                                                                                             // id_router_009:src_valid -> rsp_xbar_demux_009:sink_valid
	wire         id_router_009_src_startofpacket;                                                                                     // id_router_009:src_startofpacket -> rsp_xbar_demux_009:sink_startofpacket
	wire  [70:0] id_router_009_src_data;                                                                                              // id_router_009:src_data -> rsp_xbar_demux_009:sink_data
	wire   [7:0] id_router_009_src_channel;                                                                                           // id_router_009:src_channel -> rsp_xbar_demux_009:sink_channel
	wire         id_router_009_src_ready;                                                                                             // rsp_xbar_demux_009:sink_ready -> id_router_009:src_ready
	wire         cmd_xbar_demux_002_src0_endofpacket;                                                                                 // cmd_xbar_demux_002:src0_endofpacket -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_002_src0_valid;                                                                                       // cmd_xbar_demux_002:src0_valid -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_002_src0_startofpacket;                                                                               // cmd_xbar_demux_002:src0_startofpacket -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [68:0] cmd_xbar_demux_002_src0_data;                                                                                        // cmd_xbar_demux_002:src0_data -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [6:0] cmd_xbar_demux_002_src0_channel;                                                                                     // cmd_xbar_demux_002:src0_channel -> rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_002_src1_endofpacket;                                                                                 // cmd_xbar_demux_002:src1_endofpacket -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_002_src1_valid;                                                                                       // cmd_xbar_demux_002:src1_valid -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_002_src1_startofpacket;                                                                               // cmd_xbar_demux_002:src1_startofpacket -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [68:0] cmd_xbar_demux_002_src1_data;                                                                                        // cmd_xbar_demux_002:src1_data -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [6:0] cmd_xbar_demux_002_src1_channel;                                                                                     // cmd_xbar_demux_002:src1_channel -> rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_002_src2_endofpacket;                                                                                 // cmd_xbar_demux_002:src2_endofpacket -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_002_src2_valid;                                                                                       // cmd_xbar_demux_002:src2_valid -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_002_src2_startofpacket;                                                                               // cmd_xbar_demux_002:src2_startofpacket -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [68:0] cmd_xbar_demux_002_src2_data;                                                                                        // cmd_xbar_demux_002:src2_data -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [6:0] cmd_xbar_demux_002_src2_channel;                                                                                     // cmd_xbar_demux_002:src2_channel -> rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_002_src3_endofpacket;                                                                                 // cmd_xbar_demux_002:src3_endofpacket -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_002_src3_valid;                                                                                       // cmd_xbar_demux_002:src3_valid -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_002_src3_startofpacket;                                                                               // cmd_xbar_demux_002:src3_startofpacket -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [68:0] cmd_xbar_demux_002_src3_data;                                                                                        // cmd_xbar_demux_002:src3_data -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [6:0] cmd_xbar_demux_002_src3_channel;                                                                                     // cmd_xbar_demux_002:src3_channel -> rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_002_src4_endofpacket;                                                                                 // cmd_xbar_demux_002:src4_endofpacket -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_002_src4_valid;                                                                                       // cmd_xbar_demux_002:src4_valid -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_002_src4_startofpacket;                                                                               // cmd_xbar_demux_002:src4_startofpacket -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [68:0] cmd_xbar_demux_002_src4_data;                                                                                        // cmd_xbar_demux_002:src4_data -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [6:0] cmd_xbar_demux_002_src4_channel;                                                                                     // cmd_xbar_demux_002:src4_channel -> rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_002_src5_endofpacket;                                                                                 // cmd_xbar_demux_002:src5_endofpacket -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_002_src5_valid;                                                                                       // cmd_xbar_demux_002:src5_valid -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_002_src5_startofpacket;                                                                               // cmd_xbar_demux_002:src5_startofpacket -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [68:0] cmd_xbar_demux_002_src5_data;                                                                                        // cmd_xbar_demux_002:src5_data -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [6:0] cmd_xbar_demux_002_src5_channel;                                                                                     // cmd_xbar_demux_002:src5_channel -> rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_002_src6_endofpacket;                                                                                 // cmd_xbar_demux_002:src6_endofpacket -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_002_src6_valid;                                                                                       // cmd_xbar_demux_002:src6_valid -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_002_src6_startofpacket;                                                                               // cmd_xbar_demux_002:src6_startofpacket -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [68:0] cmd_xbar_demux_002_src6_data;                                                                                        // cmd_xbar_demux_002:src6_data -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [6:0] cmd_xbar_demux_002_src6_channel;                                                                                     // cmd_xbar_demux_002:src6_channel -> rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         rsp_xbar_demux_010_src0_endofpacket;                                                                                 // rsp_xbar_demux_010:src0_endofpacket -> rsp_xbar_mux_002:sink0_endofpacket
	wire         rsp_xbar_demux_010_src0_valid;                                                                                       // rsp_xbar_demux_010:src0_valid -> rsp_xbar_mux_002:sink0_valid
	wire         rsp_xbar_demux_010_src0_startofpacket;                                                                               // rsp_xbar_demux_010:src0_startofpacket -> rsp_xbar_mux_002:sink0_startofpacket
	wire  [68:0] rsp_xbar_demux_010_src0_data;                                                                                        // rsp_xbar_demux_010:src0_data -> rsp_xbar_mux_002:sink0_data
	wire   [6:0] rsp_xbar_demux_010_src0_channel;                                                                                     // rsp_xbar_demux_010:src0_channel -> rsp_xbar_mux_002:sink0_channel
	wire         rsp_xbar_demux_010_src0_ready;                                                                                       // rsp_xbar_mux_002:sink0_ready -> rsp_xbar_demux_010:src0_ready
	wire         rsp_xbar_demux_011_src0_endofpacket;                                                                                 // rsp_xbar_demux_011:src0_endofpacket -> rsp_xbar_mux_002:sink1_endofpacket
	wire         rsp_xbar_demux_011_src0_valid;                                                                                       // rsp_xbar_demux_011:src0_valid -> rsp_xbar_mux_002:sink1_valid
	wire         rsp_xbar_demux_011_src0_startofpacket;                                                                               // rsp_xbar_demux_011:src0_startofpacket -> rsp_xbar_mux_002:sink1_startofpacket
	wire  [68:0] rsp_xbar_demux_011_src0_data;                                                                                        // rsp_xbar_demux_011:src0_data -> rsp_xbar_mux_002:sink1_data
	wire   [6:0] rsp_xbar_demux_011_src0_channel;                                                                                     // rsp_xbar_demux_011:src0_channel -> rsp_xbar_mux_002:sink1_channel
	wire         rsp_xbar_demux_011_src0_ready;                                                                                       // rsp_xbar_mux_002:sink1_ready -> rsp_xbar_demux_011:src0_ready
	wire         rsp_xbar_demux_012_src0_endofpacket;                                                                                 // rsp_xbar_demux_012:src0_endofpacket -> rsp_xbar_mux_002:sink2_endofpacket
	wire         rsp_xbar_demux_012_src0_valid;                                                                                       // rsp_xbar_demux_012:src0_valid -> rsp_xbar_mux_002:sink2_valid
	wire         rsp_xbar_demux_012_src0_startofpacket;                                                                               // rsp_xbar_demux_012:src0_startofpacket -> rsp_xbar_mux_002:sink2_startofpacket
	wire  [68:0] rsp_xbar_demux_012_src0_data;                                                                                        // rsp_xbar_demux_012:src0_data -> rsp_xbar_mux_002:sink2_data
	wire   [6:0] rsp_xbar_demux_012_src0_channel;                                                                                     // rsp_xbar_demux_012:src0_channel -> rsp_xbar_mux_002:sink2_channel
	wire         rsp_xbar_demux_012_src0_ready;                                                                                       // rsp_xbar_mux_002:sink2_ready -> rsp_xbar_demux_012:src0_ready
	wire         rsp_xbar_demux_013_src0_endofpacket;                                                                                 // rsp_xbar_demux_013:src0_endofpacket -> rsp_xbar_mux_002:sink3_endofpacket
	wire         rsp_xbar_demux_013_src0_valid;                                                                                       // rsp_xbar_demux_013:src0_valid -> rsp_xbar_mux_002:sink3_valid
	wire         rsp_xbar_demux_013_src0_startofpacket;                                                                               // rsp_xbar_demux_013:src0_startofpacket -> rsp_xbar_mux_002:sink3_startofpacket
	wire  [68:0] rsp_xbar_demux_013_src0_data;                                                                                        // rsp_xbar_demux_013:src0_data -> rsp_xbar_mux_002:sink3_data
	wire   [6:0] rsp_xbar_demux_013_src0_channel;                                                                                     // rsp_xbar_demux_013:src0_channel -> rsp_xbar_mux_002:sink3_channel
	wire         rsp_xbar_demux_013_src0_ready;                                                                                       // rsp_xbar_mux_002:sink3_ready -> rsp_xbar_demux_013:src0_ready
	wire         rsp_xbar_demux_014_src0_endofpacket;                                                                                 // rsp_xbar_demux_014:src0_endofpacket -> rsp_xbar_mux_002:sink4_endofpacket
	wire         rsp_xbar_demux_014_src0_valid;                                                                                       // rsp_xbar_demux_014:src0_valid -> rsp_xbar_mux_002:sink4_valid
	wire         rsp_xbar_demux_014_src0_startofpacket;                                                                               // rsp_xbar_demux_014:src0_startofpacket -> rsp_xbar_mux_002:sink4_startofpacket
	wire  [68:0] rsp_xbar_demux_014_src0_data;                                                                                        // rsp_xbar_demux_014:src0_data -> rsp_xbar_mux_002:sink4_data
	wire   [6:0] rsp_xbar_demux_014_src0_channel;                                                                                     // rsp_xbar_demux_014:src0_channel -> rsp_xbar_mux_002:sink4_channel
	wire         rsp_xbar_demux_014_src0_ready;                                                                                       // rsp_xbar_mux_002:sink4_ready -> rsp_xbar_demux_014:src0_ready
	wire         rsp_xbar_demux_015_src0_endofpacket;                                                                                 // rsp_xbar_demux_015:src0_endofpacket -> rsp_xbar_mux_002:sink5_endofpacket
	wire         rsp_xbar_demux_015_src0_valid;                                                                                       // rsp_xbar_demux_015:src0_valid -> rsp_xbar_mux_002:sink5_valid
	wire         rsp_xbar_demux_015_src0_startofpacket;                                                                               // rsp_xbar_demux_015:src0_startofpacket -> rsp_xbar_mux_002:sink5_startofpacket
	wire  [68:0] rsp_xbar_demux_015_src0_data;                                                                                        // rsp_xbar_demux_015:src0_data -> rsp_xbar_mux_002:sink5_data
	wire   [6:0] rsp_xbar_demux_015_src0_channel;                                                                                     // rsp_xbar_demux_015:src0_channel -> rsp_xbar_mux_002:sink5_channel
	wire         rsp_xbar_demux_015_src0_ready;                                                                                       // rsp_xbar_mux_002:sink5_ready -> rsp_xbar_demux_015:src0_ready
	wire         rsp_xbar_demux_016_src0_endofpacket;                                                                                 // rsp_xbar_demux_016:src0_endofpacket -> rsp_xbar_mux_002:sink6_endofpacket
	wire         rsp_xbar_demux_016_src0_valid;                                                                                       // rsp_xbar_demux_016:src0_valid -> rsp_xbar_mux_002:sink6_valid
	wire         rsp_xbar_demux_016_src0_startofpacket;                                                                               // rsp_xbar_demux_016:src0_startofpacket -> rsp_xbar_mux_002:sink6_startofpacket
	wire  [68:0] rsp_xbar_demux_016_src0_data;                                                                                        // rsp_xbar_demux_016:src0_data -> rsp_xbar_mux_002:sink6_data
	wire   [6:0] rsp_xbar_demux_016_src0_channel;                                                                                     // rsp_xbar_demux_016:src0_channel -> rsp_xbar_mux_002:sink6_channel
	wire         rsp_xbar_demux_016_src0_ready;                                                                                       // rsp_xbar_mux_002:sink6_ready -> rsp_xbar_demux_016:src0_ready
	wire         limiter_002_cmd_src_endofpacket;                                                                                     // limiter_002:cmd_src_endofpacket -> cmd_xbar_demux_002:sink_endofpacket
	wire         limiter_002_cmd_src_startofpacket;                                                                                   // limiter_002:cmd_src_startofpacket -> cmd_xbar_demux_002:sink_startofpacket
	wire  [68:0] limiter_002_cmd_src_data;                                                                                            // limiter_002:cmd_src_data -> cmd_xbar_demux_002:sink_data
	wire   [6:0] limiter_002_cmd_src_channel;                                                                                         // limiter_002:cmd_src_channel -> cmd_xbar_demux_002:sink_channel
	wire         limiter_002_cmd_src_ready;                                                                                           // cmd_xbar_demux_002:sink_ready -> limiter_002:cmd_src_ready
	wire         rsp_xbar_mux_002_src_endofpacket;                                                                                    // rsp_xbar_mux_002:src_endofpacket -> limiter_002:rsp_sink_endofpacket
	wire         rsp_xbar_mux_002_src_valid;                                                                                          // rsp_xbar_mux_002:src_valid -> limiter_002:rsp_sink_valid
	wire         rsp_xbar_mux_002_src_startofpacket;                                                                                  // rsp_xbar_mux_002:src_startofpacket -> limiter_002:rsp_sink_startofpacket
	wire  [68:0] rsp_xbar_mux_002_src_data;                                                                                           // rsp_xbar_mux_002:src_data -> limiter_002:rsp_sink_data
	wire   [6:0] rsp_xbar_mux_002_src_channel;                                                                                        // rsp_xbar_mux_002:src_channel -> limiter_002:rsp_sink_channel
	wire         rsp_xbar_mux_002_src_ready;                                                                                          // limiter_002:rsp_sink_ready -> rsp_xbar_mux_002:src_ready
	wire         cmd_xbar_demux_002_src0_ready;                                                                                       // rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_002:src0_ready
	wire         id_router_010_src_endofpacket;                                                                                       // id_router_010:src_endofpacket -> rsp_xbar_demux_010:sink_endofpacket
	wire         id_router_010_src_valid;                                                                                             // id_router_010:src_valid -> rsp_xbar_demux_010:sink_valid
	wire         id_router_010_src_startofpacket;                                                                                     // id_router_010:src_startofpacket -> rsp_xbar_demux_010:sink_startofpacket
	wire  [68:0] id_router_010_src_data;                                                                                              // id_router_010:src_data -> rsp_xbar_demux_010:sink_data
	wire   [6:0] id_router_010_src_channel;                                                                                           // id_router_010:src_channel -> rsp_xbar_demux_010:sink_channel
	wire         id_router_010_src_ready;                                                                                             // rsp_xbar_demux_010:sink_ready -> id_router_010:src_ready
	wire         cmd_xbar_demux_002_src1_ready;                                                                                       // rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_002:src1_ready
	wire         id_router_011_src_endofpacket;                                                                                       // id_router_011:src_endofpacket -> rsp_xbar_demux_011:sink_endofpacket
	wire         id_router_011_src_valid;                                                                                             // id_router_011:src_valid -> rsp_xbar_demux_011:sink_valid
	wire         id_router_011_src_startofpacket;                                                                                     // id_router_011:src_startofpacket -> rsp_xbar_demux_011:sink_startofpacket
	wire  [68:0] id_router_011_src_data;                                                                                              // id_router_011:src_data -> rsp_xbar_demux_011:sink_data
	wire   [6:0] id_router_011_src_channel;                                                                                           // id_router_011:src_channel -> rsp_xbar_demux_011:sink_channel
	wire         id_router_011_src_ready;                                                                                             // rsp_xbar_demux_011:sink_ready -> id_router_011:src_ready
	wire         cmd_xbar_demux_002_src2_ready;                                                                                       // rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_002:src2_ready
	wire         id_router_012_src_endofpacket;                                                                                       // id_router_012:src_endofpacket -> rsp_xbar_demux_012:sink_endofpacket
	wire         id_router_012_src_valid;                                                                                             // id_router_012:src_valid -> rsp_xbar_demux_012:sink_valid
	wire         id_router_012_src_startofpacket;                                                                                     // id_router_012:src_startofpacket -> rsp_xbar_demux_012:sink_startofpacket
	wire  [68:0] id_router_012_src_data;                                                                                              // id_router_012:src_data -> rsp_xbar_demux_012:sink_data
	wire   [6:0] id_router_012_src_channel;                                                                                           // id_router_012:src_channel -> rsp_xbar_demux_012:sink_channel
	wire         id_router_012_src_ready;                                                                                             // rsp_xbar_demux_012:sink_ready -> id_router_012:src_ready
	wire         cmd_xbar_demux_002_src3_ready;                                                                                       // rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_002:src3_ready
	wire         id_router_013_src_endofpacket;                                                                                       // id_router_013:src_endofpacket -> rsp_xbar_demux_013:sink_endofpacket
	wire         id_router_013_src_valid;                                                                                             // id_router_013:src_valid -> rsp_xbar_demux_013:sink_valid
	wire         id_router_013_src_startofpacket;                                                                                     // id_router_013:src_startofpacket -> rsp_xbar_demux_013:sink_startofpacket
	wire  [68:0] id_router_013_src_data;                                                                                              // id_router_013:src_data -> rsp_xbar_demux_013:sink_data
	wire   [6:0] id_router_013_src_channel;                                                                                           // id_router_013:src_channel -> rsp_xbar_demux_013:sink_channel
	wire         id_router_013_src_ready;                                                                                             // rsp_xbar_demux_013:sink_ready -> id_router_013:src_ready
	wire         cmd_xbar_demux_002_src4_ready;                                                                                       // rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_002:src4_ready
	wire         id_router_014_src_endofpacket;                                                                                       // id_router_014:src_endofpacket -> rsp_xbar_demux_014:sink_endofpacket
	wire         id_router_014_src_valid;                                                                                             // id_router_014:src_valid -> rsp_xbar_demux_014:sink_valid
	wire         id_router_014_src_startofpacket;                                                                                     // id_router_014:src_startofpacket -> rsp_xbar_demux_014:sink_startofpacket
	wire  [68:0] id_router_014_src_data;                                                                                              // id_router_014:src_data -> rsp_xbar_demux_014:sink_data
	wire   [6:0] id_router_014_src_channel;                                                                                           // id_router_014:src_channel -> rsp_xbar_demux_014:sink_channel
	wire         id_router_014_src_ready;                                                                                             // rsp_xbar_demux_014:sink_ready -> id_router_014:src_ready
	wire         cmd_xbar_demux_002_src5_ready;                                                                                       // rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_002:src5_ready
	wire         id_router_015_src_endofpacket;                                                                                       // id_router_015:src_endofpacket -> rsp_xbar_demux_015:sink_endofpacket
	wire         id_router_015_src_valid;                                                                                             // id_router_015:src_valid -> rsp_xbar_demux_015:sink_valid
	wire         id_router_015_src_startofpacket;                                                                                     // id_router_015:src_startofpacket -> rsp_xbar_demux_015:sink_startofpacket
	wire  [68:0] id_router_015_src_data;                                                                                              // id_router_015:src_data -> rsp_xbar_demux_015:sink_data
	wire   [6:0] id_router_015_src_channel;                                                                                           // id_router_015:src_channel -> rsp_xbar_demux_015:sink_channel
	wire         id_router_015_src_ready;                                                                                             // rsp_xbar_demux_015:sink_ready -> id_router_015:src_ready
	wire         cmd_xbar_demux_002_src6_ready;                                                                                       // rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux_002:src6_ready
	wire         id_router_016_src_endofpacket;                                                                                       // id_router_016:src_endofpacket -> rsp_xbar_demux_016:sink_endofpacket
	wire         id_router_016_src_valid;                                                                                             // id_router_016:src_valid -> rsp_xbar_demux_016:sink_valid
	wire         id_router_016_src_startofpacket;                                                                                     // id_router_016:src_startofpacket -> rsp_xbar_demux_016:sink_startofpacket
	wire  [68:0] id_router_016_src_data;                                                                                              // id_router_016:src_data -> rsp_xbar_demux_016:sink_data
	wire   [6:0] id_router_016_src_channel;                                                                                           // id_router_016:src_channel -> rsp_xbar_demux_016:sink_channel
	wire         id_router_016_src_ready;                                                                                             // rsp_xbar_demux_016:sink_ready -> id_router_016:src_ready
	wire         crosser_out_endofpacket;                                                                                             // crosser:out_endofpacket -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         crosser_out_valid;                                                                                                   // crosser:out_valid -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_valid
	wire         crosser_out_startofpacket;                                                                                           // crosser:out_startofpacket -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [67:0] crosser_out_data;                                                                                                    // crosser:out_data -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_data
	wire   [1:0] crosser_out_channel;                                                                                                 // crosser:out_channel -> tx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_src0_endofpacket;                                                                                     // cmd_xbar_demux:src0_endofpacket -> crosser:in_endofpacket
	wire         cmd_xbar_demux_src0_valid;                                                                                           // cmd_xbar_demux:src0_valid -> crosser:in_valid
	wire         cmd_xbar_demux_src0_startofpacket;                                                                                   // cmd_xbar_demux:src0_startofpacket -> crosser:in_startofpacket
	wire  [67:0] cmd_xbar_demux_src0_data;                                                                                            // cmd_xbar_demux:src0_data -> crosser:in_data
	wire   [1:0] cmd_xbar_demux_src0_channel;                                                                                         // cmd_xbar_demux:src0_channel -> crosser:in_channel
	wire         cmd_xbar_demux_src0_ready;                                                                                           // crosser:in_ready -> cmd_xbar_demux:src0_ready
	wire         crosser_001_out_endofpacket;                                                                                         // crosser_001:out_endofpacket -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         crosser_001_out_valid;                                                                                               // crosser_001:out_valid -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_valid
	wire         crosser_001_out_startofpacket;                                                                                       // crosser_001:out_startofpacket -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [67:0] crosser_001_out_data;                                                                                                // crosser_001:out_data -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_data
	wire   [1:0] crosser_001_out_channel;                                                                                             // crosser_001:out_channel -> rx_bridge_s0_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_src1_endofpacket;                                                                                     // cmd_xbar_demux:src1_endofpacket -> crosser_001:in_endofpacket
	wire         cmd_xbar_demux_src1_valid;                                                                                           // cmd_xbar_demux:src1_valid -> crosser_001:in_valid
	wire         cmd_xbar_demux_src1_startofpacket;                                                                                   // cmd_xbar_demux:src1_startofpacket -> crosser_001:in_startofpacket
	wire  [67:0] cmd_xbar_demux_src1_data;                                                                                            // cmd_xbar_demux:src1_data -> crosser_001:in_data
	wire   [1:0] cmd_xbar_demux_src1_channel;                                                                                         // cmd_xbar_demux:src1_channel -> crosser_001:in_channel
	wire         cmd_xbar_demux_src1_ready;                                                                                           // crosser_001:in_ready -> cmd_xbar_demux:src1_ready
	wire         crosser_002_out_endofpacket;                                                                                         // crosser_002:out_endofpacket -> rsp_xbar_mux:sink0_endofpacket
	wire         crosser_002_out_valid;                                                                                               // crosser_002:out_valid -> rsp_xbar_mux:sink0_valid
	wire         crosser_002_out_startofpacket;                                                                                       // crosser_002:out_startofpacket -> rsp_xbar_mux:sink0_startofpacket
	wire  [67:0] crosser_002_out_data;                                                                                                // crosser_002:out_data -> rsp_xbar_mux:sink0_data
	wire   [1:0] crosser_002_out_channel;                                                                                             // crosser_002:out_channel -> rsp_xbar_mux:sink0_channel
	wire         crosser_002_out_ready;                                                                                               // rsp_xbar_mux:sink0_ready -> crosser_002:out_ready
	wire         rsp_xbar_demux_src0_endofpacket;                                                                                     // rsp_xbar_demux:src0_endofpacket -> crosser_002:in_endofpacket
	wire         rsp_xbar_demux_src0_valid;                                                                                           // rsp_xbar_demux:src0_valid -> crosser_002:in_valid
	wire         rsp_xbar_demux_src0_startofpacket;                                                                                   // rsp_xbar_demux:src0_startofpacket -> crosser_002:in_startofpacket
	wire  [67:0] rsp_xbar_demux_src0_data;                                                                                            // rsp_xbar_demux:src0_data -> crosser_002:in_data
	wire   [1:0] rsp_xbar_demux_src0_channel;                                                                                         // rsp_xbar_demux:src0_channel -> crosser_002:in_channel
	wire         rsp_xbar_demux_src0_ready;                                                                                           // crosser_002:in_ready -> rsp_xbar_demux:src0_ready
	wire         crosser_003_out_endofpacket;                                                                                         // crosser_003:out_endofpacket -> rsp_xbar_mux:sink1_endofpacket
	wire         crosser_003_out_valid;                                                                                               // crosser_003:out_valid -> rsp_xbar_mux:sink1_valid
	wire         crosser_003_out_startofpacket;                                                                                       // crosser_003:out_startofpacket -> rsp_xbar_mux:sink1_startofpacket
	wire  [67:0] crosser_003_out_data;                                                                                                // crosser_003:out_data -> rsp_xbar_mux:sink1_data
	wire   [1:0] crosser_003_out_channel;                                                                                             // crosser_003:out_channel -> rsp_xbar_mux:sink1_channel
	wire         crosser_003_out_ready;                                                                                               // rsp_xbar_mux:sink1_ready -> crosser_003:out_ready
	wire         rsp_xbar_demux_001_src0_endofpacket;                                                                                 // rsp_xbar_demux_001:src0_endofpacket -> crosser_003:in_endofpacket
	wire         rsp_xbar_demux_001_src0_valid;                                                                                       // rsp_xbar_demux_001:src0_valid -> crosser_003:in_valid
	wire         rsp_xbar_demux_001_src0_startofpacket;                                                                               // rsp_xbar_demux_001:src0_startofpacket -> crosser_003:in_startofpacket
	wire  [67:0] rsp_xbar_demux_001_src0_data;                                                                                        // rsp_xbar_demux_001:src0_data -> crosser_003:in_data
	wire   [1:0] rsp_xbar_demux_001_src0_channel;                                                                                     // rsp_xbar_demux_001:src0_channel -> crosser_003:in_channel
	wire         rsp_xbar_demux_001_src0_ready;                                                                                       // crosser_003:in_ready -> rsp_xbar_demux_001:src0_ready
	wire   [1:0] limiter_cmd_valid_data;                                                                                              // limiter:cmd_src_valid -> cmd_xbar_demux:sink_valid
	wire   [7:0] limiter_001_cmd_valid_data;                                                                                          // limiter_001:cmd_src_valid -> cmd_xbar_demux_001:sink_valid
	wire   [6:0] limiter_002_cmd_valid_data;                                                                                          // limiter_002:cmd_src_valid -> cmd_xbar_demux_002:sink_valid

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (13),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (15),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (0),
		.USE_WAITREQUEST             (1),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (0),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) merlin_master_translator (
		.clk                   (csr_clk_clk),                                                      //                       clk.clk
		.reset                 (rst_controller_reset_out_reset),                                   //                     reset.reset
		.uav_address           (merlin_master_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (merlin_master_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (merlin_master_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (merlin_master_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (merlin_master_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (merlin_master_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (merlin_master_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (merlin_master_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (merlin_master_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (merlin_master_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (merlin_master_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (csr_address),                                                      //      avalon_anti_master_0.address
		.av_waitrequest        (csr_waitrequest),                                                  //                          .waitrequest
		.av_read               (csr_read),                                                         //                          .read
		.av_readdata           (csr_readdata),                                                     //                          .readdata
		.av_write              (csr_write),                                                        //                          .write
		.av_writedata          (csr_writedata),                                                    //                          .writedata
		.av_burstcount         (1'b1),                                                             //               (terminated)
		.av_byteenable         (4'b1111),                                                          //               (terminated)
		.av_beginbursttransfer (1'b0),                                                             //               (terminated)
		.av_begintransfer      (1'b0),                                                             //               (terminated)
		.av_chipselect         (1'b0),                                                             //               (terminated)
		.av_readdatavalid      (),                                                                 //               (terminated)
		.av_lock               (1'b0),                                                             //               (terminated)
		.av_debugaccess        (1'b0),                                                             //               (terminated)
		.uav_clken             (),                                                                 //               (terminated)
		.av_clken              (1'b1)                                                              //               (terminated)
	);

	altera_avalon_mm_bridge #(
		.DATA_WIDTH        (32),
		.SYMBOL_WIDTH      (8),
		.ADDRESS_WIDTH     (14),
		.BURSTCOUNT_WIDTH  (1),
		.PIPELINE_COMMAND  (0),
		.PIPELINE_RESPONSE (0)
	) tx_bridge (
		.clk              (tx_clk_clk),                                                //   clk.clk
		.reset            (rst_controller_001_reset_out_reset),                        // reset.reset
		.s0_waitrequest   (tx_bridge_s0_translator_avalon_anti_slave_0_waitrequest),   //    s0.waitrequest
		.s0_readdata      (tx_bridge_s0_translator_avalon_anti_slave_0_readdata),      //      .readdata
		.s0_readdatavalid (tx_bridge_s0_translator_avalon_anti_slave_0_readdatavalid), //      .readdatavalid
		.s0_burstcount    (tx_bridge_s0_translator_avalon_anti_slave_0_burstcount),    //      .burstcount
		.s0_writedata     (tx_bridge_s0_translator_avalon_anti_slave_0_writedata),     //      .writedata
		.s0_address       (tx_bridge_s0_translator_avalon_anti_slave_0_address),       //      .address
		.s0_write         (tx_bridge_s0_translator_avalon_anti_slave_0_write),         //      .write
		.s0_read          (tx_bridge_s0_translator_avalon_anti_slave_0_read),          //      .read
		.s0_byteenable    (tx_bridge_s0_translator_avalon_anti_slave_0_byteenable),    //      .byteenable
		.s0_debugaccess   (tx_bridge_s0_translator_avalon_anti_slave_0_debugaccess),   //      .debugaccess
		.m0_waitrequest   (tx_bridge_m0_waitrequest),                                  //    m0.waitrequest
		.m0_readdata      (tx_bridge_m0_readdata),                                     //      .readdata
		.m0_readdatavalid (tx_bridge_m0_readdatavalid),                                //      .readdatavalid
		.m0_burstcount    (tx_bridge_m0_burstcount),                                   //      .burstcount
		.m0_writedata     (tx_bridge_m0_writedata),                                    //      .writedata
		.m0_address       (tx_bridge_m0_address),                                      //      .address
		.m0_write         (tx_bridge_m0_write),                                        //      .write
		.m0_read          (tx_bridge_m0_read),                                         //      .read
		.m0_byteenable    (tx_bridge_m0_byteenable),                                   //      .byteenable
		.m0_debugaccess   (tx_bridge_m0_debugaccess)                                   //      .debugaccess
	);

	altera_eth_packet_underflow_control #(
		.BITSPERSYMBOL  (8),
		.SYMBOLSPERBEAT (8),
		.ERROR_WIDTH    (1)
	) tx_eth_packet_underflow_control (
		.clk             (tx_clk_clk),                                                                             //             clock_reset.clk
		.reset           (rst_controller_001_reset_out_reset),                                                     //       clock_reset_reset.reset
		.csr_readdata    (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_anti_slave_0_readdata), //          avalon_slave_0.readdata
		.csr_read        (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_anti_slave_0_read),     //                        .read
		.csr_address     (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_anti_slave_0_address),  //                        .address
		.data_sink_sop   (avalon_st_tx_startofpacket),                                                             //   avalon_streaming_sink.startofpacket
		.data_sink_valid (avalon_st_tx_valid),                                                                     //                        .valid
		.data_sink_data  (avalon_st_tx_data),                                                                      //                        .data
		.data_sink_empty (avalon_st_tx_empty),                                                                     //                        .empty
		.data_sink_ready (avalon_st_tx_ready),                                                                     //                        .ready
		.data_sink_error (avalon_st_tx_error),                                                                     //                        .error
		.data_sink_eop   (avalon_st_tx_endofpacket),                                                               //                        .endofpacket
		.data_src_sop    (tx_eth_packet_underflow_control_avalon_streaming_source_startofpacket),                  // avalon_streaming_source.startofpacket
		.data_src_eop    (tx_eth_packet_underflow_control_avalon_streaming_source_endofpacket),                    //                        .endofpacket
		.data_src_valid  (tx_eth_packet_underflow_control_avalon_streaming_source_valid),                          //                        .valid
		.data_src_data   (tx_eth_packet_underflow_control_avalon_streaming_source_data),                           //                        .data
		.data_src_empty  (tx_eth_packet_underflow_control_avalon_streaming_source_empty),                          //                        .empty
		.data_src_ready  (tx_eth_packet_underflow_control_avalon_streaming_source_ready),                          //                        .ready
		.data_src_error  (tx_eth_packet_underflow_control_avalon_streaming_source_error)                           //                        .error
	);

	altera_eth_pad_inserter #(
		.SYMBOLSPERBEAT (8),
		.ERROR_WIDTH    (2)
	) tx_eth_pad_inserter (
		.clk             (tx_clk_clk),                                                            //           clock_reset.clk
		.reset           (rst_controller_001_reset_out_reset),                                    //     clock_reset_reset.reset
		.csr_write       (tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_write),          //                   csr.write
		.csr_read        (tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_read),           //                      .read
		.csr_address     (tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_address),        //                      .address
		.csr_writedata   (tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_writedata),      //                      .writedata
		.csr_readdata    (tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_readdata),       //                      .readdata
		.data_src_sop    (tx_eth_pad_inserter_avalon_st_source_data_startofpacket),               // avalon_st_source_data.startofpacket
		.data_src_eop    (tx_eth_pad_inserter_avalon_st_source_data_endofpacket),                 //                      .endofpacket
		.data_src_valid  (tx_eth_pad_inserter_avalon_st_source_data_valid),                       //                      .valid
		.data_src_ready  (tx_eth_pad_inserter_avalon_st_source_data_ready),                       //                      .ready
		.data_src_data   (tx_eth_pad_inserter_avalon_st_source_data_data),                        //                      .data
		.data_src_empty  (tx_eth_pad_inserter_avalon_st_source_data_empty),                       //                      .empty
		.data_src_error  (tx_eth_pad_inserter_avalon_st_source_data_error),                       //                      .error
		.data_sink_sop   (tx_eth_packet_underflow_control_avalon_streaming_source_startofpacket), //   avalon_st_sink_data.startofpacket
		.data_sink_eop   (tx_eth_packet_underflow_control_avalon_streaming_source_endofpacket),   //                      .endofpacket
		.data_sink_valid (tx_eth_packet_underflow_control_avalon_streaming_source_valid),         //                      .valid
		.data_sink_ready (tx_eth_packet_underflow_control_avalon_streaming_source_ready),         //                      .ready
		.data_sink_data  (tx_eth_packet_underflow_control_avalon_streaming_source_data),          //                      .data
		.data_sink_empty (tx_eth_packet_underflow_control_avalon_streaming_source_empty),         //                      .empty
		.data_sink_error (tx_eth_packet_underflow_control_avalon_streaming_source_error)          //                      .error
	);

	altera_eth_pkt_backpressure_control #(
		.BITSPERSYMBOL  (8),
		.SYMBOLSPERBEAT (8),
		.ERROR_WIDTH    (2),
		.USE_READY      (1)
	) tx_eth_pkt_backpressure_control (
		.clk                   (tx_clk_clk),                                                                   //           clock_reset.clk
		.reset                 (rst_controller_001_reset_out_reset),                                           //     clock_reset_reset.reset
		.csr_write             (tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_write),     //                   csr.write
		.csr_read              (tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_read),      //                      .read
		.csr_address           (tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_address),   //                      .address
		.csr_writedata         (tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_writedata), //                      .writedata
		.csr_readdata          (tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_readdata),  //                      .readdata
		.data_src_sop          (tx_eth_pkt_backpressure_control_avalon_st_source_data_startofpacket),          // avalon_st_source_data.startofpacket
		.data_src_eop          (tx_eth_pkt_backpressure_control_avalon_st_source_data_endofpacket),            //                      .endofpacket
		.data_src_valid        (tx_eth_pkt_backpressure_control_avalon_st_source_data_valid),                  //                      .valid
		.data_src_ready        (tx_eth_pkt_backpressure_control_avalon_st_source_data_ready),                  //                      .ready
		.data_src_data         (tx_eth_pkt_backpressure_control_avalon_st_source_data_data),                   //                      .data
		.data_src_empty        (tx_eth_pkt_backpressure_control_avalon_st_source_data_empty),                  //                      .empty
		.data_src_error        (tx_eth_pkt_backpressure_control_avalon_st_source_data_error),                  //                      .error
		.data_sink_sop         (tx_eth_pad_inserter_avalon_st_source_data_startofpacket),                      //   avalon_st_sink_data.startofpacket
		.data_sink_eop         (tx_eth_pad_inserter_avalon_st_source_data_endofpacket),                        //                      .endofpacket
		.data_sink_valid       (tx_eth_pad_inserter_avalon_st_source_data_valid),                              //                      .valid
		.data_sink_ready       (tx_eth_pad_inserter_avalon_st_source_data_ready),                              //                      .ready
		.data_sink_data        (tx_eth_pad_inserter_avalon_st_source_data_data),                               //                      .data
		.data_sink_empty       (tx_eth_pad_inserter_avalon_st_source_data_empty),                              //                      .empty
		.data_sink_error       (tx_eth_pad_inserter_avalon_st_source_data_error),                              //                      .error
		.pausebeats_sink_valid (tx_eth_pause_beat_conversion_pause_beat_src_valid),                            //       avalon_st_pause.valid
		.pausebeats_sink_data  (tx_eth_pause_beat_conversion_pause_beat_src_data)                              //                      .data
	);

	altera_eth_pause_beat_conversion tx_eth_pause_beat_conversion (
		.clk                     (tx_clk_clk),                                        //       clock_reset.clk
		.reset                   (rst_controller_001_reset_out_reset),                // clock_reset_reset.reset
		.pause_quanta_sink_valid (rxtx_timing_adapter_pauselen_tx_out_valid),         // pause_quanta_sink.valid
		.pause_quanta_sink_data  (rxtx_timing_adapter_pauselen_tx_out_data),          //                  .data
		.pause_beat_src_valid    (tx_eth_pause_beat_conversion_pause_beat_src_valid), //    pause_beat_src.valid
		.pause_beat_src_data     (tx_eth_pause_beat_conversion_pause_beat_src_data)   //                  .data
	);

	altera_eth_pause_ctrl_gen #(
		.BITSPERSYMBOL  (8),
		.SYMBOLSPERBEAT (8),
		.ERROR_WIDTH    (1)
	) tx_eth_pause_ctrl_gen (
		.clk                  (tx_clk_clk),                                                         //       clock_reset.clk
		.reset                (rst_controller_001_reset_out_reset),                                 // clock_reset_reset.reset
		.csr_address          (tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_address),   //               csr.address
		.csr_read             (tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_read),      //                  .read
		.csr_readdata         (tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_readdata),  //                  .readdata
		.csr_write            (tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_write),     //                  .write
		.csr_writedata        (tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_writedata), //                  .writedata
		.pause_ctrl_sink_data (avalon_st_pause_data),                                               //     pause_control.data
		.pause_source_sop     (tx_eth_pause_ctrl_gen_pause_packet_startofpacket),                   //      pause_packet.startofpacket
		.pause_source_eop     (tx_eth_pause_ctrl_gen_pause_packet_endofpacket),                     //                  .endofpacket
		.pause_source_valid   (tx_eth_pause_ctrl_gen_pause_packet_valid),                           //                  .valid
		.pause_source_data    (tx_eth_pause_ctrl_gen_pause_packet_data),                            //                  .data
		.pause_source_empty   (tx_eth_pause_ctrl_gen_pause_packet_empty),                           //                  .empty
		.pause_source_error   (tx_eth_pause_ctrl_gen_pause_packet_error),                           //                  .error
		.pause_source_ready   (tx_eth_pause_ctrl_gen_pause_packet_ready)                            //                  .ready
	);

	sonic_v1_15_eth_10g_eth_10g_mac_tx_st_pause_ctrl_error_adapter tx_st_pause_ctrl_error_adapter (
		.clk               (tx_clk_clk),                                       //   clk.clk
		.reset_n           (~rst_controller_001_reset_out_reset),              // reset.reset_n
		.in_ready          (tx_eth_pause_ctrl_gen_pause_packet_ready),         //    in.ready
		.in_valid          (tx_eth_pause_ctrl_gen_pause_packet_valid),         //      .valid
		.in_data           (tx_eth_pause_ctrl_gen_pause_packet_data),          //      .data
		.in_error          (tx_eth_pause_ctrl_gen_pause_packet_error),         //      .error
		.in_startofpacket  (tx_eth_pause_ctrl_gen_pause_packet_startofpacket), //      .startofpacket
		.in_endofpacket    (tx_eth_pause_ctrl_gen_pause_packet_endofpacket),   //      .endofpacket
		.in_empty          (tx_eth_pause_ctrl_gen_pause_packet_empty),         //      .empty
		.out_ready         (tx_st_pause_ctrl_error_adapter_out_ready),         //   out.ready
		.out_valid         (tx_st_pause_ctrl_error_adapter_out_valid),         //      .valid
		.out_data          (tx_st_pause_ctrl_error_adapter_out_data),          //      .data
		.out_error         (tx_st_pause_ctrl_error_adapter_out_error),         //      .error
		.out_startofpacket (tx_st_pause_ctrl_error_adapter_out_startofpacket), //      .startofpacket
		.out_endofpacket   (tx_st_pause_ctrl_error_adapter_out_endofpacket),   //      .endofpacket
		.out_empty         (tx_st_pause_ctrl_error_adapter_out_empty)          //      .empty
	);

	sonic_v1_15_eth_10g_eth_10g_mac_tx_st_mux_flow_control_user_frame tx_st_mux_flow_control_user_frame (
		.clk               (tx_clk_clk),                                                          //   clk.clk
		.reset_n           (~rst_controller_001_reset_out_reset),                                 // reset.reset_n
		.in0_valid         (tx_eth_pkt_backpressure_control_avalon_st_source_data_valid),         //   in0.valid
		.in0_ready         (tx_eth_pkt_backpressure_control_avalon_st_source_data_ready),         //      .ready
		.in0_data          (tx_eth_pkt_backpressure_control_avalon_st_source_data_data),          //      .data
		.in0_error         (tx_eth_pkt_backpressure_control_avalon_st_source_data_error),         //      .error
		.in0_startofpacket (tx_eth_pkt_backpressure_control_avalon_st_source_data_startofpacket), //      .startofpacket
		.in0_endofpacket   (tx_eth_pkt_backpressure_control_avalon_st_source_data_endofpacket),   //      .endofpacket
		.in0_empty         (tx_eth_pkt_backpressure_control_avalon_st_source_data_empty),         //      .empty
		.in1_valid         (tx_st_pause_ctrl_error_adapter_out_valid),                            //   in1.valid
		.in1_ready         (tx_st_pause_ctrl_error_adapter_out_ready),                            //      .ready
		.in1_data          (tx_st_pause_ctrl_error_adapter_out_data),                             //      .data
		.in1_error         (tx_st_pause_ctrl_error_adapter_out_error),                            //      .error
		.in1_startofpacket (tx_st_pause_ctrl_error_adapter_out_startofpacket),                    //      .startofpacket
		.in1_endofpacket   (tx_st_pause_ctrl_error_adapter_out_endofpacket),                      //      .endofpacket
		.in1_empty         (tx_st_pause_ctrl_error_adapter_out_empty),                            //      .empty
		.out_channel       (),                                                                    //   out.channel
		.out_valid         (tx_st_mux_flow_control_user_frame_out_valid),                         //      .valid
		.out_ready         (tx_st_mux_flow_control_user_frame_out_ready),                         //      .ready
		.out_data          (tx_st_mux_flow_control_user_frame_out_data),                          //      .data
		.out_error         (tx_st_mux_flow_control_user_frame_out_error),                         //      .error
		.out_startofpacket (tx_st_mux_flow_control_user_frame_out_startofpacket),                 //      .startofpacket
		.out_endofpacket   (tx_st_mux_flow_control_user_frame_out_endofpacket),                   //      .endofpacket
		.out_empty         (tx_st_mux_flow_control_user_frame_out_empty)                          //      .empty
	);

	altera_eth_address_inserter #(
		.BITSPERSYMBOL  (8),
		.SYMBOLSPERBEAT (8),
		.ERROR_WIDTH    (2)
	) tx_eth_address_inserter (
		.clk             (tx_clk_clk),                                                           //             clock_reset.clk
		.reset           (rst_controller_001_reset_out_reset),                                   //       clock_reset_reset.reset
		.csr_write       (tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_write),     //                     csr.write
		.csr_read        (tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_read),      //                        .read
		.csr_address     (tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_address),   //                        .address
		.csr_writedata   (tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_writedata), //                        .writedata
		.csr_readdata    (tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_readdata),  //                        .readdata
		.data_sink_sop   (tx_st_mux_flow_control_user_frame_out_startofpacket),                  //   avalon_streaming_sink.startofpacket
		.data_sink_eop   (tx_st_mux_flow_control_user_frame_out_endofpacket),                    //                        .endofpacket
		.data_sink_valid (tx_st_mux_flow_control_user_frame_out_valid),                          //                        .valid
		.data_sink_ready (tx_st_mux_flow_control_user_frame_out_ready),                          //                        .ready
		.data_sink_data  (tx_st_mux_flow_control_user_frame_out_data),                           //                        .data
		.data_sink_empty (tx_st_mux_flow_control_user_frame_out_empty),                          //                        .empty
		.data_sink_error (tx_st_mux_flow_control_user_frame_out_error),                          //                        .error
		.data_src_sop    (tx_eth_address_inserter_avalon_streaming_source_startofpacket),        // avalon_streaming_source.startofpacket
		.data_src_eop    (tx_eth_address_inserter_avalon_streaming_source_endofpacket),          //                        .endofpacket
		.data_src_valid  (tx_eth_address_inserter_avalon_streaming_source_valid),                //                        .valid
		.data_src_ready  (tx_eth_address_inserter_avalon_streaming_source_ready),                //                        .ready
		.data_src_data   (tx_eth_address_inserter_avalon_streaming_source_data),                 //                        .data
		.data_src_empty  (tx_eth_address_inserter_avalon_streaming_source_empty),                //                        .empty
		.data_src_error  (tx_eth_address_inserter_avalon_streaming_source_error)                 //                        .error
	);

	altera_eth_crc #(
		.BITSPERSYMBOL             (8),
		.SYMBOLSPERBEAT            (8),
		.ERROR_WIDTH               (2),
		.MODE_CHECKER_0_INSERTER_1 (1)
	) tx_eth_crc_inserter (
		.clk             (tx_clk_clk),                                                       //             clock_reset.clk
		.reset           (rst_controller_001_reset_out_reset),                               //       clock_reset_reset.reset
		.csr_write       (tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_write),     //                     csr.write
		.csr_read        (tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_read),      //                        .read
		.csr_address     (tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_address),   //                        .address
		.csr_writedata   (tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_writedata), //                        .writedata
		.csr_readdata    (tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_readdata),  //                        .readdata
		.data_sink_sop   (tx_eth_address_inserter_avalon_streaming_source_startofpacket),    //   avalon_streaming_sink.startofpacket
		.data_sink_eop   (tx_eth_address_inserter_avalon_streaming_source_endofpacket),      //                        .endofpacket
		.data_sink_valid (tx_eth_address_inserter_avalon_streaming_source_valid),            //                        .valid
		.data_sink_ready (tx_eth_address_inserter_avalon_streaming_source_ready),            //                        .ready
		.data_sink_data  (tx_eth_address_inserter_avalon_streaming_source_data),             //                        .data
		.data_sink_empty (tx_eth_address_inserter_avalon_streaming_source_empty),            //                        .empty
		.data_sink_error (tx_eth_address_inserter_avalon_streaming_source_error),            //                        .error
		.data_src_sop    (tx_eth_crc_inserter_avalon_streaming_source_startofpacket),        // avalon_streaming_source.startofpacket
		.data_src_eop    (tx_eth_crc_inserter_avalon_streaming_source_endofpacket),          //                        .endofpacket
		.data_src_valid  (tx_eth_crc_inserter_avalon_streaming_source_valid),                //                        .valid
		.data_src_ready  (tx_eth_crc_inserter_avalon_streaming_source_ready),                //                        .ready
		.data_src_data   (tx_eth_crc_inserter_avalon_streaming_source_data),                 //                        .data
		.data_src_empty  (tx_eth_crc_inserter_avalon_streaming_source_empty),                //                        .empty
		.data_src_error  (tx_eth_crc_inserter_avalon_streaming_source_error)                 //                        .error
	);

	altera_avalon_st_pipeline_stage #(
		.SYMBOLS_PER_BEAT (8),
		.BITS_PER_SYMBOL  (8),
		.USE_PACKETS      (1),
		.USE_EMPTY        (1),
		.EMPTY_WIDTH      (3),
		.CHANNEL_WIDTH    (0),
		.PACKET_WIDTH     (2),
		.ERROR_WIDTH      (3),
		.PIPELINE_READY   (1)
	) tx_st_pipeline_stage_rs (
		.clk               (tx_clk_clk),                                                //       cr0.clk
		.reset             (rst_controller_001_reset_out_reset),                        // cr0_reset.reset
		.in_ready          (tx_eth_crc_inserter_avalon_streaming_source_ready),         //     sink0.ready
		.in_valid          (tx_eth_crc_inserter_avalon_streaming_source_valid),         //          .valid
		.in_startofpacket  (tx_eth_crc_inserter_avalon_streaming_source_startofpacket), //          .startofpacket
		.in_endofpacket    (tx_eth_crc_inserter_avalon_streaming_source_endofpacket),   //          .endofpacket
		.in_empty          (tx_eth_crc_inserter_avalon_streaming_source_empty),         //          .empty
		.in_error          (tx_eth_crc_inserter_avalon_streaming_source_error),         //          .error
		.in_data           (tx_eth_crc_inserter_avalon_streaming_source_data),          //          .data
		.out_ready         (tx_st_pipeline_stage_rs_source0_ready),                     //   source0.ready
		.out_valid         (tx_st_pipeline_stage_rs_source0_valid),                     //          .valid
		.out_startofpacket (tx_st_pipeline_stage_rs_source0_startofpacket),             //          .startofpacket
		.out_endofpacket   (tx_st_pipeline_stage_rs_source0_endofpacket),               //          .endofpacket
		.out_empty         (tx_st_pipeline_stage_rs_source0_empty),                     //          .empty
		.out_error         (tx_st_pipeline_stage_rs_source0_error),                     //          .error
		.out_data          (tx_st_pipeline_stage_rs_source0_data),                      //          .data
		.out_channel       (),                                                          // (terminated)
		.in_channel        (1'b0)                                                       // (terminated)
	);

	altera_avalon_st_splitter #(
		.NUMBER_OF_OUTPUTS (2),
		.QUALIFY_VALID_OUT (1),
		.USE_PACKETS       (1),
		.DATA_WIDTH        (64),
		.CHANNEL_WIDTH     (1),
		.ERROR_WIDTH       (3),
		.BITS_PER_SYMBOL   (8),
		.EMPTY_WIDTH       (3)
	) tx_st_splitter_1 (
		.clk                 (tx_clk_clk),                                    //  clk.clk
		.in0_ready           (tx_st_pipeline_stage_rs_source0_ready),         //   in.ready
		.in0_valid           (tx_st_pipeline_stage_rs_source0_valid),         //     .valid
		.in0_startofpacket   (tx_st_pipeline_stage_rs_source0_startofpacket), //     .startofpacket
		.in0_endofpacket     (tx_st_pipeline_stage_rs_source0_endofpacket),   //     .endofpacket
		.in0_empty           (tx_st_pipeline_stage_rs_source0_empty),         //     .empty
		.in0_error           (tx_st_pipeline_stage_rs_source0_error),         //     .error
		.in0_data            (tx_st_pipeline_stage_rs_source0_data),          //     .data
		.out0_ready          (tx_st_splitter_1_out0_ready),                   // out0.ready
		.out0_valid          (tx_st_splitter_1_out0_valid),                   //     .valid
		.out0_startofpacket  (tx_st_splitter_1_out0_startofpacket),           //     .startofpacket
		.out0_endofpacket    (tx_st_splitter_1_out0_endofpacket),             //     .endofpacket
		.out0_empty          (tx_st_splitter_1_out0_empty),                   //     .empty
		.out0_error          (tx_st_splitter_1_out0_error),                   //     .error
		.out0_data           (tx_st_splitter_1_out0_data),                    //     .data
		.out1_ready          (tx_st_splitter_1_out1_ready),                   // out1.ready
		.out1_valid          (tx_st_splitter_1_out1_valid),                   //     .valid
		.out1_startofpacket  (tx_st_splitter_1_out1_startofpacket),           //     .startofpacket
		.out1_endofpacket    (tx_st_splitter_1_out1_endofpacket),             //     .endofpacket
		.out1_empty          (tx_st_splitter_1_out1_empty),                   //     .empty
		.out1_error          (tx_st_splitter_1_out1_error),                   //     .error
		.out1_data           (tx_st_splitter_1_out1_data),                    //     .data
		.in0_channel         (1'b0),                                          // (terminated)
		.out0_channel        (),                                              // (terminated)
		.out1_channel        (),                                              // (terminated)
		.out2_ready          (1'b1),                                          // (terminated)
		.out2_valid          (),                                              // (terminated)
		.out2_startofpacket  (),                                              // (terminated)
		.out2_endofpacket    (),                                              // (terminated)
		.out2_empty          (),                                              // (terminated)
		.out2_channel        (),                                              // (terminated)
		.out2_error          (),                                              // (terminated)
		.out2_data           (),                                              // (terminated)
		.out3_ready          (1'b1),                                          // (terminated)
		.out3_valid          (),                                              // (terminated)
		.out3_startofpacket  (),                                              // (terminated)
		.out3_endofpacket    (),                                              // (terminated)
		.out3_empty          (),                                              // (terminated)
		.out3_channel        (),                                              // (terminated)
		.out3_error          (),                                              // (terminated)
		.out3_data           (),                                              // (terminated)
		.out4_ready          (1'b1),                                          // (terminated)
		.out4_valid          (),                                              // (terminated)
		.out4_startofpacket  (),                                              // (terminated)
		.out4_endofpacket    (),                                              // (terminated)
		.out4_empty          (),                                              // (terminated)
		.out4_channel        (),                                              // (terminated)
		.out4_error          (),                                              // (terminated)
		.out4_data           (),                                              // (terminated)
		.out5_ready          (1'b1),                                          // (terminated)
		.out5_valid          (),                                              // (terminated)
		.out5_startofpacket  (),                                              // (terminated)
		.out5_endofpacket    (),                                              // (terminated)
		.out5_empty          (),                                              // (terminated)
		.out5_channel        (),                                              // (terminated)
		.out5_error          (),                                              // (terminated)
		.out5_data           (),                                              // (terminated)
		.out6_ready          (1'b1),                                          // (terminated)
		.out6_valid          (),                                              // (terminated)
		.out6_startofpacket  (),                                              // (terminated)
		.out6_endofpacket    (),                                              // (terminated)
		.out6_empty          (),                                              // (terminated)
		.out6_channel        (),                                              // (terminated)
		.out6_error          (),                                              // (terminated)
		.out6_data           (),                                              // (terminated)
		.out7_ready          (1'b1),                                          // (terminated)
		.out7_valid          (),                                              // (terminated)
		.out7_startofpacket  (),                                              // (terminated)
		.out7_endofpacket    (),                                              // (terminated)
		.out7_empty          (),                                              // (terminated)
		.out7_channel        (),                                              // (terminated)
		.out7_error          (),                                              // (terminated)
		.out7_data           (),                                              // (terminated)
		.out8_ready          (1'b1),                                          // (terminated)
		.out8_valid          (),                                              // (terminated)
		.out8_startofpacket  (),                                              // (terminated)
		.out8_endofpacket    (),                                              // (terminated)
		.out8_empty          (),                                              // (terminated)
		.out8_channel        (),                                              // (terminated)
		.out8_error          (),                                              // (terminated)
		.out8_data           (),                                              // (terminated)
		.out9_ready          (1'b1),                                          // (terminated)
		.out9_valid          (),                                              // (terminated)
		.out9_startofpacket  (),                                              // (terminated)
		.out9_endofpacket    (),                                              // (terminated)
		.out9_empty          (),                                              // (terminated)
		.out9_channel        (),                                              // (terminated)
		.out9_error          (),                                              // (terminated)
		.out9_data           (),                                              // (terminated)
		.out10_ready         (1'b1),                                          // (terminated)
		.out10_valid         (),                                              // (terminated)
		.out10_startofpacket (),                                              // (terminated)
		.out10_endofpacket   (),                                              // (terminated)
		.out10_empty         (),                                              // (terminated)
		.out10_channel       (),                                              // (terminated)
		.out10_error         (),                                              // (terminated)
		.out10_data          (),                                              // (terminated)
		.out11_ready         (1'b1),                                          // (terminated)
		.out11_valid         (),                                              // (terminated)
		.out11_startofpacket (),                                              // (terminated)
		.out11_endofpacket   (),                                              // (terminated)
		.out11_empty         (),                                              // (terminated)
		.out11_channel       (),                                              // (terminated)
		.out11_error         (),                                              // (terminated)
		.out11_data          (),                                              // (terminated)
		.out12_ready         (1'b1),                                          // (terminated)
		.out12_valid         (),                                              // (terminated)
		.out12_startofpacket (),                                              // (terminated)
		.out12_endofpacket   (),                                              // (terminated)
		.out12_empty         (),                                              // (terminated)
		.out12_channel       (),                                              // (terminated)
		.out12_error         (),                                              // (terminated)
		.out12_data          (),                                              // (terminated)
		.out13_ready         (1'b1),                                          // (terminated)
		.out13_valid         (),                                              // (terminated)
		.out13_startofpacket (),                                              // (terminated)
		.out13_endofpacket   (),                                              // (terminated)
		.out13_empty         (),                                              // (terminated)
		.out13_channel       (),                                              // (terminated)
		.out13_error         (),                                              // (terminated)
		.out13_data          (),                                              // (terminated)
		.out14_ready         (1'b1),                                          // (terminated)
		.out14_valid         (),                                              // (terminated)
		.out14_startofpacket (),                                              // (terminated)
		.out14_endofpacket   (),                                              // (terminated)
		.out14_empty         (),                                              // (terminated)
		.out14_channel       (),                                              // (terminated)
		.out14_error         (),                                              // (terminated)
		.out14_data          (),                                              // (terminated)
		.out15_ready         (1'b1),                                          // (terminated)
		.out15_valid         (),                                              // (terminated)
		.out15_startofpacket (),                                              // (terminated)
		.out15_endofpacket   (),                                              // (terminated)
		.out15_empty         (),                                              // (terminated)
		.out15_channel       (),                                              // (terminated)
		.out15_error         (),                                              // (terminated)
		.out15_data          ()                                               // (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_tx_st_timing_adapter_frame_decoder tx_st_timing_adapter_frame_decoder (
		.clk               (tx_clk_clk),                                           //   clk.clk
		.reset_n           (~rst_controller_001_reset_out_reset),                  // reset.reset_n
		.in_ready          (tx_st_splitter_1_out0_ready),                          //    in.ready
		.in_valid          (tx_st_splitter_1_out0_valid),                          //      .valid
		.in_data           (tx_st_splitter_1_out0_data),                           //      .data
		.in_error          (tx_st_splitter_1_out0_error),                          //      .error
		.in_startofpacket  (tx_st_splitter_1_out0_startofpacket),                  //      .startofpacket
		.in_endofpacket    (tx_st_splitter_1_out0_endofpacket),                    //      .endofpacket
		.in_empty          (tx_st_splitter_1_out0_empty),                          //      .empty
		.out_valid         (tx_st_timing_adapter_frame_decoder_out_valid),         //   out.valid
		.out_data          (tx_st_timing_adapter_frame_decoder_out_data),          //      .data
		.out_error         (tx_st_timing_adapter_frame_decoder_out_error),         //      .error
		.out_startofpacket (tx_st_timing_adapter_frame_decoder_out_startofpacket), //      .startofpacket
		.out_endofpacket   (tx_st_timing_adapter_frame_decoder_out_endofpacket),   //      .endofpacket
		.out_empty         (tx_st_timing_adapter_frame_decoder_out_empty)          //      .empty
	);

	altera_eth_frame_decoder #(
		.BITSPERSYMBOL    (8),
		.SYMBOLSPERBEAT   (8),
		.ERROR_WIDTH      (3),
		.ENABLE_SUPP_ADDR (0),
		.ENABLE_PFC       (0),
		.PFC_PRIORITY_NUM (8)
	) tx_eth_frame_decoder (
		.clk                        (tx_clk_clk),                                                                  //            clock_reset.clk
		.reset                      (rst_controller_001_reset_out_reset),                                          //      clock_reset_reset.reset
		.csr_readdata               (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_readdata),  //          avalom_mm_csr.readdata
		.csr_write                  (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_write),     //                       .write
		.csr_read                   (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_read),      //                       .read
		.csr_address                (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_address),   //                       .address
		.csr_writedata              (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_writedata), //                       .writedata
		.data_sink_sop              (tx_st_timing_adapter_frame_decoder_out_startofpacket),                        //    avalon_st_data_sink.startofpacket
		.data_sink_eop              (tx_st_timing_adapter_frame_decoder_out_endofpacket),                          //                       .endofpacket
		.data_sink_valid            (tx_st_timing_adapter_frame_decoder_out_valid),                                //                       .valid
		.data_sink_data             (tx_st_timing_adapter_frame_decoder_out_data),                                 //                       .data
		.data_sink_empty            (tx_st_timing_adapter_frame_decoder_out_empty),                                //                       .empty
		.data_sink_error            (tx_st_timing_adapter_frame_decoder_out_error),                                //                       .error
		.rxstatus_src_valid         (tx_eth_frame_decoder_avalon_st_rxstatus_src_valid),                           // avalon_st_rxstatus_src.valid
		.rxstatus_src_data          (tx_eth_frame_decoder_avalon_st_rxstatus_src_data),                            //                       .data
		.rxstatus_src_error         (tx_eth_frame_decoder_avalon_st_rxstatus_src_error),                           //                       .error
		.data_sink_ready            (),                                                                            //            (terminated)
		.data_src_sop               (),                                                                            //            (terminated)
		.data_src_eop               (),                                                                            //            (terminated)
		.data_src_valid             (),                                                                            //            (terminated)
		.data_src_ready             (1'b1),                                                                        //            (terminated)
		.data_src_data              (),                                                                            //            (terminated)
		.data_src_empty             (),                                                                            //            (terminated)
		.data_src_error             (),                                                                            //            (terminated)
		.pauselen_src_valid         (),                                                                            //            (terminated)
		.pauselen_src_data          (),                                                                            //            (terminated)
		.pfc_pause_quanta_src_valid (),                                                                            //            (terminated)
		.pfc_pause_quanta_src_data  (),                                                                            //            (terminated)
		.pfc_status_src_valid       (),                                                                            //            (terminated)
		.pfc_status_src_data        (),                                                                            //            (terminated)
		.pktinfo_src_valid          (),                                                                            //            (terminated)
		.pktinfo_src_data           ()                                                                             //            (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_tx_st_error_adapter_stat tx_st_error_adapter_stat (
		.clk       (tx_clk_clk),                                        //   clk.clk
		.reset_n   (~rst_controller_001_reset_out_reset),               // reset.reset_n
		.in_valid  (tx_eth_frame_decoder_avalon_st_rxstatus_src_valid), //    in.valid
		.in_data   (tx_eth_frame_decoder_avalon_st_rxstatus_src_data),  //      .data
		.in_error  (tx_eth_frame_decoder_avalon_st_rxstatus_src_error), //      .error
		.out_valid (tx_st_error_adapter_stat_out_valid),                //   out.valid
		.out_data  (tx_st_error_adapter_stat_out_data),                 //      .data
		.out_error (tx_st_error_adapter_stat_out_error)                 //      .error
	);

	sonic_v1_15_eth_10g_eth_10g_mac_tx_st_timing_adapter_splitter_status_in tx_st_timing_adapter_splitter_status_in (
		.clk       (tx_clk_clk),                                        //   clk.clk
		.reset_n   (~rst_controller_001_reset_out_reset),               // reset.reset_n
		.in_valid  (tx_st_error_adapter_stat_out_valid),                //    in.valid
		.in_data   (tx_st_error_adapter_stat_out_data),                 //      .data
		.in_error  (tx_st_error_adapter_stat_out_error),                //      .error
		.out_valid (tx_st_timing_adapter_splitter_status_in_out_valid), //   out.valid
		.out_data  (tx_st_timing_adapter_splitter_status_in_out_data),  //      .data
		.out_error (tx_st_timing_adapter_splitter_status_in_out_error), //      .error
		.out_ready (tx_st_timing_adapter_splitter_status_in_out_ready)  //      .ready
	);

	sonic_v1_15_eth_10g_eth_10g_mac_tx_st_timing_adapter_splitter_status_output tx_st_timing_adapter_splitter_status_output (
		.clk       (tx_clk_clk),                          //   clk.clk
		.reset_n   (~rst_controller_001_reset_out_reset), // reset.reset_n
		.in_ready  (tx_st_status_splitter_out1_ready),    //    in.ready
		.in_valid  (tx_st_status_splitter_out1_valid),    //      .valid
		.in_data   (tx_st_status_splitter_out1_data),     //      .data
		.in_error  (tx_st_status_splitter_out1_error),    //      .error
		.out_valid (avalon_st_txstatus_valid),            //   out.valid
		.out_data  (avalon_st_txstatus_data),             //      .data
		.out_error (avalon_st_txstatus_error)             //      .error
	);

	altera_avalon_st_splitter #(
		.NUMBER_OF_OUTPUTS (2),
		.QUALIFY_VALID_OUT (1),
		.USE_PACKETS       (0),
		.DATA_WIDTH        (40),
		.CHANNEL_WIDTH     (1),
		.ERROR_WIDTH       (7),
		.BITS_PER_SYMBOL   (40),
		.EMPTY_WIDTH       (1)
	) tx_st_status_splitter (
		.clk                 (tx_clk_clk),                                        //  clk.clk
		.in0_ready           (tx_st_timing_adapter_splitter_status_in_out_ready), //   in.ready
		.in0_valid           (tx_st_timing_adapter_splitter_status_in_out_valid), //     .valid
		.in0_error           (tx_st_timing_adapter_splitter_status_in_out_error), //     .error
		.in0_data            (tx_st_timing_adapter_splitter_status_in_out_data),  //     .data
		.out0_ready          (tx_st_status_splitter_out0_ready),                  // out0.ready
		.out0_valid          (tx_st_status_splitter_out0_valid),                  //     .valid
		.out0_error          (tx_st_status_splitter_out0_error),                  //     .error
		.out0_data           (tx_st_status_splitter_out0_data),                   //     .data
		.out1_ready          (tx_st_status_splitter_out1_ready),                  // out1.ready
		.out1_valid          (tx_st_status_splitter_out1_valid),                  //     .valid
		.out1_error          (tx_st_status_splitter_out1_error),                  //     .error
		.out1_data           (tx_st_status_splitter_out1_data),                   //     .data
		.in0_startofpacket   (1'b0),                                              // (terminated)
		.in0_endofpacket     (1'b0),                                              // (terminated)
		.in0_empty           (1'b0),                                              // (terminated)
		.in0_channel         (1'b0),                                              // (terminated)
		.out0_startofpacket  (),                                                  // (terminated)
		.out0_endofpacket    (),                                                  // (terminated)
		.out0_empty          (),                                                  // (terminated)
		.out0_channel        (),                                                  // (terminated)
		.out1_startofpacket  (),                                                  // (terminated)
		.out1_endofpacket    (),                                                  // (terminated)
		.out1_empty          (),                                                  // (terminated)
		.out1_channel        (),                                                  // (terminated)
		.out2_ready          (1'b1),                                              // (terminated)
		.out2_valid          (),                                                  // (terminated)
		.out2_startofpacket  (),                                                  // (terminated)
		.out2_endofpacket    (),                                                  // (terminated)
		.out2_empty          (),                                                  // (terminated)
		.out2_channel        (),                                                  // (terminated)
		.out2_error          (),                                                  // (terminated)
		.out2_data           (),                                                  // (terminated)
		.out3_ready          (1'b1),                                              // (terminated)
		.out3_valid          (),                                                  // (terminated)
		.out3_startofpacket  (),                                                  // (terminated)
		.out3_endofpacket    (),                                                  // (terminated)
		.out3_empty          (),                                                  // (terminated)
		.out3_channel        (),                                                  // (terminated)
		.out3_error          (),                                                  // (terminated)
		.out3_data           (),                                                  // (terminated)
		.out4_ready          (1'b1),                                              // (terminated)
		.out4_valid          (),                                                  // (terminated)
		.out4_startofpacket  (),                                                  // (terminated)
		.out4_endofpacket    (),                                                  // (terminated)
		.out4_empty          (),                                                  // (terminated)
		.out4_channel        (),                                                  // (terminated)
		.out4_error          (),                                                  // (terminated)
		.out4_data           (),                                                  // (terminated)
		.out5_ready          (1'b1),                                              // (terminated)
		.out5_valid          (),                                                  // (terminated)
		.out5_startofpacket  (),                                                  // (terminated)
		.out5_endofpacket    (),                                                  // (terminated)
		.out5_empty          (),                                                  // (terminated)
		.out5_channel        (),                                                  // (terminated)
		.out5_error          (),                                                  // (terminated)
		.out5_data           (),                                                  // (terminated)
		.out6_ready          (1'b1),                                              // (terminated)
		.out6_valid          (),                                                  // (terminated)
		.out6_startofpacket  (),                                                  // (terminated)
		.out6_endofpacket    (),                                                  // (terminated)
		.out6_empty          (),                                                  // (terminated)
		.out6_channel        (),                                                  // (terminated)
		.out6_error          (),                                                  // (terminated)
		.out6_data           (),                                                  // (terminated)
		.out7_ready          (1'b1),                                              // (terminated)
		.out7_valid          (),                                                  // (terminated)
		.out7_startofpacket  (),                                                  // (terminated)
		.out7_endofpacket    (),                                                  // (terminated)
		.out7_empty          (),                                                  // (terminated)
		.out7_channel        (),                                                  // (terminated)
		.out7_error          (),                                                  // (terminated)
		.out7_data           (),                                                  // (terminated)
		.out8_ready          (1'b1),                                              // (terminated)
		.out8_valid          (),                                                  // (terminated)
		.out8_startofpacket  (),                                                  // (terminated)
		.out8_endofpacket    (),                                                  // (terminated)
		.out8_empty          (),                                                  // (terminated)
		.out8_channel        (),                                                  // (terminated)
		.out8_error          (),                                                  // (terminated)
		.out8_data           (),                                                  // (terminated)
		.out9_ready          (1'b1),                                              // (terminated)
		.out9_valid          (),                                                  // (terminated)
		.out9_startofpacket  (),                                                  // (terminated)
		.out9_endofpacket    (),                                                  // (terminated)
		.out9_empty          (),                                                  // (terminated)
		.out9_channel        (),                                                  // (terminated)
		.out9_error          (),                                                  // (terminated)
		.out9_data           (),                                                  // (terminated)
		.out10_ready         (1'b1),                                              // (terminated)
		.out10_valid         (),                                                  // (terminated)
		.out10_startofpacket (),                                                  // (terminated)
		.out10_endofpacket   (),                                                  // (terminated)
		.out10_empty         (),                                                  // (terminated)
		.out10_channel       (),                                                  // (terminated)
		.out10_error         (),                                                  // (terminated)
		.out10_data          (),                                                  // (terminated)
		.out11_ready         (1'b1),                                              // (terminated)
		.out11_valid         (),                                                  // (terminated)
		.out11_startofpacket (),                                                  // (terminated)
		.out11_endofpacket   (),                                                  // (terminated)
		.out11_empty         (),                                                  // (terminated)
		.out11_channel       (),                                                  // (terminated)
		.out11_error         (),                                                  // (terminated)
		.out11_data          (),                                                  // (terminated)
		.out12_ready         (1'b1),                                              // (terminated)
		.out12_valid         (),                                                  // (terminated)
		.out12_startofpacket (),                                                  // (terminated)
		.out12_endofpacket   (),                                                  // (terminated)
		.out12_empty         (),                                                  // (terminated)
		.out12_channel       (),                                                  // (terminated)
		.out12_error         (),                                                  // (terminated)
		.out12_data          (),                                                  // (terminated)
		.out13_ready         (1'b1),                                              // (terminated)
		.out13_valid         (),                                                  // (terminated)
		.out13_startofpacket (),                                                  // (terminated)
		.out13_endofpacket   (),                                                  // (terminated)
		.out13_empty         (),                                                  // (terminated)
		.out13_channel       (),                                                  // (terminated)
		.out13_error         (),                                                  // (terminated)
		.out13_data          (),                                                  // (terminated)
		.out14_ready         (1'b1),                                              // (terminated)
		.out14_valid         (),                                                  // (terminated)
		.out14_startofpacket (),                                                  // (terminated)
		.out14_endofpacket   (),                                                  // (terminated)
		.out14_empty         (),                                                  // (terminated)
		.out14_channel       (),                                                  // (terminated)
		.out14_error         (),                                                  // (terminated)
		.out14_data          (),                                                  // (terminated)
		.out15_ready         (1'b1),                                              // (terminated)
		.out15_valid         (),                                                  // (terminated)
		.out15_startofpacket (),                                                  // (terminated)
		.out15_endofpacket   (),                                                  // (terminated)
		.out15_empty         (),                                                  // (terminated)
		.out15_channel       (),                                                  // (terminated)
		.out15_error         (),                                                  // (terminated)
		.out15_data          ()                                                   // (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_tx_st_timing_adapter_splitter_status_output tx_st_timing_adapter_splitter_status_statistics (
		.clk       (tx_clk_clk),                                                //   clk.clk
		.reset_n   (~rst_controller_001_reset_out_reset),                       // reset.reset_n
		.in_ready  (tx_st_status_splitter_out0_ready),                          //    in.ready
		.in_valid  (tx_st_status_splitter_out0_valid),                          //      .valid
		.in_data   (tx_st_status_splitter_out0_data),                           //      .data
		.in_error  (tx_st_status_splitter_out0_error),                          //      .error
		.out_valid (tx_st_timing_adapter_splitter_status_statistics_out_valid), //   out.valid
		.out_data  (tx_st_timing_adapter_splitter_status_statistics_out_data),  //      .data
		.out_error (tx_st_timing_adapter_splitter_status_statistics_out_error)  //      .error
	);

	altera_eth_10gmem_statistics_collector #(
		.ENABLE_PFC (0)
	) tx_eth_statistics_collector (
		.clk             (tx_clk_clk),                                                               //         clock_reset.clk
		.reset           (rst_controller_001_reset_out_reset),                                       //   clock_reset_reset.reset
		.csr_read        (tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_read),      //                 csr.read
		.csr_address     (tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_address),   //                    .address
		.csr_readdata    (tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_readdata),  //                    .readdata
		.csr_write       (tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_write),     //                    .write
		.csr_writedata   (tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_writedata), //                    .writedata
		.stat_sink_valid (tx_st_timing_adapter_splitter_status_statistics_out_valid),                // avalon_st_sink_data.valid
		.stat_sink_data  (tx_st_timing_adapter_splitter_status_statistics_out_data),                 //                    .data
		.stat_sink_error (tx_st_timing_adapter_splitter_status_statistics_out_error)                 //                    .error
	);

	altera_eth_packet_formatter #(
		.ERROR_WIDTH (3)
	) tx_eth_packet_formatter (
		.clk                      (tx_clk_clk),                                                           //       clk.clk
		.reset                    (rst_controller_001_reset_out_reset),                                   // clk_reset.reset
		.data_sink_data           (tx_st_splitter_1_out1_data),                                           // data_sink.data
		.data_sink_sop            (tx_st_splitter_1_out1_startofpacket),                                  //          .startofpacket
		.data_sink_eop            (tx_st_splitter_1_out1_endofpacket),                                    //          .endofpacket
		.data_sink_empty          (tx_st_splitter_1_out1_empty),                                          //          .empty
		.data_sink_error          (tx_st_splitter_1_out1_error),                                          //          .error
		.data_sink_valid          (tx_st_splitter_1_out1_valid),                                          //          .valid
		.data_sink_ready          (tx_st_splitter_1_out1_ready),                                          //          .ready
		.data_src_data            (tx_eth_packet_formatter_data_src_data),                                //  data_src.data
		.data_src_sop             (tx_eth_packet_formatter_data_src_startofpacket),                       //          .startofpacket
		.data_src_eop             (tx_eth_packet_formatter_data_src_endofpacket),                         //          .endofpacket
		.data_src_empty           (tx_eth_packet_formatter_data_src_empty),                               //          .empty
		.data_src_valid           (tx_eth_packet_formatter_data_src_valid),                               //          .valid
		.data_src_ready           (tx_eth_packet_formatter_data_src_ready),                               //          .ready
		.data_sink_data_preamble  (64'b0000000000000000000000000000000000000000000000000000000000000000), // (terminated)
		.data_sink_valid_preamble (1'b0),                                                                 // (terminated)
		.data_sink_ready_preamble ()                                                                      // (terminated)
	);

	altera_eth_xgmii_termination tx_eth_xgmii_termination (
		.clk             (tx_clk_clk),                                            //             clock_reset.clk
		.reset           (rst_controller_001_reset_out_reset),                    //       clock_reset_reset.reset
		.xgmii_src_data  (tx_eth_xgmii_termination_avalon_streaming_source_data), // avalon_streaming_source.data
		.data_sink_sop   (tx_eth_packet_formatter_data_src_startofpacket),        //   avalon_streaming_sink.startofpacket
		.data_sink_eop   (tx_eth_packet_formatter_data_src_endofpacket),          //                        .endofpacket
		.data_sink_valid (tx_eth_packet_formatter_data_src_valid),                //                        .valid
		.data_sink_data  (tx_eth_packet_formatter_data_src_data),                 //                        .data
		.data_sink_empty (tx_eth_packet_formatter_data_src_empty),                //                        .empty
		.data_sink_ready (tx_eth_packet_formatter_data_src_ready)                 //                        .ready
	);

	altera_eth_link_fault_generation tx_eth_link_fault_generation (
		.clk                  (tx_clk_clk),                                            //             clk.clk
		.reset                (rst_controller_001_reset_out_reset),                    //       clk_reset.reset
		.mii_sink_data        (tx_eth_xgmii_termination_avalon_streaming_source_data), //        mii_sink.data
		.mii_src_data         (xgmii_tx_data),                                         //         mii_src.data
		.link_fault_sink_data (rxtx_timing_adapter_link_fault_status_tx_out_data)      // link_fault_sink.data
	);

	altera_avalon_mm_bridge #(
		.DATA_WIDTH        (32),
		.SYMBOL_WIDTH      (8),
		.ADDRESS_WIDTH     (14),
		.BURSTCOUNT_WIDTH  (1),
		.PIPELINE_COMMAND  (0),
		.PIPELINE_RESPONSE (0)
	) rx_bridge (
		.clk              (rx_clk_clk),                                                //   clk.clk
		.reset            (rst_controller_002_reset_out_reset),                        // reset.reset
		.s0_waitrequest   (rx_bridge_s0_translator_avalon_anti_slave_0_waitrequest),   //    s0.waitrequest
		.s0_readdata      (rx_bridge_s0_translator_avalon_anti_slave_0_readdata),      //      .readdata
		.s0_readdatavalid (rx_bridge_s0_translator_avalon_anti_slave_0_readdatavalid), //      .readdatavalid
		.s0_burstcount    (rx_bridge_s0_translator_avalon_anti_slave_0_burstcount),    //      .burstcount
		.s0_writedata     (rx_bridge_s0_translator_avalon_anti_slave_0_writedata),     //      .writedata
		.s0_address       (rx_bridge_s0_translator_avalon_anti_slave_0_address),       //      .address
		.s0_write         (rx_bridge_s0_translator_avalon_anti_slave_0_write),         //      .write
		.s0_read          (rx_bridge_s0_translator_avalon_anti_slave_0_read),          //      .read
		.s0_byteenable    (rx_bridge_s0_translator_avalon_anti_slave_0_byteenable),    //      .byteenable
		.s0_debugaccess   (rx_bridge_s0_translator_avalon_anti_slave_0_debugaccess),   //      .debugaccess
		.m0_waitrequest   (rx_bridge_m0_waitrequest),                                  //    m0.waitrequest
		.m0_readdata      (rx_bridge_m0_readdata),                                     //      .readdata
		.m0_readdatavalid (rx_bridge_m0_readdatavalid),                                //      .readdatavalid
		.m0_burstcount    (rx_bridge_m0_burstcount),                                   //      .burstcount
		.m0_writedata     (rx_bridge_m0_writedata),                                    //      .writedata
		.m0_address       (rx_bridge_m0_address),                                      //      .address
		.m0_write         (rx_bridge_m0_write),                                        //      .write
		.m0_read          (rx_bridge_m0_read),                                         //      .read
		.m0_byteenable    (rx_bridge_m0_byteenable),                                   //      .byteenable
		.m0_debugaccess   (rx_bridge_m0_debugaccess)                                   //      .debugaccess
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rx_st_timing_adapter_interface_conversion rx_st_timing_adapter_interface_conversion (
		.clk       (rx_clk_clk),                                          //   clk.clk
		.reset_n   (~rst_controller_002_reset_out_reset),                 // reset.reset_n
		.in_data   (xgmii_rx_data),                                       //    in.data
		.out_data  (rx_st_timing_adapter_interface_conversion_out_data),  //   out.data
		.out_ready (rx_st_timing_adapter_interface_conversion_out_ready), //      .ready
		.out_valid (rx_st_timing_adapter_interface_conversion_out_valid)  //      .valid
	);

	altera_avalon_st_splitter #(
		.NUMBER_OF_OUTPUTS (2),
		.QUALIFY_VALID_OUT (1),
		.USE_PACKETS       (0),
		.DATA_WIDTH        (72),
		.CHANNEL_WIDTH     (1),
		.ERROR_WIDTH       (1),
		.BITS_PER_SYMBOL   (9),
		.EMPTY_WIDTH       (3)
	) rx_st_splitter_xgmii (
		.clk                 (rx_clk_clk),                                          //  clk.clk
		.in0_ready           (rx_st_timing_adapter_interface_conversion_out_ready), //   in.ready
		.in0_valid           (rx_st_timing_adapter_interface_conversion_out_valid), //     .valid
		.in0_data            (rx_st_timing_adapter_interface_conversion_out_data),  //     .data
		.out0_ready          (rx_st_splitter_xgmii_out0_ready),                     // out0.ready
		.out0_valid          (rx_st_splitter_xgmii_out0_valid),                     //     .valid
		.out0_data           (rx_st_splitter_xgmii_out0_data),                      //     .data
		.out1_ready          (rx_st_splitter_xgmii_out1_ready),                     // out1.ready
		.out1_valid          (rx_st_splitter_xgmii_out1_valid),                     //     .valid
		.out1_data           (rx_st_splitter_xgmii_out1_data),                      //     .data
		.in0_startofpacket   (1'b0),                                                // (terminated)
		.in0_endofpacket     (1'b0),                                                // (terminated)
		.in0_empty           (3'b000),                                              // (terminated)
		.in0_channel         (1'b0),                                                // (terminated)
		.in0_error           (1'b0),                                                // (terminated)
		.out0_startofpacket  (),                                                    // (terminated)
		.out0_endofpacket    (),                                                    // (terminated)
		.out0_empty          (),                                                    // (terminated)
		.out0_channel        (),                                                    // (terminated)
		.out0_error          (),                                                    // (terminated)
		.out1_startofpacket  (),                                                    // (terminated)
		.out1_endofpacket    (),                                                    // (terminated)
		.out1_empty          (),                                                    // (terminated)
		.out1_channel        (),                                                    // (terminated)
		.out1_error          (),                                                    // (terminated)
		.out2_ready          (1'b1),                                                // (terminated)
		.out2_valid          (),                                                    // (terminated)
		.out2_startofpacket  (),                                                    // (terminated)
		.out2_endofpacket    (),                                                    // (terminated)
		.out2_empty          (),                                                    // (terminated)
		.out2_channel        (),                                                    // (terminated)
		.out2_error          (),                                                    // (terminated)
		.out2_data           (),                                                    // (terminated)
		.out3_ready          (1'b1),                                                // (terminated)
		.out3_valid          (),                                                    // (terminated)
		.out3_startofpacket  (),                                                    // (terminated)
		.out3_endofpacket    (),                                                    // (terminated)
		.out3_empty          (),                                                    // (terminated)
		.out3_channel        (),                                                    // (terminated)
		.out3_error          (),                                                    // (terminated)
		.out3_data           (),                                                    // (terminated)
		.out4_ready          (1'b1),                                                // (terminated)
		.out4_valid          (),                                                    // (terminated)
		.out4_startofpacket  (),                                                    // (terminated)
		.out4_endofpacket    (),                                                    // (terminated)
		.out4_empty          (),                                                    // (terminated)
		.out4_channel        (),                                                    // (terminated)
		.out4_error          (),                                                    // (terminated)
		.out4_data           (),                                                    // (terminated)
		.out5_ready          (1'b1),                                                // (terminated)
		.out5_valid          (),                                                    // (terminated)
		.out5_startofpacket  (),                                                    // (terminated)
		.out5_endofpacket    (),                                                    // (terminated)
		.out5_empty          (),                                                    // (terminated)
		.out5_channel        (),                                                    // (terminated)
		.out5_error          (),                                                    // (terminated)
		.out5_data           (),                                                    // (terminated)
		.out6_ready          (1'b1),                                                // (terminated)
		.out6_valid          (),                                                    // (terminated)
		.out6_startofpacket  (),                                                    // (terminated)
		.out6_endofpacket    (),                                                    // (terminated)
		.out6_empty          (),                                                    // (terminated)
		.out6_channel        (),                                                    // (terminated)
		.out6_error          (),                                                    // (terminated)
		.out6_data           (),                                                    // (terminated)
		.out7_ready          (1'b1),                                                // (terminated)
		.out7_valid          (),                                                    // (terminated)
		.out7_startofpacket  (),                                                    // (terminated)
		.out7_endofpacket    (),                                                    // (terminated)
		.out7_empty          (),                                                    // (terminated)
		.out7_channel        (),                                                    // (terminated)
		.out7_error          (),                                                    // (terminated)
		.out7_data           (),                                                    // (terminated)
		.out8_ready          (1'b1),                                                // (terminated)
		.out8_valid          (),                                                    // (terminated)
		.out8_startofpacket  (),                                                    // (terminated)
		.out8_endofpacket    (),                                                    // (terminated)
		.out8_empty          (),                                                    // (terminated)
		.out8_channel        (),                                                    // (terminated)
		.out8_error          (),                                                    // (terminated)
		.out8_data           (),                                                    // (terminated)
		.out9_ready          (1'b1),                                                // (terminated)
		.out9_valid          (),                                                    // (terminated)
		.out9_startofpacket  (),                                                    // (terminated)
		.out9_endofpacket    (),                                                    // (terminated)
		.out9_empty          (),                                                    // (terminated)
		.out9_channel        (),                                                    // (terminated)
		.out9_error          (),                                                    // (terminated)
		.out9_data           (),                                                    // (terminated)
		.out10_ready         (1'b1),                                                // (terminated)
		.out10_valid         (),                                                    // (terminated)
		.out10_startofpacket (),                                                    // (terminated)
		.out10_endofpacket   (),                                                    // (terminated)
		.out10_empty         (),                                                    // (terminated)
		.out10_channel       (),                                                    // (terminated)
		.out10_error         (),                                                    // (terminated)
		.out10_data          (),                                                    // (terminated)
		.out11_ready         (1'b1),                                                // (terminated)
		.out11_valid         (),                                                    // (terminated)
		.out11_startofpacket (),                                                    // (terminated)
		.out11_endofpacket   (),                                                    // (terminated)
		.out11_empty         (),                                                    // (terminated)
		.out11_channel       (),                                                    // (terminated)
		.out11_error         (),                                                    // (terminated)
		.out11_data          (),                                                    // (terminated)
		.out12_ready         (1'b1),                                                // (terminated)
		.out12_valid         (),                                                    // (terminated)
		.out12_startofpacket (),                                                    // (terminated)
		.out12_endofpacket   (),                                                    // (terminated)
		.out12_empty         (),                                                    // (terminated)
		.out12_channel       (),                                                    // (terminated)
		.out12_error         (),                                                    // (terminated)
		.out12_data          (),                                                    // (terminated)
		.out13_ready         (1'b1),                                                // (terminated)
		.out13_valid         (),                                                    // (terminated)
		.out13_startofpacket (),                                                    // (terminated)
		.out13_endofpacket   (),                                                    // (terminated)
		.out13_empty         (),                                                    // (terminated)
		.out13_channel       (),                                                    // (terminated)
		.out13_error         (),                                                    // (terminated)
		.out13_data          (),                                                    // (terminated)
		.out14_ready         (1'b1),                                                // (terminated)
		.out14_valid         (),                                                    // (terminated)
		.out14_startofpacket (),                                                    // (terminated)
		.out14_endofpacket   (),                                                    // (terminated)
		.out14_empty         (),                                                    // (terminated)
		.out14_channel       (),                                                    // (terminated)
		.out14_error         (),                                                    // (terminated)
		.out14_data          (),                                                    // (terminated)
		.out15_ready         (1'b1),                                                // (terminated)
		.out15_valid         (),                                                    // (terminated)
		.out15_startofpacket (),                                                    // (terminated)
		.out15_endofpacket   (),                                                    // (terminated)
		.out15_empty         (),                                                    // (terminated)
		.out15_channel       (),                                                    // (terminated)
		.out15_error         (),                                                    // (terminated)
		.out15_data          ()                                                     // (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rx_st_timing_adapter_lane_decoder rx_st_timing_adapter_lane_decoder (
		.clk      (rx_clk_clk),                                 //   clk.clk
		.reset_n  (~rst_controller_002_reset_out_reset),        // reset.reset_n
		.in_ready (rx_st_splitter_xgmii_out0_ready),            //    in.ready
		.in_valid (rx_st_splitter_xgmii_out0_valid),            //      .valid
		.in_data  (rx_st_splitter_xgmii_out0_data),             //      .data
		.out_data (rx_st_timing_adapter_lane_decoder_out_data)  //   out.data
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rx_st_timing_adapter_lane_decoder rx_st_timing_adapter_link_fault_detection (
		.clk      (rx_clk_clk),                                         //   clk.clk
		.reset_n  (~rst_controller_002_reset_out_reset),                // reset.reset_n
		.in_ready (rx_st_splitter_xgmii_out1_ready),                    //    in.ready
		.in_valid (rx_st_splitter_xgmii_out1_valid),                    //      .valid
		.in_data  (rx_st_splitter_xgmii_out1_data),                     //      .data
		.out_data (rx_st_timing_adapter_link_fault_detection_out_data)  //   out.data
	);

	altera_eth_link_fault_detection rx_eth_link_fault_detection (
		.clk                 (rx_clk_clk),                                         //            clk.clk
		.reset               (rst_controller_002_reset_out_reset),                 //      clk_reset.reset
		.mii_sink_data       (rx_st_timing_adapter_link_fault_detection_out_data), //       mii_sink.data
		.link_fault_src_data (rx_eth_link_fault_detection_link_fault_src_data)     // link_fault_src.data
	);

	altera_eth_lane_decoder rx_eth_lane_decoder (
		.clk              (rx_clk_clk),                                                       //             clock_reset.clk
		.reset            (rst_controller_002_reset_out_reset),                               //       clock_reset_reset.reset
		.xgmii_sink_data  (rx_st_timing_adapter_lane_decoder_out_data),                       //   avalon_streaming_sink.data
		.rxdata_src_eop   (rx_eth_lane_decoder_avalon_streaming_source_endofpacket),          // avalon_streaming_source.endofpacket
		.rxdata_src_sop   (rx_eth_lane_decoder_avalon_streaming_source_startofpacket),        //                        .startofpacket
		.rxdata_src_valid (rx_eth_lane_decoder_avalon_streaming_source_valid),                //                        .valid
		.rxdata_src_data  (rx_eth_lane_decoder_avalon_streaming_source_data),                 //                        .data
		.rxdata_src_empty (rx_eth_lane_decoder_avalon_streaming_source_empty),                //                        .empty
		.rxdata_src_error (rx_eth_lane_decoder_avalon_streaming_source_error),                //                        .error
		.csr_read         (rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_read),      //                     csr.read
		.csr_write        (rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_write),     //                        .write
		.csr_address      (rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_address),   //                        .address
		.csr_writedata    (rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_writedata), //                        .writedata
		.csr_readdata     (rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_readdata),  //                        .readdata
		.preamble_valid   (),                                                                 //             (terminated)
		.preamble_bytes   ()                                                                  //             (terminated)
	);

	altera_eth_pkt_backpressure_control #(
		.BITSPERSYMBOL  (8),
		.SYMBOLSPERBEAT (8),
		.ERROR_WIDTH    (1),
		.USE_READY      (0)
	) rx_eth_pkt_backpressure_control (
		.clk                   (rx_clk_clk),                                                                   //           clock_reset.clk
		.reset                 (rst_controller_002_reset_out_reset),                                           //     clock_reset_reset.reset
		.csr_write             (rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_write),     //                   csr.write
		.csr_read              (rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_read),      //                      .read
		.csr_address           (rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_address),   //                      .address
		.csr_writedata         (rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_writedata), //                      .writedata
		.csr_readdata          (rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_readdata),  //                      .readdata
		.data_src_sop          (rx_eth_pkt_backpressure_control_avalon_st_source_data_startofpacket),          // avalon_st_source_data.startofpacket
		.data_src_eop          (rx_eth_pkt_backpressure_control_avalon_st_source_data_endofpacket),            //                      .endofpacket
		.data_src_valid        (rx_eth_pkt_backpressure_control_avalon_st_source_data_valid),                  //                      .valid
		.data_src_data         (rx_eth_pkt_backpressure_control_avalon_st_source_data_data),                   //                      .data
		.data_src_empty        (rx_eth_pkt_backpressure_control_avalon_st_source_data_empty),                  //                      .empty
		.data_src_error        (rx_eth_pkt_backpressure_control_avalon_st_source_data_error),                  //                      .error
		.data_sink_sop         (rx_eth_lane_decoder_avalon_streaming_source_startofpacket),                    //   avalon_st_sink_data.startofpacket
		.data_sink_eop         (rx_eth_lane_decoder_avalon_streaming_source_endofpacket),                      //                      .endofpacket
		.data_sink_valid       (rx_eth_lane_decoder_avalon_streaming_source_valid),                            //                      .valid
		.data_sink_data        (rx_eth_lane_decoder_avalon_streaming_source_data),                             //                      .data
		.data_sink_empty       (rx_eth_lane_decoder_avalon_streaming_source_empty),                            //                      .empty
		.data_sink_error       (rx_eth_lane_decoder_avalon_streaming_source_error),                            //                      .error
		.data_src_ready        (1'b1),                                                                         //           (terminated)
		.data_sink_ready       (),                                                                             //           (terminated)
		.pausebeats_sink_valid (1'b0),                                                                         //           (terminated)
		.pausebeats_sink_data  (32'b00000000000000000000000000000000)                                          //           (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rx_st_timing_adapter_frame_status_in rx_st_timing_adapter_frame_status_in (
		.clk               (rx_clk_clk),                                                          //   clk.clk
		.reset_n           (~rst_controller_002_reset_out_reset),                                 // reset.reset_n
		.in_valid          (rx_eth_pkt_backpressure_control_avalon_st_source_data_valid),         //    in.valid
		.in_data           (rx_eth_pkt_backpressure_control_avalon_st_source_data_data),          //      .data
		.in_error          (rx_eth_pkt_backpressure_control_avalon_st_source_data_error),         //      .error
		.in_startofpacket  (rx_eth_pkt_backpressure_control_avalon_st_source_data_startofpacket), //      .startofpacket
		.in_endofpacket    (rx_eth_pkt_backpressure_control_avalon_st_source_data_endofpacket),   //      .endofpacket
		.in_empty          (rx_eth_pkt_backpressure_control_avalon_st_source_data_empty),         //      .empty
		.out_valid         (rx_st_timing_adapter_frame_status_in_out_valid),                      //   out.valid
		.out_data          (rx_st_timing_adapter_frame_status_in_out_data),                       //      .data
		.out_error         (rx_st_timing_adapter_frame_status_in_out_error),                      //      .error
		.out_startofpacket (rx_st_timing_adapter_frame_status_in_out_startofpacket),              //      .startofpacket
		.out_endofpacket   (rx_st_timing_adapter_frame_status_in_out_endofpacket),                //      .endofpacket
		.out_empty         (rx_st_timing_adapter_frame_status_in_out_empty),                      //      .empty
		.out_ready         (rx_st_timing_adapter_frame_status_in_out_ready)                       //      .ready
	);

	altera_avalon_st_splitter #(
		.NUMBER_OF_OUTPUTS (2),
		.QUALIFY_VALID_OUT (1),
		.USE_PACKETS       (1),
		.DATA_WIDTH        (64),
		.CHANNEL_WIDTH     (1),
		.ERROR_WIDTH       (1),
		.BITS_PER_SYMBOL   (8),
		.EMPTY_WIDTH       (3)
	) rx_st_frame_status_splitter (
		.clk                 (rx_clk_clk),                                             //  clk.clk
		.in0_ready           (rx_st_timing_adapter_frame_status_in_out_ready),         //   in.ready
		.in0_valid           (rx_st_timing_adapter_frame_status_in_out_valid),         //     .valid
		.in0_startofpacket   (rx_st_timing_adapter_frame_status_in_out_startofpacket), //     .startofpacket
		.in0_endofpacket     (rx_st_timing_adapter_frame_status_in_out_endofpacket),   //     .endofpacket
		.in0_empty           (rx_st_timing_adapter_frame_status_in_out_empty),         //     .empty
		.in0_error           (rx_st_timing_adapter_frame_status_in_out_error),         //     .error
		.in0_data            (rx_st_timing_adapter_frame_status_in_out_data),          //     .data
		.out0_ready          (rx_st_frame_status_splitter_out0_ready),                 // out0.ready
		.out0_valid          (rx_st_frame_status_splitter_out0_valid),                 //     .valid
		.out0_startofpacket  (rx_st_frame_status_splitter_out0_startofpacket),         //     .startofpacket
		.out0_endofpacket    (rx_st_frame_status_splitter_out0_endofpacket),           //     .endofpacket
		.out0_empty          (rx_st_frame_status_splitter_out0_empty),                 //     .empty
		.out0_error          (rx_st_frame_status_splitter_out0_error),                 //     .error
		.out0_data           (rx_st_frame_status_splitter_out0_data),                  //     .data
		.out1_ready          (rx_st_frame_status_splitter_out1_ready),                 // out1.ready
		.out1_valid          (rx_st_frame_status_splitter_out1_valid),                 //     .valid
		.out1_startofpacket  (rx_st_frame_status_splitter_out1_startofpacket),         //     .startofpacket
		.out1_endofpacket    (rx_st_frame_status_splitter_out1_endofpacket),           //     .endofpacket
		.out1_empty          (rx_st_frame_status_splitter_out1_empty),                 //     .empty
		.out1_error          (rx_st_frame_status_splitter_out1_error),                 //     .error
		.out1_data           (rx_st_frame_status_splitter_out1_data),                  //     .data
		.in0_channel         (1'b0),                                                   // (terminated)
		.out0_channel        (),                                                       // (terminated)
		.out1_channel        (),                                                       // (terminated)
		.out2_ready          (1'b1),                                                   // (terminated)
		.out2_valid          (),                                                       // (terminated)
		.out2_startofpacket  (),                                                       // (terminated)
		.out2_endofpacket    (),                                                       // (terminated)
		.out2_empty          (),                                                       // (terminated)
		.out2_channel        (),                                                       // (terminated)
		.out2_error          (),                                                       // (terminated)
		.out2_data           (),                                                       // (terminated)
		.out3_ready          (1'b1),                                                   // (terminated)
		.out3_valid          (),                                                       // (terminated)
		.out3_startofpacket  (),                                                       // (terminated)
		.out3_endofpacket    (),                                                       // (terminated)
		.out3_empty          (),                                                       // (terminated)
		.out3_channel        (),                                                       // (terminated)
		.out3_error          (),                                                       // (terminated)
		.out3_data           (),                                                       // (terminated)
		.out4_ready          (1'b1),                                                   // (terminated)
		.out4_valid          (),                                                       // (terminated)
		.out4_startofpacket  (),                                                       // (terminated)
		.out4_endofpacket    (),                                                       // (terminated)
		.out4_empty          (),                                                       // (terminated)
		.out4_channel        (),                                                       // (terminated)
		.out4_error          (),                                                       // (terminated)
		.out4_data           (),                                                       // (terminated)
		.out5_ready          (1'b1),                                                   // (terminated)
		.out5_valid          (),                                                       // (terminated)
		.out5_startofpacket  (),                                                       // (terminated)
		.out5_endofpacket    (),                                                       // (terminated)
		.out5_empty          (),                                                       // (terminated)
		.out5_channel        (),                                                       // (terminated)
		.out5_error          (),                                                       // (terminated)
		.out5_data           (),                                                       // (terminated)
		.out6_ready          (1'b1),                                                   // (terminated)
		.out6_valid          (),                                                       // (terminated)
		.out6_startofpacket  (),                                                       // (terminated)
		.out6_endofpacket    (),                                                       // (terminated)
		.out6_empty          (),                                                       // (terminated)
		.out6_channel        (),                                                       // (terminated)
		.out6_error          (),                                                       // (terminated)
		.out6_data           (),                                                       // (terminated)
		.out7_ready          (1'b1),                                                   // (terminated)
		.out7_valid          (),                                                       // (terminated)
		.out7_startofpacket  (),                                                       // (terminated)
		.out7_endofpacket    (),                                                       // (terminated)
		.out7_empty          (),                                                       // (terminated)
		.out7_channel        (),                                                       // (terminated)
		.out7_error          (),                                                       // (terminated)
		.out7_data           (),                                                       // (terminated)
		.out8_ready          (1'b1),                                                   // (terminated)
		.out8_valid          (),                                                       // (terminated)
		.out8_startofpacket  (),                                                       // (terminated)
		.out8_endofpacket    (),                                                       // (terminated)
		.out8_empty          (),                                                       // (terminated)
		.out8_channel        (),                                                       // (terminated)
		.out8_error          (),                                                       // (terminated)
		.out8_data           (),                                                       // (terminated)
		.out9_ready          (1'b1),                                                   // (terminated)
		.out9_valid          (),                                                       // (terminated)
		.out9_startofpacket  (),                                                       // (terminated)
		.out9_endofpacket    (),                                                       // (terminated)
		.out9_empty          (),                                                       // (terminated)
		.out9_channel        (),                                                       // (terminated)
		.out9_error          (),                                                       // (terminated)
		.out9_data           (),                                                       // (terminated)
		.out10_ready         (1'b1),                                                   // (terminated)
		.out10_valid         (),                                                       // (terminated)
		.out10_startofpacket (),                                                       // (terminated)
		.out10_endofpacket   (),                                                       // (terminated)
		.out10_empty         (),                                                       // (terminated)
		.out10_channel       (),                                                       // (terminated)
		.out10_error         (),                                                       // (terminated)
		.out10_data          (),                                                       // (terminated)
		.out11_ready         (1'b1),                                                   // (terminated)
		.out11_valid         (),                                                       // (terminated)
		.out11_startofpacket (),                                                       // (terminated)
		.out11_endofpacket   (),                                                       // (terminated)
		.out11_empty         (),                                                       // (terminated)
		.out11_channel       (),                                                       // (terminated)
		.out11_error         (),                                                       // (terminated)
		.out11_data          (),                                                       // (terminated)
		.out12_ready         (1'b1),                                                   // (terminated)
		.out12_valid         (),                                                       // (terminated)
		.out12_startofpacket (),                                                       // (terminated)
		.out12_endofpacket   (),                                                       // (terminated)
		.out12_empty         (),                                                       // (terminated)
		.out12_channel       (),                                                       // (terminated)
		.out12_error         (),                                                       // (terminated)
		.out12_data          (),                                                       // (terminated)
		.out13_ready         (1'b1),                                                   // (terminated)
		.out13_valid         (),                                                       // (terminated)
		.out13_startofpacket (),                                                       // (terminated)
		.out13_endofpacket   (),                                                       // (terminated)
		.out13_empty         (),                                                       // (terminated)
		.out13_channel       (),                                                       // (terminated)
		.out13_error         (),                                                       // (terminated)
		.out13_data          (),                                                       // (terminated)
		.out14_ready         (1'b1),                                                   // (terminated)
		.out14_valid         (),                                                       // (terminated)
		.out14_startofpacket (),                                                       // (terminated)
		.out14_endofpacket   (),                                                       // (terminated)
		.out14_empty         (),                                                       // (terminated)
		.out14_channel       (),                                                       // (terminated)
		.out14_error         (),                                                       // (terminated)
		.out14_data          (),                                                       // (terminated)
		.out15_ready         (1'b1),                                                   // (terminated)
		.out15_valid         (),                                                       // (terminated)
		.out15_startofpacket (),                                                       // (terminated)
		.out15_endofpacket   (),                                                       // (terminated)
		.out15_empty         (),                                                       // (terminated)
		.out15_channel       (),                                                       // (terminated)
		.out15_error         (),                                                       // (terminated)
		.out15_data          ()                                                        // (terminated)
	);

	altera_eth_frame_decoder #(
		.BITSPERSYMBOL    (8),
		.SYMBOLSPERBEAT   (8),
		.ERROR_WIDTH      (1),
		.ENABLE_SUPP_ADDR (1),
		.ENABLE_PFC       (0),
		.PFC_PRIORITY_NUM (8)
	) rx_eth_frame_decoder (
		.clk                        (rx_clk_clk),                                                                  //            clock_reset.clk
		.reset                      (rst_controller_002_reset_out_reset),                                          //      clock_reset_reset.reset
		.csr_readdata               (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_readdata),  //          avalom_mm_csr.readdata
		.csr_write                  (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_write),     //                       .write
		.csr_read                   (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_read),      //                       .read
		.csr_address                (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_address),   //                       .address
		.csr_writedata              (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_writedata), //                       .writedata
		.data_sink_sop              (rx_timing_adapter_frame_status_out_frame_decoder_out_startofpacket),          //    avalon_st_data_sink.startofpacket
		.data_sink_eop              (rx_timing_adapter_frame_status_out_frame_decoder_out_endofpacket),            //                       .endofpacket
		.data_sink_valid            (rx_timing_adapter_frame_status_out_frame_decoder_out_valid),                  //                       .valid
		.data_sink_data             (rx_timing_adapter_frame_status_out_frame_decoder_out_data),                   //                       .data
		.data_sink_empty            (rx_timing_adapter_frame_status_out_frame_decoder_out_empty),                  //                       .empty
		.data_sink_error            (rx_timing_adapter_frame_status_out_frame_decoder_out_error),                  //                       .error
		.data_src_sop               (rx_eth_frame_decoder_avalon_st_data_src_startofpacket),                       //     avalon_st_data_src.startofpacket
		.data_src_eop               (rx_eth_frame_decoder_avalon_st_data_src_endofpacket),                         //                       .endofpacket
		.data_src_valid             (rx_eth_frame_decoder_avalon_st_data_src_valid),                               //                       .valid
		.data_src_data              (rx_eth_frame_decoder_avalon_st_data_src_data),                                //                       .data
		.data_src_empty             (rx_eth_frame_decoder_avalon_st_data_src_empty),                               //                       .empty
		.data_src_error             (rx_eth_frame_decoder_avalon_st_data_src_error),                               //                       .error
		.pauselen_src_valid         (rx_eth_frame_decoder_avalon_st_pauselen_src_valid),                           // avalon_st_pauselen_src.valid
		.pauselen_src_data          (rx_eth_frame_decoder_avalon_st_pauselen_src_data),                            //                       .data
		.rxstatus_src_valid         (rx_eth_frame_decoder_avalon_st_rxstatus_src_valid),                           // avalon_st_rxstatus_src.valid
		.rxstatus_src_data          (rx_eth_frame_decoder_avalon_st_rxstatus_src_data),                            //                       .data
		.rxstatus_src_error         (rx_eth_frame_decoder_avalon_st_rxstatus_src_error),                           //                       .error
		.pktinfo_src_valid          (rx_eth_frame_decoder_avalon_st_pktinfo_src_valid),                            //  avalon_st_pktinfo_src.valid
		.pktinfo_src_data           (rx_eth_frame_decoder_avalon_st_pktinfo_src_data),                             //                       .data
		.data_sink_ready            (),                                                                            //            (terminated)
		.data_src_ready             (1'b1),                                                                        //            (terminated)
		.pfc_pause_quanta_src_valid (),                                                                            //            (terminated)
		.pfc_pause_quanta_src_data  (),                                                                            //            (terminated)
		.pfc_status_src_valid       (),                                                                            //            (terminated)
		.pfc_status_src_data        ()                                                                             //            (terminated)
	);

	altera_eth_crc #(
		.BITSPERSYMBOL             (8),
		.SYMBOLSPERBEAT            (8),
		.ERROR_WIDTH               (1),
		.MODE_CHECKER_0_INSERTER_1 (0)
	) rx_eth_crc_checker (
		.clk             (rx_clk_clk),                                                       //             clock_reset.clk
		.reset           (rst_controller_002_reset_out_reset),                               //       clock_reset_reset.reset
		.csr_write       (rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_write),      //                     csr.write
		.csr_read        (rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_read),       //                        .read
		.csr_address     (rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_address),    //                        .address
		.csr_writedata   (rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_writedata),  //                        .writedata
		.csr_readdata    (rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_readdata),   //                        .readdata
		.data_sink_sop   (rx_timing_adapter_frame_status_out_crc_checker_out_startofpacket), //   avalon_streaming_sink.startofpacket
		.data_sink_eop   (rx_timing_adapter_frame_status_out_crc_checker_out_endofpacket),   //                        .endofpacket
		.data_sink_valid (rx_timing_adapter_frame_status_out_crc_checker_out_valid),         //                        .valid
		.data_sink_data  (rx_timing_adapter_frame_status_out_crc_checker_out_data),          //                        .data
		.data_sink_empty (rx_timing_adapter_frame_status_out_crc_checker_out_empty),         //                        .empty
		.data_sink_error (rx_timing_adapter_frame_status_out_crc_checker_out_error),         //                        .error
		.data_src_sop    (rx_eth_crc_checker_avalon_streaming_source_startofpacket),         // avalon_streaming_source.startofpacket
		.data_src_eop    (rx_eth_crc_checker_avalon_streaming_source_endofpacket),           //                        .endofpacket
		.data_src_valid  (rx_eth_crc_checker_avalon_streaming_source_valid),                 //                        .valid
		.data_src_data   (rx_eth_crc_checker_avalon_streaming_source_data),                  //                        .data
		.data_src_empty  (rx_eth_crc_checker_avalon_streaming_source_empty),                 //                        .empty
		.data_src_error  (rx_eth_crc_checker_avalon_streaming_source_error),                 //                        .error
		.data_sink_ready (),                                                                 //             (terminated)
		.data_src_ready  (1'b1)                                                              //             (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rx_timing_adapter_frame_status_out_frame_decoder rx_timing_adapter_frame_status_out_frame_decoder (
		.clk               (rx_clk_clk),                                                         //   clk.clk
		.reset_n           (~rst_controller_002_reset_out_reset),                                // reset.reset_n
		.in_ready          (rx_st_frame_status_splitter_out0_ready),                             //    in.ready
		.in_valid          (rx_st_frame_status_splitter_out0_valid),                             //      .valid
		.in_data           (rx_st_frame_status_splitter_out0_data),                              //      .data
		.in_error          (rx_st_frame_status_splitter_out0_error),                             //      .error
		.in_startofpacket  (rx_st_frame_status_splitter_out0_startofpacket),                     //      .startofpacket
		.in_endofpacket    (rx_st_frame_status_splitter_out0_endofpacket),                       //      .endofpacket
		.in_empty          (rx_st_frame_status_splitter_out0_empty),                             //      .empty
		.out_valid         (rx_timing_adapter_frame_status_out_frame_decoder_out_valid),         //   out.valid
		.out_data          (rx_timing_adapter_frame_status_out_frame_decoder_out_data),          //      .data
		.out_error         (rx_timing_adapter_frame_status_out_frame_decoder_out_error),         //      .error
		.out_startofpacket (rx_timing_adapter_frame_status_out_frame_decoder_out_startofpacket), //      .startofpacket
		.out_endofpacket   (rx_timing_adapter_frame_status_out_frame_decoder_out_endofpacket),   //      .endofpacket
		.out_empty         (rx_timing_adapter_frame_status_out_frame_decoder_out_empty)          //      .empty
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rx_timing_adapter_frame_status_out_frame_decoder rx_timing_adapter_frame_status_out_crc_checker (
		.clk               (rx_clk_clk),                                                       //   clk.clk
		.reset_n           (~rst_controller_002_reset_out_reset),                              // reset.reset_n
		.in_ready          (rx_st_frame_status_splitter_out1_ready),                           //    in.ready
		.in_valid          (rx_st_frame_status_splitter_out1_valid),                           //      .valid
		.in_data           (rx_st_frame_status_splitter_out1_data),                            //      .data
		.in_error          (rx_st_frame_status_splitter_out1_error),                           //      .error
		.in_startofpacket  (rx_st_frame_status_splitter_out1_startofpacket),                   //      .startofpacket
		.in_endofpacket    (rx_st_frame_status_splitter_out1_endofpacket),                     //      .endofpacket
		.in_empty          (rx_st_frame_status_splitter_out1_empty),                           //      .empty
		.out_valid         (rx_timing_adapter_frame_status_out_crc_checker_out_valid),         //   out.valid
		.out_data          (rx_timing_adapter_frame_status_out_crc_checker_out_data),          //      .data
		.out_error         (rx_timing_adapter_frame_status_out_crc_checker_out_error),         //      .error
		.out_startofpacket (rx_timing_adapter_frame_status_out_crc_checker_out_startofpacket), //      .startofpacket
		.out_endofpacket   (rx_timing_adapter_frame_status_out_crc_checker_out_endofpacket),   //      .endofpacket
		.out_empty         (rx_timing_adapter_frame_status_out_crc_checker_out_empty)          //      .empty
	);

	altera_eth_frame_status_merger rx_eth_frame_status_merger (
		.clk                           (rx_clk_clk),                                                                                                                                    //             clock_reset.clk
		.reset                         (rst_controller_002_reset_out_reset),                                                                                                            //       clock_reset_reset.reset
		.frame_decoder_data_sink_sop   (rx_eth_frame_decoder_avalon_st_data_src_startofpacket),                                                                                         // frame_decoder_data_sink.startofpacket
		.frame_decoder_data_sink_eop   (rx_eth_frame_decoder_avalon_st_data_src_endofpacket),                                                                                           //                        .endofpacket
		.frame_decoder_data_sink_valid (rx_eth_frame_decoder_avalon_st_data_src_valid),                                                                                                 //                        .valid
		.frame_decoder_data_sink_data  (rx_eth_frame_decoder_avalon_st_data_src_data),                                                                                                  //                        .data
		.frame_decoder_data_sink_empty (rx_eth_frame_decoder_avalon_st_data_src_empty),                                                                                                 //                        .empty
		.frame_decoder_data_sink_error (rx_eth_frame_decoder_avalon_st_data_src_error),                                                                                                 //                        .error
		.crc_checker_data_sink_sop     (rx_eth_crc_checker_avalon_streaming_source_startofpacket),                                                                                      //   crc_checker_data_sink.startofpacket
		.crc_checker_data_sink_eop     (rx_eth_crc_checker_avalon_streaming_source_endofpacket),                                                                                        //                        .endofpacket
		.crc_checker_data_sink_valid   (rx_eth_crc_checker_avalon_streaming_source_valid),                                                                                              //                        .valid
		.crc_checker_data_sink_data    (rx_eth_crc_checker_avalon_streaming_source_data),                                                                                               //                        .data
		.crc_checker_data_sink_empty   (rx_eth_crc_checker_avalon_streaming_source_empty),                                                                                              //                        .empty
		.crc_checker_data_sink_error   (rx_eth_crc_checker_avalon_streaming_source_error),                                                                                              //                        .error
		.data_src_sop                  (rx_eth_frame_status_merger_data_src_startofpacket),                                                                                             //                data_src.startofpacket
		.data_src_eop                  (rx_eth_frame_status_merger_data_src_endofpacket),                                                                                               //                        .endofpacket
		.data_src_valid                (rx_eth_frame_status_merger_data_src_valid),                                                                                                     //                        .valid
		.data_src_data                 (rx_eth_frame_status_merger_data_src_data),                                                                                                      //                        .data
		.data_src_empty                (rx_eth_frame_status_merger_data_src_empty),                                                                                                     //                        .empty
		.data_src_error                (rx_eth_frame_status_merger_data_src_error),                                                                                                     //                        .error
		.pauselen_sink_valid           (rx_eth_frame_decoder_avalon_st_pauselen_src_valid),                                                                                             //           pauselen_sink.valid
		.pauselen_sink_data            (rx_eth_frame_decoder_avalon_st_pauselen_src_data),                                                                                              //                        .data
		.pauselen_src_valid            (rx_eth_frame_status_merger_pauselen_src_valid),                                                                                                 //            pauselen_src.valid
		.pauselen_src_data             (rx_eth_frame_status_merger_pauselen_src_data),                                                                                                  //                        .data
		.rxstatus_sink_valid           (rx_eth_frame_decoder_avalon_st_rxstatus_src_valid),                                                                                             //           rxstatus_sink.valid
		.rxstatus_sink_data            (rx_eth_frame_decoder_avalon_st_rxstatus_src_data),                                                                                              //                        .data
		.rxstatus_sink_error           (rx_eth_frame_decoder_avalon_st_rxstatus_src_error),                                                                                             //                        .error
		.rxstatus_src_valid            (rx_eth_frame_status_merger_rxstatus_src_valid),                                                                                                 //            rxstatus_src.valid
		.rxstatus_src_data             (rx_eth_frame_status_merger_rxstatus_src_data),                                                                                                  //                        .data
		.rxstatus_src_error            (rx_eth_frame_status_merger_rxstatus_src_error),                                                                                                 //                        .error
		.pfc_pause_quanta_sink_valid   (1'b0),                                                                                                                                          //             (terminated)
		.pfc_pause_quanta_sink_data    (136'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000), //             (terminated)
		.pfc_pause_quanta_src_valid    (),                                                                                                                                              //             (terminated)
		.pfc_pause_quanta_src_data     ()                                                                                                                                               //             (terminated)
	);

	altera_eth_crc_pad_rem #(
		.BITSPERSYMBOL  (8),
		.SYMBOLSPERBEAT (8),
		.ERRORWIDTH     (5)
	) rx_eth_crc_pad_rem (
		.clk               (rx_clk_clk),                                                      //                  clock_reset.clk
		.reset             (rst_controller_002_reset_out_reset),                              //            clock_reset_reset.reset
		.csr_read          (rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_read),      //                          csr.read
		.csr_write         (rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_write),     //                             .write
		.csr_address       (rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_address),   //                             .address
		.csr_writedata     (rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_writedata), //                             .writedata
		.csr_readdata      (rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_readdata),  //                             .readdata
		.data_sink_sop     (rx_eth_frame_status_merger_data_src_startofpacket),               //   avalon_streaming_sink_data.startofpacket
		.data_sink_eop     (rx_eth_frame_status_merger_data_src_endofpacket),                 //                             .endofpacket
		.data_sink_valid   (rx_eth_frame_status_merger_data_src_valid),                       //                             .valid
		.data_sink_data    (rx_eth_frame_status_merger_data_src_data),                        //                             .data
		.data_sink_empty   (rx_eth_frame_status_merger_data_src_empty),                       //                             .empty
		.data_sink_error   (rx_eth_frame_status_merger_data_src_error),                       //                             .error
		.status_sink_valid (rx_eth_frame_decoder_avalon_st_pktinfo_src_valid),                // avalon_streaming_sink_status.valid
		.status_sink_data  (rx_eth_frame_decoder_avalon_st_pktinfo_src_data),                 //                             .data
		.data_source_sop   (rx_eth_crc_pad_rem_avalon_streaming_source_data_startofpacket),   // avalon_streaming_source_data.startofpacket
		.data_source_eop   (rx_eth_crc_pad_rem_avalon_streaming_source_data_endofpacket),     //                             .endofpacket
		.data_source_valid (rx_eth_crc_pad_rem_avalon_streaming_source_data_valid),           //                             .valid
		.data_source_data  (rx_eth_crc_pad_rem_avalon_streaming_source_data_data),            //                             .data
		.data_source_empty (rx_eth_crc_pad_rem_avalon_streaming_source_data_empty),           //                             .empty
		.data_source_error (rx_eth_crc_pad_rem_avalon_streaming_source_data_error)            //                             .error
	);

	altera_eth_packet_overflow_control #(
		.BITSPERSYMBOL  (8),
		.SYMBOLSPERBEAT (8),
		.ERROR_WIDTH    (5)
	) rx_eth_packet_overflow_control (
		.clk             (rx_clk_clk),                                                                 //             clock_reset.clk
		.reset           (rst_controller_002_reset_out_reset),                                         //       clock_reset_reset.reset
		.data_sink_sop   (rx_eth_crc_pad_rem_avalon_streaming_source_data_startofpacket),              //   avalon_streaming_sink.startofpacket
		.data_sink_eop   (rx_eth_crc_pad_rem_avalon_streaming_source_data_endofpacket),                //                        .endofpacket
		.data_sink_valid (rx_eth_crc_pad_rem_avalon_streaming_source_data_valid),                      //                        .valid
		.data_sink_empty (rx_eth_crc_pad_rem_avalon_streaming_source_data_empty),                      //                        .empty
		.data_sink_error (rx_eth_crc_pad_rem_avalon_streaming_source_data_error),                      //                        .error
		.data_sink_data  (rx_eth_crc_pad_rem_avalon_streaming_source_data_data),                       //                        .data
		.data_src_sop    (avalon_st_rx_startofpacket),                                                 // avalon_streaming_source.startofpacket
		.data_src_eop    (avalon_st_rx_endofpacket),                                                   //                        .endofpacket
		.data_src_valid  (avalon_st_rx_valid),                                                         //                        .valid
		.data_src_ready  (avalon_st_rx_ready),                                                         //                        .ready
		.data_src_data   (avalon_st_rx_data),                                                          //                        .data
		.data_src_empty  (avalon_st_rx_empty),                                                         //                        .empty
		.data_src_error  (avalon_st_rx_error),                                                         //                        .error
		.csr_address     (rx_eth_packet_overflow_control_csr_translator_avalon_anti_slave_0_address),  //                     csr.address
		.csr_read        (rx_eth_packet_overflow_control_csr_translator_avalon_anti_slave_0_read),     //                        .read
		.csr_readdata    (rx_eth_packet_overflow_control_csr_translator_avalon_anti_slave_0_readdata)  //                        .readdata
	);

	altera_avalon_st_delay #(
		.NUMBER_OF_DELAY_CLOCKS (2),
		.DATA_WIDTH             (40),
		.BITS_PER_SYMBOL        (40),
		.USE_PACKETS            (0),
		.USE_CHANNEL            (0),
		.CHANNEL_WIDTH          (1),
		.USE_ERROR              (1),
		.ERROR_WIDTH            (7)
	) rx_st_status_output_delay (
		.in0_valid          (rx_st_timing_adapter_splitter_status_output_out_valid), //        in.valid
		.in0_data           (rx_st_timing_adapter_splitter_status_output_out_data),  //          .data
		.in0_error          (rx_st_timing_adapter_splitter_status_output_out_error), //          .error
		.out0_valid         (avalon_st_rxstatus_valid),                              //       out.valid
		.out0_data          (avalon_st_rxstatus_data),                               //          .data
		.out0_error         (avalon_st_rxstatus_error),                              //          .error
		.clk                (rx_clk_clk),                                            //       clk.clk
		.reset_n            (~rst_controller_002_reset_out_reset),                   // clk_reset.reset_n
		.in0_startofpacket  (1'b0),                                                  // (terminated)
		.in0_endofpacket    (1'b0),                                                  // (terminated)
		.out0_startofpacket (),                                                      // (terminated)
		.out0_endofpacket   (),                                                      // (terminated)
		.in0_empty          (1'b0),                                                  // (terminated)
		.out0_empty         (),                                                      // (terminated)
		.in0_channel        (1'b0),                                                  // (terminated)
		.out0_channel       ()                                                       // (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rx_st_error_adapter_stat rx_st_error_adapter_stat (
		.clk       (rx_clk_clk),                                    //   clk.clk
		.reset_n   (~rst_controller_002_reset_out_reset),           // reset.reset_n
		.in_valid  (rx_eth_frame_status_merger_rxstatus_src_valid), //    in.valid
		.in_data   (rx_eth_frame_status_merger_rxstatus_src_data),  //      .data
		.in_error  (rx_eth_frame_status_merger_rxstatus_src_error), //      .error
		.out_valid (rx_st_error_adapter_stat_out_valid),            //   out.valid
		.out_data  (rx_st_error_adapter_stat_out_data),             //      .data
		.out_error (rx_st_error_adapter_stat_out_error)             //      .error
	);

	sonic_v1_15_eth_10g_eth_10g_mac_tx_st_timing_adapter_splitter_status_in rx_st_timing_adapter_splitter_status_in (
		.clk       (rx_clk_clk),                                        //   clk.clk
		.reset_n   (~rst_controller_002_reset_out_reset),               // reset.reset_n
		.in_valid  (rx_st_error_adapter_stat_out_valid),                //    in.valid
		.in_data   (rx_st_error_adapter_stat_out_data),                 //      .data
		.in_error  (rx_st_error_adapter_stat_out_error),                //      .error
		.out_valid (rx_st_timing_adapter_splitter_status_in_out_valid), //   out.valid
		.out_data  (rx_st_timing_adapter_splitter_status_in_out_data),  //      .data
		.out_error (rx_st_timing_adapter_splitter_status_in_out_error), //      .error
		.out_ready (rx_st_timing_adapter_splitter_status_in_out_ready)  //      .ready
	);

	altera_avalon_st_splitter #(
		.NUMBER_OF_OUTPUTS (2),
		.QUALIFY_VALID_OUT (1),
		.USE_PACKETS       (0),
		.DATA_WIDTH        (40),
		.CHANNEL_WIDTH     (1),
		.ERROR_WIDTH       (7),
		.BITS_PER_SYMBOL   (40),
		.EMPTY_WIDTH       (1)
	) rx_st_status_splitter (
		.clk                 (rx_clk_clk),                                        //  clk.clk
		.in0_ready           (rx_st_timing_adapter_splitter_status_in_out_ready), //   in.ready
		.in0_valid           (rx_st_timing_adapter_splitter_status_in_out_valid), //     .valid
		.in0_error           (rx_st_timing_adapter_splitter_status_in_out_error), //     .error
		.in0_data            (rx_st_timing_adapter_splitter_status_in_out_data),  //     .data
		.out0_ready          (rx_st_status_splitter_out0_ready),                  // out0.ready
		.out0_valid          (rx_st_status_splitter_out0_valid),                  //     .valid
		.out0_error          (rx_st_status_splitter_out0_error),                  //     .error
		.out0_data           (rx_st_status_splitter_out0_data),                   //     .data
		.out1_ready          (rx_st_status_splitter_out1_ready),                  // out1.ready
		.out1_valid          (rx_st_status_splitter_out1_valid),                  //     .valid
		.out1_error          (rx_st_status_splitter_out1_error),                  //     .error
		.out1_data           (rx_st_status_splitter_out1_data),                   //     .data
		.in0_startofpacket   (1'b0),                                              // (terminated)
		.in0_endofpacket     (1'b0),                                              // (terminated)
		.in0_empty           (1'b0),                                              // (terminated)
		.in0_channel         (1'b0),                                              // (terminated)
		.out0_startofpacket  (),                                                  // (terminated)
		.out0_endofpacket    (),                                                  // (terminated)
		.out0_empty          (),                                                  // (terminated)
		.out0_channel        (),                                                  // (terminated)
		.out1_startofpacket  (),                                                  // (terminated)
		.out1_endofpacket    (),                                                  // (terminated)
		.out1_empty          (),                                                  // (terminated)
		.out1_channel        (),                                                  // (terminated)
		.out2_ready          (1'b1),                                              // (terminated)
		.out2_valid          (),                                                  // (terminated)
		.out2_startofpacket  (),                                                  // (terminated)
		.out2_endofpacket    (),                                                  // (terminated)
		.out2_empty          (),                                                  // (terminated)
		.out2_channel        (),                                                  // (terminated)
		.out2_error          (),                                                  // (terminated)
		.out2_data           (),                                                  // (terminated)
		.out3_ready          (1'b1),                                              // (terminated)
		.out3_valid          (),                                                  // (terminated)
		.out3_startofpacket  (),                                                  // (terminated)
		.out3_endofpacket    (),                                                  // (terminated)
		.out3_empty          (),                                                  // (terminated)
		.out3_channel        (),                                                  // (terminated)
		.out3_error          (),                                                  // (terminated)
		.out3_data           (),                                                  // (terminated)
		.out4_ready          (1'b1),                                              // (terminated)
		.out4_valid          (),                                                  // (terminated)
		.out4_startofpacket  (),                                                  // (terminated)
		.out4_endofpacket    (),                                                  // (terminated)
		.out4_empty          (),                                                  // (terminated)
		.out4_channel        (),                                                  // (terminated)
		.out4_error          (),                                                  // (terminated)
		.out4_data           (),                                                  // (terminated)
		.out5_ready          (1'b1),                                              // (terminated)
		.out5_valid          (),                                                  // (terminated)
		.out5_startofpacket  (),                                                  // (terminated)
		.out5_endofpacket    (),                                                  // (terminated)
		.out5_empty          (),                                                  // (terminated)
		.out5_channel        (),                                                  // (terminated)
		.out5_error          (),                                                  // (terminated)
		.out5_data           (),                                                  // (terminated)
		.out6_ready          (1'b1),                                              // (terminated)
		.out6_valid          (),                                                  // (terminated)
		.out6_startofpacket  (),                                                  // (terminated)
		.out6_endofpacket    (),                                                  // (terminated)
		.out6_empty          (),                                                  // (terminated)
		.out6_channel        (),                                                  // (terminated)
		.out6_error          (),                                                  // (terminated)
		.out6_data           (),                                                  // (terminated)
		.out7_ready          (1'b1),                                              // (terminated)
		.out7_valid          (),                                                  // (terminated)
		.out7_startofpacket  (),                                                  // (terminated)
		.out7_endofpacket    (),                                                  // (terminated)
		.out7_empty          (),                                                  // (terminated)
		.out7_channel        (),                                                  // (terminated)
		.out7_error          (),                                                  // (terminated)
		.out7_data           (),                                                  // (terminated)
		.out8_ready          (1'b1),                                              // (terminated)
		.out8_valid          (),                                                  // (terminated)
		.out8_startofpacket  (),                                                  // (terminated)
		.out8_endofpacket    (),                                                  // (terminated)
		.out8_empty          (),                                                  // (terminated)
		.out8_channel        (),                                                  // (terminated)
		.out8_error          (),                                                  // (terminated)
		.out8_data           (),                                                  // (terminated)
		.out9_ready          (1'b1),                                              // (terminated)
		.out9_valid          (),                                                  // (terminated)
		.out9_startofpacket  (),                                                  // (terminated)
		.out9_endofpacket    (),                                                  // (terminated)
		.out9_empty          (),                                                  // (terminated)
		.out9_channel        (),                                                  // (terminated)
		.out9_error          (),                                                  // (terminated)
		.out9_data           (),                                                  // (terminated)
		.out10_ready         (1'b1),                                              // (terminated)
		.out10_valid         (),                                                  // (terminated)
		.out10_startofpacket (),                                                  // (terminated)
		.out10_endofpacket   (),                                                  // (terminated)
		.out10_empty         (),                                                  // (terminated)
		.out10_channel       (),                                                  // (terminated)
		.out10_error         (),                                                  // (terminated)
		.out10_data          (),                                                  // (terminated)
		.out11_ready         (1'b1),                                              // (terminated)
		.out11_valid         (),                                                  // (terminated)
		.out11_startofpacket (),                                                  // (terminated)
		.out11_endofpacket   (),                                                  // (terminated)
		.out11_empty         (),                                                  // (terminated)
		.out11_channel       (),                                                  // (terminated)
		.out11_error         (),                                                  // (terminated)
		.out11_data          (),                                                  // (terminated)
		.out12_ready         (1'b1),                                              // (terminated)
		.out12_valid         (),                                                  // (terminated)
		.out12_startofpacket (),                                                  // (terminated)
		.out12_endofpacket   (),                                                  // (terminated)
		.out12_empty         (),                                                  // (terminated)
		.out12_channel       (),                                                  // (terminated)
		.out12_error         (),                                                  // (terminated)
		.out12_data          (),                                                  // (terminated)
		.out13_ready         (1'b1),                                              // (terminated)
		.out13_valid         (),                                                  // (terminated)
		.out13_startofpacket (),                                                  // (terminated)
		.out13_endofpacket   (),                                                  // (terminated)
		.out13_empty         (),                                                  // (terminated)
		.out13_channel       (),                                                  // (terminated)
		.out13_error         (),                                                  // (terminated)
		.out13_data          (),                                                  // (terminated)
		.out14_ready         (1'b1),                                              // (terminated)
		.out14_valid         (),                                                  // (terminated)
		.out14_startofpacket (),                                                  // (terminated)
		.out14_endofpacket   (),                                                  // (terminated)
		.out14_empty         (),                                                  // (terminated)
		.out14_channel       (),                                                  // (terminated)
		.out14_error         (),                                                  // (terminated)
		.out14_data          (),                                                  // (terminated)
		.out15_ready         (1'b1),                                              // (terminated)
		.out15_valid         (),                                                  // (terminated)
		.out15_startofpacket (),                                                  // (terminated)
		.out15_endofpacket   (),                                                  // (terminated)
		.out15_empty         (),                                                  // (terminated)
		.out15_channel       (),                                                  // (terminated)
		.out15_error         (),                                                  // (terminated)
		.out15_data          ()                                                   // (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_tx_st_timing_adapter_splitter_status_output rx_st_timing_adapter_splitter_status_statistics (
		.clk       (rx_clk_clk),                                                //   clk.clk
		.reset_n   (~rst_controller_002_reset_out_reset),                       // reset.reset_n
		.in_ready  (rx_st_status_splitter_out0_ready),                          //    in.ready
		.in_valid  (rx_st_status_splitter_out0_valid),                          //      .valid
		.in_data   (rx_st_status_splitter_out0_data),                           //      .data
		.in_error  (rx_st_status_splitter_out0_error),                          //      .error
		.out_valid (rx_st_timing_adapter_splitter_status_statistics_out_valid), //   out.valid
		.out_data  (rx_st_timing_adapter_splitter_status_statistics_out_data),  //      .data
		.out_error (rx_st_timing_adapter_splitter_status_statistics_out_error)  //      .error
	);

	sonic_v1_15_eth_10g_eth_10g_mac_tx_st_timing_adapter_splitter_status_output rx_st_timing_adapter_splitter_status_output (
		.clk       (rx_clk_clk),                                            //   clk.clk
		.reset_n   (~rst_controller_002_reset_out_reset),                   // reset.reset_n
		.in_ready  (rx_st_status_splitter_out1_ready),                      //    in.ready
		.in_valid  (rx_st_status_splitter_out1_valid),                      //      .valid
		.in_data   (rx_st_status_splitter_out1_data),                       //      .data
		.in_error  (rx_st_status_splitter_out1_error),                      //      .error
		.out_valid (rx_st_timing_adapter_splitter_status_output_out_valid), //   out.valid
		.out_data  (rx_st_timing_adapter_splitter_status_output_out_data),  //      .data
		.out_error (rx_st_timing_adapter_splitter_status_output_out_error)  //      .error
	);

	altera_avalon_st_delay #(
		.NUMBER_OF_DELAY_CLOCKS (1),
		.DATA_WIDTH             (40),
		.BITS_PER_SYMBOL        (40),
		.USE_PACKETS            (0),
		.USE_CHANNEL            (0),
		.CHANNEL_WIDTH          (1),
		.USE_ERROR              (1),
		.ERROR_WIDTH            (7)
	) rx_st_status_statistics_delay (
		.in0_valid          (rx_st_timing_adapter_splitter_status_statistics_out_valid), //        in.valid
		.in0_data           (rx_st_timing_adapter_splitter_status_statistics_out_data),  //          .data
		.in0_error          (rx_st_timing_adapter_splitter_status_statistics_out_error), //          .error
		.out0_valid         (rx_st_status_statistics_delay_out_valid),                   //       out.valid
		.out0_data          (rx_st_status_statistics_delay_out_data),                    //          .data
		.out0_error         (rx_st_status_statistics_delay_out_error),                   //          .error
		.clk                (rx_clk_clk),                                                //       clk.clk
		.reset_n            (~rst_controller_002_reset_out_reset),                       // clk_reset.reset_n
		.in0_startofpacket  (1'b0),                                                      // (terminated)
		.in0_endofpacket    (1'b0),                                                      // (terminated)
		.out0_startofpacket (),                                                          // (terminated)
		.out0_endofpacket   (),                                                          // (terminated)
		.in0_empty          (1'b0),                                                      // (terminated)
		.out0_empty         (),                                                          // (terminated)
		.in0_channel        (1'b0),                                                      // (terminated)
		.out0_channel       ()                                                           // (terminated)
	);

	altera_eth_10gmem_statistics_collector #(
		.ENABLE_PFC (0)
	) rx_eth_statistics_collector (
		.clk             (rx_clk_clk),                                                               //         clock_reset.clk
		.reset           (rst_controller_002_reset_out_reset),                                       //   clock_reset_reset.reset
		.csr_read        (rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_read),      //                 csr.read
		.csr_address     (rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_address),   //                    .address
		.csr_readdata    (rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_readdata),  //                    .readdata
		.csr_write       (rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_write),     //                    .write
		.csr_writedata   (rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_writedata), //                    .writedata
		.stat_sink_valid (rx_st_status_statistics_delay_out_valid),                                  // avalon_st_sink_data.valid
		.stat_sink_data  (rx_st_status_statistics_delay_out_data),                                   //                    .data
		.stat_sink_error (rx_st_status_statistics_delay_out_error)                                   //                    .error
	);

	sonic_v1_15_eth_10g_eth_10g_mac_txrx_timing_adapter_link_fault_status_rx txrx_timing_adapter_link_fault_status_rx (
		.clk       (rx_clk_clk),                                         //   clk.clk
		.reset_n   (~rst_controller_002_reset_out_reset),                // reset.reset_n
		.in_data   (rx_eth_link_fault_detection_link_fault_src_data),    //    in.data
		.out_data  (txrx_timing_adapter_link_fault_status_rx_out_data),  //   out.data
		.out_ready (txrx_timing_adapter_link_fault_status_rx_out_ready), //      .ready
		.out_valid (txrx_timing_adapter_link_fault_status_rx_out_valid)  //      .valid
	);

	altera_avalon_st_splitter #(
		.NUMBER_OF_OUTPUTS (2),
		.QUALIFY_VALID_OUT (0),
		.USE_PACKETS       (0),
		.DATA_WIDTH        (2),
		.CHANNEL_WIDTH     (1),
		.ERROR_WIDTH       (1),
		.BITS_PER_SYMBOL   (2),
		.EMPTY_WIDTH       (1)
	) txrx_st_splitter_link_fault_status (
		.clk                 (rx_clk_clk),                                         //  clk.clk
		.in0_ready           (txrx_timing_adapter_link_fault_status_rx_out_ready), //   in.ready
		.in0_valid           (txrx_timing_adapter_link_fault_status_rx_out_valid), //     .valid
		.in0_data            (txrx_timing_adapter_link_fault_status_rx_out_data),  //     .data
		.out0_ready          (txrx_st_splitter_link_fault_status_out0_ready),      // out0.ready
		.out0_valid          (txrx_st_splitter_link_fault_status_out0_valid),      //     .valid
		.out0_data           (txrx_st_splitter_link_fault_status_out0_data),       //     .data
		.out1_ready          (txrx_st_splitter_link_fault_status_out1_ready),      // out1.ready
		.out1_valid          (txrx_st_splitter_link_fault_status_out1_valid),      //     .valid
		.out1_data           (txrx_st_splitter_link_fault_status_out1_data),       //     .data
		.in0_startofpacket   (1'b0),                                               // (terminated)
		.in0_endofpacket     (1'b0),                                               // (terminated)
		.in0_empty           (1'b0),                                               // (terminated)
		.in0_channel         (1'b0),                                               // (terminated)
		.in0_error           (1'b0),                                               // (terminated)
		.out0_startofpacket  (),                                                   // (terminated)
		.out0_endofpacket    (),                                                   // (terminated)
		.out0_empty          (),                                                   // (terminated)
		.out0_channel        (),                                                   // (terminated)
		.out0_error          (),                                                   // (terminated)
		.out1_startofpacket  (),                                                   // (terminated)
		.out1_endofpacket    (),                                                   // (terminated)
		.out1_empty          (),                                                   // (terminated)
		.out1_channel        (),                                                   // (terminated)
		.out1_error          (),                                                   // (terminated)
		.out2_ready          (1'b1),                                               // (terminated)
		.out2_valid          (),                                                   // (terminated)
		.out2_startofpacket  (),                                                   // (terminated)
		.out2_endofpacket    (),                                                   // (terminated)
		.out2_empty          (),                                                   // (terminated)
		.out2_channel        (),                                                   // (terminated)
		.out2_error          (),                                                   // (terminated)
		.out2_data           (),                                                   // (terminated)
		.out3_ready          (1'b1),                                               // (terminated)
		.out3_valid          (),                                                   // (terminated)
		.out3_startofpacket  (),                                                   // (terminated)
		.out3_endofpacket    (),                                                   // (terminated)
		.out3_empty          (),                                                   // (terminated)
		.out3_channel        (),                                                   // (terminated)
		.out3_error          (),                                                   // (terminated)
		.out3_data           (),                                                   // (terminated)
		.out4_ready          (1'b1),                                               // (terminated)
		.out4_valid          (),                                                   // (terminated)
		.out4_startofpacket  (),                                                   // (terminated)
		.out4_endofpacket    (),                                                   // (terminated)
		.out4_empty          (),                                                   // (terminated)
		.out4_channel        (),                                                   // (terminated)
		.out4_error          (),                                                   // (terminated)
		.out4_data           (),                                                   // (terminated)
		.out5_ready          (1'b1),                                               // (terminated)
		.out5_valid          (),                                                   // (terminated)
		.out5_startofpacket  (),                                                   // (terminated)
		.out5_endofpacket    (),                                                   // (terminated)
		.out5_empty          (),                                                   // (terminated)
		.out5_channel        (),                                                   // (terminated)
		.out5_error          (),                                                   // (terminated)
		.out5_data           (),                                                   // (terminated)
		.out6_ready          (1'b1),                                               // (terminated)
		.out6_valid          (),                                                   // (terminated)
		.out6_startofpacket  (),                                                   // (terminated)
		.out6_endofpacket    (),                                                   // (terminated)
		.out6_empty          (),                                                   // (terminated)
		.out6_channel        (),                                                   // (terminated)
		.out6_error          (),                                                   // (terminated)
		.out6_data           (),                                                   // (terminated)
		.out7_ready          (1'b1),                                               // (terminated)
		.out7_valid          (),                                                   // (terminated)
		.out7_startofpacket  (),                                                   // (terminated)
		.out7_endofpacket    (),                                                   // (terminated)
		.out7_empty          (),                                                   // (terminated)
		.out7_channel        (),                                                   // (terminated)
		.out7_error          (),                                                   // (terminated)
		.out7_data           (),                                                   // (terminated)
		.out8_ready          (1'b1),                                               // (terminated)
		.out8_valid          (),                                                   // (terminated)
		.out8_startofpacket  (),                                                   // (terminated)
		.out8_endofpacket    (),                                                   // (terminated)
		.out8_empty          (),                                                   // (terminated)
		.out8_channel        (),                                                   // (terminated)
		.out8_error          (),                                                   // (terminated)
		.out8_data           (),                                                   // (terminated)
		.out9_ready          (1'b1),                                               // (terminated)
		.out9_valid          (),                                                   // (terminated)
		.out9_startofpacket  (),                                                   // (terminated)
		.out9_endofpacket    (),                                                   // (terminated)
		.out9_empty          (),                                                   // (terminated)
		.out9_channel        (),                                                   // (terminated)
		.out9_error          (),                                                   // (terminated)
		.out9_data           (),                                                   // (terminated)
		.out10_ready         (1'b1),                                               // (terminated)
		.out10_valid         (),                                                   // (terminated)
		.out10_startofpacket (),                                                   // (terminated)
		.out10_endofpacket   (),                                                   // (terminated)
		.out10_empty         (),                                                   // (terminated)
		.out10_channel       (),                                                   // (terminated)
		.out10_error         (),                                                   // (terminated)
		.out10_data          (),                                                   // (terminated)
		.out11_ready         (1'b1),                                               // (terminated)
		.out11_valid         (),                                                   // (terminated)
		.out11_startofpacket (),                                                   // (terminated)
		.out11_endofpacket   (),                                                   // (terminated)
		.out11_empty         (),                                                   // (terminated)
		.out11_channel       (),                                                   // (terminated)
		.out11_error         (),                                                   // (terminated)
		.out11_data          (),                                                   // (terminated)
		.out12_ready         (1'b1),                                               // (terminated)
		.out12_valid         (),                                                   // (terminated)
		.out12_startofpacket (),                                                   // (terminated)
		.out12_endofpacket   (),                                                   // (terminated)
		.out12_empty         (),                                                   // (terminated)
		.out12_channel       (),                                                   // (terminated)
		.out12_error         (),                                                   // (terminated)
		.out12_data          (),                                                   // (terminated)
		.out13_ready         (1'b1),                                               // (terminated)
		.out13_valid         (),                                                   // (terminated)
		.out13_startofpacket (),                                                   // (terminated)
		.out13_endofpacket   (),                                                   // (terminated)
		.out13_empty         (),                                                   // (terminated)
		.out13_channel       (),                                                   // (terminated)
		.out13_error         (),                                                   // (terminated)
		.out13_data          (),                                                   // (terminated)
		.out14_ready         (1'b1),                                               // (terminated)
		.out14_valid         (),                                                   // (terminated)
		.out14_startofpacket (),                                                   // (terminated)
		.out14_endofpacket   (),                                                   // (terminated)
		.out14_empty         (),                                                   // (terminated)
		.out14_channel       (),                                                   // (terminated)
		.out14_error         (),                                                   // (terminated)
		.out14_data          (),                                                   // (terminated)
		.out15_ready         (1'b1),                                               // (terminated)
		.out15_valid         (),                                                   // (terminated)
		.out15_startofpacket (),                                                   // (terminated)
		.out15_endofpacket   (),                                                   // (terminated)
		.out15_empty         (),                                                   // (terminated)
		.out15_channel       (),                                                   // (terminated)
		.out15_error         (),                                                   // (terminated)
		.out15_data          ()                                                    // (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_txrx_timing_adapter_link_fault_status_export txrx_timing_adapter_link_fault_status_export (
		.clk      (rx_clk_clk),                                    //   clk.clk
		.reset_n  (~rst_controller_002_reset_out_reset),           // reset.reset_n
		.in_ready (txrx_st_splitter_link_fault_status_out0_ready), //    in.ready
		.in_valid (txrx_st_splitter_link_fault_status_out0_valid), //      .valid
		.in_data  (txrx_st_splitter_link_fault_status_out0_data),  //      .data
		.out_data (link_fault_status_xgmii_rx_data)                //   out.data
	);

	altera_avalon_dc_fifo #(
		.SYMBOLS_PER_BEAT   (1),
		.BITS_PER_SYMBOL    (2),
		.FIFO_DEPTH         (16),
		.CHANNEL_WIDTH      (0),
		.ERROR_WIDTH        (0),
		.USE_PACKETS        (0),
		.USE_IN_FILL_LEVEL  (0),
		.USE_OUT_FILL_LEVEL (0),
		.WR_SYNC_DEPTH      (2),
		.RD_SYNC_DEPTH      (2)
	) rxtx_dc_fifo_link_fault_status (
		.in_clk      (rx_clk_clk),                                    //        in_clk.clk
		.in_reset_n  (~rst_controller_002_reset_out_reset),           //  in_clk_reset.reset_n
		.out_clk     (tx_clk_clk),                                    //       out_clk.clk
		.out_reset_n (~rst_controller_001_reset_out_reset),           // out_clk_reset.reset_n
		.in_data     (txrx_st_splitter_link_fault_status_out1_data),  //            in.data
		.in_valid    (txrx_st_splitter_link_fault_status_out1_valid), //              .valid
		.in_ready    (txrx_st_splitter_link_fault_status_out1_ready), //              .ready
		.out_data    (rxtx_dc_fifo_link_fault_status_out_data),       //           out.data
		.out_valid   (rxtx_dc_fifo_link_fault_status_out_valid),      //              .valid
		.out_ready   (rxtx_dc_fifo_link_fault_status_out_ready)       //              .ready
	);

	sonic_v1_15_eth_10g_eth_10g_mac_txrx_timing_adapter_link_fault_status_export rxtx_timing_adapter_link_fault_status_tx (
		.clk      (tx_clk_clk),                                        //   clk.clk
		.reset_n  (~rst_controller_001_reset_out_reset),               // reset.reset_n
		.in_ready (rxtx_dc_fifo_link_fault_status_out_ready),          //    in.ready
		.in_valid (rxtx_dc_fifo_link_fault_status_out_valid),          //      .valid
		.in_data  (rxtx_dc_fifo_link_fault_status_out_data),           //      .data
		.out_data (rxtx_timing_adapter_link_fault_status_tx_out_data)  //   out.data
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rxtx_timing_adapter_pauselen_rx rxtx_timing_adapter_pauselen_rx (
		.clk       (rx_clk_clk),                                    //   clk.clk
		.reset_n   (~rst_controller_002_reset_out_reset),           // reset.reset_n
		.in_valid  (rx_eth_frame_status_merger_pauselen_src_valid), //    in.valid
		.in_data   (rx_eth_frame_status_merger_pauselen_src_data),  //      .data
		.out_valid (rxtx_timing_adapter_pauselen_rx_out_valid),     //   out.valid
		.out_data  (rxtx_timing_adapter_pauselen_rx_out_data),      //      .data
		.out_ready (rxtx_timing_adapter_pauselen_rx_out_ready)      //      .ready
	);

	altera_avalon_dc_fifo #(
		.SYMBOLS_PER_BEAT   (1),
		.BITS_PER_SYMBOL    (16),
		.FIFO_DEPTH         (16),
		.CHANNEL_WIDTH      (0),
		.ERROR_WIDTH        (0),
		.USE_PACKETS        (0),
		.USE_IN_FILL_LEVEL  (0),
		.USE_OUT_FILL_LEVEL (0),
		.WR_SYNC_DEPTH      (2),
		.RD_SYNC_DEPTH      (2)
	) rxtx_dc_fifo_pauselen (
		.in_clk      (rx_clk_clk),                                //        in_clk.clk
		.in_reset_n  (~rst_controller_002_reset_out_reset),       //  in_clk_reset.reset_n
		.out_clk     (tx_clk_clk),                                //       out_clk.clk
		.out_reset_n (~rst_controller_001_reset_out_reset),       // out_clk_reset.reset_n
		.in_data     (rxtx_timing_adapter_pauselen_rx_out_data),  //            in.data
		.in_valid    (rxtx_timing_adapter_pauselen_rx_out_valid), //              .valid
		.in_ready    (rxtx_timing_adapter_pauselen_rx_out_ready), //              .ready
		.out_data    (rxtx_dc_fifo_pauselen_out_data),            //           out.data
		.out_valid   (rxtx_dc_fifo_pauselen_out_valid),           //              .valid
		.out_ready   (rxtx_dc_fifo_pauselen_out_ready)            //              .ready
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rxtx_timing_adapter_pauselen_tx rxtx_timing_adapter_pauselen_tx (
		.clk       (tx_clk_clk),                                //   clk.clk
		.reset_n   (~rst_controller_001_reset_out_reset),       // reset.reset_n
		.in_ready  (rxtx_dc_fifo_pauselen_out_ready),           //    in.ready
		.in_valid  (rxtx_dc_fifo_pauselen_out_valid),           //      .valid
		.in_data   (rxtx_dc_fifo_pauselen_out_data),            //      .data
		.out_valid (rxtx_timing_adapter_pauselen_tx_out_valid), //   out.valid
		.out_data  (rxtx_timing_adapter_pauselen_tx_out_data)   //      .data
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (15),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (3),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (15),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (1),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) merlin_master_translator_avalon_universal_master_0_translator (
		.clk                   (csr_clk_clk),                                                                                           //                       clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                                        //                     reset.reset
		.uav_address           (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (merlin_master_translator_avalon_universal_master_0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (merlin_master_translator_avalon_universal_master_0_waitrequest),                                        //                          .waitrequest
		.av_burstcount         (merlin_master_translator_avalon_universal_master_0_burstcount),                                         //                          .burstcount
		.av_byteenable         (merlin_master_translator_avalon_universal_master_0_byteenable),                                         //                          .byteenable
		.av_read               (merlin_master_translator_avalon_universal_master_0_read),                                               //                          .read
		.av_readdata           (merlin_master_translator_avalon_universal_master_0_readdata),                                           //                          .readdata
		.av_readdatavalid      (merlin_master_translator_avalon_universal_master_0_readdatavalid),                                      //                          .readdatavalid
		.av_write              (merlin_master_translator_avalon_universal_master_0_write),                                              //                          .write
		.av_writedata          (merlin_master_translator_avalon_universal_master_0_writedata),                                          //                          .writedata
		.av_lock               (merlin_master_translator_avalon_universal_master_0_lock),                                               //                          .lock
		.av_debugaccess        (merlin_master_translator_avalon_universal_master_0_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer (1'b0),                                                                                                  //               (terminated)
		.av_begintransfer      (1'b0),                                                                                                  //               (terminated)
		.av_chipselect         (1'b0),                                                                                                  //               (terminated)
		.uav_clken             (),                                                                                                      //               (terminated)
		.av_clken              (1'b1)                                                                                                   //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (14),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (15),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (1),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) tx_bridge_s0_translator (
		.clk                   (tx_clk_clk),                                                              //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                      //                    reset.reset
		.uav_address           (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (tx_bridge_s0_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (tx_bridge_s0_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (tx_bridge_s0_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (tx_bridge_s0_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (tx_bridge_s0_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_burstcount         (tx_bridge_s0_translator_avalon_anti_slave_0_burstcount),                  //                         .burstcount
		.av_byteenable         (tx_bridge_s0_translator_avalon_anti_slave_0_byteenable),                  //                         .byteenable
		.av_readdatavalid      (tx_bridge_s0_translator_avalon_anti_slave_0_readdatavalid),               //                         .readdatavalid
		.av_waitrequest        (tx_bridge_s0_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_debugaccess        (tx_bridge_s0_translator_avalon_anti_slave_0_debugaccess),                 //                         .debugaccess
		.av_begintransfer      (),                                                                        //              (terminated)
		.av_beginbursttransfer (),                                                                        //              (terminated)
		.av_writebyteenable    (),                                                                        //              (terminated)
		.av_lock               (),                                                                        //              (terminated)
		.av_chipselect         (),                                                                        //              (terminated)
		.av_clken              (),                                                                        //              (terminated)
		.uav_clken             (1'b0),                                                                    //              (terminated)
		.av_outputenable       ()                                                                         //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (14),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (15),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (1),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) rx_bridge_s0_translator (
		.clk                   (rx_clk_clk),                                                              //                      clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                      //                    reset.reset
		.uav_address           (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (rx_bridge_s0_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (rx_bridge_s0_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (rx_bridge_s0_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (rx_bridge_s0_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (rx_bridge_s0_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_burstcount         (rx_bridge_s0_translator_avalon_anti_slave_0_burstcount),                  //                         .burstcount
		.av_byteenable         (rx_bridge_s0_translator_avalon_anti_slave_0_byteenable),                  //                         .byteenable
		.av_readdatavalid      (rx_bridge_s0_translator_avalon_anti_slave_0_readdatavalid),               //                         .readdatavalid
		.av_waitrequest        (rx_bridge_s0_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_debugaccess        (rx_bridge_s0_translator_avalon_anti_slave_0_debugaccess),                 //                         .debugaccess
		.av_begintransfer      (),                                                                        //              (terminated)
		.av_beginbursttransfer (),                                                                        //              (terminated)
		.av_writebyteenable    (),                                                                        //              (terminated)
		.av_lock               (),                                                                        //              (terminated)
		.av_chipselect         (),                                                                        //              (terminated)
		.av_clken              (),                                                                        //              (terminated)
		.uav_clken             (1'b0),                                                                    //              (terminated)
		.av_outputenable       ()                                                                         //              (terminated)
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (14),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (14),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) tx_bridge_m0_translator (
		.clk                   (tx_clk_clk),                                                      //                       clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                              //                     reset.reset
		.uav_address           (tx_bridge_m0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (tx_bridge_m0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (tx_bridge_m0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (tx_bridge_m0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (tx_bridge_m0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (tx_bridge_m0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (tx_bridge_m0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (tx_bridge_m0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (tx_bridge_m0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (tx_bridge_m0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (tx_bridge_m0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (tx_bridge_m0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (tx_bridge_m0_waitrequest),                                        //                          .waitrequest
		.av_burstcount         (tx_bridge_m0_burstcount),                                         //                          .burstcount
		.av_byteenable         (tx_bridge_m0_byteenable),                                         //                          .byteenable
		.av_read               (tx_bridge_m0_read),                                               //                          .read
		.av_readdata           (tx_bridge_m0_readdata),                                           //                          .readdata
		.av_readdatavalid      (tx_bridge_m0_readdatavalid),                                      //                          .readdatavalid
		.av_write              (tx_bridge_m0_write),                                              //                          .write
		.av_writedata          (tx_bridge_m0_writedata),                                          //                          .writedata
		.av_debugaccess        (tx_bridge_m0_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer (1'b0),                                                            //               (terminated)
		.av_begintransfer      (1'b0),                                                            //               (terminated)
		.av_chipselect         (1'b0),                                                            //               (terminated)
		.av_lock               (1'b0),                                                            //               (terminated)
		.uav_clken             (),                                                                //               (terminated)
		.av_clken              (1'b1)                                                             //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (1),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) tx_eth_pkt_backpressure_control_csr_translator (
		.clk                   (tx_clk_clk),                                                                                     //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                                             //                    reset.reset
		.uav_address           (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (tx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                               //              (terminated)
		.av_beginbursttransfer (),                                                                                               //              (terminated)
		.av_burstcount         (),                                                                                               //              (terminated)
		.av_byteenable         (),                                                                                               //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                           //              (terminated)
		.av_waitrequest        (1'b0),                                                                                           //              (terminated)
		.av_writebyteenable    (),                                                                                               //              (terminated)
		.av_lock               (),                                                                                               //              (terminated)
		.av_chipselect         (),                                                                                               //              (terminated)
		.av_clken              (),                                                                                               //              (terminated)
		.uav_clken             (1'b0),                                                                                           //              (terminated)
		.av_debugaccess        (),                                                                                               //              (terminated)
		.av_outputenable       ()                                                                                                //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (1),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) tx_eth_pad_inserter_csr_translator (
		.clk                   (tx_clk_clk),                                                                         //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                                 //                    reset.reset
		.uav_address           (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (tx_eth_pad_inserter_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                   //              (terminated)
		.av_beginbursttransfer (),                                                                                   //              (terminated)
		.av_burstcount         (),                                                                                   //              (terminated)
		.av_byteenable         (),                                                                                   //              (terminated)
		.av_readdatavalid      (1'b0),                                                                               //              (terminated)
		.av_waitrequest        (1'b0),                                                                               //              (terminated)
		.av_writebyteenable    (),                                                                                   //              (terminated)
		.av_lock               (),                                                                                   //              (terminated)
		.av_chipselect         (),                                                                                   //              (terminated)
		.av_clken              (),                                                                                   //              (terminated)
		.uav_clken             (1'b0),                                                                               //              (terminated)
		.av_debugaccess        (),                                                                                   //              (terminated)
		.av_outputenable       ()                                                                                    //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (1),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) tx_eth_crc_inserter_csr_translator (
		.clk                   (tx_clk_clk),                                                                         //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                                 //                    reset.reset
		.uav_address           (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (tx_eth_crc_inserter_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                   //              (terminated)
		.av_beginbursttransfer (),                                                                                   //              (terminated)
		.av_burstcount         (),                                                                                   //              (terminated)
		.av_byteenable         (),                                                                                   //              (terminated)
		.av_readdatavalid      (1'b0),                                                                               //              (terminated)
		.av_waitrequest        (1'b0),                                                                               //              (terminated)
		.av_writebyteenable    (),                                                                                   //              (terminated)
		.av_lock               (),                                                                                   //              (terminated)
		.av_chipselect         (),                                                                                   //              (terminated)
		.av_clken              (),                                                                                   //              (terminated)
		.uav_clken             (1'b0),                                                                               //              (terminated)
		.av_debugaccess        (),                                                                                   //              (terminated)
		.av_outputenable       ()                                                                                    //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (2),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) tx_eth_pause_ctrl_gen_csr_translator (
		.clk                   (tx_clk_clk),                                                                           //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                                   //                    reset.reset
		.uav_address           (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (tx_eth_pause_ctrl_gen_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                     //              (terminated)
		.av_beginbursttransfer (),                                                                                     //              (terminated)
		.av_burstcount         (),                                                                                     //              (terminated)
		.av_byteenable         (),                                                                                     //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                 //              (terminated)
		.av_waitrequest        (1'b0),                                                                                 //              (terminated)
		.av_writebyteenable    (),                                                                                     //              (terminated)
		.av_lock               (),                                                                                     //              (terminated)
		.av_chipselect         (),                                                                                     //              (terminated)
		.av_clken              (),                                                                                     //              (terminated)
		.uav_clken             (1'b0),                                                                                 //              (terminated)
		.av_debugaccess        (),                                                                                     //              (terminated)
		.av_outputenable       ()                                                                                      //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (2),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) tx_eth_address_inserter_csr_translator (
		.clk                   (tx_clk_clk),                                                                             //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                                     //                    reset.reset
		.uav_address           (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (tx_eth_address_inserter_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                       //              (terminated)
		.av_beginbursttransfer (),                                                                                       //              (terminated)
		.av_burstcount         (),                                                                                       //              (terminated)
		.av_byteenable         (),                                                                                       //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                   //              (terminated)
		.av_waitrequest        (1'b0),                                                                                   //              (terminated)
		.av_writebyteenable    (),                                                                                       //              (terminated)
		.av_lock               (),                                                                                       //              (terminated)
		.av_chipselect         (),                                                                                       //              (terminated)
		.av_clken              (),                                                                                       //              (terminated)
		.uav_clken             (1'b0),                                                                                   //              (terminated)
		.av_debugaccess        (),                                                                                       //              (terminated)
		.av_outputenable       ()                                                                                        //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (1),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) tx_eth_packet_underflow_control_avalon_slave_0_translator (
		.clk                   (tx_clk_clk),                                                                                                //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                                                        //                    reset.reset
		.uav_address           (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_read               (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_write              (),                                                                                                          //              (terminated)
		.av_writedata          (),                                                                                                          //              (terminated)
		.av_begintransfer      (),                                                                                                          //              (terminated)
		.av_beginbursttransfer (),                                                                                                          //              (terminated)
		.av_burstcount         (),                                                                                                          //              (terminated)
		.av_byteenable         (),                                                                                                          //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                                      //              (terminated)
		.av_waitrequest        (1'b0),                                                                                                      //              (terminated)
		.av_writebyteenable    (),                                                                                                          //              (terminated)
		.av_lock               (),                                                                                                          //              (terminated)
		.av_chipselect         (),                                                                                                          //              (terminated)
		.av_clken              (),                                                                                                          //              (terminated)
		.uav_clken             (1'b0),                                                                                                      //              (terminated)
		.av_debugaccess        (),                                                                                                          //              (terminated)
		.av_outputenable       ()                                                                                                           //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (5),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) tx_eth_frame_decoder_avalom_mm_csr_translator (
		.clk                   (tx_clk_clk),                                                                                    //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                                            //                    reset.reset
		.uav_address           (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                              //              (terminated)
		.av_beginbursttransfer (),                                                                                              //              (terminated)
		.av_burstcount         (),                                                                                              //              (terminated)
		.av_byteenable         (),                                                                                              //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                          //              (terminated)
		.av_waitrequest        (1'b0),                                                                                          //              (terminated)
		.av_writebyteenable    (),                                                                                              //              (terminated)
		.av_lock               (),                                                                                              //              (terminated)
		.av_chipselect         (),                                                                                              //              (terminated)
		.av_clken              (),                                                                                              //              (terminated)
		.uav_clken             (1'b0),                                                                                          //              (terminated)
		.av_debugaccess        (),                                                                                              //              (terminated)
		.av_outputenable       ()                                                                                               //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (6),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (2),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) tx_eth_statistics_collector_csr_translator (
		.clk                   (tx_clk_clk),                                                                                 //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                                         //                    reset.reset
		.uav_address           (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (tx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                           //              (terminated)
		.av_beginbursttransfer (),                                                                                           //              (terminated)
		.av_burstcount         (),                                                                                           //              (terminated)
		.av_byteenable         (),                                                                                           //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                       //              (terminated)
		.av_waitrequest        (1'b0),                                                                                       //              (terminated)
		.av_writebyteenable    (),                                                                                           //              (terminated)
		.av_lock               (),                                                                                           //              (terminated)
		.av_chipselect         (),                                                                                           //              (terminated)
		.av_clken              (),                                                                                           //              (terminated)
		.uav_clken             (1'b0),                                                                                       //              (terminated)
		.av_debugaccess        (),                                                                                           //              (terminated)
		.av_outputenable       ()                                                                                            //              (terminated)
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (14),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (14),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) rx_bridge_m0_translator (
		.clk                   (rx_clk_clk),                                                      //                       clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                              //                     reset.reset
		.uav_address           (rx_bridge_m0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (rx_bridge_m0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (rx_bridge_m0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (rx_bridge_m0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (rx_bridge_m0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (rx_bridge_m0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (rx_bridge_m0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (rx_bridge_m0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (rx_bridge_m0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (rx_bridge_m0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (rx_bridge_m0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (rx_bridge_m0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (rx_bridge_m0_waitrequest),                                        //                          .waitrequest
		.av_burstcount         (rx_bridge_m0_burstcount),                                         //                          .burstcount
		.av_byteenable         (rx_bridge_m0_byteenable),                                         //                          .byteenable
		.av_read               (rx_bridge_m0_read),                                               //                          .read
		.av_readdata           (rx_bridge_m0_readdata),                                           //                          .readdata
		.av_readdatavalid      (rx_bridge_m0_readdatavalid),                                      //                          .readdatavalid
		.av_write              (rx_bridge_m0_write),                                              //                          .write
		.av_writedata          (rx_bridge_m0_writedata),                                          //                          .writedata
		.av_debugaccess        (rx_bridge_m0_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer (1'b0),                                                            //               (terminated)
		.av_begintransfer      (1'b0),                                                            //               (terminated)
		.av_chipselect         (1'b0),                                                            //               (terminated)
		.av_lock               (1'b0),                                                            //               (terminated)
		.uav_clken             (),                                                                //               (terminated)
		.av_clken              (1'b1)                                                             //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (1),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) rx_eth_pkt_backpressure_control_csr_translator (
		.clk                   (rx_clk_clk),                                                                                     //                      clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                                             //                    reset.reset
		.uav_address           (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (rx_eth_pkt_backpressure_control_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                               //              (terminated)
		.av_beginbursttransfer (),                                                                                               //              (terminated)
		.av_burstcount         (),                                                                                               //              (terminated)
		.av_byteenable         (),                                                                                               //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                           //              (terminated)
		.av_waitrequest        (1'b0),                                                                                           //              (terminated)
		.av_writebyteenable    (),                                                                                               //              (terminated)
		.av_lock               (),                                                                                               //              (terminated)
		.av_chipselect         (),                                                                                               //              (terminated)
		.av_clken              (),                                                                                               //              (terminated)
		.uav_clken             (1'b0),                                                                                           //              (terminated)
		.av_debugaccess        (),                                                                                               //              (terminated)
		.av_outputenable       ()                                                                                                //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (2),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) rx_eth_crc_pad_rem_csr_translator (
		.clk                   (rx_clk_clk),                                                                        //                      clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                                //                    reset.reset
		.uav_address           (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (rx_eth_crc_pad_rem_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                  //              (terminated)
		.av_beginbursttransfer (),                                                                                  //              (terminated)
		.av_burstcount         (),                                                                                  //              (terminated)
		.av_byteenable         (),                                                                                  //              (terminated)
		.av_readdatavalid      (1'b0),                                                                              //              (terminated)
		.av_waitrequest        (1'b0),                                                                              //              (terminated)
		.av_writebyteenable    (),                                                                                  //              (terminated)
		.av_lock               (),                                                                                  //              (terminated)
		.av_chipselect         (),                                                                                  //              (terminated)
		.av_clken              (),                                                                                  //              (terminated)
		.uav_clken             (1'b0),                                                                              //              (terminated)
		.av_debugaccess        (),                                                                                  //              (terminated)
		.av_outputenable       ()                                                                                   //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (1),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) rx_eth_crc_checker_csr_translator (
		.clk                   (rx_clk_clk),                                                                        //                      clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                                //                    reset.reset
		.uav_address           (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (rx_eth_crc_checker_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                  //              (terminated)
		.av_beginbursttransfer (),                                                                                  //              (terminated)
		.av_burstcount         (),                                                                                  //              (terminated)
		.av_byteenable         (),                                                                                  //              (terminated)
		.av_readdatavalid      (1'b0),                                                                              //              (terminated)
		.av_waitrequest        (1'b0),                                                                              //              (terminated)
		.av_writebyteenable    (),                                                                                  //              (terminated)
		.av_lock               (),                                                                                  //              (terminated)
		.av_chipselect         (),                                                                                  //              (terminated)
		.av_clken              (),                                                                                  //              (terminated)
		.uav_clken             (1'b0),                                                                              //              (terminated)
		.av_debugaccess        (),                                                                                  //              (terminated)
		.av_outputenable       ()                                                                                   //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (5),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) rx_eth_frame_decoder_avalom_mm_csr_translator (
		.clk                   (rx_clk_clk),                                                                                    //                      clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                                            //                    reset.reset
		.uav_address           (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                              //              (terminated)
		.av_beginbursttransfer (),                                                                                              //              (terminated)
		.av_burstcount         (),                                                                                              //              (terminated)
		.av_byteenable         (),                                                                                              //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                          //              (terminated)
		.av_waitrequest        (1'b0),                                                                                          //              (terminated)
		.av_writebyteenable    (),                                                                                              //              (terminated)
		.av_lock               (),                                                                                              //              (terminated)
		.av_chipselect         (),                                                                                              //              (terminated)
		.av_clken              (),                                                                                              //              (terminated)
		.uav_clken             (1'b0),                                                                                          //              (terminated)
		.av_debugaccess        (),                                                                                              //              (terminated)
		.av_outputenable       ()                                                                                               //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (2),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) rx_eth_packet_overflow_control_csr_translator (
		.clk                   (rx_clk_clk),                                                                                    //                      clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                                            //                    reset.reset
		.uav_address           (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (rx_eth_packet_overflow_control_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_read               (rx_eth_packet_overflow_control_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (rx_eth_packet_overflow_control_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_write              (),                                                                                              //              (terminated)
		.av_writedata          (),                                                                                              //              (terminated)
		.av_begintransfer      (),                                                                                              //              (terminated)
		.av_beginbursttransfer (),                                                                                              //              (terminated)
		.av_burstcount         (),                                                                                              //              (terminated)
		.av_byteenable         (),                                                                                              //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                          //              (terminated)
		.av_waitrequest        (1'b0),                                                                                          //              (terminated)
		.av_writebyteenable    (),                                                                                              //              (terminated)
		.av_lock               (),                                                                                              //              (terminated)
		.av_chipselect         (),                                                                                              //              (terminated)
		.av_clken              (),                                                                                              //              (terminated)
		.uav_clken             (1'b0),                                                                                          //              (terminated)
		.av_debugaccess        (),                                                                                              //              (terminated)
		.av_outputenable       ()                                                                                               //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (6),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (2),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) rx_eth_statistics_collector_csr_translator (
		.clk                   (rx_clk_clk),                                                                                 //                      clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                                         //                    reset.reset
		.uav_address           (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (rx_eth_statistics_collector_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                           //              (terminated)
		.av_beginbursttransfer (),                                                                                           //              (terminated)
		.av_burstcount         (),                                                                                           //              (terminated)
		.av_byteenable         (),                                                                                           //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                       //              (terminated)
		.av_waitrequest        (1'b0),                                                                                       //              (terminated)
		.av_writebyteenable    (),                                                                                           //              (terminated)
		.av_lock               (),                                                                                           //              (terminated)
		.av_chipselect         (),                                                                                           //              (terminated)
		.av_clken              (),                                                                                           //              (terminated)
		.uav_clken             (1'b0),                                                                                       //              (terminated)
		.av_debugaccess        (),                                                                                           //              (terminated)
		.av_outputenable       ()                                                                                            //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (1),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) rx_eth_lane_decoder_csr_translator (
		.clk                   (rx_clk_clk),                                                                         //                      clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                                 //                    reset.reset
		.uav_address           (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (rx_eth_lane_decoder_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                   //              (terminated)
		.av_beginbursttransfer (),                                                                                   //              (terminated)
		.av_burstcount         (),                                                                                   //              (terminated)
		.av_byteenable         (),                                                                                   //              (terminated)
		.av_readdatavalid      (1'b0),                                                                               //              (terminated)
		.av_waitrequest        (1'b0),                                                                               //              (terminated)
		.av_writebyteenable    (),                                                                                   //              (terminated)
		.av_lock               (),                                                                                   //              (terminated)
		.av_chipselect         (),                                                                                   //              (terminated)
		.av_clken              (),                                                                                   //              (terminated)
		.uav_clken             (1'b0),                                                                               //              (terminated)
		.av_debugaccess        (),                                                                                   //              (terminated)
		.av_outputenable       ()                                                                                    //              (terminated)
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (67),
		.PKT_PROTECTION_L          (67),
		.PKT_BEGIN_BURST           (62),
		.PKT_BURSTWRAP_H           (61),
		.PKT_BURSTWRAP_L           (59),
		.PKT_BYTE_CNT_H            (58),
		.PKT_BYTE_CNT_L            (56),
		.PKT_ADDR_H                (50),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (51),
		.PKT_TRANS_POSTED          (52),
		.PKT_TRANS_WRITE           (53),
		.PKT_TRANS_READ            (54),
		.PKT_TRANS_LOCK            (55),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (63),
		.PKT_DEST_ID_H             (66),
		.PKT_DEST_ID_L             (65),
		.ST_DATA_W                 (68),
		.ST_CHANNEL_W              (2),
		.AV_BURSTCOUNT_W           (3),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (1),
		.BURSTWRAP_VALUE           (7)
	) merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent (
		.clk              (csr_clk_clk),                                                                                                    //       clk.clk
		.reset            (rst_controller_reset_out_reset),                                                                                 // clk_reset.reset
		.av_address       (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_rsp_src_valid),                                                                                          //        rp.valid
		.rp_data          (limiter_rsp_src_data),                                                                                           //          .data
		.rp_channel       (limiter_rsp_src_channel),                                                                                        //          .channel
		.rp_startofpacket (limiter_rsp_src_startofpacket),                                                                                  //          .startofpacket
		.rp_endofpacket   (limiter_rsp_src_endofpacket),                                                                                    //          .endofpacket
		.rp_ready         (limiter_rsp_src_ready)                                                                                           //          .ready
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (62),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (50),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (51),
		.PKT_TRANS_POSTED          (52),
		.PKT_TRANS_WRITE           (53),
		.PKT_TRANS_READ            (54),
		.PKT_TRANS_LOCK            (55),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (63),
		.PKT_DEST_ID_H             (66),
		.PKT_DEST_ID_L             (65),
		.PKT_BURSTWRAP_H           (61),
		.PKT_BURSTWRAP_L           (59),
		.PKT_BYTE_CNT_H            (58),
		.PKT_BYTE_CNT_L            (56),
		.PKT_PROTECTION_H          (67),
		.PKT_PROTECTION_L          (67),
		.ST_CHANNEL_W              (2),
		.ST_DATA_W                 (68),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) tx_bridge_s0_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                        //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                //       clk_reset.reset
		.m0_address              (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (tx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (crosser_out_ready),                                                                 //              cp.ready
		.cp_valid                (crosser_out_valid),                                                                 //                .valid
		.cp_data                 (crosser_out_data),                                                                  //                .data
		.cp_startofpacket        (crosser_out_startofpacket),                                                         //                .startofpacket
		.cp_endofpacket          (crosser_out_endofpacket),                                                           //                .endofpacket
		.cp_channel              (crosser_out_channel),                                                               //                .channel
		.rf_sink_ready           (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid),       //                .valid
		.rdata_fifo_sink_data    (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),        //                .data
		.rdata_fifo_src_ready    (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (69),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                        //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                // clk_reset.reset
		.in_data           (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                             // (terminated)
		.csr_read          (1'b0),                                                                              // (terminated)
		.csr_write         (1'b0),                                                                              // (terminated)
		.csr_readdata      (),                                                                                  // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                              // (terminated)
		.almost_full_data  (),                                                                                  // (terminated)
		.almost_empty_data (),                                                                                  // (terminated)
		.in_empty          (1'b0),                                                                              // (terminated)
		.out_empty         (),                                                                                  // (terminated)
		.in_error          (1'b0),                                                                              // (terminated)
		.out_error         (),                                                                                  // (terminated)
		.in_channel        (1'b0),                                                                              // (terminated)
		.out_channel       ()                                                                                   // (terminated)
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (32),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (0),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (0),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo (
		.clk               (tx_clk_clk),                                                                  //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                          // clk_reset.reset
		.in_data           (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),  //        in.data
		.in_valid          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid), //          .valid
		.in_ready          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready), //          .ready
		.out_data          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),  //       out.data
		.out_valid         (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid), //          .valid
		.out_ready         (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready), //          .ready
		.csr_address       (2'b00),                                                                       // (terminated)
		.csr_read          (1'b0),                                                                        // (terminated)
		.csr_write         (1'b0),                                                                        // (terminated)
		.csr_readdata      (),                                                                            // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                        // (terminated)
		.almost_full_data  (),                                                                            // (terminated)
		.almost_empty_data (),                                                                            // (terminated)
		.in_startofpacket  (1'b0),                                                                        // (terminated)
		.in_endofpacket    (1'b0),                                                                        // (terminated)
		.out_startofpacket (),                                                                            // (terminated)
		.out_endofpacket   (),                                                                            // (terminated)
		.in_empty          (1'b0),                                                                        // (terminated)
		.out_empty         (),                                                                            // (terminated)
		.in_error          (1'b0),                                                                        // (terminated)
		.out_error         (),                                                                            // (terminated)
		.in_channel        (1'b0),                                                                        // (terminated)
		.out_channel       ()                                                                             // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (62),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (50),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (51),
		.PKT_TRANS_POSTED          (52),
		.PKT_TRANS_WRITE           (53),
		.PKT_TRANS_READ            (54),
		.PKT_TRANS_LOCK            (55),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (63),
		.PKT_DEST_ID_H             (66),
		.PKT_DEST_ID_L             (65),
		.PKT_BURSTWRAP_H           (61),
		.PKT_BURSTWRAP_L           (59),
		.PKT_BYTE_CNT_H            (58),
		.PKT_BYTE_CNT_L            (56),
		.PKT_PROTECTION_H          (67),
		.PKT_PROTECTION_L          (67),
		.ST_CHANNEL_W              (2),
		.ST_DATA_W                 (68),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) rx_bridge_s0_translator_avalon_universal_slave_0_agent (
		.clk                     (rx_clk_clk),                                                                        //             clk.clk
		.reset                   (rst_controller_002_reset_out_reset),                                                //       clk_reset.reset
		.m0_address              (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (rx_bridge_s0_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (crosser_001_out_ready),                                                             //              cp.ready
		.cp_valid                (crosser_001_out_valid),                                                             //                .valid
		.cp_data                 (crosser_001_out_data),                                                              //                .data
		.cp_startofpacket        (crosser_001_out_startofpacket),                                                     //                .startofpacket
		.cp_endofpacket          (crosser_001_out_endofpacket),                                                       //                .endofpacket
		.cp_channel              (crosser_001_out_channel),                                                           //                .channel
		.rf_sink_ready           (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid),       //                .valid
		.rdata_fifo_sink_data    (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),        //                .data
		.rdata_fifo_src_ready    (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (69),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (rx_clk_clk),                                                                        //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                                // clk_reset.reset
		.in_data           (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                             // (terminated)
		.csr_read          (1'b0),                                                                              // (terminated)
		.csr_write         (1'b0),                                                                              // (terminated)
		.csr_readdata      (),                                                                                  // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                              // (terminated)
		.almost_full_data  (),                                                                                  // (terminated)
		.almost_empty_data (),                                                                                  // (terminated)
		.in_empty          (1'b0),                                                                              // (terminated)
		.out_empty         (),                                                                                  // (terminated)
		.in_error          (1'b0),                                                                              // (terminated)
		.out_error         (),                                                                                  // (terminated)
		.in_channel        (1'b0),                                                                              // (terminated)
		.out_channel       ()                                                                                   // (terminated)
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (32),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (0),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (0),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo (
		.clk               (rx_clk_clk),                                                                  //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                          // clk_reset.reset
		.in_data           (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),  //        in.data
		.in_valid          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid), //          .valid
		.in_ready          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready), //          .ready
		.out_data          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),  //       out.data
		.out_valid         (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid), //          .valid
		.out_ready         (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready), //          .ready
		.csr_address       (2'b00),                                                                       // (terminated)
		.csr_read          (1'b0),                                                                        // (terminated)
		.csr_write         (1'b0),                                                                        // (terminated)
		.csr_readdata      (),                                                                            // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                        // (terminated)
		.almost_full_data  (),                                                                            // (terminated)
		.almost_empty_data (),                                                                            // (terminated)
		.in_startofpacket  (1'b0),                                                                        // (terminated)
		.in_endofpacket    (1'b0),                                                                        // (terminated)
		.out_startofpacket (),                                                                            // (terminated)
		.out_endofpacket   (),                                                                            // (terminated)
		.in_empty          (1'b0),                                                                        // (terminated)
		.out_empty         (),                                                                            // (terminated)
		.in_error          (1'b0),                                                                        // (terminated)
		.out_error         (),                                                                            // (terminated)
		.in_channel        (1'b0),                                                                        // (terminated)
		.out_channel       ()                                                                             // (terminated)
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (70),
		.PKT_PROTECTION_L          (70),
		.PKT_BEGIN_BURST           (61),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (65),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (69),
		.PKT_DEST_ID_L             (66),
		.ST_DATA_W                 (71),
		.ST_CHANNEL_W              (8),
		.AV_BURSTCOUNT_W           (3),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (1),
		.BURSTWRAP_VALUE           (7)
	) tx_bridge_m0_translator_avalon_universal_master_0_agent (
		.clk              (tx_clk_clk),                                                               //       clk.clk
		.reset            (rst_controller_001_reset_out_reset),                                       // clk_reset.reset
		.av_address       (tx_bridge_m0_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (tx_bridge_m0_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (tx_bridge_m0_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (tx_bridge_m0_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (tx_bridge_m0_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (tx_bridge_m0_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (tx_bridge_m0_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (tx_bridge_m0_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (tx_bridge_m0_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (tx_bridge_m0_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (tx_bridge_m0_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_001_rsp_src_valid),                                                //        rp.valid
		.rp_data          (limiter_001_rsp_src_data),                                                 //          .data
		.rp_channel       (limiter_001_rsp_src_channel),                                              //          .channel
		.rp_startofpacket (limiter_001_rsp_src_startofpacket),                                        //          .startofpacket
		.rp_endofpacket   (limiter_001_rsp_src_endofpacket),                                          //          .endofpacket
		.rp_ready         (limiter_001_rsp_src_ready)                                                 //          .ready
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (65),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (69),
		.PKT_DEST_ID_L             (66),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (70),
		.PKT_PROTECTION_L          (70),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (71),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                                               //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                                       //       clk_reset.reset
		.m0_address              (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src0_ready),                                                                            //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src0_valid),                                                                            //                .valid
		.cp_data                 (cmd_xbar_demux_001_src0_data),                                                                             //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src0_startofpacket),                                                                    //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src0_endofpacket),                                                                      //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src0_channel),                                                                          //                .channel
		.rf_sink_ready           (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (72),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                                               //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                                       // clk_reset.reset
		.in_data           (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                                    // (terminated)
		.csr_read          (1'b0),                                                                                                     // (terminated)
		.csr_write         (1'b0),                                                                                                     // (terminated)
		.csr_readdata      (),                                                                                                         // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                                     // (terminated)
		.almost_full_data  (),                                                                                                         // (terminated)
		.almost_empty_data (),                                                                                                         // (terminated)
		.in_empty          (1'b0),                                                                                                     // (terminated)
		.out_empty         (),                                                                                                         // (terminated)
		.in_error          (1'b0),                                                                                                     // (terminated)
		.out_error         (),                                                                                                         // (terminated)
		.in_channel        (1'b0),                                                                                                     // (terminated)
		.out_channel       ()                                                                                                          // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (65),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (69),
		.PKT_DEST_ID_L             (66),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (70),
		.PKT_PROTECTION_L          (70),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (71),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                                   //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                           //       clk_reset.reset
		.m0_address              (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src1_ready),                                                                //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src1_valid),                                                                //                .valid
		.cp_data                 (cmd_xbar_demux_001_src1_data),                                                                 //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src1_startofpacket),                                                        //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src1_endofpacket),                                                          //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src1_channel),                                                              //                .channel
		.rf_sink_ready           (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (72),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                                   //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                           // clk_reset.reset
		.in_data           (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                        // (terminated)
		.csr_read          (1'b0),                                                                                         // (terminated)
		.csr_write         (1'b0),                                                                                         // (terminated)
		.csr_readdata      (),                                                                                             // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                         // (terminated)
		.almost_full_data  (),                                                                                             // (terminated)
		.almost_empty_data (),                                                                                             // (terminated)
		.in_empty          (1'b0),                                                                                         // (terminated)
		.out_empty         (),                                                                                             // (terminated)
		.in_error          (1'b0),                                                                                         // (terminated)
		.out_error         (),                                                                                             // (terminated)
		.in_channel        (1'b0),                                                                                         // (terminated)
		.out_channel       ()                                                                                              // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (65),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (69),
		.PKT_DEST_ID_L             (66),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (70),
		.PKT_PROTECTION_L          (70),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (71),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                                   //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                           //       clk_reset.reset
		.m0_address              (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src2_ready),                                                                //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src2_valid),                                                                //                .valid
		.cp_data                 (cmd_xbar_demux_001_src2_data),                                                                 //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src2_startofpacket),                                                        //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src2_endofpacket),                                                          //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src2_channel),                                                              //                .channel
		.rf_sink_ready           (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (72),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                                   //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                           // clk_reset.reset
		.in_data           (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                        // (terminated)
		.csr_read          (1'b0),                                                                                         // (terminated)
		.csr_write         (1'b0),                                                                                         // (terminated)
		.csr_readdata      (),                                                                                             // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                         // (terminated)
		.almost_full_data  (),                                                                                             // (terminated)
		.almost_empty_data (),                                                                                             // (terminated)
		.in_empty          (1'b0),                                                                                         // (terminated)
		.out_empty         (),                                                                                             // (terminated)
		.in_error          (1'b0),                                                                                         // (terminated)
		.out_error         (),                                                                                             // (terminated)
		.in_channel        (1'b0),                                                                                         // (terminated)
		.out_channel       ()                                                                                              // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (65),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (69),
		.PKT_DEST_ID_L             (66),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (70),
		.PKT_PROTECTION_L          (70),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (71),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                                     //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                             //       clk_reset.reset
		.m0_address              (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src3_ready),                                                                  //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src3_valid),                                                                  //                .valid
		.cp_data                 (cmd_xbar_demux_001_src3_data),                                                                   //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src3_startofpacket),                                                          //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src3_endofpacket),                                                            //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src3_channel),                                                                //                .channel
		.rf_sink_ready           (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (72),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                                     //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                             // clk_reset.reset
		.in_data           (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                          // (terminated)
		.csr_read          (1'b0),                                                                                           // (terminated)
		.csr_write         (1'b0),                                                                                           // (terminated)
		.csr_readdata      (),                                                                                               // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                           // (terminated)
		.almost_full_data  (),                                                                                               // (terminated)
		.almost_empty_data (),                                                                                               // (terminated)
		.in_empty          (1'b0),                                                                                           // (terminated)
		.out_empty         (),                                                                                               // (terminated)
		.in_error          (1'b0),                                                                                           // (terminated)
		.out_error         (),                                                                                               // (terminated)
		.in_channel        (1'b0),                                                                                           // (terminated)
		.out_channel       ()                                                                                                // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (65),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (69),
		.PKT_DEST_ID_L             (66),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (70),
		.PKT_PROTECTION_L          (70),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (71),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                                       //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                               //       clk_reset.reset
		.m0_address              (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src4_ready),                                                                    //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src4_valid),                                                                    //                .valid
		.cp_data                 (cmd_xbar_demux_001_src4_data),                                                                     //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src4_startofpacket),                                                            //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src4_endofpacket),                                                              //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src4_channel),                                                                  //                .channel
		.rf_sink_ready           (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (72),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                                       //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                               // clk_reset.reset
		.in_data           (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                            // (terminated)
		.csr_read          (1'b0),                                                                                             // (terminated)
		.csr_write         (1'b0),                                                                                             // (terminated)
		.csr_readdata      (),                                                                                                 // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                             // (terminated)
		.almost_full_data  (),                                                                                                 // (terminated)
		.almost_empty_data (),                                                                                                 // (terminated)
		.in_empty          (1'b0),                                                                                             // (terminated)
		.out_empty         (),                                                                                                 // (terminated)
		.in_error          (1'b0),                                                                                             // (terminated)
		.out_error         (),                                                                                                 // (terminated)
		.in_channel        (1'b0),                                                                                             // (terminated)
		.out_channel       ()                                                                                                  // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (65),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (69),
		.PKT_DEST_ID_L             (66),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (70),
		.PKT_PROTECTION_L          (70),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (71),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                                                          //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                                                  //       clk_reset.reset
		.m0_address              (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src5_ready),                                                                                       //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src5_valid),                                                                                       //                .valid
		.cp_data                 (cmd_xbar_demux_001_src5_data),                                                                                        //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src5_startofpacket),                                                                               //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src5_endofpacket),                                                                                 //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src5_channel),                                                                                     //                .channel
		.rf_sink_ready           (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (72),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                                                          //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                                                  // clk_reset.reset
		.in_data           (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                                               // (terminated)
		.csr_read          (1'b0),                                                                                                                // (terminated)
		.csr_write         (1'b0),                                                                                                                // (terminated)
		.csr_readdata      (),                                                                                                                    // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                                                // (terminated)
		.almost_full_data  (),                                                                                                                    // (terminated)
		.almost_empty_data (),                                                                                                                    // (terminated)
		.in_empty          (1'b0),                                                                                                                // (terminated)
		.out_empty         (),                                                                                                                    // (terminated)
		.in_error          (1'b0),                                                                                                                // (terminated)
		.out_error         (),                                                                                                                    // (terminated)
		.in_channel        (1'b0),                                                                                                                // (terminated)
		.out_channel       ()                                                                                                                     // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (65),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (69),
		.PKT_DEST_ID_L             (66),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (70),
		.PKT_PROTECTION_L          (70),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (71),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                                              //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                                      //       clk_reset.reset
		.m0_address              (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src6_ready),                                                                           //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src6_valid),                                                                           //                .valid
		.cp_data                 (cmd_xbar_demux_001_src6_data),                                                                            //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src6_startofpacket),                                                                   //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src6_endofpacket),                                                                     //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src6_channel),                                                                         //                .channel
		.rf_sink_ready           (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (72),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                                              //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                                      // clk_reset.reset
		.in_data           (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                                   // (terminated)
		.csr_read          (1'b0),                                                                                                    // (terminated)
		.csr_write         (1'b0),                                                                                                    // (terminated)
		.csr_readdata      (),                                                                                                        // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                                    // (terminated)
		.almost_full_data  (),                                                                                                        // (terminated)
		.almost_empty_data (),                                                                                                        // (terminated)
		.in_empty          (1'b0),                                                                                                    // (terminated)
		.out_empty         (),                                                                                                        // (terminated)
		.in_error          (1'b0),                                                                                                    // (terminated)
		.out_error         (),                                                                                                        // (terminated)
		.in_channel        (1'b0),                                                                                                    // (terminated)
		.out_channel       ()                                                                                                         // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (65),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (69),
		.PKT_DEST_ID_L             (66),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (70),
		.PKT_PROTECTION_L          (70),
		.ST_CHANNEL_W              (8),
		.ST_DATA_W                 (71),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                                           //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                                   //       clk_reset.reset
		.m0_address              (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_001_src7_ready),                                                                        //              cp.ready
		.cp_valid                (cmd_xbar_demux_001_src7_valid),                                                                        //                .valid
		.cp_data                 (cmd_xbar_demux_001_src7_data),                                                                         //                .data
		.cp_startofpacket        (cmd_xbar_demux_001_src7_startofpacket),                                                                //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_001_src7_endofpacket),                                                                  //                .endofpacket
		.cp_channel              (cmd_xbar_demux_001_src7_channel),                                                                      //                .channel
		.rf_sink_ready           (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (72),
		.FIFO_DEPTH          (3),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                                           //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                                   // clk_reset.reset
		.in_data           (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                                // (terminated)
		.csr_read          (1'b0),                                                                                                 // (terminated)
		.csr_write         (1'b0),                                                                                                 // (terminated)
		.csr_readdata      (),                                                                                                     // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                                 // (terminated)
		.almost_full_data  (),                                                                                                     // (terminated)
		.almost_empty_data (),                                                                                                     // (terminated)
		.in_empty          (1'b0),                                                                                                 // (terminated)
		.out_empty         (),                                                                                                     // (terminated)
		.in_error          (1'b0),                                                                                                 // (terminated)
		.out_error         (),                                                                                                     // (terminated)
		.in_channel        (1'b0),                                                                                                 // (terminated)
		.out_channel       ()                                                                                                      // (terminated)
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (68),
		.PKT_PROTECTION_L          (68),
		.PKT_BEGIN_BURST           (61),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (67),
		.PKT_DEST_ID_L             (65),
		.ST_DATA_W                 (69),
		.ST_CHANNEL_W              (7),
		.AV_BURSTCOUNT_W           (3),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (1),
		.BURSTWRAP_VALUE           (7)
	) rx_bridge_m0_translator_avalon_universal_master_0_agent (
		.clk              (rx_clk_clk),                                                               //       clk.clk
		.reset            (rst_controller_002_reset_out_reset),                                       // clk_reset.reset
		.av_address       (rx_bridge_m0_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (rx_bridge_m0_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (rx_bridge_m0_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (rx_bridge_m0_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (rx_bridge_m0_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (rx_bridge_m0_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (rx_bridge_m0_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (rx_bridge_m0_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (rx_bridge_m0_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (rx_bridge_m0_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (rx_bridge_m0_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_002_rsp_src_valid),                                                //        rp.valid
		.rp_data          (limiter_002_rsp_src_data),                                                 //          .data
		.rp_channel       (limiter_002_rsp_src_channel),                                              //          .channel
		.rp_startofpacket (limiter_002_rsp_src_startofpacket),                                        //          .startofpacket
		.rp_endofpacket   (limiter_002_rsp_src_endofpacket),                                          //          .endofpacket
		.rp_ready         (limiter_002_rsp_src_ready)                                                 //          .ready
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (67),
		.PKT_DEST_ID_L             (65),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (68),
		.PKT_PROTECTION_L          (68),
		.ST_CHANNEL_W              (7),
		.ST_DATA_W                 (69),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (rx_clk_clk),                                                                                               //             clk.clk
		.reset                   (rst_controller_002_reset_out_reset),                                                                       //       clk_reset.reset
		.m0_address              (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_002_src0_ready),                                                                            //              cp.ready
		.cp_valid                (cmd_xbar_demux_002_src0_valid),                                                                            //                .valid
		.cp_data                 (cmd_xbar_demux_002_src0_data),                                                                             //                .data
		.cp_startofpacket        (cmd_xbar_demux_002_src0_startofpacket),                                                                    //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_002_src0_endofpacket),                                                                      //                .endofpacket
		.cp_channel              (cmd_xbar_demux_002_src0_channel),                                                                          //                .channel
		.rf_sink_ready           (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (70),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (rx_clk_clk),                                                                                               //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                                                       // clk_reset.reset
		.in_data           (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                                    // (terminated)
		.csr_read          (1'b0),                                                                                                     // (terminated)
		.csr_write         (1'b0),                                                                                                     // (terminated)
		.csr_readdata      (),                                                                                                         // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                                     // (terminated)
		.almost_full_data  (),                                                                                                         // (terminated)
		.almost_empty_data (),                                                                                                         // (terminated)
		.in_empty          (1'b0),                                                                                                     // (terminated)
		.out_empty         (),                                                                                                         // (terminated)
		.in_error          (1'b0),                                                                                                     // (terminated)
		.out_error         (),                                                                                                         // (terminated)
		.in_channel        (1'b0),                                                                                                     // (terminated)
		.out_channel       ()                                                                                                          // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (67),
		.PKT_DEST_ID_L             (65),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (68),
		.PKT_PROTECTION_L          (68),
		.ST_CHANNEL_W              (7),
		.ST_DATA_W                 (69),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (rx_clk_clk),                                                                                  //             clk.clk
		.reset                   (rst_controller_002_reset_out_reset),                                                          //       clk_reset.reset
		.m0_address              (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_002_src1_ready),                                                               //              cp.ready
		.cp_valid                (cmd_xbar_demux_002_src1_valid),                                                               //                .valid
		.cp_data                 (cmd_xbar_demux_002_src1_data),                                                                //                .data
		.cp_startofpacket        (cmd_xbar_demux_002_src1_startofpacket),                                                       //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_002_src1_endofpacket),                                                         //                .endofpacket
		.cp_channel              (cmd_xbar_demux_002_src1_channel),                                                             //                .channel
		.rf_sink_ready           (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (70),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (rx_clk_clk),                                                                                  //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                                          // clk_reset.reset
		.in_data           (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                       // (terminated)
		.csr_read          (1'b0),                                                                                        // (terminated)
		.csr_write         (1'b0),                                                                                        // (terminated)
		.csr_readdata      (),                                                                                            // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                        // (terminated)
		.almost_full_data  (),                                                                                            // (terminated)
		.almost_empty_data (),                                                                                            // (terminated)
		.in_empty          (1'b0),                                                                                        // (terminated)
		.out_empty         (),                                                                                            // (terminated)
		.in_error          (1'b0),                                                                                        // (terminated)
		.out_error         (),                                                                                            // (terminated)
		.in_channel        (1'b0),                                                                                        // (terminated)
		.out_channel       ()                                                                                             // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (67),
		.PKT_DEST_ID_L             (65),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (68),
		.PKT_PROTECTION_L          (68),
		.ST_CHANNEL_W              (7),
		.ST_DATA_W                 (69),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (rx_clk_clk),                                                                                  //             clk.clk
		.reset                   (rst_controller_002_reset_out_reset),                                                          //       clk_reset.reset
		.m0_address              (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_002_src2_ready),                                                               //              cp.ready
		.cp_valid                (cmd_xbar_demux_002_src2_valid),                                                               //                .valid
		.cp_data                 (cmd_xbar_demux_002_src2_data),                                                                //                .data
		.cp_startofpacket        (cmd_xbar_demux_002_src2_startofpacket),                                                       //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_002_src2_endofpacket),                                                         //                .endofpacket
		.cp_channel              (cmd_xbar_demux_002_src2_channel),                                                             //                .channel
		.rf_sink_ready           (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (70),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (rx_clk_clk),                                                                                  //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                                          // clk_reset.reset
		.in_data           (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                       // (terminated)
		.csr_read          (1'b0),                                                                                        // (terminated)
		.csr_write         (1'b0),                                                                                        // (terminated)
		.csr_readdata      (),                                                                                            // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                        // (terminated)
		.almost_full_data  (),                                                                                            // (terminated)
		.almost_empty_data (),                                                                                            // (terminated)
		.in_empty          (1'b0),                                                                                        // (terminated)
		.out_empty         (),                                                                                            // (terminated)
		.in_error          (1'b0),                                                                                        // (terminated)
		.out_error         (),                                                                                            // (terminated)
		.in_channel        (1'b0),                                                                                        // (terminated)
		.out_channel       ()                                                                                             // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (67),
		.PKT_DEST_ID_L             (65),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (68),
		.PKT_PROTECTION_L          (68),
		.ST_CHANNEL_W              (7),
		.ST_DATA_W                 (69),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (rx_clk_clk),                                                                                              //             clk.clk
		.reset                   (rst_controller_002_reset_out_reset),                                                                      //       clk_reset.reset
		.m0_address              (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_002_src3_ready),                                                                           //              cp.ready
		.cp_valid                (cmd_xbar_demux_002_src3_valid),                                                                           //                .valid
		.cp_data                 (cmd_xbar_demux_002_src3_data),                                                                            //                .data
		.cp_startofpacket        (cmd_xbar_demux_002_src3_startofpacket),                                                                   //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_002_src3_endofpacket),                                                                     //                .endofpacket
		.cp_channel              (cmd_xbar_demux_002_src3_channel),                                                                         //                .channel
		.rf_sink_ready           (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (70),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (rx_clk_clk),                                                                                              //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                                                      // clk_reset.reset
		.in_data           (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                                   // (terminated)
		.csr_read          (1'b0),                                                                                                    // (terminated)
		.csr_write         (1'b0),                                                                                                    // (terminated)
		.csr_readdata      (),                                                                                                        // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                                    // (terminated)
		.almost_full_data  (),                                                                                                        // (terminated)
		.almost_empty_data (),                                                                                                        // (terminated)
		.in_empty          (1'b0),                                                                                                    // (terminated)
		.out_empty         (),                                                                                                        // (terminated)
		.in_error          (1'b0),                                                                                                    // (terminated)
		.out_error         (),                                                                                                        // (terminated)
		.in_channel        (1'b0),                                                                                                    // (terminated)
		.out_channel       ()                                                                                                         // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (67),
		.PKT_DEST_ID_L             (65),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (68),
		.PKT_PROTECTION_L          (68),
		.ST_CHANNEL_W              (7),
		.ST_DATA_W                 (69),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (rx_clk_clk),                                                                                              //             clk.clk
		.reset                   (rst_controller_002_reset_out_reset),                                                                      //       clk_reset.reset
		.m0_address              (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_002_src4_ready),                                                                           //              cp.ready
		.cp_valid                (cmd_xbar_demux_002_src4_valid),                                                                           //                .valid
		.cp_data                 (cmd_xbar_demux_002_src4_data),                                                                            //                .data
		.cp_startofpacket        (cmd_xbar_demux_002_src4_startofpacket),                                                                   //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_002_src4_endofpacket),                                                                     //                .endofpacket
		.cp_channel              (cmd_xbar_demux_002_src4_channel),                                                                         //                .channel
		.rf_sink_ready           (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (70),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (rx_clk_clk),                                                                                              //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                                                      // clk_reset.reset
		.in_data           (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                                   // (terminated)
		.csr_read          (1'b0),                                                                                                    // (terminated)
		.csr_write         (1'b0),                                                                                                    // (terminated)
		.csr_readdata      (),                                                                                                        // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                                    // (terminated)
		.almost_full_data  (),                                                                                                        // (terminated)
		.almost_empty_data (),                                                                                                        // (terminated)
		.in_empty          (1'b0),                                                                                                    // (terminated)
		.out_empty         (),                                                                                                        // (terminated)
		.in_error          (1'b0),                                                                                                    // (terminated)
		.out_error         (),                                                                                                        // (terminated)
		.in_channel        (1'b0),                                                                                                    // (terminated)
		.out_channel       ()                                                                                                         // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (67),
		.PKT_DEST_ID_L             (65),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (68),
		.PKT_PROTECTION_L          (68),
		.ST_CHANNEL_W              (7),
		.ST_DATA_W                 (69),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (rx_clk_clk),                                                                                           //             clk.clk
		.reset                   (rst_controller_002_reset_out_reset),                                                                   //       clk_reset.reset
		.m0_address              (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_002_src5_ready),                                                                        //              cp.ready
		.cp_valid                (cmd_xbar_demux_002_src5_valid),                                                                        //                .valid
		.cp_data                 (cmd_xbar_demux_002_src5_data),                                                                         //                .data
		.cp_startofpacket        (cmd_xbar_demux_002_src5_startofpacket),                                                                //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_002_src5_endofpacket),                                                                  //                .endofpacket
		.cp_channel              (cmd_xbar_demux_002_src5_channel),                                                                      //                .channel
		.rf_sink_ready           (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (70),
		.FIFO_DEPTH          (3),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (rx_clk_clk),                                                                                           //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                                                   // clk_reset.reset
		.in_data           (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                                // (terminated)
		.csr_read          (1'b0),                                                                                                 // (terminated)
		.csr_write         (1'b0),                                                                                                 // (terminated)
		.csr_readdata      (),                                                                                                     // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                                 // (terminated)
		.almost_full_data  (),                                                                                                     // (terminated)
		.almost_empty_data (),                                                                                                     // (terminated)
		.in_empty          (1'b0),                                                                                                 // (terminated)
		.out_empty         (),                                                                                                     // (terminated)
		.in_error          (1'b0),                                                                                                 // (terminated)
		.out_error         (),                                                                                                     // (terminated)
		.in_channel        (1'b0),                                                                                                 // (terminated)
		.out_channel       ()                                                                                                      // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (61),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (49),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (50),
		.PKT_TRANS_POSTED          (51),
		.PKT_TRANS_WRITE           (52),
		.PKT_TRANS_READ            (53),
		.PKT_TRANS_LOCK            (54),
		.PKT_SRC_ID_H              (64),
		.PKT_SRC_ID_L              (62),
		.PKT_DEST_ID_H             (67),
		.PKT_DEST_ID_L             (65),
		.PKT_BURSTWRAP_H           (60),
		.PKT_BURSTWRAP_L           (58),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_PROTECTION_H          (68),
		.PKT_PROTECTION_L          (68),
		.ST_CHANNEL_W              (7),
		.ST_DATA_W                 (69),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (rx_clk_clk),                                                                                   //             clk.clk
		.reset                   (rst_controller_002_reset_out_reset),                                                           //       clk_reset.reset
		.m0_address              (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_002_src6_ready),                                                                //              cp.ready
		.cp_valid                (cmd_xbar_demux_002_src6_valid),                                                                //                .valid
		.cp_data                 (cmd_xbar_demux_002_src6_data),                                                                 //                .data
		.cp_startofpacket        (cmd_xbar_demux_002_src6_startofpacket),                                                        //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_002_src6_endofpacket),                                                          //                .endofpacket
		.cp_channel              (cmd_xbar_demux_002_src6_channel),                                                              //                .channel
		.rf_sink_ready           (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (70),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (rx_clk_clk),                                                                                   //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                                           // clk_reset.reset
		.in_data           (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                        // (terminated)
		.csr_read          (1'b0),                                                                                         // (terminated)
		.csr_write         (1'b0),                                                                                         // (terminated)
		.csr_readdata      (),                                                                                             // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                         // (terminated)
		.almost_full_data  (),                                                                                             // (terminated)
		.almost_empty_data (),                                                                                             // (terminated)
		.in_empty          (1'b0),                                                                                         // (terminated)
		.out_empty         (),                                                                                             // (terminated)
		.in_error          (1'b0),                                                                                         // (terminated)
		.out_error         (),                                                                                             // (terminated)
		.in_channel        (1'b0),                                                                                         // (terminated)
		.out_channel       ()                                                                                              // (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_addr_router addr_router (
		.sink_ready         (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (merlin_master_translator_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (csr_clk_clk),                                                                                                    //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                                                 // clk_reset.reset
		.src_ready          (addr_router_src_ready),                                                                                          //       src.ready
		.src_valid          (addr_router_src_valid),                                                                                          //          .valid
		.src_data           (addr_router_src_data),                                                                                           //          .data
		.src_channel        (addr_router_src_channel),                                                                                        //          .channel
		.src_startofpacket  (addr_router_src_startofpacket),                                                                                  //          .startofpacket
		.src_endofpacket    (addr_router_src_endofpacket)                                                                                     //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router id_router (
		.sink_ready         (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                              //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                      // clk_reset.reset
		.src_ready          (id_router_src_ready),                                                     //       src.ready
		.src_valid          (id_router_src_valid),                                                     //          .valid
		.src_data           (id_router_src_data),                                                      //          .data
		.src_channel        (id_router_src_channel),                                                   //          .channel
		.src_startofpacket  (id_router_src_startofpacket),                                             //          .startofpacket
		.src_endofpacket    (id_router_src_endofpacket)                                                //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router id_router_001 (
		.sink_ready         (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (rx_bridge_s0_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (rx_clk_clk),                                                              //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                      // clk_reset.reset
		.src_ready          (id_router_001_src_ready),                                                 //       src.ready
		.src_valid          (id_router_001_src_valid),                                                 //          .valid
		.src_data           (id_router_001_src_data),                                                  //          .data
		.src_channel        (id_router_001_src_channel),                                               //          .channel
		.src_startofpacket  (id_router_001_src_startofpacket),                                         //          .startofpacket
		.src_endofpacket    (id_router_001_src_endofpacket)                                            //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_addr_router_001 addr_router_001 (
		.sink_ready         (tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_bridge_m0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                               //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                       // clk_reset.reset
		.src_ready          (addr_router_001_src_ready),                                                //       src.ready
		.src_valid          (addr_router_001_src_valid),                                                //          .valid
		.src_data           (addr_router_001_src_data),                                                 //          .data
		.src_channel        (addr_router_001_src_channel),                                              //          .channel
		.src_startofpacket  (addr_router_001_src_startofpacket),                                        //          .startofpacket
		.src_endofpacket    (addr_router_001_src_endofpacket)                                           //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_002 id_router_002 (
		.sink_ready         (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                                                     //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                                             // clk_reset.reset
		.src_ready          (id_router_002_src_ready),                                                                        //       src.ready
		.src_valid          (id_router_002_src_valid),                                                                        //          .valid
		.src_data           (id_router_002_src_data),                                                                         //          .data
		.src_channel        (id_router_002_src_channel),                                                                      //          .channel
		.src_startofpacket  (id_router_002_src_startofpacket),                                                                //          .startofpacket
		.src_endofpacket    (id_router_002_src_endofpacket)                                                                   //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_002 id_router_003 (
		.sink_ready         (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_eth_pad_inserter_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                                         //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                                 // clk_reset.reset
		.src_ready          (id_router_003_src_ready),                                                            //       src.ready
		.src_valid          (id_router_003_src_valid),                                                            //          .valid
		.src_data           (id_router_003_src_data),                                                             //          .data
		.src_channel        (id_router_003_src_channel),                                                          //          .channel
		.src_startofpacket  (id_router_003_src_startofpacket),                                                    //          .startofpacket
		.src_endofpacket    (id_router_003_src_endofpacket)                                                       //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_002 id_router_004 (
		.sink_ready         (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_eth_crc_inserter_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                                         //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                                 // clk_reset.reset
		.src_ready          (id_router_004_src_ready),                                                            //       src.ready
		.src_valid          (id_router_004_src_valid),                                                            //          .valid
		.src_data           (id_router_004_src_data),                                                             //          .data
		.src_channel        (id_router_004_src_channel),                                                          //          .channel
		.src_startofpacket  (id_router_004_src_startofpacket),                                                    //          .startofpacket
		.src_endofpacket    (id_router_004_src_endofpacket)                                                       //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_002 id_router_005 (
		.sink_ready         (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_eth_pause_ctrl_gen_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                                           //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                                   // clk_reset.reset
		.src_ready          (id_router_005_src_ready),                                                              //       src.ready
		.src_valid          (id_router_005_src_valid),                                                              //          .valid
		.src_data           (id_router_005_src_data),                                                               //          .data
		.src_channel        (id_router_005_src_channel),                                                            //          .channel
		.src_startofpacket  (id_router_005_src_startofpacket),                                                      //          .startofpacket
		.src_endofpacket    (id_router_005_src_endofpacket)                                                         //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_002 id_router_006 (
		.sink_ready         (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_eth_address_inserter_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                                             //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                                     // clk_reset.reset
		.src_ready          (id_router_006_src_ready),                                                                //       src.ready
		.src_valid          (id_router_006_src_valid),                                                                //          .valid
		.src_data           (id_router_006_src_data),                                                                 //          .data
		.src_channel        (id_router_006_src_channel),                                                              //          .channel
		.src_startofpacket  (id_router_006_src_startofpacket),                                                        //          .startofpacket
		.src_endofpacket    (id_router_006_src_endofpacket)                                                           //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_002 id_router_007 (
		.sink_ready         (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_eth_packet_underflow_control_avalon_slave_0_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                                                                //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                                                        // clk_reset.reset
		.src_ready          (id_router_007_src_ready),                                                                                   //       src.ready
		.src_valid          (id_router_007_src_valid),                                                                                   //          .valid
		.src_data           (id_router_007_src_data),                                                                                    //          .data
		.src_channel        (id_router_007_src_channel),                                                                                 //          .channel
		.src_startofpacket  (id_router_007_src_startofpacket),                                                                           //          .startofpacket
		.src_endofpacket    (id_router_007_src_endofpacket)                                                                              //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_002 id_router_008 (
		.sink_ready         (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                                                    //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                                            // clk_reset.reset
		.src_ready          (id_router_008_src_ready),                                                                       //       src.ready
		.src_valid          (id_router_008_src_valid),                                                                       //          .valid
		.src_data           (id_router_008_src_data),                                                                        //          .data
		.src_channel        (id_router_008_src_channel),                                                                     //          .channel
		.src_startofpacket  (id_router_008_src_startofpacket),                                                               //          .startofpacket
		.src_endofpacket    (id_router_008_src_endofpacket)                                                                  //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_002 id_router_009 (
		.sink_ready         (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                                                 //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                                         // clk_reset.reset
		.src_ready          (id_router_009_src_ready),                                                                    //       src.ready
		.src_valid          (id_router_009_src_valid),                                                                    //          .valid
		.src_data           (id_router_009_src_data),                                                                     //          .data
		.src_channel        (id_router_009_src_channel),                                                                  //          .channel
		.src_startofpacket  (id_router_009_src_startofpacket),                                                            //          .startofpacket
		.src_endofpacket    (id_router_009_src_endofpacket)                                                               //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_addr_router_002 addr_router_002 (
		.sink_ready         (rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (rx_bridge_m0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (rx_clk_clk),                                                               //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                       // clk_reset.reset
		.src_ready          (addr_router_002_src_ready),                                                //       src.ready
		.src_valid          (addr_router_002_src_valid),                                                //          .valid
		.src_data           (addr_router_002_src_data),                                                 //          .data
		.src_channel        (addr_router_002_src_channel),                                              //          .channel
		.src_startofpacket  (addr_router_002_src_startofpacket),                                        //          .startofpacket
		.src_endofpacket    (addr_router_002_src_endofpacket)                                           //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_010 id_router_010 (
		.sink_ready         (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (rx_eth_pkt_backpressure_control_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (rx_clk_clk),                                                                                     //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                                             // clk_reset.reset
		.src_ready          (id_router_010_src_ready),                                                                        //       src.ready
		.src_valid          (id_router_010_src_valid),                                                                        //          .valid
		.src_data           (id_router_010_src_data),                                                                         //          .data
		.src_channel        (id_router_010_src_channel),                                                                      //          .channel
		.src_startofpacket  (id_router_010_src_startofpacket),                                                                //          .startofpacket
		.src_endofpacket    (id_router_010_src_endofpacket)                                                                   //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_010 id_router_011 (
		.sink_ready         (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (rx_eth_crc_pad_rem_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (rx_clk_clk),                                                                        //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                                // clk_reset.reset
		.src_ready          (id_router_011_src_ready),                                                           //       src.ready
		.src_valid          (id_router_011_src_valid),                                                           //          .valid
		.src_data           (id_router_011_src_data),                                                            //          .data
		.src_channel        (id_router_011_src_channel),                                                         //          .channel
		.src_startofpacket  (id_router_011_src_startofpacket),                                                   //          .startofpacket
		.src_endofpacket    (id_router_011_src_endofpacket)                                                      //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_010 id_router_012 (
		.sink_ready         (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (rx_eth_crc_checker_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (rx_clk_clk),                                                                        //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                                // clk_reset.reset
		.src_ready          (id_router_012_src_ready),                                                           //       src.ready
		.src_valid          (id_router_012_src_valid),                                                           //          .valid
		.src_data           (id_router_012_src_data),                                                            //          .data
		.src_channel        (id_router_012_src_channel),                                                         //          .channel
		.src_startofpacket  (id_router_012_src_startofpacket),                                                   //          .startofpacket
		.src_endofpacket    (id_router_012_src_endofpacket)                                                      //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_010 id_router_013 (
		.sink_ready         (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (rx_eth_frame_decoder_avalom_mm_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (rx_clk_clk),                                                                                    //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                                            // clk_reset.reset
		.src_ready          (id_router_013_src_ready),                                                                       //       src.ready
		.src_valid          (id_router_013_src_valid),                                                                       //          .valid
		.src_data           (id_router_013_src_data),                                                                        //          .data
		.src_channel        (id_router_013_src_channel),                                                                     //          .channel
		.src_startofpacket  (id_router_013_src_startofpacket),                                                               //          .startofpacket
		.src_endofpacket    (id_router_013_src_endofpacket)                                                                  //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_010 id_router_014 (
		.sink_ready         (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (rx_eth_packet_overflow_control_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (rx_clk_clk),                                                                                    //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                                            // clk_reset.reset
		.src_ready          (id_router_014_src_ready),                                                                       //       src.ready
		.src_valid          (id_router_014_src_valid),                                                                       //          .valid
		.src_data           (id_router_014_src_data),                                                                        //          .data
		.src_channel        (id_router_014_src_channel),                                                                     //          .channel
		.src_startofpacket  (id_router_014_src_startofpacket),                                                               //          .startofpacket
		.src_endofpacket    (id_router_014_src_endofpacket)                                                                  //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_010 id_router_015 (
		.sink_ready         (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (rx_eth_statistics_collector_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (rx_clk_clk),                                                                                 //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                                         // clk_reset.reset
		.src_ready          (id_router_015_src_ready),                                                                    //       src.ready
		.src_valid          (id_router_015_src_valid),                                                                    //          .valid
		.src_data           (id_router_015_src_data),                                                                     //          .data
		.src_channel        (id_router_015_src_channel),                                                                  //          .channel
		.src_startofpacket  (id_router_015_src_startofpacket),                                                            //          .startofpacket
		.src_endofpacket    (id_router_015_src_endofpacket)                                                               //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_id_router_010 id_router_016 (
		.sink_ready         (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (rx_eth_lane_decoder_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (rx_clk_clk),                                                                         //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                                 // clk_reset.reset
		.src_ready          (id_router_016_src_ready),                                                            //       src.ready
		.src_valid          (id_router_016_src_valid),                                                            //          .valid
		.src_data           (id_router_016_src_data),                                                             //          .data
		.src_channel        (id_router_016_src_channel),                                                          //          .channel
		.src_startofpacket  (id_router_016_src_startofpacket),                                                    //          .startofpacket
		.src_endofpacket    (id_router_016_src_endofpacket)                                                       //          .endofpacket
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (66),
		.PKT_DEST_ID_L             (65),
		.PKT_TRANS_POSTED          (52),
		.MAX_OUTSTANDING_RESPONSES (9),
		.PIPELINED                 (0),
		.ST_DATA_W                 (68),
		.ST_CHANNEL_W              (2),
		.VALID_WIDTH               (2),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (58),
		.PKT_BYTE_CNT_L            (56),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter (
		.clk                    (csr_clk_clk),                    //       clk.clk
		.reset                  (rst_controller_reset_out_reset), // clk_reset.reset
		.cmd_sink_ready         (addr_router_src_ready),          //  cmd_sink.ready
		.cmd_sink_valid         (addr_router_src_valid),          //          .valid
		.cmd_sink_data          (addr_router_src_data),           //          .data
		.cmd_sink_channel       (addr_router_src_channel),        //          .channel
		.cmd_sink_startofpacket (addr_router_src_startofpacket),  //          .startofpacket
		.cmd_sink_endofpacket   (addr_router_src_endofpacket),    //          .endofpacket
		.cmd_src_ready          (limiter_cmd_src_ready),          //   cmd_src.ready
		.cmd_src_data           (limiter_cmd_src_data),           //          .data
		.cmd_src_channel        (limiter_cmd_src_channel),        //          .channel
		.cmd_src_startofpacket  (limiter_cmd_src_startofpacket),  //          .startofpacket
		.cmd_src_endofpacket    (limiter_cmd_src_endofpacket),    //          .endofpacket
		.rsp_sink_ready         (rsp_xbar_mux_src_ready),         //  rsp_sink.ready
		.rsp_sink_valid         (rsp_xbar_mux_src_valid),         //          .valid
		.rsp_sink_channel       (rsp_xbar_mux_src_channel),       //          .channel
		.rsp_sink_data          (rsp_xbar_mux_src_data),          //          .data
		.rsp_sink_startofpacket (rsp_xbar_mux_src_startofpacket), //          .startofpacket
		.rsp_sink_endofpacket   (rsp_xbar_mux_src_endofpacket),   //          .endofpacket
		.rsp_src_ready          (limiter_rsp_src_ready),          //   rsp_src.ready
		.rsp_src_valid          (limiter_rsp_src_valid),          //          .valid
		.rsp_src_data           (limiter_rsp_src_data),           //          .data
		.rsp_src_channel        (limiter_rsp_src_channel),        //          .channel
		.rsp_src_startofpacket  (limiter_rsp_src_startofpacket),  //          .startofpacket
		.rsp_src_endofpacket    (limiter_rsp_src_endofpacket),    //          .endofpacket
		.cmd_src_valid          (limiter_cmd_valid_data)          // cmd_valid.data
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (69),
		.PKT_DEST_ID_L             (66),
		.PKT_TRANS_POSTED          (51),
		.MAX_OUTSTANDING_RESPONSES (6),
		.PIPELINED                 (0),
		.ST_DATA_W                 (71),
		.ST_CHANNEL_W              (8),
		.VALID_WIDTH               (8),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter_001 (
		.clk                    (tx_clk_clk),                         //       clk.clk
		.reset                  (rst_controller_001_reset_out_reset), // clk_reset.reset
		.cmd_sink_ready         (addr_router_001_src_ready),          //  cmd_sink.ready
		.cmd_sink_valid         (addr_router_001_src_valid),          //          .valid
		.cmd_sink_data          (addr_router_001_src_data),           //          .data
		.cmd_sink_channel       (addr_router_001_src_channel),        //          .channel
		.cmd_sink_startofpacket (addr_router_001_src_startofpacket),  //          .startofpacket
		.cmd_sink_endofpacket   (addr_router_001_src_endofpacket),    //          .endofpacket
		.cmd_src_ready          (limiter_001_cmd_src_ready),          //   cmd_src.ready
		.cmd_src_data           (limiter_001_cmd_src_data),           //          .data
		.cmd_src_channel        (limiter_001_cmd_src_channel),        //          .channel
		.cmd_src_startofpacket  (limiter_001_cmd_src_startofpacket),  //          .startofpacket
		.cmd_src_endofpacket    (limiter_001_cmd_src_endofpacket),    //          .endofpacket
		.rsp_sink_ready         (rsp_xbar_mux_001_src_ready),         //  rsp_sink.ready
		.rsp_sink_valid         (rsp_xbar_mux_001_src_valid),         //          .valid
		.rsp_sink_channel       (rsp_xbar_mux_001_src_channel),       //          .channel
		.rsp_sink_data          (rsp_xbar_mux_001_src_data),          //          .data
		.rsp_sink_startofpacket (rsp_xbar_mux_001_src_startofpacket), //          .startofpacket
		.rsp_sink_endofpacket   (rsp_xbar_mux_001_src_endofpacket),   //          .endofpacket
		.rsp_src_ready          (limiter_001_rsp_src_ready),          //   rsp_src.ready
		.rsp_src_valid          (limiter_001_rsp_src_valid),          //          .valid
		.rsp_src_data           (limiter_001_rsp_src_data),           //          .data
		.rsp_src_channel        (limiter_001_rsp_src_channel),        //          .channel
		.rsp_src_startofpacket  (limiter_001_rsp_src_startofpacket),  //          .startofpacket
		.rsp_src_endofpacket    (limiter_001_rsp_src_endofpacket),    //          .endofpacket
		.cmd_src_valid          (limiter_001_cmd_valid_data)          // cmd_valid.data
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (67),
		.PKT_DEST_ID_L             (65),
		.PKT_TRANS_POSTED          (51),
		.MAX_OUTSTANDING_RESPONSES (6),
		.PIPELINED                 (0),
		.ST_DATA_W                 (69),
		.ST_CHANNEL_W              (7),
		.VALID_WIDTH               (7),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (57),
		.PKT_BYTE_CNT_L            (55),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter_002 (
		.clk                    (rx_clk_clk),                         //       clk.clk
		.reset                  (rst_controller_002_reset_out_reset), // clk_reset.reset
		.cmd_sink_ready         (addr_router_002_src_ready),          //  cmd_sink.ready
		.cmd_sink_valid         (addr_router_002_src_valid),          //          .valid
		.cmd_sink_data          (addr_router_002_src_data),           //          .data
		.cmd_sink_channel       (addr_router_002_src_channel),        //          .channel
		.cmd_sink_startofpacket (addr_router_002_src_startofpacket),  //          .startofpacket
		.cmd_sink_endofpacket   (addr_router_002_src_endofpacket),    //          .endofpacket
		.cmd_src_ready          (limiter_002_cmd_src_ready),          //   cmd_src.ready
		.cmd_src_data           (limiter_002_cmd_src_data),           //          .data
		.cmd_src_channel        (limiter_002_cmd_src_channel),        //          .channel
		.cmd_src_startofpacket  (limiter_002_cmd_src_startofpacket),  //          .startofpacket
		.cmd_src_endofpacket    (limiter_002_cmd_src_endofpacket),    //          .endofpacket
		.rsp_sink_ready         (rsp_xbar_mux_002_src_ready),         //  rsp_sink.ready
		.rsp_sink_valid         (rsp_xbar_mux_002_src_valid),         //          .valid
		.rsp_sink_channel       (rsp_xbar_mux_002_src_channel),       //          .channel
		.rsp_sink_data          (rsp_xbar_mux_002_src_data),          //          .data
		.rsp_sink_startofpacket (rsp_xbar_mux_002_src_startofpacket), //          .startofpacket
		.rsp_sink_endofpacket   (rsp_xbar_mux_002_src_endofpacket),   //          .endofpacket
		.rsp_src_ready          (limiter_002_rsp_src_ready),          //   rsp_src.ready
		.rsp_src_valid          (limiter_002_rsp_src_valid),          //          .valid
		.rsp_src_data           (limiter_002_rsp_src_data),           //          .data
		.rsp_src_channel        (limiter_002_rsp_src_channel),        //          .channel
		.rsp_src_startofpacket  (limiter_002_rsp_src_startofpacket),  //          .startofpacket
		.rsp_src_endofpacket    (limiter_002_rsp_src_endofpacket),    //          .endofpacket
		.cmd_src_valid          (limiter_002_cmd_valid_data)          // cmd_valid.data
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~csr_reset_reset_n),             // reset_in0.reset
		.clk        (csr_clk_clk),                    //       clk.clk
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

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller_001 (
		.reset_in0  (~tx_reset_reset_n),                  // reset_in0.reset
		.clk        (tx_clk_clk),                         //       clk.clk
		.reset_out  (rst_controller_001_reset_out_reset), // reset_out.reset
		.reset_in1  (1'b0),                               // (terminated)
		.reset_in2  (1'b0),                               // (terminated)
		.reset_in3  (1'b0),                               // (terminated)
		.reset_in4  (1'b0),                               // (terminated)
		.reset_in5  (1'b0),                               // (terminated)
		.reset_in6  (1'b0),                               // (terminated)
		.reset_in7  (1'b0),                               // (terminated)
		.reset_in8  (1'b0),                               // (terminated)
		.reset_in9  (1'b0),                               // (terminated)
		.reset_in10 (1'b0),                               // (terminated)
		.reset_in11 (1'b0),                               // (terminated)
		.reset_in12 (1'b0),                               // (terminated)
		.reset_in13 (1'b0),                               // (terminated)
		.reset_in14 (1'b0),                               // (terminated)
		.reset_in15 (1'b0)                                // (terminated)
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller_002 (
		.reset_in0  (~rx_reset_reset_n),                  // reset_in0.reset
		.clk        (rx_clk_clk),                         //       clk.clk
		.reset_out  (rst_controller_002_reset_out_reset), // reset_out.reset
		.reset_in1  (1'b0),                               // (terminated)
		.reset_in2  (1'b0),                               // (terminated)
		.reset_in3  (1'b0),                               // (terminated)
		.reset_in4  (1'b0),                               // (terminated)
		.reset_in5  (1'b0),                               // (terminated)
		.reset_in6  (1'b0),                               // (terminated)
		.reset_in7  (1'b0),                               // (terminated)
		.reset_in8  (1'b0),                               // (terminated)
		.reset_in9  (1'b0),                               // (terminated)
		.reset_in10 (1'b0),                               // (terminated)
		.reset_in11 (1'b0),                               // (terminated)
		.reset_in12 (1'b0),                               // (terminated)
		.reset_in13 (1'b0),                               // (terminated)
		.reset_in14 (1'b0),                               // (terminated)
		.reset_in15 (1'b0)                                // (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac_cmd_xbar_demux cmd_xbar_demux (
		.clk                (csr_clk_clk),                       //        clk.clk
		.reset              (rst_controller_reset_out_reset),    //  clk_reset.reset
		.sink_ready         (limiter_cmd_src_ready),             //       sink.ready
		.sink_channel       (limiter_cmd_src_channel),           //           .channel
		.sink_data          (limiter_cmd_src_data),              //           .data
		.sink_startofpacket (limiter_cmd_src_startofpacket),     //           .startofpacket
		.sink_endofpacket   (limiter_cmd_src_endofpacket),       //           .endofpacket
		.sink_valid         (limiter_cmd_valid_data),            // sink_valid.data
		.src0_ready         (cmd_xbar_demux_src0_ready),         //       src0.ready
		.src0_valid         (cmd_xbar_demux_src0_valid),         //           .valid
		.src0_data          (cmd_xbar_demux_src0_data),          //           .data
		.src0_channel       (cmd_xbar_demux_src0_channel),       //           .channel
		.src0_startofpacket (cmd_xbar_demux_src0_startofpacket), //           .startofpacket
		.src0_endofpacket   (cmd_xbar_demux_src0_endofpacket),   //           .endofpacket
		.src1_ready         (cmd_xbar_demux_src1_ready),         //       src1.ready
		.src1_valid         (cmd_xbar_demux_src1_valid),         //           .valid
		.src1_data          (cmd_xbar_demux_src1_data),          //           .data
		.src1_channel       (cmd_xbar_demux_src1_channel),       //           .channel
		.src1_startofpacket (cmd_xbar_demux_src1_startofpacket), //           .startofpacket
		.src1_endofpacket   (cmd_xbar_demux_src1_endofpacket)    //           .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux rsp_xbar_demux (
		.clk                (tx_clk_clk),                         //       clk.clk
		.reset              (rst_controller_001_reset_out_reset), // clk_reset.reset
		.sink_ready         (id_router_src_ready),                //      sink.ready
		.sink_channel       (id_router_src_channel),              //          .channel
		.sink_data          (id_router_src_data),                 //          .data
		.sink_startofpacket (id_router_src_startofpacket),        //          .startofpacket
		.sink_endofpacket   (id_router_src_endofpacket),          //          .endofpacket
		.sink_valid         (id_router_src_valid),                //          .valid
		.src0_ready         (rsp_xbar_demux_src0_ready),          //      src0.ready
		.src0_valid         (rsp_xbar_demux_src0_valid),          //          .valid
		.src0_data          (rsp_xbar_demux_src0_data),           //          .data
		.src0_channel       (rsp_xbar_demux_src0_channel),        //          .channel
		.src0_startofpacket (rsp_xbar_demux_src0_startofpacket),  //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_src0_endofpacket)     //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux rsp_xbar_demux_001 (
		.clk                (rx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_001_src_ready),               //      sink.ready
		.sink_channel       (id_router_001_src_channel),             //          .channel
		.sink_data          (id_router_001_src_data),                //          .data
		.sink_startofpacket (id_router_001_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_001_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_001_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_001_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_001_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_001_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_001_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_001_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_001_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_mux rsp_xbar_mux (
		.clk                 (csr_clk_clk),                    //       clk.clk
		.reset               (rst_controller_reset_out_reset), // clk_reset.reset
		.src_ready           (rsp_xbar_mux_src_ready),         //       src.ready
		.src_valid           (rsp_xbar_mux_src_valid),         //          .valid
		.src_data            (rsp_xbar_mux_src_data),          //          .data
		.src_channel         (rsp_xbar_mux_src_channel),       //          .channel
		.src_startofpacket   (rsp_xbar_mux_src_startofpacket), //          .startofpacket
		.src_endofpacket     (rsp_xbar_mux_src_endofpacket),   //          .endofpacket
		.sink0_ready         (crosser_002_out_ready),          //     sink0.ready
		.sink0_valid         (crosser_002_out_valid),          //          .valid
		.sink0_channel       (crosser_002_out_channel),        //          .channel
		.sink0_data          (crosser_002_out_data),           //          .data
		.sink0_startofpacket (crosser_002_out_startofpacket),  //          .startofpacket
		.sink0_endofpacket   (crosser_002_out_endofpacket),    //          .endofpacket
		.sink1_ready         (crosser_003_out_ready),          //     sink1.ready
		.sink1_valid         (crosser_003_out_valid),          //          .valid
		.sink1_channel       (crosser_003_out_channel),        //          .channel
		.sink1_data          (crosser_003_out_data),           //          .data
		.sink1_startofpacket (crosser_003_out_startofpacket),  //          .startofpacket
		.sink1_endofpacket   (crosser_003_out_endofpacket)     //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_cmd_xbar_demux_001 cmd_xbar_demux_001 (
		.clk                (tx_clk_clk),                            //        clk.clk
		.reset              (rst_controller_001_reset_out_reset),    //  clk_reset.reset
		.sink_ready         (limiter_001_cmd_src_ready),             //       sink.ready
		.sink_channel       (limiter_001_cmd_src_channel),           //           .channel
		.sink_data          (limiter_001_cmd_src_data),              //           .data
		.sink_startofpacket (limiter_001_cmd_src_startofpacket),     //           .startofpacket
		.sink_endofpacket   (limiter_001_cmd_src_endofpacket),       //           .endofpacket
		.sink_valid         (limiter_001_cmd_valid_data),            // sink_valid.data
		.src0_ready         (cmd_xbar_demux_001_src0_ready),         //       src0.ready
		.src0_valid         (cmd_xbar_demux_001_src0_valid),         //           .valid
		.src0_data          (cmd_xbar_demux_001_src0_data),          //           .data
		.src0_channel       (cmd_xbar_demux_001_src0_channel),       //           .channel
		.src0_startofpacket (cmd_xbar_demux_001_src0_startofpacket), //           .startofpacket
		.src0_endofpacket   (cmd_xbar_demux_001_src0_endofpacket),   //           .endofpacket
		.src1_ready         (cmd_xbar_demux_001_src1_ready),         //       src1.ready
		.src1_valid         (cmd_xbar_demux_001_src1_valid),         //           .valid
		.src1_data          (cmd_xbar_demux_001_src1_data),          //           .data
		.src1_channel       (cmd_xbar_demux_001_src1_channel),       //           .channel
		.src1_startofpacket (cmd_xbar_demux_001_src1_startofpacket), //           .startofpacket
		.src1_endofpacket   (cmd_xbar_demux_001_src1_endofpacket),   //           .endofpacket
		.src2_ready         (cmd_xbar_demux_001_src2_ready),         //       src2.ready
		.src2_valid         (cmd_xbar_demux_001_src2_valid),         //           .valid
		.src2_data          (cmd_xbar_demux_001_src2_data),          //           .data
		.src2_channel       (cmd_xbar_demux_001_src2_channel),       //           .channel
		.src2_startofpacket (cmd_xbar_demux_001_src2_startofpacket), //           .startofpacket
		.src2_endofpacket   (cmd_xbar_demux_001_src2_endofpacket),   //           .endofpacket
		.src3_ready         (cmd_xbar_demux_001_src3_ready),         //       src3.ready
		.src3_valid         (cmd_xbar_demux_001_src3_valid),         //           .valid
		.src3_data          (cmd_xbar_demux_001_src3_data),          //           .data
		.src3_channel       (cmd_xbar_demux_001_src3_channel),       //           .channel
		.src3_startofpacket (cmd_xbar_demux_001_src3_startofpacket), //           .startofpacket
		.src3_endofpacket   (cmd_xbar_demux_001_src3_endofpacket),   //           .endofpacket
		.src4_ready         (cmd_xbar_demux_001_src4_ready),         //       src4.ready
		.src4_valid         (cmd_xbar_demux_001_src4_valid),         //           .valid
		.src4_data          (cmd_xbar_demux_001_src4_data),          //           .data
		.src4_channel       (cmd_xbar_demux_001_src4_channel),       //           .channel
		.src4_startofpacket (cmd_xbar_demux_001_src4_startofpacket), //           .startofpacket
		.src4_endofpacket   (cmd_xbar_demux_001_src4_endofpacket),   //           .endofpacket
		.src5_ready         (cmd_xbar_demux_001_src5_ready),         //       src5.ready
		.src5_valid         (cmd_xbar_demux_001_src5_valid),         //           .valid
		.src5_data          (cmd_xbar_demux_001_src5_data),          //           .data
		.src5_channel       (cmd_xbar_demux_001_src5_channel),       //           .channel
		.src5_startofpacket (cmd_xbar_demux_001_src5_startofpacket), //           .startofpacket
		.src5_endofpacket   (cmd_xbar_demux_001_src5_endofpacket),   //           .endofpacket
		.src6_ready         (cmd_xbar_demux_001_src6_ready),         //       src6.ready
		.src6_valid         (cmd_xbar_demux_001_src6_valid),         //           .valid
		.src6_data          (cmd_xbar_demux_001_src6_data),          //           .data
		.src6_channel       (cmd_xbar_demux_001_src6_channel),       //           .channel
		.src6_startofpacket (cmd_xbar_demux_001_src6_startofpacket), //           .startofpacket
		.src6_endofpacket   (cmd_xbar_demux_001_src6_endofpacket),   //           .endofpacket
		.src7_ready         (cmd_xbar_demux_001_src7_ready),         //       src7.ready
		.src7_valid         (cmd_xbar_demux_001_src7_valid),         //           .valid
		.src7_data          (cmd_xbar_demux_001_src7_data),          //           .data
		.src7_channel       (cmd_xbar_demux_001_src7_channel),       //           .channel
		.src7_startofpacket (cmd_xbar_demux_001_src7_startofpacket), //           .startofpacket
		.src7_endofpacket   (cmd_xbar_demux_001_src7_endofpacket)    //           .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_002 rsp_xbar_demux_002 (
		.clk                (tx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_002_src_ready),               //      sink.ready
		.sink_channel       (id_router_002_src_channel),             //          .channel
		.sink_data          (id_router_002_src_data),                //          .data
		.sink_startofpacket (id_router_002_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_002_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_002_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_002_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_002_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_002_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_002_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_002_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_002_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_002 rsp_xbar_demux_003 (
		.clk                (tx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_003_src_ready),               //      sink.ready
		.sink_channel       (id_router_003_src_channel),             //          .channel
		.sink_data          (id_router_003_src_data),                //          .data
		.sink_startofpacket (id_router_003_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_003_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_003_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_003_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_003_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_003_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_003_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_003_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_003_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_002 rsp_xbar_demux_004 (
		.clk                (tx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_004_src_ready),               //      sink.ready
		.sink_channel       (id_router_004_src_channel),             //          .channel
		.sink_data          (id_router_004_src_data),                //          .data
		.sink_startofpacket (id_router_004_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_004_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_004_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_004_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_004_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_004_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_004_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_004_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_004_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_002 rsp_xbar_demux_005 (
		.clk                (tx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_005_src_ready),               //      sink.ready
		.sink_channel       (id_router_005_src_channel),             //          .channel
		.sink_data          (id_router_005_src_data),                //          .data
		.sink_startofpacket (id_router_005_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_005_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_005_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_005_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_005_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_005_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_005_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_005_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_005_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_002 rsp_xbar_demux_006 (
		.clk                (tx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_006_src_ready),               //      sink.ready
		.sink_channel       (id_router_006_src_channel),             //          .channel
		.sink_data          (id_router_006_src_data),                //          .data
		.sink_startofpacket (id_router_006_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_006_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_006_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_006_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_006_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_006_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_006_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_006_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_006_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_002 rsp_xbar_demux_007 (
		.clk                (tx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_007_src_ready),               //      sink.ready
		.sink_channel       (id_router_007_src_channel),             //          .channel
		.sink_data          (id_router_007_src_data),                //          .data
		.sink_startofpacket (id_router_007_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_007_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_007_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_007_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_007_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_007_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_007_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_007_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_007_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_002 rsp_xbar_demux_008 (
		.clk                (tx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_008_src_ready),               //      sink.ready
		.sink_channel       (id_router_008_src_channel),             //          .channel
		.sink_data          (id_router_008_src_data),                //          .data
		.sink_startofpacket (id_router_008_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_008_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_008_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_008_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_008_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_008_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_008_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_008_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_008_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_002 rsp_xbar_demux_009 (
		.clk                (tx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_009_src_ready),               //      sink.ready
		.sink_channel       (id_router_009_src_channel),             //          .channel
		.sink_data          (id_router_009_src_data),                //          .data
		.sink_startofpacket (id_router_009_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_009_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_009_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_009_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_009_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_009_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_009_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_009_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_009_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_mux_001 rsp_xbar_mux_001 (
		.clk                 (tx_clk_clk),                            //       clk.clk
		.reset               (rst_controller_001_reset_out_reset),    // clk_reset.reset
		.src_ready           (rsp_xbar_mux_001_src_ready),            //       src.ready
		.src_valid           (rsp_xbar_mux_001_src_valid),            //          .valid
		.src_data            (rsp_xbar_mux_001_src_data),             //          .data
		.src_channel         (rsp_xbar_mux_001_src_channel),          //          .channel
		.src_startofpacket   (rsp_xbar_mux_001_src_startofpacket),    //          .startofpacket
		.src_endofpacket     (rsp_xbar_mux_001_src_endofpacket),      //          .endofpacket
		.sink0_ready         (rsp_xbar_demux_002_src0_ready),         //     sink0.ready
		.sink0_valid         (rsp_xbar_demux_002_src0_valid),         //          .valid
		.sink0_channel       (rsp_xbar_demux_002_src0_channel),       //          .channel
		.sink0_data          (rsp_xbar_demux_002_src0_data),          //          .data
		.sink0_startofpacket (rsp_xbar_demux_002_src0_startofpacket), //          .startofpacket
		.sink0_endofpacket   (rsp_xbar_demux_002_src0_endofpacket),   //          .endofpacket
		.sink1_ready         (rsp_xbar_demux_003_src0_ready),         //     sink1.ready
		.sink1_valid         (rsp_xbar_demux_003_src0_valid),         //          .valid
		.sink1_channel       (rsp_xbar_demux_003_src0_channel),       //          .channel
		.sink1_data          (rsp_xbar_demux_003_src0_data),          //          .data
		.sink1_startofpacket (rsp_xbar_demux_003_src0_startofpacket), //          .startofpacket
		.sink1_endofpacket   (rsp_xbar_demux_003_src0_endofpacket),   //          .endofpacket
		.sink2_ready         (rsp_xbar_demux_004_src0_ready),         //     sink2.ready
		.sink2_valid         (rsp_xbar_demux_004_src0_valid),         //          .valid
		.sink2_channel       (rsp_xbar_demux_004_src0_channel),       //          .channel
		.sink2_data          (rsp_xbar_demux_004_src0_data),          //          .data
		.sink2_startofpacket (rsp_xbar_demux_004_src0_startofpacket), //          .startofpacket
		.sink2_endofpacket   (rsp_xbar_demux_004_src0_endofpacket),   //          .endofpacket
		.sink3_ready         (rsp_xbar_demux_005_src0_ready),         //     sink3.ready
		.sink3_valid         (rsp_xbar_demux_005_src0_valid),         //          .valid
		.sink3_channel       (rsp_xbar_demux_005_src0_channel),       //          .channel
		.sink3_data          (rsp_xbar_demux_005_src0_data),          //          .data
		.sink3_startofpacket (rsp_xbar_demux_005_src0_startofpacket), //          .startofpacket
		.sink3_endofpacket   (rsp_xbar_demux_005_src0_endofpacket),   //          .endofpacket
		.sink4_ready         (rsp_xbar_demux_006_src0_ready),         //     sink4.ready
		.sink4_valid         (rsp_xbar_demux_006_src0_valid),         //          .valid
		.sink4_channel       (rsp_xbar_demux_006_src0_channel),       //          .channel
		.sink4_data          (rsp_xbar_demux_006_src0_data),          //          .data
		.sink4_startofpacket (rsp_xbar_demux_006_src0_startofpacket), //          .startofpacket
		.sink4_endofpacket   (rsp_xbar_demux_006_src0_endofpacket),   //          .endofpacket
		.sink5_ready         (rsp_xbar_demux_007_src0_ready),         //     sink5.ready
		.sink5_valid         (rsp_xbar_demux_007_src0_valid),         //          .valid
		.sink5_channel       (rsp_xbar_demux_007_src0_channel),       //          .channel
		.sink5_data          (rsp_xbar_demux_007_src0_data),          //          .data
		.sink5_startofpacket (rsp_xbar_demux_007_src0_startofpacket), //          .startofpacket
		.sink5_endofpacket   (rsp_xbar_demux_007_src0_endofpacket),   //          .endofpacket
		.sink6_ready         (rsp_xbar_demux_008_src0_ready),         //     sink6.ready
		.sink6_valid         (rsp_xbar_demux_008_src0_valid),         //          .valid
		.sink6_channel       (rsp_xbar_demux_008_src0_channel),       //          .channel
		.sink6_data          (rsp_xbar_demux_008_src0_data),          //          .data
		.sink6_startofpacket (rsp_xbar_demux_008_src0_startofpacket), //          .startofpacket
		.sink6_endofpacket   (rsp_xbar_demux_008_src0_endofpacket),   //          .endofpacket
		.sink7_ready         (rsp_xbar_demux_009_src0_ready),         //     sink7.ready
		.sink7_valid         (rsp_xbar_demux_009_src0_valid),         //          .valid
		.sink7_channel       (rsp_xbar_demux_009_src0_channel),       //          .channel
		.sink7_data          (rsp_xbar_demux_009_src0_data),          //          .data
		.sink7_startofpacket (rsp_xbar_demux_009_src0_startofpacket), //          .startofpacket
		.sink7_endofpacket   (rsp_xbar_demux_009_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_cmd_xbar_demux_002 cmd_xbar_demux_002 (
		.clk                (rx_clk_clk),                            //        clk.clk
		.reset              (rst_controller_002_reset_out_reset),    //  clk_reset.reset
		.sink_ready         (limiter_002_cmd_src_ready),             //       sink.ready
		.sink_channel       (limiter_002_cmd_src_channel),           //           .channel
		.sink_data          (limiter_002_cmd_src_data),              //           .data
		.sink_startofpacket (limiter_002_cmd_src_startofpacket),     //           .startofpacket
		.sink_endofpacket   (limiter_002_cmd_src_endofpacket),       //           .endofpacket
		.sink_valid         (limiter_002_cmd_valid_data),            // sink_valid.data
		.src0_ready         (cmd_xbar_demux_002_src0_ready),         //       src0.ready
		.src0_valid         (cmd_xbar_demux_002_src0_valid),         //           .valid
		.src0_data          (cmd_xbar_demux_002_src0_data),          //           .data
		.src0_channel       (cmd_xbar_demux_002_src0_channel),       //           .channel
		.src0_startofpacket (cmd_xbar_demux_002_src0_startofpacket), //           .startofpacket
		.src0_endofpacket   (cmd_xbar_demux_002_src0_endofpacket),   //           .endofpacket
		.src1_ready         (cmd_xbar_demux_002_src1_ready),         //       src1.ready
		.src1_valid         (cmd_xbar_demux_002_src1_valid),         //           .valid
		.src1_data          (cmd_xbar_demux_002_src1_data),          //           .data
		.src1_channel       (cmd_xbar_demux_002_src1_channel),       //           .channel
		.src1_startofpacket (cmd_xbar_demux_002_src1_startofpacket), //           .startofpacket
		.src1_endofpacket   (cmd_xbar_demux_002_src1_endofpacket),   //           .endofpacket
		.src2_ready         (cmd_xbar_demux_002_src2_ready),         //       src2.ready
		.src2_valid         (cmd_xbar_demux_002_src2_valid),         //           .valid
		.src2_data          (cmd_xbar_demux_002_src2_data),          //           .data
		.src2_channel       (cmd_xbar_demux_002_src2_channel),       //           .channel
		.src2_startofpacket (cmd_xbar_demux_002_src2_startofpacket), //           .startofpacket
		.src2_endofpacket   (cmd_xbar_demux_002_src2_endofpacket),   //           .endofpacket
		.src3_ready         (cmd_xbar_demux_002_src3_ready),         //       src3.ready
		.src3_valid         (cmd_xbar_demux_002_src3_valid),         //           .valid
		.src3_data          (cmd_xbar_demux_002_src3_data),          //           .data
		.src3_channel       (cmd_xbar_demux_002_src3_channel),       //           .channel
		.src3_startofpacket (cmd_xbar_demux_002_src3_startofpacket), //           .startofpacket
		.src3_endofpacket   (cmd_xbar_demux_002_src3_endofpacket),   //           .endofpacket
		.src4_ready         (cmd_xbar_demux_002_src4_ready),         //       src4.ready
		.src4_valid         (cmd_xbar_demux_002_src4_valid),         //           .valid
		.src4_data          (cmd_xbar_demux_002_src4_data),          //           .data
		.src4_channel       (cmd_xbar_demux_002_src4_channel),       //           .channel
		.src4_startofpacket (cmd_xbar_demux_002_src4_startofpacket), //           .startofpacket
		.src4_endofpacket   (cmd_xbar_demux_002_src4_endofpacket),   //           .endofpacket
		.src5_ready         (cmd_xbar_demux_002_src5_ready),         //       src5.ready
		.src5_valid         (cmd_xbar_demux_002_src5_valid),         //           .valid
		.src5_data          (cmd_xbar_demux_002_src5_data),          //           .data
		.src5_channel       (cmd_xbar_demux_002_src5_channel),       //           .channel
		.src5_startofpacket (cmd_xbar_demux_002_src5_startofpacket), //           .startofpacket
		.src5_endofpacket   (cmd_xbar_demux_002_src5_endofpacket),   //           .endofpacket
		.src6_ready         (cmd_xbar_demux_002_src6_ready),         //       src6.ready
		.src6_valid         (cmd_xbar_demux_002_src6_valid),         //           .valid
		.src6_data          (cmd_xbar_demux_002_src6_data),          //           .data
		.src6_channel       (cmd_xbar_demux_002_src6_channel),       //           .channel
		.src6_startofpacket (cmd_xbar_demux_002_src6_startofpacket), //           .startofpacket
		.src6_endofpacket   (cmd_xbar_demux_002_src6_endofpacket)    //           .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_010 rsp_xbar_demux_010 (
		.clk                (rx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_010_src_ready),               //      sink.ready
		.sink_channel       (id_router_010_src_channel),             //          .channel
		.sink_data          (id_router_010_src_data),                //          .data
		.sink_startofpacket (id_router_010_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_010_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_010_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_010_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_010_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_010_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_010_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_010_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_010_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_010 rsp_xbar_demux_011 (
		.clk                (rx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_011_src_ready),               //      sink.ready
		.sink_channel       (id_router_011_src_channel),             //          .channel
		.sink_data          (id_router_011_src_data),                //          .data
		.sink_startofpacket (id_router_011_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_011_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_011_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_011_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_011_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_011_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_011_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_011_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_011_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_010 rsp_xbar_demux_012 (
		.clk                (rx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_012_src_ready),               //      sink.ready
		.sink_channel       (id_router_012_src_channel),             //          .channel
		.sink_data          (id_router_012_src_data),                //          .data
		.sink_startofpacket (id_router_012_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_012_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_012_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_012_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_012_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_012_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_012_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_012_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_012_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_010 rsp_xbar_demux_013 (
		.clk                (rx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_013_src_ready),               //      sink.ready
		.sink_channel       (id_router_013_src_channel),             //          .channel
		.sink_data          (id_router_013_src_data),                //          .data
		.sink_startofpacket (id_router_013_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_013_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_013_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_013_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_013_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_013_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_013_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_013_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_013_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_010 rsp_xbar_demux_014 (
		.clk                (rx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_014_src_ready),               //      sink.ready
		.sink_channel       (id_router_014_src_channel),             //          .channel
		.sink_data          (id_router_014_src_data),                //          .data
		.sink_startofpacket (id_router_014_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_014_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_014_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_014_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_014_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_014_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_014_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_014_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_014_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_010 rsp_xbar_demux_015 (
		.clk                (rx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_015_src_ready),               //      sink.ready
		.sink_channel       (id_router_015_src_channel),             //          .channel
		.sink_data          (id_router_015_src_data),                //          .data
		.sink_startofpacket (id_router_015_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_015_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_015_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_015_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_015_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_015_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_015_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_015_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_015_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_demux_010 rsp_xbar_demux_016 (
		.clk                (rx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_016_src_ready),               //      sink.ready
		.sink_channel       (id_router_016_src_channel),             //          .channel
		.sink_data          (id_router_016_src_data),                //          .data
		.sink_startofpacket (id_router_016_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_016_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_016_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_016_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_016_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_016_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_016_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_016_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_016_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_eth_10g_mac_rsp_xbar_mux_002 rsp_xbar_mux_002 (
		.clk                 (rx_clk_clk),                            //       clk.clk
		.reset               (rst_controller_002_reset_out_reset),    // clk_reset.reset
		.src_ready           (rsp_xbar_mux_002_src_ready),            //       src.ready
		.src_valid           (rsp_xbar_mux_002_src_valid),            //          .valid
		.src_data            (rsp_xbar_mux_002_src_data),             //          .data
		.src_channel         (rsp_xbar_mux_002_src_channel),          //          .channel
		.src_startofpacket   (rsp_xbar_mux_002_src_startofpacket),    //          .startofpacket
		.src_endofpacket     (rsp_xbar_mux_002_src_endofpacket),      //          .endofpacket
		.sink0_ready         (rsp_xbar_demux_010_src0_ready),         //     sink0.ready
		.sink0_valid         (rsp_xbar_demux_010_src0_valid),         //          .valid
		.sink0_channel       (rsp_xbar_demux_010_src0_channel),       //          .channel
		.sink0_data          (rsp_xbar_demux_010_src0_data),          //          .data
		.sink0_startofpacket (rsp_xbar_demux_010_src0_startofpacket), //          .startofpacket
		.sink0_endofpacket   (rsp_xbar_demux_010_src0_endofpacket),   //          .endofpacket
		.sink1_ready         (rsp_xbar_demux_011_src0_ready),         //     sink1.ready
		.sink1_valid         (rsp_xbar_demux_011_src0_valid),         //          .valid
		.sink1_channel       (rsp_xbar_demux_011_src0_channel),       //          .channel
		.sink1_data          (rsp_xbar_demux_011_src0_data),          //          .data
		.sink1_startofpacket (rsp_xbar_demux_011_src0_startofpacket), //          .startofpacket
		.sink1_endofpacket   (rsp_xbar_demux_011_src0_endofpacket),   //          .endofpacket
		.sink2_ready         (rsp_xbar_demux_012_src0_ready),         //     sink2.ready
		.sink2_valid         (rsp_xbar_demux_012_src0_valid),         //          .valid
		.sink2_channel       (rsp_xbar_demux_012_src0_channel),       //          .channel
		.sink2_data          (rsp_xbar_demux_012_src0_data),          //          .data
		.sink2_startofpacket (rsp_xbar_demux_012_src0_startofpacket), //          .startofpacket
		.sink2_endofpacket   (rsp_xbar_demux_012_src0_endofpacket),   //          .endofpacket
		.sink3_ready         (rsp_xbar_demux_013_src0_ready),         //     sink3.ready
		.sink3_valid         (rsp_xbar_demux_013_src0_valid),         //          .valid
		.sink3_channel       (rsp_xbar_demux_013_src0_channel),       //          .channel
		.sink3_data          (rsp_xbar_demux_013_src0_data),          //          .data
		.sink3_startofpacket (rsp_xbar_demux_013_src0_startofpacket), //          .startofpacket
		.sink3_endofpacket   (rsp_xbar_demux_013_src0_endofpacket),   //          .endofpacket
		.sink4_ready         (rsp_xbar_demux_014_src0_ready),         //     sink4.ready
		.sink4_valid         (rsp_xbar_demux_014_src0_valid),         //          .valid
		.sink4_channel       (rsp_xbar_demux_014_src0_channel),       //          .channel
		.sink4_data          (rsp_xbar_demux_014_src0_data),          //          .data
		.sink4_startofpacket (rsp_xbar_demux_014_src0_startofpacket), //          .startofpacket
		.sink4_endofpacket   (rsp_xbar_demux_014_src0_endofpacket),   //          .endofpacket
		.sink5_ready         (rsp_xbar_demux_015_src0_ready),         //     sink5.ready
		.sink5_valid         (rsp_xbar_demux_015_src0_valid),         //          .valid
		.sink5_channel       (rsp_xbar_demux_015_src0_channel),       //          .channel
		.sink5_data          (rsp_xbar_demux_015_src0_data),          //          .data
		.sink5_startofpacket (rsp_xbar_demux_015_src0_startofpacket), //          .startofpacket
		.sink5_endofpacket   (rsp_xbar_demux_015_src0_endofpacket),   //          .endofpacket
		.sink6_ready         (rsp_xbar_demux_016_src0_ready),         //     sink6.ready
		.sink6_valid         (rsp_xbar_demux_016_src0_valid),         //          .valid
		.sink6_channel       (rsp_xbar_demux_016_src0_channel),       //          .channel
		.sink6_data          (rsp_xbar_demux_016_src0_data),          //          .data
		.sink6_startofpacket (rsp_xbar_demux_016_src0_startofpacket), //          .startofpacket
		.sink6_endofpacket   (rsp_xbar_demux_016_src0_endofpacket)    //          .endofpacket
	);

	altera_avalon_st_handshake_clock_crosser #(
		.DATA_WIDTH          (68),
		.BITS_PER_SYMBOL     (68),
		.USE_PACKETS         (1),
		.USE_CHANNEL         (1),
		.CHANNEL_WIDTH       (2),
		.USE_ERROR           (0),
		.ERROR_WIDTH         (1),
		.VALID_SYNC_DEPTH    (2),
		.READY_SYNC_DEPTH    (2),
		.USE_OUTPUT_PIPELINE (0)
	) crosser (
		.in_clk            (csr_clk_clk),                        //        in_clk.clk
		.in_reset          (rst_controller_reset_out_reset),     //  in_clk_reset.reset
		.out_clk           (tx_clk_clk),                         //       out_clk.clk
		.out_reset         (rst_controller_001_reset_out_reset), // out_clk_reset.reset
		.in_ready          (cmd_xbar_demux_src0_ready),          //            in.ready
		.in_valid          (cmd_xbar_demux_src0_valid),          //              .valid
		.in_startofpacket  (cmd_xbar_demux_src0_startofpacket),  //              .startofpacket
		.in_endofpacket    (cmd_xbar_demux_src0_endofpacket),    //              .endofpacket
		.in_channel        (cmd_xbar_demux_src0_channel),        //              .channel
		.in_data           (cmd_xbar_demux_src0_data),           //              .data
		.out_ready         (crosser_out_ready),                  //           out.ready
		.out_valid         (crosser_out_valid),                  //              .valid
		.out_startofpacket (crosser_out_startofpacket),          //              .startofpacket
		.out_endofpacket   (crosser_out_endofpacket),            //              .endofpacket
		.out_channel       (crosser_out_channel),                //              .channel
		.out_data          (crosser_out_data),                   //              .data
		.in_empty          (1'b0),                               //   (terminated)
		.in_error          (1'b0),                               //   (terminated)
		.out_empty         (),                                   //   (terminated)
		.out_error         ()                                    //   (terminated)
	);

	altera_avalon_st_handshake_clock_crosser #(
		.DATA_WIDTH          (68),
		.BITS_PER_SYMBOL     (68),
		.USE_PACKETS         (1),
		.USE_CHANNEL         (1),
		.CHANNEL_WIDTH       (2),
		.USE_ERROR           (0),
		.ERROR_WIDTH         (1),
		.VALID_SYNC_DEPTH    (2),
		.READY_SYNC_DEPTH    (2),
		.USE_OUTPUT_PIPELINE (0)
	) crosser_001 (
		.in_clk            (csr_clk_clk),                        //        in_clk.clk
		.in_reset          (rst_controller_reset_out_reset),     //  in_clk_reset.reset
		.out_clk           (rx_clk_clk),                         //       out_clk.clk
		.out_reset         (rst_controller_002_reset_out_reset), // out_clk_reset.reset
		.in_ready          (cmd_xbar_demux_src1_ready),          //            in.ready
		.in_valid          (cmd_xbar_demux_src1_valid),          //              .valid
		.in_startofpacket  (cmd_xbar_demux_src1_startofpacket),  //              .startofpacket
		.in_endofpacket    (cmd_xbar_demux_src1_endofpacket),    //              .endofpacket
		.in_channel        (cmd_xbar_demux_src1_channel),        //              .channel
		.in_data           (cmd_xbar_demux_src1_data),           //              .data
		.out_ready         (crosser_001_out_ready),              //           out.ready
		.out_valid         (crosser_001_out_valid),              //              .valid
		.out_startofpacket (crosser_001_out_startofpacket),      //              .startofpacket
		.out_endofpacket   (crosser_001_out_endofpacket),        //              .endofpacket
		.out_channel       (crosser_001_out_channel),            //              .channel
		.out_data          (crosser_001_out_data),               //              .data
		.in_empty          (1'b0),                               //   (terminated)
		.in_error          (1'b0),                               //   (terminated)
		.out_empty         (),                                   //   (terminated)
		.out_error         ()                                    //   (terminated)
	);

	altera_avalon_st_handshake_clock_crosser #(
		.DATA_WIDTH          (68),
		.BITS_PER_SYMBOL     (68),
		.USE_PACKETS         (1),
		.USE_CHANNEL         (1),
		.CHANNEL_WIDTH       (2),
		.USE_ERROR           (0),
		.ERROR_WIDTH         (1),
		.VALID_SYNC_DEPTH    (2),
		.READY_SYNC_DEPTH    (2),
		.USE_OUTPUT_PIPELINE (0)
	) crosser_002 (
		.in_clk            (tx_clk_clk),                         //        in_clk.clk
		.in_reset          (rst_controller_001_reset_out_reset), //  in_clk_reset.reset
		.out_clk           (csr_clk_clk),                        //       out_clk.clk
		.out_reset         (rst_controller_reset_out_reset),     // out_clk_reset.reset
		.in_ready          (rsp_xbar_demux_src0_ready),          //            in.ready
		.in_valid          (rsp_xbar_demux_src0_valid),          //              .valid
		.in_startofpacket  (rsp_xbar_demux_src0_startofpacket),  //              .startofpacket
		.in_endofpacket    (rsp_xbar_demux_src0_endofpacket),    //              .endofpacket
		.in_channel        (rsp_xbar_demux_src0_channel),        //              .channel
		.in_data           (rsp_xbar_demux_src0_data),           //              .data
		.out_ready         (crosser_002_out_ready),              //           out.ready
		.out_valid         (crosser_002_out_valid),              //              .valid
		.out_startofpacket (crosser_002_out_startofpacket),      //              .startofpacket
		.out_endofpacket   (crosser_002_out_endofpacket),        //              .endofpacket
		.out_channel       (crosser_002_out_channel),            //              .channel
		.out_data          (crosser_002_out_data),               //              .data
		.in_empty          (1'b0),                               //   (terminated)
		.in_error          (1'b0),                               //   (terminated)
		.out_empty         (),                                   //   (terminated)
		.out_error         ()                                    //   (terminated)
	);

	altera_avalon_st_handshake_clock_crosser #(
		.DATA_WIDTH          (68),
		.BITS_PER_SYMBOL     (68),
		.USE_PACKETS         (1),
		.USE_CHANNEL         (1),
		.CHANNEL_WIDTH       (2),
		.USE_ERROR           (0),
		.ERROR_WIDTH         (1),
		.VALID_SYNC_DEPTH    (2),
		.READY_SYNC_DEPTH    (2),
		.USE_OUTPUT_PIPELINE (0)
	) crosser_003 (
		.in_clk            (rx_clk_clk),                            //        in_clk.clk
		.in_reset          (rst_controller_002_reset_out_reset),    //  in_clk_reset.reset
		.out_clk           (csr_clk_clk),                           //       out_clk.clk
		.out_reset         (rst_controller_reset_out_reset),        // out_clk_reset.reset
		.in_ready          (rsp_xbar_demux_001_src0_ready),         //            in.ready
		.in_valid          (rsp_xbar_demux_001_src0_valid),         //              .valid
		.in_startofpacket  (rsp_xbar_demux_001_src0_startofpacket), //              .startofpacket
		.in_endofpacket    (rsp_xbar_demux_001_src0_endofpacket),   //              .endofpacket
		.in_channel        (rsp_xbar_demux_001_src0_channel),       //              .channel
		.in_data           (rsp_xbar_demux_001_src0_data),          //              .data
		.out_ready         (crosser_003_out_ready),                 //           out.ready
		.out_valid         (crosser_003_out_valid),                 //              .valid
		.out_startofpacket (crosser_003_out_startofpacket),         //              .startofpacket
		.out_endofpacket   (crosser_003_out_endofpacket),           //              .endofpacket
		.out_channel       (crosser_003_out_channel),               //              .channel
		.out_data          (crosser_003_out_data),                  //              .data
		.in_empty          (1'b0),                                  //   (terminated)
		.in_error          (1'b0),                                  //   (terminated)
		.out_empty         (),                                      //   (terminated)
		.out_error         ()                                       //   (terminated)
	);

endmodule
