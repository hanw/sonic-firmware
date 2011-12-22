// --------------------------------------------------------------------------------
//| Avalon Streaming Timing Adapter
// --------------------------------------------------------------------------------

`timescale 1ns / 100ps
module sonic_vc_multiplexer_adapter (
    
      // Interface: clk
      input              clk,
      // Interface: reset
      input              reset_n,
      // Interface: in
      output reg         in_ready,
      input              in_valid,
      input      [127: 0] in_data,
      input              in_channel,
      input              in_error,
      input              in_startofpacket,
      input              in_endofpacket,
      input      [ 1: 0] in_empty,
      // Interface: out
      input              out_ready,
      output reg         out_valid,
      output reg [127: 0] out_data,
      output reg         out_channel,
      output reg         out_error,
      output reg         out_startofpacket,
      output reg         out_endofpacket,
      output reg [ 1: 0] out_empty
);




   // ---------------------------------------------------------------------
   //| Signal Declarations
   // ---------------------------------------------------------------------

   reg  [133: 0] in_payload;
   reg  [133: 0] out_payload;
   reg  [ 2: 0] ready;


   // ---------------------------------------------------------------------
   //| Payload Mapping
   // ---------------------------------------------------------------------
   always @* begin
     in_payload = {in_data,in_channel,in_error,in_startofpacket,in_endofpacket,in_empty};
     {out_data,out_channel,out_error,out_startofpacket,out_endofpacket,out_empty} = out_payload;
   end

   // ---------------------------------------------------------------------
   //| Ready & valid signals.
   // ---------------------------------------------------------------------
   always @* begin
     ready[2] = out_ready;
     out_valid = in_valid && ready[0];
     out_payload = in_payload;
     in_ready = ready[0];
   end


   always @(posedge clk or negedge reset_n) begin
      if (!reset_n) begin
        ready[2-1:0] <= 0;
      end else begin
        ready[2-1:0] <= ready[2:1];
      end 
   end


endmodule

