// --------------------------------------------------------------------------------
//| Avalon Streaming Timing Adapter
// --------------------------------------------------------------------------------

`timescale 1ns / 100ps
module sonic_v1_15_pcs_eth_10g_mac_tx_st_timing_adapter_splitter_status_in (
    
      // Interface: clk
      input              clk,
      // Interface: reset
      input              reset_n,
      // Interface: in
      input              in_valid,
      input      [39: 0] in_data,
      input      [ 6: 0] in_error,
      // Interface: out
      output reg         out_valid,
      output reg [39: 0] out_data,
      output reg [ 6: 0] out_error,
      input              out_ready
);




   // ---------------------------------------------------------------------
   //| Signal Declarations
   // ---------------------------------------------------------------------

   reg  [46: 0] in_payload;
   reg  [46: 0] out_payload;
   reg  [ 0: 0] ready;
   reg          in_ready;
   // synthesis translate_off
   always @(negedge in_ready) begin
      $display("%m: The downstream component is backpressuring by deasserting ready, but the upstream component can't be backpressured.");
   end
   // synthesis translate_on   


   // ---------------------------------------------------------------------
   //| Payload Mapping
   // ---------------------------------------------------------------------
   always @* begin
     in_payload = {in_data,in_error};
     {out_data,out_error} = out_payload;
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




endmodule

