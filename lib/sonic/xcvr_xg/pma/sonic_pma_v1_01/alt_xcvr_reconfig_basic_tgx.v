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


(* ALTERA_ATTRIBUTE = {"{-to address_pres_reg[11]} DPRIO_CHANNEL_NUM=11;{-to address_pres_reg[10]} DPRIO_CHANNEL_NUM=10;{-to address_pres_reg[9]} DPRIO_CHANNEL_NUM=9;{-to address_pres_reg[8]} DPRIO_CHANNEL_NUM=8;{-to address_pres_reg[7]} DPRIO_CHANNEL_NUM=7;{-to address_pres_reg[6]} DPRIO_CHANNEL_NUM=6;{-to address_pres_reg[5]} DPRIO_CHANNEL_NUM=5;{-to address_pres_reg[4]} DPRIO_CHANNEL_NUM=4;{-to address_pres_reg[3]} DPRIO_CHANNEL_NUM=3;{-to address_pres_reg[2]} DPRIO_CHANNEL_NUM=2;{-to address_pres_reg[1]} DPRIO_CHANNEL_NUM=1;{-to address_pres_reg[0]} DPRIO_CHANNEL_NUM=0; disable_da_rule=\"S102,R102\""} *)
module alt_xcvr_reconfig_basic_tgx 
#(  parameter number_of_reconfig_interfaces = 1
 )
(
    // avalon clock interface
    input wire reconfig_clk,
    input wire reset,
    
    // avalon MM
    input wire basic_reconfig_write,
    input wire basic_reconfig_read,
    input wire [31:0] basic_reconfig_writedata,
    input wire [2:0] basic_reconfig_address,     // address to MM described below
    
    output reg [31:0] basic_reconfig_readdata,   // reconfig_fromgxb_data
    output wire basic_reconfig_waitrequest,

    // avalon MM
//    output wire reconfig_write_base,
//    output wire reconfig_read_base,
//    output wire [31:0] reconfig_writedata_base,
//    output wire [4:0] reconfig_address_base,     // address to MM described below

//   input wire [31:0] reconfig_readdata_base,   // reconfig_fromgxb_data
//    input wire reconfig_waitrequest_from_base,


    // avalon ST interface 
    input wire [number_of_reconfig_interfaces*17 - 1 : 0] basic_reconfig_fromgxb_data, // dprioout, testbus from altgx : (17+4 bits/quad)
    input wire [number_of_reconfig_interfaces*8 - 1 : 0] aeq_fromgxb_data,            // for ADCE dprio
    output wire [3:0] basic_reconfig_togxb_data,        // busy, dprioin, dprioload, dpriodisable and aeq to altgx
    output reg [number_of_reconfig_interfaces*24 - 1 : 0] aeq_togxb_data,             // for ADCE
    output reg [number_of_reconfig_interfaces*16 - 1 : 0] testbus_data,
    
    output reg basic_reconfig_irq             // interrupt to Master
);

//assign reconfig_write_base = 1'b0;
//assign reconfig_read_base = 1'b0;
//assign reconfig_writedata_base = 32'd0;
//assign reconfig_address_base = 5'd0;


// Memeory Map for register indirection
//     addr            wr/rd                description
//    ------------------------------------------------------
//      0                 wr/rd             mutex : bit[0]
//      1                wr/rd              logical_ch_addr (10 bits)
//      2                 rd                physical_chnl_map
//      3                rd/wr              status/control          -- bit 0 busy/bit 1 read, bit 0 write, bit 3 = absolute addressing
//      4               wr/rd               DPRIO addr_offset
//      5               wr/rd               DPRIO data
//      6               rd/wr               adce_standby, adce_capture, testbussel : bit 7 -- adcedone, bit 6 -- adcetestbus, bits 5,4 -- adce, 3 to 0 -- bussel
//      7               rd/wr               offset cancellation busy output to GX bit 0

//local parameters
localparam quad_address_width = 9;
localparam IDLE_STATE = 2'b00;
localparam WRITE_STATE = 2'b01;
localparam READ_STATE = 2'b10;


(* ALTERA_ATTRIBUTE = {"PRESERVE_REGISTER=ON"} *)
reg     [11:0]   address_pres_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [11:0] logical_channel_addr_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [14:0] dprio_table_addr_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [1:0] pma_pcs_id_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [1:0] state;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg dprio_busy_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [15:0] data_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [5:0] testbussel;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [1:0] adce_testdata;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [1:0] control_reg;
// mutex
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg  mutex_value;
//reg   [15:0]  mutex_owner;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg  [10:0] mutex_timeout_cntr;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg offset_cancellation_busy;

