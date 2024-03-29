// --------------------------------------------------------------------------------
//| Avalon Streaming Timing Adapter
// --------------------------------------------------------------------------------

`timescale 1ns / 100ps
module sonic_v1_15_pcs_eth_10g_mac_txrx_timing_adapter_link_fault_status_rx (
    
      // Interface: clk
      input              clk,
      // Interface: reset
      input              reset_n,
      // Interface: in
      input      [ 1: 0] in_data,
      // Interface: out
      output reg [ 1: 0] out_data,
      input              out_ready,
      output reg         out_valid
);




   // ---------------------------------------------------------------------
   //| Signal Declarations
   // ---------------------------------------------------------------------

   reg  [ 1: 0] in_payload;
   reg  [ 1: 0] out_payload;
   reg  [ 0: 0] ready;
   reg          in_ready;
   // synthesis translate_off
   always @(negedge in_ready) begin
      $display("%m: The downstream component is backpressuring by deasserting ready, but the upstream component can't be backpressured.");
   end
   // synthesis translate_on   
   reg          in_valid;
   reg  [ 0: 0] valid_vector;


   // ---------------------------------------------------------------------
   //| Payload Mapping
   // ---------------------------------------------------------------------
   always @* begin
     in_payload = {in_data};
     {out_data} = out_payload;
   end

   // ---------------------------------------------------------------------
   //| Ready & valid signals.
   // ---------------------------------------------------------------------
   always @* begin
     ready[0] = out_ready;
     out_valid = in_valid;
     out_payload = in_payload;
     in_ready = ready[0];
   end



   // ---------------------------------------------------------------------
   //| Input Valid Generation
   // ---------------------------------------------------------------------
   always @* begin
      valid_vector[0] = in_ready;
      in_valid        = valid_vector[0];
   end


endmodule

