// --------------------------------------------------------------------------------
//| Avalon Streaming Timing Adapter
// --------------------------------------------------------------------------------

`timescale 1ns / 100ps
module sonic_vc_rx_fifo_in_adapter (
    
      // Interface: clk
      input              clk,
      // Interface: reset
      input              reset_n,
      // Interface: in
      output reg         in_ready,
      input              in_valid,
      input      [127: 0] in_data,
      input              in_channel,
      input              in_startofpacket,
      input              in_endofpacket,
      input      [ 1: 0] in_empty,
      // Interface: out
      input              out_ready,
      output reg         out_valid,
      output reg [127: 0] out_data,
      output reg         out_channel,
      output reg         out_startofpacket,
      output reg         out_endofpacket,
      output reg [ 1: 0] out_empty
);




   // ---------------------------------------------------------------------
   //| Signal Declarations
   // ---------------------------------------------------------------------

   reg  [132: 0] in_payload;
   wire [132: 0] out_payload;
   wire         in_ready_wire;
   wire         out_valid_wire;
   wire [ 4: 0] fifo_fill;
   reg  [ 0: 0] ready;


   // ---------------------------------------------------------------------
   //| Payload Mapping
   // ---------------------------------------------------------------------
   always @* begin
     in_payload = {in_data,in_channel,in_startofpacket,in_endofpacket,in_empty};
     {out_data,out_channel,out_startofpacket,out_endofpacket,out_empty} = out_payload;
   end

   // ---------------------------------------------------------------------
   //| FIFO
   // ---------------------------------------------------------------------
   sonic_vc_rx_fifo_in_adapter_fifo sonic_vc_rx_fifo_in_adapter_fifo 
     ( 
       .clk        (clk),
       .reset_n    (reset_n),
       .in_ready   (),
       .in_valid   (in_valid),      
       .in_data    (in_payload),
       .out_ready  (ready[0]),
       .out_valid  (out_valid_wire),      
       .out_data   (out_payload),
       .fill_level (fifo_fill)
       );

   // ---------------------------------------------------------------------
   //| Ready & valid signals.
   // ---------------------------------------------------------------------
   always @* begin
      in_ready = (fifo_fill < 5 );
      out_valid = out_valid_wire;
      ready[0] = out_ready;
   end



endmodule

