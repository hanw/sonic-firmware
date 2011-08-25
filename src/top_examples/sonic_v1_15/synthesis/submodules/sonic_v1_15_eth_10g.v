// sonic_v1_15_eth_10g.v

// This file was auto-generated from altera_eth_10g_design_example_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using SOPC Builder version 11.0 157 at 2011.07.26.17:40:50

`timescale 1 ps / 1 ps
module sonic_v1_15_eth_10g #(
		parameter device_family                = "Stratix IV",
		parameter starting_channel_number      = 0,
		parameter interface_type               = "Hard XAUI",
		parameter xaui_pll_type                = "CMU",
		parameter use_control_and_status_ports = 0,
		parameter external_pma_ctrl_reconf     = 0,
		parameter recovered_clk_out            = 0,
		parameter number_of_interfaces         = 1,
		parameter reconfig_interfaces          = 1,
		parameter use_rx_rate_match            = 0,
		parameter tx_termination               = "OCT_100_OHMS",
		parameter tx_vod_selection             = 4,
		parameter tx_preemp_pretap             = 0,
		parameter tx_preemp_pretap_inv         = 0,
		parameter tx_preemp_tap_1              = 0,
		parameter tx_preemp_tap_2              = 0,
		parameter tx_preemp_tap_2_inv          = 0,
		parameter rx_common_mode               = "0.82v",
		parameter rx_termination               = "OCT_100_OHMS",
		parameter rx_eq_dc_gain                = 0,
		parameter rx_eq_ctrl                   = 0
	) (
		input  wire        mm_clk_clk,                      //                     mm_clk.clk
		input  wire        mm_reset_reset_n,                //                   mm_reset.reset_n
		input  wire        tx_clk_clk,                      //                     tx_clk.clk
		input  wire        tx_reset_reset_n,                //                   tx_reset.reset_n
		input  wire [18:0] mm_pipeline_bridge_address,      //         mm_pipeline_bridge.address
		output wire        mm_pipeline_bridge_waitrequest,  //                           .waitrequest
		input  wire        mm_pipeline_bridge_read,         //                           .read
		output wire [31:0] mm_pipeline_bridge_readdata,     //                           .readdata
		input  wire        mm_pipeline_bridge_write,        //                           .write
		input  wire [31:0] mm_pipeline_bridge_writedata,    //                           .writedata
		input  wire        ref_clk_clk,                     //                    ref_clk.clk
		input  wire        ref_reset_reset_n,               //                  ref_reset.reset_n
		output wire        xgmii_rx_clk_clk,                //               xgmii_rx_clk.clk
		output wire        avalon_st_rxstatus_valid,        //         avalon_st_rxstatus.valid
		output wire [39:0] avalon_st_rxstatus_data,         //                           .data
		output wire [6:0]  avalon_st_rxstatus_error,        //                           .error
		output wire [1:0]  link_fault_status_xgmii_rx_data, // link_fault_status_xgmii_rx.data
		input  wire        rx_serial_data_export,           //             rx_serial_data.export
		output wire        tx_serial_data_export,           //             tx_serial_data.export
		output wire        rx_ready_export,                 //                   rx_ready.export
		output wire        tx_ready_export,                 //                   tx_ready.export
		input  wire [63:0] tx_sc_fifo_in_data,              //              tx_sc_fifo_in.data
		input  wire        tx_sc_fifo_in_valid,             //                           .valid
		output wire        tx_sc_fifo_in_ready,             //                           .ready
		input  wire        tx_sc_fifo_in_startofpacket,     //                           .startofpacket
		input  wire        tx_sc_fifo_in_endofpacket,       //                           .endofpacket
		input  wire [2:0]  tx_sc_fifo_in_empty,             //                           .empty
		input  wire        tx_sc_fifo_in_error,             //                           .error
		output wire [63:0] rx_sc_fifo_out_data,             //             rx_sc_fifo_out.data
		output wire        rx_sc_fifo_out_valid,            //                           .valid
		input  wire        rx_sc_fifo_out_ready,            //                           .ready
		output wire        rx_sc_fifo_out_startofpacket,    //                           .startofpacket
		output wire        rx_sc_fifo_out_endofpacket,      //                           .endofpacket
		output wire [2:0]  rx_sc_fifo_out_empty,            //                           .empty
		output wire [5:0]  rx_sc_fifo_out_error,            //                           .error
		input  wire        mdio_mdio_in,                    //                       mdio.mdio_in
		output wire        mdio_mdio_out,                   //                           .mdio_out
		output wire        mdio_mdc,                        //                           .mdc
		output wire        mdio_mdio_oen,                   //                           .mdio_oen
		output wire        avalon_st_txstatus_valid,        //         avalon_st_txstatus.valid
		output wire [39:0] avalon_st_txstatus_data,         //                           .data
		output wire [6:0]  avalon_st_txstatus_error         //                           .error
	);

	wire  [71:0] eth_10g_mac_xgmii_tx_data;                                                                                     // eth_10g_mac:xgmii_tx_data -> eth_loopback_composed:lb_tx_sink_data_data
	wire  [71:0] eth_loopback_composed_lb_rx_src_data_data;                                                                     // eth_loopback_composed:lb_rx_src_data_data -> eth_10g_mac:xgmii_rx_data
	wire         rx_sc_fifo_almost_full_data;                                                                                   // rx_sc_fifo:almost_full_data -> eth_fifo_pause_ctrl_adapter:data_sink_almost_full
	wire         rx_sc_fifo_almost_empty_data;                                                                                  // rx_sc_fifo:almost_empty_data -> eth_fifo_pause_ctrl_adapter:data_sink_almost_empty
	wire   [1:0] eth_fifo_pause_ctrl_adapter_avalon_streaming_source_data;                                                      // eth_fifo_pause_ctrl_adapter:pause_ctrl_src_data -> pa_pg_before_timing_adapter:in_data
	wire         pa_pg_before_timing_adapter_out_valid;                                                                         // pa_pg_before_timing_adapter:out_valid -> dc_fifo_pause_adapt_pause_gen:in_valid
	wire   [1:0] pa_pg_before_timing_adapter_out_data;                                                                          // pa_pg_before_timing_adapter:out_data -> dc_fifo_pause_adapt_pause_gen:in_data
	wire         pa_pg_before_timing_adapter_out_ready;                                                                         // dc_fifo_pause_adapt_pause_gen:in_ready -> pa_pg_before_timing_adapter:out_ready
	wire         dc_fifo_pause_adapt_pause_gen_out_valid;                                                                       // dc_fifo_pause_adapt_pause_gen:out_valid -> pa_pg_after_timing_adapter:in_valid
	wire   [1:0] dc_fifo_pause_adapt_pause_gen_out_data;                                                                        // dc_fifo_pause_adapt_pause_gen:out_data -> pa_pg_after_timing_adapter:in_data
	wire         dc_fifo_pause_adapt_pause_gen_out_ready;                                                                       // pa_pg_after_timing_adapter:in_ready -> dc_fifo_pause_adapt_pause_gen:out_ready
	wire   [1:0] pa_pg_after_timing_adapter_out_data;                                                                           // pa_pg_after_timing_adapter:out_data -> eth_10g_mac:avalon_st_pause_data
	wire  [71:0] altera_10gbaser_xgmii_rx_dc_0_data;                                                                            // altera_10gbaser:xgmii_rx_dc_0 -> eth_loopback_composed:lb_rx_sink_data_data
	wire  [71:0] eth_loopback_composed_lb_tx_src_data_data;                                                                     // eth_loopback_composed:lb_tx_src_data_data -> altera_10gbaser:xgmii_tx_dc_0
	wire         tx_sc_fifo_out_endofpacket;                                                                                    // tx_sc_fifo:out_endofpacket -> eth_10g_mac:avalon_st_tx_endofpacket
	wire         tx_sc_fifo_out_valid;                                                                                          // tx_sc_fifo:out_valid -> eth_10g_mac:avalon_st_tx_valid
	wire         tx_sc_fifo_out_startofpacket;                                                                                  // tx_sc_fifo:out_startofpacket -> eth_10g_mac:avalon_st_tx_startofpacket
	wire         tx_sc_fifo_out_error;                                                                                          // tx_sc_fifo:out_error -> eth_10g_mac:avalon_st_tx_error
	wire   [2:0] tx_sc_fifo_out_empty;                                                                                          // tx_sc_fifo:out_empty -> eth_10g_mac:avalon_st_tx_empty
	wire  [63:0] tx_sc_fifo_out_data;                                                                                           // tx_sc_fifo:out_data -> eth_10g_mac:avalon_st_tx_data
	wire         tx_sc_fifo_out_ready;                                                                                          // eth_10g_mac:avalon_st_tx_ready -> tx_sc_fifo:out_ready
	wire         eth_10g_mac_avalon_st_rx_endofpacket;                                                                          // eth_10g_mac:avalon_st_rx_endofpacket -> rx_sc_fifo:in_endofpacket
	wire         eth_10g_mac_avalon_st_rx_valid;                                                                                // eth_10g_mac:avalon_st_rx_valid -> rx_sc_fifo:in_valid
	wire         eth_10g_mac_avalon_st_rx_startofpacket;                                                                        // eth_10g_mac:avalon_st_rx_startofpacket -> rx_sc_fifo:in_startofpacket
	wire   [5:0] eth_10g_mac_avalon_st_rx_error;                                                                                // eth_10g_mac:avalon_st_rx_error -> rx_sc_fifo:in_error
	wire   [2:0] eth_10g_mac_avalon_st_rx_empty;                                                                                // eth_10g_mac:avalon_st_rx_empty -> rx_sc_fifo:in_empty
	wire  [63:0] eth_10g_mac_avalon_st_rx_data;                                                                                 // eth_10g_mac:avalon_st_rx_data -> rx_sc_fifo:in_data
	wire         eth_10g_mac_avalon_st_rx_ready;                                                                                // rx_sc_fifo:in_ready -> eth_10g_mac:avalon_st_rx_ready
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_waitrequest;                                                 // altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_waitrequest -> altera_avalon_mm_bridge:uav_waitrequest
	wire   [2:0] altera_avalon_mm_bridge_avalon_universal_master_0_burstcount;                                                  // altera_avalon_mm_bridge:uav_burstcount -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_burstcount
	wire  [31:0] altera_avalon_mm_bridge_avalon_universal_master_0_writedata;                                                   // altera_avalon_mm_bridge:uav_writedata -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_writedata
	wire  [31:0] altera_avalon_mm_bridge_avalon_universal_master_0_address;                                                     // altera_avalon_mm_bridge:uav_address -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_address
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_lock;                                                        // altera_avalon_mm_bridge:uav_lock -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_lock
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_write;                                                       // altera_avalon_mm_bridge:uav_write -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_write
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_read;                                                        // altera_avalon_mm_bridge:uav_read -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_read
	wire  [31:0] altera_avalon_mm_bridge_avalon_universal_master_0_readdata;                                                    // altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_readdata -> altera_avalon_mm_bridge:uav_readdata
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_debugaccess;                                                 // altera_avalon_mm_bridge:uav_debugaccess -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_debugaccess
	wire   [3:0] altera_avalon_mm_bridge_avalon_universal_master_0_byteenable;                                                  // altera_avalon_mm_bridge:uav_byteenable -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_byteenable
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_readdatavalid;                                               // altera_avalon_mm_bridge_avalon_universal_master_0_translator:av_readdatavalid -> altera_avalon_mm_bridge:uav_readdatavalid
	wire         altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_waitrequest;                                           // altera_10gbaser:phy_mgmt_waitrequest -> altera_10gbaser_phy_mgmt_translator:av_waitrequest
	wire  [31:0] altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_writedata;                                             // altera_10gbaser_phy_mgmt_translator:av_writedata -> altera_10gbaser:phy_mgmt_writedata
	wire   [8:0] altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_address;                                               // altera_10gbaser_phy_mgmt_translator:av_address -> altera_10gbaser:phy_mgmt_address
	wire         altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_write;                                                 // altera_10gbaser_phy_mgmt_translator:av_write -> altera_10gbaser:phy_mgmt_write
	wire         altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_read;                                                  // altera_10gbaser_phy_mgmt_translator:av_read -> altera_10gbaser:phy_mgmt_read
	wire  [31:0] altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_readdata;                                              // altera_10gbaser:phy_mgmt_readdata -> altera_10gbaser_phy_mgmt_translator:av_readdata
	wire         eth_10g_mac_csr_translator_avalon_anti_slave_0_waitrequest;                                                    // eth_10g_mac:csr_waitrequest -> eth_10g_mac_csr_translator:av_waitrequest
	wire  [31:0] eth_10g_mac_csr_translator_avalon_anti_slave_0_writedata;                                                      // eth_10g_mac_csr_translator:av_writedata -> eth_10g_mac:csr_writedata
	wire  [12:0] eth_10g_mac_csr_translator_avalon_anti_slave_0_address;                                                        // eth_10g_mac_csr_translator:av_address -> eth_10g_mac:csr_address
	wire         eth_10g_mac_csr_translator_avalon_anti_slave_0_write;                                                          // eth_10g_mac_csr_translator:av_write -> eth_10g_mac:csr_write
	wire         eth_10g_mac_csr_translator_avalon_anti_slave_0_read;                                                           // eth_10g_mac_csr_translator:av_read -> eth_10g_mac:csr_read
	wire  [31:0] eth_10g_mac_csr_translator_avalon_anti_slave_0_readdata;                                                       // eth_10g_mac:csr_readdata -> eth_10g_mac_csr_translator:av_readdata
	wire         eth_loopback_composed_csr_translator_avalon_anti_slave_0_waitrequest;                                          // eth_loopback_composed:csr_waitrequest -> eth_loopback_composed_csr_translator:av_waitrequest
	wire  [31:0] eth_loopback_composed_csr_translator_avalon_anti_slave_0_writedata;                                            // eth_loopback_composed_csr_translator:av_writedata -> eth_loopback_composed:csr_writedata
	wire   [3:0] eth_loopback_composed_csr_translator_avalon_anti_slave_0_address;                                              // eth_loopback_composed_csr_translator:av_address -> eth_loopback_composed:csr_address
	wire         eth_loopback_composed_csr_translator_avalon_anti_slave_0_write;                                                // eth_loopback_composed_csr_translator:av_write -> eth_loopback_composed:csr_write
	wire         eth_loopback_composed_csr_translator_avalon_anti_slave_0_read;                                                 // eth_loopback_composed_csr_translator:av_read -> eth_loopback_composed:csr_read
	wire  [31:0] eth_loopback_composed_csr_translator_avalon_anti_slave_0_readdata;                                             // eth_loopback_composed:csr_readdata -> eth_loopback_composed_csr_translator:av_readdata
	wire  [31:0] tx_sc_fifo_csr_translator_avalon_anti_slave_0_writedata;                                                       // tx_sc_fifo_csr_translator:av_writedata -> tx_sc_fifo:csr_writedata
	wire   [2:0] tx_sc_fifo_csr_translator_avalon_anti_slave_0_address;                                                         // tx_sc_fifo_csr_translator:av_address -> tx_sc_fifo:csr_address
	wire         tx_sc_fifo_csr_translator_avalon_anti_slave_0_write;                                                           // tx_sc_fifo_csr_translator:av_write -> tx_sc_fifo:csr_write
	wire         tx_sc_fifo_csr_translator_avalon_anti_slave_0_read;                                                            // tx_sc_fifo_csr_translator:av_read -> tx_sc_fifo:csr_read
	wire  [31:0] tx_sc_fifo_csr_translator_avalon_anti_slave_0_readdata;                                                        // tx_sc_fifo:csr_readdata -> tx_sc_fifo_csr_translator:av_readdata
	wire  [31:0] rx_sc_fifo_csr_translator_avalon_anti_slave_0_writedata;                                                       // rx_sc_fifo_csr_translator:av_writedata -> rx_sc_fifo:csr_writedata
	wire   [2:0] rx_sc_fifo_csr_translator_avalon_anti_slave_0_address;                                                         // rx_sc_fifo_csr_translator:av_address -> rx_sc_fifo:csr_address
	wire         rx_sc_fifo_csr_translator_avalon_anti_slave_0_write;                                                           // rx_sc_fifo_csr_translator:av_write -> rx_sc_fifo:csr_write
	wire         rx_sc_fifo_csr_translator_avalon_anti_slave_0_read;                                                            // rx_sc_fifo_csr_translator:av_read -> rx_sc_fifo:csr_read
	wire  [31:0] rx_sc_fifo_csr_translator_avalon_anti_slave_0_readdata;                                                        // rx_sc_fifo:csr_readdata -> rx_sc_fifo_csr_translator:av_readdata
	wire         altera_eth_mdio_csr_translator_avalon_anti_slave_0_waitrequest;                                                // altera_eth_mdio:csr_waitrequest -> altera_eth_mdio_csr_translator:av_waitrequest
	wire  [31:0] altera_eth_mdio_csr_translator_avalon_anti_slave_0_writedata;                                                  // altera_eth_mdio_csr_translator:av_writedata -> altera_eth_mdio:csr_writedata
	wire   [5:0] altera_eth_mdio_csr_translator_avalon_anti_slave_0_address;                                                    // altera_eth_mdio_csr_translator:av_address -> altera_eth_mdio:csr_address
	wire         altera_eth_mdio_csr_translator_avalon_anti_slave_0_write;                                                      // altera_eth_mdio_csr_translator:av_write -> altera_eth_mdio:csr_write
	wire         altera_eth_mdio_csr_translator_avalon_anti_slave_0_read;                                                       // altera_eth_mdio_csr_translator:av_read -> altera_eth_mdio:csr_read
	wire  [31:0] altera_eth_mdio_csr_translator_avalon_anti_slave_0_readdata;                                                   // altera_eth_mdio:csr_readdata -> altera_eth_mdio_csr_translator:av_readdata
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_waitrequest;            // altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_waitrequest -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_waitrequest
	wire   [2:0] altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_burstcount;             // altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_burstcount -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_writedata;              // altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_writedata -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_writedata
	wire  [31:0] altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_address;                // altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_address -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_address
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_lock;                   // altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_lock -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_lock
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_write;                  // altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_write -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_write
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_read;                   // altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_read -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdata;               // altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_readdata -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_readdata
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_debugaccess;            // altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_debugaccess -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_byteenable;             // altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_byteenable -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_byteenable
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdatavalid;          // altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:av_readdatavalid -> altera_avalon_mm_bridge_avalon_universal_master_0_translator:uav_readdatavalid
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_waitrequest;                             // altera_10gbaser_phy_mgmt_translator:uav_waitrequest -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_burstcount;                              // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_burstcount -> altera_10gbaser_phy_mgmt_translator:uav_burstcount
	wire  [31:0] altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_writedata;                               // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_writedata -> altera_10gbaser_phy_mgmt_translator:uav_writedata
	wire  [31:0] altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_address;                                 // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_address -> altera_10gbaser_phy_mgmt_translator:uav_address
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_write;                                   // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_write -> altera_10gbaser_phy_mgmt_translator:uav_write
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_lock;                                    // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_lock -> altera_10gbaser_phy_mgmt_translator:uav_lock
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_read;                                    // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_read -> altera_10gbaser_phy_mgmt_translator:uav_read
	wire  [31:0] altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdata;                                // altera_10gbaser_phy_mgmt_translator:uav_readdata -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                           // altera_10gbaser_phy_mgmt_translator:uav_readdatavalid -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_debugaccess;                             // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_debugaccess -> altera_10gbaser_phy_mgmt_translator:uav_debugaccess
	wire   [3:0] altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_byteenable;                              // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_byteenable -> altera_10gbaser_phy_mgmt_translator:uav_byteenable
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                      // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_valid;                            // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_source_valid -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                    // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [87:0] altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_data;                             // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_source_data -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_ready;                            // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                   // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                         // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                 // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [87:0] altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                          // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                         // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_sink_ready -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                       // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                        // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                       // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                      // eth_10g_mac_csr_translator:uav_waitrequest -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                       // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> eth_10g_mac_csr_translator:uav_burstcount
	wire  [31:0] eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                        // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> eth_10g_mac_csr_translator:uav_writedata
	wire  [31:0] eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_address;                                          // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_address -> eth_10g_mac_csr_translator:uav_address
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_write;                                            // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_write -> eth_10g_mac_csr_translator:uav_write
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                             // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_lock -> eth_10g_mac_csr_translator:uav_lock
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_read;                                             // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_read -> eth_10g_mac_csr_translator:uav_read
	wire  [31:0] eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                         // eth_10g_mac_csr_translator:uav_readdata -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                    // eth_10g_mac_csr_translator:uav_readdatavalid -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                      // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> eth_10g_mac_csr_translator:uav_debugaccess
	wire   [3:0] eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                       // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> eth_10g_mac_csr_translator:uav_byteenable
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                               // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                                     // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                             // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [87:0] eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                      // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                                     // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                            // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                                  // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                          // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [87:0] eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                                   // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                                  // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                                // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                                 // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                                // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                            // eth_loopback_composed_csr_translator:uav_waitrequest -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                             // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> eth_loopback_composed_csr_translator:uav_burstcount
	wire  [31:0] eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                              // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> eth_loopback_composed_csr_translator:uav_writedata
	wire  [31:0] eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_address;                                // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_address -> eth_loopback_composed_csr_translator:uav_address
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_write;                                  // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_write -> eth_loopback_composed_csr_translator:uav_write
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                   // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_lock -> eth_loopback_composed_csr_translator:uav_lock
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_read;                                   // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_read -> eth_loopback_composed_csr_translator:uav_read
	wire  [31:0] eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                               // eth_loopback_composed_csr_translator:uav_readdata -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                          // eth_loopback_composed_csr_translator:uav_readdatavalid -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                            // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> eth_loopback_composed_csr_translator:uav_debugaccess
	wire   [3:0] eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                             // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> eth_loopback_composed_csr_translator:uav_byteenable
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                     // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                           // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                   // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [87:0] eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                            // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                           // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                  // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                        // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [87:0] eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                         // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                        // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                      // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                       // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                      // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                       // tx_sc_fifo_csr_translator:uav_waitrequest -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                        // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> tx_sc_fifo_csr_translator:uav_burstcount
	wire  [31:0] tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                         // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> tx_sc_fifo_csr_translator:uav_writedata
	wire  [31:0] tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_address;                                           // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_address -> tx_sc_fifo_csr_translator:uav_address
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_write;                                             // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_write -> tx_sc_fifo_csr_translator:uav_write
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                              // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_lock -> tx_sc_fifo_csr_translator:uav_lock
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_read;                                              // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_read -> tx_sc_fifo_csr_translator:uav_read
	wire  [31:0] tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                          // tx_sc_fifo_csr_translator:uav_readdata -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                     // tx_sc_fifo_csr_translator:uav_readdatavalid -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                       // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> tx_sc_fifo_csr_translator:uav_debugaccess
	wire   [3:0] tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                        // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> tx_sc_fifo_csr_translator:uav_byteenable
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                                // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                                      // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                              // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [87:0] tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                       // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                                      // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                             // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                                   // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                           // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [87:0] tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                                    // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                                   // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                                 // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:in_valid
	wire  [31:0] tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                                  // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:in_data
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                                 // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:in_ready -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid;                                 // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:out_valid -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data;                                  // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:out_data -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready;                                 // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:out_ready
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                       // rx_sc_fifo_csr_translator:uav_waitrequest -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                        // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> rx_sc_fifo_csr_translator:uav_burstcount
	wire  [31:0] rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                         // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> rx_sc_fifo_csr_translator:uav_writedata
	wire  [31:0] rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_address;                                           // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_address -> rx_sc_fifo_csr_translator:uav_address
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_write;                                             // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_write -> rx_sc_fifo_csr_translator:uav_write
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                              // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_lock -> rx_sc_fifo_csr_translator:uav_lock
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_read;                                              // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_read -> rx_sc_fifo_csr_translator:uav_read
	wire  [31:0] rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                          // rx_sc_fifo_csr_translator:uav_readdata -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                     // rx_sc_fifo_csr_translator:uav_readdatavalid -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                       // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> rx_sc_fifo_csr_translator:uav_debugaccess
	wire   [3:0] rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                        // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> rx_sc_fifo_csr_translator:uav_byteenable
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                                // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                                      // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                              // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [87:0] rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                       // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                                      // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                             // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                                   // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                           // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [87:0] rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                                    // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                                   // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                                 // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:in_valid
	wire  [31:0] rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                                  // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:in_data
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                                 // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:in_ready -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid;                                 // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:out_valid -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data;                                  // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:out_data -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready;                                 // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:out_ready
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                                  // altera_eth_mdio_csr_translator:uav_waitrequest -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                                   // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> altera_eth_mdio_csr_translator:uav_burstcount
	wire  [31:0] altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                                    // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> altera_eth_mdio_csr_translator:uav_writedata
	wire  [31:0] altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_address;                                      // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_address -> altera_eth_mdio_csr_translator:uav_address
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_write;                                        // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_write -> altera_eth_mdio_csr_translator:uav_write
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_lock;                                         // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_lock -> altera_eth_mdio_csr_translator:uav_lock
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_read;                                         // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_read -> altera_eth_mdio_csr_translator:uav_read
	wire  [31:0] altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                                     // altera_eth_mdio_csr_translator:uav_readdata -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                                // altera_eth_mdio_csr_translator:uav_readdatavalid -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                                  // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> altera_eth_mdio_csr_translator:uav_debugaccess
	wire   [3:0] altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                                   // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> altera_eth_mdio_csr_translator:uav_byteenable
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                           // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                                 // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                         // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [87:0] altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                                  // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                                 // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                        // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                              // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;                      // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [87:0] altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                               // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                              // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                            // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                             // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                            // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_endofpacket;   // altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router:sink_endofpacket
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_valid;         // altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_valid -> addr_router:sink_valid
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_startofpacket; // altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router:sink_startofpacket
	wire  [86:0] altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_data;          // altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_data -> addr_router:sink_data
	wire         altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_ready;         // addr_router:sink_ready -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:cp_ready
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_endofpacket;                             // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router:sink_endofpacket
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_valid;                                   // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rp_valid -> id_router:sink_valid
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_startofpacket;                           // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router:sink_startofpacket
	wire  [86:0] altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_data;                                    // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rp_data -> id_router:sink_data
	wire         altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_ready;                                   // id_router:sink_ready -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:rp_ready
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                      // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_001:sink_endofpacket
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                            // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_001:sink_valid
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                    // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_001:sink_startofpacket
	wire  [86:0] eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_data;                                             // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_001:sink_data
	wire         eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                            // id_router_001:sink_ready -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                            // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_002:sink_endofpacket
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                  // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_002:sink_valid
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                          // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_002:sink_startofpacket
	wire  [86:0] eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_data;                                   // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_002:sink_data
	wire         eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                  // id_router_002:sink_ready -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                       // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_003:sink_endofpacket
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                             // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_003:sink_valid
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                     // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_003:sink_startofpacket
	wire  [86:0] tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_data;                                              // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_003:sink_data
	wire         tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                             // id_router_003:sink_ready -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                       // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_004:sink_endofpacket
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                             // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_004:sink_valid
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                     // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_004:sink_startofpacket
	wire  [86:0] rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_data;                                              // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_004:sink_data
	wire         rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                             // id_router_004:sink_ready -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                                  // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_005:sink_endofpacket
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_valid;                                        // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_005:sink_valid
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                                // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_005:sink_startofpacket
	wire  [86:0] altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_data;                                         // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router_005:sink_data
	wire         altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_ready;                                        // id_router_005:sink_ready -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         addr_router_src_endofpacket;                                                                                   // addr_router:src_endofpacket -> limiter:cmd_sink_endofpacket
	wire         addr_router_src_valid;                                                                                         // addr_router:src_valid -> limiter:cmd_sink_valid
	wire         addr_router_src_startofpacket;                                                                                 // addr_router:src_startofpacket -> limiter:cmd_sink_startofpacket
	wire  [86:0] addr_router_src_data;                                                                                          // addr_router:src_data -> limiter:cmd_sink_data
	wire   [5:0] addr_router_src_channel;                                                                                       // addr_router:src_channel -> limiter:cmd_sink_channel
	wire         addr_router_src_ready;                                                                                         // limiter:cmd_sink_ready -> addr_router:src_ready
	wire         limiter_rsp_src_endofpacket;                                                                                   // limiter:rsp_src_endofpacket -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_rsp_src_valid;                                                                                         // limiter:rsp_src_valid -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_rsp_src_startofpacket;                                                                                 // limiter:rsp_src_startofpacket -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [86:0] limiter_rsp_src_data;                                                                                          // limiter:rsp_src_data -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_data
	wire   [5:0] limiter_rsp_src_channel;                                                                                       // limiter:rsp_src_channel -> altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_rsp_src_ready;                                                                                         // altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:rp_ready -> limiter:rsp_src_ready
	wire         rst_controller_reset_out_reset;                                                                                // rst_controller:reset_out -> [addr_router:reset, altera_10gbaser:phy_mgmt_clk_reset, altera_10gbaser_phy_mgmt_translator:reset, altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:reset, altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, altera_avalon_mm_bridge:reset, altera_avalon_mm_bridge_avalon_universal_master_0_translator:reset, altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent:reset, altera_eth_mdio:reset, altera_eth_mdio_csr_translator:reset, altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:reset, altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, cmd_xbar_demux:reset, crosser:in_reset, crosser_001:in_reset, crosser_002:out_reset, crosser_003:out_reset, eth_10g_mac_csr_translator:reset, eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:reset, eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, id_router:reset, id_router_001:reset, id_router_005:reset, limiter:reset, rsp_xbar_demux:reset, rsp_xbar_demux_001:reset, rsp_xbar_demux_005:reset, rsp_xbar_mux:reset]
	wire         rst_controller_001_reset_out_reset;                                                                            // rst_controller_001:reset_out -> [crosser:out_reset, crosser_002:in_reset, dc_fifo_pause_adapt_pause_gen:out_reset_n, id_router_003:reset, pa_pg_after_timing_adapter:reset_n, rsp_xbar_demux_003:reset, tx_sc_fifo:reset, tx_sc_fifo_csr_translator:reset, tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:reset, tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:reset, tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset]
	wire         rst_controller_002_reset_out_reset;                                                                            // rst_controller_002:reset_out -> [crosser_001:out_reset, crosser_003:in_reset, dc_fifo_pause_adapt_pause_gen:in_reset_n, eth_fifo_pause_ctrl_adapter:reset, id_router_004:reset, pa_pg_before_timing_adapter:reset_n, rsp_xbar_demux_004:reset, rx_sc_fifo:reset, rx_sc_fifo_csr_translator:reset, rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:reset, rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo:reset, rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset]
	wire         rst_controller_003_reset_out_reset;                                                                            // rst_controller_003:reset_out -> [eth_loopback_composed_csr_translator:reset, eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:reset, eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, id_router_002:reset, rsp_xbar_demux_002:reset]
	wire         cmd_xbar_demux_src0_endofpacket;                                                                               // cmd_xbar_demux:src0_endofpacket -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_src0_valid;                                                                                     // cmd_xbar_demux:src0_valid -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_src0_startofpacket;                                                                             // cmd_xbar_demux:src0_startofpacket -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [86:0] cmd_xbar_demux_src0_data;                                                                                      // cmd_xbar_demux:src0_data -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_data
	wire   [5:0] cmd_xbar_demux_src0_channel;                                                                                   // cmd_xbar_demux:src0_channel -> altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_src1_endofpacket;                                                                               // cmd_xbar_demux:src1_endofpacket -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_src1_valid;                                                                                     // cmd_xbar_demux:src1_valid -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_src1_startofpacket;                                                                             // cmd_xbar_demux:src1_startofpacket -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [86:0] cmd_xbar_demux_src1_data;                                                                                      // cmd_xbar_demux:src1_data -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [5:0] cmd_xbar_demux_src1_channel;                                                                                   // cmd_xbar_demux:src1_channel -> eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_src2_endofpacket;                                                                               // cmd_xbar_demux:src2_endofpacket -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_src2_valid;                                                                                     // cmd_xbar_demux:src2_valid -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_src2_startofpacket;                                                                             // cmd_xbar_demux:src2_startofpacket -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [86:0] cmd_xbar_demux_src2_data;                                                                                      // cmd_xbar_demux:src2_data -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [5:0] cmd_xbar_demux_src2_channel;                                                                                   // cmd_xbar_demux:src2_channel -> eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_src5_endofpacket;                                                                               // cmd_xbar_demux:src5_endofpacket -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_src5_valid;                                                                                     // cmd_xbar_demux:src5_valid -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_src5_startofpacket;                                                                             // cmd_xbar_demux:src5_startofpacket -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [86:0] cmd_xbar_demux_src5_data;                                                                                      // cmd_xbar_demux:src5_data -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [5:0] cmd_xbar_demux_src5_channel;                                                                                   // cmd_xbar_demux:src5_channel -> altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         rsp_xbar_demux_src0_endofpacket;                                                                               // rsp_xbar_demux:src0_endofpacket -> rsp_xbar_mux:sink0_endofpacket
	wire         rsp_xbar_demux_src0_valid;                                                                                     // rsp_xbar_demux:src0_valid -> rsp_xbar_mux:sink0_valid
	wire         rsp_xbar_demux_src0_startofpacket;                                                                             // rsp_xbar_demux:src0_startofpacket -> rsp_xbar_mux:sink0_startofpacket
	wire  [86:0] rsp_xbar_demux_src0_data;                                                                                      // rsp_xbar_demux:src0_data -> rsp_xbar_mux:sink0_data
	wire   [5:0] rsp_xbar_demux_src0_channel;                                                                                   // rsp_xbar_demux:src0_channel -> rsp_xbar_mux:sink0_channel
	wire         rsp_xbar_demux_src0_ready;                                                                                     // rsp_xbar_mux:sink0_ready -> rsp_xbar_demux:src0_ready
	wire         rsp_xbar_demux_001_src0_endofpacket;                                                                           // rsp_xbar_demux_001:src0_endofpacket -> rsp_xbar_mux:sink1_endofpacket
	wire         rsp_xbar_demux_001_src0_valid;                                                                                 // rsp_xbar_demux_001:src0_valid -> rsp_xbar_mux:sink1_valid
	wire         rsp_xbar_demux_001_src0_startofpacket;                                                                         // rsp_xbar_demux_001:src0_startofpacket -> rsp_xbar_mux:sink1_startofpacket
	wire  [86:0] rsp_xbar_demux_001_src0_data;                                                                                  // rsp_xbar_demux_001:src0_data -> rsp_xbar_mux:sink1_data
	wire   [5:0] rsp_xbar_demux_001_src0_channel;                                                                               // rsp_xbar_demux_001:src0_channel -> rsp_xbar_mux:sink1_channel
	wire         rsp_xbar_demux_001_src0_ready;                                                                                 // rsp_xbar_mux:sink1_ready -> rsp_xbar_demux_001:src0_ready
	wire         rsp_xbar_demux_002_src0_endofpacket;                                                                           // rsp_xbar_demux_002:src0_endofpacket -> rsp_xbar_mux:sink2_endofpacket
	wire         rsp_xbar_demux_002_src0_valid;                                                                                 // rsp_xbar_demux_002:src0_valid -> rsp_xbar_mux:sink2_valid
	wire         rsp_xbar_demux_002_src0_startofpacket;                                                                         // rsp_xbar_demux_002:src0_startofpacket -> rsp_xbar_mux:sink2_startofpacket
	wire  [86:0] rsp_xbar_demux_002_src0_data;                                                                                  // rsp_xbar_demux_002:src0_data -> rsp_xbar_mux:sink2_data
	wire   [5:0] rsp_xbar_demux_002_src0_channel;                                                                               // rsp_xbar_demux_002:src0_channel -> rsp_xbar_mux:sink2_channel
	wire         rsp_xbar_demux_002_src0_ready;                                                                                 // rsp_xbar_mux:sink2_ready -> rsp_xbar_demux_002:src0_ready
	wire         rsp_xbar_demux_005_src0_endofpacket;                                                                           // rsp_xbar_demux_005:src0_endofpacket -> rsp_xbar_mux:sink5_endofpacket
	wire         rsp_xbar_demux_005_src0_valid;                                                                                 // rsp_xbar_demux_005:src0_valid -> rsp_xbar_mux:sink5_valid
	wire         rsp_xbar_demux_005_src0_startofpacket;                                                                         // rsp_xbar_demux_005:src0_startofpacket -> rsp_xbar_mux:sink5_startofpacket
	wire  [86:0] rsp_xbar_demux_005_src0_data;                                                                                  // rsp_xbar_demux_005:src0_data -> rsp_xbar_mux:sink5_data
	wire   [5:0] rsp_xbar_demux_005_src0_channel;                                                                               // rsp_xbar_demux_005:src0_channel -> rsp_xbar_mux:sink5_channel
	wire         rsp_xbar_demux_005_src0_ready;                                                                                 // rsp_xbar_mux:sink5_ready -> rsp_xbar_demux_005:src0_ready
	wire         limiter_cmd_src_endofpacket;                                                                                   // limiter:cmd_src_endofpacket -> cmd_xbar_demux:sink_endofpacket
	wire         limiter_cmd_src_startofpacket;                                                                                 // limiter:cmd_src_startofpacket -> cmd_xbar_demux:sink_startofpacket
	wire  [86:0] limiter_cmd_src_data;                                                                                          // limiter:cmd_src_data -> cmd_xbar_demux:sink_data
	wire   [5:0] limiter_cmd_src_channel;                                                                                       // limiter:cmd_src_channel -> cmd_xbar_demux:sink_channel
	wire         limiter_cmd_src_ready;                                                                                         // cmd_xbar_demux:sink_ready -> limiter:cmd_src_ready
	wire         rsp_xbar_mux_src_endofpacket;                                                                                  // rsp_xbar_mux:src_endofpacket -> limiter:rsp_sink_endofpacket
	wire         rsp_xbar_mux_src_valid;                                                                                        // rsp_xbar_mux:src_valid -> limiter:rsp_sink_valid
	wire         rsp_xbar_mux_src_startofpacket;                                                                                // rsp_xbar_mux:src_startofpacket -> limiter:rsp_sink_startofpacket
	wire  [86:0] rsp_xbar_mux_src_data;                                                                                         // rsp_xbar_mux:src_data -> limiter:rsp_sink_data
	wire   [5:0] rsp_xbar_mux_src_channel;                                                                                      // rsp_xbar_mux:src_channel -> limiter:rsp_sink_channel
	wire         rsp_xbar_mux_src_ready;                                                                                        // limiter:rsp_sink_ready -> rsp_xbar_mux:src_ready
	wire         cmd_xbar_demux_src0_ready;                                                                                     // altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux:src0_ready
	wire         id_router_src_endofpacket;                                                                                     // id_router:src_endofpacket -> rsp_xbar_demux:sink_endofpacket
	wire         id_router_src_valid;                                                                                           // id_router:src_valid -> rsp_xbar_demux:sink_valid
	wire         id_router_src_startofpacket;                                                                                   // id_router:src_startofpacket -> rsp_xbar_demux:sink_startofpacket
	wire  [86:0] id_router_src_data;                                                                                            // id_router:src_data -> rsp_xbar_demux:sink_data
	wire   [5:0] id_router_src_channel;                                                                                         // id_router:src_channel -> rsp_xbar_demux:sink_channel
	wire         id_router_src_ready;                                                                                           // rsp_xbar_demux:sink_ready -> id_router:src_ready
	wire         cmd_xbar_demux_src1_ready;                                                                                     // eth_10g_mac_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux:src1_ready
	wire         id_router_001_src_endofpacket;                                                                                 // id_router_001:src_endofpacket -> rsp_xbar_demux_001:sink_endofpacket
	wire         id_router_001_src_valid;                                                                                       // id_router_001:src_valid -> rsp_xbar_demux_001:sink_valid
	wire         id_router_001_src_startofpacket;                                                                               // id_router_001:src_startofpacket -> rsp_xbar_demux_001:sink_startofpacket
	wire  [86:0] id_router_001_src_data;                                                                                        // id_router_001:src_data -> rsp_xbar_demux_001:sink_data
	wire   [5:0] id_router_001_src_channel;                                                                                     // id_router_001:src_channel -> rsp_xbar_demux_001:sink_channel
	wire         id_router_001_src_ready;                                                                                       // rsp_xbar_demux_001:sink_ready -> id_router_001:src_ready
	wire         cmd_xbar_demux_src2_ready;                                                                                     // eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux:src2_ready
	wire         id_router_002_src_endofpacket;                                                                                 // id_router_002:src_endofpacket -> rsp_xbar_demux_002:sink_endofpacket
	wire         id_router_002_src_valid;                                                                                       // id_router_002:src_valid -> rsp_xbar_demux_002:sink_valid
	wire         id_router_002_src_startofpacket;                                                                               // id_router_002:src_startofpacket -> rsp_xbar_demux_002:sink_startofpacket
	wire  [86:0] id_router_002_src_data;                                                                                        // id_router_002:src_data -> rsp_xbar_demux_002:sink_data
	wire   [5:0] id_router_002_src_channel;                                                                                     // id_router_002:src_channel -> rsp_xbar_demux_002:sink_channel
	wire         id_router_002_src_ready;                                                                                       // rsp_xbar_demux_002:sink_ready -> id_router_002:src_ready
	wire         crosser_out_ready;                                                                                             // tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_ready -> crosser:out_ready
	wire         id_router_003_src_endofpacket;                                                                                 // id_router_003:src_endofpacket -> rsp_xbar_demux_003:sink_endofpacket
	wire         id_router_003_src_valid;                                                                                       // id_router_003:src_valid -> rsp_xbar_demux_003:sink_valid
	wire         id_router_003_src_startofpacket;                                                                               // id_router_003:src_startofpacket -> rsp_xbar_demux_003:sink_startofpacket
	wire  [86:0] id_router_003_src_data;                                                                                        // id_router_003:src_data -> rsp_xbar_demux_003:sink_data
	wire   [5:0] id_router_003_src_channel;                                                                                     // id_router_003:src_channel -> rsp_xbar_demux_003:sink_channel
	wire         id_router_003_src_ready;                                                                                       // rsp_xbar_demux_003:sink_ready -> id_router_003:src_ready
	wire         crosser_001_out_ready;                                                                                         // rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_ready -> crosser_001:out_ready
	wire         id_router_004_src_endofpacket;                                                                                 // id_router_004:src_endofpacket -> rsp_xbar_demux_004:sink_endofpacket
	wire         id_router_004_src_valid;                                                                                       // id_router_004:src_valid -> rsp_xbar_demux_004:sink_valid
	wire         id_router_004_src_startofpacket;                                                                               // id_router_004:src_startofpacket -> rsp_xbar_demux_004:sink_startofpacket
	wire  [86:0] id_router_004_src_data;                                                                                        // id_router_004:src_data -> rsp_xbar_demux_004:sink_data
	wire   [5:0] id_router_004_src_channel;                                                                                     // id_router_004:src_channel -> rsp_xbar_demux_004:sink_channel
	wire         id_router_004_src_ready;                                                                                       // rsp_xbar_demux_004:sink_ready -> id_router_004:src_ready
	wire         cmd_xbar_demux_src5_ready;                                                                                     // altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux:src5_ready
	wire         id_router_005_src_endofpacket;                                                                                 // id_router_005:src_endofpacket -> rsp_xbar_demux_005:sink_endofpacket
	wire         id_router_005_src_valid;                                                                                       // id_router_005:src_valid -> rsp_xbar_demux_005:sink_valid
	wire         id_router_005_src_startofpacket;                                                                               // id_router_005:src_startofpacket -> rsp_xbar_demux_005:sink_startofpacket
	wire  [86:0] id_router_005_src_data;                                                                                        // id_router_005:src_data -> rsp_xbar_demux_005:sink_data
	wire   [5:0] id_router_005_src_channel;                                                                                     // id_router_005:src_channel -> rsp_xbar_demux_005:sink_channel
	wire         id_router_005_src_ready;                                                                                       // rsp_xbar_demux_005:sink_ready -> id_router_005:src_ready
	wire         crosser_out_endofpacket;                                                                                       // crosser:out_endofpacket -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         crosser_out_valid;                                                                                             // crosser:out_valid -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         crosser_out_startofpacket;                                                                                     // crosser:out_startofpacket -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [86:0] crosser_out_data;                                                                                              // crosser:out_data -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [5:0] crosser_out_channel;                                                                                           // crosser:out_channel -> tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_src3_endofpacket;                                                                               // cmd_xbar_demux:src3_endofpacket -> crosser:in_endofpacket
	wire         cmd_xbar_demux_src3_valid;                                                                                     // cmd_xbar_demux:src3_valid -> crosser:in_valid
	wire         cmd_xbar_demux_src3_startofpacket;                                                                             // cmd_xbar_demux:src3_startofpacket -> crosser:in_startofpacket
	wire  [86:0] cmd_xbar_demux_src3_data;                                                                                      // cmd_xbar_demux:src3_data -> crosser:in_data
	wire   [5:0] cmd_xbar_demux_src3_channel;                                                                                   // cmd_xbar_demux:src3_channel -> crosser:in_channel
	wire         cmd_xbar_demux_src3_ready;                                                                                     // crosser:in_ready -> cmd_xbar_demux:src3_ready
	wire         crosser_001_out_endofpacket;                                                                                   // crosser_001:out_endofpacket -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         crosser_001_out_valid;                                                                                         // crosser_001:out_valid -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         crosser_001_out_startofpacket;                                                                                 // crosser_001:out_startofpacket -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [86:0] crosser_001_out_data;                                                                                          // crosser_001:out_data -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [5:0] crosser_001_out_channel;                                                                                       // crosser_001:out_channel -> rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_src4_endofpacket;                                                                               // cmd_xbar_demux:src4_endofpacket -> crosser_001:in_endofpacket
	wire         cmd_xbar_demux_src4_valid;                                                                                     // cmd_xbar_demux:src4_valid -> crosser_001:in_valid
	wire         cmd_xbar_demux_src4_startofpacket;                                                                             // cmd_xbar_demux:src4_startofpacket -> crosser_001:in_startofpacket
	wire  [86:0] cmd_xbar_demux_src4_data;                                                                                      // cmd_xbar_demux:src4_data -> crosser_001:in_data
	wire   [5:0] cmd_xbar_demux_src4_channel;                                                                                   // cmd_xbar_demux:src4_channel -> crosser_001:in_channel
	wire         cmd_xbar_demux_src4_ready;                                                                                     // crosser_001:in_ready -> cmd_xbar_demux:src4_ready
	wire         crosser_002_out_endofpacket;                                                                                   // crosser_002:out_endofpacket -> rsp_xbar_mux:sink3_endofpacket
	wire         crosser_002_out_valid;                                                                                         // crosser_002:out_valid -> rsp_xbar_mux:sink3_valid
	wire         crosser_002_out_startofpacket;                                                                                 // crosser_002:out_startofpacket -> rsp_xbar_mux:sink3_startofpacket
	wire  [86:0] crosser_002_out_data;                                                                                          // crosser_002:out_data -> rsp_xbar_mux:sink3_data
	wire   [5:0] crosser_002_out_channel;                                                                                       // crosser_002:out_channel -> rsp_xbar_mux:sink3_channel
	wire         crosser_002_out_ready;                                                                                         // rsp_xbar_mux:sink3_ready -> crosser_002:out_ready
	wire         rsp_xbar_demux_003_src0_endofpacket;                                                                           // rsp_xbar_demux_003:src0_endofpacket -> crosser_002:in_endofpacket
	wire         rsp_xbar_demux_003_src0_valid;                                                                                 // rsp_xbar_demux_003:src0_valid -> crosser_002:in_valid
	wire         rsp_xbar_demux_003_src0_startofpacket;                                                                         // rsp_xbar_demux_003:src0_startofpacket -> crosser_002:in_startofpacket
	wire  [86:0] rsp_xbar_demux_003_src0_data;                                                                                  // rsp_xbar_demux_003:src0_data -> crosser_002:in_data
	wire   [5:0] rsp_xbar_demux_003_src0_channel;                                                                               // rsp_xbar_demux_003:src0_channel -> crosser_002:in_channel
	wire         rsp_xbar_demux_003_src0_ready;                                                                                 // crosser_002:in_ready -> rsp_xbar_demux_003:src0_ready
	wire         crosser_003_out_endofpacket;                                                                                   // crosser_003:out_endofpacket -> rsp_xbar_mux:sink4_endofpacket
	wire         crosser_003_out_valid;                                                                                         // crosser_003:out_valid -> rsp_xbar_mux:sink4_valid
	wire         crosser_003_out_startofpacket;                                                                                 // crosser_003:out_startofpacket -> rsp_xbar_mux:sink4_startofpacket
	wire  [86:0] crosser_003_out_data;                                                                                          // crosser_003:out_data -> rsp_xbar_mux:sink4_data
	wire   [5:0] crosser_003_out_channel;                                                                                       // crosser_003:out_channel -> rsp_xbar_mux:sink4_channel
	wire         crosser_003_out_ready;                                                                                         // rsp_xbar_mux:sink4_ready -> crosser_003:out_ready
	wire         rsp_xbar_demux_004_src0_endofpacket;                                                                           // rsp_xbar_demux_004:src0_endofpacket -> crosser_003:in_endofpacket
	wire         rsp_xbar_demux_004_src0_valid;                                                                                 // rsp_xbar_demux_004:src0_valid -> crosser_003:in_valid
	wire         rsp_xbar_demux_004_src0_startofpacket;                                                                         // rsp_xbar_demux_004:src0_startofpacket -> crosser_003:in_startofpacket
	wire  [86:0] rsp_xbar_demux_004_src0_data;                                                                                  // rsp_xbar_demux_004:src0_data -> crosser_003:in_data
	wire   [5:0] rsp_xbar_demux_004_src0_channel;                                                                               // rsp_xbar_demux_004:src0_channel -> crosser_003:in_channel
	wire         rsp_xbar_demux_004_src0_ready;                                                                                 // crosser_003:in_ready -> rsp_xbar_demux_004:src0_ready
	wire   [5:0] limiter_cmd_valid_data;                                                                                        // limiter:cmd_src_valid -> cmd_xbar_demux:sink_valid
	wire   [0:0] altera_10gbaser_tx_serial_data;                                                                                // port fragment
	wire  [71:0] altera_10gbaser_xgmii_rx_dc;                                                                                   // port fragment

	generate
		// If any of the display statements (or deliberately broken
		// instantiations) within this generate block triggers then this module
		// has been instantiated this module with a set of parameters different
		// from those it was generated for.  This will usually result in a
		// non-functioning system.
		if (device_family != "Stratix IV")
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					device_family_check ( .error(1'b1) );
		end
		if (starting_channel_number != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					starting_channel_number_check ( .error(1'b1) );
		end
		if (interface_type != "Hard XAUI")
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					interface_type_check ( .error(1'b1) );
		end
		if (xaui_pll_type != "CMU")
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					xaui_pll_type_check ( .error(1'b1) );
		end
		if (use_control_and_status_ports != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					use_control_and_status_ports_check ( .error(1'b1) );
		end
		if (external_pma_ctrl_reconf != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					external_pma_ctrl_reconf_check ( .error(1'b1) );
		end
		if (recovered_clk_out != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					recovered_clk_out_check ( .error(1'b1) );
		end
		if (number_of_interfaces != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					number_of_interfaces_check ( .error(1'b1) );
		end
		if (reconfig_interfaces != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					reconfig_interfaces_check ( .error(1'b1) );
		end
		if (use_rx_rate_match != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					use_rx_rate_match_check ( .error(1'b1) );
		end
		if (tx_termination != "OCT_100_OHMS")
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					tx_termination_check ( .error(1'b1) );
		end
		if (tx_vod_selection != 4)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					tx_vod_selection_check ( .error(1'b1) );
		end
		if (tx_preemp_pretap != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					tx_preemp_pretap_check ( .error(1'b1) );
		end
		if (tx_preemp_pretap_inv != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					tx_preemp_pretap_inv_check ( .error(1'b1) );
		end
		if (tx_preemp_tap_1 != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					tx_preemp_tap_1_check ( .error(1'b1) );
		end
		if (tx_preemp_tap_2 != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					tx_preemp_tap_2_check ( .error(1'b1) );
		end
		if (tx_preemp_tap_2_inv != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					tx_preemp_tap_2_inv_check ( .error(1'b1) );
		end
		if (rx_common_mode != "0.82v")
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					rx_common_mode_check ( .error(1'b1) );
		end
		if (rx_termination != "OCT_100_OHMS")
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					rx_termination_check ( .error(1'b1) );
		end
		if (rx_eq_dc_gain != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					rx_eq_dc_gain_check ( .error(1'b1) );
		end
		if (rx_eq_ctrl != 0)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					rx_eq_ctrl_check ( .error(1'b1) );
		end
	endgenerate

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (19),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (3),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (32),
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
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (1),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) altera_avalon_mm_bridge (
		.clk                   (mm_clk_clk),                                                      //                       clk.clk
		.reset                 (rst_controller_reset_out_reset),                                  //                     reset.reset
		.uav_address           (altera_avalon_mm_bridge_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (altera_avalon_mm_bridge_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (altera_avalon_mm_bridge_avalon_universal_master_0_read),          //                          .read
		.uav_write             (altera_avalon_mm_bridge_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (altera_avalon_mm_bridge_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (altera_avalon_mm_bridge_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (altera_avalon_mm_bridge_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (altera_avalon_mm_bridge_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (altera_avalon_mm_bridge_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (altera_avalon_mm_bridge_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (altera_avalon_mm_bridge_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (mm_pipeline_bridge_address),                                      //      avalon_anti_master_0.address
		.av_waitrequest        (mm_pipeline_bridge_waitrequest),                                  //                          .waitrequest
		.av_read               (mm_pipeline_bridge_read),                                         //                          .read
		.av_readdata           (mm_pipeline_bridge_readdata),                                     //                          .readdata
		.av_write              (mm_pipeline_bridge_write),                                        //                          .write
		.av_writedata          (mm_pipeline_bridge_writedata),                                    //                          .writedata
		.av_burstcount         (3'b001),                                                          //               (terminated)
		.av_byteenable         (4'b1111),                                                         //               (terminated)
		.av_beginbursttransfer (1'b0),                                                            //               (terminated)
		.av_begintransfer      (1'b0),                                                            //               (terminated)
		.av_chipselect         (1'b0),                                                            //               (terminated)
		.av_readdatavalid      (),                                                                //               (terminated)
		.av_lock               (1'b0),                                                            //               (terminated)
		.av_debugaccess        (1'b0),                                                            //               (terminated)
		.uav_clken             (),                                                                //               (terminated)
		.av_clken              (1'b1)                                                             //               (terminated)
	);

	altera_xcvr_10gbaser #(
		.device_family            ("Stratix IV"),
		.num_channels             (1),
		.operation_mode           ("duplex"),
		.external_pma_ctrl_config (0),
		.control_pin_out          (0),
		.recovered_clk_out        (0),
		.ref_clk_freq             ("644.53125 MHz"),
		.starting_channel_number  (0),
		.reconfig_interfaces      (1),
		.tx_termination           ("OCT_100_OHMS"),
		.tx_vod_selection         (1),
		.tx_preemp_pretap         (0),
		.tx_preemp_pretap_inv     (0),
		.tx_preemp_tap_1          (5),
		.tx_preemp_tap_2          (0),
		.tx_preemp_tap_2_inv      (0),
		.rx_common_mode           ("0.82v"),
		.rx_termination           ("OCT_100_OHMS"),
		.rx_eq_dc_gain            (0),
		.rx_eq_ctrl               (14),
		.mgmt_clk_in_mhz          (150)
	) altera_10gbaser (
		.pll_ref_clk          (ref_clk_clk),                                                         //        pll_ref_clk.clk
		.xgmii_rx_clk         (xgmii_rx_clk_clk),                                                    //       xgmii_rx_clk.clk
		.tx_ready             (tx_ready_export),                                                     //           tx_ready.export
		.xgmii_tx_clk         (tx_clk_clk),                                                          //       xgmii_tx_clk.clk
		.rx_ready             (rx_ready_export),                                                     //           rx_ready.export
		.rx_data_ready        (),                                                                    //      rx_data_ready.export
		.xgmii_rx_dc          (altera_10gbaser_xgmii_rx_dc),                                         //      xgmii_rx_dc_0.data
		.rx_serial_data       ({rx_serial_data_export}),                                             //   rx_serial_data_0.export
		.xgmii_tx_dc          ({eth_loopback_composed_lb_tx_src_data_data[71:0]}),                   //      xgmii_tx_dc_0.data
		.tx_serial_data       (altera_10gbaser_tx_serial_data),                                      //   tx_serial_data_0.export
		.phy_mgmt_clk         (mm_clk_clk),                                                          //       phy_mgmt_clk.clk
		.phy_mgmt_clk_reset   (rst_controller_reset_out_reset),                                      // phy_mgmt_clk_reset.reset
		.phy_mgmt_address     (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_address),     //           phy_mgmt.address
		.phy_mgmt_read        (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_read),        //                   .read
		.phy_mgmt_readdata    (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_readdata),    //                   .readdata
		.phy_mgmt_write       (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_write),       //                   .write
		.phy_mgmt_writedata   (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_writedata),   //                   .writedata
		.phy_mgmt_waitrequest (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_waitrequest), //                   .waitrequest
		.rx_block_lock        (),                                                                    //        (terminated)
		.rx_hi_ber            (),                                                                    //        (terminated)
		.rx_recovered_clk     (),                                                                    //        (terminated)
		.gxb_pdn              (1'b0),                                                                //        (terminated)
		.pll_locked           (),                                                                    //        (terminated)
		.pll_pdn              (1'b0),                                                                //        (terminated)
		.cal_blk_pdn          (1'b0),                                                                //        (terminated)
		.cal_blk_clk          (1'b0),                                                                //        (terminated)
		.reconfig_to_xcvr     (4'b0000),                                                             //        (terminated)
		.reconfig_from_xcvr   ()                                                                     //        (terminated)
	);

	sonic_v1_15_eth_10g_eth_10g_mac eth_10g_mac (
		.csr_clk_clk                     (mm_clk_clk),                                                 //                    csr_clk.clk
		.csr_reset_reset_n               (mm_reset_reset_n),                                           //                  csr_reset.reset_n
		.csr_address                     (eth_10g_mac_csr_translator_avalon_anti_slave_0_address),     //                        csr.address
		.csr_waitrequest                 (eth_10g_mac_csr_translator_avalon_anti_slave_0_waitrequest), //                           .waitrequest
		.csr_read                        (eth_10g_mac_csr_translator_avalon_anti_slave_0_read),        //                           .read
		.csr_readdata                    (eth_10g_mac_csr_translator_avalon_anti_slave_0_readdata),    //                           .readdata
		.csr_write                       (eth_10g_mac_csr_translator_avalon_anti_slave_0_write),       //                           .write
		.csr_writedata                   (eth_10g_mac_csr_translator_avalon_anti_slave_0_writedata),   //                           .writedata
		.tx_clk_clk                      (tx_clk_clk),                                                 //                     tx_clk.clk
		.tx_reset_reset_n                (tx_reset_reset_n),                                           //                   tx_reset.reset_n
		.avalon_st_tx_startofpacket      (tx_sc_fifo_out_startofpacket),                               //               avalon_st_tx.startofpacket
		.avalon_st_tx_valid              (tx_sc_fifo_out_valid),                                       //                           .valid
		.avalon_st_tx_data               (tx_sc_fifo_out_data),                                        //                           .data
		.avalon_st_tx_empty              (tx_sc_fifo_out_empty),                                       //                           .empty
		.avalon_st_tx_ready              (tx_sc_fifo_out_ready),                                       //                           .ready
		.avalon_st_tx_error              (tx_sc_fifo_out_error),                                       //                           .error
		.avalon_st_tx_endofpacket        (tx_sc_fifo_out_endofpacket),                                 //                           .endofpacket
		.avalon_st_pause_data            (pa_pg_after_timing_adapter_out_data),                        //            avalon_st_pause.data
		.xgmii_tx_data                   (eth_10g_mac_xgmii_tx_data),                                  //                   xgmii_tx.data
		.avalon_st_txstatus_valid        (avalon_st_txstatus_valid),                                   //         avalon_st_txstatus.valid
		.avalon_st_txstatus_data         (avalon_st_txstatus_data),                                    //                           .data
		.avalon_st_txstatus_error        (avalon_st_txstatus_error),                                   //                           .error
		.rx_clk_clk                      (xgmii_rx_clk_clk),                                           //                     rx_clk.clk
		.rx_reset_reset_n                (ref_reset_reset_n),                                          //                   rx_reset.reset_n
		.xgmii_rx_data                   (eth_loopback_composed_lb_rx_src_data_data),                  //                   xgmii_rx.data
		.avalon_st_rx_startofpacket      (eth_10g_mac_avalon_st_rx_startofpacket),                     //               avalon_st_rx.startofpacket
		.avalon_st_rx_endofpacket        (eth_10g_mac_avalon_st_rx_endofpacket),                       //                           .endofpacket
		.avalon_st_rx_valid              (eth_10g_mac_avalon_st_rx_valid),                             //                           .valid
		.avalon_st_rx_ready              (eth_10g_mac_avalon_st_rx_ready),                             //                           .ready
		.avalon_st_rx_data               (eth_10g_mac_avalon_st_rx_data),                              //                           .data
		.avalon_st_rx_empty              (eth_10g_mac_avalon_st_rx_empty),                             //                           .empty
		.avalon_st_rx_error              (eth_10g_mac_avalon_st_rx_error),                             //                           .error
		.avalon_st_rxstatus_valid        (avalon_st_rxstatus_valid),                                   //         avalon_st_rxstatus.valid
		.avalon_st_rxstatus_data         (avalon_st_rxstatus_data),                                    //                           .data
		.avalon_st_rxstatus_error        (avalon_st_rxstatus_error),                                   //                           .error
		.link_fault_status_xgmii_rx_data (link_fault_status_xgmii_rx_data)                             // link_fault_status_xgmii_rx.data
	);

	sonic_v1_15_eth_10g_eth_loopback_composed eth_loopback_composed (
		.tx_clk_clk           (tx_clk_clk),                                                           //          tx_clk.clk
		.tx_reset_reset_n     (tx_reset_reset_n),                                                     //        tx_reset.reset_n
		.rx_clk_clk           (xgmii_rx_clk_clk),                                                     //          rx_clk.clk
		.rx_reset_reset_n     (ref_reset_reset_n),                                                    //        rx_reset.reset_n
		.csr_clk_clk          (mm_clk_clk),                                                           //         csr_clk.clk
		.csr_reset_reset_n    (mm_reset_reset_n),                                                     //       csr_reset.reset_n
		.lb_tx_sink_data_data (eth_10g_mac_xgmii_tx_data),                                            // lb_tx_sink_data.data
		.lb_tx_src_data_data  (eth_loopback_composed_lb_tx_src_data_data),                            //  lb_tx_src_data.data
		.lb_rx_sink_data_data (altera_10gbaser_xgmii_rx_dc_0_data),                                   // lb_rx_sink_data.data
		.lb_rx_src_data_data  (eth_loopback_composed_lb_rx_src_data_data),                            //  lb_rx_src_data.data
		.csr_address          (eth_loopback_composed_csr_translator_avalon_anti_slave_0_address),     //             csr.address
		.csr_waitrequest      (eth_loopback_composed_csr_translator_avalon_anti_slave_0_waitrequest), //                .waitrequest
		.csr_read             (eth_loopback_composed_csr_translator_avalon_anti_slave_0_read),        //                .read
		.csr_readdata         (eth_loopback_composed_csr_translator_avalon_anti_slave_0_readdata),    //                .readdata
		.csr_write            (eth_loopback_composed_csr_translator_avalon_anti_slave_0_write),       //                .write
		.csr_writedata        (eth_loopback_composed_csr_translator_avalon_anti_slave_0_writedata)    //                .writedata
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (8),
		.BITS_PER_SYMBOL     (8),
		.FIFO_DEPTH          (512),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (1),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (1),
		.EMPTY_LATENCY       (3),
		.USE_MEMORY_BLOCKS   (1),
		.USE_STORE_FORWARD   (1),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) tx_sc_fifo (
		.clk               (tx_clk_clk),                                              //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                      // clk_reset.reset
		.csr_address       (tx_sc_fifo_csr_translator_avalon_anti_slave_0_address),   //       csr.address
		.csr_read          (tx_sc_fifo_csr_translator_avalon_anti_slave_0_read),      //          .read
		.csr_write         (tx_sc_fifo_csr_translator_avalon_anti_slave_0_write),     //          .write
		.csr_readdata      (tx_sc_fifo_csr_translator_avalon_anti_slave_0_readdata),  //          .readdata
		.csr_writedata     (tx_sc_fifo_csr_translator_avalon_anti_slave_0_writedata), //          .writedata
		.in_data           (tx_sc_fifo_in_data),                                      //        in.data
		.in_valid          (tx_sc_fifo_in_valid),                                     //          .valid
		.in_ready          (tx_sc_fifo_in_ready),                                     //          .ready
		.in_startofpacket  (tx_sc_fifo_in_startofpacket),                             //          .startofpacket
		.in_endofpacket    (tx_sc_fifo_in_endofpacket),                               //          .endofpacket
		.in_empty          (tx_sc_fifo_in_empty),                                     //          .empty
		.in_error          (tx_sc_fifo_in_error),                                     //          .error
		.out_data          (tx_sc_fifo_out_data),                                     //       out.data
		.out_valid         (tx_sc_fifo_out_valid),                                    //          .valid
		.out_ready         (tx_sc_fifo_out_ready),                                    //          .ready
		.out_startofpacket (tx_sc_fifo_out_startofpacket),                            //          .startofpacket
		.out_endofpacket   (tx_sc_fifo_out_endofpacket),                              //          .endofpacket
		.out_empty         (tx_sc_fifo_out_empty),                                    //          .empty
		.out_error         (tx_sc_fifo_out_error),                                    //          .error
		.almost_full_data  (),                                                        // (terminated)
		.almost_empty_data (),                                                        // (terminated)
		.in_channel        (1'b0),                                                    // (terminated)
		.out_channel       ()                                                         // (terminated)
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (8),
		.BITS_PER_SYMBOL     (8),
		.FIFO_DEPTH          (512),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (6),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (1),
		.EMPTY_LATENCY       (3),
		.USE_MEMORY_BLOCKS   (1),
		.USE_STORE_FORWARD   (1),
		.USE_ALMOST_FULL_IF  (1),
		.USE_ALMOST_EMPTY_IF (1)
	) rx_sc_fifo (
		.clk               (xgmii_rx_clk_clk),                                        //          clk.clk
		.reset             (rst_controller_002_reset_out_reset),                      //    clk_reset.reset
		.csr_address       (rx_sc_fifo_csr_translator_avalon_anti_slave_0_address),   //          csr.address
		.csr_read          (rx_sc_fifo_csr_translator_avalon_anti_slave_0_read),      //             .read
		.csr_write         (rx_sc_fifo_csr_translator_avalon_anti_slave_0_write),     //             .write
		.csr_readdata      (rx_sc_fifo_csr_translator_avalon_anti_slave_0_readdata),  //             .readdata
		.csr_writedata     (rx_sc_fifo_csr_translator_avalon_anti_slave_0_writedata), //             .writedata
		.almost_full_data  (rx_sc_fifo_almost_full_data),                             //  almost_full.data
		.almost_empty_data (rx_sc_fifo_almost_empty_data),                            // almost_empty.data
		.in_data           (eth_10g_mac_avalon_st_rx_data),                           //           in.data
		.in_valid          (eth_10g_mac_avalon_st_rx_valid),                          //             .valid
		.in_ready          (eth_10g_mac_avalon_st_rx_ready),                          //             .ready
		.in_startofpacket  (eth_10g_mac_avalon_st_rx_startofpacket),                  //             .startofpacket
		.in_endofpacket    (eth_10g_mac_avalon_st_rx_endofpacket),                    //             .endofpacket
		.in_empty          (eth_10g_mac_avalon_st_rx_empty),                          //             .empty
		.in_error          (eth_10g_mac_avalon_st_rx_error),                          //             .error
		.out_data          (rx_sc_fifo_out_data),                                     //          out.data
		.out_valid         (rx_sc_fifo_out_valid),                                    //             .valid
		.out_ready         (rx_sc_fifo_out_ready),                                    //             .ready
		.out_startofpacket (rx_sc_fifo_out_startofpacket),                            //             .startofpacket
		.out_endofpacket   (rx_sc_fifo_out_endofpacket),                              //             .endofpacket
		.out_empty         (rx_sc_fifo_out_empty),                                    //             .empty
		.out_error         (rx_sc_fifo_out_error),                                    //             .error
		.in_channel        (1'b0),                                                    //  (terminated)
		.out_channel       ()                                                         //  (terminated)
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
	) dc_fifo_pause_adapt_pause_gen (
		.in_clk      (xgmii_rx_clk_clk),                        //        in_clk.clk
		.in_reset_n  (~rst_controller_002_reset_out_reset),     //  in_clk_reset.reset_n
		.out_clk     (tx_clk_clk),                              //       out_clk.clk
		.out_reset_n (~rst_controller_001_reset_out_reset),     // out_clk_reset.reset_n
		.in_data     (pa_pg_before_timing_adapter_out_data),    //            in.data
		.in_valid    (pa_pg_before_timing_adapter_out_valid),   //              .valid
		.in_ready    (pa_pg_before_timing_adapter_out_ready),   //              .ready
		.out_data    (dc_fifo_pause_adapt_pause_gen_out_data),  //           out.data
		.out_valid   (dc_fifo_pause_adapt_pause_gen_out_valid), //              .valid
		.out_ready   (dc_fifo_pause_adapt_pause_gen_out_ready)  //              .ready
	);

	sonic_v1_15_eth_10g_pa_pg_before_timing_adapter pa_pg_before_timing_adapter (
		.clk       (xgmii_rx_clk_clk),                                         //   clk.clk
		.reset_n   (~rst_controller_002_reset_out_reset),                      // reset.reset_n
		.in_data   (eth_fifo_pause_ctrl_adapter_avalon_streaming_source_data), //    in.data
		.out_data  (pa_pg_before_timing_adapter_out_data),                     //   out.data
		.out_ready (pa_pg_before_timing_adapter_out_ready),                    //      .ready
		.out_valid (pa_pg_before_timing_adapter_out_valid)                     //      .valid
	);

	sonic_v1_15_eth_10g_pa_pg_after_timing_adapter pa_pg_after_timing_adapter (
		.clk      (tx_clk_clk),                              //   clk.clk
		.reset_n  (~rst_controller_001_reset_out_reset),     // reset.reset_n
		.in_ready (dc_fifo_pause_adapt_pause_gen_out_ready), //    in.ready
		.in_valid (dc_fifo_pause_adapt_pause_gen_out_valid), //      .valid
		.in_data  (dc_fifo_pause_adapt_pause_gen_out_data),  //      .data
		.out_data (pa_pg_after_timing_adapter_out_data)      //   out.data
	);

	altera_eth_fifo_pause_ctrl_adapter eth_fifo_pause_ctrl_adapter (
		.clk                    (xgmii_rx_clk_clk),                                         //                              clock.clk
		.reset                  (rst_controller_002_reset_out_reset),                       //                        clock_reset.reset
		.data_sink_almost_full  (rx_sc_fifo_almost_full_data),                              //  avalon_streaming_sink_almost_full.data
		.data_sink_almost_empty (rx_sc_fifo_almost_empty_data),                             // avalon_streaming_sink_almost_empty.data
		.pause_ctrl_src_data    (eth_fifo_pause_ctrl_adapter_avalon_streaming_source_data)  //            avalon_streaming_source.data
	);

	altera_eth_mdio #(
		.MDC_DIVISOR (32)
	) altera_eth_mdio (
		.clk             (mm_clk_clk),                                                     //       clock.clk
		.reset           (rst_controller_reset_out_reset),                                 // clock_reset.reset
		.csr_write       (altera_eth_mdio_csr_translator_avalon_anti_slave_0_write),       //         csr.write
		.csr_read        (altera_eth_mdio_csr_translator_avalon_anti_slave_0_read),        //            .read
		.csr_address     (altera_eth_mdio_csr_translator_avalon_anti_slave_0_address),     //            .address
		.csr_writedata   (altera_eth_mdio_csr_translator_avalon_anti_slave_0_writedata),   //            .writedata
		.csr_readdata    (altera_eth_mdio_csr_translator_avalon_anti_slave_0_readdata),    //            .readdata
		.csr_waitrequest (altera_eth_mdio_csr_translator_avalon_anti_slave_0_waitrequest), //            .waitrequest
		.mdc             (mdio_mdc),                                                       //        mdio.export
		.mdio_in         (mdio_mdio_in),                                                   //            .export
		.mdio_out        (mdio_mdio_out),                                                  //            .export
		.mdio_oen        (mdio_mdio_oen)                                                   //            .export
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (32),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (3),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (32),
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
	) altera_avalon_mm_bridge_avalon_universal_master_0_translator (
		.clk                   (mm_clk_clk),                                                                                           //                       clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                                       //                     reset.reset
		.uav_address           (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (altera_avalon_mm_bridge_avalon_universal_master_0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (altera_avalon_mm_bridge_avalon_universal_master_0_waitrequest),                                        //                          .waitrequest
		.av_burstcount         (altera_avalon_mm_bridge_avalon_universal_master_0_burstcount),                                         //                          .burstcount
		.av_byteenable         (altera_avalon_mm_bridge_avalon_universal_master_0_byteenable),                                         //                          .byteenable
		.av_read               (altera_avalon_mm_bridge_avalon_universal_master_0_read),                                               //                          .read
		.av_readdata           (altera_avalon_mm_bridge_avalon_universal_master_0_readdata),                                           //                          .readdata
		.av_readdatavalid      (altera_avalon_mm_bridge_avalon_universal_master_0_readdatavalid),                                      //                          .readdatavalid
		.av_write              (altera_avalon_mm_bridge_avalon_universal_master_0_write),                                              //                          .write
		.av_writedata          (altera_avalon_mm_bridge_avalon_universal_master_0_writedata),                                          //                          .writedata
		.av_lock               (altera_avalon_mm_bridge_avalon_universal_master_0_lock),                                               //                          .lock
		.av_debugaccess        (altera_avalon_mm_bridge_avalon_universal_master_0_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer (1'b0),                                                                                                 //               (terminated)
		.av_begintransfer      (1'b0),                                                                                                 //               (terminated)
		.av_chipselect         (1'b0),                                                                                                 //               (terminated)
		.uav_clken             (),                                                                                                     //               (terminated)
		.av_clken              (1'b1)                                                                                                  //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (9),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (32),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (1),
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
	) altera_10gbaser_phy_mgmt_translator (
		.clk                   (mm_clk_clk),                                                                          //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                      //                    reset.reset
		.uav_address           (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (altera_10gbaser_phy_mgmt_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                                    //              (terminated)
		.av_beginbursttransfer (),                                                                                    //              (terminated)
		.av_burstcount         (),                                                                                    //              (terminated)
		.av_byteenable         (),                                                                                    //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                //              (terminated)
		.av_writebyteenable    (),                                                                                    //              (terminated)
		.av_lock               (),                                                                                    //              (terminated)
		.av_chipselect         (),                                                                                    //              (terminated)
		.av_clken              (),                                                                                    //              (terminated)
		.uav_clken             (1'b0),                                                                                //              (terminated)
		.av_debugaccess        (),                                                                                    //              (terminated)
		.av_outputenable       ()                                                                                     //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (13),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (32),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (1),
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
	) eth_10g_mac_csr_translator (
		.clk                   (mm_clk_clk),                                                                 //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                             //                    reset.reset
		.uav_address           (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (eth_10g_mac_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (eth_10g_mac_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (eth_10g_mac_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (eth_10g_mac_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (eth_10g_mac_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (eth_10g_mac_csr_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                           //              (terminated)
		.av_beginbursttransfer (),                                                                           //              (terminated)
		.av_burstcount         (),                                                                           //              (terminated)
		.av_byteenable         (),                                                                           //              (terminated)
		.av_readdatavalid      (1'b0),                                                                       //              (terminated)
		.av_writebyteenable    (),                                                                           //              (terminated)
		.av_lock               (),                                                                           //              (terminated)
		.av_chipselect         (),                                                                           //              (terminated)
		.av_clken              (),                                                                           //              (terminated)
		.uav_clken             (1'b0),                                                                       //              (terminated)
		.av_debugaccess        (),                                                                           //              (terminated)
		.av_outputenable       ()                                                                            //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (4),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (32),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (1),
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
	) eth_loopback_composed_csr_translator (
		.clk                   (mm_clk_clk),                                                                           //                      clk.clk
		.reset                 (rst_controller_003_reset_out_reset),                                                   //                    reset.reset
		.uav_address           (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (eth_loopback_composed_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (eth_loopback_composed_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (eth_loopback_composed_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (eth_loopback_composed_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (eth_loopback_composed_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (eth_loopback_composed_csr_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                                     //              (terminated)
		.av_beginbursttransfer (),                                                                                     //              (terminated)
		.av_burstcount         (),                                                                                     //              (terminated)
		.av_byteenable         (),                                                                                     //              (terminated)
		.av_readdatavalid      (1'b0),                                                                                 //              (terminated)
		.av_writebyteenable    (),                                                                                     //              (terminated)
		.av_lock               (),                                                                                     //              (terminated)
		.av_chipselect         (),                                                                                     //              (terminated)
		.av_clken              (),                                                                                     //              (terminated)
		.uav_clken             (1'b0),                                                                                 //              (terminated)
		.av_debugaccess        (),                                                                                     //              (terminated)
		.av_outputenable       ()                                                                                      //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (3),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (32),
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
	) tx_sc_fifo_csr_translator (
		.clk                   (tx_clk_clk),                                                                //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                        //                    reset.reset
		.uav_address           (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (tx_sc_fifo_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (tx_sc_fifo_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (tx_sc_fifo_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (tx_sc_fifo_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (tx_sc_fifo_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                          //              (terminated)
		.av_beginbursttransfer (),                                                                          //              (terminated)
		.av_burstcount         (),                                                                          //              (terminated)
		.av_byteenable         (),                                                                          //              (terminated)
		.av_readdatavalid      (1'b0),                                                                      //              (terminated)
		.av_waitrequest        (1'b0),                                                                      //              (terminated)
		.av_writebyteenable    (),                                                                          //              (terminated)
		.av_lock               (),                                                                          //              (terminated)
		.av_chipselect         (),                                                                          //              (terminated)
		.av_clken              (),                                                                          //              (terminated)
		.uav_clken             (1'b0),                                                                      //              (terminated)
		.av_debugaccess        (),                                                                          //              (terminated)
		.av_outputenable       ()                                                                           //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (3),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (32),
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
	) rx_sc_fifo_csr_translator (
		.clk                   (xgmii_rx_clk_clk),                                                          //                      clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                        //                    reset.reset
		.uav_address           (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (rx_sc_fifo_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (rx_sc_fifo_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (rx_sc_fifo_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (rx_sc_fifo_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (rx_sc_fifo_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (),                                                                          //              (terminated)
		.av_beginbursttransfer (),                                                                          //              (terminated)
		.av_burstcount         (),                                                                          //              (terminated)
		.av_byteenable         (),                                                                          //              (terminated)
		.av_readdatavalid      (1'b0),                                                                      //              (terminated)
		.av_waitrequest        (1'b0),                                                                      //              (terminated)
		.av_writebyteenable    (),                                                                          //              (terminated)
		.av_lock               (),                                                                          //              (terminated)
		.av_chipselect         (),                                                                          //              (terminated)
		.av_clken              (),                                                                          //              (terminated)
		.uav_clken             (1'b0),                                                                      //              (terminated)
		.av_debugaccess        (),                                                                          //              (terminated)
		.av_outputenable       ()                                                                           //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (6),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (32),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) altera_eth_mdio_csr_translator (
		.clk                   (mm_clk_clk),                                                                     //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                 //                    reset.reset
		.uav_address           (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (altera_eth_mdio_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (altera_eth_mdio_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (altera_eth_mdio_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (altera_eth_mdio_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (altera_eth_mdio_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (altera_eth_mdio_csr_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                               //              (terminated)
		.av_beginbursttransfer (),                                                                               //              (terminated)
		.av_burstcount         (),                                                                               //              (terminated)
		.av_byteenable         (),                                                                               //              (terminated)
		.av_readdatavalid      (1'b0),                                                                           //              (terminated)
		.av_writebyteenable    (),                                                                               //              (terminated)
		.av_lock               (),                                                                               //              (terminated)
		.av_chipselect         (),                                                                               //              (terminated)
		.av_clken              (),                                                                               //              (terminated)
		.uav_clken             (1'b0),                                                                           //              (terminated)
		.av_debugaccess        (),                                                                               //              (terminated)
		.av_outputenable       ()                                                                                //              (terminated)
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.PKT_BEGIN_BURST           (79),
		.PKT_BURSTWRAP_H           (78),
		.PKT_BURSTWRAP_L           (76),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_ADDR_H                (67),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (68),
		.PKT_TRANS_POSTED          (69),
		.PKT_TRANS_WRITE           (70),
		.PKT_TRANS_READ            (71),
		.PKT_TRANS_LOCK            (72),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (82),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (83),
		.ST_DATA_W                 (87),
		.ST_CHANNEL_W              (6),
		.AV_BURSTCOUNT_W           (3),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (1),
		.BURSTWRAP_VALUE           (7)
	) altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent (
		.clk              (mm_clk_clk),                                                                                                    //       clk.clk
		.reset            (rst_controller_reset_out_reset),                                                                                // clk_reset.reset
		.av_address       (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_rsp_src_valid),                                                                                         //        rp.valid
		.rp_data          (limiter_rsp_src_data),                                                                                          //          .data
		.rp_channel       (limiter_rsp_src_channel),                                                                                       //          .channel
		.rp_startofpacket (limiter_rsp_src_startofpacket),                                                                                 //          .startofpacket
		.rp_endofpacket   (limiter_rsp_src_endofpacket),                                                                                   //          .endofpacket
		.rp_ready         (limiter_rsp_src_ready)                                                                                          //          .ready
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (79),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (67),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (68),
		.PKT_TRANS_POSTED          (69),
		.PKT_TRANS_WRITE           (70),
		.PKT_TRANS_READ            (71),
		.PKT_TRANS_LOCK            (72),
		.PKT_SRC_ID_H              (82),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (83),
		.PKT_BURSTWRAP_H           (78),
		.PKT_BURSTWRAP_L           (76),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.ST_CHANNEL_W              (6),
		.ST_DATA_W                 (87),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent (
		.clk                     (mm_clk_clk),                                                                                    //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                                //       clk_reset.reset
		.m0_address              (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_src0_ready),                                                                     //              cp.ready
		.cp_valid                (cmd_xbar_demux_src0_valid),                                                                     //                .valid
		.cp_data                 (cmd_xbar_demux_src0_data),                                                                      //                .data
		.cp_startofpacket        (cmd_xbar_demux_src0_startofpacket),                                                             //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_src0_endofpacket),                                                               //                .endofpacket
		.cp_channel              (cmd_xbar_demux_src0_channel),                                                                   //                .channel
		.rf_sink_ready           (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (88),
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
	) altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (mm_clk_clk),                                                                                    //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                                // clk_reset.reset
		.in_data           (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                         // (terminated)
		.csr_read          (1'b0),                                                                                          // (terminated)
		.csr_write         (1'b0),                                                                                          // (terminated)
		.csr_readdata      (),                                                                                              // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                          // (terminated)
		.almost_full_data  (),                                                                                              // (terminated)
		.almost_empty_data (),                                                                                              // (terminated)
		.in_empty          (1'b0),                                                                                          // (terminated)
		.out_empty         (),                                                                                              // (terminated)
		.in_error          (1'b0),                                                                                          // (terminated)
		.out_error         (),                                                                                              // (terminated)
		.in_channel        (1'b0),                                                                                          // (terminated)
		.out_channel       ()                                                                                               // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (79),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (67),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (68),
		.PKT_TRANS_POSTED          (69),
		.PKT_TRANS_WRITE           (70),
		.PKT_TRANS_READ            (71),
		.PKT_TRANS_LOCK            (72),
		.PKT_SRC_ID_H              (82),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (83),
		.PKT_BURSTWRAP_H           (78),
		.PKT_BURSTWRAP_L           (76),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.ST_CHANNEL_W              (6),
		.ST_DATA_W                 (87),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) eth_10g_mac_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (mm_clk_clk),                                                                           //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                       //       clk_reset.reset
		.m0_address              (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_src1_ready),                                                            //              cp.ready
		.cp_valid                (cmd_xbar_demux_src1_valid),                                                            //                .valid
		.cp_data                 (cmd_xbar_demux_src1_data),                                                             //                .data
		.cp_startofpacket        (cmd_xbar_demux_src1_startofpacket),                                                    //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_src1_endofpacket),                                                      //                .endofpacket
		.cp_channel              (cmd_xbar_demux_src1_channel),                                                          //                .channel
		.rf_sink_ready           (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (88),
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
	) eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (mm_clk_clk),                                                                           //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                       // clk_reset.reset
		.in_data           (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                // (terminated)
		.csr_read          (1'b0),                                                                                 // (terminated)
		.csr_write         (1'b0),                                                                                 // (terminated)
		.csr_readdata      (),                                                                                     // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                 // (terminated)
		.almost_full_data  (),                                                                                     // (terminated)
		.almost_empty_data (),                                                                                     // (terminated)
		.in_empty          (1'b0),                                                                                 // (terminated)
		.out_empty         (),                                                                                     // (terminated)
		.in_error          (1'b0),                                                                                 // (terminated)
		.out_error         (),                                                                                     // (terminated)
		.in_channel        (1'b0),                                                                                 // (terminated)
		.out_channel       ()                                                                                      // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (79),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (67),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (68),
		.PKT_TRANS_POSTED          (69),
		.PKT_TRANS_WRITE           (70),
		.PKT_TRANS_READ            (71),
		.PKT_TRANS_LOCK            (72),
		.PKT_SRC_ID_H              (82),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (83),
		.PKT_BURSTWRAP_H           (78),
		.PKT_BURSTWRAP_L           (76),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.ST_CHANNEL_W              (6),
		.ST_DATA_W                 (87),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (mm_clk_clk),                                                                                     //             clk.clk
		.reset                   (rst_controller_003_reset_out_reset),                                                             //       clk_reset.reset
		.m0_address              (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_src2_ready),                                                                      //              cp.ready
		.cp_valid                (cmd_xbar_demux_src2_valid),                                                                      //                .valid
		.cp_data                 (cmd_xbar_demux_src2_data),                                                                       //                .data
		.cp_startofpacket        (cmd_xbar_demux_src2_startofpacket),                                                              //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_src2_endofpacket),                                                                //                .endofpacket
		.cp_channel              (cmd_xbar_demux_src2_channel),                                                                    //                .channel
		.rf_sink_ready           (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (88),
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
	) eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (mm_clk_clk),                                                                                     //       clk.clk
		.reset             (rst_controller_003_reset_out_reset),                                                             // clk_reset.reset
		.in_data           (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
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
		.PKT_BEGIN_BURST           (79),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (67),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (68),
		.PKT_TRANS_POSTED          (69),
		.PKT_TRANS_WRITE           (70),
		.PKT_TRANS_READ            (71),
		.PKT_TRANS_LOCK            (72),
		.PKT_SRC_ID_H              (82),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (83),
		.PKT_BURSTWRAP_H           (78),
		.PKT_BURSTWRAP_L           (76),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.ST_CHANNEL_W              (6),
		.ST_DATA_W                 (87),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (tx_clk_clk),                                                                          //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                  //       clk_reset.reset
		.m0_address              (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (crosser_out_ready),                                                                   //              cp.ready
		.cp_valid                (crosser_out_valid),                                                                   //                .valid
		.cp_data                 (crosser_out_data),                                                                    //                .data
		.cp_startofpacket        (crosser_out_startofpacket),                                                           //                .startofpacket
		.cp_endofpacket          (crosser_out_endofpacket),                                                             //                .endofpacket
		.cp_channel              (crosser_out_channel),                                                                 //                .channel
		.rf_sink_ready           (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid),       //                .valid
		.rdata_fifo_sink_data    (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),        //                .data
		.rdata_fifo_src_ready    (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (88),
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
	) tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (tx_clk_clk),                                                                          //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                  // clk_reset.reset
		.in_data           (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                               // (terminated)
		.csr_read          (1'b0),                                                                                // (terminated)
		.csr_write         (1'b0),                                                                                // (terminated)
		.csr_readdata      (),                                                                                    // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                // (terminated)
		.almost_full_data  (),                                                                                    // (terminated)
		.almost_empty_data (),                                                                                    // (terminated)
		.in_empty          (1'b0),                                                                                // (terminated)
		.out_empty         (),                                                                                    // (terminated)
		.in_error          (1'b0),                                                                                // (terminated)
		.out_error         (),                                                                                    // (terminated)
		.in_channel        (1'b0),                                                                                // (terminated)
		.out_channel       ()                                                                                     // (terminated)
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
	) tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo (
		.clk               (tx_clk_clk),                                                                    //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                            // clk_reset.reset
		.in_data           (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),  //        in.data
		.in_valid          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid), //          .valid
		.in_ready          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready), //          .ready
		.out_data          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),  //       out.data
		.out_valid         (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid), //          .valid
		.out_ready         (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready), //          .ready
		.csr_address       (2'b00),                                                                         // (terminated)
		.csr_read          (1'b0),                                                                          // (terminated)
		.csr_write         (1'b0),                                                                          // (terminated)
		.csr_readdata      (),                                                                              // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                          // (terminated)
		.almost_full_data  (),                                                                              // (terminated)
		.almost_empty_data (),                                                                              // (terminated)
		.in_startofpacket  (1'b0),                                                                          // (terminated)
		.in_endofpacket    (1'b0),                                                                          // (terminated)
		.out_startofpacket (),                                                                              // (terminated)
		.out_endofpacket   (),                                                                              // (terminated)
		.in_empty          (1'b0),                                                                          // (terminated)
		.out_empty         (),                                                                              // (terminated)
		.in_error          (1'b0),                                                                          // (terminated)
		.out_error         (),                                                                              // (terminated)
		.in_channel        (1'b0),                                                                          // (terminated)
		.out_channel       ()                                                                               // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (79),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (67),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (68),
		.PKT_TRANS_POSTED          (69),
		.PKT_TRANS_WRITE           (70),
		.PKT_TRANS_READ            (71),
		.PKT_TRANS_LOCK            (72),
		.PKT_SRC_ID_H              (82),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (83),
		.PKT_BURSTWRAP_H           (78),
		.PKT_BURSTWRAP_L           (76),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.ST_CHANNEL_W              (6),
		.ST_DATA_W                 (87),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (xgmii_rx_clk_clk),                                                                    //             clk.clk
		.reset                   (rst_controller_002_reset_out_reset),                                                  //       clk_reset.reset
		.m0_address              (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (crosser_001_out_ready),                                                               //              cp.ready
		.cp_valid                (crosser_001_out_valid),                                                               //                .valid
		.cp_data                 (crosser_001_out_data),                                                                //                .data
		.cp_startofpacket        (crosser_001_out_startofpacket),                                                       //                .startofpacket
		.cp_endofpacket          (crosser_001_out_endofpacket),                                                         //                .endofpacket
		.cp_channel              (crosser_001_out_channel),                                                             //                .channel
		.rf_sink_ready           (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid),       //                .valid
		.rdata_fifo_sink_data    (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),        //                .data
		.rdata_fifo_src_ready    (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (88),
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
	) rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (xgmii_rx_clk_clk),                                                                    //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                                  // clk_reset.reset
		.in_data           (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                               // (terminated)
		.csr_read          (1'b0),                                                                                // (terminated)
		.csr_write         (1'b0),                                                                                // (terminated)
		.csr_readdata      (),                                                                                    // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                // (terminated)
		.almost_full_data  (),                                                                                    // (terminated)
		.almost_empty_data (),                                                                                    // (terminated)
		.in_empty          (1'b0),                                                                                // (terminated)
		.out_empty         (),                                                                                    // (terminated)
		.in_error          (1'b0),                                                                                // (terminated)
		.out_error         (),                                                                                    // (terminated)
		.in_channel        (1'b0),                                                                                // (terminated)
		.out_channel       ()                                                                                     // (terminated)
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
	) rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo (
		.clk               (xgmii_rx_clk_clk),                                                              //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                            // clk_reset.reset
		.in_data           (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),  //        in.data
		.in_valid          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid), //          .valid
		.in_ready          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready), //          .ready
		.out_data          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),  //       out.data
		.out_valid         (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid), //          .valid
		.out_ready         (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready), //          .ready
		.csr_address       (2'b00),                                                                         // (terminated)
		.csr_read          (1'b0),                                                                          // (terminated)
		.csr_write         (1'b0),                                                                          // (terminated)
		.csr_readdata      (),                                                                              // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                          // (terminated)
		.almost_full_data  (),                                                                              // (terminated)
		.almost_empty_data (),                                                                              // (terminated)
		.in_startofpacket  (1'b0),                                                                          // (terminated)
		.in_endofpacket    (1'b0),                                                                          // (terminated)
		.out_startofpacket (),                                                                              // (terminated)
		.out_endofpacket   (),                                                                              // (terminated)
		.in_empty          (1'b0),                                                                          // (terminated)
		.out_empty         (),                                                                              // (terminated)
		.in_error          (1'b0),                                                                          // (terminated)
		.out_error         (),                                                                              // (terminated)
		.in_channel        (1'b0),                                                                          // (terminated)
		.out_channel       ()                                                                               // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (79),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (67),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (68),
		.PKT_TRANS_POSTED          (69),
		.PKT_TRANS_WRITE           (70),
		.PKT_TRANS_READ            (71),
		.PKT_TRANS_LOCK            (72),
		.PKT_SRC_ID_H              (82),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (83),
		.PKT_BURSTWRAP_H           (78),
		.PKT_BURSTWRAP_L           (76),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.ST_CHANNEL_W              (6),
		.ST_DATA_W                 (87),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (mm_clk_clk),                                                                               //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                           //       clk_reset.reset
		.m0_address              (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_src5_ready),                                                                //              cp.ready
		.cp_valid                (cmd_xbar_demux_src5_valid),                                                                //                .valid
		.cp_data                 (cmd_xbar_demux_src5_data),                                                                 //                .data
		.cp_startofpacket        (cmd_xbar_demux_src5_startofpacket),                                                        //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_src5_endofpacket),                                                          //                .endofpacket
		.cp_channel              (cmd_xbar_demux_src5_channel),                                                              //                .channel
		.rf_sink_ready           (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (88),
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
	) altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (mm_clk_clk),                                                                               //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                           // clk_reset.reset
		.in_data           (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                    // (terminated)
		.csr_read          (1'b0),                                                                                     // (terminated)
		.csr_write         (1'b0),                                                                                     // (terminated)
		.csr_readdata      (),                                                                                         // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                     // (terminated)
		.almost_full_data  (),                                                                                         // (terminated)
		.almost_empty_data (),                                                                                         // (terminated)
		.in_empty          (1'b0),                                                                                     // (terminated)
		.out_empty         (),                                                                                         // (terminated)
		.in_error          (1'b0),                                                                                     // (terminated)
		.out_error         (),                                                                                         // (terminated)
		.in_channel        (1'b0),                                                                                     // (terminated)
		.out_channel       ()                                                                                          // (terminated)
	);

	sonic_v1_15_eth_10g_addr_router addr_router (
		.sink_ready         (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (altera_avalon_mm_bridge_avalon_universal_master_0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (mm_clk_clk),                                                                                                    //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                                                // clk_reset.reset
		.src_ready          (addr_router_src_ready),                                                                                         //       src.ready
		.src_valid          (addr_router_src_valid),                                                                                         //          .valid
		.src_data           (addr_router_src_data),                                                                                          //          .data
		.src_channel        (addr_router_src_channel),                                                                                       //          .channel
		.src_startofpacket  (addr_router_src_startofpacket),                                                                                 //          .startofpacket
		.src_endofpacket    (addr_router_src_endofpacket)                                                                                    //          .endofpacket
	);

	sonic_v1_15_eth_10g_id_router id_router (
		.sink_ready         (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (altera_10gbaser_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (mm_clk_clk),                                                                          //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                      // clk_reset.reset
		.src_ready          (id_router_src_ready),                                                                 //       src.ready
		.src_valid          (id_router_src_valid),                                                                 //          .valid
		.src_data           (id_router_src_data),                                                                  //          .data
		.src_channel        (id_router_src_channel),                                                               //          .channel
		.src_startofpacket  (id_router_src_startofpacket),                                                         //          .startofpacket
		.src_endofpacket    (id_router_src_endofpacket)                                                            //          .endofpacket
	);

	sonic_v1_15_eth_10g_id_router id_router_001 (
		.sink_ready         (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (eth_10g_mac_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (mm_clk_clk),                                                                 //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                             // clk_reset.reset
		.src_ready          (id_router_001_src_ready),                                                    //       src.ready
		.src_valid          (id_router_001_src_valid),                                                    //          .valid
		.src_data           (id_router_001_src_data),                                                     //          .data
		.src_channel        (id_router_001_src_channel),                                                  //          .channel
		.src_startofpacket  (id_router_001_src_startofpacket),                                            //          .startofpacket
		.src_endofpacket    (id_router_001_src_endofpacket)                                               //          .endofpacket
	);

	sonic_v1_15_eth_10g_id_router id_router_002 (
		.sink_ready         (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (eth_loopback_composed_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (mm_clk_clk),                                                                           //       clk.clk
		.reset              (rst_controller_003_reset_out_reset),                                                   // clk_reset.reset
		.src_ready          (id_router_002_src_ready),                                                              //       src.ready
		.src_valid          (id_router_002_src_valid),                                                              //          .valid
		.src_data           (id_router_002_src_data),                                                               //          .data
		.src_channel        (id_router_002_src_channel),                                                            //          .channel
		.src_startofpacket  (id_router_002_src_startofpacket),                                                      //          .startofpacket
		.src_endofpacket    (id_router_002_src_endofpacket)                                                         //          .endofpacket
	);

	sonic_v1_15_eth_10g_id_router id_router_003 (
		.sink_ready         (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (tx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (tx_clk_clk),                                                                //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                        // clk_reset.reset
		.src_ready          (id_router_003_src_ready),                                                   //       src.ready
		.src_valid          (id_router_003_src_valid),                                                   //          .valid
		.src_data           (id_router_003_src_data),                                                    //          .data
		.src_channel        (id_router_003_src_channel),                                                 //          .channel
		.src_startofpacket  (id_router_003_src_startofpacket),                                           //          .startofpacket
		.src_endofpacket    (id_router_003_src_endofpacket)                                              //          .endofpacket
	);

	sonic_v1_15_eth_10g_id_router id_router_004 (
		.sink_ready         (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (rx_sc_fifo_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (xgmii_rx_clk_clk),                                                          //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                        // clk_reset.reset
		.src_ready          (id_router_004_src_ready),                                                   //       src.ready
		.src_valid          (id_router_004_src_valid),                                                   //          .valid
		.src_data           (id_router_004_src_data),                                                    //          .data
		.src_channel        (id_router_004_src_channel),                                                 //          .channel
		.src_startofpacket  (id_router_004_src_startofpacket),                                           //          .startofpacket
		.src_endofpacket    (id_router_004_src_endofpacket)                                              //          .endofpacket
	);

	sonic_v1_15_eth_10g_id_router id_router_005 (
		.sink_ready         (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (altera_eth_mdio_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (mm_clk_clk),                                                                     //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                 // clk_reset.reset
		.src_ready          (id_router_005_src_ready),                                                        //       src.ready
		.src_valid          (id_router_005_src_valid),                                                        //          .valid
		.src_data           (id_router_005_src_data),                                                         //          .data
		.src_channel        (id_router_005_src_channel),                                                      //          .channel
		.src_startofpacket  (id_router_005_src_startofpacket),                                                //          .startofpacket
		.src_endofpacket    (id_router_005_src_endofpacket)                                                   //          .endofpacket
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (83),
		.PKT_TRANS_POSTED          (69),
		.MAX_OUTSTANDING_RESPONSES (9),
		.PIPELINED                 (0),
		.ST_DATA_W                 (87),
		.ST_CHANNEL_W              (6),
		.VALID_WIDTH               (6),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter (
		.clk                    (mm_clk_clk),                     //       clk.clk
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

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~mm_reset_reset_n),              // reset_in0.reset
		.clk        (mm_clk_clk),                     //       clk.clk
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
		.reset_in0  (~ref_reset_reset_n),                 // reset_in0.reset
		.clk        (xgmii_rx_clk_clk),                   //       clk.clk
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

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller_003 (
		.reset_in0  (~tx_reset_reset_n),                  // reset_in0.reset
		.clk        (mm_clk_clk),                         //       clk.clk
		.reset_out  (rst_controller_003_reset_out_reset), // reset_out.reset
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

	sonic_v1_15_eth_10g_cmd_xbar_demux cmd_xbar_demux (
		.clk                (mm_clk_clk),                        //        clk.clk
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
		.src1_endofpacket   (cmd_xbar_demux_src1_endofpacket),   //           .endofpacket
		.src2_ready         (cmd_xbar_demux_src2_ready),         //       src2.ready
		.src2_valid         (cmd_xbar_demux_src2_valid),         //           .valid
		.src2_data          (cmd_xbar_demux_src2_data),          //           .data
		.src2_channel       (cmd_xbar_demux_src2_channel),       //           .channel
		.src2_startofpacket (cmd_xbar_demux_src2_startofpacket), //           .startofpacket
		.src2_endofpacket   (cmd_xbar_demux_src2_endofpacket),   //           .endofpacket
		.src3_ready         (cmd_xbar_demux_src3_ready),         //       src3.ready
		.src3_valid         (cmd_xbar_demux_src3_valid),         //           .valid
		.src3_data          (cmd_xbar_demux_src3_data),          //           .data
		.src3_channel       (cmd_xbar_demux_src3_channel),       //           .channel
		.src3_startofpacket (cmd_xbar_demux_src3_startofpacket), //           .startofpacket
		.src3_endofpacket   (cmd_xbar_demux_src3_endofpacket),   //           .endofpacket
		.src4_ready         (cmd_xbar_demux_src4_ready),         //       src4.ready
		.src4_valid         (cmd_xbar_demux_src4_valid),         //           .valid
		.src4_data          (cmd_xbar_demux_src4_data),          //           .data
		.src4_channel       (cmd_xbar_demux_src4_channel),       //           .channel
		.src4_startofpacket (cmd_xbar_demux_src4_startofpacket), //           .startofpacket
		.src4_endofpacket   (cmd_xbar_demux_src4_endofpacket),   //           .endofpacket
		.src5_ready         (cmd_xbar_demux_src5_ready),         //       src5.ready
		.src5_valid         (cmd_xbar_demux_src5_valid),         //           .valid
		.src5_data          (cmd_xbar_demux_src5_data),          //           .data
		.src5_channel       (cmd_xbar_demux_src5_channel),       //           .channel
		.src5_startofpacket (cmd_xbar_demux_src5_startofpacket), //           .startofpacket
		.src5_endofpacket   (cmd_xbar_demux_src5_endofpacket)    //           .endofpacket
	);

	sonic_v1_15_eth_10g_rsp_xbar_demux rsp_xbar_demux (
		.clk                (mm_clk_clk),                        //       clk.clk
		.reset              (rst_controller_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_src_ready),               //      sink.ready
		.sink_channel       (id_router_src_channel),             //          .channel
		.sink_data          (id_router_src_data),                //          .data
		.sink_startofpacket (id_router_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_eth_10g_rsp_xbar_demux rsp_xbar_demux_001 (
		.clk                (mm_clk_clk),                            //       clk.clk
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

	sonic_v1_15_eth_10g_rsp_xbar_demux rsp_xbar_demux_002 (
		.clk                (mm_clk_clk),                            //       clk.clk
		.reset              (rst_controller_003_reset_out_reset),    // clk_reset.reset
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

	sonic_v1_15_eth_10g_rsp_xbar_demux rsp_xbar_demux_003 (
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

	sonic_v1_15_eth_10g_rsp_xbar_demux rsp_xbar_demux_004 (
		.clk                (xgmii_rx_clk_clk),                      //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),    // clk_reset.reset
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

	sonic_v1_15_eth_10g_rsp_xbar_demux rsp_xbar_demux_005 (
		.clk                (mm_clk_clk),                            //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
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

	sonic_v1_15_eth_10g_rsp_xbar_mux rsp_xbar_mux (
		.clk                 (mm_clk_clk),                            //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
		.src_ready           (rsp_xbar_mux_src_ready),                //       src.ready
		.src_valid           (rsp_xbar_mux_src_valid),                //          .valid
		.src_data            (rsp_xbar_mux_src_data),                 //          .data
		.src_channel         (rsp_xbar_mux_src_channel),              //          .channel
		.src_startofpacket   (rsp_xbar_mux_src_startofpacket),        //          .startofpacket
		.src_endofpacket     (rsp_xbar_mux_src_endofpacket),          //          .endofpacket
		.sink0_ready         (rsp_xbar_demux_src0_ready),             //     sink0.ready
		.sink0_valid         (rsp_xbar_demux_src0_valid),             //          .valid
		.sink0_channel       (rsp_xbar_demux_src0_channel),           //          .channel
		.sink0_data          (rsp_xbar_demux_src0_data),              //          .data
		.sink0_startofpacket (rsp_xbar_demux_src0_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (rsp_xbar_demux_src0_endofpacket),       //          .endofpacket
		.sink1_ready         (rsp_xbar_demux_001_src0_ready),         //     sink1.ready
		.sink1_valid         (rsp_xbar_demux_001_src0_valid),         //          .valid
		.sink1_channel       (rsp_xbar_demux_001_src0_channel),       //          .channel
		.sink1_data          (rsp_xbar_demux_001_src0_data),          //          .data
		.sink1_startofpacket (rsp_xbar_demux_001_src0_startofpacket), //          .startofpacket
		.sink1_endofpacket   (rsp_xbar_demux_001_src0_endofpacket),   //          .endofpacket
		.sink2_ready         (rsp_xbar_demux_002_src0_ready),         //     sink2.ready
		.sink2_valid         (rsp_xbar_demux_002_src0_valid),         //          .valid
		.sink2_channel       (rsp_xbar_demux_002_src0_channel),       //          .channel
		.sink2_data          (rsp_xbar_demux_002_src0_data),          //          .data
		.sink2_startofpacket (rsp_xbar_demux_002_src0_startofpacket), //          .startofpacket
		.sink2_endofpacket   (rsp_xbar_demux_002_src0_endofpacket),   //          .endofpacket
		.sink3_ready         (crosser_002_out_ready),                 //     sink3.ready
		.sink3_valid         (crosser_002_out_valid),                 //          .valid
		.sink3_channel       (crosser_002_out_channel),               //          .channel
		.sink3_data          (crosser_002_out_data),                  //          .data
		.sink3_startofpacket (crosser_002_out_startofpacket),         //          .startofpacket
		.sink3_endofpacket   (crosser_002_out_endofpacket),           //          .endofpacket
		.sink4_ready         (crosser_003_out_ready),                 //     sink4.ready
		.sink4_valid         (crosser_003_out_valid),                 //          .valid
		.sink4_channel       (crosser_003_out_channel),               //          .channel
		.sink4_data          (crosser_003_out_data),                  //          .data
		.sink4_startofpacket (crosser_003_out_startofpacket),         //          .startofpacket
		.sink4_endofpacket   (crosser_003_out_endofpacket),           //          .endofpacket
		.sink5_ready         (rsp_xbar_demux_005_src0_ready),         //     sink5.ready
		.sink5_valid         (rsp_xbar_demux_005_src0_valid),         //          .valid
		.sink5_channel       (rsp_xbar_demux_005_src0_channel),       //          .channel
		.sink5_data          (rsp_xbar_demux_005_src0_data),          //          .data
		.sink5_startofpacket (rsp_xbar_demux_005_src0_startofpacket), //          .startofpacket
		.sink5_endofpacket   (rsp_xbar_demux_005_src0_endofpacket)    //          .endofpacket
	);

	altera_avalon_st_handshake_clock_crosser #(
		.DATA_WIDTH          (87),
		.BITS_PER_SYMBOL     (87),
		.USE_PACKETS         (1),
		.USE_CHANNEL         (1),
		.CHANNEL_WIDTH       (6),
		.USE_ERROR           (0),
		.ERROR_WIDTH         (1),
		.VALID_SYNC_DEPTH    (2),
		.READY_SYNC_DEPTH    (2),
		.USE_OUTPUT_PIPELINE (0)
	) crosser (
		.in_clk            (mm_clk_clk),                         //        in_clk.clk
		.in_reset          (rst_controller_reset_out_reset),     //  in_clk_reset.reset
		.out_clk           (tx_clk_clk),                         //       out_clk.clk
		.out_reset         (rst_controller_001_reset_out_reset), // out_clk_reset.reset
		.in_ready          (cmd_xbar_demux_src3_ready),          //            in.ready
		.in_valid          (cmd_xbar_demux_src3_valid),          //              .valid
		.in_startofpacket  (cmd_xbar_demux_src3_startofpacket),  //              .startofpacket
		.in_endofpacket    (cmd_xbar_demux_src3_endofpacket),    //              .endofpacket
		.in_channel        (cmd_xbar_demux_src3_channel),        //              .channel
		.in_data           (cmd_xbar_demux_src3_data),           //              .data
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
		.DATA_WIDTH          (87),
		.BITS_PER_SYMBOL     (87),
		.USE_PACKETS         (1),
		.USE_CHANNEL         (1),
		.CHANNEL_WIDTH       (6),
		.USE_ERROR           (0),
		.ERROR_WIDTH         (1),
		.VALID_SYNC_DEPTH    (2),
		.READY_SYNC_DEPTH    (2),
		.USE_OUTPUT_PIPELINE (0)
	) crosser_001 (
		.in_clk            (mm_clk_clk),                         //        in_clk.clk
		.in_reset          (rst_controller_reset_out_reset),     //  in_clk_reset.reset
		.out_clk           (xgmii_rx_clk_clk),                   //       out_clk.clk
		.out_reset         (rst_controller_002_reset_out_reset), // out_clk_reset.reset
		.in_ready          (cmd_xbar_demux_src4_ready),          //            in.ready
		.in_valid          (cmd_xbar_demux_src4_valid),          //              .valid
		.in_startofpacket  (cmd_xbar_demux_src4_startofpacket),  //              .startofpacket
		.in_endofpacket    (cmd_xbar_demux_src4_endofpacket),    //              .endofpacket
		.in_channel        (cmd_xbar_demux_src4_channel),        //              .channel
		.in_data           (cmd_xbar_demux_src4_data),           //              .data
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
		.DATA_WIDTH          (87),
		.BITS_PER_SYMBOL     (87),
		.USE_PACKETS         (1),
		.USE_CHANNEL         (1),
		.CHANNEL_WIDTH       (6),
		.USE_ERROR           (0),
		.ERROR_WIDTH         (1),
		.VALID_SYNC_DEPTH    (2),
		.READY_SYNC_DEPTH    (2),
		.USE_OUTPUT_PIPELINE (0)
	) crosser_002 (
		.in_clk            (tx_clk_clk),                            //        in_clk.clk
		.in_reset          (rst_controller_001_reset_out_reset),    //  in_clk_reset.reset
		.out_clk           (mm_clk_clk),                            //       out_clk.clk
		.out_reset         (rst_controller_reset_out_reset),        // out_clk_reset.reset
		.in_ready          (rsp_xbar_demux_003_src0_ready),         //            in.ready
		.in_valid          (rsp_xbar_demux_003_src0_valid),         //              .valid
		.in_startofpacket  (rsp_xbar_demux_003_src0_startofpacket), //              .startofpacket
		.in_endofpacket    (rsp_xbar_demux_003_src0_endofpacket),   //              .endofpacket
		.in_channel        (rsp_xbar_demux_003_src0_channel),       //              .channel
		.in_data           (rsp_xbar_demux_003_src0_data),          //              .data
		.out_ready         (crosser_002_out_ready),                 //           out.ready
		.out_valid         (crosser_002_out_valid),                 //              .valid
		.out_startofpacket (crosser_002_out_startofpacket),         //              .startofpacket
		.out_endofpacket   (crosser_002_out_endofpacket),           //              .endofpacket
		.out_channel       (crosser_002_out_channel),               //              .channel
		.out_data          (crosser_002_out_data),                  //              .data
		.in_empty          (1'b0),                                  //   (terminated)
		.in_error          (1'b0),                                  //   (terminated)
		.out_empty         (),                                      //   (terminated)
		.out_error         ()                                       //   (terminated)
	);

	altera_avalon_st_handshake_clock_crosser #(
		.DATA_WIDTH          (87),
		.BITS_PER_SYMBOL     (87),
		.USE_PACKETS         (1),
		.USE_CHANNEL         (1),
		.CHANNEL_WIDTH       (6),
		.USE_ERROR           (0),
		.ERROR_WIDTH         (1),
		.VALID_SYNC_DEPTH    (2),
		.READY_SYNC_DEPTH    (2),
		.USE_OUTPUT_PIPELINE (0)
	) crosser_003 (
		.in_clk            (xgmii_rx_clk_clk),                      //        in_clk.clk
		.in_reset          (rst_controller_002_reset_out_reset),    //  in_clk_reset.reset
		.out_clk           (mm_clk_clk),                            //       out_clk.clk
		.out_reset         (rst_controller_reset_out_reset),        // out_clk_reset.reset
		.in_ready          (rsp_xbar_demux_004_src0_ready),         //            in.ready
		.in_valid          (rsp_xbar_demux_004_src0_valid),         //              .valid
		.in_startofpacket  (rsp_xbar_demux_004_src0_startofpacket), //              .startofpacket
		.in_endofpacket    (rsp_xbar_demux_004_src0_endofpacket),   //              .endofpacket
		.in_channel        (rsp_xbar_demux_004_src0_channel),       //              .channel
		.in_data           (rsp_xbar_demux_004_src0_data),          //              .data
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

	assign tx_serial_data_export = { altera_10gbaser_tx_serial_data[0:0] };

	assign altera_10gbaser_xgmii_rx_dc_0_data = { altera_10gbaser_xgmii_rx_dc[71:0] };

endmodule
