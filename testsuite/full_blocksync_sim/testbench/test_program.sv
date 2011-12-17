/*
 * Test program that generate 10G bitstream
 */
`timescale 1 ps / 1 ps

`define VERBOSITY VERBOSITY_INFO

`define CLK tb.sonic_blocksync_sim_inst_clk_bfm
`define RESET tb.sonic_blocksync_sim_inst_reset_bfm
`define SRC_CH0 tb.sonic_blocksync_sim_inst.xcvr_dataout_0
`define SNK_CH0 tb.sonic_blocksync_sim_inst.xcvr_datain_0
`define SRC_CH1 tb.sonic_blocksync_sim_inst.xcvr_dataout_1
`define SNK_CH1 tb.sonic_blocksync_sim_inst.xcvr_datain_1

`define DRIVER tb.sonic_blocksync_sim_inst.sonic_blocksync_sim_top_0.drvr

`define NUMBER_OF_TRANSACTIONS 60000

module test_program();

   import verbosity_pkg::*;
   event idle;
   string message;
   typedef logic [39:0] AvalonSTData_t;

   //the ST transaction is defined using SystemVerilog structure data type
   typedef struct 	{
      AvalonSTData_t data;
   } transaction_struct;
   
   typedef enum 	int {
			     SOURCE,
			     SINK
			     } label_t;
   
   transaction_struct src_transaction;
   int 			i;
   integer 		vec_in;   
   reg [39:0] 		data;
   reg 			unused_result;
      
   //push the transaction to Source BFM queue
   function automatic void src_ch0_push_transaction
     (
      transaction_struct transaction
      );
      `SRC_CH0.set_transaction_data    (transaction.data);
      `SRC_CH0.push_transaction();
     // print_transaction(src_transaction, SOURCE, i);
   endfunction // set_transaction_data
   
   //prints the transaction to simulator console
   function automatic void print_transaction
     (
      transaction_struct transaction, 
      label_t label_name,  
      int count
      );
      string message;
      
      if (label_name == SOURCE)
	$sformat(message, "%d %s: Source BFM: Send transaction %0d ", ($time/1000), "ns", count);
      else
	$sformat(message, "%d %s: Sink BFM: Receive transaction %0d ", ($time/1000), "ns", count);
      print(VERBOSITY_INFO, message);                  
      $sformat(message, "%d %s:   Data:  	%0x", ($time/1000), "ns", transaction.data);
      print(VERBOSITY_INFO, message);                        
   endfunction // if

   /*
    * Simulated software driver for Channel0
    */
   task chan0_driver;
      reg [31:0] read_data;
      reg [31:0] rx_ring_ptr;
      reg [31:0] dwords_to_fetch;
      
      rx_ring_ptr = 0;
      
      // check chan0 irq data for rx ring write pointer.
      while(1)
	begin
	   // SCR_MEMSLAVE based at 0x40.
	   read_data = `DRIVER.shmem_read(32'h0000_0048, 4) & 32'h3FFF;
	   // if enough data buffered in rx ring, issue a DMA.
	   if (read_data != 0 && rx_ring_ptr != read_data)
	     begin
		if (read_data > rx_ring_ptr)
		  dwords_to_fetch = read_data - rx_ring_ptr;
		else
		  dwords_to_fetch = 32'h4000 + read_data - rx_ring_ptr;
		
		rx_ring_ptr = read_data;
		
		// dma rd is counted in number of Owords, thus, divide dwords_to_fetch by 2.
		`DRIVER.issue_dma_wr(`DRIVER.BAR_TABLE_POINTER, 2, 0, 0, dwords_to_fetch[31:1]);
	     end
	   else 
	     #1000; //wait
	end
   endtask // dma_driver
   
   /*
    * Simulated xcvr inputs for Channel 0
    */
   task chan0_xcvr_src;
      #43000000; // Wait for PCIe initialization completion & BAR commands.
      
      for (i = 0; i < `NUMBER_OF_TRANSACTIONS; i++)
	begin
	   $fscanf (vec_in, "%h", data);
	   src_transaction.data = data;
	   src_ch0_push_transaction(src_transaction);
	   #1; //push again in next clock cycle
	end   
      
   endtask // chan0_xcvr_src

   task test_program;
      fork: test_threads
	 chan0_xcvr_src();
	 chan0_driver();
      join;
      disable test_threads;      
   endtask // test_program
      
   initial
     begin
	set_verbosity(`VERBOSITY);
	
	$sformat(message, "%m: Helloworld message!");
	print(VERBOSITY_INFO, message);

	`CLK.clock_start();
	`RESET.reset_deassert();
	
	`SRC_CH0.init();
	`SNK_CH0.init();
	`SRC_CH1.init();
	`SNK_CH1.init();
	`SRC_CH0.set_max_transaction_queue_size(10000);
	
	vec_in = $fopen("data/test_vector.dat", "r");

	test_program();
	
     end // initial begin

endmodule // test_program
