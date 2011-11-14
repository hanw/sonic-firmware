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
module alt_xcvr_reconfig_eyemon
#(
	parameter device_family = "Stratix IV",      
    parameter number_of_reconfig_interfaces = 1
)
(
    input wire reconfig_clk,        // this will be the reconfig clk
    input wire reset,
    
    //avalon MM slave
    input wire [2:0] eyemon_address,             // MM address
    input wire [31:0] eyemon_writedata,
    input wire eyemon_write,
    input wire eyemon_read,
    
    //output MM slave
    output wire [31:0] eyemon_readdata,      // from MM
    output wire        eyemon_waitrequest,   // from MM
    
    output wire eyemon_done,
      
    // input from base_reconfig
    input wire eyemon_irq_from_base,
    input wire eyemon_waitrequest_from_base,
      
    // output to base_reconfig
    // Avalon MM Master
    output wire [4:0] eyemon_address_base,   // 3 bit MM
    output wire [31:0] eyemon_writedata_base,  
    output wire eyemon_write_base,                         // start write to GXB
    output wire eyemon_read_base,                          // start read from GXB
    
    // input from base reconfig
    input wire [31:0] eyemon_readdata_base         // data from read command
    
);

generate 
    if ((device_family == "Stratix IV"))
    begin   
    
        alt_xcvr_reconfig_eyemon_tgx 
        #(
    	    .device_family(device_family),      
            .number_of_reconfig_interfaces(number_of_reconfig_interfaces)
        ) eyemon_tgx 
        (
            .reconfig_clk(reconfig_clk),
            .reset(reset),
            .eyemon_address(eyemon_address),
            .eyemon_writedata(eyemon_writedata),
            .eyemon_write(eyemon_write),
            .eyemon_read(eyemon_read),
            .eyemon_readdata(eyemon_readdata),
            .eyemon_waitrequest(eyemon_waitrequest),
            .eyemon_irq(eyemon_done),
            .eyemon_irq_from_base(eyemon_irq_from_base),
            .eyemon_waitrequest_from_base(eyemon_waitrequest_from_base),
            .eyemon_address_base(eyemon_address_base),
            .eyemon_writedata_base(eyemon_writedata_base),  
            .eyemon_write_base(eyemon_write_base),
            .eyemon_read_base(eyemon_read_base),
            .eyemon_readdata_base(eyemon_readdata_base)
        );
    end else begin
            assign eyemon_readdata = 32'b0;
            assign eyemon_done = 1'b0;
            assign eyemon_address_base = 5'b0;
            assign eyemon_writedata_base = 32'b0;
            assign eyemon_write_base = 1'b0;
            assign eyemon_read_base = 1'b0;
    end

endgenerate

endmodule

