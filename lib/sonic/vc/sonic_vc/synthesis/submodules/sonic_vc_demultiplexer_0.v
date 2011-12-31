// --------------------------------------------------------------------------------
//| Demultiplexer
// --------------------------------------------------------------------------------
//|
//| Module Name     : sonic_vc_demultiplexer_0
//| Version         : 6.1
//| Created On      : 2006 August 18th
//| Description     :
//|
// --------------------------------------------------------------------------------

`timescale 1ns / 100ps
module sonic_vc_demultiplexer_0 (	
    
      // Interface: clk
      input              clk,
      // Interface: reset
      input              reset_n,
      // Interface: in
      input              in_channel,
      input              in_valid,
      output reg         in_ready,
      input      [127: 0] in_data,
      input              in_startofpacket,
      input              in_endofpacket,
      input              in_empty,
      // Interface: out0
      output reg         out0_valid,
      input              out0_ready,
      output reg [127: 0] out0_data,
      output reg         out0_startofpacket,
      output reg         out0_endofpacket,
      output reg         out0_empty,
      // Interface: out1
      output reg         out1_valid,
      input              out1_ready,
      output reg [127: 0] out1_data,
      output reg         out1_startofpacket,
      output reg         out1_endofpacket,
      output reg         out1_empty
);

   // ---------------------------------------------------------------------
   //| Signal Declarations
   // ---------------------------------------------------------------------
   wire         in_ready_wire;
   reg          in_select;
   reg  [130: 0] in_payload;
   
   reg          lhs_ready;
   wire         lhs_valid;   
   
   wire         mid_select;
   wire [130: 0] mid_payload;
   
   reg          rhs0_valid;
   wire         rhs0_ready;   
   reg          rhs1_valid;
   wire         rhs1_ready;   
   wire         out0_valid_wire;
   wire [130: 0] out0_payload;
   wire         out1_valid_wire;
   wire [130: 0] out1_payload;
  
   // ---------------------------------------------------------------------
   //| Input Mapping
   // ---------------------------------------------------------------------
   always @* begin
     in_ready   = in_ready_wire;
     in_payload = {in_data,in_empty,in_endofpacket,in_startofpacket};
     in_select  = in_channel;
   end
   
   // ---------------------------------------------------------------------
   //| Input Pipeline Stage
   // ---------------------------------------------------------------------
   sonic_vc_demultiplexer_0_1stage_pipeline #( .PAYLOAD_WIDTH( 131 + 1) ) inpipe
      ( .clk      (clk ),
        .reset_n  (reset_n  ),
        .in_ready (in_ready_wire ),
        .in_valid (in_valid ), 
        .in_payload ({in_select, in_payload}),
        .out_ready(lhs_ready ), 
        .out_valid(lhs_valid), 
        .out_payload({mid_select, mid_payload}) );
   
   // ---------------------------------------------------------------------
   //| Demuxing
   // ---------------------------------------------------------------------
   always @* begin
     lhs_ready = 1;
     rhs0_valid = 0; 
     rhs1_valid = 0; 
     
     // Do mux
     case (mid_select)
       0: begin
             lhs_ready = rhs0_ready; 
             rhs0_valid = lhs_valid; 
          end
       1: begin
             lhs_ready = rhs1_ready; 
             rhs1_valid = lhs_valid; 
          end
     endcase 
   end 


   // ---------------------------------------------------------------------
   //| Output Pipeline Stage
   // ---------------------------------------------------------------------
   sonic_vc_demultiplexer_0_1stage_pipeline   #( .PAYLOAD_WIDTH( 131)) outpipe0
      ( .clk      (clk ),
        .reset_n   (reset_n  ),
        .in_ready (rhs0_ready ),
        .in_valid (rhs0_valid),
        .in_payload (mid_payload),
        .out_ready(out0_ready ),
        .out_valid(out0_valid_wire),
        .out_payload(out0_payload)  );
        
   sonic_vc_demultiplexer_0_1stage_pipeline   #( .PAYLOAD_WIDTH( 131)) outpipe1
      ( .clk      (clk ),
        .reset_n   (reset_n  ),
        .in_ready (rhs1_ready ),
        .in_valid (rhs1_valid),
        .in_payload (mid_payload),
        .out_ready(out1_ready ),
        .out_valid(out1_valid_wire),
        .out_payload(out1_payload)  );
        

   // ---------------------------------------------------------------------
   //| Output Mapping
   // ---------------------------------------------------------------------
   always @* begin
     out0_valid   = out0_valid_wire;
     {out0_data,out0_empty,out0_endofpacket,out0_startofpacket} = out0_payload;
     out1_valid   = out1_valid_wire;
     {out1_data,out1_empty,out1_endofpacket,out1_startofpacket} = out1_payload;
   end

endmodule

//  --------------------------------------------------------------------------------
// | single buffered pipeline stage
//  --------------------------------------------------------------------------------
module sonic_vc_demultiplexer_0_1stage_pipeline  
#( parameter PAYLOAD_WIDTH = 8 )
 ( input                          clk,
   input                          reset_n, 
   output reg                     in_ready,
   input                          in_valid,   
   input      [PAYLOAD_WIDTH-1:0] in_payload,
   input                          out_ready,   
   output reg                     out_valid,
   output reg [PAYLOAD_WIDTH-1:0] out_payload      
 );
   
   reg in_ready1;
   
   always @* begin
   
     in_ready = out_ready || ~out_valid;
   
//     in_ready = in_ready1;
//     if (!out_ready)
//       in_ready = 0;
   end
   
   always @ (negedge reset_n, posedge clk) begin
      if (!reset_n) begin
         in_ready1 <= 0;
         out_valid <= 0;
         out_payload <= 0;
      end else begin
         in_ready1 <= out_ready || !out_valid;
         
         if (in_valid) begin
           out_valid <= 1;
         end else if (out_ready) begin
           out_valid <= 0;
         end
         
         if(in_valid && in_ready) begin
            out_payload <= in_payload;
         end
      end
   end

endmodule

