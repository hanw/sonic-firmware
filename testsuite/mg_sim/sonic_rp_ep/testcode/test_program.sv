/*
 * Source for clk, reset_n and xcvr_datain, xcvr_dataout
 */

`define VERBOSITY VERBOSITY_INFO

`define RESET tb.sonic_rp_ep_sim_inst_reset_bfm
`define SRC tb.sonic_rp_ep_sim_inst_xcvr_tx_datain_bfm
`define SNK tb.sonic_rp_ep_sim_inst_xcvr_rx_dataout_bfm

module test_program();

   import verbosity_pkg::*;

   event idle;
   string message;
      
   initial
     begin
	set_verbosity(`VERBOSITY);
    $sformat(message, "%m: Helloworld message!");
    print(VERBOSITY_INFO, message);
	`SRC.init();
	`SNK.init();
		
	fork: test_threads;
	   source_data_threads: begin
	      $sformat(message, "%m: Helloworld message!");
	      print(VERBOSITY_INFO, message);

	      while(1)
		begin
		   @(idle);
		end
	   end
	join_any;
	disable test_threads;
	
     end
endmodule

