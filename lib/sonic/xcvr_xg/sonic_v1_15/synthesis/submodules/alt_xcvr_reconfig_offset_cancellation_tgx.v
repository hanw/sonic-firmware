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
module alt_xcvr_reconfig_offset_cancellation_tgx 
#(
	parameter device_family = "StratixIV",      
    parameter number_of_reconfig_interfaces = 1
)
(
    input wire reconfig_clk,        // this will be the reconfig clk
    input wire reset,
    
    //avalon MM slave
    input wire offset_cancellation_address,             // MM address
    input wire [31:0] offset_cancellation_writedata,
    input wire offset_cancellation_write,
    input wire offset_cancellation_read,
    
    //output MM slave
    output reg [31:0] offset_cancellation_readdata,      // from MM
    
    output reg offset_cancellation_done,
      
    // input from base_reconfig
    input wire offset_cancellation_irq_from_base,
    input wire offset_cancellation_waitrequest_from_base,
    
    output wire offset_cancellation_waitrequest,
      
    // output to base_reconfig
    // Avalon MM Master
    output wire [4:0] offset_cancellation_address_base,   // 3 bit MM
    output wire [31:0] offset_cancellation_writedata_base,  
    output wire offset_cancellation_write_base,                         // start write to GXB
    output wire offset_cancellation_read_base,                          // start read from GXB
    
    // input from base reconfig
    input wire [31:0] offset_cancellation_readdata_base,         // data from read command
    
    // Avalon ST
    input wire [number_of_reconfig_interfaces*16 - 1 : 0] testbus_data 
);

///////////////////////////////////////////////////////////////////
// Memory map   | wr/rd     |       Description 
//----------------------------------------------------------------
// 0           | wr/rd     |   [31:10] Reserved
//              |           |   [9] Error
//              |           |   [8] Busy
//              |           |   [7:1] Reserved
//              |           |   [0] Start (hidden for QII 9.1)
///////////////////////////////////////////////////////////////////

//local parameters
//state
localparam IDLE_STATE = 4'b0000;
localparam LOGICAL_ADDRESS_STATE = 4'b0001;
localparam WRITE_DATA_STATE = 4'b0010;
localparam CONTROL_STATE = 4'b0011;
localparam BUSY_STATE = 4'b0100;
localparam READ_PHY_ADDR_STATE = 4'b0101;
localparam CHECK_PHY_ADDR_STATE = 4'b0110;
localparam ADDRESS_OFFSET_STATE = 4'b0111;
localparam BASE_BUSY_STATE = 4'b1000;
localparam READ_DATA_STATE = 4'b1001;
localparam WRITE_DONE_STATE = 4'b1010;

localparam ILLEGAL_PHYSICAL_CHNL = 10'b1111111111;

wire mutex_grant;
wire [31:0] master_read_data;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [3:0] state;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg write_read_control;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg master_write;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg master_read;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [31:0] master_write_data;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [2:0] master_address;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg req_and_use_mutex;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg set_busy;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg alt_cal_error_reg;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg wait_phy_addr_ready;

wire [4:0] master_address_shifted;

//alt_cal instantiation
wire alt_cal_busy;
wire [15:0] alt_cal_dprio_dataout;
wire alt_cal_dprio_wren;
wire alt_cal_dprio_rden;
wire alt_cal_retain_addr;
wire [(number_of_reconfig_interfaces*4-1) : 0] alt_cal_error;

wire [number_of_reconfig_interfaces*16 - 1 : 0] alt_cal_testbuses;
wire [15:0] alt_cal_dprio_addr;
wire [8:0] alt_cal_quad_addr;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [11:0] alt_cal_remap_addr;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg alt_cal_dprio_busy;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg alt_cal_dprio_busy_int;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [15:0] alt_cal_dprio_datain;

function integer CLogB2;
input integer Depth;
integer i;
begin
i = Depth; 
for(CLogB2 = 0; i > 0; CLogB2 = CLogB2 + 1)
i = i >> 1;
end
endfunction

// Implement waitrequest to match previous implementation
altera_wait_generate wait_gen(
    .rst(reset),
    .clk(reconfig_clk),
    .launch_signal(offset_cancellation_read),
    .wait_req(offset_cancellation_waitrequest)
);

