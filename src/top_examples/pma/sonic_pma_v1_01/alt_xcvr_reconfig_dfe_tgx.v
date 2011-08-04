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
module alt_xcvr_reconfig_dfe_tgx 
#(
     parameter device_family = "StratixIV",      
    parameter number_of_reconfig_interfaces = 1
)
(
    input wire reconfig_clk,        // this will be the reconfig clk
    input wire reset,
    
    //avalon MM slave
    input wire [2:0]  dfe_address,       // Check this! fix me!
    input wire [31:0] dfe_writedata,
    input wire dfe_write,
    input wire dfe_read,
    
    //output MM slave
    output wire [31:0] dfe_readdata,      // from MM
    output wire        dfe_waitrequest,   // from MM
    
    output reg dfe_irq,
      
    // input from base_reconfig
    input wire dfe_irq_from_base,
    input wire dfe_waitrequest_from_base,
      
    // output to base_reconfig
    // Avalon MM Master
    output wire [4:0] dfe_address_base,   // 3 bit MM
    output wire [31:0] dfe_writedata_base,  
    output wire dfe_write_base,                         // start write to GXB
    output wire dfe_read_base,                          // start read from GXB
    
    // input from base reconfig
    input wire [31:0] dfe_readdata_base         // data from read command
    
);

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
reg wait_phy_addr_ready;

wire [4:0] master_address_shifted;

//alt_dfe instantiation
wire alt_dfe_busy;
wire [15:0] alt_dfe_dprio_dataout;
wire alt_dfe_dprio_wren;
wire alt_dfe_dprio_rden;
wire [(number_of_reconfig_interfaces*4-1) : 0] alt_dfe_error;

