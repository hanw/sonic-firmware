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
module alt_xcvr_reconfig_dfe
#(
	parameter device_family = "Stratix IV",      
    parameter number_of_reconfig_interfaces = 1
)
(
    input wire reconfig_clk,        // this will be the reconfig clk
    input wire reset,
    
    //avalon MM slave
    input wire [2:0] dfe_address,             // MM address
    input wire [31:0] dfe_writedata,
    input wire dfe_write,
    input wire dfe_read,
    
    //output MM slave
    output wire [31:0] dfe_readdata,      // from MM
    output wire        dfe_waitrequest,
    
    output wire dfe_done,
      
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

generate
    if ((device_family == "Stratix IV"))
    begin   
    
        alt_xcvr_reconfig_dfe_tgx 
        #(
    	    .device_family(device_family),      
            .number_of_reconfig_interfaces(number_of_reconfig_interfaces)
        ) dfe_tgx 
        (
            .reconfig_clk(reconfig_clk),
            .reset(reset),
            .dfe_address(dfe_address),
            .dfe_writedata(dfe_writedata),
            .dfe_write(dfe_write),
            .dfe_read(dfe_read),
            .dfe_readdata(dfe_readdata),
            .dfe_waitrequest(dfe_waitrequest),
            .dfe_irq(dfe_done),
            .dfe_irq_from_base(dfe_irq_from_base),
            .dfe_waitrequest_from_base(dfe_waitrequest_from_base),
            .dfe_address_base(dfe_address_base),
            .dfe_writedata_base(dfe_writedata_base),  
            .dfe_write_base(dfe_write_base),
            .dfe_read_base(dfe_read_base),
            .dfe_readdata_base(dfe_readdata_base)
        );

    end else begin
            assign dfe_readdata = 32'b0;
            assign dfe_waitrequest = 1'b0;
            assign dfe_done = 1'b0;
            assign dfe_address_base = 5'b0;
            assign dfe_writedata_base = 32'b0;
            assign dfe_write_base = 1'b0;
            assign dfe_read_base = 1'b0;
    end

endgenerate

endmodule
