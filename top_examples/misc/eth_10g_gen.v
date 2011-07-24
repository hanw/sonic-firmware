//-----------------------------------------------------------------------------
// Title         : eth_10g_gen
// Project       : 10G Ethernet reference design
//-----------------------------------------------------------------------------
// File          : eth_10g_gen.v
// Author        : Altera Corporation
//-----------------------------------------------------------------------------
// Functional Description:
// This module is the top level of the 10G Ethernet Packet Generator
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

module eth_10g_gen
(
 input                 clk             // TX FIFO Interface clock
,input                 reset           // Reset signal
,input          [3:0]  address         // Register Address
,input                 write           // Register Write Strobe
,input                 read            // Register Read Strobe
,input          [31:0] writedata       // Register Write Data
,output reg     [31:0] readdata        // Register Read Data

,input                 tx_ready        // Avalon-ST Ready Input
,output reg     [63:0] tx_data         // Avalon-ST TX Data
,output reg            tx_valid        // Avalon-ST TX Valid
,output reg            tx_sop          // Avalon-ST TX StartOfPacket
,output reg            tx_eop          // Avalon-ST TX EndOfPacket
,output reg     [2:0]  tx_empty        // Avalon-ST TX Empty
,output wire           tx_error        // Avalon-ST TX Error
);



// 10G Ethernet Control Registers
reg     [31:0] number_packet;                   // Register to store number of packets to be transmitted
reg     [31:0] config_setting;                  // Register to configure settings: data pattern type, length
reg     [31:0] operation;                       // Register to configure to operation of the generator: Start, Stop and Done status
reg     [31:0] source_addr0;                    // Register to program the MAC source address [31:0]
reg     [31:0] source_addr1;                    // Register to program the MAC source address [47:32]
reg     [31:0] destination_addr0;               // Register to program the MAC destination address [31:0]
reg     [31:0] destination_addr1;               // Register to program the MAC destination address [47:32]
reg     [31:0] packet_tx_count;                 // Register to count the number of succesfully transmitted packets
reg     [31:0] rand_seed0;                      // Register to program seed number for prbs generator [31:0]
reg     [31:0] rand_seed1;                      // Register to program seed number for prbs generator [63:32]
reg     [31:0] rand_seed2;                      // Register to program seed number for prbs generator [91:64]

wire    pattern_sel;                            // Select what type of data pattern:0=incremental, 1=random
wire    length_sel;                             // Select what type of packet length:0=fixed, 1=random
wire    [13:0] pkt_length;                      // Fixed payload length for every packet
wire    start;                                  // Start operation of packet generator
wire    stop;                                   // Stop operation of packet generator
wire    [47:0] d_addr;                          // Destination MAC address
wire    [47:0] s_addr;                          // Source MAC address
wire    [91:0] random_seed;                     // Random seed number for PRBS generator

wire    S_IDLE;
wire    S_DEST_SRC;
wire    S_SRC_LEN_SEQ;
wire    S_DATA;
wire    S_TRANSITION;

reg     [2:0] ns;
reg     [2:0] ps;

// State machine parameters
// --------------------------
localparam state_idle         = 3'b000;         // Idle State
localparam state_dest_src     = 3'b001;         // Dest(47:0) & Src(47:32) State
localparam state_src_len_seq  = 3'b010;         // Src(31:0) & Length(15:0) & SeqNr(15:0) State
localparam state_data         = 3'b011;         // Data Pattern State
localparam state_transition   = 3'b100;         // Transition State


wire    [91:0] tx_prbs;
reg     [15:0] byte_count;
reg     [63:0] data_pattern;
reg     [15:0] length;
reg     [15:0] seq_num;

// Avalon-ST signals to CRC generator
// -----------------------------------

wire    [3:0] empty;
reg     [63:0] tx_data_reg;
reg     tx_valid_reg;
reg     tx_sop_reg;
reg     tx_eop_reg;
reg     [2:0] tx_empty_reg;

wire    crc_valid;
wire    [31:0] crc;
reg     [31:0] crc_l1;
reg     [31:0] crc_l2;
reg     [31:0] crc_l3;
reg     [31:0] crc_l4;
reg     [2:0] crc_valid_count;
wire    [31:0] checksum;

wire    [63:0] tx_data_out;
wire    [5:0] tx_ctrl_out;

