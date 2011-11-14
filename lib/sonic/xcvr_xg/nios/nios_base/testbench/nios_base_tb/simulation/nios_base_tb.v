// nios_base_tb.v


`timescale 1 ps / 1 ps
module nios_base_tb (
	);

	wire         nios_base_inst_clk_clk_in_bfm_clk_clk;           // nios_base_inst_clk_clk_in_bfm:clk -> [nios_base_inst:clk, nios_base_inst_clk_clk_in_reset_bfm:clk, nios_base_inst_read_master_bfm:clk, nios_base_inst_write_master_bfm:clk]
	wire         nios_base_inst_clk_clk_in_reset_bfm_reset_reset; // nios_base_inst_clk_clk_in_reset_bfm:reset -> [nios_base_inst:reset_n, nios_base_inst_read_master_bfm:reset, nios_base_inst_write_master_bfm:reset]
	wire         nios_base_inst_read_master_waitrequest;          // nios_base_inst_read_master_bfm:avs_waitrequest -> nios_base_inst:read_master_waitrequest
	wire  [31:0] nios_base_inst_read_master_address;              // nios_base_inst:read_master_address -> nios_base_inst_read_master_bfm:avs_address
	wire         nios_base_inst_read_master_read;                 // nios_base_inst:read_master_read -> nios_base_inst_read_master_bfm:avs_read
	wire  [31:0] nios_base_inst_read_master_readdata;             // nios_base_inst_read_master_bfm:avs_readdata -> nios_base_inst:read_master_readdata
	wire         nios_base_inst_read_master_readdatavalid;        // nios_base_inst_read_master_bfm:avs_readdatavalid -> nios_base_inst:read_master_readdatavalid
	wire   [3:0] nios_base_inst_read_master_byteenable;           // nios_base_inst:read_master_byteenable -> nios_base_inst_read_master_bfm:avs_byteenable
	wire         nios_base_inst_write_master_waitrequest;         // nios_base_inst_write_master_bfm:avs_waitrequest -> nios_base_inst:write_master_waitrequest
	wire  [31:0] nios_base_inst_write_master_writedata;           // nios_base_inst:write_master_writedata -> nios_base_inst_write_master_bfm:avs_writedata
	wire  [31:0] nios_base_inst_write_master_address;             // nios_base_inst:write_master_address -> nios_base_inst_write_master_bfm:avs_address
	wire         nios_base_inst_write_master_write;               // nios_base_inst:write_master_write -> nios_base_inst_write_master_bfm:avs_write
	wire   [3:0] nios_base_inst_write_master_byteenable;          // nios_base_inst:write_master_byteenable -> nios_base_inst_write_master_bfm:avs_byteenable
	wire   [3:0] nios_base_inst_ext_ctrl_in_bfm_conduit_export;   // nios_base_inst_ext_ctrl_in_bfm:sig_export -> nios_base_inst:ext_ctrl_in_export

	nios_base_tb_nios_base_inst nios_base_inst (
		.clk                       (nios_base_inst_clk_clk_in_bfm_clk_clk),           //       clk_clk_in.clk
		.reset_n                   (nios_base_inst_clk_clk_in_reset_bfm_reset_reset), // clk_clk_in_reset.reset_n
		.read_master_address       (nios_base_inst_read_master_address),              //      read_master.address
		.read_master_read          (nios_base_inst_read_master_read),                 //                 .read
		.read_master_byteenable    (nios_base_inst_read_master_byteenable),           //                 .byteenable
		.read_master_readdata      (nios_base_inst_read_master_readdata),             //                 .readdata
		.read_master_readdatavalid (nios_base_inst_read_master_readdatavalid),        //                 .readdatavalid
		.read_master_waitrequest   (nios_base_inst_read_master_waitrequest),          //                 .waitrequest
		.write_master_address      (nios_base_inst_write_master_address),             //     write_master.address
		.write_master_write        (nios_base_inst_write_master_write),               //                 .write
		.write_master_byteenable   (nios_base_inst_write_master_byteenable),          //                 .byteenable
		.write_master_writedata    (nios_base_inst_write_master_writedata),           //                 .writedata
		.write_master_waitrequest  (nios_base_inst_write_master_waitrequest),         //                 .waitrequest
		.ext_ctrl_in_export        (nios_base_inst_ext_ctrl_in_bfm_conduit_export)    //      ext_ctrl_in.export
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (50)
	) nios_base_inst_clk_clk_in_bfm (
		.clk (nios_base_inst_clk_clk_in_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) nios_base_inst_clk_clk_in_reset_bfm (
		.reset (nios_base_inst_clk_clk_in_reset_bfm_reset_reset), // reset.reset_n
		.clk   (nios_base_inst_clk_clk_in_bfm_clk_clk)            //   clk.clk
	);

	altera_avalon_mm_slave_bfm #(
		.AV_ADDRESS_W               (32),
		.AV_SYMBOL_W                (8),
		.AV_NUMSYMBOLS              (4),
		.AV_BURSTCOUNT_W            (1),
		.AV_READRESPONSE_W          (1),
		.AV_WRITERESPONSE_W         (1),
		.USE_READ                   (1),
		.USE_WRITE                  (0),
		.USE_ADDRESS                (1),
		.USE_BYTE_ENABLE            (1),
		.USE_BURSTCOUNT             (0),
		.USE_READ_DATA              (1),
		.USE_READ_DATA_VALID        (1),
		.USE_WRITE_DATA             (0),
		.USE_BEGIN_TRANSFER         (0),
		.USE_BEGIN_BURST_TRANSFER   (0),
		.USE_WAIT_REQUEST           (1),
		.USE_TRANSACTIONID          (0),
		.USE_WRITERESPONSE          (0),
		.USE_READRESPONSE           (0),
		.USE_CLKEN                  (0),
		.AV_BURST_LINEWRAP          (0),
		.AV_BURST_BNDR_ONLY         (0),
		.AV_MAX_PENDING_READS       (1),
		.AV_FIX_READ_LATENCY        (0),
		.AV_READ_WAIT_TIME          (1),
		.AV_WRITE_WAIT_TIME         (0),
		.REGISTER_WAITREQUEST       (0),
		.AV_REGISTERINCOMINGSIGNALS (0)
	) nios_base_inst_read_master_bfm (
		.clk                      (nios_base_inst_clk_clk_in_bfm_clk_clk),            //       clk.clk
		.reset                    (~nios_base_inst_clk_clk_in_reset_bfm_reset_reset), // clk_reset.reset
		.avs_readdata             (nios_base_inst_read_master_readdata),              //        s0.readdata
		.avs_address              (nios_base_inst_read_master_address),               //          .address
		.avs_waitrequest          (nios_base_inst_read_master_waitrequest),           //          .waitrequest
		.avs_read                 (nios_base_inst_read_master_read),                  //          .read
		.avs_byteenable           (nios_base_inst_read_master_byteenable),            //          .byteenable
		.avs_readdatavalid        (nios_base_inst_read_master_readdatavalid),         //          .readdatavalid
		.avs_writedata            (32'b00000000000000000000000000000000),             // (terminated)
		.avs_begintransfer        (1'b0),                                             // (terminated)
		.avs_beginbursttransfer   (1'b0),                                             // (terminated)
		.avs_burstcount           (1'b1),                                             // (terminated)
		.avs_write                (1'b0),                                             // (terminated)
		.avs_arbiterlock          (1'b0),                                             // (terminated)
		.avs_lock                 (1'b0),                                             // (terminated)
		.avs_debugaccess          (1'b0),                                             // (terminated)
		.avs_transactionid        (8'b00000000),                                      // (terminated)
		.avs_readresponse         (),                                                 // (terminated)
		.avs_readid               (),                                                 // (terminated)
		.avs_writeresponserequest (1'b0),                                             // (terminated)
		.avs_writeresponse        (),                                                 // (terminated)
		.avs_writeresponsevalid   (),                                                 // (terminated)
		.avs_writeid              (),                                                 // (terminated)
		.avs_clken                (1'b1)                                              // (terminated)
	);

	altera_avalon_mm_slave_bfm #(
		.AV_ADDRESS_W               (32),
		.AV_SYMBOL_W                (8),
		.AV_NUMSYMBOLS              (4),
		.AV_BURSTCOUNT_W            (1),
		.AV_READRESPONSE_W          (1),
		.AV_WRITERESPONSE_W         (1),
		.USE_READ                   (0),
		.USE_WRITE                  (1),
		.USE_ADDRESS                (1),
		.USE_BYTE_ENABLE            (1),
		.USE_BURSTCOUNT             (0),
		.USE_READ_DATA              (0),
		.USE_READ_DATA_VALID        (0),
		.USE_WRITE_DATA             (1),
		.USE_BEGIN_TRANSFER         (0),
		.USE_BEGIN_BURST_TRANSFER   (0),
		.USE_WAIT_REQUEST           (1),
		.USE_TRANSACTIONID          (0),
		.USE_WRITERESPONSE          (0),
		.USE_READRESPONSE           (0),
		.USE_CLKEN                  (0),
		.AV_BURST_LINEWRAP          (0),
		.AV_BURST_BNDR_ONLY         (0),
		.AV_MAX_PENDING_READS       (0),
		.AV_FIX_READ_LATENCY        (0),
		.AV_READ_WAIT_TIME          (1),
		.AV_WRITE_WAIT_TIME         (0),
		.REGISTER_WAITREQUEST       (0),
		.AV_REGISTERINCOMINGSIGNALS (0)
	) nios_base_inst_write_master_bfm (
		.clk                      (nios_base_inst_clk_clk_in_bfm_clk_clk),            //       clk.clk
		.reset                    (~nios_base_inst_clk_clk_in_reset_bfm_reset_reset), // clk_reset.reset
		.avs_writedata            (nios_base_inst_write_master_writedata),            //        s0.writedata
		.avs_address              (nios_base_inst_write_master_address),              //          .address
		.avs_waitrequest          (nios_base_inst_write_master_waitrequest),          //          .waitrequest
		.avs_write                (nios_base_inst_write_master_write),                //          .write
		.avs_byteenable           (nios_base_inst_write_master_byteenable),           //          .byteenable
		.avs_begintransfer        (1'b0),                                             // (terminated)
		.avs_beginbursttransfer   (1'b0),                                             // (terminated)
		.avs_burstcount           (1'b1),                                             // (terminated)
		.avs_readdata             (),                                                 // (terminated)
		.avs_read                 (1'b0),                                             // (terminated)
		.avs_readdatavalid        (),                                                 // (terminated)
		.avs_arbiterlock          (1'b0),                                             // (terminated)
		.avs_lock                 (1'b0),                                             // (terminated)
		.avs_debugaccess          (1'b0),                                             // (terminated)
		.avs_transactionid        (8'b00000000),                                      // (terminated)
		.avs_readresponse         (),                                                 // (terminated)
		.avs_readid               (),                                                 // (terminated)
		.avs_writeresponserequest (1'b0),                                             // (terminated)
		.avs_writeresponse        (),                                                 // (terminated)
		.avs_writeresponsevalid   (),                                                 // (terminated)
		.avs_writeid              (),                                                 // (terminated)
		.avs_clken                (1'b1)                                              // (terminated)
	);

	nios_base_tb_nios_base_inst_ext_ctrl_in_bfm nios_base_inst_ext_ctrl_in_bfm (
		.sig_export (nios_base_inst_ext_ctrl_in_bfm_conduit_export)  // conduit.export
	);

endmodule