// synopsys translate_off
initial begin
    state = 3'b000;
    alt_cal_remap_addr = 12'h000;
    req_and_use_mutex = 1'b0;
    wait_phy_addr_ready = 1'b0;
   // alt_cal_testbuses = 0;
   alt_cal_dprio_datain = 16'h0000;
   alt_cal_dprio_busy = 1'b0;
   alt_cal_dprio_busy_int = 1'b0;
    
    master_write = 1'b0;
    master_read = 1'b0;
    master_write_data = {32{1'b0}};
    master_address = 3'h0;
    
    write_read_control = 1'b0; // 1 for write, 0 for read
    set_busy = 1'b0; // 1 for assert busy, 0 for deassert busy 
    
    alt_cal_error_reg = 1'b0; 
    offset_cancellation_done = 1'b0;
    
end
// synopsys translate_on

integer count;

always @(posedge reconfig_clk or posedge reset)
begin
    if (reset)
    begin
        master_write <= 1'b0;
        master_read <= 1'b0;
        master_write_data <= {32{1'b0}};
        master_address <= 3'h0;        
        write_read_control = 1'b0; // 1 for write, 0 for read
        set_busy <= 1'b0;
        state <= IDLE_STATE;
        offset_cancellation_readdata[31:0] <= {32{1'b0}};
        alt_cal_error_reg <= 1'b0;
        req_and_use_mutex <= 1'b0;
        wait_phy_addr_ready <= 1'b0;
        alt_cal_dprio_busy_int<= 1'b0;
        offset_cancellation_done = 1'b0;
    end
    else begin
        if(offset_cancellation_read == 1'b1)
        begin
            if(offset_cancellation_address == 1'b0)
            begin
                offset_cancellation_readdata <= {{22{1'b0}}, alt_cal_error_reg, alt_cal_busy , {8{1'b0}}};
            end
        end
        
        for(count=0; count < (number_of_reconfig_interfaces*4); count=count+1)
        begin
            alt_cal_error_reg = alt_cal_error[count] | alt_cal_error_reg;
        end    
        
        if(alt_cal_busy == 1'b0)
            req_and_use_mutex <= 1'b0;
        else
            req_and_use_mutex <= 1'b1;    
		
        case (state)
        IDLE_STATE: 
        begin
            offset_cancellation_done <= 1'b0; // reset write/read done flag
            //reset the signal
            set_busy <= 1'b0;
            master_write <= 1'b0;
            master_read <= 1'b0;
            alt_cal_remap_addr <= 12'h000;
            
           //al_cal will not assert wren and rden at the same time 
    		if((alt_cal_dprio_wren == 1'b1) || (alt_cal_dprio_rden == 1'b1))
    		begin
    		    if(mutex_grant == 1'b1)
    		    begin  		    
        		    if(alt_cal_dprio_wren == 1'b1)
        		        write_read_control <= 1'b1; // 1 for write
        		    else
        		        write_read_control <= 1'b0; // 0 for read
        		    state <= LOGICAL_ADDRESS_STATE;  
        		end
        		else
        		    state <= IDLE_STATE;
    		end
    		else if(alt_cal_retain_addr == 1'b1)
    		begin
    		    if(mutex_grant == 1'b1)
        		    state <= WRITE_DATA_STATE;  
        		else
        		    state <= IDLE_STATE;
    		end
    		else
    		begin
    		    state <= IDLE_STATE;
    		end
        end
        LOGICAL_ADDRESS_STATE: //sending channel and quad address
        begin
		    if(mutex_grant == 1'b1)
		    begin  	
                master_address <= 3'h1;
                master_write_data <= {{21{1'b0}}, alt_cal_quad_addr, alt_cal_dprio_addr[13:12]};
                master_write <= 1'b1; // send address to alt_dprio
                master_read <= 1'b0;
                state <= READ_PHY_ADDR_STATE; 
            end
            else
            begin
                state <= LOGICAL_ADDRESS_STATE; 
            end
        end
        READ_PHY_ADDR_STATE: //read phsical address
        begin
		    if(mutex_grant == 1'b1)
		    begin
		        master_address <= 3'h2;
		        master_read <= 1'b1;
		        master_write <= 1'b0;
		        if (wait_phy_addr_ready == 1'b1)
		        begin
		            wait_phy_addr_ready <= 1'b0;
		            state <= CHECK_PHY_ADDR_STATE;
		        end
		        else
		        begin
		            wait_phy_addr_ready <= 1'b1;
		            state <= READ_PHY_ADDR_STATE;
		            //state <= CHECK_PHY_ADDR_STATE;
		        end
		    end
		    else
		    begin
		        state <= READ_PHY_ADDR_STATE;
		    end
        end
        CHECK_PHY_ADDR_STATE: //check physical address correct or not
        begin
		    if(mutex_grant == 1'b1)
		    begin
		        master_read <= 1'b0;
		        master_write <= 1'b0;
		        if (master_read_data[9:0] == ILLEGAL_PHYSICAL_CHNL)
		        begin
                            // synopsys translate_off
                            $display ("Illegal physical address: 10'h%h", master_read_data);
                            $display ("Time: %0t  Instance: %m", $time);
                            // synopsys translate_on
		            alt_cal_remap_addr <= 12'hfff;
                            state <= IDLE_STATE;
		        end
		        else
		        begin
		            alt_cal_remap_addr <= master_read_data[11:0];
		            state <= ADDRESS_OFFSET_STATE;
		        end
		    end
		    else
		    begin
		        state <= CHECK_PHY_ADDR_STATE;
		    end
        end
        ADDRESS_OFFSET_STATE: // send address offset to alt_dprio
        begin
		    if(mutex_grant == 1'b1)
		    begin  	
                master_address <= 3'h4;
                master_write_data <= {{17{1'b0}}, alt_cal_dprio_addr[14:0]};
                master_write <= 1'b1; 
                master_read <= 1'b0;
                if(write_read_control == 1'b1)
                    state <= WRITE_DATA_STATE; 
                else
                    state <= CONTROL_STATE;
            end
            else
            begin
                state <= ADDRESS_OFFSET_STATE; 
            end
        end
        WRITE_DATA_STATE:
        begin
            master_address <= 3'h5;
            master_write_data = {{16{1'b0}}, alt_cal_dprio_dataout};
            master_write <= 1'b1; // send address to alt_dprio
            master_read <= 1'b0;
            state <= CONTROL_STATE; 
        end
        CONTROL_STATE: // sending write/read command
        begin
		    if(mutex_grant == 1'b1)
		    begin 
                master_address <= 3'h3; // get ready to send control command to alt_dprio
//                master_write_data <=  {{29{1'b0}}, (~write_read_control), write_read_control};
                master_write_data <=  {{27{1'b0}}, 1'b1, 1'b0, (~write_read_control), write_read_control}; // use absolute addressing
                master_write <= 1'b1;  
                master_read <= 1'b0; 
                state <= BASE_BUSY_STATE;
            end
            else
            begin
                state <= CONTROL_STATE; 
            end         
        end
        BASE_BUSY_STATE: // send busy to reconfig_togxb
        begin
		    if(mutex_grant == 1'b1)
		    begin 
		        master_address <= 3'h7; // set offset cancellation busy to reconfig_togxb
                master_write_data <=  {{30{1'b0}}, alt_cal_busy};
                master_write <= 1'b1; 
                master_read <= 1'b0; 
                if(set_busy == 1'b0)
                begin
                    set_busy <= 1'b1;
                    state <= BUSY_STATE;
                end
                else
                begin
                    set_busy <= 1'b0;
                    state <= IDLE_STATE;
                end
		    end
		    else
		    begin
		        state <= BASE_BUSY_STATE;
		    end
        end
        BUSY_STATE: // wait for write done
        begin            
            if(offset_cancellation_irq_from_base == 1'b1)
            begin
                alt_cal_dprio_busy <= 1'b1;
                if(write_read_control == 1'b0) //read
                begin
                    master_write <= 1'b0; 
                    master_read <= 1'b0;
                    state <= READ_DATA_STATE;
                end
                else
                begin

                    master_write <= 1'b0; 
                    master_read <= 1'b0;
                    state <= WRITE_DONE_STATE;
                end
            end
            else
            begin
                master_read <= 1'b0;                
                master_write <= 1'b0;
                alt_cal_dprio_busy <= 1'b1;
                state <= BUSY_STATE;
            end
        end
        WRITE_DONE_STATE:
        begin
            if(mutex_grant == 1'b1)
		    begin
                if(offset_cancellation_irq_from_base == 1'b1)
                begin
                    if(alt_cal_dprio_busy_int == 1'b1) // wait for dprio_busy to go low
                    begin
                        master_write <= 1'b0;                    
                        master_read <= 1'b1;
                        master_address <= 3'h3;
                        alt_cal_dprio_busy_int <= master_read_data[8];
                        alt_cal_dprio_busy <= 1'b1;
                        state <= WRITE_DONE_STATE;
                    end
                    else
                    begin
                        master_write <= 1'b1; 
                        master_read <= 1'b0;
                        master_address <= 3'h3;
                        master_write_data <= {{16{1'b0}}, {16'h0000}}; //acknowledge write operation                        
                        alt_cal_dprio_busy <= 1'b1;                        
                        state <= WRITE_DONE_STATE;
                    end
                end
                else
                begin
                    master_read <= 1'b0;                
                    master_write <= 1'b0;
                    alt_cal_dprio_busy <= 1'b0;
                    offset_cancellation_done <= 1'b1; // write done
                    state <= IDLE_STATE;
                end
            end
            else
            begin
                state <= WRITE_DONE_STATE;
            end
        end
        READ_DATA_STATE:
        begin
            if(mutex_grant == 1'b1)
            begin 
                if(offset_cancellation_irq_from_base == 1'b1)
                begin
                    if(alt_cal_dprio_busy_int == 1'b1) // wait for dprio_busy to go low
                    begin  
                        master_write <= 1'b0;                    
                        master_read <= 1'b1;
                        master_address <= 3'h3;
                        alt_cal_dprio_busy_int <= master_read_data[8];
                        alt_cal_dprio_busy <= 1'b1;                        
                    end
                    else
                    begin
                        master_address <= 3'h5;		        
                        master_write <= 1'b0; 
                        master_read <= 1'b1;                        
                        alt_cal_dprio_busy <= 1'b1;
                    end
                    state <= READ_DATA_STATE;
                end
                else
                begin
                    master_read <= 1'b0;                
                    master_write <= 1'b0;
                    offset_cancellation_done <= 1'b1; // read done
                    alt_cal_dprio_datain <= master_read_data[15:0];
                    alt_cal_dprio_busy <= 1'b0;
                    state <= IDLE_STATE;
                end                
            end
            else
            begin
                state <= READ_DATA_STATE;
            end
        end
        default:
        begin
            state <= IDLE_STATE;
        end
        endcase        
    end
end



generate

//Deepak Use alt_cal_mm for SIV and AIIGX
if((device_family=="Stratix IV") || (device_family=="Arria II GX") || (device_family=="Arria II GZ") || (device_family=="HardCopy IV"))
begin
	alt_cal_mm #(
		.number_of_channels (number_of_reconfig_interfaces*4),
		.channel_address_width (CLogB2(number_of_reconfig_interfaces*4))    
	)alt_cal_inst
	(
	.clock(reconfig_clk),
	.reset(reset),
	.start(),
	.busy(alt_cal_busy),
 	.dprio_addr(alt_cal_dprio_addr), // only extract the logical channel address
	.quad_addr(alt_cal_quad_addr),
	.dprio_dataout(alt_cal_dprio_dataout),
	.dprio_datain(alt_cal_dprio_datain),
	.dprio_wren(alt_cal_dprio_wren),
	.dprio_rden(alt_cal_dprio_rden),
	.dprio_busy(alt_cal_dprio_busy),
	.retain_addr(alt_cal_retain_addr),
	.remap_addr(alt_cal_remap_addr),
	.testbuses(alt_cal_testbuses),
	.cal_error(alt_cal_error)
	);
end
//Deepak: Use alt_cal_c3gxb for Cyclone IV GX
if(device_family=="Cyclone IV GX")
begin
	alt_cal_c3gxb alt_cal_inst
	(
    	.clock(reconfig_clk),
	.reset(reset),
	.start(),
	.busy(alt_cal_busy),
	.dprio_addr(alt_cal_dprio_addr), // only extract the logical channel address
	.quad_addr(alt_cal_quad_addr),
	.dprio_dataout(alt_cal_dprio_dataout),
	.dprio_datain(alt_cal_dprio_datain),
	.dprio_wren(alt_cal_dprio_wren),
	.dprio_rden(alt_cal_dprio_rden),
	.dprio_busy(alt_cal_dprio_busy),
	.retain_addr(alt_cal_retain_addr),
	.remap_addr(alt_cal_remap_addr),
	.testbuses(alt_cal_testbuses),
	.cal_error(alt_cal_error)
	);
defparam
    alt_cal_inst.number_of_channels = number_of_reconfig_interfaces*4,
    alt_cal_inst.channel_address_width = CLogB2(number_of_reconfig_interfaces*4);    
end
endgenerate

alt_mutex_acq #(
	.mutex_wait_time(102), ///Thia: pick a different mutex wait time to avoid collision. Say 102. (since analog is already using 101)
	.addr_width(5),
	.data_width(32)
)	
mutex_inst (
	.clk(reconfig_clk),
	.reset(reset),
// inputs to the base that should be routed through the mutex		
	.address(master_address_shifted),
	.writedata(master_write_data),
	.write(master_write),
	.read(master_read),
// output from the mutex which is processed form of output from base
	.waitrequest(),
	.readdata(master_read_data),

// outputs from mutex to be routed to the base
	.master_address(offset_cancellation_address_base),
	.master_writedata(offset_cancellation_writedata_base),
	.master_write(offset_cancellation_write_base),
	.master_read(offset_cancellation_read_base),

// these ports are from the base routed to the mutex
	.master_waitrequest(offset_cancellation_waitrequest_from_base),
	.master_readdata(offset_cancellation_readdata_base),      // from MM

//request signal to the mutex		should be kept high as long as the mutex is being used
	.mutex_req(req_and_use_mutex),
// output from mutex indicates whether you have mutex or not
	.mutex_grant(mutex_grant) 
);	

//wire assignment
assign alt_cal_testbuses = testbus_data;
assign master_address_shifted = {master_address, {2'b00}};

endmodule

