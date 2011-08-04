//----------------------------------------------------------------------------------------------
// This test module uses System Verilog syntax.
//----------------------------------------------------------------------------------------------
// console messaging level
//
`timescale 1ns/1ps

`include "tlp_struct.sv"

`define VERBOSITY VERBOSITY_INFO

`define LEGACY_IRQ	tb.sonic_application_top_testbench_inst_legacy_irq_bfm
`define MSI_IRQ		tb.sonic_application_top_testbench_inst_msi_irq_bfm
`define ERR_DESC	tb.sonic_application_top_testbench_inst_err_desc_bfm
`define PEX_MSI_NUM tb.sonic_application_top_testbench_inst_pex_msi_num_bfm
`define CLK			tb.sonic_application_top_testbench_inst_clk_bfm
`define RST			tb.sonic_application_top_testbench_inst_reset_bfm
`define RST_CTRL	tb.rst_controller
`define SRC			tb.sonic_application_top_testbench_inst_rx_st_bfm
`define SNK			tb.sonic_application_top_testbench_inst_tx_st_bfm
`define RX_MISC		tb.sonic_application_top_testbench_inst_rx_st_misc_bfm
`define CFG			tb.sonic_application_top_testbench_inst_tl_cfg_bfm
`define CRED		tb.sonic_application_top_testbench_inst_tx_st_cred_bfm
`define FIFO_EMPTY  tb.sonic_application_top_testbench_inst_tx_st_fifo_empty_bfm
`define LINKCSR		tb.sonic_application_top_testbench_inst_cfg_linkcsr_bfm
`define PMA_TX_READY	tb.sonic_application_top_testbench_inst_pma_tx_ready_bfm
`define PMA_RX_READY	tb.sonic_application_top_testbench_inst_pma_rx_ready_bfm

//BFM related parameters
`define ST_SYMBOL_W      8
`define ST_NUMSYMBOLS    16
`define ST_CHANNEL_W     3
`define ST_ERROR_W       3
`define ST_EMPTY_W       2
`define ST_READY_LATENCY 0
`define ST_MAX_CHANNELS  7
`define SOURCE_RESP_TIMEOUT 100

//SoNIC parameters
`define IRQ_BASE_ADDRESS_HI 32'h1
`define IRQ_BASE_ADDRESS_LO 32'h78000000
`define IRQ_SIZE		32'h400

//local parameters
`define LOCAL_DT_MEMORY  32'h2000
`define ST_DATA_W `ST_SYMBOL_W * `ST_NUMSYMBOLS
`define NUMBER_OF_TRANSACTIONS 10 //this value reflects the number of transactions performed in the test
`define BACK_PRESSURE_CYCLES 1
`define LONG_DELAY			 20
`define BRIEF_DELAY			 4

//Command Constants
`define CMD_RESET 32'h1;
`define CMD_GET_RX_OFFSET 32'h10;
`define CMD_GET_RX_OFFSET2 32'h11;
`define CMD_GET_RX_SIZE	  32'h12;
`define CMD_GET_RX_BLOCK_SIZE 32'h13;
`define CMD_STOP_SFP1	32'h20;
`define CMD_START_SFP1	32'h21;
`define CMD_STOP_SFP2	32'h22;
`define CMD_START_SFP2	32'h23;
`define CMD_CONFIG_IRQ	32'h3;
`define CMD_SET_ADDRESS_IRQ 32'h2;
`define CMD_SET_RX_BLOCK_SIZE 32'h14;

