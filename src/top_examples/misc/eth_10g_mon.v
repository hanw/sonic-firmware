//-----------------------------------------------------------------------------
// Title         : eth_10g_mon
// Project       : 10G Ethernet reference design
//-----------------------------------------------------------------------------
// File          : eth_10g_mon.v
// Author        : Altera Corporation
//-----------------------------------------------------------------------------
// Functional Description:
// This module is the top level of the 10G Ethernet Packet Monitor
//-------------------------------------------------------------------------------
//
// Copyright 2008 Altera Corporation. All rights reserved.  Altera products are
// protected under numerous U.S. and foreign patents, maskwork rights, copyrights and
// other intellectual property laws.
// This reference design file, and your use thereof, is subject to and governed by
// the terms and conditions of the applicable Altera Reference Design License Agreement.
// By using this reference design file, you indicate your acceptance of such terms and
// conditions between you and Altera Corporation.  In the event that you do not agree with
// such terms and conditions, you may not use the reference design file. Please promptly
// destroy any copies you have made.
//
// This reference design file being provided on an "as-is" basis and as an accommodation
// and therefore all warranties, representations or guarantees of any kind
// (whether express, implied or statutory) including, without limitation, warranties of
// merchantability, non-infringement, or fitness for a particular purpose, are
// specifically disclaimed.  By making this reference design file available, Altera
// expressly does not recommend, suggest or require that this reference design file be
// used in combination with any other product not provided by Altera

// turn off bogus verilog processor warnings
// altera message_off 10034 10035 10036 10037 10230

module eth_10g_mon
(
 input                 clk               // RX FIFO interface clock
,input                 reset             // Reset Signal
,input          [2:0]  address           // Register Address
,input                 write             // Register Write Strobe
,input                 read              // Register Read Strobe
,input          [31:0] writedata         // Register Write Data
,output reg     [31:0] readdata          // Register Read Data

,input          [63:0] rx_data           // Avalon-ST RX Data
,input                 rx_valid          // Avalon-ST RX Valid
,input                 rx_sop            // Avalon-ST RX StartOfPacket
,input                 rx_eop            // Avalon-ST RX EndOfPacket
,input          [2:0]  rx_empty          // Avalon-ST RX Data Empty
,input			[5:0]  rx_error          // Avalon-ST RX Error
,output reg            rx_ready          // Avalon-ST RX Ready Output
);

// Ethernet Monitor Control Registers
// -------------------------------------

reg     [31:0] number_packet;                   // Register to store number of packets to be received
reg     [31:0] packet_rx_ok;                    // Register to count packets received without error
reg     [31:0] packet_rx_error;                 // Register to count packets received with error
reg     [ 3:0] add_to_byte_rx_count;
reg     [63:0] byte_rx_count;                   // Register to count number of bytes being received
reg            byte_rx_count_zero;              
reg     [63:0] cycle_rx_count;                  // Register to count number of cycle starting from first byte received
reg     [31:0] receive_ctrl_status;             // Register to reflect status of the received packets

wire    start;
wire    stop;
wire    rx_done;

// CRC status signals
// ----------------------

wire    crcbad;
wire    crcvalid;

