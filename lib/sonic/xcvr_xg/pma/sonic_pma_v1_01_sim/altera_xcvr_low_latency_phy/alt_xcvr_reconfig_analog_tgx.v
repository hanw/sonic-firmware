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


`timescale 1 ps / 1 ps
module alt_xcvr_reconfig_analog_tgx (

input wire reconfig_clk,        // this will be the reconfig clk
input wire reset,

//avalon MM slave
input wire [2:0] analog_reconfig_address,             // MM address
input wire [31:0] analog_reconfig_writedata,
input wire analog_reconfig_write,
input wire analog_reconfig_read,

//output MM slave
output reg [31:0] analog_reconfig_readdata,      // from MM
output wire analog_reconfig_waitrequest,
//output wire analog_reconfig_error,
output reg analog_reconfig_done,
  
// input from base_reconfig
  input wire analog_reconfig_irq_from_base,
  input wire analog_reconfig_waitrequest_from_base,
  
  
// output to base_reconfig
// Avalon MM Master
output wire [4:0] analog_reconfig_address_base,   // 3 bit MM
output wire [31:0] analog_reconfig_writedata_base,  
output wire analog_reconfig_write_base,                         // start write to GXB
output wire analog_reconfig_read_base,                          // start read from GXB

// input from base reconfig
input wire [31:0] analog_reconfig_readdata_base         // data from read command
);

parameter device_family = "Stratix IV";      // or ArriaII

// new memory map -- register indirection
//----------------------------------------------
// address                                    data[15:0]
//    0                wr/rd              logical_channel_address
//    1                 rd                 physical_chnl
//    2                wr/rd                control (write, read) / status (error, datavalid, busy)
//    3               wr/rd                  addr_offset
//    4                wr/rd                     data
//
//    addr_offset ( upto 16 bits)
//      0-15                                TX parameters : vod, preemph_0t, preemph_1t, preemph_2t
//      16-31                               RX parameters : dcgain, eqctrl

//local parameters
localparam ADDR_WIDTH = 3;

localparam IDLE = 4'b0000;
localparam READ_FROM_GXB = 4'b0001;
localparam WRITE_TO_GXB = 4'b0010;
localparam SET_INFO_ON_BASIC = 4'b0011;
localparam WRITE_DONE = 4'b0100;
localparam READ_FROM_BASIC = 4'b0101;
localparam READ_FROM_BASIC_DONE = 4'b0110;
localparam READ_IDLE = 4'b0111;
localparam GET_MUTEX = 4'b1000;
localparam WRITE_CHL_ADDR = 4'b1001;
localparam READ_OR_SET_INFO = 4'b1010;

localparam ILLEGAL_PHYSICAL_CHNL = 12'b111111111111;

(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [3:0] state;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
//reg [3:0] prev_state;
genvar i;
integer j;
wire [(2**ADDR_WIDTH)-1:0] address_decode;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [4:0] master_addr;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg master_read;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg master_write;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [31:0] master_writedata;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [15:0] chnl_addr_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [11:0] phys_chnl_addr_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg logical_chnl_addr_updated;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [1:0] status_reg;
reg [1:0] control_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [15:0] data_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg needs_second_access;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [4:0] addr_offset;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg needs_second_write_access;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg do_read_before_write;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg set_addr;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg have_mutex;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg req_and_use_mutex;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg do_read_phys_chnl;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg do_write_chnl_addr;

wire mutex_grant;
wire mutex_acq_waitrequest;
wire [31:0] mutex_acq_readdata;
wire accessing_rxeqctrl;
wire accessing_rxdcgain;
wire accessing_vod;
wire accessing_preemph1t;
wire accessing_preemph0t;
wire accessing_preemph2t;

// Implement waitrequest to match previous implementation
altera_wait_generate wait_gen(
    .rst(reset),
    .clk(reconfig_clk),
    .launch_signal(analog_reconfig_read),
    .wait_req(analog_reconfig_waitrequest)
);

// synopsys translate_off
initial begin
    state <= 3'b000;
    master_write <= 1'b0;
    master_read <= 1'b0;
    master_writedata <= 16'b0;
    master_addr <= 5'b0;
    status_reg <= 2'b0;
    control_reg <= 2'b0;
    data_reg <= 16'b0;
    needs_second_access <= 1'b0;
    do_read_before_write <= 1'b0;
    addr_offset <= 5'b0;
    set_addr <= 1'b0;
    needs_second_write_access <= 1'b0;
    have_mutex <= 0;
    req_and_use_mutex <= 0;
    do_read_phys_chnl <= 0;
    do_write_chnl_addr <= 0;
    logical_chnl_addr_updated <= 0;
end
// synopsys translate_on

always @(posedge reconfig_clk or posedge reset)
begin
    if (reset)
    begin
        state <= IDLE;
        analog_reconfig_readdata[31:0] <= 32'b0;
        analog_reconfig_done <= 1'b0;  
        status_reg <= 2'b0;
        control_reg <= 2'b0;
        needs_second_access <= 1'b0;
        needs_second_write_access <= 1'b0;
        set_addr <= 1'b0;
        do_read_before_write <= 1'b0;
        data_reg <= 16'b0;
        have_mutex <= 0;
        req_and_use_mutex <= 0;
        do_read_phys_chnl <= 0;
        do_write_chnl_addr <= 0;
        logical_chnl_addr_updated <= 0;
    end
    else begin
        have_mutex <= mutex_grant;
        if (analog_reconfig_read == 1'b1)        // allow status read during GX read
        begin
            if (analog_reconfig_address == 3'b000) // logical channel address
                analog_reconfig_readdata <= {{16{1'b0}}, chnl_addr_reg};
            else if (analog_reconfig_address == 3'b001) // physical channel address
                analog_reconfig_readdata <= {{20{1'b0}}, phys_chnl_addr_reg};
            else if (analog_reconfig_address == 3'b010) // status
                analog_reconfig_readdata <= {{22{1'b0}}, status_reg[1:0], {8{1'b0}}};
            else if (analog_reconfig_address == 3'b011) // TX/RX offset
                analog_reconfig_readdata <= {{16{1'b0}}, addr_offset};				
            else if (analog_reconfig_address == 3'b100) // previously read data
                analog_reconfig_readdata <= {{16{1'b0}}, data_reg};
            else
                analog_reconfig_readdata <= {32{1'b0}};
        end
        case (state)
        IDLE: begin
                needs_second_access <= 1'b0;
                if (analog_reconfig_address == 3'b0)
                begin
                    if (analog_reconfig_write == 1'b1)
                    begin
                        chnl_addr_reg <= {{4{1'b0}},analog_reconfig_writedata[11:0]};   // write logical_ch_addr
                        logical_chnl_addr_updated <= 1'b1;
                    end
                end
                else if (analog_reconfig_write == 1'b1 && analog_reconfig_address == 3'b011)     // addr_offset
                begin
                    addr_offset <= analog_reconfig_writedata[4:0];
                end
                else if (analog_reconfig_address == 3'b100)      // DPRIO write data
                begin
                    if (analog_reconfig_write == 1'b1)
                        data_reg[15:0] <= analog_reconfig_writedata[15:0];
                end
                else if (analog_reconfig_read == 1'b1 && analog_reconfig_address == 3'b001)    // physical chnl
                begin
                    if (logical_chnl_addr_updated == 1'b1) // if logical chnl addr was updated from the last time we read the phys addr, go do the read again
                    begin
                        status_reg <= {1'b0, 1'b1};       //set busy bit
                        if (have_mutex)
                        begin
                            state <= WRITE_CHL_ADDR;
                            do_read_phys_chnl <= 1;
                        end
                        else begin
                            state <= READ_IDLE;
                            req_and_use_mutex <= 1'b1;
                            do_write_chnl_addr <= 1'b1;
                            do_read_phys_chnl <= 1;                   
                        end
                        logical_chnl_addr_updated <= 1'b0; 
                    end
                end
                else if (analog_reconfig_address == 3'b010 && analog_reconfig_write == 1'b1)     // control reg  bit 1 rd, bit 0 wr
                begin
                    status_reg <= {1'b0, 1'b1};             // set busy bit
                    control_reg <= analog_reconfig_writedata[1:0];
                    if (analog_reconfig_writedata[0] == 1'b1)
                        do_read_before_write <= 1'b1;                
                    if (have_mutex)
                    begin
                        state <= WRITE_CHL_ADDR;
                    end
                    else begin
                        state <= READ_IDLE;
                        req_and_use_mutex <= 1'b1;
                        do_write_chnl_addr <= 1'b1;
                        status_reg <= {1'b0, 1'b1};             // set busy bit
                    end
                end
                else if (analog_reconfig_address > 3'b100 && analog_reconfig_write == 1'b1)  //
                begin
                    // synopsys translate_off
                    $display ("Illegal operation to reserved address %h", analog_reconfig_address);
                    $display ("Time: %0t  Instance: %m", $time);
                    // synopsys translate_on
                end
                else if (have_mutex == 1'b1)
                begin
                    // holding the mutex in idle state, release it
                    req_and_use_mutex <= 1'b0;
                end
                else
                begin
                    master_read <= 1'b0;
                    master_write <= 1'b0;
                end
        end
        WRITE_CHL_ADDR: begin
            master_addr <= 5'b00100;
            master_write <= 1'b1;
            master_writedata <= chnl_addr_reg;
            state <= READ_OR_SET_INFO;
        end
        READ_OR_SET_INFO: begin
            if (analog_reconfig_waitrequest_from_base == 1'b1)
                state <= READ_OR_SET_INFO;
            else
            begin
                master_write <= 1'b0;
                if (do_read_phys_chnl)
                begin
                    state <= READ_FROM_BASIC;
                //  do_read_phys_chnl = 0;
                end
                else begin
                    state <= SET_INFO_ON_BASIC;
                    set_addr <= 1'b1;
                    master_read <= 0;
                end
            end
        end
        GET_MUTEX: 
        begin
            if (have_mutex == 1'b1)
            begin
                if (do_write_chnl_addr == 1'b1)
                    state <= WRITE_CHL_ADDR;
                else
                    state <= READ_OR_SET_INFO;
            end
            else
            begin
                state <= GET_MUTEX;
            end
        end
        READ_FROM_BASIC: begin
            if (analog_reconfig_waitrequest == 1'b0)
            begin
                master_write <= 1'b0;
                master_read <= 1'b1;
                if (analog_reconfig_irq_from_base == 1'b1)           // start read access to data reg. of base_reconfig
                begin
                    master_addr <= 5'b10100;
                end
                else begin
                    master_addr <= 5'b01000;
                end
                state <= READ_IDLE;
            end
            else
            begin
                state <= READ_FROM_BASIC;
            end
        end
        READ_IDLE: begin
            if (analog_reconfig_waitrequest == 1'b0)
            begin
                if (have_mutex)
                    state <= READ_FROM_BASIC_DONE;
                else
                begin
                    state <= GET_MUTEX;
                end
            end
            else
            begin
                state <= READ_IDLE;
            end
        end
        READ_FROM_BASIC_DONE: begin
            if (analog_reconfig_waitrequest == 1'b0)
            begin
                master_read <= 1'b0;
                if (do_read_phys_chnl)
                begin
                    do_read_phys_chnl <= 0;
                    phys_chnl_addr_reg <= mutex_acq_readdata[11:0];
                    if (mutex_acq_readdata[11:0] == ILLEGAL_PHYSICAL_CHNL)
                    begin
                        //set error bit
                        status_reg <= {1'b1, 1'b0};
                        // error message for sim
                        //$display();
                        //$display();
                    end
                    else begin
                        // unset busy bit
                        status_reg <= 2'b0;
                    end
                    state <= IDLE;
                end
                else if (accessing_vod)
                begin
                
                    // This is for Stratix IV only
                    //////////////////////////////////////////////////
                    //Port              |       DPRIO CRAM bit value
                    //2..0              |       2..0
                    //////////////////////////////////////////////////
                    //000               |       000
                    //001               |       001
                    //010               |       010
                    //011               |       110
                    //100               |       011
                    //101               |       111
                    //110               |       100
                    //111               |       101
                    /////////////////////////////////////////////////
                    if (control_reg[0] == 1'b1)         // this was a write cycle to begin with
                    begin
                        master_writedata[31:16] <= {16{1'b0}};
                        master_writedata[15:13] <= {(data_reg[2] & data_reg[1]) | (data_reg[2] & data_reg[0]) | (data_reg[1] & data_reg[0]), data_reg[2] ^ data_reg[1], (~data_reg[1] & data_reg[0]) | (data_reg[2] & data_reg[0]) | (data_reg[2] & ~data_reg[1])};
                        master_writedata[12:0] <= mutex_acq_readdata[12:0];
                        master_addr <= 5'b10100;
                        master_write <= 1'b1;
                        state <= SET_INFO_ON_BASIC;
                        set_addr <= 1'b1;    
                    end
                    else begin
                        data_reg <= {{13{1'b0}}, (mutex_acq_readdata[15] & ~mutex_acq_readdata[14]) | (mutex_acq_readdata[14] & mutex_acq_readdata[13]), (mutex_acq_readdata[15] & ~mutex_acq_readdata[14]) | (mutex_acq_readdata[14] & ~mutex_acq_readdata[13]), (~mutex_acq_readdata[14] & mutex_acq_readdata[13]) | (mutex_acq_readdata[15] & mutex_acq_readdata[14])};
                        // unset busy bit
                        status_reg <= 2'b0;
                        state <= IDLE;
                    end
                end
                else if (accessing_rxdcgain)
                begin
                    // This is for Stratix IV only
                    //////////////////////////////////////////////////
                    //Port              |       DRIO CRAM bit value
                    //2..0              |       10..7
                    //////////////////////////////////////////////////
                    //000               |       0000
                    //001               |       0001
                    //010               |       0011
                    //011               |       0111
                    //100               |       1111
                    //Others            |       Assume to be 1's
                    /////////////////////////////////////////////////
                    
                    // This is for Arria II only
                    //////////////////////////////////////////////////
                    //Port             |       DRIO CRAM bit value
                    //1..0             |       10..7
                    //////////////////////////////////////////////////
                    //00               |       0000
                    //01               |       0001
                    //10               |       0011
                    //Others           |       Assume to be 1's
                    /////////////////////////////////////////////////
                    if (control_reg[0] == 1'b1)
                    begin
                        if ((device_family == "Stratix IV") || (device_family == "HardCopy IV"))
                            master_writedata <= {{16{1'b0}}, mutex_acq_readdata[15:11], data_reg[2], data_reg[1] & data_reg[0] | data_reg[2], data_reg[2] | data_reg[1], data_reg[2] | data_reg[1] | data_reg[0], mutex_acq_readdata[6:0]};
                        else
                            master_writedata <= {{16{1'b0}}, mutex_acq_readdata[15:11], 1'b0, 1'b0, data_reg[1], data_reg[1] | data_reg[0], mutex_acq_readdata[6:0]};
                        master_addr <= 5'b10100;
                        master_write <= 1'b1;
                        state <= SET_INFO_ON_BASIC;
                        set_addr <= 1'b1;
                    end
                    else begin
                        if ((device_family == "Stratix IV") || (device_family == "HardCopy IV"))
                            data_reg <= {{13{1'b0}}, mutex_acq_readdata[10], ~mutex_acq_readdata[10] & mutex_acq_readdata[8], mutex_acq_readdata[10] ^ mutex_acq_readdata[9] ^ mutex_acq_readdata[8] ^ mutex_acq_readdata[7]};
                        else
                            data_reg <= {{14{1'b0}}, mutex_acq_readdata[8], mutex_acq_readdata[7] ^ mutex_acq_readdata[8]};
                        // unset busy bit
                        status_reg <= 2'b0;
                        state <= IDLE;
                    end
                end
                else if (accessing_rxeqctrl)     // encode/decode rx_eqctrl
                begin
                    ////////////////////////////////////////
                    //        Wiz     A    B   C   D   V
                    //        3210    EDC BA9 876 543 210
                    //        0000    000 000 000 000 000
                    //    L0  0001    011 000 000 000 111
                    //    L1  0010    100 000 000 000 000
                    //    L2  0011    111 000 000 000 000
                    //    L3  0100    111 000 000 000 111
                    //    L4  0101    101 101 000 000 000 
                    //    M0  0110    111 111 000 000 000
                    //    M1  0111    111 111 000 000 100
                    //    M2  1000    111 111 000 000 111
                    //    M3  1001    111 111 111 000 001
                    //    M4  1010    111 111 111 000 100
                    //    H0  1011    111 111 111 111 000
                    //    H1  1100    111 111 111 111 001
                    //    H2  1101    111 111 111 111 100
                    //    H3  1110    111 111 111 111 110
                    //    H4  1111    111 111 111 111 111
                    ////////////////////////////////////////    
                    if (control_reg[0] == 1'b1)
                    begin
                        master_writedata[31:16] <= 0;
                        master_writedata[15] <= mutex_acq_readdata[15];
                        if (data_reg[3:0] > 4'b1010)            
                            master_writedata[14:3] <= {12{1'b1}};
                        else if (data_reg[3:0] > 4'b0110)            
                            master_writedata[14:3] <= {{3{1'b0}}, {9{1'b1}}};
                        else if (data_reg[3:0] > 4'b0011)            
                            master_writedata[14:3] <= {{6{1'b0}}, {6{1'b1}}};
                        else if (data_reg[3:0] > 4'b0)            
                            master_writedata[14:3] <= {{9{1'b0}}, {3{1'b1}}};
                        else
                            master_writedata[14:3] <= {12{1'b0}};
                        master_writedata[2] <= (data_reg[1] & ~data_reg[0]) | (~data_reg[3] & ~data_reg[2] & data_reg[1]) | (data_reg[2] & ~data_reg[1] & data_reg[0] | (data_reg[3] & data_reg[2] & data_reg[0]) | (data_reg[3] & ~data_reg[2] & ~data_reg[1]));
                        master_writedata[1] <= ( data_reg[1] & (data_reg[0] ^ (data_reg[2] ^ data_reg[3]))) | (data_reg[3] & data_reg[2] & ~data_reg[1] & ~data_reg[0]);
                        master_writedata[0] <= (~(data_reg[3] ^ data_reg[2]) & data_reg[1] & data_reg[0]) | (data_reg[2] & data_reg[1] & ~data_reg[0]) | (data_reg[3] & data_reg[1] & ~data_reg[0]) | (data_reg[3] & data_reg[2] & ~data_reg[0]) | (data_reg[3] & ~data_reg[2] & ~data_reg[1] & data_reg[0]);
                        
                        master_addr <= 5'b10100;
                        master_write <= 1'b1;
                        state <= SET_INFO_ON_BASIC;
                        set_addr <= 1'b1;                
                    end
                    else begin
                        if (mutex_acq_readdata[14:12] == 3'b111)         // > 10
                            data_reg <= {{12{1'b0}}, 1'b1, (mutex_acq_readdata[1] & mutex_acq_readdata[0]) | (mutex_acq_readdata[2] & ~mutex_acq_readdata[1]), (mutex_acq_readdata[2] & mutex_acq_readdata[0]) | (~mutex_acq_readdata[0] & ~mutex_acq_readdata[1] & ~mutex_acq_readdata[2]), (~mutex_acq_readdata[1] & ~mutex_acq_readdata[0]) | (mutex_acq_readdata[2] & mutex_acq_readdata[1] & mutex_acq_readdata[0])};
                        else if (mutex_acq_readdata[11:9] == 3'b111)    // > 6 only
                            data_reg <= {{12{1'b0}}, mutex_acq_readdata[2], ~mutex_acq_readdata[2], (mutex_acq_readdata[2] & mutex_acq_readdata[1] & mutex_acq_readdata[0]) | (~mutex_acq_readdata[2] & ~mutex_acq_readdata[1] & ~mutex_acq_readdata[0]), (~mutex_acq_readdata[2] & ~mutex_acq_readdata[1] & ~mutex_acq_readdata[0]) | (mutex_acq_readdata[2] & ~mutex_acq_readdata[1] & mutex_acq_readdata[0])};
                        else if (mutex_acq_readdata[8:6] == 3'b111)     // > 3 only
                            data_reg <= {{12{1'b0}}, 1'b0, 1'b1, mutex_acq_readdata[2] & mutex_acq_readdata[1] & mutex_acq_readdata[0], mutex_acq_readdata[2] & ~mutex_acq_readdata[1] & ~mutex_acq_readdata[0]};
                        else if (mutex_acq_readdata[5:3] == 3'b111)     // > 0 only
                            data_reg <= {{12{1'b0}}, {2{1'b0}}, (mutex_acq_readdata[2] & mutex_acq_readdata[1] & mutex_acq_readdata[0]) | (mutex_acq_readdata[2] & ~mutex_acq_readdata[1] & ~mutex_acq_readdata[0]), (mutex_acq_readdata[2] & mutex_acq_readdata[1] & mutex_acq_readdata[0]) | (~mutex_acq_readdata[2] & ~mutex_acq_readdata[1] & ~mutex_acq_readdata[0]) };
                    else
                            data_reg <= {16{1'b0}};
                            
                        // unset busy bit
                        status_reg <= 2'b0;
                        state <= IDLE; 
                    end
                end
                else if (accessing_preemph1t)
                begin
                    // This is for Arria II only
                    //////////////////////////////////////////////////
                    //Port                |       DRIO CRAM bit value
                    //4..0                |       15..11
                    //////////////////////////////////////////////////
                    //00000               |       00000
                    //00001               |       00001
                    //00010               |       00101
                    //00011               |       01001
                    //00100               |       01101
                    //00101               |       10001
                    //00110               |       10101  
                    //Others              |       Assume to be 1's
                    /////////////////////////////////////////////////
                    if (control_reg[0] == 1'b1)
                    begin
                        if (device_family == "Stratix IV")
                            master_writedata <= {{16{1'b0}}, data_reg[4:0], mutex_acq_readdata[10:0]};
                        else
                            master_writedata <= {{16{1'b0}}, data_reg[2] & data_reg[1] ^ data_reg[0], data_reg[2] & ~data_reg[1] & ~data_reg[0] | (data_reg[1] & data_reg[0]), (data_reg[2] | data_reg[1]) & ~data_reg[0], 1'b0, (data_reg[2] | data_reg[1] | data_reg[0]), mutex_acq_readdata[10:0]};
                        master_addr <= 5'b10100;
                        master_write <= 1'b1;
                        state <= SET_INFO_ON_BASIC;
                        set_addr <= 1'b1;
                    end
                    else begin
                        if (device_family == "Stratix IV")
                            data_reg <= {{11{1'b0}}, mutex_acq_readdata[15:11]};
                        else
                            data_reg <= {{11{1'b0}}, 1'b0, 1'b0, mutex_acq_readdata[15] | (mutex_acq_readdata[14] & mutex_acq_readdata[13]), mutex_acq_readdata[14] ^ mutex_acq_readdata[13], mutex_acq_readdata[13] ^ mutex_acq_readdata[11]};
                        // unset busy bit
                        status_reg <= 2'b0;
                        state <= IDLE;
                    end
                end
                else if (accessing_preemph0t || accessing_preemph2t)
                begin
                    if (control_reg[0] == 1'b1)
                    begin
                        if (accessing_preemph0t)
                        begin
                            if (needs_second_write_access)
                            begin
                                master_writedata <= {{16{1'b0}}, mutex_acq_readdata[15:5], ~data_reg[4], mutex_acq_readdata[3:0]};
                            end
                            else begin
                                if (data_reg[4] == 1'b0)
                                    master_writedata <= {{16{1'b0}}, mutex_acq_readdata[15:4], 4'b0000 - data_reg[3:0]};
                                else
                                    master_writedata <= {{16{1'b0}}, mutex_acq_readdata[15:4], data_reg[3:0]};
                            end
                        end
                        else if (accessing_preemph2t)
                        begin
                            if (needs_second_write_access)
                            begin
                                master_writedata <= {{16{1'b0}}, mutex_acq_readdata[15:4], ~data_reg[4], mutex_acq_readdata[2:0]};
                            end
                            else begin
                                if (data_reg[4] == 1'b0)
                                    master_writedata <= {{16{1'b0}}, mutex_acq_readdata[15:8], 4'b0000 - data_reg[3:0], mutex_acq_readdata[3:0]};
                                else
                                    master_writedata <= {{16{1'b0}}, mutex_acq_readdata[15:8], data_reg[3:0], mutex_acq_readdata[3:0]};
                            end
                        end
                        master_addr <= 5'b10100;
                        master_write <= 1'b1;
                        state <= SET_INFO_ON_BASIC;
                        set_addr <= 1'b1;
                    end
                    else begin
                        if (needs_second_access)
                        begin
                            data_reg <= mutex_acq_readdata[15:0];
                            master_write <= 1'b1;       // start access for INV bit
                            master_addr <= 5'b10000;
                            master_writedata <= {{16{1'b0}}, {4{1'b0}}, 2'b10, {8{1'b0}}, 2'b11};    // DPRIO register address
                            state <= SET_INFO_ON_BASIC;
                            needs_second_access <= 1'b0;
                        end
                        else begin
                            if (accessing_preemph0t)
                            begin
                                if (mutex_acq_readdata[4] == 1'b1)
                                    data_reg <= {{11{1'b0}}, 1'b0, 4'b0000 - data_reg[3:0]};
                                else
                                    data_reg <= {{11{1'b0}}, 1'b1, data_reg[3:0]};
                            end
                            else begin
                                if (mutex_acq_readdata[3] == 1'b1)
                                    data_reg <= {{11{1'b0}}, 1'b0, 4'b0000 - data_reg[7:4]};
                                else
                                    data_reg <= {{11{1'b0}}, 1'b1, data_reg[7:4]};
                            end
                            // unset busy
                            status_reg <= 2'b0;
                            state <= IDLE;
                        end
                    end
                end
                else begin // dont know what the operation is
                    analog_reconfig_readdata <= mutex_acq_readdata;
                    // unset busy bit
                    status_reg <= 2'b0;
                    state <= IDLE;
                end
            end
            else
            begin
                state <= READ_FROM_BASIC_DONE;
            end
        end
        SET_INFO_ON_BASIC: begin
            if (set_addr)
            begin
                master_addr <= 5'b10000;
                master_write <= 1'b1;
                if (accessing_vod)
                begin
                    master_writedata <= {{16{1'b0}}, {4{1'b0}}, 2'b10, {10{1'b0}}};
                end
                else if (accessing_preemph1t)
                    master_writedata <= {{16{1'b0}}, {4{1'b0}}, 2'b10, {8{1'b0}}, 2'b01};
                else if (accessing_rxdcgain)
                    master_writedata <= {{16{1'b0}}, {4{1'b0}}, 2'b11, 10'b0};
                else if (accessing_rxeqctrl)
                    master_writedata <= {{16{1'b0}}, {4{1'b0}}, 2'b11, 10'b0000001011};
                else if (accessing_preemph0t || accessing_preemph2t)
                begin
                    if (needs_second_write_access)
                    begin
                        master_writedata <= {{16{1'b0}}, {4{1'b0}}, 2'b10, {8{1'b0}}, 2'b11};
                    end
                    else
                        master_writedata <= {{16{1'b0}}, {4{1'b0}}, 2'b10, {8{1'b0}}, 2'b10};
                    if (control_reg[1] == 1'b1)                           // pure read cycle
                        needs_second_access <= 1'b1;
                end
                set_addr <= 1'b0;
            end
            else if (control_reg[1] == 1'b1 || (control_reg[0] == 1'b1 & do_read_before_write))         // read
            begin
                master_addr <= 5'b01100;
                master_write <= 1'b1;
                master_writedata <= {{16{1'b0}}, {14{1'b0}}, 2'b10};    // initiate read first
                state <= READ_FROM_GXB;
                do_read_before_write <= 1'b0;
            end
            else if (control_reg[0] == 1'b1)      // actual write
            begin
                master_write <= 1'b1;
                master_addr <= 5'b01100;
                master_writedata <= {{16{1'b0}}, {14{1'b0}}, 2'b01};   // issue write to basic's control_reg to start WRITE
                state <= WRITE_TO_GXB;
            end
        end
        READ_FROM_GXB: begin
            master_write <= 1'b0;
            if (analog_reconfig_irq_from_base == 1'b1)
                state <= READ_FROM_BASIC;
        end
        WRITE_TO_GXB: begin
            master_write <= 1'b0;
            if (analog_reconfig_irq_from_base == 1'b1)
            begin
                //start access to clear interrupt control reg. on slave
                master_addr <= 5'b01100;
                master_write <= 1'b1;
                master_writedata <= {{16{1'b0}}, {13{1'b0}}, 3'b000};
                state <= WRITE_DONE;
            end
        end
        WRITE_DONE: begin
            master_write <= 1'b0;
            if (analog_reconfig_irq_from_base == 1'b1)
            begin
                if ((accessing_preemph0t || accessing_preemph2t) & (!needs_second_write_access))
                begin
                    needs_second_write_access <= 1'b1;
                    do_read_before_write <= 1'b1;
                    master_write <= 1'b1;
                    master_addr <= 5'b10000;
                    master_writedata <= {{16{1'b0}}, {4{1'b0}}, 2'b10, {8{1'b0}}, 2'b11};    // DPRIO register address for INV
                    state <= SET_INFO_ON_BASIC;
                end
                else begin
                    needs_second_write_access <= 1'b0;
                    status_reg <= {1'b0, 1'b0};        // unset busy
                    analog_reconfig_done <= 1'b1;               // send INTERRUPT
                    state <= IDLE;
                end
            end
        end
        default:begin
            state <= IDLE;
        end
        endcase        
    end
//    prev_state <= state;
end

assign accessing_vod = (addr_offset[4:0] == 5'b0);
assign accessing_preemph0t = (addr_offset[4:0] == 5'b00001);
assign accessing_preemph1t = (addr_offset[4:0] == 5'b00010);
assign accessing_preemph2t = (addr_offset[4:0] == 5'b00011);
assign accessing_rxdcgain = (addr_offset[4] == 1'b1 && addr_offset[3:0] == 4'b0000);
assign accessing_rxeqctrl = (addr_offset[4] == 1'b1 && addr_offset[3:0] == 4'b0001);

//assign analog_reconfig_address_base = master_addr;
//assign analog_reconfig_write_base = master_write;
//assign analog_reconfig_read_base = master_read;
//assign analog_reconfig_writedata_base = master_writedata;


    alt_mutex_acq #(
        .mutex_wait_time(101),
        .addr_width(5),
        .data_width(32)
    )
    mutex_inst (
        .clk(reconfig_clk),
        .reset(reset),
    // inputs to the base that should be routed through the mutex		
        .address(master_addr),
        .writedata(master_writedata),
        .write(master_write),
        .read(master_read),
    // output from the mutex which is processed form of output from base
        .waitrequest(mutex_acq_waitrequest),
        .readdata(mutex_acq_readdata),


    // outputs from mutex to be routed to the base
        .master_address(analog_reconfig_address_base),
        .master_writedata(analog_reconfig_writedata_base),
        .master_write(analog_reconfig_write_base),
        .master_read(analog_reconfig_read_base),

    // these ports are from the base routed to the mutex
        .master_waitrequest(analog_reconfig_waitrequest_from_base),
        .master_readdata(analog_reconfig_readdata_base),      // from MM

    //request signal to the mutex		should be kept high as long as the mutex is being used
        .mutex_req(req_and_use_mutex),
    // output from mutex indicates whether you have mutex or not
        .mutex_grant(mutex_grant) 
    );

endmodule
