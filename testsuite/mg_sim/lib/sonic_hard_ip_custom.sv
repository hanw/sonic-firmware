//                              -*- Mode: Verilog -*-
// Filename        : sonic_hard_ip_custom.sv
// Description     : generate bardec and byte-enable signals.
// Author          : hwang
// Created On      : Tue Dec  6 01:12:10 2011
// Last Modified By: hwang
// Last Modified On: Tue Dec  6 01:12:10 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!

/*
 * This module construct the rx_st_be signal from the TLP packets,
 * There is an example that construct the rx_st_be signal from Descriptor/Data interface signals.
 * The difference is that DD signal has rx_be representing the validity of each byte in data.
 * The TLP packet only has First BE and Last BE that deal with first 4DW and last 4DW.
 * The rest of DW are assumed to be valid. 
 * And we need to monitor the sop and eop signal when assigning value to rx_st_be.
 */
module sonic_hard_ip_custom (/*AUTOARG*/
   // Outputs
   tx_st_data_r, tx_st_sop_r, tx_st_eop_r, tx_st_valid_r, tx_st_err_r,
   tx_st_empty_r, tx_st_be, tx_st_bardec,
   // Inputs
   clk_in, rstn, tx_st_data, tx_st_sop, tx_st_eop, tx_st_valid,
   tx_st_err, tx_st_empty
   ) ;

   input         clk_in;   
   input         rstn;
   input [127:0] tx_st_data;
   input 	 tx_st_sop;
   input 	 tx_st_eop;
   input 	 tx_st_valid;
   input 	 tx_st_err;
   input 	 tx_st_empty;
   
   output [127:0] tx_st_data_r;
   output 	  tx_st_sop_r;
   output 	  tx_st_eop_r;
   output 	  tx_st_valid_r;
   output 	  tx_st_err_r;
   output 	  tx_st_empty_r;
   output [15:0]  tx_st_be;
   output [7:0]   tx_st_bardec;

   reg [15:0] 	  tx_st_be;
   reg [127:0] 	  tx_st_data_r;
   reg 		  tx_st_sop_r;
   reg 		  tx_st_eop_r;
   reg 		  tx_st_valid_r;
   reg 		  tx_st_err_r;
   reg 		  tx_st_empty_r;
   reg [7:0] 	  tx_st_bardec;
   reg 		  tx_st_sop_p0;
   reg 		  tx_st_sop_p1;
   reg 		  tx_st_eop_p0;
   reg 		  tx_st_eop_p1;
      
   wire 	 ctrltx_3dw;  // set when TLP is 3dw
   wire [9:0] 	 ctrltx_length;  // set TLP length
   wire 	 ctrltx_payload;
   reg [9:0] 	 ctrltx_count_length_dword;
   wire 	 ctrltx_single_cycle;
   reg [9:0] 	 ctrltx_length_reg;
   reg 		 ctrltx_single_cycle_reg;
   reg 		 ctrltx_payload_reg;
   reg 		 ctrltx_3dw_reg;
   reg 		 ctrltx_dw_addroffset_reg;
   reg [15:0] 	 data_tail_be_mask;
      
   assign ctrltx_single_cycle   =  (tx_st_sop==1'b1) ? ((tx_st_eop==1'b1) ? 1'b1 :1'b0) : ctrltx_single_cycle_reg;
   // ctrltx_payload is set when the TLP has payload,
   assign ctrltx_payload        = ((tx_st_sop==1'b1)&&(tx_st_data[30]==1'b1)) ? 1'b1  : ctrltx_payload_reg;
   // ctrltx_3dw is set when the TLP has 3 DWORD header
   assign ctrltx_3dw            = ((tx_st_sop==1'b1)&&(tx_st_data[29]==1'b0))?1'b1:ctrltx_3dw_reg;
   // ctrltx_lenght equals to length field of TLP
   assign ctrltx_length[9:0]    = (tx_st_sop==1'b1) ?  ((tx_st_data[30]==1'b1) ? tx_st_data[9:0]: 10'h0) : ctrltx_length_reg[9:0];

   always @ (posedge clk_in) begin
      // BYTE ENABLES
      if ((tx_st_sop_p0==1'b1) & (ctrltx_3dw==1'b1)) begin  // 3DW
	 if (ctrltx_single_cycle == 1'b1)
	   tx_st_be <= 16'hffff;
	 else
	   tx_st_be <= 16'hfff;
      end
      else if (ctrltx_3dw==1'b1) begin                      // Subsequent data phases for 3DW header
	 tx_st_be <= data_tail_be_mask;
      end
      else if ((tx_st_sop_p0==1'b1) & (ctrltx_3dw==1'b0))  begin //  First Data Phase for 4DW header
	 tx_st_be <= 16'hffff;
      end
      else if (ctrltx_3dw==1'b0)  begin                       //  Subsequent Data Phase for 4DW header
	 tx_st_be <= data_tail_be_mask;
      end
   end // always @ (clk_in)

   always @ (posedge clk_in) begin

      // BAR 3
      if (tx_st_data[95:64] >= 32'h0024_0000 && tx_st_sop == 1'b1) begin
	 tx_st_bardec <= 8'b0000_1000;
      end
      // Or BAR 2
      else if (tx_st_data[95:64] >= 32'h0020_0000 && tx_st_sop == 1'b1) begin
	 tx_st_bardec <= 8'b0000_0100;
      end
   end
   
   always @(posedge clk_in) begin
      if (rstn == 1'b0) begin
         ctrltx_count_length_dword  <= 0;
      end
      else begin
         // DW unit remaining count
         if (tx_st_sop_p0==1'b1) begin // if current cycle is sop.
            if (ctrltx_payload==1'b1) begin // and if TLP has payload.
	       ctrltx_count_length_dword <= ctrltx_length;
            end
            else begin // if TLP has no payload, set count to zero.
               ctrltx_count_length_dword <= 0;
            end
         end
         else if ((ctrltx_count_length_dword>3)) // if current cycle is not sop, and more than 4DW data available. decrement the count.
           ctrltx_count_length_dword <= ctrltx_count_length_dword - 4;
      end // else: !if(srst==1'b1)
   end

   always @(posedge clk_in) begin
      if (rstn == 1'b0) begin
         ctrltx_single_cycle_reg   <= 1'b0; // 1 cycle delay
         ctrltx_payload_reg        <= 1'b0; // same cycle
         ctrltx_3dw_reg            <= 1'b0; // same cycle
         ctrltx_length_reg         <= 0;    // 1 cycle delay
      end
      else begin
         ctrltx_single_cycle_reg   <= ctrltx_single_cycle;
         ctrltx_length_reg         <= ctrltx_length;

          if (tx_st_sop_p0==1'b1) begin
              ctrltx_3dw_reg           <= (tx_st_data[29]==1'b0) ? 1'b1 : 1'b0;
              ctrltx_payload_reg       <= (tx_st_data[30]==1'b1) ? 1'b1 : 1'b0;
           end
          else if (((ctrltx_single_cycle==1'b1))||
                    ((ctrltx_single_cycle==1'b0)&&(tx_st_eop_p0==1'b1))) begin
              ctrltx_3dw_reg           <=1'b0; // last one cycle longer than ctrltx_3dw;
              ctrltx_payload_reg       <=1'b0; // last one cycle longer than ctrltx_payload;
          end

      end
   end // always @ (posedge clk_in)
   
   assign tx_st_sop_p0 = (tx_st_sop==1'b1) ? 1'b1 : 1'b0;  // generating pulse tx_st_sop_p0, p1
   assign tx_st_eop_p0 = (tx_st_eop==1'b1) ? 1'b1 : 1'b0;  // generating pulse tx_st_eop_p0, p1

   always @ (posedge clk_in) begin
      tx_st_sop_p1 <= tx_st_sop_p0;
      tx_st_eop_p1 <= tx_st_eop_p0;

      tx_st_valid_r <= tx_st_valid;
      tx_st_err_r <= tx_st_err;
      tx_st_sop_r <= tx_st_sop;
      tx_st_eop_r <= tx_st_eop;
      tx_st_data_r <= tx_st_data;
      tx_st_empty_r <= tx_st_empty;
   end
   
   always @ (*) begin
      // create bit significant vector to mask the end of payload data.
      if (ctrltx_count_length_dword[9:2] > 0) begin     // # of payload DWs left to pass to rx_data0 including this cycle is >4 DWs.  This count is already adjusted for addr offsets.
         data_tail_be_mask = 16'hffff;
      end
      else begin                                        // this is the last payload cycle.  mask out non-Payload bytes.
         case (ctrltx_count_length_dword[1:0])
           2'b00: data_tail_be_mask = 16'h0000;
           2'b01: data_tail_be_mask = 16'h000f;
           2'b10: data_tail_be_mask = 16'h00ff;
           2'b11: data_tail_be_mask = 16'h0fff;
         endcase
      end
   end // always @ (*)
endmodule // sonic_hard_ip_custom
