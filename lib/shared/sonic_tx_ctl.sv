// synthesis translate_off
`timescale 1ns / 1ns
// synthesis translate_on
//
`include "sonic_constants.sv"
// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030

module sonic_tx_ctl (
		     
		     // data
		     input logic wr_clock,
		     input logic rd_clock,
		     input logic reset,
		     input logic [`TX_WRITE_ADDR_WIDTH-1:0] wr_address_owords,
		     input logic wr_req,
		     input logic [127:0] wr_data,
		     output logic [39:0] rd_data,

		     input logic tag_cpl,
		     // prg_reg
		     input  logic tx_prg_wrena,
		     input  logic [31:0] tx_prg_wrdata,
		     input  logic [7:0] tx_prg_addr,
		     output logic [31:0] tx_prg_rddata,

		     output logic [`TX_READ_ADDR_WIDTH-1:0] tx_ring_rptr
		     );
   
   // Signals for circular buffer
   wire tx_empty;
   wire tx_full;
   wire tx_almost_full;
   wire tx_almost_empty;	

   // sonic_tx_circular_buffer 
   sonic_tx_circular_buffer ep_tx_dpram(
					.write_data(wr_data),
					.wr_address_owords(wr_address_owords),
					.wrena(1'b1),	//TODO:fix
					.wrreq(wr_req),
					.rdena(1'b1),   //TODO: fix
					.waitrequest(1'b0),	//TODO:fix
					.tx_ring_rptr (tx_ring_rptr),
					.tag_cpl(tag_cpl),
      
					.reset(reset),
					.rdclock(rd_clock),
					.wrclock(wr_clock),
      
					.data_out(rd_data),
      
					.empty(tx_empty),
					.full(tx_full),
					.almost_full(tx_almost_full),
					.almost_empty(tx_almost_empty)
					);
   defparam ep_tx_dpram.INPUT_WIDTH = 128,
     ep_tx_dpram.BUFFER_WIDTH = 64,
     ep_tx_dpram.OUTPUT_WIDTH = 40;

   // -----------------------------------------------
   //  If nothing to sent, we should signal error
   // -----------------------------------------------

endmodule