module test_program();

	import verbosity_pkg::*;
	
	typedef logic [`ST_DATA_W-1    :0] AvalonSTData_t;
	typedef bit [`ST_CHANNEL_W-1 :0] AvalonSTChannel_t;
	typedef logic [`ST_EMPTY_W-1   :0] AvalonSTEmpty_t;
	typedef logic [`ST_ERROR_W-1   :0] AvalonSTError_t;
	typedef logic [15:0]	AvalonSTBe0_t;
	typedef logic [7:0]	AvalonSTBardec0_t;
	//the ST transaction is defined using SystemVerilog structure data type
	 
	class transaction_class;
	    int               idles;  //idle is not part of Avalon ST signal, it is used in BFM only
		bit               startofpacket;
		bit               endofpacket;
		AvalonSTChannel_t channel;
		AvalonSTData_t    data;
		AvalonSTError_t   error;
		AvalonSTEmpty_t   empty;
		AvalonSTBe0_t	  be0;
		AvalonSTBardec0_t bardec0;

		function new();
			idles = 0;
			startofpacket = 0;
			endofpacket = 0;
			channel = 0;
			data = 0;
			error = 0;
			empty = 0;
			be0 = 0;
			bardec0 = 0;
		endfunction
	endclass: transaction_class;	

	typedef enum int 
	{  
		SOURCE,
		SINK
	} label_t;

	//----------------------------------------------------------
	// Transaction Layer Packet Classes
	//----------------------------------------------------------


	class base_tlp_packet;
		transaction_class transaction;
	
		function new();
			transaction = new;
		endfunction		

		function void __push_transaction();
			string message;
			`SRC.set_transaction_idles   (transaction.idles);
			`SRC.set_transaction_sop     (transaction.startofpacket);
			`SRC.set_transaction_eop     (transaction.endofpacket);
			`SRC.set_transaction_channel (transaction.channel);
			`SRC.set_transaction_data    (transaction.data);
			`SRC.set_transaction_error   (transaction.error);	 
			`SRC.set_transaction_empty   (transaction.empty);	 
			`SRC.set_transaction_be0     (transaction.be0);	 
			`SRC.set_transaction_bardec0   (transaction.bardec0);	 
//			$sformat(message, "data %0x ", transaction.data);
//			print(VERBOSITY_INFO, message);        								 
			`SRC.push_transaction();  
		endfunction

		virtual function void __update();
		endfunction

		virtual function void __set_tlp_header();
		endfunction

		virtual function void __set_payload(input bit[127:0] payload, bit[15:0] be );
		endfunction	

		task send_command( input bit[7:0] bardec0, bit[15:0] be0, bit[127:0] payload, bit[15:0] be );
			print (VERBOSITY_INFO, "send command");
			__set_tlp_header();
			transaction.idles          = 0;	      
			transaction.channel        = 0;
			transaction.error          = 0;
			transaction.empty          = 0;
			transaction.startofpacket  = 1;
			transaction.endofpacket    = 0;
			transaction.bardec0	   = bardec0;
			transaction.be0		   = be0;
			__push_transaction();
	
			__set_payload(payload , be);
			transaction.idles		   = 0;
			transaction.channel		   = 0;
			transaction.error		   = 0;
			transaction.empty		   = 0;
			transaction.startofpacket  = 0;	
			transaction.endofpacket    = 1;
			transaction.bardec0	   = bardec0;
			transaction.be0		   = be;
			__push_transaction();

		endtask


	endclass: base_tlp_packet;
		
	class tlp_mem_rd_32 extends base_tlp_packet;
		tlp_mem_rd_32_struct tlp;

		function new();
			super.new();
			tlp.tc = 0;
			tlp.td = 0;
			tlp.ep = 0;
			tlp.attr = 0;
			tlp.length = 0;
			tlp.requester_id = 0;
			tlp.last_be = 0;
			tlp.first_be = 0;
			tlp.address = 0;
			tlp.__reserved_0 = 9'h0;
			tlp.__reserved_1 = 4'h0;
			tlp.__reserved_2 = 2'h0;
			tlp.__reserved_3 = 2'h0;
			tlp.__reserved_4 = 32'h0;
		endfunction

		function void __update();
			transaction.data = {
				tlp.__reserved_4,
				tlp.address, tlp.__reserved_3, 
				tlp.requester_id, tlp.tag, tlp.last_be, tlp.first_be,
				tlp.__reserved_0, tlp.tc, tlp.__reserved_1, tlp.td, tlp.ep, tlp.attr, tlp.__reserved_2, tlp.length
				};
		endfunction
	endclass: tlp_mem_rd_32;

	class tlp_mem_wr_32 extends base_tlp_packet;
		tlp_mem_wr_32_struct tlp;
		function new();
			super.new();
			tlp.tc = 0;
			tlp.td = 0;
			tlp.ep = 0;
			tlp.attr = 0;
			tlp.length = 0;
			tlp.requester_id = 0;
			tlp.last_be = 0;
			tlp.first_be = 0;
			tlp.address = 0;
			tlp.__reserved_0 = 9'h80; //9'b0100_0000_0
			tlp.__reserved_1 = 4'h0;
			tlp.__reserved_2 = 2'h0;
			tlp.__reserved_3 = 2'h0;
			tlp.__reserved_4 = 32'h0;
		endfunction

		function void __update();
			transaction.data = {
				tlp.__reserved_4,
				tlp.address, tlp.__reserved_3, 
				tlp.requester_id, tlp.tag, tlp.last_be, tlp.first_be,
				tlp.__reserved_0, tlp.tc, tlp.__reserved_1, tlp.td, tlp.ep, tlp.attr, tlp.__reserved_2, tlp.length
				};
		endfunction

		function void __set_tlp_header();
			transaction.data = {
				tlp.__reserved_4,
				tlp.address, tlp.__reserved_3, 
				tlp.requester_id, tlp.tag, tlp.last_be, tlp.first_be,
				tlp.__reserved_0, tlp.tc, tlp.__reserved_1, tlp.td, tlp.ep, tlp.attr, tlp.__reserved_2, tlp.length
				};
		endfunction

		function void __set_payload(input bit[127:0] payload , bit[15:0] be);
			transaction.data = { payload
								 };
		endfunction

	endclass: tlp_mem_wr_32;

	class tlp_cpl_with_data extends base_tlp_packet;
		tlp_cpl_with_data_struct tlp;
		tlp_cpl_payload payload;
		function new();
			super.new();
			tlp.tc = 0;
			tlp.td = 0;
			tlp.ep = 0;
			tlp.attr = 0;
			tlp.length = 0;
			tlp.completer_id = 0;
			tlp.status = 0;
			tlp.b = 0;
			tlp.byte_count = 0;
			tlp.requester_id = 16'h0108;
			tlp.tag = 0;
			tlp.lower_address = 0;
			tlp.__reserved_0 = 9'h94; //9'b0100_1010_0
			tlp.__reserved_1 = 4'h0;
			tlp.__reserved_2 = 2'h0;
			tlp.__reserved_3 = 0;
			tlp.__reserved_4 = 32'h0;
			payload.dw0	= 32'h0;
			payload.dw1 = 32'h0;
			payload.dw2 = 32'h0;
			payload.dw3 = 32'h0;
		endfunction

		function void __update();
