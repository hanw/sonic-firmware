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

module sonic_cmd_ctl #(
	parameter RING_SIZE = 8192,
	parameter USEDW_WIDTH = 13
	)(
	input	clk_in,
	input	rstn,

	// prg_reg interface to RC slave
	input logic				cmd_prg_wrena,
	input logic [31:0]		cmd_prg_wrdata,
	input logic [7:0]		cmd_prg_addr,
	output logic [31:0]		cmd_prg_rddata,

	// Interface to SoNIC hardware
	output reg	soft_resetn,
	output reg	enable_sfp1,
	output reg	enable_sfp2,
	
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
	output                    tx_ready,
	input                     tx_ready_others,

	// interface to irq generator register file
	output logic			  irq_prg_wrena,
	output logic [31:0]		  irq_prg_wrdata,
	output logic [7:0]		  irq_prg_addr,
	input  logic [31:0]		  rx_block_size
	);
	

	localparam RESP_DATA_DWORDS  = 4;
	localparam RESP_DATA_OWORDS  = RESP_DATA_DWORDS/4;	
	reg [63:0] response_data;
	reg [63:0] response_error_code;

	logic reset;
	assign reset = ~rstn;	

	// ----------------------------------------------------
	// Sonic command registers
	// ----------------------------------------------------
	wire init;

	wire [63:0] cmd_base_rc;
	wire		cmd_3dw_rcadd;

	logic			local_prg_wrena;
	logic [31:0]	local_prg_wrdata;
	logic [7:0]		local_prg_addr;

	logic			mux_prg_wrena;
	logic [31:0]	mux_prg_wrdata;
	logic [7:0]		mux_prg_addr;


	wire [31:0]		cmd_type;
	wire [31:0]		cmd_param0;
	wire [31:0]		cmd_param1;
	wire [31:0]		cmd_param2;

	reg [31:0]		cmd_type_reg;
	reg [31:0]		cmd_param0_reg;
	reg [31:0]		cmd_param1_reg;
	reg [31:0]		cmd_param2_reg;

	reg				cmd_done;

	enum int unsigned { IDLE=0, EXECUTE=1, WRITEBACK=2, START_TX_CMD_RESP=3, 
						MWR_REQ_CMD_RESP=4, MWR_DV_CMD_RESP=5} cstate, nstate;

	always @(posedge reset or posedge clk_in) begin
		if(reset == 1'b1) begin
			cmd_type_reg	<= 32'h0;
			cmd_param0_reg	<= 32'h0;
			cmd_param1_reg  <= 32'h0;
			cmd_param2_reg  <= 32'h0;
		end
		else begin
			cmd_type_reg	<= cmd_type;
			cmd_param0_reg  <= cmd_param0;
			cmd_param1_reg  <= cmd_param1;
			cmd_param2_reg  <= cmd_param2;
		end
	end

	sonic_cmd_prg_reg cmd_prg_reg (
		.clk_in(clk_in),
		.rstn(rstn),
		.sonic_cmd_prg_wrena(mux_prg_wrena),
		.sonic_cmd_prg_wrdata(mux_prg_wrdata),
		.sonic_cmd_prg_addr(mux_prg_addr),	
		.sonic_cmd_prg_rddata(cmd_prg_rddata),
		.cmd_base_rc(cmd_base_rc),
		.cmd_3dw_rcadd(cmd_3dw_rcadd),
		.cmd_type(cmd_type),
		.cmd_param0(cmd_param0),
		.cmd_param1(cmd_param1),
		.cmd_param2(cmd_param2),
		.init(init)
	);
	defparam cmd_prg_reg.RC_64BITS_ADDR=1'b1,
			 cmd_prg_reg.AVALON_ST_128=1'b1;

	//-----------------------------------------------------------
	// We clear cmd_type register in writeback stage.
	//-----------------------------------------------------------
	assign local_prg_wrena = 1'b1;
	assign local_prg_wrdata = 32'h0;
	assign local_prg_addr = `SONIC_REG_CMD_DW0;

	assign mux_prg_wrena	= (cstate == WRITEBACK)?local_prg_wrena:cmd_prg_wrena;
	assign mux_prg_wrdata	= (cstate == WRITEBACK)?local_prg_wrdata:cmd_prg_wrdata;
	assign mux_prg_addr		= (cstate == WRITEBACK)?local_prg_addr:cmd_prg_addr;

	// Determine the next state
	always @ ( * ) begin
		case (cstate)
			IDLE:
				if (cmd_type_reg != `SONIC_CMD_NONE) 
					nstate = EXECUTE;
				else
					nstate = IDLE;
			EXECUTE:
				if (cmd_done == 1'b1) 
					nstate = WRITEBACK;
				else 
					nstate = EXECUTE;
			WRITEBACK:
				// Writeback is constant one cycle
				nstate = START_TX_CMD_RESP;
			START_TX_CMD_RESP:
				if ((tx_sel==1'b1) &&	(tx_ws ==1'b0) && (tx_ready_others==1'b0))
					nstate = MWR_REQ_CMD_RESP;
				else
					nstate = START_TX_CMD_RESP;
			MWR_REQ_CMD_RESP:
				if (tx_ack==1'b1)
					nstate = MWR_DV_CMD_RESP;
				else
					nstate = MWR_REQ_CMD_RESP;
			MWR_DV_CMD_RESP:
				if ((tx_ws==1'b0) || (tx_dv==1'b0))
					nstate = IDLE;
				else
					nstate = MWR_DV_CMD_RESP;
			default:
				nstate = IDLE;
		endcase
	end

	always @ (posedge reset or posedge clk_in) begin
		if (reset == 1'b1)
			cstate = IDLE;
		else
			cstate = nstate;
	end

	int cmd_cycle;

	always @ (posedge reset or posedge clk_in) begin
		if (reset == 1'b1) begin
			cmd_done <= 1'b0;
		end
		else if (cstate == IDLE) begin
			cmd_done <= 1'b0;
		end
		else begin
			case(cmd_type_reg) 
				`SONIC_CMD_GET_RX_OFFSET,
				`SONIC_CMD_GET_RX_SIZE,
				`SONIC_CMD_GET_RX_BLOCK_SIZE,
				`SONIC_CMD_GET_TX_OFFSET,
				`SONIC_CMD_GET_TX_SIZE,
				`SONIC_CMD_GET_TX_BLOCK_SIZE,
				`SONIC_CMD_STOP_SFP1,
				`SONIC_CMD_START_SFP1,
				`SONIC_CMD_STOP_SFP2,
				`SONIC_CMD_START_SFP2:
					if (cmd_cycle == 1) begin
						cmd_done <= 1'b1;
					end
				`SONIC_CMD_RESET:
					if (cmd_cycle == 4) begin
						cmd_done <= 1'b1;
					end
				`SONIC_CMD_SET_ADDR_IRQ:
					if (cmd_cycle == 4) begin
						cmd_done <= 1'b1;
					end
				`SONIC_CMD_CONFIG_IRQ:
					if (cmd_cycle == 2) begin
						cmd_done <= 1'b1;
					end
				`SONIC_CMD_SET_RX_BLOCK_SIZE:
					if (cmd_cycle == 2) begin
						cmd_done <= 1'b1;
					end
				default:
					cmd_done <= 1'b1;
			endcase
		end
	end

	// command cycle counter
	always @ (posedge reset or posedge clk_in) begin
		if (reset == 1'b1) 
			cmd_cycle = 0;
		else begin
			if(cstate == EXECUTE)
				cmd_cycle = cmd_cycle+1;
			else
				cmd_cycle = 0;
		end
	end

	// generate a reset signal that is 4 cycle long.
	always @ (posedge clk_in) begin
		if (cstate == EXECUTE) begin
			if (cmd_type_reg == `SONIC_CMD_RESET) begin
				soft_resetn <= 1'b0;
			end
		end
		else begin
			soft_resetn <= 1'b1;
		end
	end	

	always @ (posedge clk_in) begin
		if (reset == 1'b1) begin
			enable_sfp1 <= 1'b0;
			enable_sfp2 <= 1'b0;
		end
		else if (cstate == EXECUTE) begin
			if (cmd_type_reg == `SONIC_CMD_START_SFP1) begin
				enable_sfp1 <= 1'b1;
			end
			else if (cmd_type_reg == `SONIC_CMD_STOP_SFP1) begin
				enable_sfp1 <= 1'b0;
			end

			if (cmd_type_reg == `SONIC_CMD_START_SFP2) begin
				enable_sfp2 <= 1'b1;
			end
			else if (cmd_type_reg == `SONIC_CMD_STOP_SFP2) begin
				enable_sfp2 <= 1'b0;
			end
		end
		else begin
			enable_sfp1 <= enable_sfp1;
			enable_sfp2 <= enable_sfp2;
		end
	end

	always @ (posedge clk_in) begin
		if (cstate == EXECUTE) begin
			if (cmd_type_reg == `SONIC_CMD_SET_ADDR_IRQ) begin
				if ((cmd_cycle == 1) || (cmd_cycle==2)) begin
					irq_prg_wrena <= 1'b1;
					irq_prg_wrdata <= cmd_param0_reg;
					irq_prg_addr <= `SONIC_REG_CNTL_DW1;
				end
				else if ((cmd_cycle==3) || (cmd_cycle==4)) begin
					irq_prg_wrena <= 1'b1;
					irq_prg_wrdata <= cmd_param1_reg;
					irq_prg_addr <= `SONIC_REG_CNTL_DW2;
				end
			end
			else if(cmd_type_reg == `SONIC_CMD_CONFIG_IRQ) begin
				if ((cmd_cycle == 1) || (cmd_cycle==2)) begin
					irq_prg_wrena <= 1'b1;
					irq_prg_wrdata <= cmd_param0_reg;
					irq_prg_addr <= `SONIC_REG_CNTL_DW0;
				end
			end
			else if(cmd_type_reg == `SONIC_CMD_SET_RX_BLOCK_SIZE) begin
				if ((cmd_cycle == 1) || (cmd_cycle==2)) begin
					irq_prg_wrena <= 1'b1;
					irq_prg_wrdata <= cmd_param0_reg;
					irq_prg_addr <= `SONIC_REG_CNTL_DW3;
				end
			end
		end
		else begin
			irq_prg_wrena <= 1'b0;
			irq_prg_wrdata <= 32'h0;
			irq_prg_addr <= 8'h0;
		end
	end
	

	// if the current cmd_type is SONIC_CMD_NONE, clear response data
	always @ (posedge clk_in) begin
		if (cstate == EXECUTE) begin
			case (cmd_type_reg)
			`SONIC_CMD_NONE,
			`SONIC_CMD_GET_RX_OFFSET,
			`SONIC_CMD_GET_TX_OFFSET,
			`SONIC_CMD_START_SFP1,
			`SONIC_CMD_STOP_SFP1,
			`SONIC_CMD_START_SFP2,
			`SONIC_CMD_STOP_SFP2: begin
				response_data <= 64'h0;
				response_error_code <= 64'h0;
			end
			`SONIC_CMD_GET_RX_SIZE: begin
				response_data <= {32'h0, RING_SIZE};
				response_error_code <= 64'h0;
			end
			`SONIC_CMD_GET_RX_BLOCK_SIZE: begin
				response_data <= {32'h0, rx_block_size};
				response_error_code <= 64'h0;
			end
			`SONIC_CMD_GET_TX_SIZE: begin
				response_data <= {32'h0, RING_SIZE};
				response_error_code <= 64'h0;
			end
			`SONIC_CMD_GET_TX_BLOCK_SIZE: begin
				response_data <= 64'h0;
				response_error_code <= 64'h0;
			end
			default: begin
				response_data <= 64'h0;
				response_error_code <= 64'h0;
			end
			endcase
		end
	end

	// ------------------------------------------------------
	// PCIE backend RC update module. For simplicity, we 
	// ------------------------------------------------------
	
	sonic_rc_update rc_update(
		.clk_in(clk_in),
		.rstn(rstn),
		.init(init),
		.tx_req(tx_req),
		.tx_ack(tx_ack),
		.tx_desc(tx_desc),
		.tx_ws(tx_ws),
		.tx_dv(tx_dv),
		.tx_dfr(tx_dfr),
		.tx_data(tx_data),
		.tx_err(tx_err),
		.tx_sel(tx_sel),
		.tx_busy(tx_busy),
		.tx_ready(tx_ready),
		.tx_ready_others(tx_ready_others),
		.cstate(cstate),
		.nstate(nstate),
		.base_rc(cmd_base_rc),
		//VHDL translation_off
		.sfp1_on(enable_sfp1),
		.sfp2_on(enable_sfp2),
		.byte_ready(),
		.byte_sent(),
		.byte_dropped_tx(),
		.byte_dropped_rx(),
		.rx_ring_wptr(),
		.tx_ring_rptr(),
		//VHDL translation_on
		.cmd_response(response_data),
		.cmd_error_code(response_error_code)
	);
	defparam rc_update.START_TX = START_TX_CMD_RESP,
			 rc_update.MWR_REQ = MWR_REQ_CMD_RESP,
			 rc_update.MWR_DV = MWR_DV_CMD_RESP,
			 rc_update.MODE   = `RC_UPD_CMD_MODE;

endmodule