wire [15:0] alt_dfe_dprio_addr;
wire [8:0] alt_dfe_quad_addr;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [11:0] alt_dfe_remap_addr;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg alt_dfe_dprio_busy;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg alt_dfe_dprio_busy_int;
(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=LOW"} *)
reg [15:0] alt_dfe_dprio_datain;

function integer CLogB2;
input integer Depth;
integer i;
begin
i = Depth; 
for(CLogB2 = 0; i > 0; CLogB2 = CLogB2 + 1)
i = i >> 1;
end
endfunction

// synopsys translate_off
initial begin
    state = 3'b000;
    alt_dfe_remap_addr = 12'h000;
    req_and_use_mutex = 1'b0;
    wait_phy_addr_ready = 1'b0;
    alt_dfe_dprio_datain = 16'h0000;
    alt_dfe_dprio_busy = 1'b0;
    alt_dfe_dprio_busy_int = 1'b0;
    
    master_write = 1'b0;
    master_read = 1'b0;
    master_write_data = {32{1'b0}};
    master_address = 3'h0;
    
    write_read_control = 1'b0; // 1 for write, 0 for read
    set_busy = 1'b0; // 1 for assert busy, 0 for deassert busy 
    
    dfe_irq = 1'b0;
    
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
        write_read_control <= 1'b0; // 1 for write, 0 for read
        set_busy <= 1'b0;
        state <= IDLE_STATE;
        req_and_use_mutex <= 1'b0;
        wait_phy_addr_ready <= 1'b0;
        alt_dfe_dprio_busy_int<= 1'b0;
        dfe_irq <= 1'b0;
    end
    else begin
        if(alt_dfe_busy == 1'b0)
            req_and_use_mutex <= 1'b0;
        else
            req_and_use_mutex <= 1'b1;    
		
        case (state)
        IDLE_STATE: 
        begin
            dfe_irq <= 1'b0; // reset write/read done flag
            //reset the signal
            set_busy <= 1'b0;
            master_write <= 1'b0;
            master_read <= 1'b0;
	    alt_dfe_remap_addr <= 12'h000;
            
           //alt_dfe will not assert wren and rden at the same time 
    		if((alt_dfe_dprio_wren == 1'b1) || (alt_dfe_dprio_rden == 1'b1))
    		begin
    		    if(mutex_grant == 1'b1)
    		    begin  		    
        		    if(alt_dfe_dprio_wren == 1'b1)
        		        write_read_control <= 1'b1; // 1 for write
        		    else
        		        write_read_control <= 1'b0; // 0 for read
        		    state <= LOGICAL_ADDRESS_STATE;  
        		end
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
                master_write_data <= {{21{1'b0}}, alt_dfe_quad_addr, alt_dfe_dprio_addr[13:12]};
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
		            alt_dfe_remap_addr <= 12'hfff;
                            state <= IDLE_STATE;
		        end
		        else
		        begin
		            alt_dfe_remap_addr <= master_read_data[11:0];
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
                master_write_data <= {{20{1'b0}}, alt_dfe_dprio_addr[11:0]};
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
            master_write_data = {{16{1'b0}}, alt_dfe_dprio_dataout};
            master_write <= 1'b1; // send address to alt_dprio
            master_read <= 1'b0;
            state <= CONTROL_STATE; 
        end
        CONTROL_STATE: // sending write/read command
        begin
		    if(mutex_grant == 1'b1)
		    begin 
                master_address <= 3'h3; // get ready to send control command to alt_dprio
                master_write_data <=  {{29{1'b0}}, (~write_read_control), write_read_control};
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
                master_write_data <=  {{30{1'b0}}, alt_dfe_busy};
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
            if(dfe_irq_from_base == 1'b1)
            begin
                alt_dfe_dprio_busy <= 1'b1;
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
                alt_dfe_dprio_busy <= 1'b1;
                state <= BUSY_STATE;
            end
        end
        WRITE_DONE_STATE:
        begin
            if(mutex_grant == 1'b1)
		    begin
                if(dfe_irq_from_base == 1'b1)
                begin
                    if(alt_dfe_dprio_busy_int == 1'b1) // wait for dprio_busy to go low
                    begin
                        master_write <= 1'b0;                    
                        master_read <= 1'b1;
                        master_address <= 3'h3;
                        alt_dfe_dprio_busy_int <= master_read_data[8];
                        alt_dfe_dprio_busy <= 1'b1;
                        state <= WRITE_DONE_STATE;
                    end
                    else
                    begin
                        master_write <= 1'b1; 
                        master_read <= 1'b0;
                        master_address <= 3'h3;
                        master_write_data <= {{16{1'b0}}, {16'h0000}}; //acknowledge write operation                        
                        alt_dfe_dprio_busy <= 1'b1;                        
                        state <= WRITE_DONE_STATE;
                    end
                end
                else
                begin
                    master_read <= 1'b0;                
                    master_write <= 1'b0;
                    alt_dfe_dprio_busy <= 1'b0;
                    dfe_irq <= 1'b1; // write done
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
                if(dfe_irq_from_base == 1'b1)
                begin
                    if(alt_dfe_dprio_busy_int == 1'b1) // wait for dprio_busy to go low
                    begin  
                        master_write <= 1'b0;                    
                        master_read <= 1'b1;
                        master_address <= 3'h3;
                        alt_dfe_dprio_busy_int <= master_read_data[8];
                        alt_dfe_dprio_busy <= 1'b1;                        
                    end
                    else
                    begin
                        master_address <= 3'h5;		        
                        master_write <= 1'b0; 
                        master_read <= 1'b1;                        
                        alt_dfe_dprio_busy <= 1'b1;
                    end
                    state <= READ_DATA_STATE;
                end
                else
                begin
                    master_read <= 1'b0;                
                    master_write <= 1'b0;
                    dfe_irq <= 1'b1; // read done
                    alt_dfe_dprio_datain <= master_read_data[15:0];
                    alt_dfe_dprio_busy <= 1'b0;
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

alt_dfe #(  
 .channel_address_width (CLogB2(number_of_reconfig_interfaces*4)),
  .avmm_slave_addr_width (3),
  .avmm_slave_rdata_width ( 32),
  .avmm_slave_wdata_width (32)
)alt_dfe_inst(
  .i_resetn            (~reset),
  .i_avmm_clk          (reconfig_clk),
  .i_avmm_saddress     (dfe_address),
  .i_avmm_sread        (dfe_read),
  .i_avmm_swrite       (dfe_write),
  .i_avmm_swritedata   (dfe_writedata),
//.  i_avmm_sbegintransfer,
  .o_avmm_sreaddata    (dfe_readdata),
  .o_avmm_swaitrequest (dfe_waitrequest),

  .i_remap_address     (alt_dfe_remap_addr),
  .o_quad_address      (alt_dfe_quad_addr),
  .o_reconfig_busy     (alt_dfe_busy),

  .i_dprio_busy        (alt_dfe_dprio_busy),
  .i_dprio_in          (alt_dfe_dprio_datain),
  .o_dprio_wren        (alt_dfe_dprio_wren),
  .o_dprio_rden        (alt_dfe_dprio_rden),
  .o_dprio_addr        (alt_dfe_dprio_addr),
  .o_dprio_data        (alt_dfe_dprio_dataout)
);
alt_mutex_acq #(
	.mutex_wait_time(103), //analog uses 101, offset cancellation uses 102
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
	.master_address(dfe_address_base),
	.master_writedata(dfe_writedata_base),
	.master_write(dfe_write_base),
	.master_read(dfe_read_base),

// these ports are from the base routed to the mutex
	.master_waitrequest(dfe_waitrequest_from_base),
	.master_readdata(dfe_readdata_base),      // from MM

//request signal to the mutex		should be kept high as long as the mutex is being used
	.mutex_req(req_and_use_mutex),
// output from mutex indicates whether you have mutex or not
	.mutex_grant(mutex_grant) 
);	

//wire assignment
assign master_address_shifted = {master_address, {2'b00}};

endmodule

