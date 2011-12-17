// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $File: //acds/rel/11.0/ip/sopc/components/verification/altera_avalon_st_monitor_bfm/altera_avalon_st_monitor_transactions.sv $
// $Revision: #1 $
// $Date: 2011/02/14 $
// $Author: max $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_avalon_st_monitor_transactions
// =head1 SYNOPSIS
// Streaming Avalon Bus Protocol Checker
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This module implements Avalon ST protocol transaction recording.
//-----------------------------------------------------------------------------

module altera_avalon_st_monitor_transactions(
                                             clk,
                                             reset,
                                             tap
                                            );

   // =head1 PARAMETERS
   parameter ST_SYMBOL_W       = 8;  // number of bits in one symbols    
   parameter ST_NUMSYMBOLS     = 4;  // number of symbols in one data  
   parameter ST_CHANNEL_W      = 0;  // width of channel signal
   parameter ST_ERROR_W        = 0;  // width of error signal
   parameter ST_EMPTY_W        = 0;  // width of empty signal
   
   parameter ST_READY_LATENCY  = 0;  // fixed ready latency in cycles
   parameter ST_MAX_CHANNELS   = 1;  // maximum number of channels 
   
   parameter USE_PACKET        = 0;  // data transfer in packet format
   parameter USE_CHANNEL       = 0;  // use channel port
   parameter USE_ERROR         = 0;  // use error port
   parameter USE_READY         = 1;  // use ready port
   parameter USE_VALID         = 1;  // use valid port
   parameter USE_EMPTY         = 0;  // use empty port
   parameter ST_BEATSPERCYCLE  = 1;  // Max number of packets per cycle
   
   parameter ST_MAX_PACKET_SIZE = 1; // Max number of packet size covered

   localparam VERSION          = "__ACDS_VERSION_SHORT__";               

   localparam ST_DATA_W        = ST_SYMBOL_W * ST_NUMSYMBOLS;
   localparam ST_MDATA_W       = ST_BEATSPERCYCLE * ST_DATA_W;
   localparam ST_MCHANNEL_W    = ST_BEATSPERCYCLE * ST_CHANNEL_W;
   localparam ST_MERROR_W      = ST_BEATSPERCYCLE * ST_ERROR_W;
   localparam ST_MEMPTY_W      = ST_BEATSPERCYCLE * ST_EMPTY_W;   
   
   localparam ST_MAX_EMPTY     = 2**(ST_EMPTY_W) - 1;
   localparam NUM_CHANNEL      = (ST_MAX_CHANNELS > 1)? ST_MAX_CHANNELS:1;
   localparam FIFO_MAX_LEVEL   = 100;
   localparam FIFO_THRESHOLD   = 50;
   
   localparam TAP_W = ((ST_DATA_W == 0)? 1:ST_DATA_W) +        // data
                      ((ST_CHANNEL_W == 0)? 1:ST_CHANNEL_W) +  // channel
                      1 +                                      // valid
                      1 +                                      // startofpacket
                      1 +                                      // endofpacket
                      ((ST_ERROR_W == 0)? 1:ST_ERROR_W) +      // error
                      ((ST_EMPTY_W == 0)? 1:ST_EMPTY_W) +      // empty
                      1;                                       // ready
   
   // =head1 PINS   
   // =head2 Clock Interface
   input                                             clk;
   input                                             reset; 

   // =head2 Avalon Monitor Interface - will be defined as Streaming Sink
   input  [(TAP_W*ST_BEATSPERCYCLE)-ST_BEATSPERCYCLE:0]         tap;        

   // =cut
   
   function int lindex;
      // returns the left index for a vector having a declared width 
      // when width is 0, then the left index is set to 0 rather than -1
      input [31:0] width;
      lindex = (width > 0) ? (width-1) : 0;
   endfunction  

   //-------------------------------------------------------------------------- 
   // synthesis translate_off

   import verbosity_pkg::*;

   //--------------------------------------------------------------------------
   // Private Types and Variables
   //--------------------------------------------------------------------------
   
   typedef bit [lindex(ST_DATA_W)     :0] STData_t;
   typedef bit [lindex(ST_CHANNEL_W)  :0] STChannel_t;
   typedef bit [lindex(ST_EMPTY_W)    :0] STEmpty_t;
   typedef bit [lindex(ST_ERROR_W)    :0] STError_t;

   typedef logic [lindex(ST_MDATA_W)    :0] STMData_t;
   typedef logic [lindex(ST_MCHANNEL_W) :0] STMChannel_t;
   typedef logic [lindex(ST_MEMPTY_W)   :0] STMEmpty_t;
   typedef logic [lindex(ST_MERROR_W)   :0] STMError_t;
   typedef logic [ST_BEATSPERCYCLE-1    :0] STBeats_t;
   
   typedef struct packed
   {
        bit [31:0]      idles;
        logic           startofpacket;
        logic           endofpacket;
        STChannel_t     channel;
        STData_t        data;
        STError_t       error;
        STEmpty_t       empty;
   } Transaction_t;
   
   Transaction_t current_transaction[ST_BEATSPERCYCLE];
   Transaction_t query_transaction;   
   Transaction_t transaction_queue[$];   

   // unpack Avalon bus interface tap into individual port signals
   logic [lindex(ST_MDATA_W): 0]    sink_data;
   logic [lindex(ST_MCHANNEL_W): 0] sink_channel;
   logic [ST_BEATSPERCYCLE-1: 0]    sink_valid;
   logic [ST_BEATSPERCYCLE-1: 0]    sink_startofpacket;
   logic [ST_BEATSPERCYCLE-1: 0]    sink_endofpacket;
   logic [lindex(ST_MERROR_W): 0]   sink_error;
   logic [lindex(ST_MEMPTY_W): 0]   sink_empty;    
   logic                            sink_ready;
   
   string 	 message  	      	    = "*uninitialized*";     
   logic  	 ready    	      	    = 0;
   int    	 idle_ctr 	      	    = 0;        
   int           transaction_fifo_max 	    = FIFO_MAX_LEVEL;
   int           transaction_fifo_threshold = FIFO_THRESHOLD;
   
   STBeats_t     sink_valid_qualified;
   logic         sink_ready_qualified;

   localparam MAX_READY_DELAY = 8;  
   logic [MAX_READY_DELAY-1:0]   sink_ready_delayed;

   //--------------------------------------------------------------------------
   // Private Functions
   //--------------------------------------------------------------------------
   
   function int __floor(int arg);
      // returns the arg if it is greater than 0, else returns 0
      return (arg > 0) ? arg : 0;
   endfunction   
   
   function automatic void __abort_simulation();
      string message;
      $sformat(message, "%m: Abort the simulation due to fatal error."); 
      print(VERBOSITY_FAILURE, message);
      $stop;
   endfunction
   
   //--------------------------------------------------------------------------   
   // =head1 Public Methods API
   // This section describes the public methods in the application programming
   // interface (API). In this case the application program is the test bench
   // which instantiates and controls and queries state of this component.
   // Test programs must only use these public access methods and events to 
   // communicate with this BFM component. The API and the module pins
   // are the only interfaces in this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   //--------------------------------------------------------------------------
   event signal_fatal_error; // public
      // Signal that a fatal error has occurred. Terminates simulation.
   
   event signal_transaction_received;  //public
      // Signal that a transaction has been received and queued.

   event signal_transaction_fifo_threshold; // public
      // Signal that the transaction FIFO threshold level has been exceeded

   event signal_transaction_fifo_overflow; // public
      // Signal that the FIFO is full and further transactions are being dropped
   
   function automatic string get_version();  // public
      // Return component version as a string of three integers separated by periods.
      // For example, version 9.1 sp1 is encoded as "9.1.1".      
      return VERSION;
   endfunction 

   function automatic void set_transaction_fifo_max( // public
      int  level
   );
      // Set the maximum fullness level of the FIFO. The event
      // signal_transaction_fifo_max is triggered when this 
      // level is exceeded.      
      transaction_fifo_max = level;
   endfunction

   function automatic int get_transaction_fifo_max();
      // Get the maximum transaction FIFO depth.
      return transaction_fifo_max;
   endfunction
   
   function automatic void set_transaction_fifo_threshold( // public
      int  level
   );
      // Set the threshold alert level of the FIFO. The event
      // signal_transaction_fifo_threshold is triggered when this 
      // level is exceeded.
      transaction_fifo_threshold = level;
   endfunction

   function automatic int get_transaction_fifo_threshold();
      // Get the transaction FIFO threshold level.
      return transaction_fifo_threshold;
   endfunction
   
   function automatic void pop_transaction(); // public
      // Pop the transaction descriptor from the queue so that it can be
      // queried with the get_transaction methods by the test bench.
      if (reset) begin
	 $sformat(message, "%m: Illegal command while reset asserted"); 
	 print(VERBOSITY_ERROR, message);
	 ->signal_fatal_error;	 
      end
      
      query_transaction = transaction_queue.pop_back();

      $sformat(message, "%m: called pop_transaction");
      print(VERBOSITY_DEBUG, message);
      $sformat(message, "%m:   Data: %x", query_transaction.data);
      print(VERBOSITY_DEBUG, message);
      $sformat(message, "%m:   Channel: %0d", query_transaction.channel);
      print(VERBOSITY_DEBUG, message);		            
      $sformat(message, "%m:   SOP: %0d EOP: %0d", 
	       query_transaction.startofpacket,
	       query_transaction.endofpacket);
      print(VERBOSITY_DEBUG, message);		            
   endfunction

   function automatic bit[31:0] get_transaction_idles(); // public
      // Return the number of idle cycles in the transaction
      $sformat(message, "%m: called get_transaction_idles");
      print(VERBOSITY_DEBUG, message);
      
      return query_transaction.idles;
   endfunction

   function automatic STData_t get_transaction_data(); // public
      // Return the data in the transaction      
      $sformat(message, "%m: called get_transaction_data");
      print(VERBOSITY_DEBUG, message);
      
      return query_transaction.data;
   endfunction
    
   function automatic STChannel_t get_transaction_channel(); // public
      // Return the channel identifier in the transaction            
      $sformat(message, "%m: called get_transaction_channel");
      print(VERBOSITY_DEBUG, message);
      
      return query_transaction.channel;
   endfunction

   function automatic bit get_transaction_sop(); // public
      // Return the start of packet status in the transaction            
      $sformat(message, "%m: called get_transaction_sop");
      print(VERBOSITY_DEBUG, message);
      
      return query_transaction.startofpacket;
   endfunction

   function automatic bit get_transaction_eop(); // public
      // Return the end of packet status in the transaction                  
      $sformat(message, "%m: called get_transaction_eop");
      print(VERBOSITY_DEBUG, message);
      
      return query_transaction.endofpacket;
   endfunction

   function automatic STError_t get_transaction_error(); // public
      // Return the error status in the transaction                  
      $sformat(message, "%m: called get_transaction_error");
      print(VERBOSITY_DEBUG, message);
      
      return query_transaction.error;
   endfunction

   function automatic STEmpty_t get_transaction_empty(); // public
      // Return the number of empty symbols in the transaction 
      $sformat(message, "%m: called get_transaction_empty");
      print(VERBOSITY_DEBUG, message);
      
      return query_transaction.empty;
   endfunction

   function automatic int get_transaction_queue_size(); // public
      // Return the length of the queue holding received transactions
      $sformat(message, "%m: called get_transaction_queue_size");
      print(VERBOSITY_DEBUG, message);
      
     // Return the number of transactions in the internal queues.       
      return transaction_queue.size();
   endfunction
   
   // =cut

   //--------------------------------------------------------------------------
   // Local Machinery
   //--------------------------------------------------------------------------
   always @(signal_fatal_error) __abort_simulation();
   
   always @(*) begin
      {
       sink_data,
       sink_channel,
       sink_valid,
       sink_startofpacket,
       sink_endofpacket,
       sink_error,
       sink_empty,
       sink_ready 
       } <= tap;   
   end
        
   // delay chain for sink_ready back pressure output to account for latency
   always @(posedge clk or posedge reset) begin
      if (reset) begin	    
	 sink_ready_delayed <= 0;
      end else begin
	 sink_ready_delayed <= {sink_ready_delayed[6:0], sink_ready};
      end
   end

   always @(*) begin
      if (USE_READY == 0)
	sink_ready_qualified = 1'b1;
      else begin
	 if (ST_READY_LATENCY == 0)
	   sink_ready_qualified = sink_ready;
	 else	   
	   sink_ready_qualified = sink_ready_delayed[__floor(ST_READY_LATENCY-1)];  	 
      end
   end
   
   always @(sink_valid) begin
      if (USE_VALID > 0)
	sink_valid_qualified = sink_valid;
      else
	sink_valid_qualified = '1;
   end
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 for (int i=0; i<ST_BEATSPERCYCLE; i++) begin	 
            current_transaction[i] = '0;
	 end
      end else begin
         if (sink_ready_qualified) begin
            if (sink_valid_qualified != 0) 
	      ->signal_transaction_received;	    
	    for (int i=0; i<ST_BEATSPERCYCLE; i++) begin
               if (sink_valid_qualified[i]) begin
		  current_transaction[i].data          = 
               	      sink_data >> (i*ST_DATA_W);
               	  current_transaction[i].channel       = 
               	      sink_channel >> (i*ST_CHANNEL_W);
               	  current_transaction[i].startofpacket = 
               	      sink_startofpacket[i];
               	  current_transaction[i].endofpacket   = 
               	      sink_endofpacket[i];
               	  current_transaction[i].error         = 
               	      sink_error >> (i*ST_ERROR_W);
               	  current_transaction[i].empty         = 
               	      sink_empty >> (i*ST_EMPTY_W);

		  // TODO - this is ok for single beat, but not for multi beats
               	  current_transaction[i].idles         = idle_ctr; // replicate

		  if (get_transaction_queue_size() < transaction_fifo_max) begin
	       	     transaction_queue.push_front(current_transaction[i]);

		     if (get_transaction_queue_size() > transaction_fifo_threshold) 
		       ->signal_transaction_fifo_threshold;
		  end else begin
		     $sformat(message, 
	                      "%m: FIFO overflow! Transaction dropped.");
		     print(VERBOSITY_WARNING, message);
		     ->signal_transaction_fifo_overflow;
		  end
	       end
	    end 
	 end
      end
   end 
   
   // synthesis translate_on
   
endmodule