// Number Packets Register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         number_packet <= 32'h0;
      end else begin
         if (write & address == 3'h0) begin
            number_packet <= writedata;
         end
      end
   end

// Packet RX OK Count Register
// ----------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         packet_rx_ok <= 32'h0;
      end else begin
         if (start) begin
            packet_rx_ok <= 32'h0;
         end else if (~stop & crcvalid & ~crcbad) begin
            packet_rx_ok <= packet_rx_ok + 32'h1;
         end
      end
   end

// Packet RX Error Count Register
// -------------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         packet_rx_error <= 32'h0;
      end else begin
         if (start) begin
            packet_rx_error <= 32'h0;
         end else if (~stop & crcvalid & crcbad) begin
            packet_rx_error <= packet_rx_error + 32'h1;
         end
      end
   end

// Packet RX Byte Count
// ---------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         byte_rx_count <= 64'h0;
         byte_rx_count_zero <= 1'b1;
      end else begin
         if (start) begin
            byte_rx_count <= 64'h0;
            byte_rx_count_zero <= 1'b1;
         end else begin
            if (add_to_byte_rx_count !== 4'h0) begin 
               byte_rx_count_zero <= 1'b0;
            end   
            byte_rx_count <= byte_rx_count + add_to_byte_rx_count;
         end
      end
   end
   
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         add_to_byte_rx_count <= 4'h0;
      end else begin
         if (~stop & rx_valid) begin
            add_to_byte_rx_count <= 4'h0;
            if (rx_eop) begin
               case (rx_empty)
                  3'b000: add_to_byte_rx_count <= 4'h8;
                  3'b001: add_to_byte_rx_count <= 4'h7;
                  3'b010: add_to_byte_rx_count <= 4'h6;
                  3'b011: add_to_byte_rx_count <= 4'h5;
                  3'b100: add_to_byte_rx_count <= 4'h4;
                  3'b101: add_to_byte_rx_count <= 4'h3;
                  3'b110: add_to_byte_rx_count <= 4'h2;
                  3'b111: add_to_byte_rx_count <= 4'h1;
                  default: add_to_byte_rx_count <= 4'h8;
               endcase
            end else begin
               add_to_byte_rx_count <= 4'h8;
            end
         end else begin
            add_to_byte_rx_count <= 4'h0;
         end 
      end
   end    

// cycle_rx_count register
// -----------------------

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         cycle_rx_count <= 64'h0;
      end else begin
         if (start) begin
            cycle_rx_count <= 64'h0;
         end else if (~stop & ~rx_done & ~byte_rx_count_zero) begin
            cycle_rx_count <= cycle_rx_count + 64'h1;
         end
      end
   end

// receive_ctrl_status register
// ----------------------------

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         receive_ctrl_status <= 32'h0;
      end else begin
         if (write & address == 3'h7) begin
            receive_ctrl_status[1:0] <= writedata[1:0];
         end else if (receive_ctrl_status[0]) begin
            receive_ctrl_status[2:0] <= 3'b000;
         end else if ((packet_rx_ok + packet_rx_error) == number_packet) begin
            receive_ctrl_status[2] <= 1'b1;
         end
         
         if (rx_valid & rx_eop) begin
            receive_ctrl_status[9:4] <= rx_error;
         end   
         if (rx_valid & crcvalid) begin
            receive_ctrl_status[3] <= crcbad;
         end   
         
      end
   end

// used for edge detection: because receive_ctrl_status[0] assertion maybe > 1 clk long 
// --------------------------
reg receive_ctrl_status_bit0_d;

always @ (posedge reset or posedge clk)
   begin
      if (reset) 
         receive_ctrl_status_bit0_d<= 1'b0;
      else
         receive_ctrl_status_bit0_d<= receive_ctrl_status[0]; 
   end

//assign start = receive_ctrl_status[0];
assign start = receive_ctrl_status[0] & (~receive_ctrl_status_bit0_d);
assign stop = receive_ctrl_status[1];
assign rx_done = receive_ctrl_status[2];

// Output MUX of registers into readdata bus
// ------------------------------------------

always @ (*)
   begin
      readdata = 0;
      if (read) begin
         case (address)
            3'h0: readdata = number_packet;
            3'h1: readdata = packet_rx_ok;
            3'h2: readdata = packet_rx_error;
            3'h3: readdata = byte_rx_count[31:0];
            3'h4: readdata = byte_rx_count[63:32];
            3'h5: readdata = cycle_rx_count[31:0];
            3'h6: readdata = cycle_rx_count[63:32];
            3'h7: readdata = receive_ctrl_status;
            default: readdata = 32'h0;
         endcase
      end
   end

// Avalon-ST rx_rdy interface to TSE RX FIFO interface
// ------------------------------------------------------

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         rx_ready <= 1'b0;
      end else begin
         rx_ready <= 1'b1;
      end
   end

// Using CRC Compiler Checker to verify the data payload of the incoming packets
// --------------------------------------------------------------------------------

crcchk crcchk_inst
(
   .clk           (clk),
   .data          (rx_data),
   .datavalid     (rx_valid),
   .empty         (rx_empty),
   .endofpacket   (rx_eop),
   .reset_n       (~reset),
   .startofpacket (rx_sop),
   .crcbad        (crcbad),
   .crcvalid      (crcvalid)
);

endmodule

