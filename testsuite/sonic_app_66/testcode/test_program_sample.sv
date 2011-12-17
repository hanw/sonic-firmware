//----------------------------------------------------------------------------------------------
// This test module uses System Verilog syntax.
//----------------------------------------------------------------------------------------------


// console messaging level
`define VERBOSITY VERBOSITY_INFO

//BFM hierachy
`define LEGACY_IRQ	tb.sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_legacy_irq_bfm
`define MSI_IRQ		tb.sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_msi_irq_bfm
`define ERR_DESC	tb.sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_err_desc_bfm
`define PEX_MSI_NUM tb.sonic_application_top_testbench_tb_sonic_application_top_testbench_inst_pex_msi_num_bfm

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

module test_program();

   import verbosity_pkg::*;
   
   typedef logic [`ST_DATA_W-1    :0] AvalonSTData_t;
   typedef logic [`ST_CHANNEL_W-1 :0] AvalonSTChannel_t;
   typedef logic [`ST_EMPTY_W-1   :0] AvalonSTEmpty_t;
   typedef logic [`ST_ERROR_W-1   :0] AvalonSTError_t;

   //the ST transaction is defined using SystemVerilog structure data type
   typedef struct 		      
				      {    int               idles;  //idle is not part of Avalon ST signal, it is used in BFM only
					 bit startofpacket;
					 bit endofpacket;
					 AvalonSTChannel_t channel;
					 AvalonSTData_t    data;
					 AvalonSTError_t   error;
					 AvalonSTEmpty_t   empty;
				      } transaction_struct;
   
   typedef enum 			     int 
					     {  SOURCE,
						SINK
						} label_t;
   
   transaction_struct src_transaction, snk_transaction, expected_transaction;
   transaction_struct src_transaction_backup[$];
   
   int 					     i, j, src_response_latency;
   bit 					     compare_result = 1;
   string 				     message;
   
   initial
     begin
	set_verbosity(`VERBOSITY);
	`SRC.set_response_timeout(`SOURCE_RESP_TIMEOUT);
	`SRC.init();
	`SNK.init();
	
	//wait for reset to de-assert and trigger start_test event
	wait(`RST.reset == 0);
	
	fork: test_threads      
	   source_data_thread: begin
	      for (i = 0; i < `NUMBER_OF_TRANSACTIONS; i++)
		begin 
		   src_transaction.idles          = 0;	      
		   src_transaction.channel        = 0;
		   src_transaction.data           = i;
		   src_transaction.error          = 0;
		   src_transaction.empty          = 0;
		   if (i == 0)	  
		     src_transaction.startofpacket  = 1;
		   else
		     src_transaction.startofpacket  = 0;
		   if (i == `NUMBER_OF_TRANSACTIONS-1)
		     src_transaction.endofpacket    = 1;
		   else
		     src_transaction.endofpacket    = 0;
		   
		   src_transaction_backup.push_back(src_transaction);
		   
		   print_transaction(src_transaction, SOURCE, i);
		   
		   src_pushing_transaction(src_transaction);				
		end
	      
	      wait ((`SRC.get_transaction_queue_size() == 0) && (`SNK.get_transaction_queue_size() == 0) && (j == `NUMBER_OF_TRANSACTIONS));
	      
	      disable test_threads;
	   end // source_data_thread

	   sink_thread: begin
	      j = 0;
	      `SNK.set_ready(1);
	      while (1)
		begin
		   if(j%2 == 1)
		     begin
			`SNK.set_ready(0);
			repeat(`BACK_PRESSURE_CYCLES) @(posedge `CLK.clk);
			`SNK.set_ready(1);
		     end
		   
		   @ (`SNK.signal_transaction_received);
		   snk_transaction = snk_pop_transaction();
		   print_transaction(snk_transaction, SINK, j);
		   expected_transaction = src_transaction_backup.pop_front();
		   compare_result = compare_result & compare_transaction(j, snk_transaction, expected_transaction);							
		   j++;		
		end
	   end // sink_thread
	   
	   source_response_thread: begin	    	    
	      while (1) 
		begin
		   @(`SRC.signal_response_done);
		   `SRC.pop_response();
		   src_response_latency = `SRC.get_response_latency();
		   $sformat(message, "%m: Source response latency %0d ", src_response_latency);
		   print(VERBOSITY_INFO, message);        								 
		end 
	   end // source_response_thread
	   
	join_any;
	disable test_threads;  // kill any threads still running
	
	
	if (compare_result == 1'b1) 
	  begin
	     $sformat(message, "%m: Test Passed");
	     print(VERBOSITY_INFO, message);     	  
	  end
	else begin
	   $sformat(message, "%m: Test Failed");
	   print(VERBOSITY_WARNING, message);
	end
	$stop;
	
     end
   
   
   
   //functions
   
   //push the transaction to Source BFM queue
   function automatic void src_pushing_transaction(
						   transaction_struct transaction
						   );
      `SRC.set_transaction_idles   (transaction.idles);
      `SRC.set_transaction_sop     (transaction.startofpacket);
      `SRC.set_transaction_eop     (transaction.endofpacket);
      `SRC.set_transaction_channel (transaction.channel);
      `SRC.set_transaction_data    (transaction.data);
      `SRC.set_transaction_error   (transaction.error);	 
      `SRC.set_transaction_empty   (transaction.empty);	 
      `SRC.push_transaction();  
   endfunction
   
   //pop the transaction from Sink BFM queue and get the decriptors
   function automatic transaction_struct snk_pop_transaction(
							     );    
      transaction_struct transaction;
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
   
   //prints the transaction to simulator console
   function automatic void print_transaction(
					     transaction_struct transaction, 
					     label_t label_name,  
					     int count
					     );
      string 					 message;
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
   
   //compares the transactions received by sink BFM with the expected transactions
   function automatic bit compare_transaction(
					      int transaction_number,		       
					      transaction_struct test_transaction,
					      transaction_struct ref_transaction
					      );
      string 					  message;
      
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