reg     add_extra_qword;
reg     valid_extended;
reg     eop_extended;
reg     [2:0] empty_extended;

// ----------------------------------------------
// 10G Ethernet Control Registers
// ----------------------------------------------

// number packet register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         number_packet <= 32'h0;
      end else begin
         if (write & address == 4'h0) begin
            number_packet <= writedata;
         end
      end
   end

// config setting register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         config_setting <= 32'h0;
      end else begin
         if (write & address == 4'h1) begin
            config_setting[15: 0] <= writedata[15:0];
         end
      end
   end

assign length_sel = config_setting[0];
assign pkt_length = config_setting[14:1];
assign pattern_sel = config_setting[15];

// operation register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         operation <= 32'h0;
      end else begin
         if (write & address == 4'h2) begin
            operation[1:0] <= writedata[1:0];
         end else if (operation[0]) begin
            operation[2:0] <= 3'b000;
         end else if (packet_tx_count == number_packet) begin
            operation[2] <= 1'b1;
         end 
      end
   end

// used for edge detection because operation[0] assertion maybe > 1 clk long 
// --------------------------
reg operation_bit0_d;

always @ (posedge reset or posedge clk)
   begin
      if (reset) 
          operation_bit0_d<= 1'b0;
      else
          operation_bit0_d<= operation[0]; 
   end


//assign start = operation[0];
assign start = operation[0] & ~operation_bit0_d; //edge detect, start may be more than 1 pulse long because it comes from different clk domain
assign stop  = operation[1];

// MAC source_addr0 register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         source_addr0 <= 32'h0;
      end else begin
         if (write & address == 4'h4) begin
            source_addr0 <= writedata;
         end
      end
   end

// MAC dest_addr1 register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         source_addr1 <= 32'h0;
      end else begin
         if (write & address == 4'h5) begin
            source_addr1[15:0] <= writedata[15:0];
         end
      end
   end

assign s_addr = {source_addr1[15:0], source_addr0[31:0]};

// MAC dest_addr0 register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         destination_addr0 <= 32'h0;
      end else begin
         if (write & address == 4'h6) begin
            destination_addr0 <= writedata;
         end
      end
   end

// MAC dest_addr1 register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         destination_addr1 <= 32'h0;
      end else begin
         if (write & address == 4'h7) begin
            destination_addr1[15:0] <= writedata[15:0];
         end
      end
   end

assign d_addr = {destination_addr1[15:0], destination_addr0[31:0]};

// packet_tx_count register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         packet_tx_count <= 32'h0;
      end else begin
         if (start) begin
            packet_tx_count <= 32'h0;
         end else if (tx_ready & S_SRC_LEN_SEQ) begin
            packet_tx_count <= packet_tx_count + 32'h1;
         end
      end
   end

// rand_seed0 register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         rand_seed0 <= 32'h0;
      end else begin
         if (write & address == 4'hC) begin
            rand_seed0 <= writedata;
         end
      end
   end

// rand_seed1 register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         rand_seed1 <= 32'h0;
      end else begin
         if (write & address == 4'hD) begin
            rand_seed1 <= writedata;
         end
      end
   end

// rand_seed2 register
// --------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         rand_seed2 <= 32'h0;
      end else begin
         if (write & address == 4'hE) begin
            rand_seed2[27:0] <= writedata[27:0];
         end
      end
   end

assign random_seed = {rand_seed2[27:0], rand_seed1[31:0], rand_seed0[31:0]};

// Output MUX of registers into readdata bus
// -----------------------------------------
always @ (*)
   begin
      readdata = 32'h0;
      if (read) begin
         case (address)
            4'h0: readdata = number_packet;
            4'h1: readdata = config_setting;
            4'h2: readdata = operation;
            4'h4: readdata = source_addr0;
            4'h5: readdata = source_addr1;
            4'h6: readdata = destination_addr0;
            4'h7: readdata = destination_addr1;
            4'h9: readdata = packet_tx_count;
            4'hc: readdata = rand_seed0;
            4'hd: readdata = rand_seed1;
            4'he: readdata = rand_seed2;
            default: readdata =32'h0;
         endcase
      end
   end

// PRBS Pattern Generator
// --------------------------------
prbs23 prbs_tx0
(
   .clk        (clk),
   .rst_n      (~reset),
   .load       (S_IDLE),
   .enable     (tx_ready & (S_SRC_LEN_SEQ | S_DATA)),
   .seed       (random_seed[22:0]),
   .d          (tx_prbs[22:0]),
   .m          (tx_prbs[22:0])
);

prbs23 prbs_tx1
(
   .clk        (clk),
   .rst_n      (~reset),
   .load       (S_IDLE),
   .enable     (tx_ready & (S_SRC_LEN_SEQ | S_DATA)),
   .seed       (random_seed[45:23]),
   .d          (tx_prbs[45:23]),
   .m          (tx_prbs[45:23])
);

prbs23 prbs_tx2
(
   .clk        (clk),
   .rst_n      (~reset),
   .load       (S_IDLE),
   .enable     (tx_ready & (S_SRC_LEN_SEQ | S_DATA)),
   .seed       (random_seed[68:46]),
   .d          (tx_prbs[68:46]),
   .m          (tx_prbs[68:46])
);

prbs23 prbs_tx3
(
   .clk        (clk),
   .rst_n      (~reset),
   .load       (S_IDLE),
   .enable     (tx_ready & (S_SRC_LEN_SEQ | S_DATA)),
   .seed       (random_seed[91:69]),
   .d          (tx_prbs[91:69]),
   .m          (tx_prbs[91:69])
);

// FSM State Machine for Generator
// --------------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         ps <= state_idle;
      end else begin
         if (start) begin
            ps <= state_dest_src;
         end else begin
            ps <= ns;
         end
      end
   end

always @ (*)
   begin
      ns = ps;
      case (ps)
         state_idle:begin
            if (start) begin
               ns = state_dest_src;
            end
         end
         state_dest_src:begin
            if (tx_ready) begin
               ns = state_src_len_seq;
            end
         end
         state_src_len_seq:begin
            if (tx_ready & (length == 16'h0)) begin
               ns = state_transition;
            end else if (tx_ready) begin
               ns = state_data;
            end
         end
         state_data:begin
            if (tx_ready & (byte_count[15] | byte_count == 16'h0)) begin
               ns = state_transition;
            end
         end
         state_transition:begin
            if (stop | packet_tx_count == number_packet) begin
               ns = state_idle;
            end else if (tx_ready) begin
               ns = state_dest_src;
            end      
         end
         default:   ns = state_idle;
      endcase
   end

assign S_IDLE        = (ns == state_idle)        ? 1'b1 : 1'b0;
assign S_DEST_SRC    = (ns == state_dest_src)    ? 1'b1 : 1'b0;
assign S_SRC_LEN_SEQ = (ns == state_src_len_seq) ? 1'b1 : 1'b0;
assign S_DATA        = (ns == state_data)        ? 1'b1 : 1'b0;
assign S_TRANSITION  = (ns == state_transition)  ? 1'b1 : 1'b0;

// Length is used to store the payload length size. Payload length smaller than 46 will have zeros data padded
// Allowable fixed payload length: 6 -> 9582
// Allowable random payload length: 6 -> 1500
// --------------------------------------------------

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         length <= 16'h0;
      end else begin
         if (S_IDLE | S_TRANSITION) begin
            if (~length_sel & (pkt_length < 14'h0018)) begin
               length <= 16'h0;
            end else if (~length_sel & (pkt_length > 14'h2580)) begin
               length <= 16'h2568;
            end else if (~length_sel) begin
               length <= {2'b00, pkt_length - 14'h18};
            end else if (length_sel) begin
               length <= (tx_prbs[74:64] % 16'h05D7);
            end
         end
      end
   end

// Byte_count is used to keep track of how many bytes of data payload being generated out
// --------------------------------------------------------------------------------------

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         byte_count <= 16'h0;
      end else begin
         if (S_DEST_SRC) begin
            byte_count <= length;
         end else if (S_DATA & tx_ready) begin
            byte_count <= byte_count - 16'h8;
         end
      end
   end

// Seq_num is inserted into the first 2 bytes of data payload of every packet
// ---------------------------------------------------------------------------

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         seq_num <= 16'h0;
      end else begin
         if (start) begin
            seq_num <= 16'h0;
         end else if (S_TRANSITION & tx_ready) begin
            seq_num <= seq_num + 16'h1;
         end
      end
   end

// Generation of incremental data or pseudo random data
// -----------------------------------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         data_pattern <= 64'h0;
      end else begin
         if (S_IDLE & ~pattern_sel) begin
            data_pattern <= 64'h0001020304050607;
         end else if (S_DATA & ~pattern_sel & tx_ready & data_pattern == 64'hF8F9FAFBFCFDFEFF) begin
            data_pattern <= 64'h0001020304050607;
         end else if (S_DATA & ~pattern_sel & tx_ready) begin
            data_pattern <= data_pattern + 64'h0808080808080808;
         end else if ((S_SRC_LEN_SEQ | S_DATA) & pattern_sel & tx_ready) begin
            data_pattern <= tx_prbs[63:0];
         end
      end
   end

// Avalon-ST tx_data interface to CRC generator
// ---------------------------------------------

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         tx_data_reg <= 64'h0;
      end else begin
         if (S_DEST_SRC) begin
            tx_data_reg[63:32] <= {d_addr[ 7: 0], d_addr[15: 8], d_addr[23:16], d_addr[31:24]};
            tx_data_reg[31: 0] <= {d_addr[39:32], d_addr[47:40], s_addr[ 7: 0], s_addr[15: 8]};
         end else if (S_SRC_LEN_SEQ) begin
            tx_data_reg[63:32] <= {s_addr[23:16], s_addr[31:24], s_addr[39:32], s_addr[47:40]};
            tx_data_reg[31: 0] <= {length + 16'h6, seq_num};
         end else if (S_DATA & tx_ready) begin
            tx_data_reg <= data_pattern;
         end
      end
   end

// Avalon-ST tx_valid interface to CRC generator
// ----------------------------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         tx_valid_reg <= 1'b0;
      end else begin
         if (S_IDLE | S_TRANSITION) begin
            tx_valid_reg <= 1'b0;
         end else begin
            tx_valid_reg <= 1'b1;
         end
      end
   end

   // Avalon-ST tx_sop interface to CRC generator
// --------------------------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         tx_sop_reg <= 1'b0;
      end else begin
         if (S_DEST_SRC) begin
            tx_sop_reg <= 1'b1;
         end else begin
            tx_sop_reg <= 1'b0;
         end
      end
   end

// Avalon-ST tx_eop interface to CRC generator
// --------------------------------------------
always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         tx_eop_reg <= 1'b0;
      end else begin
         if (S_SRC_LEN_SEQ & (length == 0)) begin
            tx_eop_reg <= 1'b1;
         end else if (S_DATA & tx_ready & (byte_count <= 8)) begin
            tx_eop_reg <= 1'b1;
         end else if (S_TRANSITION) begin
            tx_eop_reg <= 1'b0;
         end
      end
   end

// Avalon-ST tx_empty interface to CRC generator
// ----------------------------------------------

assign empty = 4'h8 - length[2:0];

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         tx_empty_reg <= 3'b000;
      end else begin
         if (S_DATA & tx_ready & (byte_count <= 8)) begin
            tx_empty_reg <= empty[2:0];
         end else if (S_TRANSITION) begin
            tx_empty_reg <= 3'b000;
         end
      end
   end

// Using CRC Compiler to generate checksum and append it to EOP
// -------------------------------------------------------------

crcgen crcgen_inst
(
        .clk            (clk),
        .data           (tx_data_reg),
        .datavalid      (tx_valid_reg & tx_ready),
        .empty          (tx_empty_reg),
        .endofpacket    (tx_eop_reg),
        .reset_n        (~reset),
        .startofpacket  (tx_sop_reg),
        .checksum       (crc),
        .crcvalid       (crc_valid)
);

// Using RAM based shift register to delay packet payload sending to TSE TX FIFO
// interface for CRC checksum merging at EOP
// -------------------------------------------------------------------------------

shiftreg_data shiftreg_data_inst
(
        .clken          (tx_ready),
        .clock          (clk),
        .shiftin        (tx_data_reg),
        .shiftout       (tx_data_out),
        .taps           ()
);

// Using RAM based shift register to store and delay control signals
// ------------------------------------------------------------------

shiftreg_ctrl shiftreg_ctrl_inst
(
        .clken          (tx_ready),
        .clock          (clk),
        .shiftin        ({tx_valid_reg, tx_sop_reg, tx_eop_reg, tx_empty_reg}),
        .shiftout       (tx_ctrl_out),
        .taps           ()
);

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         crc_valid_count <= 2'b00;
      end else begin
         crc_valid_count <= crc_valid_count + (crc_valid) - (tx_ready & tx_eop);
      end
   end

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         crc_l1 <= 32'h0;
         crc_l2 <= 32'h0;
      end else begin
         if (crc_valid) begin
            crc_l1 <= crc;
            crc_l2 <= crc_l1;
            crc_l3 <= crc_l2;
            crc_l4 <= crc_l3;
         end
      end
   end

assign checksum = (crc_valid_count == 3'b001) ? crc_l1 :
                  (crc_valid_count == 3'b010) ? crc_l2 :
                  (crc_valid_count == 3'b011) ? crc_l3 :
                  (crc_valid_count == 3'b100) ? crc_l4 :
                  32'h0;

// Extend packet by one cycle when not enough
// space in last word to add in checksum
// -------------------------------------------

always @ (*)
   begin
      add_extra_qword <= 1'b0;
      if (tx_ctrl_out[5] & tx_ctrl_out[3]) begin // valid eop
         if (tx_ctrl_out[2] == 1'b0) begin // Less than 4 empty bytes
            add_extra_qword <= 1'b1;
         end
      end
   end

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         valid_extended <= 1'b0;
         eop_extended   <= 1'b0;
         empty_extended <= 3'b000;
      end else begin
         if (tx_ready) begin
            if (add_extra_qword) begin
               valid_extended <= 1'b1;
               eop_extended   <= 1'b1;
               empty_extended[2]   <= 1'b1;
               empty_extended[1:0] <= tx_ctrl_out[1:0];
            end else begin
               valid_extended <= 1'b0;
               eop_extended   <= 1'b0;
               empty_extended[2]   <= 1'b0;
               empty_extended[1:0] <= 3'b000;
            end
         end
      end
   end

always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         tx_valid <= 1'b0;
         tx_sop   <= 1'b0;
         tx_eop   <= 1'b0;
         tx_empty <= 1'b0;
      end else begin
         if (tx_ready) begin
            tx_valid <= tx_ctrl_out[5] | valid_extended;
         end else begin
            tx_valid <= 1'b0 ;
         end    

         if (tx_ready) begin
            tx_valid <= tx_ctrl_out[5] | valid_extended;
            tx_sop   <= tx_ctrl_out[4];
            if (tx_ctrl_out[5] & tx_ctrl_out[3]) begin // valid eop
               tx_eop <= !add_extra_qword; // keep original
            end else begin
               tx_eop <= eop_extended;
            end
            if (tx_ctrl_out[5] & tx_ctrl_out[3]) begin // valid eop
               if (add_extra_qword) begin
                  tx_empty <= 3'b000;
               end else begin
                  tx_empty <= tx_ctrl_out[2:0] - 3'h4;
               end
            end else begin
               tx_empty <= empty_extended[2:0];
            end
         end
      end
   end

 always @ (posedge reset or posedge clk)
   begin
      if (reset) begin
         tx_data <= 64'h0;
      end else begin
         if (tx_ready) begin
            tx_data <= tx_data_out; // By default

            if (tx_ctrl_out[3]) begin // Normal EOP field
               case (tx_ctrl_out[2:0])
                  3'b000: tx_data <=  tx_data_out[63:0];
                  3'b001: tx_data <= {tx_data_out[63:8],  checksum[31:24]};
                  3'b010: tx_data <= {tx_data_out[63:16], checksum[31:16]};
                  3'b011: tx_data <= {tx_data_out[63:24], checksum[31: 8]};
                  3'b100: tx_data <= {tx_data_out[63:32], checksum[31: 0]};
                  3'b101: tx_data <= {tx_data_out[63:40], checksum[31: 0],  8'h0};
                  3'b110: tx_data <= {tx_data_out[63:48], checksum[31: 0], 16'h0};
                  3'b111: tx_data <= {tx_data_out[63:56], checksum[31: 0], 24'h0};
                  default: tx_data <= tx_data_out;
               endcase
            end else if (eop_extended) begin
               case (empty_extended)
                  3'b100: tx_data <= {checksum[31:0], 32'h0};
                  3'b101: tx_data <= {checksum[23:0], 40'h0};
                  3'b110: tx_data <= {checksum[15:0], 48'h0};
                  3'b111: tx_data <= {checksum[ 7:0], 56'h0};
                  default: tx_data <= 64'h0;
               endcase
            end
         end
      end
   end

assign tx_error = 1'b0;

endmodule


