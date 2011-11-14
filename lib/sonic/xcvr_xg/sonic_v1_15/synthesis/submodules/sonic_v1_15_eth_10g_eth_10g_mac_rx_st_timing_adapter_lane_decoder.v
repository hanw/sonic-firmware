// --------------------------------------------------------------------------------
//| Avalon Streaming Timing Adapter
// --------------------------------------------------------------------------------

`timescale 1ns / 100ps
module sonic_v1_15_eth_10g_eth_10g_mac_rx_st_timing_adapter_lane_decoder (
    
      // Interface: clk
      input              clk,
      // Interface: reset
      input              reset_n,
      // Interface: in
      output reg         in_ready,
      input              in_valid,
      input      [71: 0] in_data,
      // Interface: out
      output reg [71: 0] out_data
);




   // ---------------------------------------------------------------------
   //| Signal Declarations
   // ---------------------------------------------------------------------

   reg  [71: 0] in_payload;
   reg  [71: 0] out_payload;
   reg  [ 0: 0] ready;
   reg          out_ready = 1;
   reg          out_valid;
   // synthesis translate_off
   always @(negedge out_valid) begin
      $display("%m: The downstream component expects valid data, but the upstream component cannot provide it.");
   end
   // synthesis translate_on


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




endmodule

