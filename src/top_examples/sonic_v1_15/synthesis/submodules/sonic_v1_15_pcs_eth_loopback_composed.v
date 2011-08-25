// sonic_v1_15_pcs_eth_loopback_composed.v

// This file was auto-generated from altera_eth_loopback_composed_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using SOPC Builder version 11.0 157 at 2011.08.01.12:24:25

`timescale 1 ps / 1 ps
module sonic_v1_15_pcs_eth_loopback_composed (
		input  wire        tx_clk_clk,           //          tx_clk.clk
		input  wire        tx_reset_reset_n,     //        tx_reset.reset_n
		input  wire        rx_clk_clk,           //          rx_clk.clk
		input  wire        rx_reset_reset_n,     //        rx_reset.reset_n
		input  wire        csr_clk_clk,          //         csr_clk.clk
		input  wire        csr_reset_reset_n,    //       csr_reset.reset_n
		input  wire [71:0] lb_tx_sink_data_data, // lb_tx_sink_data.data
		output wire [71:0] lb_tx_src_data_data,  //  lb_tx_src_data.data
		input  wire [71:0] lb_rx_sink_data_data, // lb_rx_sink_data.data
		output wire [71:0] lb_rx_src_data_data,  //  lb_rx_src_data.data
		input  wire [3:0]  csr_address,          //             csr.address
		output wire        csr_waitrequest,      //                .waitrequest
		input  wire        csr_read,             //                .read
		output wire [31:0] csr_readdata,         //                .readdata
		input  wire        csr_write,            //                .write
		input  wire [31:0] csr_writedata         //                .writedata
	);

	wire         lc_splitter_timing_adapter_out_valid;                                                                     // lc_splitter_timing_adapter:out_valid -> local_splitter:in0_valid
	wire  [71:0] lc_splitter_timing_adapter_out_data;                                                                      // lc_splitter_timing_adapter:out_data -> local_splitter:in0_data
	wire         lc_splitter_timing_adapter_out_ready;                                                                     // local_splitter:in0_ready -> lc_splitter_timing_adapter:out_ready
	wire         local_splitter_out0_valid;                                                                                // local_splitter:out0_valid -> line_loopback:in_valid_0
	wire  [71:0] local_splitter_out0_data;                                                                                 // local_splitter:out0_data -> line_loopback:in_data_0
	wire         local_splitter_out0_ready;                                                                                // line_loopback:in_ready_0 -> local_splitter:out0_ready
	wire         local_splitter_out1_valid;                                                                                // local_splitter:out1_valid -> dc_fifo_1:in_valid
	wire  [71:0] local_splitter_out1_data;                                                                                 // local_splitter:out1_data -> dc_fifo_1:in_data
	wire         local_splitter_out1_ready;                                                                                // dc_fifo_1:in_ready -> local_splitter:out1_ready
	wire         dc_fifo_1_out_valid;                                                                                      // dc_fifo_1:out_valid -> local_loopback:in_valid_1
	wire  [71:0] dc_fifo_1_out_data;                                                                                       // dc_fifo_1:out_data -> local_loopback:in_data_1
	wire         dc_fifo_1_out_ready;                                                                                      // local_loopback:in_ready_1 -> dc_fifo_1:out_ready
	wire         line_loopback_avalon_streaming_source_valid;                                                              // line_loopback:out_valid -> line_lb_timing_adapter:in_valid
	wire  [71:0] line_loopback_avalon_streaming_source_data;                                                               // line_loopback:out_data -> line_lb_timing_adapter:in_data
	wire         line_loopback_avalon_streaming_source_ready;                                                              // line_lb_timing_adapter:in_ready -> line_loopback:out_ready
	wire         line_splitter_timing_adapter_out_valid;                                                                   // line_splitter_timing_adapter:out_valid -> line_splitter:in0_valid
	wire  [71:0] line_splitter_timing_adapter_out_data;                                                                    // line_splitter_timing_adapter:out_data -> line_splitter:in0_data
	wire         line_splitter_timing_adapter_out_ready;                                                                   // line_splitter:in0_ready -> line_splitter_timing_adapter:out_ready
	wire         line_splitter_out0_valid;                                                                                 // line_splitter:out0_valid -> dc_fifo_2:in_valid
	wire  [71:0] line_splitter_out0_data;                                                                                  // line_splitter:out0_data -> dc_fifo_2:in_data
	wire         line_splitter_out0_ready;                                                                                 // dc_fifo_2:in_ready -> line_splitter:out0_ready
	wire         dc_fifo_2_out_valid;                                                                                      // dc_fifo_2:out_valid -> line_loopback:in_valid_1
	wire  [71:0] dc_fifo_2_out_data;                                                                                       // dc_fifo_2:out_data -> line_loopback:in_data_1
	wire         dc_fifo_2_out_ready;                                                                                      // line_loopback:in_ready_1 -> dc_fifo_2:out_ready
	wire         line_splitter_out1_valid;                                                                                 // line_splitter:out1_valid -> local_loopback:in_valid_0
	wire  [71:0] line_splitter_out1_data;                                                                                  // line_splitter:out1_data -> local_loopback:in_data_0
	wire         line_splitter_out1_ready;                                                                                 // local_loopback:in_ready_0 -> line_splitter:out1_ready
	wire         local_loopback_avalon_streaming_source_valid;                                                             // local_loopback:out_valid -> lc_lb_timing_adapter:in_valid
	wire  [71:0] local_loopback_avalon_streaming_source_data;                                                              // local_loopback:out_data -> lc_lb_timing_adapter:in_data
	wire         local_loopback_avalon_streaming_source_ready;                                                             // lc_lb_timing_adapter:in_ready -> local_loopback:out_ready
	wire         mm_pipeline_bridge_avalon_universal_master_0_waitrequest;                                                 // mm_pipeline_bridge_avalon_universal_master_0_translator:av_waitrequest -> mm_pipeline_bridge:uav_waitrequest
	wire   [2:0] mm_pipeline_bridge_avalon_universal_master_0_burstcount;                                                  // mm_pipeline_bridge:uav_burstcount -> mm_pipeline_bridge_avalon_universal_master_0_translator:av_burstcount
	wire  [31:0] mm_pipeline_bridge_avalon_universal_master_0_writedata;                                                   // mm_pipeline_bridge:uav_writedata -> mm_pipeline_bridge_avalon_universal_master_0_translator:av_writedata
	wire   [5:0] mm_pipeline_bridge_avalon_universal_master_0_address;                                                     // mm_pipeline_bridge:uav_address -> mm_pipeline_bridge_avalon_universal_master_0_translator:av_address
	wire         mm_pipeline_bridge_avalon_universal_master_0_lock;                                                        // mm_pipeline_bridge:uav_lock -> mm_pipeline_bridge_avalon_universal_master_0_translator:av_lock
	wire         mm_pipeline_bridge_avalon_universal_master_0_write;                                                       // mm_pipeline_bridge:uav_write -> mm_pipeline_bridge_avalon_universal_master_0_translator:av_write
	wire         mm_pipeline_bridge_avalon_universal_master_0_read;                                                        // mm_pipeline_bridge:uav_read -> mm_pipeline_bridge_avalon_universal_master_0_translator:av_read
	wire  [31:0] mm_pipeline_bridge_avalon_universal_master_0_readdata;                                                    // mm_pipeline_bridge_avalon_universal_master_0_translator:av_readdata -> mm_pipeline_bridge:uav_readdata
	wire         mm_pipeline_bridge_avalon_universal_master_0_debugaccess;                                                 // mm_pipeline_bridge:uav_debugaccess -> mm_pipeline_bridge_avalon_universal_master_0_translator:av_debugaccess
	wire   [3:0] mm_pipeline_bridge_avalon_universal_master_0_byteenable;                                                  // mm_pipeline_bridge:uav_byteenable -> mm_pipeline_bridge_avalon_universal_master_0_translator:av_byteenable
	wire         mm_pipeline_bridge_avalon_universal_master_0_readdatavalid;                                               // mm_pipeline_bridge_avalon_universal_master_0_translator:av_readdatavalid -> mm_pipeline_bridge:uav_readdatavalid
	wire  [31:0] local_loopback_control_translator_avalon_anti_slave_0_writedata;                                          // local_loopback_control_translator:av_writedata -> local_loopback:control_writedata
	wire         local_loopback_control_translator_avalon_anti_slave_0_address;                                            // local_loopback_control_translator:av_address -> local_loopback:control_address
	wire         local_loopback_control_translator_avalon_anti_slave_0_write;                                              // local_loopback_control_translator:av_write -> local_loopback:control_write
	wire         local_loopback_control_translator_avalon_anti_slave_0_read;                                               // local_loopback_control_translator:av_read -> local_loopback:control_read
	wire  [31:0] local_loopback_control_translator_avalon_anti_slave_0_readdata;                                           // local_loopback:control_readdata -> local_loopback_control_translator:av_readdata
	wire  [31:0] line_loopback_control_translator_avalon_anti_slave_0_writedata;                                           // line_loopback_control_translator:av_writedata -> line_loopback:control_writedata
	wire         line_loopback_control_translator_avalon_anti_slave_0_address;                                             // line_loopback_control_translator:av_address -> line_loopback:control_address
	wire         line_loopback_control_translator_avalon_anti_slave_0_write;                                               // line_loopback_control_translator:av_write -> line_loopback:control_write
	wire         line_loopback_control_translator_avalon_anti_slave_0_read;                                                // line_loopback_control_translator:av_read -> line_loopback:control_read
	wire  [31:0] line_loopback_control_translator_avalon_anti_slave_0_readdata;                                            // line_loopback:control_readdata -> line_loopback_control_translator:av_readdata
	wire         mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_waitrequest;            // mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_waitrequest -> mm_pipeline_bridge_avalon_universal_master_0_translator:uav_waitrequest
	wire   [2:0] mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_burstcount;             // mm_pipeline_bridge_avalon_universal_master_0_translator:uav_burstcount -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_writedata;              // mm_pipeline_bridge_avalon_universal_master_0_translator:uav_writedata -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_writedata
	wire   [5:0] mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_address;                // mm_pipeline_bridge_avalon_universal_master_0_translator:uav_address -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_address
	wire         mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_lock;                   // mm_pipeline_bridge_avalon_universal_master_0_translator:uav_lock -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_lock
	wire         mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_write;                  // mm_pipeline_bridge_avalon_universal_master_0_translator:uav_write -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_write
	wire         mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_read;                   // mm_pipeline_bridge_avalon_universal_master_0_translator:uav_read -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdata;               // mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_readdata -> mm_pipeline_bridge_avalon_universal_master_0_translator:uav_readdata
	wire         mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_debugaccess;            // mm_pipeline_bridge_avalon_universal_master_0_translator:uav_debugaccess -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_byteenable;             // mm_pipeline_bridge_avalon_universal_master_0_translator:uav_byteenable -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_byteenable
	wire         mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdatavalid;          // mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_readdatavalid -> mm_pipeline_bridge_avalon_universal_master_0_translator:uav_readdatavalid
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_m0_waitrequest;                          // local_loopback_control_translator:uav_waitrequest -> local_loopback_control_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] local_loopback_control_translator_avalon_universal_slave_0_agent_m0_burstcount;                           // local_loopback_control_translator_avalon_universal_slave_0_agent:m0_burstcount -> local_loopback_control_translator:uav_burstcount
	wire  [31:0] local_loopback_control_translator_avalon_universal_slave_0_agent_m0_writedata;                            // local_loopback_control_translator_avalon_universal_slave_0_agent:m0_writedata -> local_loopback_control_translator:uav_writedata
	wire   [5:0] local_loopback_control_translator_avalon_universal_slave_0_agent_m0_address;                              // local_loopback_control_translator_avalon_universal_slave_0_agent:m0_address -> local_loopback_control_translator:uav_address
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_m0_write;                                // local_loopback_control_translator_avalon_universal_slave_0_agent:m0_write -> local_loopback_control_translator:uav_write
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_m0_lock;                                 // local_loopback_control_translator_avalon_universal_slave_0_agent:m0_lock -> local_loopback_control_translator:uav_lock
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_m0_read;                                 // local_loopback_control_translator_avalon_universal_slave_0_agent:m0_read -> local_loopback_control_translator:uav_read
	wire  [31:0] local_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdata;                             // local_loopback_control_translator:uav_readdata -> local_loopback_control_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                        // local_loopback_control_translator:uav_readdatavalid -> local_loopback_control_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_m0_debugaccess;                          // local_loopback_control_translator_avalon_universal_slave_0_agent:m0_debugaccess -> local_loopback_control_translator:uav_debugaccess
	wire   [3:0] local_loopback_control_translator_avalon_universal_slave_0_agent_m0_byteenable;                           // local_loopback_control_translator_avalon_universal_slave_0_agent:m0_byteenable -> local_loopback_control_translator:uav_byteenable
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                   // local_loopback_control_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_valid;                         // local_loopback_control_translator_avalon_universal_slave_0_agent:rf_source_valid -> local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                 // local_loopback_control_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [59:0] local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_data;                          // local_loopback_control_translator_avalon_universal_slave_0_agent:rf_source_data -> local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_ready;                         // local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> local_loopback_control_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                // local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> local_loopback_control_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                      // local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> local_loopback_control_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;              // local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> local_loopback_control_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [59:0] local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                       // local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> local_loopback_control_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                      // local_loopback_control_translator_avalon_universal_slave_0_agent:rf_sink_ready -> local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                    // local_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:in_valid
	wire  [31:0] local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                     // local_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:in_data
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                    // local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:in_ready -> local_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid;                    // local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:out_valid -> local_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data;                     // local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:out_data -> local_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready;                    // local_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:out_ready
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_m0_waitrequest;                           // line_loopback_control_translator:uav_waitrequest -> line_loopback_control_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] line_loopback_control_translator_avalon_universal_slave_0_agent_m0_burstcount;                            // line_loopback_control_translator_avalon_universal_slave_0_agent:m0_burstcount -> line_loopback_control_translator:uav_burstcount
	wire  [31:0] line_loopback_control_translator_avalon_universal_slave_0_agent_m0_writedata;                             // line_loopback_control_translator_avalon_universal_slave_0_agent:m0_writedata -> line_loopback_control_translator:uav_writedata
	wire   [5:0] line_loopback_control_translator_avalon_universal_slave_0_agent_m0_address;                               // line_loopback_control_translator_avalon_universal_slave_0_agent:m0_address -> line_loopback_control_translator:uav_address
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_m0_write;                                 // line_loopback_control_translator_avalon_universal_slave_0_agent:m0_write -> line_loopback_control_translator:uav_write
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_m0_lock;                                  // line_loopback_control_translator_avalon_universal_slave_0_agent:m0_lock -> line_loopback_control_translator:uav_lock
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_m0_read;                                  // line_loopback_control_translator_avalon_universal_slave_0_agent:m0_read -> line_loopback_control_translator:uav_read
	wire  [31:0] line_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdata;                              // line_loopback_control_translator:uav_readdata -> line_loopback_control_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                         // line_loopback_control_translator:uav_readdatavalid -> line_loopback_control_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_m0_debugaccess;                           // line_loopback_control_translator_avalon_universal_slave_0_agent:m0_debugaccess -> line_loopback_control_translator:uav_debugaccess
	wire   [3:0] line_loopback_control_translator_avalon_universal_slave_0_agent_m0_byteenable;                            // line_loopback_control_translator_avalon_universal_slave_0_agent:m0_byteenable -> line_loopback_control_translator:uav_byteenable
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                    // line_loopback_control_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_valid;                          // line_loopback_control_translator_avalon_universal_slave_0_agent:rf_source_valid -> line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                  // line_loopback_control_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [59:0] line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_data;                           // line_loopback_control_translator_avalon_universal_slave_0_agent:rf_source_data -> line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_ready;                          // line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> line_loopback_control_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                 // line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> line_loopback_control_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                       // line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> line_loopback_control_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;               // line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> line_loopback_control_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [59:0] line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                        // line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> line_loopback_control_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                       // line_loopback_control_translator_avalon_universal_slave_0_agent:rf_sink_ready -> line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                     // line_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:in_valid
	wire  [31:0] line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                      // line_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:in_data
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                     // line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:in_ready -> line_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid;                     // line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:out_valid -> line_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data;                      // line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:out_data -> line_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready;                     // line_loopback_control_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:out_ready
	wire         mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_endofpacket;   // mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router:sink_endofpacket
	wire         mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_valid;         // mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_valid -> addr_router:sink_valid
	wire         mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_startofpacket; // mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router:sink_startofpacket
	wire  [58:0] mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_data;          // mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_data -> addr_router:sink_data
	wire         mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_ready;         // addr_router:sink_ready -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_ready
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rp_endofpacket;                          // local_loopback_control_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router:sink_endofpacket
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rp_valid;                                // local_loopback_control_translator_avalon_universal_slave_0_agent:rp_valid -> id_router:sink_valid
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rp_startofpacket;                        // local_loopback_control_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router:sink_startofpacket
	wire  [58:0] local_loopback_control_translator_avalon_universal_slave_0_agent_rp_data;                                 // local_loopback_control_translator_avalon_universal_slave_0_agent:rp_data -> id_router:sink_data
	wire         local_loopback_control_translator_avalon_universal_slave_0_agent_rp_ready;                                // id_router:sink_ready -> local_loopback_control_translator_avalon_universal_slave_0_agent:rp_ready
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rp_endofpacket;                           // line_loopback_control_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_001:sink_endofpacket
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rp_valid;                                 // line_loopback_control_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_001:sink_valid
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rp_startofpacket;                         // line_loopback_control_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_001:sink_startofpacket
	wire  [58:0] line_loopback_control_translator_avalon_universal_slave_0_agent_rp_data;                                  // line_loopback_control_translator_avalon_universal_slave_0_agent:rp_data -> id_router_001:sink_data
	wire         line_loopback_control_translator_avalon_universal_slave_0_agent_rp_ready;                                 // id_router_001:sink_ready -> line_loopback_control_translator_avalon_universal_slave_0_agent:rp_ready
	wire         addr_router_src_endofpacket;                                                                              // addr_router:src_endofpacket -> limiter:cmd_sink_endofpacket
	wire         addr_router_src_valid;                                                                                    // addr_router:src_valid -> limiter:cmd_sink_valid
	wire         addr_router_src_startofpacket;                                                                            // addr_router:src_startofpacket -> limiter:cmd_sink_startofpacket
	wire  [58:0] addr_router_src_data;                                                                                     // addr_router:src_data -> limiter:cmd_sink_data
	wire   [1:0] addr_router_src_channel;                                                                                  // addr_router:src_channel -> limiter:cmd_sink_channel
	wire         addr_router_src_ready;                                                                                    // limiter:cmd_sink_ready -> addr_router:src_ready
	wire         limiter_rsp_src_endofpacket;                                                                              // limiter:rsp_src_endofpacket -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_rsp_src_valid;                                                                                    // limiter:rsp_src_valid -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_rsp_src_startofpacket;                                                                            // limiter:rsp_src_startofpacket -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [58:0] limiter_rsp_src_data;                                                                                     // limiter:rsp_src_data -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_data
	wire   [1:0] limiter_rsp_src_channel;                                                                                  // limiter:rsp_src_channel -> mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_rsp_src_ready;                                                                                    // mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_ready -> limiter:rsp_src_ready
	wire         rst_controller_reset_out_reset;                                                                           // rst_controller:reset_out -> [crosser_001:out_reset, crosser_003:in_reset, dc_fifo_1:in_reset_n, dc_fifo_2:out_reset_n, id_router_001:reset, lc_splitter_timing_adapter:reset_n, line_lb_timing_adapter:reset_n, line_loopback:reset_n, line_loopback_control_translator:reset, line_loopback_control_translator_avalon_universal_slave_0_agent:reset, line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:reset, line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rsp_xbar_demux_001:reset]
	wire         rst_controller_001_reset_out_reset;                                                                       // rst_controller_001:reset_out -> [crosser:out_reset, crosser_002:in_reset, dc_fifo_1:out_reset_n, dc_fifo_2:in_reset_n, id_router:reset, lc_lb_timing_adapter:reset_n, line_splitter_timing_adapter:reset_n, local_loopback:reset_n, local_loopback_control_translator:reset, local_loopback_control_translator_avalon_universal_slave_0_agent:reset, local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo:reset, local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rsp_xbar_demux:reset]
	wire         rst_controller_002_reset_out_reset;                                                                       // rst_controller_002:reset_out -> [addr_router:reset, cmd_xbar_demux:reset, crosser:in_reset, crosser_001:in_reset, crosser_002:out_reset, crosser_003:out_reset, limiter:reset, mm_pipeline_bridge:reset, mm_pipeline_bridge_avalon_universal_master_0_translator:reset, mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:reset, rsp_xbar_mux:reset]
	wire         limiter_cmd_src_endofpacket;                                                                              // limiter:cmd_src_endofpacket -> cmd_xbar_demux:sink_endofpacket
	wire         limiter_cmd_src_startofpacket;                                                                            // limiter:cmd_src_startofpacket -> cmd_xbar_demux:sink_startofpacket
	wire  [58:0] limiter_cmd_src_data;                                                                                     // limiter:cmd_src_data -> cmd_xbar_demux:sink_data
	wire   [1:0] limiter_cmd_src_channel;                                                                                  // limiter:cmd_src_channel -> cmd_xbar_demux:sink_channel
	wire         limiter_cmd_src_ready;                                                                                    // cmd_xbar_demux:sink_ready -> limiter:cmd_src_ready
	wire         rsp_xbar_mux_src_endofpacket;                                                                             // rsp_xbar_mux:src_endofpacket -> limiter:rsp_sink_endofpacket
	wire         rsp_xbar_mux_src_valid;                                                                                   // rsp_xbar_mux:src_valid -> limiter:rsp_sink_valid
	wire         rsp_xbar_mux_src_startofpacket;                                                                           // rsp_xbar_mux:src_startofpacket -> limiter:rsp_sink_startofpacket
	wire  [58:0] rsp_xbar_mux_src_data;                                                                                    // rsp_xbar_mux:src_data -> limiter:rsp_sink_data
	wire   [1:0] rsp_xbar_mux_src_channel;                                                                                 // rsp_xbar_mux:src_channel -> limiter:rsp_sink_channel
	wire         rsp_xbar_mux_src_ready;                                                                                   // limiter:rsp_sink_ready -> rsp_xbar_mux:src_ready
	wire         crosser_out_ready;                                                                                        // local_loopback_control_translator_avalon_universal_slave_0_agent:cp_ready -> crosser:out_ready
	wire         id_router_src_endofpacket;                                                                                // id_router:src_endofpacket -> rsp_xbar_demux:sink_endofpacket
	wire         id_router_src_valid;                                                                                      // id_router:src_valid -> rsp_xbar_demux:sink_valid
	wire         id_router_src_startofpacket;                                                                              // id_router:src_startofpacket -> rsp_xbar_demux:sink_startofpacket
	wire  [58:0] id_router_src_data;                                                                                       // id_router:src_data -> rsp_xbar_demux:sink_data
	wire   [1:0] id_router_src_channel;                                                                                    // id_router:src_channel -> rsp_xbar_demux:sink_channel
	wire         id_router_src_ready;                                                                                      // rsp_xbar_demux:sink_ready -> id_router:src_ready
	wire         crosser_001_out_ready;                                                                                    // line_loopback_control_translator_avalon_universal_slave_0_agent:cp_ready -> crosser_001:out_ready
	wire         id_router_001_src_endofpacket;                                                                            // id_router_001:src_endofpacket -> rsp_xbar_demux_001:sink_endofpacket
	wire         id_router_001_src_valid;                                                                                  // id_router_001:src_valid -> rsp_xbar_demux_001:sink_valid
	wire         id_router_001_src_startofpacket;                                                                          // id_router_001:src_startofpacket -> rsp_xbar_demux_001:sink_startofpacket
	wire  [58:0] id_router_001_src_data;                                                                                   // id_router_001:src_data -> rsp_xbar_demux_001:sink_data
	wire   [1:0] id_router_001_src_channel;                                                                                // id_router_001:src_channel -> rsp_xbar_demux_001:sink_channel
	wire         id_router_001_src_ready;                                                                                  // rsp_xbar_demux_001:sink_ready -> id_router_001:src_ready
	wire         crosser_out_endofpacket;                                                                                  // crosser:out_endofpacket -> local_loopback_control_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         crosser_out_valid;                                                                                        // crosser:out_valid -> local_loopback_control_translator_avalon_universal_slave_0_agent:cp_valid
	wire         crosser_out_startofpacket;                                                                                // crosser:out_startofpacket -> local_loopback_control_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [58:0] crosser_out_data;                                                                                         // crosser:out_data -> local_loopback_control_translator_avalon_universal_slave_0_agent:cp_data
	wire   [1:0] crosser_out_channel;                                                                                      // crosser:out_channel -> local_loopback_control_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_src0_endofpacket;                                                                          // cmd_xbar_demux:src0_endofpacket -> crosser:in_endofpacket
	wire         cmd_xbar_demux_src0_valid;                                                                                // cmd_xbar_demux:src0_valid -> crosser:in_valid
	wire         cmd_xbar_demux_src0_startofpacket;                                                                        // cmd_xbar_demux:src0_startofpacket -> crosser:in_startofpacket
	wire  [58:0] cmd_xbar_demux_src0_data;                                                                                 // cmd_xbar_demux:src0_data -> crosser:in_data
	wire   [1:0] cmd_xbar_demux_src0_channel;                                                                              // cmd_xbar_demux:src0_channel -> crosser:in_channel
	wire         cmd_xbar_demux_src0_ready;                                                                                // crosser:in_ready -> cmd_xbar_demux:src0_ready
	wire         crosser_001_out_endofpacket;                                                                              // crosser_001:out_endofpacket -> line_loopback_control_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         crosser_001_out_valid;                                                                                    // crosser_001:out_valid -> line_loopback_control_translator_avalon_universal_slave_0_agent:cp_valid
	wire         crosser_001_out_startofpacket;                                                                            // crosser_001:out_startofpacket -> line_loopback_control_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [58:0] crosser_001_out_data;                                                                                     // crosser_001:out_data -> line_loopback_control_translator_avalon_universal_slave_0_agent:cp_data
	wire   [1:0] crosser_001_out_channel;                                                                                  // crosser_001:out_channel -> line_loopback_control_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_src1_endofpacket;                                                                          // cmd_xbar_demux:src1_endofpacket -> crosser_001:in_endofpacket
	wire         cmd_xbar_demux_src1_valid;                                                                                // cmd_xbar_demux:src1_valid -> crosser_001:in_valid
	wire         cmd_xbar_demux_src1_startofpacket;                                                                        // cmd_xbar_demux:src1_startofpacket -> crosser_001:in_startofpacket
	wire  [58:0] cmd_xbar_demux_src1_data;                                                                                 // cmd_xbar_demux:src1_data -> crosser_001:in_data
	wire   [1:0] cmd_xbar_demux_src1_channel;                                                                              // cmd_xbar_demux:src1_channel -> crosser_001:in_channel
	wire         cmd_xbar_demux_src1_ready;                                                                                // crosser_001:in_ready -> cmd_xbar_demux:src1_ready
	wire         crosser_002_out_endofpacket;                                                                              // crosser_002:out_endofpacket -> rsp_xbar_mux:sink0_endofpacket
	wire         crosser_002_out_valid;                                                                                    // crosser_002:out_valid -> rsp_xbar_mux:sink0_valid
	wire         crosser_002_out_startofpacket;                                                                            // crosser_002:out_startofpacket -> rsp_xbar_mux:sink0_startofpacket
	wire  [58:0] crosser_002_out_data;                                                                                     // crosser_002:out_data -> rsp_xbar_mux:sink0_data
	wire   [1:0] crosser_002_out_channel;                                                                                  // crosser_002:out_channel -> rsp_xbar_mux:sink0_channel
	wire         crosser_002_out_ready;                                                                                    // rsp_xbar_mux:sink0_ready -> crosser_002:out_ready
	wire         rsp_xbar_demux_src0_endofpacket;                                                                          // rsp_xbar_demux:src0_endofpacket -> crosser_002:in_endofpacket
	wire         rsp_xbar_demux_src0_valid;                                                                                // rsp_xbar_demux:src0_valid -> crosser_002:in_valid
	wire         rsp_xbar_demux_src0_startofpacket;                                                                        // rsp_xbar_demux:src0_startofpacket -> crosser_002:in_startofpacket
	wire  [58:0] rsp_xbar_demux_src0_data;                                                                                 // rsp_xbar_demux:src0_data -> crosser_002:in_data
	wire   [1:0] rsp_xbar_demux_src0_channel;                                                                              // rsp_xbar_demux:src0_channel -> crosser_002:in_channel
	wire         rsp_xbar_demux_src0_ready;                                                                                // crosser_002:in_ready -> rsp_xbar_demux:src0_ready
	wire         crosser_003_out_endofpacket;                                                                              // crosser_003:out_endofpacket -> rsp_xbar_mux:sink1_endofpacket
	wire         crosser_003_out_valid;                                                                                    // crosser_003:out_valid -> rsp_xbar_mux:sink1_valid
	wire         crosser_003_out_startofpacket;                                                                            // crosser_003:out_startofpacket -> rsp_xbar_mux:sink1_startofpacket
	wire  [58:0] crosser_003_out_data;                                                                                     // crosser_003:out_data -> rsp_xbar_mux:sink1_data
	wire   [1:0] crosser_003_out_channel;                                                                                  // crosser_003:out_channel -> rsp_xbar_mux:sink1_channel
	wire         crosser_003_out_ready;                                                                                    // rsp_xbar_mux:sink1_ready -> crosser_003:out_ready
	wire         rsp_xbar_demux_001_src0_endofpacket;                                                                      // rsp_xbar_demux_001:src0_endofpacket -> crosser_003:in_endofpacket
	wire         rsp_xbar_demux_001_src0_valid;                                                                            // rsp_xbar_demux_001:src0_valid -> crosser_003:in_valid
	wire         rsp_xbar_demux_001_src0_startofpacket;                                                                    // rsp_xbar_demux_001:src0_startofpacket -> crosser_003:in_startofpacket
	wire  [58:0] rsp_xbar_demux_001_src0_data;                                                                             // rsp_xbar_demux_001:src0_data -> crosser_003:in_data
	wire   [1:0] rsp_xbar_demux_001_src0_channel;                                                                          // rsp_xbar_demux_001:src0_channel -> crosser_003:in_channel
	wire         rsp_xbar_demux_001_src0_ready;                                                                            // crosser_003:in_ready -> rsp_xbar_demux_001:src0_ready
	wire   [1:0] limiter_cmd_valid_data;                                                                                   // limiter:cmd_src_valid -> cmd_xbar_demux:sink_valid

	sonic_v1_15_pcs_eth_loopback_composed_lc_splitter_timing_adapter lc_splitter_timing_adapter (
		.clk       (tx_clk_clk),                           //   clk.clk
		.reset_n   (~rst_controller_reset_out_reset),      // reset.reset_n
		.in_data   (lb_tx_sink_data_data),                 //    in.data
		.out_data  (lc_splitter_timing_adapter_out_data),  //   out.data
		.out_ready (lc_splitter_timing_adapter_out_ready), //      .ready
		.out_valid (lc_splitter_timing_adapter_out_valid)  //      .valid
	);

	altera_avalon_st_splitter #(
		.NUMBER_OF_OUTPUTS (2),
		.QUALIFY_VALID_OUT (0),
		.USE_PACKETS       (0),
		.DATA_WIDTH        (72),
		.CHANNEL_WIDTH     (1),
		.ERROR_WIDTH       (1),
		.BITS_PER_SYMBOL   (72),
		.EMPTY_WIDTH       (1)
	) local_splitter (
		.clk                 (tx_clk_clk),                           //  clk.clk
		.in0_ready           (lc_splitter_timing_adapter_out_ready), //   in.ready
		.in0_valid           (lc_splitter_timing_adapter_out_valid), //     .valid
		.in0_data            (lc_splitter_timing_adapter_out_data),  //     .data
		.out0_ready          (local_splitter_out0_ready),            // out0.ready
		.out0_valid          (local_splitter_out0_valid),            //     .valid
		.out0_data           (local_splitter_out0_data),             //     .data
		.out1_ready          (local_splitter_out1_ready),            // out1.ready
		.out1_valid          (local_splitter_out1_valid),            //     .valid
		.out1_data           (local_splitter_out1_data),             //     .data
		.in0_startofpacket   (1'b0),                                 // (terminated)
		.in0_endofpacket     (1'b0),                                 // (terminated)
		.in0_empty           (1'b0),                                 // (terminated)
		.in0_channel         (1'b0),                                 // (terminated)
		.in0_error           (1'b0),                                 // (terminated)
		.out0_startofpacket  (),                                     // (terminated)
		.out0_endofpacket    (),                                     // (terminated)
		.out0_empty          (),                                     // (terminated)
		.out0_channel        (),                                     // (terminated)
		.out0_error          (),                                     // (terminated)
		.out1_startofpacket  (),                                     // (terminated)
		.out1_endofpacket    (),                                     // (terminated)
		.out1_empty          (),                                     // (terminated)
		.out1_channel        (),                                     // (terminated)
		.out1_error          (),                                     // (terminated)
		.out2_ready          (1'b1),                                 // (terminated)
		.out2_valid          (),                                     // (terminated)
		.out2_startofpacket  (),                                     // (terminated)
		.out2_endofpacket    (),                                     // (terminated)
		.out2_empty          (),                                     // (terminated)
		.out2_channel        (),                                     // (terminated)
		.out2_error          (),                                     // (terminated)
		.out2_data           (),                                     // (terminated)
		.out3_ready          (1'b1),                                 // (terminated)
		.out3_valid          (),                                     // (terminated)
		.out3_startofpacket  (),                                     // (terminated)
		.out3_endofpacket    (),                                     // (terminated)
		.out3_empty          (),                                     // (terminated)
		.out3_channel        (),                                     // (terminated)
		.out3_error          (),                                     // (terminated)
		.out3_data           (),                                     // (terminated)
		.out4_ready          (1'b1),                                 // (terminated)
		.out4_valid          (),                                     // (terminated)
		.out4_startofpacket  (),                                     // (terminated)
		.out4_endofpacket    (),                                     // (terminated)
		.out4_empty          (),                                     // (terminated)
		.out4_channel        (),                                     // (terminated)
		.out4_error          (),                                     // (terminated)
		.out4_data           (),                                     // (terminated)
		.out5_ready          (1'b1),                                 // (terminated)
		.out5_valid          (),                                     // (terminated)
		.out5_startofpacket  (),                                     // (terminated)
		.out5_endofpacket    (),                                     // (terminated)
		.out5_empty          (),                                     // (terminated)
		.out5_channel        (),                                     // (terminated)
		.out5_error          (),                                     // (terminated)
		.out5_data           (),                                     // (terminated)
		.out6_ready          (1'b1),                                 // (terminated)
		.out6_valid          (),                                     // (terminated)
		.out6_startofpacket  (),                                     // (terminated)
		.out6_endofpacket    (),                                     // (terminated)
		.out6_empty          (),                                     // (terminated)
		.out6_channel        (),                                     // (terminated)
		.out6_error          (),                                     // (terminated)
		.out6_data           (),                                     // (terminated)
		.out7_ready          (1'b1),                                 // (terminated)
		.out7_valid          (),                                     // (terminated)
		.out7_startofpacket  (),                                     // (terminated)
		.out7_endofpacket    (),                                     // (terminated)
		.out7_empty          (),                                     // (terminated)
		.out7_channel        (),                                     // (terminated)
		.out7_error          (),                                     // (terminated)
		.out7_data           (),                                     // (terminated)
		.out8_ready          (1'b1),                                 // (terminated)
		.out8_valid          (),                                     // (terminated)
		.out8_startofpacket  (),                                     // (terminated)
		.out8_endofpacket    (),                                     // (terminated)
		.out8_empty          (),                                     // (terminated)
		.out8_channel        (),                                     // (terminated)
		.out8_error          (),                                     // (terminated)
		.out8_data           (),                                     // (terminated)
		.out9_ready          (1'b1),                                 // (terminated)
		.out9_valid          (),                                     // (terminated)
		.out9_startofpacket  (),                                     // (terminated)
		.out9_endofpacket    (),                                     // (terminated)
		.out9_empty          (),                                     // (terminated)
		.out9_channel        (),                                     // (terminated)
		.out9_error          (),                                     // (terminated)
		.out9_data           (),                                     // (terminated)
		.out10_ready         (1'b1),                                 // (terminated)
		.out10_valid         (),                                     // (terminated)
		.out10_startofpacket (),                                     // (terminated)
		.out10_endofpacket   (),                                     // (terminated)
		.out10_empty         (),                                     // (terminated)
		.out10_channel       (),                                     // (terminated)
		.out10_error         (),                                     // (terminated)
		.out10_data          (),                                     // (terminated)
		.out11_ready         (1'b1),                                 // (terminated)
		.out11_valid         (),                                     // (terminated)
		.out11_startofpacket (),                                     // (terminated)
		.out11_endofpacket   (),                                     // (terminated)
		.out11_empty         (),                                     // (terminated)
		.out11_channel       (),                                     // (terminated)
		.out11_error         (),                                     // (terminated)
		.out11_data          (),                                     // (terminated)
		.out12_ready         (1'b1),                                 // (terminated)
		.out12_valid         (),                                     // (terminated)
		.out12_startofpacket (),                                     // (terminated)
		.out12_endofpacket   (),                                     // (terminated)
		.out12_empty         (),                                     // (terminated)
		.out12_channel       (),                                     // (terminated)
		.out12_error         (),                                     // (terminated)
		.out12_data          (),                                     // (terminated)
		.out13_ready         (1'b1),                                 // (terminated)
		.out13_valid         (),                                     // (terminated)
		.out13_startofpacket (),                                     // (terminated)
		.out13_endofpacket   (),                                     // (terminated)
		.out13_empty         (),                                     // (terminated)
		.out13_channel       (),                                     // (terminated)
		.out13_error         (),                                     // (terminated)
		.out13_data          (),                                     // (terminated)
		.out14_ready         (1'b1),                                 // (terminated)
		.out14_valid         (),                                     // (terminated)
		.out14_startofpacket (),                                     // (terminated)
		.out14_endofpacket   (),                                     // (terminated)
		.out14_empty         (),                                     // (terminated)
		.out14_channel       (),                                     // (terminated)
		.out14_error         (),                                     // (terminated)
		.out14_data          (),                                     // (terminated)
		.out15_ready         (1'b1),                                 // (terminated)
		.out15_valid         (),                                     // (terminated)
		.out15_startofpacket (),                                     // (terminated)
		.out15_endofpacket   (),                                     // (terminated)
		.out15_empty         (),                                     // (terminated)
		.out15_channel       (),                                     // (terminated)
		.out15_error         (),                                     // (terminated)
		.out15_data          ()                                      // (terminated)
	);

	altera_eth_loopback #(
		.SYMBOLS_PER_BEAT (1),
		.BITS_PER_SYMBOL  (72),
		.ERROR_WIDTH      (0),
		.USE_PACKETS      (0),
		.EMPTY_WIDTH      (0)
	) line_loopback (
		.clk               (tx_clk_clk),                                                     //                   clock.clk
		.reset_n           (~rst_controller_reset_out_reset),                                //             clock_reset.reset_n
		.control_address   (line_loopback_control_translator_avalon_anti_slave_0_address),   //                 control.address
		.control_write     (line_loopback_control_translator_avalon_anti_slave_0_write),     //                        .write
		.control_read      (line_loopback_control_translator_avalon_anti_slave_0_read),      //                        .read
		.control_readdata  (line_loopback_control_translator_avalon_anti_slave_0_readdata),  //                        .readdata
		.control_writedata (line_loopback_control_translator_avalon_anti_slave_0_writedata), //                        .writedata
		.in_data_0         (local_splitter_out0_data),                                       //   avalon_streaming_sink.data
		.in_valid_0        (local_splitter_out0_valid),                                      //                        .valid
		.in_ready_0        (local_splitter_out0_ready),                                      //                        .ready
		.in_data_1         (dc_fifo_2_out_data),                                             // avalon_streaming_sink_1.data
		.in_valid_1        (dc_fifo_2_out_valid),                                            //                        .valid
		.in_ready_1        (dc_fifo_2_out_ready),                                            //                        .ready
		.out_data          (line_loopback_avalon_streaming_source_data),                     // avalon_streaming_source.data
		.out_valid         (line_loopback_avalon_streaming_source_valid),                    //                        .valid
		.out_ready         (line_loopback_avalon_streaming_source_ready)                     //                        .ready
	);

	sonic_v1_15_pcs_eth_loopback_composed_line_lb_timing_adapter line_lb_timing_adapter (
		.clk      (tx_clk_clk),                                  //   clk.clk
		.reset_n  (~rst_controller_reset_out_reset),             // reset.reset_n
		.in_ready (line_loopback_avalon_streaming_source_ready), //    in.ready
		.in_valid (line_loopback_avalon_streaming_source_valid), //      .valid
		.in_data  (line_loopback_avalon_streaming_source_data),  //      .data
		.out_data (lb_tx_src_data_data)                          //   out.data
	);

	sonic_v1_15_pcs_eth_loopback_composed_line_splitter_timing_adapter line_splitter_timing_adapter (
		.clk       (rx_clk_clk),                             //   clk.clk
		.reset_n   (~rst_controller_001_reset_out_reset),    // reset.reset_n
		.in_data   (lb_rx_sink_data_data),                   //    in.data
		.out_data  (line_splitter_timing_adapter_out_data),  //   out.data
		.out_ready (line_splitter_timing_adapter_out_ready), //      .ready
		.out_valid (line_splitter_timing_adapter_out_valid)  //      .valid
	);

	altera_avalon_st_splitter #(
		.NUMBER_OF_OUTPUTS (2),
		.QUALIFY_VALID_OUT (0),
		.USE_PACKETS       (0),
		.DATA_WIDTH        (72),
		.CHANNEL_WIDTH     (1),
		.ERROR_WIDTH       (1),
		.BITS_PER_SYMBOL   (72),
		.EMPTY_WIDTH       (1)
	) line_splitter (
		.clk                 (rx_clk_clk),                             //  clk.clk
		.in0_ready           (line_splitter_timing_adapter_out_ready), //   in.ready
		.in0_valid           (line_splitter_timing_adapter_out_valid), //     .valid
		.in0_data            (line_splitter_timing_adapter_out_data),  //     .data
		.out0_ready          (line_splitter_out0_ready),               // out0.ready
		.out0_valid          (line_splitter_out0_valid),               //     .valid
		.out0_data           (line_splitter_out0_data),                //     .data
		.out1_ready          (line_splitter_out1_ready),               // out1.ready
		.out1_valid          (line_splitter_out1_valid),               //     .valid
		.out1_data           (line_splitter_out1_data),                //     .data
		.in0_startofpacket   (1'b0),                                   // (terminated)
		.in0_endofpacket     (1'b0),                                   // (terminated)
		.in0_empty           (1'b0),                                   // (terminated)
		.in0_channel         (1'b0),                                   // (terminated)
		.in0_error           (1'b0),                                   // (terminated)
		.out0_startofpacket  (),                                       // (terminated)
		.out0_endofpacket    (),                                       // (terminated)
		.out0_empty          (),                                       // (terminated)
		.out0_channel        (),                                       // (terminated)
		.out0_error          (),                                       // (terminated)
		.out1_startofpacket  (),                                       // (terminated)
		.out1_endofpacket    (),                                       // (terminated)
		.out1_empty          (),                                       // (terminated)
		.out1_channel        (),                                       // (terminated)
		.out1_error          (),                                       // (terminated)
		.out2_ready          (1'b1),                                   // (terminated)
		.out2_valid          (),                                       // (terminated)
		.out2_startofpacket  (),                                       // (terminated)
		.out2_endofpacket    (),                                       // (terminated)
		.out2_empty          (),                                       // (terminated)
		.out2_channel        (),                                       // (terminated)
		.out2_error          (),                                       // (terminated)
		.out2_data           (),                                       // (terminated)
		.out3_ready          (1'b1),                                   // (terminated)
		.out3_valid          (),                                       // (terminated)
		.out3_startofpacket  (),                                       // (terminated)
		.out3_endofpacket    (),                                       // (terminated)
		.out3_empty          (),                                       // (terminated)
		.out3_channel        (),                                       // (terminated)
		.out3_error          (),                                       // (terminated)
		.out3_data           (),                                       // (terminated)
		.out4_ready          (1'b1),                                   // (terminated)
		.out4_valid          (),                                       // (terminated)
		.out4_startofpacket  (),                                       // (terminated)
		.out4_endofpacket    (),                                       // (terminated)
		.out4_empty          (),                                       // (terminated)
		.out4_channel        (),                                       // (terminated)
		.out4_error          (),                                       // (terminated)
		.out4_data           (),                                       // (terminated)
		.out5_ready          (1'b1),                                   // (terminated)
		.out5_valid          (),                                       // (terminated)
		.out5_startofpacket  (),                                       // (terminated)
		.out5_endofpacket    (),                                       // (terminated)
		.out5_empty          (),                                       // (terminated)
		.out5_channel        (),                                       // (terminated)
		.out5_error          (),                                       // (terminated)
		.out5_data           (),                                       // (terminated)
		.out6_ready          (1'b1),                                   // (terminated)
		.out6_valid          (),                                       // (terminated)
		.out6_startofpacket  (),                                       // (terminated)
		.out6_endofpacket    (),                                       // (terminated)
		.out6_empty          (),                                       // (terminated)
		.out6_channel        (),                                       // (terminated)
		.out6_error          (),                                       // (terminated)
		.out6_data           (),                                       // (terminated)
		.out7_ready          (1'b1),                                   // (terminated)
		.out7_valid          (),                                       // (terminated)
		.out7_startofpacket  (),                                       // (terminated)
		.out7_endofpacket    (),                                       // (terminated)
		.out7_empty          (),                                       // (terminated)
		.out7_channel        (),                                       // (terminated)
		.out7_error          (),                                       // (terminated)
		.out7_data           (),                                       // (terminated)
		.out8_ready          (1'b1),                                   // (terminated)
		.out8_valid          (),                                       // (terminated)
		.out8_startofpacket  (),                                       // (terminated)
		.out8_endofpacket    (),                                       // (terminated)
		.out8_empty          (),                                       // (terminated)
		.out8_channel        (),                                       // (terminated)
		.out8_error          (),                                       // (terminated)
		.out8_data           (),                                       // (terminated)
		.out9_ready          (1'b1),                                   // (terminated)
		.out9_valid          (),                                       // (terminated)
		.out9_startofpacket  (),                                       // (terminated)
		.out9_endofpacket    (),                                       // (terminated)
		.out9_empty          (),                                       // (terminated)
		.out9_channel        (),                                       // (terminated)
		.out9_error          (),                                       // (terminated)
		.out9_data           (),                                       // (terminated)
		.out10_ready         (1'b1),                                   // (terminated)
		.out10_valid         (),                                       // (terminated)
		.out10_startofpacket (),                                       // (terminated)
		.out10_endofpacket   (),                                       // (terminated)
		.out10_empty         (),                                       // (terminated)
		.out10_channel       (),                                       // (terminated)
		.out10_error         (),                                       // (terminated)
		.out10_data          (),                                       // (terminated)
		.out11_ready         (1'b1),                                   // (terminated)
		.out11_valid         (),                                       // (terminated)
		.out11_startofpacket (),                                       // (terminated)
		.out11_endofpacket   (),                                       // (terminated)
		.out11_empty         (),                                       // (terminated)
		.out11_channel       (),                                       // (terminated)
		.out11_error         (),                                       // (terminated)
		.out11_data          (),                                       // (terminated)
		.out12_ready         (1'b1),                                   // (terminated)
		.out12_valid         (),                                       // (terminated)
		.out12_startofpacket (),                                       // (terminated)
		.out12_endofpacket   (),                                       // (terminated)
		.out12_empty         (),                                       // (terminated)
		.out12_channel       (),                                       // (terminated)
		.out12_error         (),                                       // (terminated)
		.out12_data          (),                                       // (terminated)
		.out13_ready         (1'b1),                                   // (terminated)
		.out13_valid         (),                                       // (terminated)
		.out13_startofpacket (),                                       // (terminated)
		.out13_endofpacket   (),                                       // (terminated)
		.out13_empty         (),                                       // (terminated)
		.out13_channel       (),                                       // (terminated)
		.out13_error         (),                                       // (terminated)
		.out13_data          (),                                       // (terminated)
		.out14_ready         (1'b1),                                   // (terminated)
		.out14_valid         (),                                       // (terminated)
		.out14_startofpacket (),                                       // (terminated)
		.out14_endofpacket   (),                                       // (terminated)
		.out14_empty         (),                                       // (terminated)
		.out14_channel       (),                                       // (terminated)
		.out14_error         (),                                       // (terminated)
		.out14_data          (),                                       // (terminated)
		.out15_ready         (1'b1),                                   // (terminated)
		.out15_valid         (),                                       // (terminated)
		.out15_startofpacket (),                                       // (terminated)
		.out15_endofpacket   (),                                       // (terminated)
		.out15_empty         (),                                       // (terminated)
		.out15_channel       (),                                       // (terminated)
		.out15_error         (),                                       // (terminated)
		.out15_data          ()                                        // (terminated)
	);

	altera_eth_loopback #(
		.SYMBOLS_PER_BEAT (1),
		.BITS_PER_SYMBOL  (72),
		.ERROR_WIDTH      (0),
		.USE_PACKETS      (0),
		.EMPTY_WIDTH      (0)
	) local_loopback (
		.clk               (rx_clk_clk),                                                      //                   clock.clk
		.reset_n           (~rst_controller_001_reset_out_reset),                             //             clock_reset.reset_n
		.control_address   (local_loopback_control_translator_avalon_anti_slave_0_address),   //                 control.address
		.control_write     (local_loopback_control_translator_avalon_anti_slave_0_write),     //                        .write
		.control_read      (local_loopback_control_translator_avalon_anti_slave_0_read),      //                        .read
		.control_readdata  (local_loopback_control_translator_avalon_anti_slave_0_readdata),  //                        .readdata
		.control_writedata (local_loopback_control_translator_avalon_anti_slave_0_writedata), //                        .writedata
		.in_data_0         (line_splitter_out1_data),                                         //   avalon_streaming_sink.data
		.in_valid_0        (line_splitter_out1_valid),                                        //                        .valid
		.in_ready_0        (line_splitter_out1_ready),                                        //                        .ready
		.in_data_1         (dc_fifo_1_out_data),                                              // avalon_streaming_sink_1.data
		.in_valid_1        (dc_fifo_1_out_valid),                                             //                        .valid
		.in_ready_1        (dc_fifo_1_out_ready),                                             //                        .ready
		.out_data          (local_loopback_avalon_streaming_source_data),                     // avalon_streaming_source.data
		.out_valid         (local_loopback_avalon_streaming_source_valid),                    //                        .valid
		.out_ready         (local_loopback_avalon_streaming_source_ready)                     //                        .ready
	);

	sonic_v1_15_pcs_eth_loopback_composed_lc_lb_timing_adapter lc_lb_timing_adapter (
		.clk      (rx_clk_clk),                                   //   clk.clk
		.reset_n  (~rst_controller_001_reset_out_reset),          // reset.reset_n
		.in_ready (local_loopback_avalon_streaming_source_ready), //    in.ready
		.in_valid (local_loopback_avalon_streaming_source_valid), //      .valid
		.in_data  (local_loopback_avalon_streaming_source_data),  //      .data
		.out_data (lb_rx_src_data_data)                           //   out.data
	);

	altera_avalon_dc_fifo #(
		.SYMBOLS_PER_BEAT   (1),
		.BITS_PER_SYMBOL    (72),
		.FIFO_DEPTH         (16),
		.CHANNEL_WIDTH      (0),
		.ERROR_WIDTH        (0),
		.USE_PACKETS        (0),
		.USE_IN_FILL_LEVEL  (0),
		.USE_OUT_FILL_LEVEL (0),
		.WR_SYNC_DEPTH      (2),
		.RD_SYNC_DEPTH      (2)
	) dc_fifo_1 (
		.in_clk      (tx_clk_clk),                          //        in_clk.clk
		.in_reset_n  (~rst_controller_reset_out_reset),     //  in_clk_reset.reset_n
		.out_clk     (rx_clk_clk),                          //       out_clk.clk
		.out_reset_n (~rst_controller_001_reset_out_reset), // out_clk_reset.reset_n
		.in_data     (local_splitter_out1_data),            //            in.data
		.in_valid    (local_splitter_out1_valid),           //              .valid
		.in_ready    (local_splitter_out1_ready),           //              .ready
		.out_data    (dc_fifo_1_out_data),                  //           out.data
		.out_valid   (dc_fifo_1_out_valid),                 //              .valid
		.out_ready   (dc_fifo_1_out_ready)                  //              .ready
	);

	altera_avalon_dc_fifo #(
		.SYMBOLS_PER_BEAT   (1),
		.BITS_PER_SYMBOL    (72),
		.FIFO_DEPTH         (16),
		.CHANNEL_WIDTH      (0),
		.ERROR_WIDTH        (0),
		.USE_PACKETS        (0),
		.USE_IN_FILL_LEVEL  (0),
		.USE_OUT_FILL_LEVEL (0),
		.WR_SYNC_DEPTH      (2),
		.RD_SYNC_DEPTH      (2)
	) dc_fifo_2 (
		.in_clk      (rx_clk_clk),                          //        in_clk.clk
		.in_reset_n  (~rst_controller_001_reset_out_reset), //  in_clk_reset.reset_n
		.out_clk     (tx_clk_clk),                          //       out_clk.clk
		.out_reset_n (~rst_controller_reset_out_reset),     // out_clk_reset.reset_n
		.in_data     (line_splitter_out0_data),             //            in.data
		.in_valid    (line_splitter_out0_valid),            //              .valid
		.in_ready    (line_splitter_out0_ready),            //              .ready
		.out_data    (dc_fifo_2_out_data),                  //           out.data
		.out_valid   (dc_fifo_2_out_valid),                 //              .valid
		.out_ready   (dc_fifo_2_out_ready)                  //              .ready
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (4),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (6),
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
	) mm_pipeline_bridge (
		.clk                   (csr_clk_clk),                                                //                       clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                         //                     reset.reset
		.uav_address           (mm_pipeline_bridge_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (mm_pipeline_bridge_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (mm_pipeline_bridge_avalon_universal_master_0_read),          //                          .read
		.uav_write             (mm_pipeline_bridge_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (mm_pipeline_bridge_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (mm_pipeline_bridge_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (mm_pipeline_bridge_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (mm_pipeline_bridge_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (mm_pipeline_bridge_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (mm_pipeline_bridge_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (mm_pipeline_bridge_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (csr_address),                                                //      avalon_anti_master_0.address
		.av_waitrequest        (csr_waitrequest),                                            //                          .waitrequest
		.av_read               (csr_read),                                                   //                          .read
		.av_readdata           (csr_readdata),                                               //                          .readdata
		.av_write              (csr_write),                                                  //                          .write
		.av_writedata          (csr_writedata),                                              //                          .writedata
		.av_burstcount         (1'b1),                                                       //               (terminated)
		.av_byteenable         (4'b1111),                                                    //               (terminated)
		.av_beginbursttransfer (1'b0),                                                       //               (terminated)
		.av_begintransfer      (1'b0),                                                       //               (terminated)
		.av_chipselect         (1'b0),                                                       //               (terminated)
		.av_readdatavalid      (),                                                           //               (terminated)
		.av_lock               (1'b0),                                                       //               (terminated)
		.av_debugaccess        (1'b0),                                                       //               (terminated)
		.uav_clken             (),                                                           //               (terminated)
		.av_clken              (1'b1)                                                        //               (terminated)
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (6),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (3),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (6),
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
	) mm_pipeline_bridge_avalon_universal_master_0_translator (
		.clk                   (csr_clk_clk),                                                                                     //                       clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                                              //                     reset.reset
		.uav_address           (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (mm_pipeline_bridge_avalon_universal_master_0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (mm_pipeline_bridge_avalon_universal_master_0_waitrequest),                                        //                          .waitrequest
		.av_burstcount         (mm_pipeline_bridge_avalon_universal_master_0_burstcount),                                         //                          .burstcount
		.av_byteenable         (mm_pipeline_bridge_avalon_universal_master_0_byteenable),                                         //                          .byteenable
		.av_read               (mm_pipeline_bridge_avalon_universal_master_0_read),                                               //                          .read
		.av_readdata           (mm_pipeline_bridge_avalon_universal_master_0_readdata),                                           //                          .readdata
		.av_readdatavalid      (mm_pipeline_bridge_avalon_universal_master_0_readdatavalid),                                      //                          .readdatavalid
		.av_write              (mm_pipeline_bridge_avalon_universal_master_0_write),                                              //                          .write
		.av_writedata          (mm_pipeline_bridge_avalon_universal_master_0_writedata),                                          //                          .writedata
		.av_lock               (mm_pipeline_bridge_avalon_universal_master_0_lock),                                               //                          .lock
		.av_debugaccess        (mm_pipeline_bridge_avalon_universal_master_0_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer (1'b0),                                                                                            //               (terminated)
		.av_begintransfer      (1'b0),                                                                                            //               (terminated)
		.av_chipselect         (1'b0),                                                                                            //               (terminated)
		.uav_clken             (),                                                                                                //               (terminated)
		.av_clken              (1'b1)                                                                                             //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (1),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (6),
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
	) local_loopback_control_translator (
		.clk                   (rx_clk_clk),                                                                        //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                                //                    reset.reset
		.uav_address           (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (local_loopback_control_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (local_loopback_control_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (local_loopback_control_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (local_loopback_control_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (local_loopback_control_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
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
		.UAV_ADDRESS_W                  (6),
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
	) line_loopback_control_translator (
		.clk                   (tx_clk_clk),                                                                       //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                   //                    reset.reset
		.uav_address           (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (line_loopback_control_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (line_loopback_control_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (line_loopback_control_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (line_loopback_control_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (line_loopback_control_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                                 //              (terminated)
		.av_beginbursttransfer (),                                                                                 //              (terminated)
		.av_burstcount         (),                                                                                 //              (terminated)
		.av_byteenable         (),                                                                                 //              (terminated)
		.av_readdatavalid      (1'b0),                                                                             //              (terminated)
		.av_waitrequest        (1'b0),                                                                             //              (terminated)
		.av_writebyteenable    (),                                                                                 //              (terminated)
		.av_lock               (),                                                                                 //              (terminated)
		.av_chipselect         (),                                                                                 //              (terminated)
		.av_clken              (),                                                                                 //              (terminated)
		.uav_clken             (1'b0),                                                                             //              (terminated)
		.av_debugaccess        (),                                                                                 //              (terminated)
		.av_outputenable       ()                                                                                  //              (terminated)
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (58),
		.PKT_PROTECTION_L          (58),
		.PKT_BEGIN_BURST           (53),
		.PKT_BURSTWRAP_H           (52),
		.PKT_BURSTWRAP_L           (50),
		.PKT_BYTE_CNT_H            (49),
		.PKT_BYTE_CNT_L            (47),
		.PKT_ADDR_H                (41),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (42),
		.PKT_TRANS_POSTED          (43),
		.PKT_TRANS_WRITE           (44),
		.PKT_TRANS_READ            (45),
		.PKT_TRANS_LOCK            (46),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (55),
		.PKT_SRC_ID_L              (54),
		.PKT_DEST_ID_H             (57),
		.PKT_DEST_ID_L             (56),
		.ST_DATA_W                 (59),
		.ST_CHANNEL_W              (2),
		.AV_BURSTCOUNT_W           (3),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (1),
		.BURSTWRAP_VALUE           (7)
	) mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent (
		.clk              (csr_clk_clk),                                                                                              //       clk.clk
		.reset            (rst_controller_002_reset_out_reset),                                                                       // clk_reset.reset
		.av_address       (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_rsp_src_valid),                                                                                    //        rp.valid
		.rp_data          (limiter_rsp_src_data),                                                                                     //          .data
		.rp_channel       (limiter_rsp_src_channel),                                                                                  //          .channel
		.rp_startofpacket (limiter_rsp_src_startofpacket),                                                                            //          .startofpacket
		.rp_endofpacket   (limiter_rsp_src_endofpacket),                                                                              //          .endofpacket
		.rp_ready         (limiter_rsp_src_ready)                                                                                     //          .ready
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (53),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (41),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (42),
		.PKT_TRANS_POSTED          (43),
		.PKT_TRANS_WRITE           (44),
		.PKT_TRANS_READ            (45),
		.PKT_TRANS_LOCK            (46),
		.PKT_SRC_ID_H              (55),
		.PKT_SRC_ID_L              (54),
		.PKT_DEST_ID_H             (57),
		.PKT_DEST_ID_L             (56),
		.PKT_BURSTWRAP_H           (52),
		.PKT_BURSTWRAP_L           (50),
		.PKT_BYTE_CNT_H            (49),
		.PKT_BYTE_CNT_L            (47),
		.PKT_PROTECTION_H          (58),
		.PKT_PROTECTION_L          (58),
		.ST_CHANNEL_W              (2),
		.ST_DATA_W                 (59),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) local_loopback_control_translator_avalon_universal_slave_0_agent (
		.clk                     (rx_clk_clk),                                                                                  //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                          //       clk_reset.reset
		.m0_address              (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (local_loopback_control_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (local_loopback_control_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (local_loopback_control_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (local_loopback_control_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (local_loopback_control_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (local_loopback_control_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (crosser_out_ready),                                                                           //              cp.ready
		.cp_valid                (crosser_out_valid),                                                                           //                .valid
		.cp_data                 (crosser_out_data),                                                                            //                .data
		.cp_startofpacket        (crosser_out_startofpacket),                                                                   //                .startofpacket
		.cp_endofpacket          (crosser_out_endofpacket),                                                                     //                .endofpacket
		.cp_channel              (crosser_out_channel),                                                                         //                .channel
		.rf_sink_ready           (local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid),       //                .valid
		.rdata_fifo_sink_data    (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),        //                .data
		.rdata_fifo_src_ready    (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (60),
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
	) local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (rx_clk_clk),                                                                                  //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                          // clk_reset.reset
		.in_data           (local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (local_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (local_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
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
	) local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo (
		.clk               (rx_clk_clk),                                                                            //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                    // clk_reset.reset
		.in_data           (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),  //        in.data
		.in_valid          (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid), //          .valid
		.in_ready          (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready), //          .ready
		.out_data          (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),  //       out.data
		.out_valid         (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid), //          .valid
		.out_ready         (local_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready), //          .ready
		.csr_address       (2'b00),                                                                                 // (terminated)
		.csr_read          (1'b0),                                                                                  // (terminated)
		.csr_write         (1'b0),                                                                                  // (terminated)
		.csr_readdata      (),                                                                                      // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                  // (terminated)
		.almost_full_data  (),                                                                                      // (terminated)
		.almost_empty_data (),                                                                                      // (terminated)
		.in_startofpacket  (1'b0),                                                                                  // (terminated)
		.in_endofpacket    (1'b0),                                                                                  // (terminated)
		.out_startofpacket (),                                                                                      // (terminated)
		.out_endofpacket   (),                                                                                      // (terminated)
		.in_empty          (1'b0),                                                                                  // (terminated)
		.out_empty         (),                                                                                      // (terminated)
		.in_error          (1'b0),                                                                                  // (terminated)
		.out_error         (),                                                                                      // (terminated)
		.in_channel        (1'b0),                                                                                  // (terminated)
		.out_channel       ()                                                                                       // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (53),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (41),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (42),
		.PKT_TRANS_POSTED          (43),
		.PKT_TRANS_WRITE           (44),
		.PKT_TRANS_READ            (45),
		.PKT_TRANS_LOCK            (46),
		.PKT_SRC_ID_H              (55),
		.PKT_SRC_ID_L              (54),
		.PKT_DEST_ID_H             (57),
		.PKT_DEST_ID_L             (56),
		.PKT_BURSTWRAP_H           (52),
		.PKT_BURSTWRAP_L           (50),
		.PKT_BYTE_CNT_H            (49),
		.PKT_BYTE_CNT_L            (47),
		.PKT_PROTECTION_H          (58),
		.PKT_PROTECTION_L          (58),
		.ST_CHANNEL_W              (2),
		.ST_DATA_W                 (59),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) line_loopback_control_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                                 //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                             //       clk_reset.reset
		.m0_address              (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (line_loopback_control_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (line_loopback_control_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (line_loopback_control_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (line_loopback_control_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (line_loopback_control_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (line_loopback_control_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (crosser_001_out_ready),                                                                      //              cp.ready
		.cp_valid                (crosser_001_out_valid),                                                                      //                .valid
		.cp_data                 (crosser_001_out_data),                                                                       //                .data
		.cp_startofpacket        (crosser_001_out_startofpacket),                                                              //                .startofpacket
		.cp_endofpacket          (crosser_001_out_endofpacket),                                                                //                .endofpacket
		.cp_channel              (crosser_001_out_channel),                                                                    //                .channel
		.rf_sink_ready           (line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid),       //                .valid
		.rdata_fifo_sink_data    (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),        //                .data
		.rdata_fifo_src_ready    (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (60),
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
	) line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                                 //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                             // clk_reset.reset
		.in_data           (line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (line_loopback_control_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (line_loopback_control_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                      // (terminated)
		.csr_read          (1'b0),                                                                                       // (terminated)
		.csr_write         (1'b0),                                                                                       // (terminated)
		.csr_readdata      (),                                                                                           // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                       // (terminated)
		.almost_full_data  (),                                                                                           // (terminated)
		.almost_empty_data (),                                                                                           // (terminated)
		.in_empty          (1'b0),                                                                                       // (terminated)
		.out_empty         (),                                                                                           // (terminated)
		.in_error          (1'b0),                                                                                       // (terminated)
		.out_error         (),                                                                                           // (terminated)
		.in_channel        (1'b0),                                                                                       // (terminated)
		.out_channel       ()                                                                                            // (terminated)
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
	) line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo (
		.clk               (tx_clk_clk),                                                                           //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                       // clk_reset.reset
		.in_data           (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),  //        in.data
		.in_valid          (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid), //          .valid
		.in_ready          (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready), //          .ready
		.out_data          (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),  //       out.data
		.out_valid         (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid), //          .valid
		.out_ready         (line_loopback_control_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready), //          .ready
		.csr_address       (2'b00),                                                                                // (terminated)
		.csr_read          (1'b0),                                                                                 // (terminated)
		.csr_write         (1'b0),                                                                                 // (terminated)
		.csr_readdata      (),                                                                                     // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                 // (terminated)
		.almost_full_data  (),                                                                                     // (terminated)
		.almost_empty_data (),                                                                                     // (terminated)
		.in_startofpacket  (1'b0),                                                                                 // (terminated)
		.in_endofpacket    (1'b0),                                                                                 // (terminated)
		.out_startofpacket (),                                                                                     // (terminated)
		.out_endofpacket   (),                                                                                     // (terminated)
		.in_empty          (1'b0),                                                                                 // (terminated)
		.out_empty         (),                                                                                     // (terminated)
		.in_error          (1'b0),                                                                                 // (terminated)
		.out_error         (),                                                                                     // (terminated)
		.in_channel        (1'b0),                                                                                 // (terminated)
		.out_channel       ()                                                                                      // (terminated)
	);

	sonic_v1_15_pcs_eth_loopback_composed_addr_router addr_router (
		.sink_ready         (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (mm_pipeline_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (csr_clk_clk),                                                                                              //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                                                       // clk_reset.reset
		.src_ready          (addr_router_src_ready),                                                                                    //       src.ready
		.src_valid          (addr_router_src_valid),                                                                                    //          .valid
		.src_data           (addr_router_src_data),                                                                                     //          .data
		.src_channel        (addr_router_src_channel),                                                                                  //          .channel
		.src_startofpacket  (addr_router_src_startofpacket),                                                                            //          .startofpacket
		.src_endofpacket    (addr_router_src_endofpacket)                                                                               //          .endofpacket
	);

	sonic_v1_15_pcs_eth_loopback_composed_id_router id_router (
		.sink_ready         (local_loopback_control_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (local_loopback_control_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (local_loopback_control_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (local_loopback_control_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (local_loopback_control_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (rx_clk_clk),                                                                        //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                                // clk_reset.reset
		.src_ready          (id_router_src_ready),                                                               //       src.ready
		.src_valid          (id_router_src_valid),                                                               //          .valid
		.src_data           (id_router_src_data),                                                                //          .data
		.src_channel        (id_router_src_channel),                                                             //          .channel
		.src_startofpacket  (id_router_src_startofpacket),                                                       //          .startofpacket
		.src_endofpacket    (id_router_src_endofpacket)                                                          //          .endofpacket
	);

	sonic_v1_15_pcs_eth_loopback_composed_id_router id_router_001 (
		.sink_ready         (line_loopback_control_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (line_loopback_control_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (line_loopback_control_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (line_loopback_control_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (line_loopback_control_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                                       //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                   // clk_reset.reset
		.src_ready          (id_router_001_src_ready),                                                          //       src.ready
		.src_valid          (id_router_001_src_valid),                                                          //          .valid
		.src_data           (id_router_001_src_data),                                                           //          .data
		.src_channel        (id_router_001_src_channel),                                                        //          .channel
		.src_startofpacket  (id_router_001_src_startofpacket),                                                  //          .startofpacket
		.src_endofpacket    (id_router_001_src_endofpacket)                                                     //          .endofpacket
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (57),
		.PKT_DEST_ID_L             (56),
		.PKT_TRANS_POSTED          (43),
		.MAX_OUTSTANDING_RESPONSES (9),
		.PIPELINED                 (0),
		.ST_DATA_W                 (59),
		.ST_CHANNEL_W              (2),
		.VALID_WIDTH               (2),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (49),
		.PKT_BYTE_CNT_L            (47),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter (
		.clk                    (csr_clk_clk),                        //       clk.clk
		.reset                  (rst_controller_002_reset_out_reset), // clk_reset.reset
		.cmd_sink_ready         (addr_router_src_ready),              //  cmd_sink.ready
		.cmd_sink_valid         (addr_router_src_valid),              //          .valid
		.cmd_sink_data          (addr_router_src_data),               //          .data
		.cmd_sink_channel       (addr_router_src_channel),            //          .channel
		.cmd_sink_startofpacket (addr_router_src_startofpacket),      //          .startofpacket
		.cmd_sink_endofpacket   (addr_router_src_endofpacket),        //          .endofpacket
		.cmd_src_ready          (limiter_cmd_src_ready),              //   cmd_src.ready
		.cmd_src_data           (limiter_cmd_src_data),               //          .data
		.cmd_src_channel        (limiter_cmd_src_channel),            //          .channel
		.cmd_src_startofpacket  (limiter_cmd_src_startofpacket),      //          .startofpacket
		.cmd_src_endofpacket    (limiter_cmd_src_endofpacket),        //          .endofpacket
		.rsp_sink_ready         (rsp_xbar_mux_src_ready),             //  rsp_sink.ready
		.rsp_sink_valid         (rsp_xbar_mux_src_valid),             //          .valid
		.rsp_sink_channel       (rsp_xbar_mux_src_channel),           //          .channel
		.rsp_sink_data          (rsp_xbar_mux_src_data),              //          .data
		.rsp_sink_startofpacket (rsp_xbar_mux_src_startofpacket),     //          .startofpacket
		.rsp_sink_endofpacket   (rsp_xbar_mux_src_endofpacket),       //          .endofpacket
		.rsp_src_ready          (limiter_rsp_src_ready),              //   rsp_src.ready
		.rsp_src_valid          (limiter_rsp_src_valid),              //          .valid
		.rsp_src_data           (limiter_rsp_src_data),               //          .data
		.rsp_src_channel        (limiter_rsp_src_channel),            //          .channel
		.rsp_src_startofpacket  (limiter_rsp_src_startofpacket),      //          .startofpacket
		.rsp_src_endofpacket    (limiter_rsp_src_endofpacket),        //          .endofpacket
		.cmd_src_valid          (limiter_cmd_valid_data)              // cmd_valid.data
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (3),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~tx_reset_reset_n),              // reset_in0.reset
		.reset_in1  (~rx_reset_reset_n),              // reset_in1.reset
		.reset_in2  (~csr_reset_reset_n),             // reset_in2.reset
		.clk        (tx_clk_clk),                     //       clk.clk
		.reset_out  (rst_controller_reset_out_reset), // reset_out.reset
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
		.NUM_RESET_INPUTS        (3),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller_001 (
		.reset_in0  (~tx_reset_reset_n),                  // reset_in0.reset
		.reset_in1  (~rx_reset_reset_n),                  // reset_in1.reset
		.reset_in2  (~csr_reset_reset_n),                 // reset_in2.reset
		.clk        (rx_clk_clk),                         //       clk.clk
		.reset_out  (rst_controller_001_reset_out_reset), // reset_out.reset
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
		.NUM_RESET_INPUTS        (3),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller_002 (
		.reset_in0  (~tx_reset_reset_n),                  // reset_in0.reset
		.reset_in1  (~rx_reset_reset_n),                  // reset_in1.reset
		.reset_in2  (~csr_reset_reset_n),                 // reset_in2.reset
		.clk        (csr_clk_clk),                        //       clk.clk
		.reset_out  (rst_controller_002_reset_out_reset), // reset_out.reset
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

	sonic_v1_15_pcs_eth_loopback_composed_cmd_xbar_demux cmd_xbar_demux (
		.clk                (csr_clk_clk),                        //        clk.clk
		.reset              (rst_controller_002_reset_out_reset), //  clk_reset.reset
		.sink_ready         (limiter_cmd_src_ready),              //       sink.ready
		.sink_channel       (limiter_cmd_src_channel),            //           .channel
		.sink_data          (limiter_cmd_src_data),               //           .data
		.sink_startofpacket (limiter_cmd_src_startofpacket),      //           .startofpacket
		.sink_endofpacket   (limiter_cmd_src_endofpacket),        //           .endofpacket
		.sink_valid         (limiter_cmd_valid_data),             // sink_valid.data
		.src0_ready         (cmd_xbar_demux_src0_ready),          //       src0.ready
		.src0_valid         (cmd_xbar_demux_src0_valid),          //           .valid
		.src0_data          (cmd_xbar_demux_src0_data),           //           .data
		.src0_channel       (cmd_xbar_demux_src0_channel),        //           .channel
		.src0_startofpacket (cmd_xbar_demux_src0_startofpacket),  //           .startofpacket
		.src0_endofpacket   (cmd_xbar_demux_src0_endofpacket),    //           .endofpacket
		.src1_ready         (cmd_xbar_demux_src1_ready),          //       src1.ready
		.src1_valid         (cmd_xbar_demux_src1_valid),          //           .valid
		.src1_data          (cmd_xbar_demux_src1_data),           //           .data
		.src1_channel       (cmd_xbar_demux_src1_channel),        //           .channel
		.src1_startofpacket (cmd_xbar_demux_src1_startofpacket),  //           .startofpacket
		.src1_endofpacket   (cmd_xbar_demux_src1_endofpacket)     //           .endofpacket
	);

	sonic_v1_15_pcs_eth_loopback_composed_rsp_xbar_demux rsp_xbar_demux (
		.clk                (rx_clk_clk),                         //       clk.clk
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

	sonic_v1_15_pcs_eth_loopback_composed_rsp_xbar_demux rsp_xbar_demux_001 (
		.clk                (tx_clk_clk),                            //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
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

	sonic_v1_15_pcs_eth_loopback_composed_rsp_xbar_mux rsp_xbar_mux (
		.clk                 (csr_clk_clk),                        //       clk.clk
		.reset               (rst_controller_002_reset_out_reset), // clk_reset.reset
		.src_ready           (rsp_xbar_mux_src_ready),             //       src.ready
		.src_valid           (rsp_xbar_mux_src_valid),             //          .valid
		.src_data            (rsp_xbar_mux_src_data),              //          .data
		.src_channel         (rsp_xbar_mux_src_channel),           //          .channel
		.src_startofpacket   (rsp_xbar_mux_src_startofpacket),     //          .startofpacket
		.src_endofpacket     (rsp_xbar_mux_src_endofpacket),       //          .endofpacket
		.sink0_ready         (crosser_002_out_ready),              //     sink0.ready
		.sink0_valid         (crosser_002_out_valid),              //          .valid
		.sink0_channel       (crosser_002_out_channel),            //          .channel
		.sink0_data          (crosser_002_out_data),               //          .data
		.sink0_startofpacket (crosser_002_out_startofpacket),      //          .startofpacket
		.sink0_endofpacket   (crosser_002_out_endofpacket),        //          .endofpacket
		.sink1_ready         (crosser_003_out_ready),              //     sink1.ready
		.sink1_valid         (crosser_003_out_valid),              //          .valid
		.sink1_channel       (crosser_003_out_channel),            //          .channel
		.sink1_data          (crosser_003_out_data),               //          .data
		.sink1_startofpacket (crosser_003_out_startofpacket),      //          .startofpacket
		.sink1_endofpacket   (crosser_003_out_endofpacket)         //          .endofpacket
	);

	altera_avalon_st_handshake_clock_crosser #(
		.DATA_WIDTH          (59),
		.BITS_PER_SYMBOL     (59),
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
		.in_reset          (rst_controller_002_reset_out_reset), //  in_clk_reset.reset
		.out_clk           (rx_clk_clk),                         //       out_clk.clk
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
		.DATA_WIDTH          (59),
		.BITS_PER_SYMBOL     (59),
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
		.in_reset          (rst_controller_002_reset_out_reset), //  in_clk_reset.reset
		.out_clk           (tx_clk_clk),                         //       out_clk.clk
		.out_reset         (rst_controller_reset_out_reset),     // out_clk_reset.reset
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
		.DATA_WIDTH          (59),
		.BITS_PER_SYMBOL     (59),
		.USE_PACKETS         (1),
		.USE_CHANNEL         (1),
		.CHANNEL_WIDTH       (2),
		.USE_ERROR           (0),
		.ERROR_WIDTH         (1),
		.VALID_SYNC_DEPTH    (2),
		.READY_SYNC_DEPTH    (2),
		.USE_OUTPUT_PIPELINE (0)
	) crosser_002 (
		.in_clk            (rx_clk_clk),                         //        in_clk.clk
		.in_reset          (rst_controller_001_reset_out_reset), //  in_clk_reset.reset
		.out_clk           (csr_clk_clk),                        //       out_clk.clk
		.out_reset         (rst_controller_002_reset_out_reset), // out_clk_reset.reset
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
		.DATA_WIDTH          (59),
		.BITS_PER_SYMBOL     (59),
		.USE_PACKETS         (1),
		.USE_CHANNEL         (1),
		.CHANNEL_WIDTH       (2),
		.USE_ERROR           (0),
		.ERROR_WIDTH         (1),
		.VALID_SYNC_DEPTH    (2),
		.READY_SYNC_DEPTH    (2),
		.USE_OUTPUT_PIPELINE (0)
	) crosser_003 (
		.in_clk            (tx_clk_clk),                            //        in_clk.clk
		.in_reset          (rst_controller_reset_out_reset),        //  in_clk_reset.reset
		.out_clk           (csr_clk_clk),                           //       out_clk.clk
		.out_reset         (rst_controller_002_reset_out_reset),    // out_clk_reset.reset
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