//			print (VERBOSITY_INFO, "UPDATE CPL HEADER");
			transaction.data = {
				tlp.__reserved_4,
				tlp.requester_id, tlp.tag, tlp.__reserved_3, tlp.lower_address,
				tlp.completer_id, tlp.status, tlp.b, tlp.byte_count,
				tlp.__reserved_0, tlp.tc, tlp.__reserved_1, tlp.td, tlp.ep, tlp.attr, tlp.__reserved_2, tlp.length
				};
		endfunction

		function void __update_payload();
			transaction.data = {
				payload.dw3, payload.dw2, payload.dw1, payload.dw0
				};
		endfunction
	
		function void send_cpl_header(input bit[7:0] bardec0, bit[15:0] be0);
			__update();
			transaction.idles          = 0;	      
			transaction.channel        = 0;
			transaction.error          = 0;
			transaction.empty          = 0;
			transaction.startofpacket  = 1;
			transaction.endofpacket    = 0;
			transaction.bardec0  = bardec0;
			transaction.be0      = be0;
			__push_transaction();
		endfunction

		function void send_cpl_payload(input bit[7:0] bardec0, bit[15:0] be0);
			__update_payload();
			transaction.idles          = 0;	      
			transaction.channel        = 0;
			transaction.error          = 0;
			transaction.empty          = 0;
			transaction.startofpacket  = 0;
			transaction.endofpacket    = 0;
			transaction.bardec0        = bardec0;
			transaction.be0		   = be0;
			__push_transaction();
		endfunction

		function void send_cpl_endpacket(input bit[7:0] bardec0, bit[15:0] be0);
			__update_payload();
			transaction.idles          = 0;	      
			transaction.channel        = 0;
			transaction.error          = 0;
			transaction.empty          = 0;
			transaction.startofpacket  = 0;
			transaction.endofpacket    = 1;
			transaction.bardec0  = bardec0;
			transaction.be0    = be0;
			__push_transaction();
		endfunction
	
	endclass: tlp_cpl_with_data;

	//---END OF TLP PACKET CLASSES --//

	string message;

	// large memory block for storing received data and irq data. > 4GB
	// We cheated here to use only the lowest 16 bit as address.
	//bit[7:0] ram [16'hFFFF];
	bit[7:0] ram [*];

	//---helper function--//
	function bit[7:0] read_byte_ram (input time address);
		bit[7:0] value;
		value = ram[address];
		return value;
	endfunction

	function void write_byte_ram (input time address, bit[7:0] value);
		ram[address] = value;
	endfunction

	function void write_dword_ram (input time address, bit[31:0] value);
		ram[address] = value[7:0];
		ram[address+1] = value[15:8];
		ram[address+2] = value[23:16];
		ram[address+3] = value[31:24];
	endfunction

	function bit[31:0] read_dword_ram (input time address);
		bit [31:0] value;
		value = {ram[address+3], 
			 ram[address+2],
			 ram[address+1],
			 ram[address]};
		return value;
	endfunction

	function void init_local_memory ();
		write_dword_ram (32'h800, 32'h0);
		write_dword_ram (32'h804, 32'h0);
		write_dword_ram (32'h808, 32'h0);
		write_dword_ram (32'h80C, 32'h0);

		write_dword_ram (32'h810, 32'h20400);
		write_dword_ram (32'h814, 32'h0);
		write_dword_ram (32'h818, 32'h1);
		write_dword_ram (32'h81C, 32'h5000);

		write_dword_ram (32'h820, 32'h20400);
		write_dword_ram (32'h824, 32'h0);
		write_dword_ram (32'h828, 32'h1);
		write_dword_ram (32'h82C, 32'h7000);

		write_dword_ram (32'h830, 32'h20400);
		write_dword_ram (32'h834, 32'h0);
		write_dword_ram (32'h838, 32'h1);
		write_dword_ram (32'h83C, 32'h8000);

		write_dword_ram (32'h840, 32'h20400);
		write_dword_ram (32'h844, 32'h0);
		write_dword_ram (32'h848, 32'h1);
		write_dword_ram (32'h84C, 32'h6000);

		write_dword_ram (32'h850, 32'h30400);
		write_dword_ram (32'h854, 32'h0);
		write_dword_ram (32'h858, 32'h1);
		write_dword_ram (32'h85C, 32'h5000);

		write_dword_ram (32'h860, 32'h20400);
		write_dword_ram (32'h864, 32'h0);
		write_dword_ram (32'h868, 32'h1);
		write_dword_ram (32'h86C, 32'h7000);
		
		write_dword_ram (32'h870, 32'h20400);
		write_dword_ram (32'h874, 32'h0);
		write_dword_ram (32'h878, 32'h1);
		write_dword_ram (32'h87C, 32'h7000);

		write_dword_ram (32'h900, 32'h0);
		write_dword_ram (32'h904, 32'h0);
		write_dword_ram (32'h908, 32'h0);
		write_dword_ram (32'h90C, 32'h0);

		write_dword_ram (32'h910, 32'h22000);
		write_dword_ram (32'h914, 32'h0);
		write_dword_ram (32'h918, 32'h1);
		write_dword_ram (32'h91C, 32'h8df0);

		write_dword_ram (32'h920, 32'h1000);
		write_dword_ram (32'h924, 32'h4000);
		write_dword_ram (32'h928, 32'h1);
		write_dword_ram (32'h92C, 32'hA000);

		write_dword_ram (32'h930, 32'h31000);
		write_dword_ram (32'h934, 32'h4000);
		write_dword_ram (32'h938, 32'h1);
		write_dword_ram (32'h93C, 32'h20ef0);

		write_dword_ram (64'h178000000, 0);
		write_dword_ram (64'h178000004, 0);
		write_dword_ram (64'h178000008, 0);
		write_dword_ram (64'h17800000C, 0);
		
	endfunction

	//--End of RAM functions
	//-- Start of Main test 
	transaction_class src_transaction, snk_transaction;
	transaction_class src_transaction_backup[$];
	transaction_class pending_rd64_queue[$];
	
	transaction_class dma_dt_transaction;
	transaction_class pending_rd32_queue[$];

	transaction_class dma_wr64_transaction;
	transaction_class dma_irq_transaction;
	transaction_class pending_wr64_queue[$];

	transaction_class dma_wr32_transaction;
	transaction_class pending_wr32_queue[$];

	tlp_mem_rd_32 tlp_rd_32;
	tlp_mem_wr_32 tlp_wr_32;

	int i, j, src_response_latency;
	int cur_cmd;
	bit compare_result = 1;
	int count, count_push, count_pop;
	int tag_count;
	event e_dma_dt_rd, e_desc_rd;
	event e_dma_dt_wr;
	event e_irq_rd;
	event e_dma_wr64;
	event e_dma_wr32;

	event start_dma_rd_test;
	event start_dma_wr_test;
	event idle;

	initial
		begin
		set_verbosity(`VERBOSITY);

		`SRC.init();
		`SNK.init();

		`PMA_TX_READY.set_export(0);
		`PMA_RX_READY.set_export(0);
		init();
		init_local_memory();
		wait (`RST_CTRL.reset_out == 0);
		`PMA_TX_READY.set_export(1);
		`PMA_RX_READY.set_export(1);

		fork: test_threads
			source_data_thread: begin
				command_init();

				#100
				//main thread that fake all the cpl data of dma.
				//This thread handles the transmission of DT, DMA Rd cpl data
				//It deals with the following PCI transaction:
				//1. Command. sequential at start up.
				//3. DMA Rd (64bit read) cpl data.
				//	 triggered by e_dma_rd_data_rd.

				// Start DMA test by sending DMA RD to SoNIC.
				start_dma_rd();
//				start_dma_wr();
				// Main Loop
				while(1)
				begin
					// wait for dma 64bit read.
					@(e_desc_rd);			//upon event, fake dma rd response.

					while(pending_rd64_queue.size() != 0)
					begin
						src_transaction = pending_rd64_queue.pop_front();
						//print_transaction(src_transaction, SOURCE, j);
						//check queued transaction to see if it is rd or wr
						//transaction, we need to tell the difference between dma rd
						//descriptor read and dma_wr descriptor read, the only
						//difference is their target address.
						send_dma_rd_cpl(src_transaction.data[9:0], src_transaction.data[47:40]);
					end
				end

				disable test_threads;
			end // source_data_thread

			// threads that handles all incoming transaction, and active the
			// corrresponding handler to process the transaction. For example,
			// if the ckech_transaction see a transaction to 0x810, the dma_wr
			// dt is sent to SoNIC, if the handle_sink_transaction see a 0x910, the
			// dma_rd dt is sent to SoNIC, if the check trnasction see other 
			// values the 64-bit read is active. If the check tranaction is 
			// - 1. see if the transaction is read/write
			// - 2. if read, check whether is 0x910, or 0x810, or other
			// address
			// - 3. if read, sent dt, wait for cpl
			sink_thread: begin

				j = 0;
				`SNK.set_ready(1);
				while (1)
				begin
	
					/*
					if(j%2 == 1)
					begin
						`SNK.set_ready(0);
						repeat(`BACK_PRESSURE_CYCLES) @(posedge `CLK.clk);
						`SNK.set_ready(1);
					end
					*/
										
					@ (`SNK.signal_transaction_received);
					snk_transaction = snk_pop_transaction();
					print_transaction(snk_transaction, SINK, j);

					// Five type of transaction are received by this thread,
					// Each transaction should have its own queue and with its
					// own thread to handle.
					// 1. The Command response.
					// 2. The DMA Rd dt 32bit read. 00000008 at 0x910
					// 3. The DMA Wr dt 32bit read, 00000008 at 0x810
					// 4. The DMA Rd, 64-bit read, 2000_00xx at diff offset.
					// 5. The DMA Wr, 64-bit write, 6000_00xx at diff offset.
					// 6. The MSI IRQ.
					handle_sink_transaction(snk_transaction);
					//compare_result = compare_result & compare_transaction(j, snk_transaction, expected_transaction);
					j++;		
				end
			end // sink_thread

			// thread that handles the income MSI interrupt, and dma write
			// for every MSI interrupt, we read the buffered data count, and 
			// issue a DMA wr to SoNIC.
			dma_irq_thread: begin
				bit [31:0] dword_read;
				bit valid;
				bit data_ready;
				bit [23:0] num_ready;
				bit [31:0] curr_rx_wptr;
				bit [31:0] curr_tx_wptr;
				bit [31:0] eplast;
				bit [31:0] last_rx_wptr;
				bit [31:0] dma_size;

				while(1)
				begin
					@e_irq_rd;
					dword_read = read_dword_ram(64'h178000000);
					curr_rx_wptr = read_dword_ram(64'h178000008);
					curr_tx_wptr = read_dword_ram(64'h17800000C);

					valid = dword_read[0];
					eplast = read_dword_ram(32'h80C);				

					$sformat(message, "data at h178000000 = %0x, valid bit is %d, rx_wptr_qword is %x, tx_wptr_qword is %x, eplast = %x", dword_read, valid, curr_rx_wptr, curr_tx_wptr, eplast);
					print(VERBOSITY_INFO, message);

					//Don't issue the next DMA write, until the last one is
					//finished.
					//if ((valid == 1) && (eplast[15:0] == 0)) begin
					if ((eplast[15:0] == 0)) begin
						num_ready = dword_read[31:8];
						//check if there is a valid irq data.
						//IRQ base address is at 0x1_7800_0000
						if(curr_rx_wptr < last_rx_wptr) begin
							dma_size = curr_rx_wptr + 32'h4000 - last_rx_wptr;
						end
						else begin
							dma_size = curr_rx_wptr - last_rx_wptr;
						end

						last_rx_wptr = curr_rx_wptr;
						$sformat(message, "curr_rx_wptr = %x, dma_size = %x ", curr_rx_wptr, dma_size);
						print(VERBOSITY_INFO, message);
						write_byte_ram(64'h178000000, 0);	//invalidate irq data
						
						write_dword_ram(32'h810, 32'h30000 + dma_size);
						write_dword_ram(32'h814, 32'h0);
						write_dword_ram(32'h818, 32'h1);
						write_dword_ram(32'h81C, 32'h5000);
	
				// 		Handle the irq by issuing a DMA wr command.
						write_dword_ram(32'h80C, 32'hBABE);

						print (VERBOSITY_INFO, "start new dma wr request");
						start_dma_wr_2();	// input dma size, and local ring address.
					end
				end
			end

			dma_dt_thread: begin
				while(1)
				begin
					@e_dma_dt_rd;
					dma_dt_transaction = pending_rd32_queue.pop_front();
					handle_rd32_transaction(dma_dt_transaction);
				end
			end

			dma_write_thread: begin
				while(1)
				begin
				@e_dma_wr64;
				dma_wr64_transaction = pending_wr64_queue.pop_front();				
				handle_wr64_transaction(dma_wr64_transaction);
				->e_irq_rd;
				end
			end
	
			dma_write32_thread: begin
				while(1)
				begin
				@e_dma_wr32;
				dma_wr32_transaction = pending_wr32_queue.pop_front();
				handle_wr32_transaction(dma_wr32_transaction);
				end
			end
		join_any;

	disable test_threads;	

	end


	//test cases
	//Issue commands that only requires one argument.
	//Assume that the command registers starts at offset 0x50 on the bar.
	//We write parameter and return address, before writing to the command reg
	//The command is executed as soon as the command register is programmed.
	//The PCI device configuration values are from the simulation.
	task init ();
		`CFG.set_devcsr(32'h2050);
		`CFG.set_busdev(12'h21);
		`CFG.set_tcvcmap(24'h0);
		`CFG.set_prmcsr(32'h6);
		`CFG.set_msicsr(32'ha5);
		`LINKCSR.set_export(32'h10820040);	//Fix the qsys design
		`CRED.set_export(36'hFFFFFFBBB);
		`MSI_IRQ.set_ack(1'b1);
	endtask

	task command_init();
		cur_cmd = `CMD_RESET;
		issue_command_no_argument(cur_cmd);
		#100
		cur_cmd = `CMD_SET_RX_BLOCK_SIZE;
		issue_command_one_argument(cur_cmd, `IRQ_SIZE);
		#100
		cur_cmd = `CMD_GET_RX_BLOCK_SIZE;
		issue_command_no_argument(cur_cmd);
		#100
		cur_cmd = `CMD_CONFIG_IRQ;
		issue_command_one_argument(cur_cmd, 32'h20000);
		#100
		cur_cmd = `CMD_SET_ADDRESS_IRQ;
		issue_command_two_argument(cur_cmd, `IRQ_BASE_ADDRESS_HI, `IRQ_BASE_ADDRESS_LO);
		#100
		cur_cmd = `CMD_GET_RX_SIZE;
		issue_command_no_argument(cur_cmd);
		#100
		cur_cmd = `CMD_START_SFP1;
		issue_command_no_argument(cur_cmd);
	endtask

	task issue_command_no_argument (input int cmd_type);
		//send return address msw
		tlp_mem_wr_32 m = new;

		m.tlp.length = 1;
		m.tlp.address = 29'h80018;	//0x00200060
		m.tlp.first_be = 4'hF;
		m.send_command(4, 16'hFFF, 0, 16'hF);	//MSW address is 0.

		//send return address lsw
		m.tlp.length = 1;
		m.tlp.address = 29'h80019;	//0x00200064
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = 32'hA00;
		m.send_command(4, 16'hFFFF, 32'hA00, 16'hFFFF);	//LSW address is 0xA00

		//send command
		m.tlp.length = 1;
		m.tlp.address = 29'h80014;	//0x00200050
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = cmd_type;
		m.send_command(4, 16'hFFF, cmd_type,16'hF);	//Command
	endtask

	task issue_command_one_argument (input int cmd_type, int param0);
		tlp_mem_wr_32 m = new;
		
		m.tlp.length = 1;
		m.tlp.address = 29'h80018;
		m.tlp.first_be = 4'hF;
		m.send_command(4, 16'hFFF, 0, 16'hF);	//
		
		//send return address lsw
		m.tlp.length = 1;
		m.tlp.address = 29'h80019;	//0x00200064
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = 32'hA00;
		m.send_command(4, 16'hFFFF, 32'hA00, 16'hFFFF);	//LSW address is 0xA00

		//send param0
		m.tlp.length = 1;
		m.tlp.address = 29'h80015;	//0x00200054
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = param0;
		m.send_command(4, 16'hFFFF, param0, 16'hF);	

		//send command
		m.tlp.length = 1;
		m.tlp.address = 29'h80014;	//0x00200050
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = cmd_type;
		m.send_command(4, 16'hFFF, cmd_type,16'hF);	//Command
	endtask
	
	task issue_command_two_argument (input int cmd_type, int param0, int param1);
		tlp_mem_wr_32 m = new;
		
		m.tlp.length = 1;
		m.tlp.address = 29'h80018;
		m.tlp.first_be = 4'hF;
		m.send_command(4, 16'hFFF, 0, 16'hF);	//
		
		//send return address lsw
		m.tlp.length = 1;
		m.tlp.address = 29'h80019;	//0x00200064
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = 32'hA00;
		m.send_command(4, 16'hFFFF, 32'hA00, 16'hFFFF);	//LSW address is 0xA00

		//send param0
		m.tlp.length = 1;
		m.tlp.address = 29'h80015;	//0x00200054
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = param0;
		m.send_command(4, 16'hFFFF, param0, 16'hF);	

		//send param1
		m.tlp.length = 1;
		m.tlp.address = 29'h80016;	//0x00200058
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = param1;
		m.send_command(4, 16'hFFFF, param1, 16'hF);	

		//send command
		m.tlp.length = 1;
		m.tlp.address = 29'h80014;	//0x00200050
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = cmd_type;
		m.send_command(4, 16'hFFF, cmd_type,16'hF);	//Command
	endtask

	task start_dma_rd ();
		//set dma_descriptor
		tlp_mem_wr_32 m = new;
		int n_dma = 3;
		int ctrl_dword = 32'h60000 + n_dma;

		m.tlp.length = 1;
		m.tlp.address = 29'h80004;	//dma rd, dw0
		m.tlp.first_be = 4'hF;
		m.send_command(4, 16'hFFF, ctrl_dword, 16'hF);	
	
		m.tlp.length = 1;
		m.tlp.address = 29'h80005;	//0x200014, dma rd dw1
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = 32'h0;
		m.send_command(4, 16'hFFF, 32'h0, 16'hF);
		
		m.tlp.length = 1;
		m.tlp.address = 29'h80006;	//0x200018, dma rd dw2
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = 32'h900;
		m.send_command(4, 16'hFFF, 32'h900, 16'hF);
		
		//set dma rc_last to start dma
		m.tlp.length = 1;
		m.tlp.address = 29'h80007;	//0x20001C, dma rd dw3
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = n_dma - 1;
		m.send_command(4, 16'hFFF, n_dma - 1, 16'hF);
	endtask

	task handle_rd32_transaction (transaction_class transaction);
		tlp_cpl_with_data m = new;
		int i;
		int n_word;
		int base_addr;
		bit[7:0] tag;
		base_addr  = transaction.data[95:64];
		n_word = transaction.data[9:0];
		tag = transaction.data[47:40];
			
		m.tlp.length = n_word;
		m.tlp.byte_count = n_word * 4;
		m.tlp.tag 	= tag;
		m.tlp.requester_id = 16'h0108;
		m.tlp.lower_address = 7'h10;
		m.send_cpl_header(1, 16'hFFF);
		
		for (i = 0; i < n_word[31:2] - 1; i++) begin
			$sformat(message, "base address %x", base_addr + i * 16);
			print(VERBOSITY_INFO, message);
			m.payload.dw0 = read_dword_ram(base_addr + i * 16);//32'h00021000;	//DMA length is in dwords, 32-bits.
			m.payload.dw1 = read_dword_ram(base_addr + i * 16 +4);//32'h0;
			m.payload.dw2 = read_dword_ram(base_addr + i * 16 +8);//32'h1;
			m.payload.dw3 = read_dword_ram(base_addr + i * 16 +12);//32'h8df0;
			m.send_cpl_payload(1, 16'hFFFF);
		end

		$sformat(message, "base address %x", base_addr + i * 16);
		print(VERBOSITY_INFO, message);
		m.payload.dw0 = read_dword_ram(base_addr + i * 16);//32'h31000;
		m.payload.dw1 = read_dword_ram(base_addr + i * 16 + 4);//32'h4000;
		m.payload.dw2 = read_dword_ram(base_addr + i * 16 + 8);//32'h1;
		m.payload.dw3 = read_dword_ram(base_addr + i * 16 + 12);//32'h20ef0;
		m.send_cpl_endpacket(1, 16'hFFFF);
	endtask

	task handle_wr64_transaction(transaction_class transaction);
		transaction_class payload = new;
		int len, i;
		bit[63:0] base_addr;
		len = transaction.data[9:0];
		base_addr = {transaction.data[95:64], transaction.data[127:96]};
		
		$sformat(message, "wr64 data = %0x", transaction.data);
		print(VERBOSITY_INFO, message);

		for(i=0; i < len[31:2]; i++) begin
			payload = pending_wr64_queue.pop_front();
			$sformat(message, "payload data = %x at base_address = 0x%x", payload.data[127:0], base_addr + i * 16);
			print(VERBOSITY_INFO, message);
			write_dword_ram(base_addr + i * 16, payload.data[31:0]);
			write_dword_ram(base_addr + i * 16 + 4, payload.data[63:32]);
			write_dword_ram(base_addr + i * 16 + 8, payload.data[95:64]);
			write_dword_ram(base_addr + i * 16 + 12, payload.data[127:96]);
		end
	endtask

	task handle_wr32_transaction(transaction_class transaction);
		transaction_class payload = new;
		int len, i;
		int idx;
		bit[31:0] base_addr;
		len = transaction.data[9:0];
		base_addr = transaction.data[95:64];

		$sformat(message, "wr32 data = %0x", transaction.data);
		print(VERBOSITY_INFO, message);

		payload = pending_wr32_queue.pop_front();
		$sformat(message, "payload data = %x at base_address = 0x%x", payload.data[127:0], base_addr + i * 16);
		print(VERBOSITY_INFO, message);
		if (len < 4) begin
			case (len[1:0])
			2'h1: begin	
				write_dword_ram(base_addr + i * 16, payload.data[31:0]);
			end
			2'h2: begin
				
				write_dword_ram(base_addr + i * 16, payload.data[31:0]);
				write_dword_ram(base_addr + i * 16 + 4, payload.data[63:32]);
			end
			2'h3: begin
				write_dword_ram(base_addr + i * 16, payload.data[31:0]);
				write_dword_ram(base_addr + i * 16 + 4, payload.data[63:32]);
				write_dword_ram(base_addr + i * 16 + 8, payload.data[95:64]);
			end
			endcase
		end
		else
		begin
			print(VERBOSITY_INFO, "WR32 more than 4DWORDS not supported!");	
		end
	endtask

	//compares the transactions received by sink BFM with the expected transactions
	//This could be changed to handle_rd64_transaction.
	//DMA payload contains the scrambled data from PCS.
	//Data are written to the tx fifo ring by DMA engine.
	task send_dma_rd_cpl(input int n_dword, bit [7:0] tag);
		int i;
		tlp_cpl_with_data m = new;		
		m.tlp.length = n_dword;
		m.tlp.byte_count = n_dword * 4;
		m.tlp.requester_id = 16'h0108;
		m.tlp.tag	= tag;
		m.tlp.lower_address = 7'h0;
		m.send_cpl_header(1, 16'hFFF);

		for (i = 0; i < (n_dword/4 - 1); i++)
		begin
			m.payload.dw0 = 32'haabbcc00 + count;
			m.payload.dw1 = 32'haabbcc00 + count + 1;
			m.payload.dw2 = 32'haabbcc00 + count + 2;
			m.payload.dw3 = 32'haabbcc00 + count + 3;
			count = count+4;
			m.send_cpl_payload(1, 16'hFFFF);
		end 
		
		m.payload.dw0 = 32'haabbcc00 + count;
		m.payload.dw1 = 32'haabbcc00 + count + 1;
		m.payload.dw2 = 32'haabbcc00 + count + 2;
		m.payload.dw3 = 32'haabbcc00 + count + 3;
		count = count + 4;
		m.send_cpl_endpacket(1, 16'hFFFF);

	endtask

	// This task executes upon reception of interrupt from sonic.
	// DMA Wr descriptor table should be prepared before this is sent.
	task start_dma_wr ();
		tlp_mem_wr_32 m = new;
		int n_dma = 5;
		int ctrl_dword = 32'h60000 + n_dma;

		print(VERBOSITY_INFO, "START DMA WR DESCRIPTOR");

		m.tlp.length = 1;
		m.tlp.address = 29'h80000;	//0x200000, dma wr, dw0
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = ctrl_dword;
		m.send_command(4, 16'hFFF, ctrl_dword, 16'hF);	
	
		m.tlp.length = 1;
		m.tlp.address = 29'h80001;	//0x200004, dma wr dw1
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = 32'h0;
		m.send_command(4, 16'hFFF, 32'h0, 16'hF);
		
		m.tlp.length = 1;
		m.tlp.address = 29'h80002;	//0x200008, dma wr dw2
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = 32'h800;
		m.send_command(4, 16'hFFF, 32'h800, 16'hF);
		
		//set dma rc_last to start dma
		m.tlp.length = 1;
		m.tlp.address = 29'h80003;	//0x20000C, dma rd dw3
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = n_dma - 1;
		m.send_command(4, 16'hFFF, n_dma - 1, 16'hF);
	endtask

	task start_dma_wr_2 ();
		tlp_mem_wr_32 m = new;
		int n_dma = 1;
		int ctrl_dword = 32'h00000 + n_dma;

		print(VERBOSITY_INFO, "START DMA WR DESCRIPTOR");

		//reset DMA engine
		m.tlp.length = 1;
		m.tlp.address = 29'h80000;	//0x200000, dma wr, dw0
		m.tlp.first_be = 4'hF;
		m.send_command(4, 16'hFFF, 32'hFFFFFFFF, 16'hF);	

		m.tlp.length = 1;
		m.tlp.address = 29'h80000;	//0x200000, dma wr, dw0
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = ctrl_dword;
		m.send_command(4, 16'hFFF, ctrl_dword, 16'hF);	
	
		m.tlp.length = 1;
		m.tlp.address = 29'h80001;	//0x200004, dma wr dw1
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = 32'h0;
		m.send_command(4, 16'hFFF, 32'h0, 16'hF);
		
		m.tlp.length = 1;
		m.tlp.address = 29'h80002;	//0x200008, dma wr dw2
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = 32'h800;
		m.send_command(4, 16'hFFF, 32'h800, 16'hF);
		
		//set dma rc_last to start dma, to clear init signal
		m.tlp.length = 1;
		m.tlp.address = 29'h80003;	//0x20000C, dma rd dw3
		m.tlp.first_be = 4'hF;
		m.tlp.__reserved_4 = n_dma - 1;
		m.send_command(4, 16'hFFF, n_dma - 1, 16'hF);
	endtask

	//pop the transaction from Sink BFM queue and get the decriptors
	function automatic transaction_class snk_pop_transaction(
	);    
		transaction_class transaction = new;
		`SNK.pop_transaction();    
		transaction.idles         = `SNK.get_transaction_idles(); 
		transaction.startofpacket = `SNK.get_transaction_sop();     
		transaction.endofpacket   = `SNK.get_transaction_eop();     
		transaction.channel       = `SNK.get_transaction_channel(); 
		transaction.data		  = `SNK.get_transaction_data();
		transaction.error 	      = `SNK.get_transaction_error();   
		transaction.empty 	      = `SNK.get_transaction_empty();
		return transaction;
	endfunction

	// 1. The Command response.
	// 2. The DMA Rd dt 32bit read. 00000008 at 0x910
	// 3. The DMA Wr dt 32bit read, 00000008 at 0x810
	// 4. The DMA Rd, 64-bit read, 2000_00xx at diff offset.
	// 5. The DMA Wr, 64-bit write, 6000_00xx at diff offset.
	// 6. The MSI IRQ.
	// 7. The DMA dt update, which may be 32-bit write.
	task handle_sink_transaction(
	  transaction_class transaction
	);
		string message;
		int i;

		//transaction type 2 & 3.
		if ((transaction.data[31:24] == 8'h0) && 
			(transaction.data[63:48] == 16'h0108))
		begin
			$sformat(message, "DMA read length: %0d dwords", transaction.data[9:0]);
			print(VERBOSITY_INFO, message);
			pending_rd32_queue.push_back(transaction);
			->e_dma_dt_rd;
		end
		//transaction type 4.
		else if ((transaction.data[31:24] == 8'h20) && 
				 (transaction.data[63:48] == 16'h0108))
		begin
			$sformat(message, "DMA read length: %0d dwords", transaction.data[9:0]);
			print(VERBOSITY_INFO, message);
			pending_rd64_queue.push_back(transaction);
			count_push = count_push + 1;
			->e_desc_rd;
		end
		//transaction type 5 & 6.
		else if ((transaction.data[31:24] == 8'h60) &&
				 (transaction.data[63:48] == 16'h0108))
		begin
			pending_wr64_queue.push_back(transaction);

			$sformat(message, "DMA WR64 DATA length: %0d dwords", transaction.data[9:0]);
			print(VERBOSITY_INFO, message);
			//Wait for the data segment of the irq.
			for (i = 0; i < transaction.data[9:2]; i++) begin
				@ (`SNK.signal_transaction_received);
				dma_wr64_transaction = snk_pop_transaction();
				print_transaction(dma_wr64_transaction, SINK, j);
				pending_wr64_queue.push_back(dma_wr64_transaction);
				print(VERBOSITY_INFO, "push on pending_wr64_queue");
			end
			->e_dma_wr64;
		end	
		//transaction type 7.
		else if ((transaction.data[31:24] == 8'h40) &&
				 (transaction.data[63:48] == 16'h0108))
		begin
			pending_wr32_queue.push_back(transaction);

			$sformat(message, "DMA WR32 DATA length: %0d dwords", transaction.data[9:0]);
			print(VERBOSITY_INFO, message);
			//Wait for the data segment of the irq.
			if ((transaction.data[9:2] == 0) && transaction.data[1:0] != 0) begin
				@(`SNK.signal_transaction_received);
				dma_wr32_transaction = snk_pop_transaction();
				print_transaction(dma_wr32_transaction, SINK, j);
				pending_wr32_queue.push_back(dma_wr32_transaction);
				print(VERBOSITY_INFO, "push on pending_wr32_queue");
			end
			else begin	//Assume the data is Oword aligned.
				for (i = 0; i < transaction.data[9:2]; i++) begin
					@ (`SNK.signal_transaction_received);
					dma_wr32_transaction = snk_pop_transaction();
					print_transaction(dma_wr32_transaction, SINK, j);
					pending_wr32_queue.push_back(dma_wr32_transaction);
					print(VERBOSITY_INFO, "push on pending_wr32_queue");
				end
			end
			->e_dma_wr32;

		end
	endtask

	//prints the transaction to simulator console
	function automatic void print_transaction(
	  transaction_class transaction, 
	  label_t label_name,  
	  int count
	);
	  string message;
	  if (label_name == SOURCE)
	  $sformat(message, "%m: Source BFM: Send transaction %0d ", count);
	  else
	  $sformat(message, "%m: Sink BFM: Receive transaction %0d ", count);
	  print(VERBOSITY_INFO, message);                  
	  $sformat(message, "%m:   Data:  	%0x", transaction.data);
	  print(VERBOSITY_INFO, message);                        
	  $sformat(message, "%m:   Idles: 	%0d", transaction.idles);
	  print(VERBOSITY_INFO, message);                  	       
	  $sformat(message, "%m:   SOP:   	%0x", transaction.startofpacket);
	  print(VERBOSITY_INFO, message);                  	       
	  $sformat(message, "%m:   EOP:   	%0x", transaction.endofpacket);
	  print(VERBOSITY_INFO, message);                  	       
	  $sformat(message, "%m:   Channel: %0d", transaction.channel);
	  print(VERBOSITY_INFO, message);                  	       
	  $sformat(message, "%m:   Error:   %0x", transaction.error);
	  print(VERBOSITY_INFO, message);                  	       
	  $sformat(message, "%m:   Empty:   %0d", transaction.empty);
	  print(VERBOSITY_INFO, message);    
	endfunction

	function automatic void print_irq_transaction(
		transaction_class transaction
	);
		string message;
		$sformat(message, "%m: IRQ Transaction");
		print(VERBOSITY_INFO, message);
		$sformat(message, "%m: Byte Dropped Tx %0d", transaction.data[127:96]);
		print(VERBOSITY_INFO, message);
		$sformat(message, "%m: Byte Dropped Rx %0d", transaction.data[95:64]);
		print(VERBOSITY_INFO, message);
		$sformat(message, "%m: Bytes sent %0d", transaction.data[63:32]);
		print(VERBOSITY_INFO, message);
		$sformat(message, "%m: Bytes ready %0d", transaction.data[31:8]);
		print(VERBOSITY_INFO, message);
		$sformat(message, "%m: SFP1 stopped %0d", transaction.data[3]);
		print(VERBOSITY_INFO, message);
		$sformat(message, "%m: SFP2 stopped %0d", transaction.data[2]);
		print(VERBOSITY_INFO, message);
		$sformat(message, "%m: Data Ready in IRQ %0d", transaction.data[1]);
		print(VERBOSITY_INFO, message);
		$sformat(message, "%m: valid irq %0d", transaction.data[0]);
		print(VERBOSITY_INFO, message);
	endfunction

	//compares the transactions received by sink BFM with the expected transactions
	function automatic bit compare_transaction(
	int transaction_number,		       
	transaction_class test_transaction,
	transaction_class ref_transaction
	);
	string message;
	  
	if (test_transaction.data		 != ref_transaction.data ||
	  test_transaction.startofpacket != ref_transaction.startofpacket ||     
	  test_transaction.endofpacket   != ref_transaction.endofpacket ||     
	  test_transaction.channel	 != ref_transaction.channel || 
	  test_transaction.error 	 != ref_transaction.error ||   
	  test_transaction.empty 	 != ref_transaction.empty) 
		begin
			$sformat(message, "%m: Transaction %0d compare FAIL", transaction_number);
			print(VERBOSITY_ERROR, message);
			return 1'b0;
	end
		else begin
			$sformat(message, "%m: Transaction %0d compare OK", transaction_number);
			print(VERBOSITY_INFO, message);
			return 1'b1;	 
		end
	endfunction

endmodule
