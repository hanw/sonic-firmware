//                              -*- Mode: Verilog -*-
// Filename        : sonic_gearbox_66_40.sv
// Description     : gearbox that convert 66 bits input to 40 bits output
// Author          : Han Wang
// Created On      : Tue Nov 22 20:45:30 2011
// Last Modified By: Han Wang
// Last Modified On: Tue Nov 22 20:45:30 2011
// Update Count    : 1
// Status          : Simulated, with zero mem read delay!


/*
 Gearbox, 66 in, 40 out
  '*'     represents valid data
  '-'     represents emptyness
  '[A:B]' is range of output
  when rd_req == 1'b1, shift sr0 to sr1
 
  NOTE: need to consider memory access latency.
        i.e. when rd_req is issued, the data_in may not be available
        until n cycles later.
 
 |State|      sr0  (66 bits)    |        sr1   (66 bits)      |  rd_req  |   shift  |
    0   ***********[39         0] *****************************     1          1
    1   ******************[13  0] [65       40]****************     1          1
    2   ************************* *****[53           14]*******     0          0
    3   **************[27      0] [65:54]**********************     1          1
    4   ********************[1:0] [65             28]**********     1          1
    5   ************************* *********[41            2]***     0          0
    6   *****************[15   0] [65     42]******************     1          1
    7   ************************* ********[55         16]******     0          0
    8   **************[29      0] [65:56]**********************     1          1
    9   ********************[3:0] [65            30]***********     1          1
   10   ************************* **********[43        4]******     0          0
   11   ***************[17     0] [65   44]********************     1          1
   12   ************************* ******[58          18]*******     0          0
   13   *************[31       0] [65  59]*********************     1          1
   14   ********************[5:0] [65            32]***********     1          1
   15   ************************* *********[45         6]******     0          0
   16   ************** [19     0] [65   46]********************     1          1 
   17   ************************* ******[59         20]********     0          0
   18   *************[33       0] [65   60]********************     1          1
   19   ********************[7:0] [65        34]***************     1          1
   20   ************************* *********[47         8]******     0          0
   21   ***************[21     0] [65   48]********************     1          1
   22   ************************* ******[61         22]********     0          0
   23   ***********[35         0] [65:62]**********************     1          1
   24   ********************[9:0] [65         36]**************     1          1
   25   ************************* *******[49          10]******     0          0
   26   **************[23      0] [65   50]********************     1          1
   27   ************************* ***[63           24]*********     0          0
   28   *********[37           0] [65:64] *********************     1          1
   29   *******************[11:0] [65         38]**************     1          1
   30   ************************* *******[51          12]******     0          0
   31   **************[25      0] [65   52]********************     1          1
   32   ************************* [65              26]*********     0          0
 
 We current assume the read latency of memory is zero cycle.
 We used state_r and rd_req for zero cycle memory read.
 Use state_rr and rd_req_r for one cycle memory read delay.
 Use state_rrr and rd_req_r2 for two cycle memory read delay.
 */

