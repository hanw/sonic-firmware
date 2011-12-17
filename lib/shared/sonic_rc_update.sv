// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

`include "sonic_constants.sv"
// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030
//-----------------------------------------------------------------------------
// Title         : 
// Project       : 
//-----------------------------------------------------------------------------
// File          : 
// Author        : 
//-----------------------------------------------------------------------------
// Description :
// 
// 
//-----------------------------------------------------------------------------

module sonic_rc_update #(
	parameter int unsigned START_TX = 0,
	parameter int unsigned MWR_REQ  = 1,
	parameter int unsigned MWR_DV   = 2,
	parameter int unsigned MODE     = `RC_UPD_CMD_MODE,
			 parameter int unsigned PORT_NUM = 0
	)(

	input					  clk_in,
	input					  rstn,
	input					  init,

	//	PCIe backend transmit transmit section
	output                    tx_req,
	input                     tx_ack,
	output     [127:0]        tx_desc,
	input                     tx_ws,
	output reg	              tx_dv,
	output                    tx_dfr,
	output     [127:0]        tx_data,
	output					  tx_err,

	// PCIe arbitration
	input                     tx_sel,
	output reg                tx_busy,
	output reg                tx_ready,
	input                     tx_ready_others,

	// State
	input int unsigned		  cstate,
	input int unsigned		  nstate,

	// RC 
	input logic [63:0]		  base_rc,

	// CMD RC update
	input logic [63:0]		  cmd_response,
	input logic [63:0]		  cmd_error_code,

	// IRQ RC update
	input logic				  sfp1_on,
	input logic				  sfp2_on,
	input logic [23:0]		  byte_ready,
	input logic [31:0]		  byte_sent,
	input logic [31:0]		  byte_dropped_tx,
	input logic [31:0]		  byte_dropped_rx,
	input logic [`RX_WRITE_ADDR_WIDTH-1:0] rx_ring_wptr,
	input logic [`TX_READ_ADDR_WIDTH-1:0] tx_ring_rptr
	);
	
	wire reset;
	assign reset = ~rstn;
	
	localparam DATA_DWORDS = 4;
	localparam DATA_OWORDS = DATA_DWORDS/4;	

   localparam TLP_TC_CLASS = (PORT_NUM == 0) ? `TLP_TC_CLASS_P0 : `TLP_TC_CLASS_P1;
   
	reg		intr_data_upd_cycle;

	reg		tx_dfr_complete;
	wire	tx_dfr_p0;
	wire	tx_ws_val;

	reg  [7:0]   tx_dfr_ow_counter; // o --> octo-word = double qword

	// PCIe Signals RC address
	reg [63:0]  tx_desc_addr ;
	reg addrval_32b_rc;
	wire [7:0]  tx_tag  ;
	wire [3:0]  tx_lbe_d;
	wire [3:0]  tx_fbe_d;

	// control bits : generate tx_dfr & tx_dv
	reg   tx_req_reg;
	wire  tx_req_pulse;
	reg   tx_req_delay ;
	wire  tx_req_p0;
	reg   tx_req_p1 ;
	
	reg [127:0] tx_data_reg;

	// arbitration signals
	always @ (posedge clk_in) begin
		if ((cstate==START_TX) && (tx_ready_others==1'b0))
			tx_ready <= 1'b1;
		else
			tx_ready <= 1'b0;
	end
	//assign tx_ready = ((cstate==START_TX) && (tx_ready_others==1'b0))?1'b1:1'b0;
	
	always @ (posedge clk_in) begin
		if ((nstate==MWR_REQ)|| (nstate==MWR_DV))
			tx_busy <= 1'b1;
		else
			tx_busy <= 1'b0;
	end

	// tx signals
	assign tx_err = 1'b0;
	assign tx_tag   = `ZERO_BYTE;
	assign tx_lbe_d = (intr_data_upd_cycle==1'b0)?4'h0:4'hF;
	assign tx_fbe_d = 4'hF;
	
	// Generation of tx_req
	assign tx_req = ((cstate == MWR_REQ) && (tx_ack==1'b0))?1'b1:1'b0;

	// Generation of tx_data
	assign tx_data = tx_data_reg;
	// --------------------------------------------------------
	// Paremeter 'mode' selects the type of rc_update block.
	// Currently, we support COMMAND_RC_UPD,
	//					and  IRQ_RC_UPD.
	// --------------------------------------------------------
	always @ (posedge clk_in) begin
		if (MODE == `RC_UPD_CMD_MODE) begin
			if(intr_data_upd_cycle==1'b1) begin
				tx_data_reg[127:64] <= cmd_response;	// how many bytes in rx buffer
				tx_data_reg[63:0]   <= cmd_error_code;	// num dropped in tx buffer
			end
			else
				tx_data_reg[127:0] <= 128'h0;
		end
		else if (MODE == `RC_UPD_IRQ_MODE) begin
			if(intr_data_upd_cycle==1'b1) begin
				tx_data_reg[127:96]   <= {{(32-`TX_READ_ADDR_WIDTH){1'b0}}, tx_ring_rptr};		// wptr in tx buffer
				tx_data_reg[95:64]    <= {{(32-`RX_WRITE_ADDR_WIDTH){1'b0}}, rx_ring_wptr};		    // wptr in rx buffer
				tx_data_reg[63:32]	  <= byte_sent;			// how many bytes sent
				tx_data_reg[31:8]	  <= byte_ready;		// how many bytes in rx buffer
				tx_data_reg[7:4]	  <= 4'b0;				// Reserved
				tx_data_reg[3]		  <= sfp1_on;			// SFP1 Stopped
				tx_data_reg[2]		  <= sfp2_on;			// SFP2 Stopped
				tx_data_reg[1]		  <= (byte_ready>0)?1:0;// Data Ready in IRQ
				tx_data_reg[0]		  <= 1'b1;				// Valid IRQ
			end
			else
				tx_data_reg[127:0] <= 128'h0;
		end
	end
			
	// --------------------------------------------
	// tx_desc construction
	// tx_desc[126:125]: 4DW
	// tx_desc[105:96] : 4DW
	// tx_desc[71:64]  : last byte enable
	// tx_desc[63:0]   : intr_data_base_address
	// --------------------------------------------
	assign tx_desc[127]     = `RESERVED_1BIT     ;
	assign tx_desc[126:125] = 
			((intr_data_upd_cycle==1'b1)&&(addrval_32b_rc==1'b0))?`TLP_FMT_4DW_W:
			((intr_data_upd_cycle==1'b1)&&(addrval_32b_rc==1'b1))?`TLP_FMT_3DW_W:
																  `TLP_FMT_4DW_W;
	assign tx_desc[124:120] = `TLP_TYPE_WRITE    ;
	assign tx_desc[119]     = `RESERVED_1BIT     ;
	assign tx_desc[118:116] = TLP_TC_CLASS    ;
	assign tx_desc[115:112] = `RESERVED_4BIT     ;
	assign tx_desc[111]     = `TLP_TD_DEFAULT    ;
	assign tx_desc[110]     = `TLP_EP_DEFAULT    ;
	assign tx_desc[109:108] = `TLP_ATTR_DEFAULT  ;
	assign tx_desc[107:106] = `RESERVED_2BIT     ;
	assign tx_desc[105:96]  = DATA_DWORDS   ;
	assign tx_desc[95:80]   = `ZERO_WORD         ;
	assign tx_desc[79:72]   = tx_tag             ;
	assign tx_desc[71:64]   = {tx_lbe_d, tx_fbe_d};
	assign tx_desc[63:0]    = tx_desc_addr;

	// Generation of tx_dfr signal
	always @ (posedge reset or posedge clk_in) begin
		if (reset == 1'b1) begin
			tx_req_reg <= 1'b0;
		end
		else begin
			if (cstate == START_TX)
				tx_req_reg <= 1'b0;
			else if (tx_req == 1'b1)
				tx_req_reg <= 1'b1;
		end
	end

	assign tx_req_pulse = tx_req & ~tx_req_reg;

	always @ (posedge clk_in)
	begin
	  tx_req_delay  <= tx_req;
	  tx_req_p1   <= tx_req_p0;
	end
	assign tx_req_p0 = tx_req & ~tx_req_delay;
	assign tx_dfr_p0 = tx_req_pulse;
	assign tx_dfr = ((tx_dfr_p0==1'b1)||(tx_dfr_complete==1'b1)) ? 1'b1:1'b0;

	always @ (posedge clk_in) begin
		if ((cstate == MWR_REQ) || (cstate== MWR_DV)) begin
			if (tx_dfr_ow_counter < DATA_OWORDS)
				tx_dfr_complete <= 1'b1;
			else if(tx_ws == 1'b0)
				tx_dfr_complete <= 1'b0;
		end
		else
			tx_dfr_complete <= 1'b0;
	end

	// tx_ws_val_pipe ignores tx_ws on the first pulse
	// of tx_dfr and on the first pulse of tx_dv
	assign tx_ws_val = ((tx_req_p0==1'b1)||(tx_ws==1'b0))?  1'b0:1'b1;

	always @ (posedge clk_in) begin
		if ((cstate == MWR_REQ) || (cstate==MWR_DV)) begin
			if ((tx_ws_val==1'b0)&&(tx_dfr_ow_counter<DATA_OWORDS))
				tx_dfr_ow_counter <= tx_dfr_ow_counter + 1;
		end
		else
			tx_dfr_ow_counter <= 0;
	end

	// Generation of tx_dv signal
	always @ (posedge init or posedge clk_in) begin
		if (init==1'b1)
			tx_dv <= 1'b0;
		else if ((tx_dv==1'b0)||(tx_ws==1'b0))
			tx_dv <= tx_dfr;
	end

	// --------------------------------------------
	// Tx address generation section:
	// we need to consider whether the upper 32-bit
	// of the 64-bit address are zeros.
	// If so, we need to use the 3dw format 
	// tx_descriptor rather than 4dw to conform 
	// with specification.
	// --------------------------------------------
	always @ (posedge init or posedge clk_in) begin
		if (init==1'b1) begin
			tx_desc_addr <= 1'b0;
			addrval_32b_rc <= 1'b0;
		end
		else begin
			if (base_rc[63:32] == `ZERO_DWORD) begin
				tx_desc_addr[63:32] <= base_rc[31:0];
				tx_desc_addr[31:0]  <= 32'h0;
				addrval_32b_rc <= 1'b1;
			end
			else begin
				tx_desc_addr <= base_rc;
				addrval_32b_rc <= 1'b0;
			end
		end
	end	
	
	// --------------------------------------------
	// Generate intr_data_upd_cycle
	// --------------------------------------------
	always @ (posedge clk_in or posedge reset or posedge init) begin
		if ((init == 1'b1) || (reset == 1'b1))
			intr_data_upd_cycle <= 1'b0;
		else begin
			if ((cstate == START_TX) ||
				(cstate == MWR_REQ)  ||
				(cstate == MWR_DV))
				intr_data_upd_cycle <= 1'b1;
			else
				intr_data_upd_cycle <= 1'b0;
		end
	end
endmodule
