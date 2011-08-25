// sonic_v1_15.v


`timescale 1 ps / 1 ps
module sonic_v1_15 (
		input  wire        rx_serial_data_export,            //     rx_serial_data.export
		output wire        rx_is_lockedtodata_export,        // rx_is_lockedtodata.export
		output wire        rx_clkout_clk,                    //          rx_clkout.clk
		input  wire        ref_clk_in_reset_reset_n,         //   ref_clk_in_reset.reset_n
		output wire        rx_is_lockedtoref_export,         //  rx_is_lockedtoref.export
		input  wire        ref_clk_in_clk,                   //         ref_clk_in.clk
		output wire        tx_serial_data_export,            //     tx_serial_data.export
		output wire        mdio_mdio_oen,                    //               mdio.mdio_oen
		input  wire        mdio_mdio_in,                     //                   .mdio_in
		output wire        mdio_mdio_out,                    //                   .mdio_out
		output wire        mdio_mdc,                         //                   .mdc
		output wire [39:0] rx_parallel_data_data,            //   rx_parallel_data.data
		input  wire        mm_clk_in_reset_reset_n,          //    mm_clk_in_reset.reset_n
		output wire        tx_ready_export,                  //           tx_ready.export
		output wire        user_interface_write,             //     user_interface.write
		input  wire [31:0] user_interface_datain_13,         //                   .datain_13
		input  wire [31:0] user_interface_datain_10,         //                   .datain_10
		output wire [31:0] user_interface_dataout_12,        //                   .dataout_12
		output wire [15:0] user_interface_chipselect,        //                   .chipselect
		input  wire [31:0] user_interface_datain_9,          //                   .datain_9
		input  wire [31:0] user_interface_datain_15,         //                   .datain_15
		output wire        user_interface_read,              //                   .read
		output wire [31:0] user_interface_dataout_15,        //                   .dataout_15
		output wire [31:0] user_interface_dataout_5,         //                   .dataout_5
		input  wire [31:0] user_interface_datain_1,          //                   .datain_1
		input  wire [31:0] user_interface_datain_7,          //                   .datain_7
		output wire [31:0] user_interface_dataout_10,        //                   .dataout_10
		output wire [31:0] user_interface_dataout_6,         //                   .dataout_6
		output wire [31:0] user_interface_dataout_14,        //                   .dataout_14
		output wire [31:0] user_interface_dataout_1,         //                   .dataout_1
		input  wire [31:0] user_interface_datain_6,          //                   .datain_6
		output wire [31:0] user_interface_dataout_11,        //                   .dataout_11
		output wire [31:0] user_interface_dataout_9,         //                   .dataout_9
		output wire [31:0] user_interface_dataout_13,        //                   .dataout_13
		input  wire [31:0] user_interface_datain_0,          //                   .datain_0
		output wire [31:0] user_interface_dataout_2,         //                   .dataout_2
		output wire [31:0] user_interface_dataout_7,         //                   .dataout_7
		input  wire [31:0] user_interface_datain_5,          //                   .datain_5
		output wire [31:0] user_interface_dataout_4,         //                   .dataout_4
		input  wire [31:0] user_interface_datain_2,          //                   .datain_2
		output wire [31:0] user_interface_dataout_8,         //                   .dataout_8
		input  wire [31:0] user_interface_datain_14,         //                   .datain_14
		output wire [31:0] user_interface_dataout_0,         //                   .dataout_0
		input  wire [31:0] user_interface_datain_11,         //                   .datain_11
		input  wire [31:0] user_interface_datain_3,          //                   .datain_3
		input  wire [31:0] user_interface_datain_12,         //                   .datain_12
		output wire [3:0]  user_interface_byteenable,        //                   .byteenable
		input  wire [31:0] user_interface_datain_4,          //                   .datain_4
		output wire [31:0] user_interface_dataout_3,         //                   .dataout_3
		input  wire [31:0] user_interface_datain_8,          //                   .datain_8
		output wire        rx_ready_export,                  //           rx_ready.export
		input  wire [39:0] tx_parallel_data_data,            //   tx_parallel_data.data
		input  wire        mm_clk_in_clk,                    //          mm_clk_in.clk
		output wire        pll_locked_export,                //         pll_locked.export
		output wire        mm_pipeline_bridge_waitrequest,   // mm_pipeline_bridge.waitrequest
		output wire [31:0] mm_pipeline_bridge_readdata,      //                   .readdata
		output wire        mm_pipeline_bridge_readdatavalid, //                   .readdatavalid
		input  wire        mm_pipeline_bridge_burstcount,    //                   .burstcount
		input  wire [31:0] mm_pipeline_bridge_writedata,     //                   .writedata
		input  wire [18:0] mm_pipeline_bridge_address,       //                   .address
		input  wire        mm_pipeline_bridge_write,         //                   .write
		input  wire        mm_pipeline_bridge_read,          //                   .read
		input  wire [3:0]  mm_pipeline_bridge_byteenable,    //                   .byteenable
		input  wire        mm_pipeline_bridge_debugaccess,   //                   .debugaccess
		output wire        tx_clkout_clk                     //          tx_clkout.clk
	);

	wire         jtag_master_master_waitrequest;                                                          // jtag_master_master_translator:av_waitrequest -> jtag_master:master_waitrequest
	wire  [31:0] jtag_master_master_writedata;                                                            // jtag_master:master_writedata -> jtag_master_master_translator:av_writedata
	wire  [31:0] jtag_master_master_address;                                                              // jtag_master:master_address -> jtag_master_master_translator:av_address
	wire         jtag_master_master_write;                                                                // jtag_master:master_write -> jtag_master_master_translator:av_write
	wire         jtag_master_master_read;                                                                 // jtag_master:master_read -> jtag_master_master_translator:av_read
	wire  [31:0] jtag_master_master_readdata;                                                             // jtag_master_master_translator:av_readdata -> jtag_master:master_readdata
	wire   [3:0] jtag_master_master_byteenable;                                                           // jtag_master:master_byteenable -> jtag_master_master_translator:av_byteenable
	wire         jtag_master_master_readdatavalid;                                                        // jtag_master_master_translator:av_readdatavalid -> jtag_master:master_readdatavalid
	wire   [0:0] mm_pipeline_bridge_m0_burstcount;                                                        // mm_pipeline_bridge:m0_burstcount -> mm_pipeline_bridge_m0_translator:av_burstcount
	wire         mm_pipeline_bridge_m0_waitrequest;                                                       // mm_pipeline_bridge_m0_translator:av_waitrequest -> mm_pipeline_bridge:m0_waitrequest
	wire  [18:0] mm_pipeline_bridge_m0_address;                                                           // mm_pipeline_bridge:m0_address -> mm_pipeline_bridge_m0_translator:av_address
	wire  [31:0] mm_pipeline_bridge_m0_writedata;                                                         // mm_pipeline_bridge:m0_writedata -> mm_pipeline_bridge_m0_translator:av_writedata
	wire         mm_pipeline_bridge_m0_write;                                                             // mm_pipeline_bridge:m0_write -> mm_pipeline_bridge_m0_translator:av_write
	wire         mm_pipeline_bridge_m0_read;                                                              // mm_pipeline_bridge:m0_read -> mm_pipeline_bridge_m0_translator:av_read
	wire  [31:0] mm_pipeline_bridge_m0_readdata;                                                          // mm_pipeline_bridge_m0_translator:av_readdata -> mm_pipeline_bridge:m0_readdata
	wire         mm_pipeline_bridge_m0_debugaccess;                                                       // mm_pipeline_bridge:m0_debugaccess -> mm_pipeline_bridge_m0_translator:av_debugaccess
	wire   [3:0] mm_pipeline_bridge_m0_byteenable;                                                        // mm_pipeline_bridge:m0_byteenable -> mm_pipeline_bridge_m0_translator:av_byteenable
	wire         mm_pipeline_bridge_m0_readdatavalid;                                                     // mm_pipeline_bridge_m0_translator:av_readdatavalid -> mm_pipeline_bridge:m0_readdatavalid
	wire         mdio_csr_translator_avalon_anti_slave_0_waitrequest;                                     // mdio:csr_waitrequest -> mdio_csr_translator:av_waitrequest
	wire  [31:0] mdio_csr_translator_avalon_anti_slave_0_writedata;                                       // mdio_csr_translator:av_writedata -> mdio:csr_writedata
	wire   [5:0] mdio_csr_translator_avalon_anti_slave_0_address;                                         // mdio_csr_translator:av_address -> mdio:csr_address
	wire         mdio_csr_translator_avalon_anti_slave_0_write;                                           // mdio_csr_translator:av_write -> mdio:csr_write
	wire         mdio_csr_translator_avalon_anti_slave_0_read;                                            // mdio_csr_translator:av_read -> mdio:csr_read
	wire  [31:0] mdio_csr_translator_avalon_anti_slave_0_readdata;                                        // mdio:csr_readdata -> mdio_csr_translator:av_readdata
	wire  [31:0] avalon_slave_0_s0_translator_avalon_anti_slave_0_writedata;                              // avalon_slave_0_s0_translator:av_writedata -> avalon_slave_0:slave_writedata
	wire   [8:0] avalon_slave_0_s0_translator_avalon_anti_slave_0_address;                                // avalon_slave_0_s0_translator:av_address -> avalon_slave_0:slave_address
	wire         avalon_slave_0_s0_translator_avalon_anti_slave_0_write;                                  // avalon_slave_0_s0_translator:av_write -> avalon_slave_0:slave_write
	wire         avalon_slave_0_s0_translator_avalon_anti_slave_0_read;                                   // avalon_slave_0_s0_translator:av_read -> avalon_slave_0:slave_read
	wire  [31:0] avalon_slave_0_s0_translator_avalon_anti_slave_0_readdata;                               // avalon_slave_0:slave_readdata -> avalon_slave_0_s0_translator:av_readdata
	wire   [3:0] avalon_slave_0_s0_translator_avalon_anti_slave_0_byteenable;                             // avalon_slave_0_s0_translator:av_byteenable -> avalon_slave_0:slave_byteenable
	wire         sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_waitrequest;                           // sonic_pma:phy_mgmt_waitrequest -> sonic_pma_phy_mgmt_translator:av_waitrequest
	wire  [31:0] sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_writedata;                             // sonic_pma_phy_mgmt_translator:av_writedata -> sonic_pma:phy_mgmt_writedata
	wire   [8:0] sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_address;                               // sonic_pma_phy_mgmt_translator:av_address -> sonic_pma:phy_mgmt_address
	wire         sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_write;                                 // sonic_pma_phy_mgmt_translator:av_write -> sonic_pma:phy_mgmt_write
	wire         sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_read;                                  // sonic_pma_phy_mgmt_translator:av_read -> sonic_pma:phy_mgmt_read
	wire  [31:0] sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_readdata;                              // sonic_pma:phy_mgmt_readdata -> sonic_pma_phy_mgmt_translator:av_readdata
	wire         jtag_master_master_translator_avalon_universal_master_0_waitrequest;                     // jtag_master_master_translator_avalon_universal_master_0_agent:av_waitrequest -> jtag_master_master_translator:uav_waitrequest
	wire   [2:0] jtag_master_master_translator_avalon_universal_master_0_burstcount;                      // jtag_master_master_translator:uav_burstcount -> jtag_master_master_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] jtag_master_master_translator_avalon_universal_master_0_writedata;                       // jtag_master_master_translator:uav_writedata -> jtag_master_master_translator_avalon_universal_master_0_agent:av_writedata
	wire  [31:0] jtag_master_master_translator_avalon_universal_master_0_address;                         // jtag_master_master_translator:uav_address -> jtag_master_master_translator_avalon_universal_master_0_agent:av_address
	wire         jtag_master_master_translator_avalon_universal_master_0_lock;                            // jtag_master_master_translator:uav_lock -> jtag_master_master_translator_avalon_universal_master_0_agent:av_lock
	wire         jtag_master_master_translator_avalon_universal_master_0_write;                           // jtag_master_master_translator:uav_write -> jtag_master_master_translator_avalon_universal_master_0_agent:av_write
	wire         jtag_master_master_translator_avalon_universal_master_0_read;                            // jtag_master_master_translator:uav_read -> jtag_master_master_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] jtag_master_master_translator_avalon_universal_master_0_readdata;                        // jtag_master_master_translator_avalon_universal_master_0_agent:av_readdata -> jtag_master_master_translator:uav_readdata
	wire         jtag_master_master_translator_avalon_universal_master_0_debugaccess;                     // jtag_master_master_translator:uav_debugaccess -> jtag_master_master_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] jtag_master_master_translator_avalon_universal_master_0_byteenable;                      // jtag_master_master_translator:uav_byteenable -> jtag_master_master_translator_avalon_universal_master_0_agent:av_byteenable
	wire         jtag_master_master_translator_avalon_universal_master_0_readdatavalid;                   // jtag_master_master_translator_avalon_universal_master_0_agent:av_readdatavalid -> jtag_master_master_translator:uav_readdatavalid
	wire         mm_pipeline_bridge_m0_translator_avalon_universal_master_0_waitrequest;                  // mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_waitrequest -> mm_pipeline_bridge_m0_translator:uav_waitrequest
	wire   [2:0] mm_pipeline_bridge_m0_translator_avalon_universal_master_0_burstcount;                   // mm_pipeline_bridge_m0_translator:uav_burstcount -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] mm_pipeline_bridge_m0_translator_avalon_universal_master_0_writedata;                    // mm_pipeline_bridge_m0_translator:uav_writedata -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_writedata
	wire  [31:0] mm_pipeline_bridge_m0_translator_avalon_universal_master_0_address;                      // mm_pipeline_bridge_m0_translator:uav_address -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_address
	wire         mm_pipeline_bridge_m0_translator_avalon_universal_master_0_lock;                         // mm_pipeline_bridge_m0_translator:uav_lock -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_lock
	wire         mm_pipeline_bridge_m0_translator_avalon_universal_master_0_write;                        // mm_pipeline_bridge_m0_translator:uav_write -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_write
	wire         mm_pipeline_bridge_m0_translator_avalon_universal_master_0_read;                         // mm_pipeline_bridge_m0_translator:uav_read -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] mm_pipeline_bridge_m0_translator_avalon_universal_master_0_readdata;                     // mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_readdata -> mm_pipeline_bridge_m0_translator:uav_readdata
	wire         mm_pipeline_bridge_m0_translator_avalon_universal_master_0_debugaccess;                  // mm_pipeline_bridge_m0_translator:uav_debugaccess -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] mm_pipeline_bridge_m0_translator_avalon_universal_master_0_byteenable;                   // mm_pipeline_bridge_m0_translator:uav_byteenable -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_byteenable
	wire         mm_pipeline_bridge_m0_translator_avalon_universal_master_0_readdatavalid;                // mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:av_readdatavalid -> mm_pipeline_bridge_m0_translator:uav_readdatavalid
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest;                       // mdio_csr_translator:uav_waitrequest -> mdio_csr_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] mdio_csr_translator_avalon_universal_slave_0_agent_m0_burstcount;                        // mdio_csr_translator_avalon_universal_slave_0_agent:m0_burstcount -> mdio_csr_translator:uav_burstcount
	wire  [31:0] mdio_csr_translator_avalon_universal_slave_0_agent_m0_writedata;                         // mdio_csr_translator_avalon_universal_slave_0_agent:m0_writedata -> mdio_csr_translator:uav_writedata
	wire  [31:0] mdio_csr_translator_avalon_universal_slave_0_agent_m0_address;                           // mdio_csr_translator_avalon_universal_slave_0_agent:m0_address -> mdio_csr_translator:uav_address
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_m0_write;                             // mdio_csr_translator_avalon_universal_slave_0_agent:m0_write -> mdio_csr_translator:uav_write
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_m0_lock;                              // mdio_csr_translator_avalon_universal_slave_0_agent:m0_lock -> mdio_csr_translator:uav_lock
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_m0_read;                              // mdio_csr_translator_avalon_universal_slave_0_agent:m0_read -> mdio_csr_translator:uav_read
	wire  [31:0] mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdata;                          // mdio_csr_translator:uav_readdata -> mdio_csr_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                     // mdio_csr_translator:uav_readdatavalid -> mdio_csr_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess;                       // mdio_csr_translator_avalon_universal_slave_0_agent:m0_debugaccess -> mdio_csr_translator:uav_debugaccess
	wire   [3:0] mdio_csr_translator_avalon_universal_slave_0_agent_m0_byteenable;                        // mdio_csr_translator_avalon_universal_slave_0_agent:m0_byteenable -> mdio_csr_translator:uav_byteenable
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                // mdio_csr_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_valid;                      // mdio_csr_translator_avalon_universal_slave_0_agent:rf_source_valid -> mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;              // mdio_csr_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [85:0] mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_data;                       // mdio_csr_translator_avalon_universal_slave_0_agent:rf_source_data -> mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_ready;                      // mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> mdio_csr_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;             // mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> mdio_csr_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                   // mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> mdio_csr_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;           // mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> mdio_csr_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [85:0] mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                    // mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> mdio_csr_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                   // mdio_csr_translator_avalon_universal_slave_0_agent:rf_sink_ready -> mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                 // mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                  // mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                 // mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> mdio_csr_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_waitrequest;              // avalon_slave_0_s0_translator:uav_waitrequest -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_burstcount;               // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_burstcount -> avalon_slave_0_s0_translator:uav_burstcount
	wire  [31:0] avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_writedata;                // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_writedata -> avalon_slave_0_s0_translator:uav_writedata
	wire  [31:0] avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_address;                  // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_address -> avalon_slave_0_s0_translator:uav_address
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_write;                    // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_write -> avalon_slave_0_s0_translator:uav_write
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_lock;                     // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_lock -> avalon_slave_0_s0_translator:uav_lock
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_read;                     // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_read -> avalon_slave_0_s0_translator:uav_read
	wire  [31:0] avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_readdata;                 // avalon_slave_0_s0_translator:uav_readdata -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_readdatavalid;            // avalon_slave_0_s0_translator:uav_readdatavalid -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_debugaccess;              // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_debugaccess -> avalon_slave_0_s0_translator:uav_debugaccess
	wire   [3:0] avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_byteenable;               // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:m0_byteenable -> avalon_slave_0_s0_translator:uav_byteenable
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;       // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_valid;             // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rf_source_valid -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;     // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [85:0] avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_data;              // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rf_source_data -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_ready;             // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;    // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;          // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;  // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [85:0] avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;           // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;          // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rf_sink_ready -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;        // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;         // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;        // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_waitrequest;             // sonic_pma_phy_mgmt_translator:uav_waitrequest -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_burstcount;              // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_burstcount -> sonic_pma_phy_mgmt_translator:uav_burstcount
	wire  [31:0] sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_writedata;               // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_writedata -> sonic_pma_phy_mgmt_translator:uav_writedata
	wire  [31:0] sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_address;                 // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_address -> sonic_pma_phy_mgmt_translator:uav_address
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_write;                   // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_write -> sonic_pma_phy_mgmt_translator:uav_write
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_lock;                    // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_lock -> sonic_pma_phy_mgmt_translator:uav_lock
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_read;                    // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_read -> sonic_pma_phy_mgmt_translator:uav_read
	wire  [31:0] sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdata;                // sonic_pma_phy_mgmt_translator:uav_readdata -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdatavalid;           // sonic_pma_phy_mgmt_translator:uav_readdatavalid -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_debugaccess;             // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_debugaccess -> sonic_pma_phy_mgmt_translator:uav_debugaccess
	wire   [3:0] sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_byteenable;              // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:m0_byteenable -> sonic_pma_phy_mgmt_translator:uav_byteenable
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;      // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_valid;            // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_source_valid -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;    // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [85:0] sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_data;             // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_source_data -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_ready;            // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;   // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;         // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket; // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [85:0] sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;          // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;         // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rf_sink_ready -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;       // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;        // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;       // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         jtag_master_master_translator_avalon_universal_master_0_agent_cp_endofpacket;            // jtag_master_master_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router:sink_endofpacket
	wire         jtag_master_master_translator_avalon_universal_master_0_agent_cp_valid;                  // jtag_master_master_translator_avalon_universal_master_0_agent:cp_valid -> addr_router:sink_valid
	wire         jtag_master_master_translator_avalon_universal_master_0_agent_cp_startofpacket;          // jtag_master_master_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router:sink_startofpacket
	wire  [84:0] jtag_master_master_translator_avalon_universal_master_0_agent_cp_data;                   // jtag_master_master_translator_avalon_universal_master_0_agent:cp_data -> addr_router:sink_data
	wire         jtag_master_master_translator_avalon_universal_master_0_agent_cp_ready;                  // addr_router:sink_ready -> jtag_master_master_translator_avalon_universal_master_0_agent:cp_ready
	wire         mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_endofpacket;         // mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router_001:sink_endofpacket
	wire         mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_valid;               // mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:cp_valid -> addr_router_001:sink_valid
	wire         mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_startofpacket;       // mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router_001:sink_startofpacket
	wire  [84:0] mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_data;                // mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:cp_data -> addr_router_001:sink_data
	wire         mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_ready;               // addr_router_001:sink_ready -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:cp_ready
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket;                       // mdio_csr_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router:sink_endofpacket
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rp_valid;                             // mdio_csr_translator_avalon_universal_slave_0_agent:rp_valid -> id_router:sink_valid
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket;                     // mdio_csr_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router:sink_startofpacket
	wire  [84:0] mdio_csr_translator_avalon_universal_slave_0_agent_rp_data;                              // mdio_csr_translator_avalon_universal_slave_0_agent:rp_data -> id_router:sink_data
	wire         mdio_csr_translator_avalon_universal_slave_0_agent_rp_ready;                             // id_router:sink_ready -> mdio_csr_translator_avalon_universal_slave_0_agent:rp_ready
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_endofpacket;              // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_001:sink_endofpacket
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_valid;                    // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_001:sink_valid
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_startofpacket;            // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_001:sink_startofpacket
	wire  [84:0] avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_data;                     // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rp_data -> id_router_001:sink_data
	wire         avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_ready;                    // id_router_001:sink_ready -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:rp_ready
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_endofpacket;             // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_002:sink_endofpacket
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_valid;                   // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_002:sink_valid
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_startofpacket;           // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_002:sink_startofpacket
	wire  [84:0] sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_data;                    // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rp_data -> id_router_002:sink_data
	wire         sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_ready;                   // id_router_002:sink_ready -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:rp_ready
	wire         addr_router_src_endofpacket;                                                             // addr_router:src_endofpacket -> limiter:cmd_sink_endofpacket
	wire         addr_router_src_valid;                                                                   // addr_router:src_valid -> limiter:cmd_sink_valid
	wire         addr_router_src_startofpacket;                                                           // addr_router:src_startofpacket -> limiter:cmd_sink_startofpacket
	wire  [84:0] addr_router_src_data;                                                                    // addr_router:src_data -> limiter:cmd_sink_data
	wire   [2:0] addr_router_src_channel;                                                                 // addr_router:src_channel -> limiter:cmd_sink_channel
	wire         addr_router_src_ready;                                                                   // limiter:cmd_sink_ready -> addr_router:src_ready
	wire         limiter_rsp_src_endofpacket;                                                             // limiter:rsp_src_endofpacket -> jtag_master_master_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_rsp_src_valid;                                                                   // limiter:rsp_src_valid -> jtag_master_master_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_rsp_src_startofpacket;                                                           // limiter:rsp_src_startofpacket -> jtag_master_master_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [84:0] limiter_rsp_src_data;                                                                    // limiter:rsp_src_data -> jtag_master_master_translator_avalon_universal_master_0_agent:rp_data
	wire   [2:0] limiter_rsp_src_channel;                                                                 // limiter:rsp_src_channel -> jtag_master_master_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_rsp_src_ready;                                                                   // jtag_master_master_translator_avalon_universal_master_0_agent:rp_ready -> limiter:rsp_src_ready
	wire         addr_router_001_src_endofpacket;                                                         // addr_router_001:src_endofpacket -> limiter_001:cmd_sink_endofpacket
	wire         addr_router_001_src_valid;                                                               // addr_router_001:src_valid -> limiter_001:cmd_sink_valid
	wire         addr_router_001_src_startofpacket;                                                       // addr_router_001:src_startofpacket -> limiter_001:cmd_sink_startofpacket
	wire  [84:0] addr_router_001_src_data;                                                                // addr_router_001:src_data -> limiter_001:cmd_sink_data
	wire   [2:0] addr_router_001_src_channel;                                                             // addr_router_001:src_channel -> limiter_001:cmd_sink_channel
	wire         addr_router_001_src_ready;                                                               // limiter_001:cmd_sink_ready -> addr_router_001:src_ready
	wire         limiter_001_rsp_src_endofpacket;                                                         // limiter_001:rsp_src_endofpacket -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_001_rsp_src_valid;                                                               // limiter_001:rsp_src_valid -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_001_rsp_src_startofpacket;                                                       // limiter_001:rsp_src_startofpacket -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [84:0] limiter_001_rsp_src_data;                                                                // limiter_001:rsp_src_data -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:rp_data
	wire   [2:0] limiter_001_rsp_src_channel;                                                             // limiter_001:rsp_src_channel -> mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_001_rsp_src_ready;                                                               // mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:rp_ready -> limiter_001:rsp_src_ready
	wire         rst_controller_reset_out_reset;                                                          // rst_controller:reset_out -> [addr_router:reset, addr_router_001:reset, cmd_xbar_demux:reset, cmd_xbar_demux_001:reset, cmd_xbar_mux:reset, id_router:reset, jtag_master:clk_reset_reset, jtag_master_master_translator:reset, jtag_master_master_translator_avalon_universal_master_0_agent:reset, limiter:reset, limiter_001:reset, mdio:reset, mdio_csr_translator:reset, mdio_csr_translator_avalon_universal_slave_0_agent:reset, mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, mm_pipeline_bridge:reset, mm_pipeline_bridge_m0_translator:reset, mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent:reset, rsp_xbar_demux:reset, rsp_xbar_mux:reset, rsp_xbar_mux_001:reset]
	wire         rst_controller_001_reset_out_reset;                                                      // rst_controller_001:reset_out -> [avalon_slave_0:reset, avalon_slave_0_s0_translator:reset, avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:reset, avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, cmd_xbar_mux_001:reset, id_router_001:reset, rsp_xbar_demux_001:reset]
	wire         jtag_master_master_reset_reset;                                                          // jtag_master:master_reset_reset -> rst_controller_001:reset_in0
	wire         rst_controller_002_reset_out_reset;                                                      // rst_controller_002:reset_out -> [id_router_002:reset, rsp_xbar_demux_002:reset, sonic_pma:phy_mgmt_clk_reset, sonic_pma_phy_mgmt_translator:reset, sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:reset, sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo:reset]
	wire         cmd_xbar_demux_src0_endofpacket;                                                         // cmd_xbar_demux:src0_endofpacket -> cmd_xbar_mux:sink0_endofpacket
	wire         cmd_xbar_demux_src0_valid;                                                               // cmd_xbar_demux:src0_valid -> cmd_xbar_mux:sink0_valid
	wire         cmd_xbar_demux_src0_startofpacket;                                                       // cmd_xbar_demux:src0_startofpacket -> cmd_xbar_mux:sink0_startofpacket
	wire  [84:0] cmd_xbar_demux_src0_data;                                                                // cmd_xbar_demux:src0_data -> cmd_xbar_mux:sink0_data
	wire   [2:0] cmd_xbar_demux_src0_channel;                                                             // cmd_xbar_demux:src0_channel -> cmd_xbar_mux:sink0_channel
	wire         cmd_xbar_demux_src0_ready;                                                               // cmd_xbar_mux:sink0_ready -> cmd_xbar_demux:src0_ready
	wire         cmd_xbar_demux_src1_endofpacket;                                                         // cmd_xbar_demux:src1_endofpacket -> cmd_xbar_mux_001:sink0_endofpacket
	wire         cmd_xbar_demux_src1_valid;                                                               // cmd_xbar_demux:src1_valid -> cmd_xbar_mux_001:sink0_valid
	wire         cmd_xbar_demux_src1_startofpacket;                                                       // cmd_xbar_demux:src1_startofpacket -> cmd_xbar_mux_001:sink0_startofpacket
	wire  [84:0] cmd_xbar_demux_src1_data;                                                                // cmd_xbar_demux:src1_data -> cmd_xbar_mux_001:sink0_data
	wire   [2:0] cmd_xbar_demux_src1_channel;                                                             // cmd_xbar_demux:src1_channel -> cmd_xbar_mux_001:sink0_channel
	wire         cmd_xbar_demux_src1_ready;                                                               // cmd_xbar_mux_001:sink0_ready -> cmd_xbar_demux:src1_ready
	wire         cmd_xbar_demux_src2_endofpacket;                                                         // cmd_xbar_demux:src2_endofpacket -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_demux_src2_valid;                                                               // cmd_xbar_demux:src2_valid -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_demux_src2_startofpacket;                                                       // cmd_xbar_demux:src2_startofpacket -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [84:0] cmd_xbar_demux_src2_data;                                                                // cmd_xbar_demux:src2_data -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_data
	wire   [2:0] cmd_xbar_demux_src2_channel;                                                             // cmd_xbar_demux:src2_channel -> sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_demux_001_src0_endofpacket;                                                     // cmd_xbar_demux_001:src0_endofpacket -> cmd_xbar_mux:sink1_endofpacket
	wire         cmd_xbar_demux_001_src0_valid;                                                           // cmd_xbar_demux_001:src0_valid -> cmd_xbar_mux:sink1_valid
	wire         cmd_xbar_demux_001_src0_startofpacket;                                                   // cmd_xbar_demux_001:src0_startofpacket -> cmd_xbar_mux:sink1_startofpacket
	wire  [84:0] cmd_xbar_demux_001_src0_data;                                                            // cmd_xbar_demux_001:src0_data -> cmd_xbar_mux:sink1_data
	wire   [2:0] cmd_xbar_demux_001_src0_channel;                                                         // cmd_xbar_demux_001:src0_channel -> cmd_xbar_mux:sink1_channel
	wire         cmd_xbar_demux_001_src0_ready;                                                           // cmd_xbar_mux:sink1_ready -> cmd_xbar_demux_001:src0_ready
	wire         cmd_xbar_demux_001_src1_endofpacket;                                                     // cmd_xbar_demux_001:src1_endofpacket -> cmd_xbar_mux_001:sink1_endofpacket
	wire         cmd_xbar_demux_001_src1_valid;                                                           // cmd_xbar_demux_001:src1_valid -> cmd_xbar_mux_001:sink1_valid
	wire         cmd_xbar_demux_001_src1_startofpacket;                                                   // cmd_xbar_demux_001:src1_startofpacket -> cmd_xbar_mux_001:sink1_startofpacket
	wire  [84:0] cmd_xbar_demux_001_src1_data;                                                            // cmd_xbar_demux_001:src1_data -> cmd_xbar_mux_001:sink1_data
	wire   [2:0] cmd_xbar_demux_001_src1_channel;                                                         // cmd_xbar_demux_001:src1_channel -> cmd_xbar_mux_001:sink1_channel
	wire         cmd_xbar_demux_001_src1_ready;                                                           // cmd_xbar_mux_001:sink1_ready -> cmd_xbar_demux_001:src1_ready
	wire         rsp_xbar_demux_src0_endofpacket;                                                         // rsp_xbar_demux:src0_endofpacket -> rsp_xbar_mux:sink0_endofpacket
	wire         rsp_xbar_demux_src0_valid;                                                               // rsp_xbar_demux:src0_valid -> rsp_xbar_mux:sink0_valid
	wire         rsp_xbar_demux_src0_startofpacket;                                                       // rsp_xbar_demux:src0_startofpacket -> rsp_xbar_mux:sink0_startofpacket
	wire  [84:0] rsp_xbar_demux_src0_data;                                                                // rsp_xbar_demux:src0_data -> rsp_xbar_mux:sink0_data
	wire   [2:0] rsp_xbar_demux_src0_channel;                                                             // rsp_xbar_demux:src0_channel -> rsp_xbar_mux:sink0_channel
	wire         rsp_xbar_demux_src0_ready;                                                               // rsp_xbar_mux:sink0_ready -> rsp_xbar_demux:src0_ready
	wire         rsp_xbar_demux_src1_endofpacket;                                                         // rsp_xbar_demux:src1_endofpacket -> rsp_xbar_mux_001:sink0_endofpacket
	wire         rsp_xbar_demux_src1_valid;                                                               // rsp_xbar_demux:src1_valid -> rsp_xbar_mux_001:sink0_valid
	wire         rsp_xbar_demux_src1_startofpacket;                                                       // rsp_xbar_demux:src1_startofpacket -> rsp_xbar_mux_001:sink0_startofpacket
	wire  [84:0] rsp_xbar_demux_src1_data;                                                                // rsp_xbar_demux:src1_data -> rsp_xbar_mux_001:sink0_data
	wire   [2:0] rsp_xbar_demux_src1_channel;                                                             // rsp_xbar_demux:src1_channel -> rsp_xbar_mux_001:sink0_channel
	wire         rsp_xbar_demux_src1_ready;                                                               // rsp_xbar_mux_001:sink0_ready -> rsp_xbar_demux:src1_ready
	wire         rsp_xbar_demux_001_src0_endofpacket;                                                     // rsp_xbar_demux_001:src0_endofpacket -> rsp_xbar_mux:sink1_endofpacket
	wire         rsp_xbar_demux_001_src0_valid;                                                           // rsp_xbar_demux_001:src0_valid -> rsp_xbar_mux:sink1_valid
	wire         rsp_xbar_demux_001_src0_startofpacket;                                                   // rsp_xbar_demux_001:src0_startofpacket -> rsp_xbar_mux:sink1_startofpacket
	wire  [84:0] rsp_xbar_demux_001_src0_data;                                                            // rsp_xbar_demux_001:src0_data -> rsp_xbar_mux:sink1_data
	wire   [2:0] rsp_xbar_demux_001_src0_channel;                                                         // rsp_xbar_demux_001:src0_channel -> rsp_xbar_mux:sink1_channel
	wire         rsp_xbar_demux_001_src0_ready;                                                           // rsp_xbar_mux:sink1_ready -> rsp_xbar_demux_001:src0_ready
	wire         rsp_xbar_demux_001_src1_endofpacket;                                                     // rsp_xbar_demux_001:src1_endofpacket -> rsp_xbar_mux_001:sink1_endofpacket
	wire         rsp_xbar_demux_001_src1_valid;                                                           // rsp_xbar_demux_001:src1_valid -> rsp_xbar_mux_001:sink1_valid
	wire         rsp_xbar_demux_001_src1_startofpacket;                                                   // rsp_xbar_demux_001:src1_startofpacket -> rsp_xbar_mux_001:sink1_startofpacket
	wire  [84:0] rsp_xbar_demux_001_src1_data;                                                            // rsp_xbar_demux_001:src1_data -> rsp_xbar_mux_001:sink1_data
	wire   [2:0] rsp_xbar_demux_001_src1_channel;                                                         // rsp_xbar_demux_001:src1_channel -> rsp_xbar_mux_001:sink1_channel
	wire         rsp_xbar_demux_001_src1_ready;                                                           // rsp_xbar_mux_001:sink1_ready -> rsp_xbar_demux_001:src1_ready
	wire         rsp_xbar_demux_002_src0_endofpacket;                                                     // rsp_xbar_demux_002:src0_endofpacket -> rsp_xbar_mux:sink2_endofpacket
	wire         rsp_xbar_demux_002_src0_valid;                                                           // rsp_xbar_demux_002:src0_valid -> rsp_xbar_mux:sink2_valid
	wire         rsp_xbar_demux_002_src0_startofpacket;                                                   // rsp_xbar_demux_002:src0_startofpacket -> rsp_xbar_mux:sink2_startofpacket
	wire  [84:0] rsp_xbar_demux_002_src0_data;                                                            // rsp_xbar_demux_002:src0_data -> rsp_xbar_mux:sink2_data
	wire   [2:0] rsp_xbar_demux_002_src0_channel;                                                         // rsp_xbar_demux_002:src0_channel -> rsp_xbar_mux:sink2_channel
	wire         rsp_xbar_demux_002_src0_ready;                                                           // rsp_xbar_mux:sink2_ready -> rsp_xbar_demux_002:src0_ready
	wire         limiter_cmd_src_endofpacket;                                                             // limiter:cmd_src_endofpacket -> cmd_xbar_demux:sink_endofpacket
	wire         limiter_cmd_src_startofpacket;                                                           // limiter:cmd_src_startofpacket -> cmd_xbar_demux:sink_startofpacket
	wire  [84:0] limiter_cmd_src_data;                                                                    // limiter:cmd_src_data -> cmd_xbar_demux:sink_data
	wire   [2:0] limiter_cmd_src_channel;                                                                 // limiter:cmd_src_channel -> cmd_xbar_demux:sink_channel
	wire         limiter_cmd_src_ready;                                                                   // cmd_xbar_demux:sink_ready -> limiter:cmd_src_ready
	wire         rsp_xbar_mux_src_endofpacket;                                                            // rsp_xbar_mux:src_endofpacket -> limiter:rsp_sink_endofpacket
	wire         rsp_xbar_mux_src_valid;                                                                  // rsp_xbar_mux:src_valid -> limiter:rsp_sink_valid
	wire         rsp_xbar_mux_src_startofpacket;                                                          // rsp_xbar_mux:src_startofpacket -> limiter:rsp_sink_startofpacket
	wire  [84:0] rsp_xbar_mux_src_data;                                                                   // rsp_xbar_mux:src_data -> limiter:rsp_sink_data
	wire   [2:0] rsp_xbar_mux_src_channel;                                                                // rsp_xbar_mux:src_channel -> limiter:rsp_sink_channel
	wire         rsp_xbar_mux_src_ready;                                                                  // limiter:rsp_sink_ready -> rsp_xbar_mux:src_ready
	wire         limiter_001_cmd_src_endofpacket;                                                         // limiter_001:cmd_src_endofpacket -> cmd_xbar_demux_001:sink_endofpacket
	wire         limiter_001_cmd_src_startofpacket;                                                       // limiter_001:cmd_src_startofpacket -> cmd_xbar_demux_001:sink_startofpacket
	wire  [84:0] limiter_001_cmd_src_data;                                                                // limiter_001:cmd_src_data -> cmd_xbar_demux_001:sink_data
	wire   [2:0] limiter_001_cmd_src_channel;                                                             // limiter_001:cmd_src_channel -> cmd_xbar_demux_001:sink_channel
	wire         limiter_001_cmd_src_ready;                                                               // cmd_xbar_demux_001:sink_ready -> limiter_001:cmd_src_ready
	wire         rsp_xbar_mux_001_src_endofpacket;                                                        // rsp_xbar_mux_001:src_endofpacket -> limiter_001:rsp_sink_endofpacket
	wire         rsp_xbar_mux_001_src_valid;                                                              // rsp_xbar_mux_001:src_valid -> limiter_001:rsp_sink_valid
	wire         rsp_xbar_mux_001_src_startofpacket;                                                      // rsp_xbar_mux_001:src_startofpacket -> limiter_001:rsp_sink_startofpacket
	wire  [84:0] rsp_xbar_mux_001_src_data;                                                               // rsp_xbar_mux_001:src_data -> limiter_001:rsp_sink_data
	wire   [2:0] rsp_xbar_mux_001_src_channel;                                                            // rsp_xbar_mux_001:src_channel -> limiter_001:rsp_sink_channel
	wire         rsp_xbar_mux_001_src_ready;                                                              // limiter_001:rsp_sink_ready -> rsp_xbar_mux_001:src_ready
	wire         cmd_xbar_mux_src_endofpacket;                                                            // cmd_xbar_mux:src_endofpacket -> mdio_csr_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_mux_src_valid;                                                                  // cmd_xbar_mux:src_valid -> mdio_csr_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_mux_src_startofpacket;                                                          // cmd_xbar_mux:src_startofpacket -> mdio_csr_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [84:0] cmd_xbar_mux_src_data;                                                                   // cmd_xbar_mux:src_data -> mdio_csr_translator_avalon_universal_slave_0_agent:cp_data
	wire   [2:0] cmd_xbar_mux_src_channel;                                                                // cmd_xbar_mux:src_channel -> mdio_csr_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_mux_src_ready;                                                                  // mdio_csr_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_mux:src_ready
	wire         id_router_src_endofpacket;                                                               // id_router:src_endofpacket -> rsp_xbar_demux:sink_endofpacket
	wire         id_router_src_valid;                                                                     // id_router:src_valid -> rsp_xbar_demux:sink_valid
	wire         id_router_src_startofpacket;                                                             // id_router:src_startofpacket -> rsp_xbar_demux:sink_startofpacket
	wire  [84:0] id_router_src_data;                                                                      // id_router:src_data -> rsp_xbar_demux:sink_data
	wire   [2:0] id_router_src_channel;                                                                   // id_router:src_channel -> rsp_xbar_demux:sink_channel
	wire         id_router_src_ready;                                                                     // rsp_xbar_demux:sink_ready -> id_router:src_ready
	wire         cmd_xbar_mux_001_src_endofpacket;                                                        // cmd_xbar_mux_001:src_endofpacket -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         cmd_xbar_mux_001_src_valid;                                                              // cmd_xbar_mux_001:src_valid -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:cp_valid
	wire         cmd_xbar_mux_001_src_startofpacket;                                                      // cmd_xbar_mux_001:src_startofpacket -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [84:0] cmd_xbar_mux_001_src_data;                                                               // cmd_xbar_mux_001:src_data -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:cp_data
	wire   [2:0] cmd_xbar_mux_001_src_channel;                                                            // cmd_xbar_mux_001:src_channel -> avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:cp_channel
	wire         cmd_xbar_mux_001_src_ready;                                                              // avalon_slave_0_s0_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_mux_001:src_ready
	wire         id_router_001_src_endofpacket;                                                           // id_router_001:src_endofpacket -> rsp_xbar_demux_001:sink_endofpacket
	wire         id_router_001_src_valid;                                                                 // id_router_001:src_valid -> rsp_xbar_demux_001:sink_valid
	wire         id_router_001_src_startofpacket;                                                         // id_router_001:src_startofpacket -> rsp_xbar_demux_001:sink_startofpacket
	wire  [84:0] id_router_001_src_data;                                                                  // id_router_001:src_data -> rsp_xbar_demux_001:sink_data
	wire   [2:0] id_router_001_src_channel;                                                               // id_router_001:src_channel -> rsp_xbar_demux_001:sink_channel
	wire         id_router_001_src_ready;                                                                 // rsp_xbar_demux_001:sink_ready -> id_router_001:src_ready
	wire         cmd_xbar_demux_src2_ready;                                                               // sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent:cp_ready -> cmd_xbar_demux:src2_ready
	wire         id_router_002_src_endofpacket;                                                           // id_router_002:src_endofpacket -> rsp_xbar_demux_002:sink_endofpacket
	wire         id_router_002_src_valid;                                                                 // id_router_002:src_valid -> rsp_xbar_demux_002:sink_valid
	wire         id_router_002_src_startofpacket;                                                         // id_router_002:src_startofpacket -> rsp_xbar_demux_002:sink_startofpacket
	wire  [84:0] id_router_002_src_data;                                                                  // id_router_002:src_data -> rsp_xbar_demux_002:sink_data
	wire   [2:0] id_router_002_src_channel;                                                               // id_router_002:src_channel -> rsp_xbar_demux_002:sink_channel
	wire         id_router_002_src_ready;                                                                 // rsp_xbar_demux_002:sink_ready -> id_router_002:src_ready
	wire   [2:0] limiter_cmd_valid_data;                                                                  // limiter:cmd_src_valid -> cmd_xbar_demux:sink_valid
	wire   [2:0] limiter_001_cmd_valid_data;                                                              // limiter_001:cmd_src_valid -> cmd_xbar_demux_001:sink_valid

	altera_eth_mdio #(
		.MDC_DIVISOR (32)
	) mdio (
		.clk             (mm_clk_in_clk),                                       //       clock.clk
		.reset           (rst_controller_reset_out_reset),                      // clock_reset.reset
		.csr_write       (mdio_csr_translator_avalon_anti_slave_0_write),       //         csr.write
		.csr_read        (mdio_csr_translator_avalon_anti_slave_0_read),        //            .read
		.csr_address     (mdio_csr_translator_avalon_anti_slave_0_address),     //            .address
		.csr_writedata   (mdio_csr_translator_avalon_anti_slave_0_writedata),   //            .writedata
		.csr_readdata    (mdio_csr_translator_avalon_anti_slave_0_readdata),    //            .readdata
		.csr_waitrequest (mdio_csr_translator_avalon_anti_slave_0_waitrequest), //            .waitrequest
		.mdc             (mdio_mdc),                                            //        mdio.export
		.mdio_in         (mdio_mdio_in),                                        //            .export
		.mdio_out        (mdio_mdio_out),                                       //            .export
		.mdio_oen        (mdio_mdio_oen)                                        //            .export
	);

	sonic_v1_15_jtag_master #(
		.USE_PLI     (0),
		.PLI_PORT    (50000),
		.FIFO_DEPTHS (2)
	) jtag_master (
		.clk_clk              (mm_clk_in_clk),                    //          clk.clk
		.clk_reset_reset      (rst_controller_reset_out_reset),   //    clk_reset.reset
		.master_address       (jtag_master_master_address),       //       master.address
		.master_readdata      (jtag_master_master_readdata),      //             .readdata
		.master_read          (jtag_master_master_read),          //             .read
		.master_write         (jtag_master_master_write),         //             .write
		.master_writedata     (jtag_master_master_writedata),     //             .writedata
		.master_waitrequest   (jtag_master_master_waitrequest),   //             .waitrequest
		.master_readdatavalid (jtag_master_master_readdatavalid), //             .readdatavalid
		.master_byteenable    (jtag_master_master_byteenable),    //             .byteenable
		.master_reset_reset   (jtag_master_master_reset_reset)    // master_reset.reset
	);

	altera_avalon_mm_bridge #(
		.DATA_WIDTH        (32),
		.SYMBOL_WIDTH      (8),
		.ADDRESS_WIDTH     (19),
		.BURSTCOUNT_WIDTH  (1),
		.PIPELINE_COMMAND  (1),
		.PIPELINE_RESPONSE (1)
	) mm_pipeline_bridge (
		.clk              (mm_clk_in_clk),                       //   clk.clk
		.reset            (rst_controller_reset_out_reset),      // reset.reset
		.s0_waitrequest   (mm_pipeline_bridge_waitrequest),      //    s0.waitrequest
		.s0_readdata      (mm_pipeline_bridge_readdata),         //      .readdata
		.s0_readdatavalid (mm_pipeline_bridge_readdatavalid),    //      .readdatavalid
		.s0_burstcount    (mm_pipeline_bridge_burstcount),       //      .burstcount
		.s0_writedata     (mm_pipeline_bridge_writedata),        //      .writedata
		.s0_address       (mm_pipeline_bridge_address),          //      .address
		.s0_write         (mm_pipeline_bridge_write),            //      .write
		.s0_read          (mm_pipeline_bridge_read),             //      .read
		.s0_byteenable    (mm_pipeline_bridge_byteenable),       //      .byteenable
		.s0_debugaccess   (mm_pipeline_bridge_debugaccess),      //      .debugaccess
		.m0_waitrequest   (mm_pipeline_bridge_m0_waitrequest),   //    m0.waitrequest
		.m0_readdata      (mm_pipeline_bridge_m0_readdata),      //      .readdata
		.m0_readdatavalid (mm_pipeline_bridge_m0_readdatavalid), //      .readdatavalid
		.m0_burstcount    (mm_pipeline_bridge_m0_burstcount),    //      .burstcount
		.m0_writedata     (mm_pipeline_bridge_m0_writedata),     //      .writedata
		.m0_address       (mm_pipeline_bridge_m0_address),       //      .address
		.m0_write         (mm_pipeline_bridge_m0_write),         //      .write
		.m0_read          (mm_pipeline_bridge_m0_read),          //      .read
		.m0_byteenable    (mm_pipeline_bridge_m0_byteenable),    //      .byteenable
		.m0_debugaccess   (mm_pipeline_bridge_m0_debugaccess)    //      .debugaccess
	);

	avalon_mm_slave #(
		.DATA_WIDTH          (32),
		.ENABLE_SYNC_SIGNALS (0),
		.MODE_0              (2),
		.MODE_1              (4),
		.MODE_2              (4),
		.MODE_3              (4),
		.MODE_4              (4),
		.MODE_5              (4),
		.MODE_6              (4),
		.MODE_7              (4),
		.MODE_8              (4),
		.MODE_9              (4),
		.MODE_10             (4),
		.MODE_11             (4),
		.MODE_12             (4),
		.MODE_13             (4),
		.MODE_14             (4),
		.MODE_15             (4),
		.IRQ_EN              (1)
	) avalon_slave_0 (
		.clk              (mm_clk_in_clk),                                               //          clock.clk
		.reset            (rst_controller_001_reset_out_reset),                          //    clock_reset.reset
		.slave_address    (avalon_slave_0_s0_translator_avalon_anti_slave_0_address),    //             s0.address
		.slave_read       (avalon_slave_0_s0_translator_avalon_anti_slave_0_read),       //               .read
		.slave_write      (avalon_slave_0_s0_translator_avalon_anti_slave_0_write),      //               .write
		.slave_readdata   (avalon_slave_0_s0_translator_avalon_anti_slave_0_readdata),   //               .readdata
		.slave_writedata  (avalon_slave_0_s0_translator_avalon_anti_slave_0_writedata),  //               .writedata
		.slave_byteenable (avalon_slave_0_s0_translator_avalon_anti_slave_0_byteenable), //               .byteenable
		.slave_irq        (),                                                            //        slv_irq.irq
		.user_dataout_0   (user_interface_dataout_0),                                    // user_interface.export
		.user_dataout_1   (user_interface_dataout_1),                                    //               .export
		.user_dataout_2   (user_interface_dataout_2),                                    //               .export
		.user_dataout_3   (user_interface_dataout_3),                                    //               .export
		.user_dataout_4   (user_interface_dataout_4),                                    //               .export
		.user_dataout_5   (user_interface_dataout_5),                                    //               .export
		.user_dataout_6   (user_interface_dataout_6),                                    //               .export
		.user_dataout_7   (user_interface_dataout_7),                                    //               .export
		.user_dataout_8   (user_interface_dataout_8),                                    //               .export
		.user_dataout_9   (user_interface_dataout_9),                                    //               .export
		.user_dataout_10  (user_interface_dataout_10),                                   //               .export
		.user_dataout_11  (user_interface_dataout_11),                                   //               .export
		.user_dataout_12  (user_interface_dataout_12),                                   //               .export
		.user_dataout_13  (user_interface_dataout_13),                                   //               .export
		.user_dataout_14  (user_interface_dataout_14),                                   //               .export
		.user_dataout_15  (user_interface_dataout_15),                                   //               .export
		.user_datain_0    (user_interface_datain_0),                                     //               .export
		.user_datain_1    (user_interface_datain_1),                                     //               .export
		.user_datain_2    (user_interface_datain_2),                                     //               .export
		.user_datain_3    (user_interface_datain_3),                                     //               .export
		.user_datain_4    (user_interface_datain_4),                                     //               .export
		.user_datain_5    (user_interface_datain_5),                                     //               .export
		.user_datain_6    (user_interface_datain_6),                                     //               .export
		.user_datain_7    (user_interface_datain_7),                                     //               .export
		.user_datain_8    (user_interface_datain_8),                                     //               .export
		.user_datain_9    (user_interface_datain_9),                                     //               .export
		.user_datain_10   (user_interface_datain_10),                                    //               .export
		.user_datain_11   (user_interface_datain_11),                                    //               .export
		.user_datain_12   (user_interface_datain_12),                                    //               .export
		.user_datain_13   (user_interface_datain_13),                                    //               .export
		.user_datain_14   (user_interface_datain_14),                                    //               .export
		.user_datain_15   (user_interface_datain_15),                                    //               .export
		.user_write       (user_interface_write),                                        //               .export
		.user_read        (user_interface_read),                                         //               .export
		.user_chipselect  (user_interface_chipselect),                                   //               .export
		.user_byteenable  (user_interface_byteenable)                                    //               .export
	);

	sonic_pma_v1_01 sonic_pma (
		.phy_mgmt_address     (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_address),     //           phy_mgmt.address
		.phy_mgmt_read        (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_read),        //                   .read
		.phy_mgmt_readdata    (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_readdata),    //                   .readdata
		.phy_mgmt_waitrequest (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_waitrequest), //                   .waitrequest
		.phy_mgmt_write       (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_write),       //                   .write
		.phy_mgmt_writedata   (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_writedata),   //                   .writedata
		.phy_mgmt_clk         (mm_clk_in_clk),                                                 //       phy_mgmt_clk.clk
		.tx_ready             (tx_ready_export),                                               //           tx_ready.export
		.rx_ready             (rx_ready_export),                                               //           rx_ready.export
		.pll_ref_clk          (ref_clk_in_clk),                                                //        pll_ref_clk.clk
		.pll_locked           (pll_locked_export),                                             //         pll_locked.export
		.tx_serial_data       (tx_serial_data_export),                                         //     tx_serial_data.export
		.rx_serial_data       (rx_serial_data_export),                                         //     rx_serial_data.export
		.rx_is_lockedtoref    (rx_is_lockedtoref_export),                                      //  rx_is_lockedtoref.export
		.rx_is_lockedtodata   (rx_is_lockedtodata_export),                                     // rx_is_lockedtodata.export
		.tx_clkout0           (tx_clkout_clk),                                                 //        tx_clkout_0.clk
		.rx_clkout0           (rx_clkout_clk),                                                 //        rx_clkout_0.clk
		.phy_mgmt_clk_reset   (rst_controller_002_reset_out_reset),                            // phy_mgmt_clk_reset.reset
		.rx_parallel_data0    (rx_parallel_data_data),                                         //  rx_parallel_data0.data
		.tx_parallel_data0    (tx_parallel_data_data)                                          //  tx_parallel_data0.data
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (32),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (32),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) jtag_master_master_translator (
		.clk                   (mm_clk_in_clk),                                                         //                       clk.clk
		.reset                 (rst_controller_reset_out_reset),                                        //                     reset.reset
		.uav_address           (jtag_master_master_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (jtag_master_master_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (jtag_master_master_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (jtag_master_master_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (jtag_master_master_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (jtag_master_master_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (jtag_master_master_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (jtag_master_master_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (jtag_master_master_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (jtag_master_master_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (jtag_master_master_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (jtag_master_master_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (jtag_master_master_waitrequest),                                        //                          .waitrequest
		.av_byteenable         (jtag_master_master_byteenable),                                         //                          .byteenable
		.av_read               (jtag_master_master_read),                                               //                          .read
		.av_readdata           (jtag_master_master_readdata),                                           //                          .readdata
		.av_readdatavalid      (jtag_master_master_readdatavalid),                                      //                          .readdatavalid
		.av_write              (jtag_master_master_write),                                              //                          .write
		.av_writedata          (jtag_master_master_writedata),                                          //                          .writedata
		.av_burstcount         (1'b1),                                                                  //               (terminated)
		.av_beginbursttransfer (1'b0),                                                                  //               (terminated)
		.av_begintransfer      (1'b0),                                                                  //               (terminated)
		.av_chipselect         (1'b0),                                                                  //               (terminated)
		.av_lock               (1'b0),                                                                  //               (terminated)
		.av_debugaccess        (1'b0),                                                                  //               (terminated)
		.uav_clken             (),                                                                      //               (terminated)
		.av_clken              (1'b1)                                                                   //               (terminated)
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (19),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
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
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) mm_pipeline_bridge_m0_translator (
		.clk                   (mm_clk_in_clk),                                                            //                       clk.clk
		.reset                 (rst_controller_reset_out_reset),                                           //                     reset.reset
		.uav_address           (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (mm_pipeline_bridge_m0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (mm_pipeline_bridge_m0_waitrequest),                                        //                          .waitrequest
		.av_burstcount         (mm_pipeline_bridge_m0_burstcount),                                         //                          .burstcount
		.av_byteenable         (mm_pipeline_bridge_m0_byteenable),                                         //                          .byteenable
		.av_read               (mm_pipeline_bridge_m0_read),                                               //                          .read
		.av_readdata           (mm_pipeline_bridge_m0_readdata),                                           //                          .readdata
		.av_readdatavalid      (mm_pipeline_bridge_m0_readdatavalid),                                      //                          .readdatavalid
		.av_write              (mm_pipeline_bridge_m0_write),                                              //                          .write
		.av_writedata          (mm_pipeline_bridge_m0_writedata),                                          //                          .writedata
		.av_debugaccess        (mm_pipeline_bridge_m0_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer (1'b0),                                                                     //               (terminated)
		.av_begintransfer      (1'b0),                                                                     //               (terminated)
		.av_chipselect         (1'b0),                                                                     //               (terminated)
		.av_lock               (1'b0),                                                                     //               (terminated)
		.uav_clken             (),                                                                         //               (terminated)
		.av_clken              (1'b1)                                                                      //               (terminated)
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
	) mdio_csr_translator (
		.clk                   (mm_clk_in_clk),                                                       //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                      //                    reset.reset
		.uav_address           (mdio_csr_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (mdio_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (mdio_csr_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (mdio_csr_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (mdio_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (mdio_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (mdio_csr_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (mdio_csr_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (mdio_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (mdio_csr_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (mdio_csr_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (mdio_csr_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (mdio_csr_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (mdio_csr_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (mdio_csr_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                    //              (terminated)
		.av_beginbursttransfer (),                                                                    //              (terminated)
		.av_burstcount         (),                                                                    //              (terminated)
		.av_byteenable         (),                                                                    //              (terminated)
		.av_readdatavalid      (1'b0),                                                                //              (terminated)
		.av_writebyteenable    (),                                                                    //              (terminated)
		.av_lock               (),                                                                    //              (terminated)
		.av_chipselect         (),                                                                    //              (terminated)
		.av_clken              (),                                                                    //              (terminated)
		.uav_clken             (1'b0),                                                                //              (terminated)
		.av_debugaccess        (),                                                                    //              (terminated)
		.av_outputenable       ()                                                                     //              (terminated)
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
		.AV_READLATENCY                 (3),
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
	) avalon_slave_0_s0_translator (
		.clk                   (mm_clk_in_clk),                                                                //                      clk.clk
		.reset                 (rst_controller_001_reset_out_reset),                                           //                    reset.reset
		.uav_address           (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (avalon_slave_0_s0_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (avalon_slave_0_s0_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (avalon_slave_0_s0_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (avalon_slave_0_s0_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (avalon_slave_0_s0_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_byteenable         (avalon_slave_0_s0_translator_avalon_anti_slave_0_byteenable),                  //                         .byteenable
		.av_begintransfer      (),                                                                             //              (terminated)
		.av_beginbursttransfer (),                                                                             //              (terminated)
		.av_burstcount         (),                                                                             //              (terminated)
		.av_readdatavalid      (1'b0),                                                                         //              (terminated)
		.av_waitrequest        (1'b0),                                                                         //              (terminated)
		.av_writebyteenable    (),                                                                             //              (terminated)
		.av_lock               (),                                                                             //              (terminated)
		.av_chipselect         (),                                                                             //              (terminated)
		.av_clken              (),                                                                             //              (terminated)
		.uav_clken             (1'b0),                                                                         //              (terminated)
		.av_debugaccess        (),                                                                             //              (terminated)
		.av_outputenable       ()                                                                              //              (terminated)
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
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) sonic_pma_phy_mgmt_translator (
		.clk                   (mm_clk_in_clk),                                                                 //                      clk.clk
		.reset                 (rst_controller_002_reset_out_reset),                                            //                    reset.reset
		.uav_address           (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_waitrequest        (sonic_pma_phy_mgmt_translator_avalon_anti_slave_0_waitrequest),                 //                         .waitrequest
		.av_begintransfer      (),                                                                              //              (terminated)
		.av_beginbursttransfer (),                                                                              //              (terminated)
		.av_burstcount         (),                                                                              //              (terminated)
		.av_byteenable         (),                                                                              //              (terminated)
		.av_readdatavalid      (1'b0),                                                                          //              (terminated)
		.av_writebyteenable    (),                                                                              //              (terminated)
		.av_lock               (),                                                                              //              (terminated)
		.av_chipselect         (),                                                                              //              (terminated)
		.av_clken              (),                                                                              //              (terminated)
		.uav_clken             (1'b0),                                                                          //              (terminated)
		.av_debugaccess        (),                                                                              //              (terminated)
		.av_outputenable       ()                                                                               //              (terminated)
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (84),
		.PKT_PROTECTION_L          (84),
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
		.PKT_SRC_ID_H              (81),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (83),
		.PKT_DEST_ID_L             (82),
		.ST_DATA_W                 (85),
		.ST_CHANNEL_W              (3),
		.AV_BURSTCOUNT_W           (3),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (1),
		.BURSTWRAP_VALUE           (7)
	) jtag_master_master_translator_avalon_universal_master_0_agent (
		.clk              (mm_clk_in_clk),                                                                  //       clk.clk
		.reset            (rst_controller_reset_out_reset),                                                 // clk_reset.reset
		.av_address       (jtag_master_master_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (jtag_master_master_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (jtag_master_master_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (jtag_master_master_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (jtag_master_master_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (jtag_master_master_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (jtag_master_master_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (jtag_master_master_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (jtag_master_master_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (jtag_master_master_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (jtag_master_master_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (jtag_master_master_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (jtag_master_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (jtag_master_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (jtag_master_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (jtag_master_master_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_rsp_src_valid),                                                          //        rp.valid
		.rp_data          (limiter_rsp_src_data),                                                           //          .data
		.rp_channel       (limiter_rsp_src_channel),                                                        //          .channel
		.rp_startofpacket (limiter_rsp_src_startofpacket),                                                  //          .startofpacket
		.rp_endofpacket   (limiter_rsp_src_endofpacket),                                                    //          .endofpacket
		.rp_ready         (limiter_rsp_src_ready)                                                           //          .ready
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (84),
		.PKT_PROTECTION_L          (84),
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
		.PKT_SRC_ID_H              (81),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (83),
		.PKT_DEST_ID_L             (82),
		.ST_DATA_W                 (85),
		.ST_CHANNEL_W              (3),
		.AV_BURSTCOUNT_W           (3),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (2),
		.BURSTWRAP_VALUE           (7)
	) mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent (
		.clk              (mm_clk_in_clk),                                                                     //       clk.clk
		.reset            (rst_controller_reset_out_reset),                                                    // clk_reset.reset
		.av_address       (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_001_rsp_src_valid),                                                         //        rp.valid
		.rp_data          (limiter_001_rsp_src_data),                                                          //          .data
		.rp_channel       (limiter_001_rsp_src_channel),                                                       //          .channel
		.rp_startofpacket (limiter_001_rsp_src_startofpacket),                                                 //          .startofpacket
		.rp_endofpacket   (limiter_001_rsp_src_endofpacket),                                                   //          .endofpacket
		.rp_ready         (limiter_001_rsp_src_ready)                                                          //          .ready
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
		.PKT_SRC_ID_H              (81),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (83),
		.PKT_DEST_ID_L             (82),
		.PKT_BURSTWRAP_H           (78),
		.PKT_BURSTWRAP_L           (76),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_PROTECTION_H          (84),
		.PKT_PROTECTION_L          (84),
		.ST_CHANNEL_W              (3),
		.ST_DATA_W                 (85),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) mdio_csr_translator_avalon_universal_slave_0_agent (
		.clk                     (mm_clk_in_clk),                                                                 //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                //       clk_reset.reset
		.m0_address              (mdio_csr_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (mdio_csr_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (mdio_csr_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (mdio_csr_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (mdio_csr_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (mdio_csr_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (mdio_csr_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (mdio_csr_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (mdio_csr_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (mdio_csr_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (mdio_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (mdio_csr_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (mdio_csr_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (mdio_csr_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (mdio_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_mux_src_ready),                                                        //              cp.ready
		.cp_valid                (cmd_xbar_mux_src_valid),                                                        //                .valid
		.cp_data                 (cmd_xbar_mux_src_data),                                                         //                .data
		.cp_startofpacket        (cmd_xbar_mux_src_startofpacket),                                                //                .startofpacket
		.cp_endofpacket          (cmd_xbar_mux_src_endofpacket),                                                  //                .endofpacket
		.cp_channel              (cmd_xbar_mux_src_channel),                                                      //                .channel
		.rf_sink_ready           (mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (mdio_csr_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (86),
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
	) mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (mm_clk_in_clk),                                                                 //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                // clk_reset.reset
		.in_data           (mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (mdio_csr_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (mdio_csr_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                         // (terminated)
		.csr_read          (1'b0),                                                                          // (terminated)
		.csr_write         (1'b0),                                                                          // (terminated)
		.csr_readdata      (),                                                                              // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                          // (terminated)
		.almost_full_data  (),                                                                              // (terminated)
		.almost_empty_data (),                                                                              // (terminated)
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
		.PKT_SRC_ID_H              (81),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (83),
		.PKT_DEST_ID_L             (82),
		.PKT_BURSTWRAP_H           (78),
		.PKT_BURSTWRAP_L           (76),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_PROTECTION_H          (84),
		.PKT_PROTECTION_L          (84),
		.ST_CHANNEL_W              (3),
		.ST_DATA_W                 (85),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) avalon_slave_0_s0_translator_avalon_universal_slave_0_agent (
		.clk                     (mm_clk_in_clk),                                                                          //             clk.clk
		.reset                   (rst_controller_001_reset_out_reset),                                                     //       clk_reset.reset
		.m0_address              (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_mux_001_src_ready),                                                             //              cp.ready
		.cp_valid                (cmd_xbar_mux_001_src_valid),                                                             //                .valid
		.cp_data                 (cmd_xbar_mux_001_src_data),                                                              //                .data
		.cp_startofpacket        (cmd_xbar_mux_001_src_startofpacket),                                                     //                .startofpacket
		.cp_endofpacket          (cmd_xbar_mux_001_src_endofpacket),                                                       //                .endofpacket
		.cp_channel              (cmd_xbar_mux_001_src_channel),                                                           //                .channel
		.rf_sink_ready           (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (86),
		.FIFO_DEPTH          (4),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (mm_clk_in_clk),                                                                          //       clk.clk
		.reset             (rst_controller_001_reset_out_reset),                                                     // clk_reset.reset
		.in_data           (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                  // (terminated)
		.csr_read          (1'b0),                                                                                   // (terminated)
		.csr_write         (1'b0),                                                                                   // (terminated)
		.csr_readdata      (),                                                                                       // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                   // (terminated)
		.almost_full_data  (),                                                                                       // (terminated)
		.almost_empty_data (),                                                                                       // (terminated)
		.in_empty          (1'b0),                                                                                   // (terminated)
		.out_empty         (),                                                                                       // (terminated)
		.in_error          (1'b0),                                                                                   // (terminated)
		.out_error         (),                                                                                       // (terminated)
		.in_channel        (1'b0),                                                                                   // (terminated)
		.out_channel       ()                                                                                        // (terminated)
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
		.PKT_SRC_ID_H              (81),
		.PKT_SRC_ID_L              (80),
		.PKT_DEST_ID_H             (83),
		.PKT_DEST_ID_L             (82),
		.PKT_BURSTWRAP_H           (78),
		.PKT_BURSTWRAP_L           (76),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_PROTECTION_H          (84),
		.PKT_PROTECTION_L          (84),
		.ST_CHANNEL_W              (3),
		.ST_DATA_W                 (85),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent (
		.clk                     (mm_clk_in_clk),                                                                           //             clk.clk
		.reset                   (rst_controller_002_reset_out_reset),                                                      //       clk_reset.reset
		.m0_address              (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (cmd_xbar_demux_src2_ready),                                                               //              cp.ready
		.cp_valid                (cmd_xbar_demux_src2_valid),                                                               //                .valid
		.cp_data                 (cmd_xbar_demux_src2_data),                                                                //                .data
		.cp_startofpacket        (cmd_xbar_demux_src2_startofpacket),                                                       //                .startofpacket
		.cp_endofpacket          (cmd_xbar_demux_src2_endofpacket),                                                         //                .endofpacket
		.cp_channel              (cmd_xbar_demux_src2_channel),                                                             //                .channel
		.rf_sink_ready           (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (86),
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
	) sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (mm_clk_in_clk),                                                                           //       clk.clk
		.reset             (rst_controller_002_reset_out_reset),                                                      // clk_reset.reset
		.in_data           (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                   // (terminated)
		.csr_read          (1'b0),                                                                                    // (terminated)
		.csr_write         (1'b0),                                                                                    // (terminated)
		.csr_readdata      (),                                                                                        // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                    // (terminated)
		.almost_full_data  (),                                                                                        // (terminated)
		.almost_empty_data (),                                                                                        // (terminated)
		.in_empty          (1'b0),                                                                                    // (terminated)
		.out_empty         (),                                                                                        // (terminated)
		.in_error          (1'b0),                                                                                    // (terminated)
		.out_error         (),                                                                                        // (terminated)
		.in_channel        (1'b0),                                                                                    // (terminated)
		.out_channel       ()                                                                                         // (terminated)
	);

	sonic_v1_15_addr_router addr_router (
		.sink_ready         (jtag_master_master_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (jtag_master_master_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (jtag_master_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (jtag_master_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (jtag_master_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (mm_clk_in_clk),                                                                  //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                 // clk_reset.reset
		.src_ready          (addr_router_src_ready),                                                          //       src.ready
		.src_valid          (addr_router_src_valid),                                                          //          .valid
		.src_data           (addr_router_src_data),                                                           //          .data
		.src_channel        (addr_router_src_channel),                                                        //          .channel
		.src_startofpacket  (addr_router_src_startofpacket),                                                  //          .startofpacket
		.src_endofpacket    (addr_router_src_endofpacket)                                                     //          .endofpacket
	);

	sonic_v1_15_addr_router_001 addr_router_001 (
		.sink_ready         (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (mm_pipeline_bridge_m0_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (mm_clk_in_clk),                                                                     //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                    // clk_reset.reset
		.src_ready          (addr_router_001_src_ready),                                                         //       src.ready
		.src_valid          (addr_router_001_src_valid),                                                         //          .valid
		.src_data           (addr_router_001_src_data),                                                          //          .data
		.src_channel        (addr_router_001_src_channel),                                                       //          .channel
		.src_startofpacket  (addr_router_001_src_startofpacket),                                                 //          .startofpacket
		.src_endofpacket    (addr_router_001_src_endofpacket)                                                    //          .endofpacket
	);

	sonic_v1_15_id_router id_router (
		.sink_ready         (mdio_csr_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (mdio_csr_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (mdio_csr_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (mdio_csr_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (mdio_csr_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (mm_clk_in_clk),                                                       //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                      // clk_reset.reset
		.src_ready          (id_router_src_ready),                                                 //       src.ready
		.src_valid          (id_router_src_valid),                                                 //          .valid
		.src_data           (id_router_src_data),                                                  //          .data
		.src_channel        (id_router_src_channel),                                               //          .channel
		.src_startofpacket  (id_router_src_startofpacket),                                         //          .startofpacket
		.src_endofpacket    (id_router_src_endofpacket)                                            //          .endofpacket
	);

	sonic_v1_15_id_router id_router_001 (
		.sink_ready         (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (avalon_slave_0_s0_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (mm_clk_in_clk),                                                                //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),                                           // clk_reset.reset
		.src_ready          (id_router_001_src_ready),                                                      //       src.ready
		.src_valid          (id_router_001_src_valid),                                                      //          .valid
		.src_data           (id_router_001_src_data),                                                       //          .data
		.src_channel        (id_router_001_src_channel),                                                    //          .channel
		.src_startofpacket  (id_router_001_src_startofpacket),                                              //          .startofpacket
		.src_endofpacket    (id_router_001_src_endofpacket)                                                 //          .endofpacket
	);

	sonic_v1_15_id_router_002 id_router_002 (
		.sink_ready         (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (sonic_pma_phy_mgmt_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (mm_clk_in_clk),                                                                 //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),                                            // clk_reset.reset
		.src_ready          (id_router_002_src_ready),                                                       //       src.ready
		.src_valid          (id_router_002_src_valid),                                                       //          .valid
		.src_data           (id_router_002_src_data),                                                        //          .data
		.src_channel        (id_router_002_src_channel),                                                     //          .channel
		.src_startofpacket  (id_router_002_src_startofpacket),                                               //          .startofpacket
		.src_endofpacket    (id_router_002_src_endofpacket)                                                  //          .endofpacket
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (83),
		.PKT_DEST_ID_L             (82),
		.PKT_TRANS_POSTED          (69),
		.MAX_OUTSTANDING_RESPONSES (7),
		.PIPELINED                 (0),
		.ST_DATA_W                 (85),
		.ST_CHANNEL_W              (3),
		.VALID_WIDTH               (3),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter (
		.clk                    (mm_clk_in_clk),                  //       clk.clk
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
		.PKT_DEST_ID_H             (83),
		.PKT_DEST_ID_L             (82),
		.PKT_TRANS_POSTED          (69),
		.MAX_OUTSTANDING_RESPONSES (7),
		.PIPELINED                 (0),
		.ST_DATA_W                 (85),
		.ST_CHANNEL_W              (3),
		.VALID_WIDTH               (3),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (75),
		.PKT_BYTE_CNT_L            (73),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter_001 (
		.clk                    (mm_clk_in_clk),                      //       clk.clk
		.reset                  (rst_controller_reset_out_reset),     // clk_reset.reset
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

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~mm_clk_in_reset_reset_n),       // reset_in0.reset
		.clk        (mm_clk_in_clk),                  //       clk.clk
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
		.NUM_RESET_INPUTS        (2),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller_001 (
		.reset_in0  (jtag_master_master_reset_reset),     // reset_in0.reset
		.reset_in1  (~mm_clk_in_reset_reset_n),           // reset_in1.reset
		.clk        (mm_clk_in_clk),                      //       clk.clk
		.reset_out  (rst_controller_001_reset_out_reset), // reset_out.reset
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
		.reset_in0  (~ref_clk_in_reset_reset_n),          // reset_in0.reset
		.clk        (mm_clk_in_clk),                      //       clk.clk
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

	sonic_v1_15_cmd_xbar_demux cmd_xbar_demux (
		.clk                (mm_clk_in_clk),                     //        clk.clk
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
		.src2_endofpacket   (cmd_xbar_demux_src2_endofpacket)    //           .endofpacket
	);

	sonic_v1_15_cmd_xbar_demux_001 cmd_xbar_demux_001 (
		.clk                (mm_clk_in_clk),                         //        clk.clk
		.reset              (rst_controller_reset_out_reset),        //  clk_reset.reset
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
		.src1_endofpacket   (cmd_xbar_demux_001_src1_endofpacket)    //           .endofpacket
	);

	sonic_v1_15_cmd_xbar_mux cmd_xbar_mux (
		.clk                 (mm_clk_in_clk),                         //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
		.src_ready           (cmd_xbar_mux_src_ready),                //       src.ready
		.src_valid           (cmd_xbar_mux_src_valid),                //          .valid
		.src_data            (cmd_xbar_mux_src_data),                 //          .data
		.src_channel         (cmd_xbar_mux_src_channel),              //          .channel
		.src_startofpacket   (cmd_xbar_mux_src_startofpacket),        //          .startofpacket
		.src_endofpacket     (cmd_xbar_mux_src_endofpacket),          //          .endofpacket
		.sink0_ready         (cmd_xbar_demux_src0_ready),             //     sink0.ready
		.sink0_valid         (cmd_xbar_demux_src0_valid),             //          .valid
		.sink0_channel       (cmd_xbar_demux_src0_channel),           //          .channel
		.sink0_data          (cmd_xbar_demux_src0_data),              //          .data
		.sink0_startofpacket (cmd_xbar_demux_src0_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (cmd_xbar_demux_src0_endofpacket),       //          .endofpacket
		.sink1_ready         (cmd_xbar_demux_001_src0_ready),         //     sink1.ready
		.sink1_valid         (cmd_xbar_demux_001_src0_valid),         //          .valid
		.sink1_channel       (cmd_xbar_demux_001_src0_channel),       //          .channel
		.sink1_data          (cmd_xbar_demux_001_src0_data),          //          .data
		.sink1_startofpacket (cmd_xbar_demux_001_src0_startofpacket), //          .startofpacket
		.sink1_endofpacket   (cmd_xbar_demux_001_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_cmd_xbar_mux cmd_xbar_mux_001 (
		.clk                 (mm_clk_in_clk),                         //       clk.clk
		.reset               (rst_controller_001_reset_out_reset),    // clk_reset.reset
		.src_ready           (cmd_xbar_mux_001_src_ready),            //       src.ready
		.src_valid           (cmd_xbar_mux_001_src_valid),            //          .valid
		.src_data            (cmd_xbar_mux_001_src_data),             //          .data
		.src_channel         (cmd_xbar_mux_001_src_channel),          //          .channel
		.src_startofpacket   (cmd_xbar_mux_001_src_startofpacket),    //          .startofpacket
		.src_endofpacket     (cmd_xbar_mux_001_src_endofpacket),      //          .endofpacket
		.sink0_ready         (cmd_xbar_demux_src1_ready),             //     sink0.ready
		.sink0_valid         (cmd_xbar_demux_src1_valid),             //          .valid
		.sink0_channel       (cmd_xbar_demux_src1_channel),           //          .channel
		.sink0_data          (cmd_xbar_demux_src1_data),              //          .data
		.sink0_startofpacket (cmd_xbar_demux_src1_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (cmd_xbar_demux_src1_endofpacket),       //          .endofpacket
		.sink1_ready         (cmd_xbar_demux_001_src1_ready),         //     sink1.ready
		.sink1_valid         (cmd_xbar_demux_001_src1_valid),         //          .valid
		.sink1_channel       (cmd_xbar_demux_001_src1_channel),       //          .channel
		.sink1_data          (cmd_xbar_demux_001_src1_data),          //          .data
		.sink1_startofpacket (cmd_xbar_demux_001_src1_startofpacket), //          .startofpacket
		.sink1_endofpacket   (cmd_xbar_demux_001_src1_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_rsp_xbar_demux rsp_xbar_demux (
		.clk                (mm_clk_in_clk),                     //       clk.clk
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
		.src0_endofpacket   (rsp_xbar_demux_src0_endofpacket),   //          .endofpacket
		.src1_ready         (rsp_xbar_demux_src1_ready),         //      src1.ready
		.src1_valid         (rsp_xbar_demux_src1_valid),         //          .valid
		.src1_data          (rsp_xbar_demux_src1_data),          //          .data
		.src1_channel       (rsp_xbar_demux_src1_channel),       //          .channel
		.src1_startofpacket (rsp_xbar_demux_src1_startofpacket), //          .startofpacket
		.src1_endofpacket   (rsp_xbar_demux_src1_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_rsp_xbar_demux rsp_xbar_demux_001 (
		.clk                (mm_clk_in_clk),                         //       clk.clk
		.reset              (rst_controller_001_reset_out_reset),    // clk_reset.reset
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
		.src0_endofpacket   (rsp_xbar_demux_001_src0_endofpacket),   //          .endofpacket
		.src1_ready         (rsp_xbar_demux_001_src1_ready),         //      src1.ready
		.src1_valid         (rsp_xbar_demux_001_src1_valid),         //          .valid
		.src1_data          (rsp_xbar_demux_001_src1_data),          //          .data
		.src1_channel       (rsp_xbar_demux_001_src1_channel),       //          .channel
		.src1_startofpacket (rsp_xbar_demux_001_src1_startofpacket), //          .startofpacket
		.src1_endofpacket   (rsp_xbar_demux_001_src1_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_rsp_xbar_demux_002 rsp_xbar_demux_002 (
		.clk                (mm_clk_in_clk),                         //       clk.clk
		.reset              (rst_controller_002_reset_out_reset),    // clk_reset.reset
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

	sonic_v1_15_rsp_xbar_mux rsp_xbar_mux (
		.clk                 (mm_clk_in_clk),                         //       clk.clk
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
		.sink2_endofpacket   (rsp_xbar_demux_002_src0_endofpacket)    //          .endofpacket
	);

	sonic_v1_15_rsp_xbar_mux_001 rsp_xbar_mux_001 (
		.clk                 (mm_clk_in_clk),                         //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
		.src_ready           (rsp_xbar_mux_001_src_ready),            //       src.ready
		.src_valid           (rsp_xbar_mux_001_src_valid),            //          .valid
		.src_data            (rsp_xbar_mux_001_src_data),             //          .data
		.src_channel         (rsp_xbar_mux_001_src_channel),          //          .channel
		.src_startofpacket   (rsp_xbar_mux_001_src_startofpacket),    //          .startofpacket
		.src_endofpacket     (rsp_xbar_mux_001_src_endofpacket),      //          .endofpacket
		.sink0_ready         (rsp_xbar_demux_src1_ready),             //     sink0.ready
		.sink0_valid         (rsp_xbar_demux_src1_valid),             //          .valid
		.sink0_channel       (rsp_xbar_demux_src1_channel),           //          .channel
		.sink0_data          (rsp_xbar_demux_src1_data),              //          .data
		.sink0_startofpacket (rsp_xbar_demux_src1_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (rsp_xbar_demux_src1_endofpacket),       //          .endofpacket
		.sink1_ready         (rsp_xbar_demux_001_src1_ready),         //     sink1.ready
		.sink1_valid         (rsp_xbar_demux_001_src1_valid),         //          .valid
		.sink1_channel       (rsp_xbar_demux_001_src1_channel),       //          .channel
		.sink1_data          (rsp_xbar_demux_001_src1_data),          //          .data
		.sink1_startofpacket (rsp_xbar_demux_001_src1_startofpacket), //          .startofpacket
		.sink1_endofpacket   (rsp_xbar_demux_001_src1_endofpacket)    //          .endofpacket
	);

endmodule
