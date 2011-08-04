`ifndef __SIMULATION_LIBRARY__
`define __SIMULATION_LIBRARY__

package sim_library;

`define LEGACY_IRQ	tb.sonic_application_top_testbench_inst_legacy_irq_bfm
`define MSI_IRQ		tb.sonic_application_top_testbench_inst_msi_irq_bfm
`define ERR_DESC	tb.sonic_application_top_testbench_inst_err_desc_bfm
`define PEX_MSI_NUM tb.sonic_application_top_testbench_inst_pex_msi_num_bfm
`define CLK			tb.sonic_application_top_testbench_inst_clk_bfm
`define RST			tb.sonic_application_top_testbench_inst_reset_bfm
`define SRC			tb.sonic_application_top_testbench_inst_rx_st_bfm
`define SNK			tb.sonic_application_top_testbench_inst_tx_st_bfm

//BFM related parameters
`define ST_SYMBOL_W      8
`define ST_NUMSYMBOLS    4
`define ST_CHANNEL_W     3
`define ST_ERROR_W       3
`define ST_EMPTY_W       2
`define ST_READY_LATENCY 0
`define ST_MAX_CHANNELS  7
`define SOURCE_RESP_TIMEOUT 100

//local parameters
`define ST_DATA_W `ST_SYMBOL_W * `ST_NUMSYMBOLS
`define NUMBER_OF_TRANSACTIONS 4 //this value reflects the number of transactions performed in the test
`define BACK_PRESSURE_CYCLES 1
	
	typedef logic [`ST_DATA_W-1    :0] AvalonSTData_t;
	typedef logic [`ST_CHANNEL_W-1 :0] AvalonSTChannel_t;
	typedef logic [`ST_EMPTY_W-1   :0] AvalonSTEmpty_t;
	typedef logic [`ST_ERROR_W-1   :0] AvalonSTError_t;

	//the ST transaction is defined using SystemVerilog structure data type
	 
	class transaction_struct;
	    int               idles;  //idle is not part of Avalon ST signal, it is used in BFM only
		bit               startofpacket;
		bit               endofpacket;
		AvalonSTChannel_t channel;
		AvalonSTData_t    data;
		AvalonSTError_t   error;
		AvalonSTEmpty_t   empty;

		function new();
			idles = 0;
			startofpacket = 0;
			endofpacket = 0;
			channel = 0;
			data = 0;
			error = 0;
			empty = 0;
		endfunction
	endclass: transaction_struct;	

	typedef enum int 
	{  
		SOURCE,
		SINK
	} label_t;

	//----------------------------------------------------------
	// Transaction Layer Packet Classes
	//----------------------------------------------------------	

	virtual class base_tlp_packet;
		virtual function void push_transaction();
		endfunction
	endclass: base_tlp_packet;
		
	class tlp_mem_rd_32 extends base_tlp_packet;
		bit	[2:0]	tc;
		bit			td;
		bit			ep;
		bit [1:0]	attr;
		bit [9:0]	length;
		bit [15:0]	requester_id;
		bit [7:0]	tag;
		bit [3:0]	last_be;
		bit [3:0]	first_be;
		bit [29:0]	address;
		transaction_struct transaction;

		function new();
			tc = 0;
			td = 0;
			ep = 0;
			attr = 0;
			length = 0;
			requester_id = 0;
			transaction = new;
		endfunction

		function void push_transaction();
			`SRC.set_transaction_idles   (transaction.idles);
			`SRC.set_transaction_sop     (transaction.startofpacket);
			`SRC.set_transaction_eop     (transaction.endofpacket);
			`SRC.set_transaction_channel (transaction.channel);
			`SRC.set_transaction_data    (transaction.data);
			`SRC.set_transaction_error   (transaction.error);	 
			`SRC.set_transaction_empty   (transaction.empty);	 
			`SRC.push_transaction();  
		endfunction
	endclass: tlp_mem_rd_32;

	class tlp_mem_


endpackage
`endif