module sonic_gearbox_66_40 (/*AUTOARG*/
   // Outputs
   data_out, rd_req_out,
   // Inputs
   data_in, clk_in, reset, ena
   );
   input [65:0]  data_in;
   input 	 clk_in;
   input 	 reset;
   input 	 ena;
   output [39:0] data_out;
   output 	 rd_req_out;

   logic [39:0]  data_out;
      
   reg [6:0] 	 state;
   reg [65:0] 	 sr0, sr1;
   reg 		 rd_req;

   reg [6:0] 	 state_r;
   reg [6:0] 	 state_rr;
   reg [6:0] 	 state_r3;
   reg [6:0] 	 state_r4;
   reg [6:0] 	 state_r5;
   reg [6:0] 	 state_r6;
   
   reg 		 rd_req_r;
   reg 		 rd_req_r2;
   reg 		 rd_req_r3;
   reg 		 rd_req_r4;
   reg 		 rd_req_r5;
   
   assign rd_req_out = rd_req;
   
   /*
    * state_r assumes zero cycle memory read delay.
    * state_rr assume one cycle delay.
    * state_r6 for 5 cycles delay.
    * 
    * NOTE: this must match the rd_req signal for barrel-shifter.
    */
   always @ ( posedge clk_in or negedge ena) begin
      if (~ena) begin
	 data_out <= 40'h0;
      end
      else begin
	 case (state_r6) //NOTE: memory read is 5 cycle.
	   0: data_out <= sr0[39:0];
	   1: data_out <= {sr0[13:0] , sr1[65:40]};
	   2: data_out <= sr1[53:14];
	   3: data_out <= {sr0[27:0] , sr1[65:54]};
	   4: data_out <= {sr0[1:0]  , sr1[65:28]};
	   5: data_out <= sr1[41:2];
	   6: data_out <= {sr0[15:0] , sr1[65:42]};
	   7: data_out <= sr1[55:16];
	   8: data_out <= {sr0[29:0] , sr1[65:56]};
	   9: data_out <= {sr0[3:0]  , sr1[65:30]};
	   10: data_out <= sr1[43:4];
	   11: data_out <= {sr0[17:0] , sr1[65:44]};
	   12: data_out <= sr1[57:18];
	   13: data_out <= {sr0[31:0] , sr1[65:58]};
	   14: data_out <= {sr0[5:0] , sr1[65:32]};
	   15: data_out <= sr1[45:6];
	   16: data_out <= {sr0[19:0] , sr1[65:46]};
	   17: data_out <= sr1[59:20];
	   18: data_out <= {sr0[33:0] , sr1[65:60]};
	   19: data_out <= {sr0[7:0] , sr1[65:34]};
	   20: data_out <= sr1[47:8];
	   21: data_out <= {sr0[21:0] , sr1[65:48]};
	   22: data_out <= sr1[61:22];
	   23: data_out <= {sr0[35:0] , sr1[65:62]};
	   24: data_out <= {sr0[9:0] , sr1[65:36]};
	   25: data_out <= sr1[49:10];
	   26: data_out <= {sr0[23:0] , sr1[65:50]};
	   27: data_out <= sr1[63:24];
	   28: data_out <= {sr0[37:0] , sr1[65:64]};
	   29: data_out <= {sr0[11:0] , sr1[65:38]};
	   30: data_out <= sr1[51:12];
	   31: data_out <= {sr0[25:0] , sr1[65:52]};
	   32: data_out <= sr1[65:26];
	 endcase // case (state)
      end // else: !if(~ena)
   end // always @ (...

   always @ ( posedge clk_in or posedge reset) begin
      if(reset == 1'b1) begin
	 rd_req_r   <= 1'b0;
	 rd_req_r2  <= 1'b0;
	 rd_req_r3 <= 1'b0;
	 rd_req_r4  <= 1'b0;
	 rd_req_r5  <= 1'b0;
	 state_r    <= 7'h0;
	 state_rr   <= 7'h0;
	 state_r3   <= 7'h0;
	 state_r4   <= 7'h0;
	 state_r5   <= 7'h0;
	 state_r6   <= 7'h0;
      end
      else begin
	 rd_req_r   <= rd_req;
	 rd_req_r2  <= rd_req_r;
	 rd_req_r3  <= rd_req_r2;
	 rd_req_r4  <= rd_req_r3;
	 rd_req_r5  <= rd_req_r4;
	 state_r    <= state;
	 state_rr   <= state_r;
	 state_r3   <= state_rr;
	 state_r4   <= state_r3;
	 state_r5   <= state_r4;
	 state_r6   <= state_r5;
      end // else: !if(reset == 1'b1)
   end
   
   always @ ( posedge clk_in or posedge reset) begin
      if (reset == 1'b1) begin
	 rd_req <= 1'b0;
      end
      else begin
	 case (state)
	   0: rd_req <= 1;
	   1: rd_req <= 1;
	   2: rd_req <= 0;
	   3: rd_req <= 1;
	   4: rd_req <= 1;
	   5: rd_req <= 0;
	   6: rd_req <= 1;
	   7: rd_req <= 0;
	   8: rd_req <= 1;
	   9: rd_req <= 1;
	   10: rd_req <= 0;
	   11: rd_req <= 1;
	   12: rd_req <= 0;
	   13: rd_req <= 1;
	   14: rd_req <= 1;
	   15: rd_req <= 0;
	   16: rd_req <= 1;
	   17: rd_req <= 0;
	   18: rd_req <= 1;
	   19: rd_req <= 1;
	   20: rd_req <= 0;
	   21: rd_req <= 1;
	   22: rd_req <= 0;
	   23: rd_req <= 1;
	   24: rd_req <= 1;
	   25: rd_req <= 0;
	   26: rd_req <= 1;
	   27: rd_req <= 0;
	   28: rd_req <= 1;
	   29: rd_req <= 1;
	   30: rd_req <= 0;
	   31: rd_req <= 1;
	   32: rd_req <= 0;
	 endcase // case (state)
      end // else: !if(reset == 1'b1)
   end
   
   always @ ( posedge clk_in or posedge reset) begin
      if (reset == 1'b1) begin
	 sr0 <= 66'h0;
	 sr1 <= 66'h0;
      end
      else begin
	// Read latency is 5 cycles, because of address computation.
	// NOTE: this must match state machine STATE.
	 if (rd_req_r5 == 1'b1) begin 
	    sr0 <= data_in;
	    sr1 <= sr0;
	 end
      end
   end

   always @ ( posedge clk_in or posedge reset or negedge ena) begin
      if (reset | ~ena) begin
	 state <= 7'h0;
      end
      else begin
	 state <= (state[5]) ? 7'h0 : (state + 1'b1);
      end
   end
   
   
endmodule // sonic_gearbox_66_40


//-----------------------------------------------------------------------------------------
// Copyright 2011 Cornell University. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of
// conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
// of conditions and the following disclaimer in the documentation and/or other materials
// provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY CORNELL UNIVERSITY ''AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
// ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// The views and conclusions contained in the software and documentation are those of the
// authors and should not be interpreted as representing official policies, either expressed
// or implied, of Cornell University.
//------------------------------------------------------------------------------------------