(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg basic_reconfig_absolute_addressing;


wire [quad_address_width-1:0] quad_address;
wire [quad_address_width-1:0] dprio_quad_address;

wire        busy_state;
wire [15:0] dprio_address;
wire        dprio_busy;
wire [15:0] dprio_datain;
wire [15:0] dprio_dataout;
wire        dprio_dprioout;
wire        dprio_rden;
wire        dprio_pulse;
wire        rd_pulse;
wire        read_done;
wire        read_word_done;
wire        reset_system;
wire        dprio_wren;
wire        write_done;
wire        wr_pulse;
wire        read_data_valid;
wire        write_word_done;

integer i,j;


assign basic_reconfig_waitrequest = 1'b0;

// synopsys translate_off
initial
begin
    state = 2'b00;
    basic_reconfig_irq = 1'b0;
    logical_channel_addr_reg = 12'b0;
    testbussel = 0;
    control_reg = 0;
    mutex_value = 0;
    mutex_timeout_cntr = 0;
    offset_cancellation_busy = 0;
    data_reg = 16'h0000;
    dprio_table_addr_reg = 15'h0000;
    pma_pcs_id_reg = 2'b00;
    
end
// synopsys translate_on

always @(posedge reconfig_clk or posedge reset)
begin
    if (reset === 1'b1)
        adce_testdata <= 0;
    else begin
        for (i=0; i<=1; i=i+1)
        begin
            adce_testdata[i] <= aeq_fromgxb_data[(logical_channel_addr_reg) + i];
        end
    end
end

always @(posedge reconfig_clk or posedge reset)
begin
    if (reset === 1'b1)
    begin
        state <= IDLE_STATE;
        basic_reconfig_readdata <= 16'b0;
        basic_reconfig_irq <= 1'b0;
        testbussel <= 0;
        control_reg <= 0;
        // mutex registers
        mutex_value <= 0;
        mutex_timeout_cntr <= 0;
    end
    else begin
        // mutex
        if (basic_reconfig_address == 3'b0)
        begin
            //read first only update the mutex_value
            if (basic_reconfig_read == 1'b1)
            begin
                basic_reconfig_readdata <= {{31{1'b0}}, mutex_value};	
              //  if (basic_reconfig_waitrequest == 1'b0)
                    if (mutex_value == 1'b0)   // mutex is free, so grant access
                        mutex_value <= 1'b1;
            end
            else if (basic_reconfig_write == 1'b1)
            begin
                mutex_value <= 0;
            end
        end

        case (state)
             IDLE_STATE: begin
                  if (basic_reconfig_write == 1'b1)
                  begin
                      mutex_timeout_cntr <= 0; // reset the mutex_timeout counter
                      if (basic_reconfig_address == 3'b001)
                      begin
                          logical_channel_addr_reg <= basic_reconfig_writedata[11:0];
                          address_pres_reg <= {basic_reconfig_writedata[10:2], 1'b0, basic_reconfig_writedata[1:0]}; //chestan
                      end
                      else if (basic_reconfig_address == 3'b100)
                      begin
                          dprio_table_addr_reg <= basic_reconfig_writedata[14:0];
                          pma_pcs_id_reg <= basic_reconfig_writedata[11:10];                      
                      end
                      else if (basic_reconfig_address == 3'b011)         // control reg
                      begin
                           if (basic_reconfig_writedata[0] == 1'b1)        // write
                           begin
                               state <= WRITE_STATE;
                               control_reg <= 2'b01;
                           end
                           else if (basic_reconfig_writedata[1] == 1'b1)     // read
                           begin
                               state <= READ_STATE;
                               control_reg <= 2'b10;
                           end
                           if (basic_reconfig_writedata[2] == 1'b0) begin
                               basic_reconfig_irq <= 1'b0;               // clear WRITE interrupt
                           end
                           basic_reconfig_absolute_addressing <= basic_reconfig_writedata[3]; // use the full address from dprio_addr, not the derived address
                      end
                      else if (basic_reconfig_address == 3'b101)    // data
                      begin
                          data_reg <= basic_reconfig_writedata[15:0];
                      end
                      else if (basic_reconfig_address == 3'b110)       // testbussel
                           testbussel <= basic_reconfig_writedata[5:0];
                      else if (basic_reconfig_address == 3'b111)
						   offset_cancellation_busy <= basic_reconfig_writedata[0];
                      begin
                      end
                  end
                  else if (basic_reconfig_read == 1'b1)
                  begin
                      if (basic_reconfig_address == 3'b001)
                          basic_reconfig_readdata <= {{20{1'b0}}, logical_channel_addr_reg};
                      else if (basic_reconfig_address == 3'b010)                            // physical chnl
                          basic_reconfig_readdata <= {{21{1'b0}}, address_pres_reg[11:3], address_pres_reg[1:0]};                  // check this
                      else if (basic_reconfig_address == 3'b011)                       // status
                          basic_reconfig_readdata <= {{23{1'b0}}, busy_state, {5{1'b0}}, basic_reconfig_irq, control_reg};
                      else if (basic_reconfig_address == 3'b100)
                          basic_reconfig_readdata <= {{20{1'b0}}, pma_pcs_id_reg, dprio_table_addr_reg};
                      else if (basic_reconfig_address == 3'b101)                       // DPRIO readdata
                      begin
                          basic_reconfig_readdata <= {{16{1'b0}}, data_reg};
                          basic_reconfig_irq <= 1'b0;      // clear READ interrupt
                      end
                      else if (basic_reconfig_address == 3'b110)
                          basic_reconfig_readdata <= {{24{1'b0}}, adce_testdata, testbussel};
                      else if (basic_reconfig_address == 3'b111)                        // testbusdata
                          basic_reconfig_readdata <= {{31{1'b0}}, offset_cancellation_busy};
                      if (basic_reconfig_address != 3'b0) // if not reading the mutex val
					      mutex_timeout_cntr <= 0; // reset the mutex counter    
                  end
                  else if (mutex_value == 1'b1) // if mutex was granted to someone
					  if (mutex_timeout_cntr == 10'd1000) // and they didnt do anything for 1000 cycles
					  begin
					      mutex_value <= 1'b0;  // reset the mutex and give it to the next person
					      mutex_timeout_cntr <= 0;
					  end
					  else    
				          mutex_timeout_cntr <= mutex_timeout_cntr[9:0] + 10'b1; // count up the timer from the last access
             end
             WRITE_STATE: begin
                 if (write_done)
                 begin
                     state <= IDLE_STATE;
                     basic_reconfig_irq <= 1'b1;      // send interrupt to master
                 end
                 // allow status_register read here
                 if (basic_reconfig_read == 1'b1 && basic_reconfig_address == 3'b011)
                     basic_reconfig_readdata <= {{23{1'b0}}, busy_state, {5{1'b0}}, basic_reconfig_irq, control_reg};
             end
             READ_STATE: begin
                 if (read_word_done == 1'b1)
                 begin
                     data_reg <= dprio_dataout;
                     basic_reconfig_irq <= 1'b1;   //  send interrupt
                     state <= IDLE_STATE;
                 end
                 // allow status_register read here
                 if (basic_reconfig_read == 1'b1 && basic_reconfig_address == 3'b011)
                     basic_reconfig_readdata <= {{23{1'b0}}, busy_state, {5{1'b0}}, basic_reconfig_irq, control_reg};
             end
             default: begin
                  state <= IDLE_STATE;
             end
        endcase
    end
end

// synopsys translate_off
initial address_pres_reg = 0;
// synopsys translate_on

assign quad_address = logical_channel_addr_reg[10:2];
assign dprio_address[15:0] = basic_reconfig_absolute_addressing ? {1'b0, dprio_table_addr_reg[14:0]} : {1'b0, address_pres_reg[2], address_pres_reg[1:0], pma_pcs_id_reg[1:0], dprio_table_addr_reg[9:0]};
assign dprio_quad_address = address_pres_reg[11:3];
assign dprio_dprioout = basic_reconfig_fromgxb_data[quad_address * 17];
assign dprio_datain = data_reg;
assign dprio_rden = rd_pulse;
assign rd_pulse = (state == READ_STATE) & ~dprio_pulse & ~read_done;
assign read_done = read_word_done | reset_system;
assign read_word_done = (state == READ_STATE) & read_data_valid;
assign read_data_valid = (state == READ_STATE) & dprio_pulse;
assign dprio_wren = wr_pulse;
assign wr_pulse = (state == WRITE_STATE) & ~dprio_pulse & ~write_done;
assign write_done = write_word_done | reset_system;
assign write_word_done = (state == WRITE_STATE) & dprio_pulse;
assign reset_system = reset;
assign busy_state = (state == READ_STATE) | (state == WRITE_STATE);

// synopsys translate_off
initial dprio_busy_reg = 0;
// synopsys translate_on

always @(posedge reconfig_clk) dprio_busy_reg <= dprio_busy;
assign dprio_pulse = (dprio_busy_reg ^ dprio_busy) & (~dprio_busy);

alt_dprio inst_alt_dprio (.dpclk(reconfig_clk),
           .datain(dprio_datain),
           .address(dprio_address),
           .wren(dprio_wren),
           .rden(dprio_rden),
//           .rdinc(),
           .wren_data(1'b0),
           .dprioout(dprio_dprioout),                        // reconfig_fromgxb_data[0]
           .quad_address(dprio_quad_address),
           // outputs
           .dprioin(basic_reconfig_togxb_data[0]),
           .dpriodisable(basic_reconfig_togxb_data[1]),
           .dprioload(basic_reconfig_togxb_data[2]),
           .dataout(dprio_dataout),
           .busy(dprio_busy)
          );

//assign testbus_data = (testbussel == 3'b110) ? basic_reconfig_fromgxb_data : 'b0;

assign basic_reconfig_togxb_data[3] = offset_cancellation_busy;

always @(basic_reconfig_fromgxb_data)
begin
    for (i=0; i<number_of_reconfig_interfaces; i=i+1)
    begin
        for (j=0; j<= 15; j=j+1)
        begin
            testbus_data[(i*16) + j] = basic_reconfig_fromgxb_data[(i*17) + j+1];
        end
    end
end

always @(logical_channel_addr_reg or testbussel)
begin
    aeq_togxb_data = {number_of_reconfig_interfaces*24{1'b0}};
    for (i=0; i<=5; i=i+1)
    begin
        aeq_togxb_data[(logical_channel_addr_reg*6) + i] = testbussel[i];
    end
end
endmodule
