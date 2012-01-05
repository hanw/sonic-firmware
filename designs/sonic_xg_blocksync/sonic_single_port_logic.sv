// /**
//  * This Verilog HDL file is used for simulation and synthesis in
//  * the chaining DMA design example. It arbitrates PCI Express packets for
//  * the modules sonic_dma_dt (read or write) and sonic_rc_slave. It
//  * instantiates the Endpoint memory used for the DMA read and write transfer.
//  */
// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on
`include "../../lib/shared/sonic_constants.sv"

// synthesis verilog_input_version verilog_2001
// turn off superfluous verilog processor warnings
// altera message_level Level1
// altera message_off 10034 10035 10036 10037 10230 10240 10030

// TLP Packet constant
`define TLP_FMT_4DW_W        2'b11    // TLP FMT field  -> 64 bits Write
`define TLP_FMT_3DW_W        2'b10    // TLP FMT field  -> 32 bits Write
`define TLP_FMT_4DW_R        2'b01    // TLP FMT field  -> 64 bits Read
`define TLP_FMT_3DW_R        2'b00    // TLP FMT field  -> 32 bits Read

`define TLP_FMT_CPL          2'b00    // TLP FMT field  -> Completion w/o data
`define TLP_FMT_CPLD         2'b10    // TLP FMT field  -> Completion with data

`define TLP_TYPE_WRITE       5'b00000 // TLP Type field -> write
`define TLP_TYPE_READ        5'b00000 // TLP Type field -> read
`define TLP_TYPE_READ_LOCKED 5'b00001 // TLP Type field -> read_lock
`define TLP_TYPE_CPLD        5'b01010 // TLP Type field -> Completion with data
`define TLP_TYPE_IO          5'b00010 // TLP Type field -> IO

`define TLP_TC_DEFAULT       3'b000   // Default TC of the TLP
`define TLP_TC_CLASS_CH_ZERO 3'b001
`define TLP_TC_CLASS_CH_ONE  3'b101
`define TLP_TD_DEFAULT       1'b0     // Default TD of the TLP
`define TLP_EP_DEFAULT       1'b0     // Default EP of the TLP
`define TLP_ATTR_DEFAULT     2'b0     // Default EP of the TLP

`define RESERVED_1BIT        1'b0     // reserved bit on 1 bit
`define RESERVED_2BIT        2'b00    // reserved bit on 1 bit
`define RESERVED_3BIT        3'b000   // reserved bit on 1 bit
`define RESERVED_4BIT        4'b0000  // reserved bit on 1 bit

`define EP_ADDR_READ_OFFSET  16
`define TRANSACTION_ID       3'b000

`define ZERO_QWORD           64'h0000_0000_0000_0000
`define ZERO_DWORD           32'h0000_0000
`define ZERO_WORD            16'h0000
`define ZERO_BYTE            8'h00

`define ONE_QWORD            64'h0000_0000_0000_0001
`define ONE_DWORD            32'h0000_0001
`define ONE_WORD             16'h0001
`define ONE_BYTE             8'h01

`define MINUS_ONE_QWORD      64'hFFFF_FFFF_FFFF_FFFF
`define MINUS_ONE_DWORD      32'hFFFF_FFFF
`define MINUS_ONE_WORD       16'hFFFF
`define MINUS_ONE_BYTE       8'hFF

`define DIRECTION_WRITE      1
`define DIRECTION_READ       0


module sonic_single_port_logic
  #(
    parameter MAX_NUMTAG             = 32,
    parameter AVALON_WADDR           = 12,
    parameter CHECK_BUS_MASTER_ENA   = 0,
    parameter AVALON_WDATA           = 64,
    parameter MAX_PAYLOAD_SIZE_BYTE  = 256,
    parameter BOARD_DEMO             = 0,
    parameter TL_SELECTION           = 0,
    parameter TXCRED_WIDTH           = 36,
    parameter CLK_250_APP            = 0,  // When 1 indicate application clock rate is 250MHz instead of 125 MHz
    parameter RC_64BITS_ADDR         = 0,  // When 1 use 64 bit tx_desc address and not 32
    parameter USE_CREDIT_CTRL        = 0,
    parameter USE_MSI                = 1,  // When 1, tx_arbitration uses tx_cred
    parameter USE_DMAWRITE           = 1,
    parameter USE_DMAREAD            = 1,
    parameter AVALON_ST_128          = 0,
    parameter INTENDED_DEVICE_FAMILY = "Cyclone IV GX",
    parameter CDMA_AST_RXWS_LATENCY  = 2,
    parameter PORT_NUM               = 0
    )(
      input clk_in  ,
      input hw_rstn ,

      input[12:0] cfg_busdev,
      input[31:0] cfg_devcsr,
      input[31:0] cfg_prmcsr,
      input[23:0] cfg_tcvcmap,
      input[31:0] cfg_linkcsr,
      input[15:0] cfg_msicsr,
      input[19:0] ko_cpl_spc_vc0,

      output reg  cpl_pending,
      output[6:0] cpl_err,
      output [127:0] err_desc,

      // MSI signals section
      input       app_msi_ack,
      output      app_msi_req,
      output[2:0] app_msi_tc ,
      output[4:0] app_msi_num,

      // Legacy Interupt signals
      output      app_int_sts,
      input       app_int_ack,

      // Transceiver in/out
      input 		xcvr_rx_clkout,
      input 		xcvr_tx_clkout,
      input  [39:0] xcvr_rx_dataout,
      output [39:0] xcvr_tx_datain,
      input		pma_tx_ready,
      input		pma_rx_ready,
      output		reset_nios,
      output		set_lpbk,
      output		unset_lpbk,

      output [127:0] monitor_out,
      // Receive section channel 0
      output       rx_ack0  ,
      output       rx_mask0 ,
      output       rx_ws0   ,
      input        rx_req0  ,
      input[135:0] rx_desc0 ,
      input[127:0] rx_data0 ,
      input[15:0]  rx_be0,
      input        rx_dv0   ,
      input        rx_dfr0  ,
      input [15:0] rx_ecrc_bad_cnt,

      //transmit section channel 0
      output                   tx_req0 ,
      input                    tx_ack0 ,
      output [127:0]           tx_desc0,
      output                   tx_dv0  ,
      output                   tx_dfr0 ,
      input                    tx_ws0 ,
      output[127:0]            tx_data0,
      output                   tx_err0 ,
      input                    tx_mask0,
      input                    cpld_rx_buffer_ready,
      input [TXCRED_WIDTH-1:0] tx_cred0,
      input [15:0]             rx_buffer_cpl_max_dw,  // specifify the maximum amount of data available in RX Buffer for a given MRd
      input                    tx_stream_ready0,

      // Workaround for controlling BAR3 registers from Channel0.
      inout [31:0] p1_prg_wrdata,           // P0 out, P1 in
      inout [7:0]  p1_prg_addr,             // P0 out, P1 in
      inout [31:0] p1_dma_rd_prg_rddata,    // P0 in,  P1 out
      inout [31:0] p1_dma_wr_prg_rddata,    // P0 in,  P1 out
      inout        p1_dma_rd_prg_wrena,     // P0 out, P1 in
      inout        p1_dma_wr_prg_wrena,     // P0 out, P1 in
      inout [31:0] p1_irq_prg_rddata,       // P0 in,  P1 out
      inout        p1_irq_prg_wrena,        // P0 out, P1 in
      inout [31:0] p1_cmd_prg_rddata,       // P0 in,  P1 out
      inout        p1_cmd_prg_wrena,        // P0 out, P1 in
      inout [15:0] p1_rx_ecrc_bad_cnt,      // P0 in,  P1 out
      inout [63:0] p1_read_dma_status,      // P0 in,  P1 out
      inout [63:0] p1_write_dma_status      // P0 in,  P1 out
      );

   // Local functions

   // VHDL translation_on
   //      function integer get_numwords;
   //         input integer width;
   //         begin
   //            get_numwords = (1<<width);
   //         end
   //     endfunction
   // VHDL translation_off

   wire 		       g_rstn;
   wire 		       sw_rstn;

   assign g_rstn = hw_rstn ;//& sw_rstn;

   // RTL Implementation static parameter
   localparam AVALON_BYTE_WIDTH = AVALON_WDATA/8;  // for epmem byte enables

   localparam FIFO_WIDTHU        = 6;  // Width of FIFO counters
   localparam FIFO_DEPTH         = 64; // Depth of descriptor FIFOs (DMA read and DMA Write)
   localparam RC_SLAVE_USETAG    = 0;  // when set (1) the RC Slave uses the TAG 2
   localparam DMA_READ_PRIORITY  = 1;
   localparam DMA_WRITE_PRIORITY = 1;
   localparam CNT_50MS           =(CLK_250_APP==0)?24'h5F5E10:24'hBEBC20;

   // Legacy interrupt signals
   reg 			       app_int_req;         // legacy interrupt request
   reg 			       app_int_ack_reg;     // boundary reg on legacy interrupt ack input
   wire 		       interrupt_ack_int;   // internal interrupt acknowledge (to interrupt requestor)
   wire 		       msi_enable;          // 1'b1 means MSI is enabled.  1'b0 means Legacy interrupt is enabled.
   reg 			       int_deassert;        // State of Legacy interrupt:  1'b1 means issuing Interrupt DEASSERT message, 1'b0 means issuing Interrupt ASSERT message.


   // AVALON SIGNALS
   wire [AVALON_WDATA-1:0]     writedata_dmard  ;
   wire [AVALON_WADDR-1:0]     address_dmard    ;
   wire 		       write_dmard      ;
   wire 		       waitrequest_dmard;
   wire [AVALON_BYTE_WIDTH-1:0] write_byteena_dmard;  // From DMA Read

   wire [AVALON_WDATA-1:0] 	open_read_data   ;
   wire [AVALON_WDATA-1:0] 	readdata_dmawr   ;
   wire [AVALON_WADDR-1:0] 	address_dmawr    ;
   wire 			read_dmawr       ;
   wire 			waitrequest_dmawr;
   wire [AVALON_BYTE_WIDTH-1:0] write_byteena_dmawr;  // From DMA Write

   wire 			ctl_wr_req;
   wire [31:0] 			ctl_wr_data;
   wire [2:0] 			ctl_addr;

   // Max Payload, Max Read
   reg [15:0] 			cfg_maxpload_dw ;
   reg [15:0] 			cfg_maxrdreq_dw;  // max length of PCIe read in DWORDS
   reg [2:0] 			cfg_maxrdreq_rxbuffer;  // max length of PCIe read in DWORDS based on rx_buffer size
   reg [2:0] 			koh_cfg_maxrdreq;
   reg [2:0] 			kod_cfg_maxrdreq;
   reg [2:0] 			cfg_maxrdreq;
   reg [2:0] 			cfg_maxpload;
   reg [4:0] 			cfg_link_negociated;
   reg [12:0] 			cfg_busdev_reg;
   reg [15:0] 			cfg_msicsr_reg;

   reg [TXCRED_WIDTH-1:0] 	tx_cred0_reg;
   reg 				tx_mask_reg;
   reg 				tx_stream_ready0_reg;

   wire 			dma_rd_prg_wrena;
   wire 			dma_wr_prg_wrena;

   //tracking completion pending
   wire 			cpl_pending_dmawr;
   wire 			cpl_pending_dmard;

   wire [63:0] 			read_dma_status;
   wire [63:0] 			write_dma_status;

   wire [31:0] 			dma_wr_prg_rddata;
   wire [31:0] 			dma_rd_prg_rddata;

   wire [31:0] 			rc_slave_irq_prg_rddata;
   wire [31:0] 			rc_slave_tx_prg_rddata;
   wire [31:0] 			rc_slave_prg_wrdata;
   wire [7:0] 			rc_slave_prg_addr;
   wire 			rc_slave_irq_prg_wrena;
   wire 			rc_slave_tx_prg_wrena;
   // Constant carrying width type for VHDL translation
   wire 			cst_one;
   wire 			cst_zero;
   wire [63:0] 			cst_std_logic_vector_type_one;
   wire [63:0] 			cst_std_logic_vector_type_zero;

   reg 				rx_req_reg;
   reg 				rx_req_p1 ;
   wire 			rx_req_p0;
   // PCI control signals
   reg 				pci_bus_master_enable;
   reg 				pci_mem_addr_space_decoder_enable;
      
   always @ (posedge clk_in) begin
      rx_req_reg <= rx_req0;
      rx_req_p1   <= rx_req_p0;
      pci_bus_master_enable             <= (CHECK_BUS_MASTER_ENA==1)?cfg_prmcsr[2]:1'b1;
      pci_mem_addr_space_decoder_enable <= (CHECK_BUS_MASTER_ENA==1)?cfg_prmcsr[1]:1'b1;
   end
   assign rx_req_p0 = rx_req0 & ~rx_req_reg;


   //------------------------------------------------------------
   // Static side-band signals
   //------------------------------------------------------------
   assign cst_one         = 1'b1;
   assign cst_zero        = 1'b0;
   assign cst_std_logic_vector_type_one  = 64'hFFFF_FFFF_FFFF_FFFF;
   assign cst_std_logic_vector_type_zero = 0;

   always @ (posedge clk_in) begin
      cfg_maxpload_dw[4 :0 ]    <= 0;
      case (cfg_maxpload)
        3'b000 :cfg_maxpload_dw[10:5 ] <= 6'b000001;// 32    ->  128B
        3'b001 :cfg_maxpload_dw[10:5 ] <= 6'b000010;// 64    ->  256B
        3'b010 :cfg_maxpload_dw[10:5 ] <= 6'b000100;// 128   ->  512B
        3'b011 :cfg_maxpload_dw[10:5 ] <= 6'b001000;// 256   -> 1024B
        3'b100 :cfg_maxpload_dw[10:5 ] <= 6'b010000;// 512   -> 2048B
        default:cfg_maxpload_dw[10:5 ] <= 6'b100000;// 1024  -> 4096B
      endcase
      cfg_maxpload_dw[15:11] <= 0;
   end

   always @ (posedge clk_in) begin
      cfg_maxrdreq_dw[4 :0 ] <= 0;
      case (cfg_maxrdreq)
        3'b000 :cfg_maxrdreq_dw[10:5] <= 6'b000001;// 32    ->  128 Bytes
        3'b001 :cfg_maxrdreq_dw[10:5] <= 6'b000010;// 64    ->  256 Bytes
        3'b010 :cfg_maxrdreq_dw[10:5] <= 6'b000100;// 128   ->  512 Bytes
        3'b011 :cfg_maxrdreq_dw[10:5] <= 6'b001000;// 256   -> 1024 Bytes
        3'b100 :cfg_maxrdreq_dw[10:5] <= 6'b010000;// 512   -> 2048 Bytes
        default:cfg_maxrdreq_dw[10:5] <= 6'b100000;// 1024  -> 4096 Bytes
      endcase
      cfg_maxrdreq_dw[15:11] <= 0;
   end

   // Based on ko_cpl_spc_vc0, adjust the size of max read request
   // 1 MRd consume 1 credit header 4 DWORDs
   // Max Read Request should be smaller than
   // cfg_maxrdreq_rxbuffer assume that
   //  - each cpld header consumes 1 credit (4 DWORDS)
   reg [4:0] koh_cfg_compare;
   always @ (posedge clk_in) begin
      // Each header can be broken into RCB 64 byte + 1 if address is not 64 byte aligned
      // 4096 byte payload
      if (ko_cpl_spc_vc0[7:0] > 8'h40) koh_cfg_compare[4] <=1'b1;
      else                             koh_cfg_compare[4] <=1'b0;
      // 2048 byte payload
      if (ko_cpl_spc_vc0[7:0] > 8'h20) koh_cfg_compare[3] <=1'b1;
      else                             koh_cfg_compare[3] <=1'b0;
      // 1024 byte payload
      if (ko_cpl_spc_vc0[7:0] > 8'h10) koh_cfg_compare[2] <=1'b1;
      else                             koh_cfg_compare[2] <=1'b0;
      // 512 byte payload
      if (ko_cpl_spc_vc0[7:0] > 8'h8)  koh_cfg_compare[1] <=1'b1;
      else                             koh_cfg_compare[1] <=1'b0;
      // 256 byte payload
      if (ko_cpl_spc_vc0[7:0] > 8'h4)  koh_cfg_compare[0] <=1'b1;
      else                             koh_cfg_compare[0] <=1'b0;
   end

   reg [4:0] kod_cfg_compare;
   always @ (posedge clk_in) begin
      // Each credit provide 16 bytes
      // 4096 byte payload -> 12'h400 credit
      if (ko_cpl_spc_vc0[19:8] > 12'h400) kod_cfg_compare[4] <=1'b1;
      else                                kod_cfg_compare[4] <=1'b0;
      // 2048 byte payload -> 12'h200 credit
      if (ko_cpl_spc_vc0[19:8] > 12'h200) kod_cfg_compare[3] <=1'b1;
      else                                kod_cfg_compare[3] <=1'b0;
      // 1024 byte payload -> 12'h100 credit
      if (ko_cpl_spc_vc0[19:8] > 12'h100) kod_cfg_compare[2] <=1'b1;
      else                                kod_cfg_compare[2] <=1'b0;
      // 512 byte payload  -> 12'h80  credit
      if (ko_cpl_spc_vc0[19:8] > 12'h80)  kod_cfg_compare[1] <=1'b1;
      else                                kod_cfg_compare[1] <=1'b0;
      // 256 byte payload  -> 12'h40  credit
      if (ko_cpl_spc_vc0[19:8] > 12'h40)  kod_cfg_compare[0] <=1'b1;
      else                                kod_cfg_compare[0] <=1'b0;
   end

   always @ (posedge clk_in) begin
      // Set the max rd req size based on buffer allocation
      if (koh_cfg_compare[4])          koh_cfg_maxrdreq <= 3'h5;
      else if (koh_cfg_compare[3])     koh_cfg_maxrdreq <= 3'h4;
      else if (koh_cfg_compare[2])     koh_cfg_maxrdreq <= 3'h3;
      else if (koh_cfg_compare[1])     koh_cfg_maxrdreq <= 3'h2;
      else if (koh_cfg_compare[0])     koh_cfg_maxrdreq <= 3'h1;
      else                             koh_cfg_maxrdreq <= 3'h0;

      // Set the max rd req size based on data buffer allocation
      if (kod_cfg_compare[4])          kod_cfg_maxrdreq <= 3'h5;
      else if (kod_cfg_compare[3])     kod_cfg_maxrdreq <= 3'h4;
      else if (kod_cfg_compare[2])     kod_cfg_maxrdreq <= 3'h3;
      else if (kod_cfg_compare[1])     kod_cfg_maxrdreq <= 3'h2;
      else if (kod_cfg_compare[0])     kod_cfg_maxrdreq <= 3'h1;
      else                             kod_cfg_maxrdreq <= 3'h0;

      cfg_maxrdreq_rxbuffer <= (koh_cfg_maxrdreq > kod_cfg_maxrdreq) ?
                               kod_cfg_maxrdreq : koh_cfg_maxrdreq;
      cfg_maxrdreq         <= (cfg_maxrdreq_rxbuffer>cfg_devcsr[14:12])?
                              cfg_devcsr[14:12]:cfg_maxrdreq_rxbuffer;
   end

   //pipelined
   always @ (posedge clk_in) begin
      cfg_link_negociated[4:0]<= cfg_linkcsr[24:20] ;
      cfg_maxpload[2:0]       <= cfg_devcsr[7:5]   ;
      tx_mask_reg             <= tx_mask0;
      tx_stream_ready0_reg    <= tx_stream_ready0;
      tx_cred0_reg            <= tx_cred0;
      cfg_busdev_reg          <= cfg_busdev;
      cfg_msicsr_reg          <= cfg_msicsr;
   end

   // unused
   assign rx_mask0  = 1'b0;

   //------------------------------------------------------------
   //    DMA Write SECTION
   //       - suffix _dmawr
   //------------------------------------------------------------
   // rx
   wire          rx_ack_dmawr;
   wire          rx_ws_dmawr;

   // tx
   wire          tx_req_dmawr;
   wire [127:0]  tx_desc_dmawr;
   wire          tx_err_dmawr;
   wire          tx_dv_dmawr;
   wire          tx_dfr_dmawr;
   wire [127:0]  tx_data_dmawr;

   reg 		 tx_sel_descriptor_dmawr  ;
   wire          tx_busy_descriptor_dmawr ;
   wire          tx_ready_descriptor_dmawr;
   reg           tx_ready_descriptor_dmawr_r;

   reg 		 tx_sel_requester_dmawr  ;
   wire          tx_busy_requester_dmawr ;
   wire          tx_ready_requester_dmawr;
   reg           tx_ready_requester_dmawr_r;

   reg 		 tx_sel_dmawr;
   wire          tx_ready_dmawr;
   wire 	 tx_sel_dmard;
   wire          tx_ready_dmard;
   wire          tx_stop_dma_write;

   wire          requester_mrdmwr_cycle_dmawr;
   wire          descriptor_mrd_cycle_dmawr;
   wire          init_dmawr     ;
   wire [10:0] 	 sm_dmawr   ;

   wire 	 app_msi_req_dmawr;
   wire [2:0] 	 app_msi_tc_dmawr;
   wire [4:0] 	 app_msi_num_dmawr;
   wire 	 msi_ready_dmawr  ;
   wire 	 msi_busy_dmawr   ;
   reg 		 msi_sel_dmawr    ;

   wire 	 tx_rdy_descriptor_dmawr;
   wire 	 tx_rdy_requester_dmawr ;
   wire 	 tx_rdy_descriptor_dmard;
   wire 	 tx_rdy_requester_dmard ;
   wire 	 tx_rdy_interrupt;
   wire 	 tx_rdy_command;

   wire [`RX_WRITE_ADDR_WIDTH-1:0] rx_ring_wptr;
   wire [`TX_READ_ADDR_WIDTH-1:0]  tx_ring_rptr;
   wire 			   dma_fifo_wrreq;

   sonic_dma_dt  #(
		   .DIRECTION      (`DIRECTION_WRITE),
		   .FIFO_WIDTHU    (FIFO_WIDTHU     ),
		   .FIFO_DEPTH     (FIFO_DEPTH      ),
		   .USE_CREDIT_CTRL(USE_CREDIT_CTRL ),
		   .USE_MSI        (USE_MSI         ),
		   .RC_SLAVE_USETAG(RC_SLAVE_USETAG ),
		   .USE_DMAWRITE   (USE_DMAWRITE),
		   .USE_DMAREAD    (USE_DMAREAD ),
		   .TXCRED_WIDTH   (TXCRED_WIDTH    ),
		   .BOARD_DEMO     (BOARD_DEMO    ),
		   .MAX_PAYLOAD    (MAX_PAYLOAD_SIZE_BYTE  ),
		   .RC_64BITS_ADDR (RC_64BITS_ADDR  ),
		   .MAX_NUMTAG     (MAX_NUMTAG      ),
		   .AVALON_WADDR   (AVALON_WADDR    ),
		   .TL_SELECTION   (TL_SELECTION    ),
		   .AVALON_ST_128  (AVALON_ST_128   ),
		   .INTENDED_DEVICE_FAMILY (INTENDED_DEVICE_FAMILY),
		   .AVALON_WDATA   (AVALON_WDATA    ),
		   .CDMA_AST_RXWS_LATENCY (CDMA_AST_RXWS_LATENCY),
		   .PORT_NUM (PORT_NUM)
		   )
   dma_write
     (
      .clk_in         (clk_in       ),
      .rstn           (g_rstn         ),
      .sw_rstn        (sw_rstn), //DEBUG, to be removed.
      .ctl_wr_req    (ctl_wr_req),
      .ctl_wr_data   (ctl_wr_data),
      .ctl_addr      (ctl_addr),

      .rx_req        (rx_req0 ),
      .rx_req_p0     (rx_req_p0),
      .rx_req_p1     (rx_req_p1),
      .rx_ack        (rx_ack_dmawr  ),
      .rx_desc       (rx_desc0 ),
      .rx_data       (rx_data0),
      .rx_ws         (rx_ws_dmawr  ),
      .rx_dv         (rx_dv0   ),
      .rx_dfr        (rx_dfr0  ),

      .tx_sel_descriptor        (tx_sel_descriptor_dmawr  ),
      .tx_busy_descriptor       (tx_busy_descriptor_dmawr ),
      .tx_ready_descriptor      (tx_ready_descriptor_dmawr),

      .tx_sel_requester        (tx_sel_requester_dmawr  ),
      .tx_busy_requester       (tx_busy_requester_dmawr ),
      .tx_ready_requester      (tx_ready_requester_dmawr),

      .tx_ready_other_dma      (tx_ready_dmard || tx_ready_interrupt || tx_ready_command),

      .tx_req        (tx_req_dmawr  ),
      .tx_ack        (tx_ack0  ),
      .tx_desc       (tx_desc_dmawr ),
      .tx_ws         (tx_ws0   ),
      .tx_err        (tx_err_dmawr  ),
      .tx_dv         (tx_dv_dmawr   ),
      .tx_dfr        (tx_dfr_dmawr  ),
      .tx_data       (tx_data_dmawr ),
      .rx_buffer_cpl_max_dw(rx_buffer_cpl_max_dw),

      .app_msi_ack   (interrupt_ack_int),
      .app_msi_req   (app_msi_req_dmawr),
      .app_msi_tc    (app_msi_tc_dmawr ),
      .app_msi_num   (app_msi_num_dmawr),
      .msi_ready     (msi_ready_dmawr),
      .msi_busy      ( msi_busy_dmawr),
      .msi_sel       (  msi_sel_dmawr),

      .tx_cred          (tx_cred0_reg      ),
      .tx_have_creds    (1'b0),
      .cfg_maxpload_dw  (cfg_maxpload_dw),
      .cfg_maxrdreq_dw  (cfg_maxrdreq_dw),
      .cfg_maxpload     (cfg_maxpload  ),
      .cfg_maxrdreq     (cfg_maxrdreq  ),
      .cfg_busdev       (cfg_busdev_reg    ),
      .cfg_link_negociated    (cfg_link_negociated    ),

      .requester_mrdmwr_cycle   (requester_mrdmwr_cycle_dmawr),
      .descriptor_mrd_cycle     (descriptor_mrd_cycle_dmawr),
      .init          (init_dmawr         ),

      .dma_sm  (sm_dmawr),

      .dma_prg_wrdata   (rc_slave_prg_wrdata),
      .dma_prg_addr     (rc_slave_prg_addr),
      .dma_prg_wrena    (dma_wr_prg_wrena),
      .dma_prg_rddata   (dma_wr_prg_rddata),

      .dma_status (write_dma_status),
      .cpl_pending (cpl_pending_dmawr),

      //VHDL translation_off
      .tag_cpl(),
      .rx_be(),
      .write_data(),
      .write_address(),
      .write(),
      .write_wait(),
      //VHDL translation_on
      
      // Avalon Read Master port
      .read_address  (address_dmawr    ),
      .read_wait     (waitrequest_dmawr),	//TODO: fixme
      .read          (read_dmawr       ),
      .read_data     (readdata_dmawr   ),
      .dma_fifo_wrreq(dma_fifo_wrreq),
      .write_byteena  (write_byteena_dmawr)	//TODO: fixme
      );

   // ----------------------------------------------------------
   // SoNIC command interface controller
   // Note: receives commands through RC downstream intf,
   // Decode and execute the command, then send the response via 
   // PCIe tx intf.
   // ----------------------------------------------------------	
   wire 			   tx_req_command;
   wire [127:0] 		   tx_desc_command;
   wire 			   tx_dfr_command;
   wire 			   tx_dv_command;
   wire [127:0] 		   tx_data_command;
   wire 			   tx_err_command;

   reg 				   tx_sel_command;
   wire 			   tx_busy_command;
   wire 			   tx_ready_command;
   reg 				   tx_ready_command_r;
   wire 			   tx_ready_command_others;
   
   wire 			   tx_req_interrupt;
   wire [127:0] 		   tx_desc_interrupt;
   wire 			   tx_dfr_interrupt;
   wire 			   tx_dv_interrupt;
   wire [127:0] 		   tx_data_interrupt;
   wire 			   tx_err_interrupt;

   reg 				   tx_sel_interrupt;
   wire 			   tx_busy_interrupt;
   wire 			   tx_ready_interrupt;
   reg 				   tx_ready_interrupt_r;
   wire 			   tx_ready_interrupt_others;

   wire 			   app_msi_req_interrupt;
   wire [2:0] 			   app_msi_tc_interrupt;
   wire [4:0] 			   app_msi_num_interrupt;
   reg 				   msi_sel_interrupt;
   wire 			   msi_ready_interrupt;
   wire 			   msi_busy_interrupt;
   
   wire [31:0] 			   cmd_prg_rddata;
   wire 			   cmd_prg_wrena;
   wire [31:0] 			   cmd_ctl_irq_prg_wrdata;
   wire 			   cmd_ctl_irq_prg_wrena;
   wire [7:0] 			   cmd_ctl_irq_prg_addr;
   wire [31:0] 			   rx_block_size;


   wire 			   enable_sfp1;

   /*
    * Command handling module, manage the command interface
    *
    */

   sonic_cmd_ctl sonic_cmd (
			    .clk_in(clk_in),
			    .rstn(hw_rstn),
			    // cmd module register intf
			    .cmd_prg_wrena(cmd_prg_wrena),
			    .cmd_prg_wrdata(rc_slave_prg_wrdata),		
			    .cmd_prg_addr(rc_slave_prg_addr),			
			    .cmd_prg_rddata(cmd_prg_rddata),	
			    // SoNIC hardware intf
			    .soft_resetn(sw_rstn),
			    .enable_sfp1(enable_sfp1),
			    .enable_sfp2(),
			    .reset_nios(reset_nios),
			    .set_lpbk(set_lpbk),
			    .unset_lpbk(unset_lpbk),
			    // PCIe backend
			    .tx_req(tx_req_command),
			    .tx_ack(tx_ack0),
			    .tx_desc(tx_desc_command),
			    .tx_ws(tx_ws0),
			    .tx_dv(tx_dv_command),
			    .tx_dfr(tx_dfr_command),
			    .tx_data(tx_data_command),
			    .tx_err(tx_err_command),
			    // PCIe arbitration
			    .tx_sel(tx_sel_command),
			    .tx_busy(tx_busy_command),
			    .tx_ready(tx_ready_command),
			    .tx_ready_others(tx_ready_command_others),
			    // irq register intf
			    .irq_prg_wrena(cmd_ctl_irq_prg_wrena),
			    .irq_prg_wrdata(cmd_ctl_irq_prg_wrdata),
			    .irq_prg_addr(cmd_ctl_irq_prg_addr),
			    .rx_block_size(rx_block_size)
			    );
   defparam sonic_cmd.RING_SIZE = `RING_DEPTH_OWORDS,
     sonic_cmd.PORT_NUM = PORT_NUM;	

   wire 			   rx_ctl_irq_prg_wrena;
   wire [31:0] 			   rx_ctl_irq_prg_wrdata;
   wire [7:0] 			   rx_ctl_irq_prg_addr;
   
   assign rx_ctl_irq_prg_wrena = (cmd_ctl_irq_prg_wrena == 1'b1)? cmd_ctl_irq_prg_wrena:
				 rc_slave_irq_prg_wrena;
   assign rx_ctl_irq_prg_wrdata = (cmd_ctl_irq_prg_wrena == 1'b1)? cmd_ctl_irq_prg_wrdata:
				  rc_slave_prg_wrdata;
   assign rx_ctl_irq_prg_addr  = (cmd_ctl_irq_prg_wrena == 1'b1)? cmd_ctl_irq_prg_addr:
				 rc_slave_prg_addr;

   /*
    *
    * IRQ control module, manages the MSI IRQ generation
    * for Rx module and command response.
    *
    */
   

   sonic_irq_ctl sonic_irq (
			    .clk_in(clk_in),
			    .reset(~hw_rstn),
			    .tx_req(tx_req_interrupt),
			    .tx_ack(tx_ack0),
			    .tx_desc(tx_desc_interrupt),
			    .tx_ws(tx_ws0),
			    .tx_dfr(tx_dfr_interrupt),
			    .tx_dv(tx_dv_interrupt),
			    .tx_data(tx_data_interrupt),
			    .tx_err(tx_err_interrupt),
			    .tx_sel(tx_sel_interrupt),
			    .tx_busy(tx_busy_interrupt),
			    .tx_ready(tx_ready_interrupt),
			    .tx_ready_others(tx_ready_interrupt_others),
			    .app_msi_ack(interrupt_ack_int),
			    .app_msi_req(app_msi_req_interrupt),
			    .app_msi_tc(app_msi_tc_interrupt),
			    .app_msi_num(app_msi_num_interrupt),
			    .msi_sel(msi_sel_interrupt),
			    .msi_ready(msi_ready_interrupt),
			    .msi_busy(msi_busy_interrupt),
			    .enable_sfp(enable_sfp1),
			    .rd_req (dma_fifo_wrreq),
			    .irq_prg_wrena(rx_ctl_irq_prg_wrena),
			    .irq_prg_wrdata(rx_ctl_irq_prg_wrdata),
			    .irq_prg_addr(rx_ctl_irq_prg_addr),
			    .irq_prg_rddata(rc_slave_irq_prg_rddata),
			    .rx_ring_wptr (rx_ring_wptr),
			    .rx_block_size(rx_block_size),
			    .tx_ring_rptr(tx_ring_rptr),
			    .force_flush_rc(~sw_rstn)
			    );
   defparam sonic_irq.PORT_NUM = PORT_NUM;

   // Monitor Signal, see Documentation.
   assign monitor_out = {enable_sfp1, 1'b0 , tx_ring_rptr, pma_rx_ready, pma_tx_ready, rx_ring_wptr,
                         32'h0,
                         32'h0,
                         32'h0
                         };
   
   /*
    *
    *  Rx Channel 66-bit version
    *  Note: the pma_rx_ready signal is not high, until we have send some data to
    *  the PMA module, therefore the Rx is always ready after the Tx module.
    *
    */

   /*
    * Synchronized reset
    */
   reg 				   rx_ctl_reset;
   always @ (posedge clk_in) begin
      rx_ctl_reset <= ~hw_rstn | ~sw_rstn;
   end
      
   sonic_rx_chan_66 sonic_rx_buf (
				  .data_in(xcvr_rx_dataout),
				  .data_out(readdata_dmawr),
				  .rd_clock(clk_in),	
				  .wr_clock(xcvr_rx_clkout), //synch with data
				  .reset(rx_ctl_reset),      
				  .rd_address(address_dmawr),
				  .enable_sfp(enable_sfp1),
				  .xcvr_rx_ready(pma_rx_ready),

				  // Data read from EP into wrfifo in write_requester.
				  // this signal is high when dma send data to RC.
				  .dma_rdreq(dma_fifo_wrreq),
      
				  .rx_ring_wptr (rx_ring_wptr)
				  //.reset(~g_rstn), 
				  //FIX: for testing purpose, we remove the reset from pma_rx_ready,
				  //As a result, the interrupt will be generated as
				  //soon as the enable_sfp is set. The ring should
				  //be written constantly, the output data won't be
				  //correct, but the interrupt should work fine.
				  );

   /*
    * Tx Channel 66-bit version
    * pma_tx_ready is set on start.
    */

   wire 			   tag_cpl;

   reg 				   tx_ctl_reset;
   always @ (posedge clk_in) begin
      tx_ctl_reset <= ~hw_rstn | ~sw_rstn;
   end
   
   sonic_tx_chan_66 sonic_tx_buf(
				 .data_in(writedata_dmard),
				 .data_out(xcvr_tx_datain),
				 .rd_clock(xcvr_tx_clkout), //sync with data_out
				 .wr_clock(clk_in),         //sync with data_in
				 .reset(tx_ctl_reset),
      
				 .wr_address(address_dmard),
				 .wrreq(write_dmard),
				 .enable_sfp(enable_sfp1),
				 .xcvr_tx_ready(pma_tx_ready),
				 .tag_cpl(tag_cpl),
				 .tx_ring_rptr (tx_ring_rptr)
				 );
   
   //------------------------------------------------------------
   //    DMA READ SECTION
   //       - suffix _dmard
   //------------------------------------------------------------
   // RX
   wire 			   rx_ack_dmard  ;
   wire 			   rx_ws_dmard   ;

   // TX
   wire 			   tx_req_dmard  ;
   wire [127:0] 		   tx_desc_dmard ;
   wire 			   tx_err_dmard  ;
   wire 			   tx_dv_dmard   ;
   wire 			   tx_dfr_dmard  ;
   wire [127:0] 		   tx_data_dmard ;

   reg 				   tx_sel_descriptor_dmard;
   wire 			   tx_busy_descriptor_dmard ;
   wire 			   tx_ready_descriptor_dmard;
   reg 				   tx_ready_descriptor_dmard_r;

   reg 				   tx_sel_requester_dmard;
   wire 			   tx_busy_requester_dmard ;
   wire 			   tx_ready_requester_dmard;
   reg 				   tx_ready_requester_dmard_r;

   //MSI
   wire 			   app_msi_req_dmard;
   wire [2:0] 			   app_msi_tc_dmard ;
   wire [4:0] 			   app_msi_num_dmard;
   wire 			   msi_ready_dmard  ;
   wire 			   msi_busy_dmard   ;
   reg 				   msi_sel_dmard    ;

   // control signal
   wire 			   requester_mrdmwr_cycle_dmard;
   wire 			   descriptor_mrd_cycle_dmard;
   wire 			   init_dmard         ;
   wire [10:0] 			   sm_dmard   ;
   reg 				   tx_req_dmard_reg;
   reg 				   tx_req_dmawr_reg;

   always @ (posedge clk_in or negedge g_rstn) begin
      if (g_rstn == 1'b0) begin
         tx_req_dmard_reg <= 1'b0;
         tx_req_dmawr_reg <= 1'b0;
      end
      else begin
         tx_req_dmard_reg <= tx_req_dmard;
         tx_req_dmawr_reg <= tx_req_dmawr;
      end
   end

   sonic_dma_dt  #(
		   .DIRECTION       (`DIRECTION_READ  ),
		   .RC_64BITS_ADDR  ( RC_64BITS_ADDR  ),
		   .MAX_NUMTAG      ( MAX_NUMTAG      ),
		   .FIFO_WIDTHU     ( FIFO_WIDTHU     ),
		   .FIFO_DEPTH      ( FIFO_DEPTH      ),
		   .USE_CREDIT_CTRL ( USE_CREDIT_CTRL ),
		   .BOARD_DEMO      ( BOARD_DEMO      ),
		   .USE_MSI         ( USE_MSI         ),
		   .USE_DMAWRITE    ( USE_DMAWRITE    ),
		   .USE_DMAREAD     ( USE_DMAREAD     ),
		   .RC_SLAVE_USETAG ( RC_SLAVE_USETAG ),
		   .TXCRED_WIDTH    ( TXCRED_WIDTH    ),
		   .AVALON_WADDR    ( AVALON_WADDR    ),
		   .AVALON_ST_128   ( AVALON_ST_128   ),
		   .AVALON_WDATA    ( AVALON_WDATA    ),
		   .CDMA_AST_RXWS_LATENCY (CDMA_AST_RXWS_LATENCY),
		   .PORT_NUM (PORT_NUM)
		   )
   dma_read
     (
      .clk_in        (clk_in        ),
      .rstn          (g_rstn          ),
      .sw_rstn       (sw_rstn), //DEBUG: to be removed.
      
      .ctl_wr_req    (ctl_wr_req),
      .ctl_wr_data   (ctl_wr_data),
      .ctl_addr      (ctl_addr),

      .rx_req        (rx_req0  ),
      .rx_req_p0     (rx_req_p0),
      .rx_req_p1     (rx_req_p1),
      .rx_ack        (rx_ack_dmard  ),
      .rx_desc       (rx_desc0 ),
      .rx_data       (rx_data0),
      .rx_be         (rx_be0),
      .rx_ws         (rx_ws_dmard   ),
      .rx_dv         (rx_dv0   ),
      .rx_dfr        (rx_dfr0  ),

      .tx_sel_descriptor        (tx_sel_descriptor_dmard  ),
      .tx_busy_descriptor       (tx_busy_descriptor_dmard ),
      .tx_ready_descriptor      (tx_ready_descriptor_dmard),

      .tx_sel_requester        (tx_sel_requester_dmard  ),
      .tx_busy_requester       (tx_busy_requester_dmard ),
      .tx_ready_requester      (tx_ready_requester_dmard),

      //DMA read only checks IRQ and COMMAND
      //DMA write checks DMA read, IRQ and COMMAND.
      //If all ready at the same time, the default order is IRQ, DMA read, DMA write.
      .tx_ready_other_dma      (tx_ready_interrupt || tx_ready_command),

      .rx_buffer_cpl_max_dw(rx_buffer_cpl_max_dw),
      .tx_cred       (tx_cred0_reg      ),
      .tx_have_creds (1'b0),
      .tx_req        (tx_req_dmard  ),
      .tx_ack        (tx_ack0  ),
      .tx_desc       (tx_desc_dmard ),
      .tx_ws         (tx_ws0   ),
      .tx_err        (tx_err_dmard  ),
      .tx_dv         (tx_dv_dmard   ),
      .tx_dfr        (tx_dfr_dmard  ),
      .tx_data       (tx_data_dmard ),

      .cfg_maxpload_dw  (cfg_maxpload_dw),
      .cfg_maxpload     (cfg_maxpload),
      .cfg_maxrdreq_dw  (cfg_maxrdreq_dw),
      .cfg_maxrdreq     (cfg_maxrdreq),
      .cfg_busdev       (cfg_busdev_reg),
      .cfg_link_negociated (cfg_link_negociated),

      .requester_mrdmwr_cycle   (requester_mrdmwr_cycle_dmard),
      .descriptor_mrd_cycle     (descriptor_mrd_cycle_dmard),
      .init                     (init_dmard    ),

      .app_msi_ack   (interrupt_ack_int   ),
      .app_msi_req   (app_msi_req_dmard),
      .app_msi_tc    (app_msi_tc_dmard ),
      .app_msi_num   (app_msi_num_dmard),
      .msi_ready     (msi_ready_dmard  ),
      .msi_busy      (msi_busy_dmard   ),
      .msi_sel       (msi_sel_dmard    ),

      .dma_sm         (sm_dmard),

      .dma_prg_wrdata   (rc_slave_prg_wrdata),
      .dma_prg_addr     (rc_slave_prg_addr),
      .dma_prg_wrena    (dma_rd_prg_wrena),
      .dma_prg_rddata (dma_rd_prg_rddata),

      .dma_status       (read_dma_status),
      .cpl_pending      (cpl_pending_dmard),
      .tag_cpl			 (tag_cpl),

      //VHDL translation_off
      .read_address	(),
      .read			(),
      .read_wait		(),
      .dma_fifo_wrreq  (),
      //VHDL translation_on

      // Avalon Write Master port
      .read_data      (open_read_data   ),
      .write_address  (address_dmard    ),
      .write_wait     (waitrequest_dmard),
      .write          (write_dmard      ),
      .write_data     (writedata_dmard  ),
      .write_byteena  (write_byteena_dmard)
      );

   //------------------------------------------------------------
   //RC Slave Section
   //       - suffix _pcnt
   //------------------------------------------------------------
   wire          rx_req_pcnt ;
   wire          rx_ack_pcnt ;
   wire [135:0]  rx_desc_pcnt;
   wire [63:0] 	 rx_data_pcnt;
   wire          rx_ws_pcnt  ;
   wire          rx_dv_pcnt  ;
   wire          rx_dfr_pcnt ;

   // TX
   wire          tx_req_pcnt  ;
   wire          tx_ack_pcnt  ;
   wire [127:0]  tx_desc_pcnt ;
   wire          tx_ws_pcnt   ;
   wire          tx_err_pcnt  ;
   wire          tx_dv_pcnt   ;
   wire          tx_dfr_pcnt  ;
   wire [127:0]  tx_data_pcnt ;
   reg 		 tx_sel_pcnt  ;
   wire          tx_busy_pcnt ;
   wire          tx_ready_pcnt;

   wire 	 tx_dv_dmard_mux  ;
   wire 	 tx_dfr_dmard_mux ;
   wire 	 tx_req_dmard_mux ;
   wire 	 tx_err_dmard_mux ;
   wire [127:0]  tx_desc_dmard_mux;
   wire [127:0]  tx_data_dmard_mux;


   wire 	 tx_sel_slave;

   assign          tx_err_pcnt = 1'b0;

   assign tx_sel_slave = tx_sel_pcnt;

   assign tx_dv_dmard_mux  =(tx_sel_slave==1'b0)?tx_dv_dmard:tx_dv_pcnt;
   assign tx_dfr_dmard_mux =(tx_sel_slave==1'b0)?tx_dfr_dmard:tx_dfr_pcnt;
   assign tx_req_dmard_mux =(tx_sel_slave==1'b0)?tx_req_dmard:tx_req_pcnt;
   assign tx_err_dmard_mux =(tx_sel_slave==1'b0)?tx_err_dmard:tx_err_pcnt;
   assign tx_data_dmard_mux=(tx_sel_slave==1'b0)?tx_data_dmard:tx_data_pcnt;
   assign tx_desc_dmard_mux=(tx_sel_slave==1'b0)?tx_desc_dmard:tx_desc_pcnt;


   /*
    * Generate the tri-state buffer for TC workaround.
    * 
    */
   wire [31:0] 	 prg_wrdata_p1;
   wire [7:0] 	 prg_addr_p1;
   wire 	 dma_rd_prg_wrena_p1;
   wire 	 dma_wr_prg_wrena_p1;
   wire 	 irq_prg_wrena_p1;
   wire 	 cmd_prg_wrena_p1;
   wire [31:0] 	 dma_rd_prg_rddata_p1;
   wire [31:0]	 dma_wr_prg_rddata_p1;
   wire [31:0]	 irq_prg_rddata_p1;
   wire [31:0]	 cmd_prg_rddata_p1;
   wire [15:0]	 rx_ecrc_bad_cnt_p1;
   wire [63:0]	 read_dma_status_p1;
   wire [63:0]	 write_dma_status_p1;
      
   assign p1_prg_wrdata = (PORT_NUM == 0) ? prg_wrdata_p1 : 32'bZ;
   assign p1_prg_addr   = (PORT_NUM == 0) ? prg_addr_p1   : 8'bZ;
   assign p1_dma_rd_prg_wrena = (PORT_NUM == 0) ? dma_rd_prg_wrena_p1 : 1'bZ;
   assign p1_dma_wr_prg_wrena = (PORT_NUM == 0) ? dma_wr_prg_wrena_p1 : 1'bZ;
   assign p1_irq_prg_wrena    = (PORT_NUM == 0) ? irq_prg_wrena_p1    : 1'bZ;
   assign p1_cmd_prg_wrena    = (PORT_NUM == 0) ? cmd_prg_wrena_p1    : 1'bZ;
   
   assign p1_dma_rd_prg_rddata = (PORT_NUM == 1) ? dma_rd_prg_rddata : 32'bZ;
   assign p1_dma_wr_prg_rddata = (PORT_NUM == 1) ? dma_wr_prg_rddata : 32'bZ;
   assign p1_irq_prg_rddata    = (PORT_NUM == 1) ? rc_slave_irq_prg_rddata    : 32'bZ;
   assign p1_cmd_prg_rddata    = (PORT_NUM == 1) ? cmd_prg_rddata    : 32'bZ;
   assign p1_rx_ecrc_bad_cnt   = (PORT_NUM == 1) ? rx_ecrc_bad_cnt   : 16'bZ;
   assign p1_read_dma_status   = (PORT_NUM == 1) ? read_dma_status   : 64'bZ;
   assign p1_write_dma_status  = (PORT_NUM == 1) ? write_dma_status  : 64'bZ;

   generate
      if (PORT_NUM == 0) begin
	 assign dma_rd_prg_rddata_p1 = p1_dma_rd_prg_rddata;
	 assign dma_wr_prg_rddata_p1 = p1_dma_wr_prg_rddata;
	 assign irq_prg_rddata_p1    = p1_irq_prg_rddata;
	 assign cmd_prg_rddata_p1    = p1_cmd_prg_rddata;
	 assign rx_ecrc_bad_cnt_p1   = p1_rx_ecrc_bad_cnt;
	 assign read_dma_status_p1   = p1_read_dma_status;
	 assign write_dma_status_p1  = p1_write_dma_status;
      end
      else begin
	 assign rc_slave_prg_wrdata  = p1_prg_wrdata;
	 assign rc_slave_prg_addr    = p1_prg_addr;
	 assign dma_rd_prg_wrena     = p1_dma_rd_prg_wrena;
	 assign dma_wr_prg_wrena     = p1_dma_wr_prg_wrena;
	 assign rc_slave_irq_prg_wrena        = p1_irq_prg_wrena;
	 assign cmd_prg_wrena        = p1_cmd_prg_wrena;
      end
   endgenerate

   generate
      if (PORT_NUM == 0) begin
	 sonic_rc_slave#(
			 .AVALON_ST_128    (AVALON_ST_128),
			 .AVALON_WDATA     (AVALON_WDATA),	
			 .AVALON_BYTE_WIDTH  (AVALON_BYTE_WIDTH),
			 .AVALON_WADDR   (AVALON_WADDR),
			 .PORT_NUM         (PORT_NUM)
			 ) sonic_rc_slave(
					  .clk_in     (clk_in),
					  .rstn       (g_rstn),

					  .rx_req     (rx_req0),
					  .rx_desc    (rx_desc0),
					  .rx_data    (rx_data0[AVALON_WDATA-1:0] ),
					  .rx_be      (rx_be0[AVALON_BYTE_WIDTH-1:0]),
					  .rx_dv      (rx_dv0),
					  .rx_dfr     (rx_dfr0),
					  .rx_ack     (rx_ack_pcnt),
					  .rx_ws      (rx_ws_pcnt),

					  .tx_ws      (tx_ws0),
					  .tx_ack     (tx_ack0),
					  .tx_desc    (tx_desc_pcnt),
					  .tx_data    (tx_data_pcnt[AVALON_WDATA-1:0]),
					  .tx_dfr     (tx_dfr_pcnt),
					  .tx_dv      (tx_dv_pcnt),
					  .tx_req     (tx_req_pcnt),
					  .tx_busy    (tx_busy_pcnt ),
					  .tx_ready   (tx_ready_pcnt),
					  .tx_sel     (tx_sel_pcnt  ),

					  .mem_rd_data_valid (1'b0),
					  .mem_rd_addr       (),		
					  .mem_rd_data       (128'h0),	
					  .mem_rd_ena        (),			
					  .mem_wr_ena        (),
					  .mem_wr_addr       (),
					  .mem_wr_data       (),
					  .mem_wr_be         (),
					  .sel_epmem         (),
					  
					  /* 
					   * this.regvalue
					   */
					  .prg_wrdata    (rc_slave_prg_wrdata),
					  .prg_addr      (rc_slave_prg_addr),		
					  .dma_rd_prg_rddata (dma_rd_prg_rddata),
					  .dma_wr_prg_rddata (dma_wr_prg_rddata),
					  .dma_rd_prg_wrena  (dma_rd_prg_wrena),
					  .dma_wr_prg_wrena  (dma_wr_prg_wrena),
					  .irq_prg_rddata    (rc_slave_irq_prg_rddata),
					  .irq_prg_wrena     (rc_slave_irq_prg_wrena),
					  .cmd_prg_rddata    (cmd_prg_rddata),
					  .cmd_prg_wrena     (cmd_prg_wrena),
					  .tx_prg_rddata     (rc_slave_tx_prg_rddata),		
					  .tx_prg_wrena      (rc_slave_tx_prg_wrena),

					  .rx_ecrc_bad_cnt   (rx_ecrc_bad_cnt),
					  .read_dma_status   (read_dma_status),
					  .write_dma_status  (write_dma_status),

					  /*
					   * other.regvalue
					   */
					  .prg_wrdata_p1        (prg_wrdata_p1),
					  .prg_addr_p1          (prg_addr_p1),
					  .dma_rd_prg_rddata_p1 (dma_rd_prg_rddata_p1),
					  .dma_wr_prg_rddata_p1 (dma_wr_prg_rddata_p1),
					  .dma_rd_prg_wrena_p1  (dma_rd_prg_wrena_p1),
					  .dma_wr_prg_wrena_p1  (dma_wr_prg_wrena_p1),
					  .irq_prg_rddata_p1    (irq_prg_rddata_p1),
					  .irq_prg_wrena_p1     (irq_prg_wrena_p1),
					  .cmd_prg_rddata_p1    (cmd_prg_rddata_p1),
					  .cmd_prg_wrena_p1     (cmd_prg_wrena_p1),
					  .rx_ecrc_bad_cnt_p1   (rx_ecrc_bad_cnt_p1),
					  .read_dma_status_p1   (read_dma_status_p1),
					  .write_dma_status_p1  (write_dma_status_p1),
					  
					  .cfg_busdev (cfg_busdev_reg)
					  );
      end // if (PORT_NUM == 0)
      else begin
	 // Port 1 does not need sonic_rc_slave.
	 sonic_rc_slave#(
			 .AVALON_ST_128    (AVALON_ST_128),
			 .AVALON_WDATA     (AVALON_WDATA),	
			 .AVALON_BYTE_WIDTH  (AVALON_BYTE_WIDTH),
			 .AVALON_WADDR   (AVALON_WADDR),
			 .PORT_NUM         (PORT_NUM)
			 ) sonic_rc_slave(
					  .clk_in     (clk_in),
					  .rstn       (g_rstn),

					  .rx_req     (rx_req0),
					  .rx_desc    (rx_desc0),
					  .rx_data    (rx_data0[AVALON_WDATA-1:0]),
					  .rx_be      (rx_be0[AVALON_BYTE_WIDTH-1:0]),
					  .rx_dv      (rx_dv0),
					  .rx_dfr     (rx_dfr0),
					  .rx_ack     (rx_ack_pcnt),
					  .rx_ws      (rx_ws_pcnt),

					  .tx_ws      (tx_ws0),
					  .tx_ack     (tx_ack0),
					  .tx_desc    (tx_desc_pcnt),
					  .tx_data    (tx_data_pcnt[AVALON_WDATA-1:0]),
					  .tx_dfr     (tx_dfr_pcnt),
					  .tx_dv      (tx_dv_pcnt),
					  .tx_req     (tx_req_pcnt),
					  .tx_busy    (tx_busy_pcnt ),
					  .tx_ready   (tx_ready_pcnt),
					  .tx_sel     (tx_sel_pcnt  ),

					  .mem_rd_data_valid (1'b0),
					  .mem_rd_addr       (),		
					  .mem_rd_data       (128'h0),	
					  .mem_rd_ena        (),			
					  .mem_wr_ena        (),
					  .mem_wr_addr       (),
					  .mem_wr_data       (),
					  .mem_wr_be         (),
					  .sel_epmem         (),

					  .prg_wrdata    (),
					  .prg_addr      (),		

					  /* 
					   * this.regvalue
					   */
					  .dma_rd_prg_rddata (),
					  .dma_wr_prg_rddata (),
					  .dma_rd_prg_wrena  (),
					  .dma_wr_prg_wrena  (),
					  .irq_prg_rddata    (),
					  .irq_prg_wrena     (),
					  .cmd_prg_rddata    (),
					  .cmd_prg_wrena     (),
					  .tx_prg_rddata     (),		
					  .tx_prg_wrena      (),
					  .rx_ecrc_bad_cnt   (),
					  .read_dma_status   (),
					  .write_dma_status  (),

					  .prg_wrdata_p1 (),
					  .prg_addr_p1   (),
					  .dma_rd_prg_rddata_p1 (),
					  .dma_wr_prg_rddata_p1 (),
					  .dma_rd_prg_wrena_p1  (),
					  .dma_wr_prg_wrena_p1  (),
					  .irq_prg_rddata_p1    (),
					  .irq_prg_wrena_p1     (),
					  .cmd_prg_rddata_p1    (),
					  .cmd_prg_wrena_p1     (),
					  .rx_ecrc_bad_cnt_p1   (),
					  .read_dma_status_p1   (),
					  .write_dma_status_p1  (),					  
					  .cfg_busdev ()
					  );

      end // else: !if(PORT_NUM == 0)
   endgenerate
   

   //------------------------------------------------------------
   // RX signal controls
   //------------------------------------------------------------

   assign rx_ack0  = rx_ack_dmawr|rx_ack_dmard|rx_ack_pcnt;
   assign rx_ws0   = rx_ws_dmawr |rx_ws_dmard |rx_ws_pcnt;

   //------------------------------------------------------------
   // TX signal controls and data stream mux
   //------------------------------------------------------------
   assign tx_dv0	=	(tx_sel_interrupt==1'b1)?tx_dv_interrupt:
			 (tx_sel_command==1'b1)?tx_dv_command:
			 (tx_sel_dmawr==1'b1)?tx_dv_dmawr  :tx_dv_dmard_mux  ;
   assign tx_dfr0  =	(tx_sel_interrupt==1'b1)?tx_dfr_interrupt:
		    (tx_sel_command==1'b1)?tx_dfr_command:
		    (tx_sel_dmawr==1'b1)?tx_dfr_dmawr :tx_dfr_dmard_mux ;
   assign tx_data0 =	(tx_sel_interrupt==1'b1)?tx_data_interrupt:
		    (tx_sel_command==1'b1)?tx_data_command:
		    (tx_sel_dmawr==1'b1)?tx_data_dmawr:tx_data_dmard_mux;
   assign tx_req0  =	(tx_sel_interrupt==1'b1)?tx_req_interrupt:
		    (tx_sel_command==1'b1)?tx_req_command:
		    (tx_sel_dmawr==1'b1)?tx_req_dmawr :tx_req_dmard_mux ;
   assign tx_err0  =	(tx_sel_interrupt==1'b1)?tx_err_interrupt:
		    (tx_sel_command==1'b1)?tx_err_command:
		    (tx_sel_dmawr==1'b1)?tx_err_dmawr :tx_err_dmard_mux ;

   assign tx_desc0[127]     = `RESERVED_1BIT;
   // TLP_FMT
   assign tx_desc0[126:125] =	(tx_sel_interrupt==1'b1)?tx_desc_interrupt[126:125]:
			     (tx_sel_command==1'b1)?tx_desc_command[126:125]:
			     (tx_sel_dmawr==1'b1)?tx_desc_dmawr[126:125]:
			     tx_desc_dmard_mux[126:125];
   // TLP_TYPE
   assign tx_desc0[124:120] =  (tx_sel_interrupt==1'b1)?tx_desc_interrupt[124:120]:
			       (tx_sel_command==1'b1)?tx_desc_command[124:120]:
			       (tx_sel_dmawr==1'b1)?tx_desc_dmawr[124:120]:
			       tx_desc_dmard_mux[124:120];

   assign tx_desc0[119]     = `RESERVED_1BIT   ;
   assign tx_desc0[118:116] = (PORT_NUM == 0) ? `TLP_TC_CLASS_CH_ZERO : `TLP_TC_CLASS_CH_ONE  ;
   assign tx_desc0[115:112] = `RESERVED_4BIT   ;
   assign tx_desc0[111]     = `TLP_TD_DEFAULT  ;
   assign tx_desc0[110]     = `TLP_EP_DEFAULT  ;
   assign tx_desc0[109:108] = `TLP_ATTR_DEFAULT;
   assign tx_desc0[107:106] = `RESERVED_2BIT   ;

   // length
   assign tx_desc0[105:96]   = (tx_sel_interrupt==1'b1)?tx_desc_interrupt[105:96]:
			       (tx_sel_command==1'b1)?tx_desc_command[105:96]:
			       (tx_sel_dmawr==1'b1)?tx_desc_dmawr[105:96]:
			       tx_desc_dmard_mux[105:96];
   // requester id
   assign tx_desc0[95:83]   = cfg_busdev_reg;
   assign tx_desc0[82:80 ]   = `TRANSACTION_ID;

   // tag
   assign tx_desc0[79:72]   =  (tx_sel_interrupt==1'b1)?tx_desc_interrupt[79:72]:
			       (tx_sel_command==1'b1)?tx_desc_command[79:72]:
			       (tx_sel_dmawr==1'b1)?tx_desc_dmawr[79:72]:
			       tx_desc_dmard_mux[79:72];
   // byte enable
   assign tx_desc0[71:64]   =  (tx_sel_interrupt==1'b1)?tx_desc_interrupt[71:64]:
			       (tx_sel_command==1'b1)?tx_desc_command[71:64]:
			       (tx_sel_dmawr==1'b1)?tx_desc_dmawr[71:64]:
			       tx_desc_dmard_mux[71:64];
   // address
   assign tx_desc0[63:0]    =  (tx_sel_interrupt==1'b1)?tx_desc_interrupt[63:0]:
			       (tx_sel_command==1'b1)?tx_desc_command[63:0]:
			       (tx_sel_dmawr==1'b1)?tx_desc_dmawr[63:0]:
			       tx_desc_dmard_mux[63:0];


   //------------------------------------------------------------
   // Arbitration of TX- RX Stream
   //------------------------------------------------------------ 
   wire 	 dma_tx_idle;
   wire 	 dma_tx_idle_p0_tx_sel;
   wire 	 write_priority_over_read;
   wire 	 tx_sel_descriptor_dmawr_p0;
   wire 	 tx_sel_descriptor_dmard_p0;
   wire 	 tx_sel_requester_dmawr_p0;
   wire 	 tx_sel_requester_dmard_p0;
   wire 	 tx_sel_pcnt_p0;
   wire 	 tx_sel_interrupt_p0;
   wire 	 tx_sel_command_p0;
   reg 		 tx_sel_reg_descriptor_dmawr;
   reg 		 tx_sel_reg_descriptor_dmard;
   reg 		 tx_sel_reg_requester_dmawr;
   reg 		 tx_sel_reg_requester_dmard;
   reg 		 tx_sel_reg_pcnt;
   reg 		 tx_sel_reg_interrupt;
   reg 		 tx_sel_reg_command;

   reg 		 rx_ecrc_failure;

   assign write_priority_over_read = (DMA_WRITE_PRIORITY>DMA_READ_PRIORITY)?
                                     1'b1:1'b0;

   assign tx_ready_dmawr = ((write_priority_over_read==1'b1)&&
                            ((tx_rdy_descriptor_dmawr==1'b1)||
                             (tx_rdy_requester_dmawr==1'b1)  ))?1'b1:1'b0;

   assign tx_sel_dmard   = ((tx_sel_descriptor_dmard==1'b1)||
                            (tx_sel_requester_dmard==1'b1))?1'b1:1'b0;

   assign tx_stop_dma_write = ((tx_mask_reg==1'b1)||
                               (tx_stream_ready0_reg==1'b0))?1'b1:1'b0;

   assign tx_ready_dmard    = ((tx_stop_dma_write==1'b1)||
                               ((write_priority_over_read==1'b0)    &&
                                ((tx_rdy_descriptor_dmard==1'b1)||
				 (tx_rdy_requester_dmard==1'b1)  ) ))?1'b1:1'b0;


   assign tx_rdy_descriptor_dmawr= (TL_SELECTION==0)?tx_ready_descriptor_dmawr_r:tx_ready_descriptor_dmawr ;
   assign tx_rdy_requester_dmawr = (TL_SELECTION==0)?tx_ready_requester_dmawr_r :tx_ready_requester_dmawr  ;
   assign tx_rdy_descriptor_dmard= (TL_SELECTION==0)?tx_ready_descriptor_dmard_r:tx_ready_descriptor_dmard ;
   assign tx_rdy_requester_dmard = (TL_SELECTION==0)?tx_ready_requester_dmard_r :tx_ready_requester_dmard  ;

   assign tx_ready_interrupt_others  = ((tx_ready_dmawr==1'b1) || (tx_ready_dmard==1'b1) ||
					(tx_rdy_command==1'b1))?1'b1:1'b0;
   assign tx_rdy_interrupt = (TL_SELECTION==0)?tx_ready_interrupt_r:tx_ready_interrupt;

   assign tx_ready_command_others = ((tx_ready_dmawr==1'b1)||(tx_ready_dmard==1'b1)||
				     (tx_rdy_interrupt==1'b1))?1'b1:1'b0;
   assign tx_rdy_command = (TL_SELECTION==0)?tx_ready_command_r:tx_ready_command;

   always @ (posedge clk_in) begin
      tx_sel_reg_descriptor_dmawr <= tx_sel_descriptor_dmawr;
      tx_sel_reg_descriptor_dmard <= tx_sel_descriptor_dmard;
      tx_sel_reg_requester_dmawr  <= tx_sel_requester_dmawr;
      tx_sel_reg_requester_dmard  <= tx_sel_requester_dmard;
      tx_sel_reg_pcnt             <= tx_sel_pcnt;
      tx_sel_reg_interrupt		  <= tx_sel_interrupt;
      tx_sel_reg_command		  <= tx_sel_command;
      tx_ready_descriptor_dmawr_r <= tx_ready_descriptor_dmawr ;
      tx_ready_requester_dmawr_r  <= tx_ready_requester_dmawr  ;
      tx_ready_descriptor_dmard_r <= tx_ready_descriptor_dmard ;
      tx_ready_requester_dmard_r  <= tx_ready_requester_dmard  ;
      tx_ready_interrupt_r		  <= tx_ready_interrupt;
      tx_ready_command_r		  <= tx_ready_command;
   end

   assign tx_sel_descriptor_dmawr_p0 = tx_sel_descriptor_dmawr &
                                        ~tx_sel_reg_descriptor_dmawr;
   assign tx_sel_descriptor_dmard_p0 = tx_sel_descriptor_dmard &
                                        ~tx_sel_reg_descriptor_dmard;
   assign tx_sel_requester_dmawr_p0  = tx_sel_requester_dmawr &
                                        ~tx_sel_reg_requester_dmawr;
   assign tx_sel_requester_dmard_p0  = tx_sel_requester_dmard &
                                        ~tx_sel_reg_requester_dmard;
   assign tx_sel_pcnt_p0             = tx_sel_pcnt & ~tx_sel_reg_pcnt;

   assign tx_sel_interrupt_p0		 = tx_sel_interrupt & ~tx_sel_reg_interrupt;

   assign tx_sel_command_p0			 = tx_sel_command & ~tx_sel_reg_command;

   assign dma_tx_idle_p0_tx_sel = ((tx_sel_pcnt_p0==1'b0)             &&
                                   (tx_sel_descriptor_dmawr_p0==1'b0) &&
                                   (tx_sel_requester_dmawr_p0==1'b0)  &&
                                   (tx_sel_descriptor_dmard_p0==1'b0) &&
                                   (tx_sel_requester_dmard_p0==1'b0)  &&
				   (tx_sel_interrupt_p0==1'b0)        &&
				   (tx_sel_command_p0==1'b0)           ) ? 1'b1:1'b0;

   assign dma_tx_idle = ((tx_busy_pcnt==1'b0)             &&
                         (tx_busy_descriptor_dmawr==1'b0) &&
                         (tx_busy_requester_dmawr==1'b0)  &&
                         (tx_busy_descriptor_dmard==1'b0) &&
                         (tx_busy_requester_dmard==1'b0)  &&
			 (tx_busy_interrupt==1'b0)        &&
			 (tx_busy_command==1'b0)         ) ? 1'b1:1'b0;

   always @ (negedge g_rstn or posedge clk_in) begin
      if (g_rstn==1'b0)
        rx_ecrc_failure <= 1'b0;
      else if (rx_ecrc_bad_cnt>0)
        rx_ecrc_failure <= 1'b1;
   end
   
   always @ (negedge g_rstn or posedge clk_in) begin
      if (g_rstn==1'b0) begin
         tx_sel_descriptor_dmawr <= 1'b0;
         tx_sel_requester_dmawr  <= 1'b0;
         tx_sel_dmawr            <= 1'b0;
         tx_sel_descriptor_dmard <= 1'b0;
         tx_sel_requester_dmard  <= 1'b0;
         tx_sel_pcnt             <= 1'b0;
	 tx_sel_interrupt	 <= 1'b0;
	 tx_sel_command		 <= 1'b0;
      end
      else begin
         if (pci_bus_master_enable==1'b0) begin
            tx_sel_descriptor_dmawr <= 1'b0;
            tx_sel_requester_dmawr  <= 1'b0;
            tx_sel_dmawr            <= 1'b0;
            tx_sel_descriptor_dmard <= 1'b0;
            tx_sel_requester_dmard  <= 1'b0;
            tx_sel_pcnt             <= 1'b1;
	    tx_sel_interrupt	<= 1'b0;
	    tx_sel_command	<= 1'b0;
         end
         else if ((dma_tx_idle==1'b1)&&
                  (dma_tx_idle_p0_tx_sel==1'b1) ) begin
            if (DMA_WRITE_PRIORITY>DMA_READ_PRIORITY) begin
               if ((tx_mask_reg==1'b1)||
                   (tx_stream_ready0_reg==1'b0)) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
	       else if (tx_rdy_interrupt==1'b1) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b1;
		  tx_sel_command			 <= 1'b0;
	       end
	       else if (tx_rdy_command==1'b1) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b1;
	       end
               else if ((tx_rdy_descriptor_dmawr==1'b1)&&(cpld_rx_buffer_ready==1'b1)) begin
                  tx_sel_descriptor_dmawr <= 1'b1;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b1;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
               else if ((tx_rdy_descriptor_dmard==1'b1)&&(cpld_rx_buffer_ready==1'b1)) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b1;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
               else if (tx_rdy_requester_dmawr==1'b1) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b1;
                  tx_sel_dmawr            <= 1'b1;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
               else if ((tx_rdy_requester_dmard==1'b1)&&(cpld_rx_buffer_ready==1'b1)) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b1;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
               else if (tx_ready_pcnt==1'b1) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b1;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
               else begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
            end
            else begin
               if ((tx_mask_reg==1'b1)||
                   (tx_stream_ready0_reg==1'b0)) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
	       else if (tx_rdy_interrupt==1'b1) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b1;
		  tx_sel_command			 <= 1'b0;
	       end
	       else if (tx_rdy_command==1'b1) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b1;
	       end
               else if ((tx_rdy_descriptor_dmard==1'b1)&&(cpld_rx_buffer_ready==1'b1)) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b1;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
               else if ((tx_rdy_descriptor_dmawr==1'b1)&&(cpld_rx_buffer_ready==1'b1)) begin
                  tx_sel_descriptor_dmawr <= 1'b1;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b1;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
               else if ((tx_rdy_requester_dmard==1'b1)&&(cpld_rx_buffer_ready==1'b1)) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b1;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
               else if (tx_rdy_requester_dmawr==1'b1) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b1;
                  tx_sel_dmawr            <= 1'b1;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
               else if (tx_ready_pcnt==1'b1) begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b1;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
               else begin
                  tx_sel_descriptor_dmawr <= 1'b0;
                  tx_sel_requester_dmawr  <= 1'b0;
                  tx_sel_dmawr            <= 1'b0;
                  tx_sel_descriptor_dmard <= 1'b0;
                  tx_sel_requester_dmard  <= 1'b0;
                  tx_sel_pcnt             <= 1'b0;
		  tx_sel_interrupt		 <= 1'b0;
		  tx_sel_command			 <= 1'b0;
               end
            end
         end
      end
   end


   //------------------------------------------------------------
   // Arbitration of MSI Stream
   //------------------------------------------------------------

   // MSI Generation
   reg app_msi_req_reg;
   reg [4:0] app_msi_num_reg;
   reg [2:0] app_msi_tc_reg;

   // MSI Generation
   always @ (negedge g_rstn or posedge clk_in) begin
      if (g_rstn==1'b0)
        app_msi_req_reg <= 1'b0;
      else if (msi_enable==1'b1) begin
         if (app_msi_ack == 1'b1)
           app_msi_req_reg <= 1'b0;
	 else if (msi_sel_interrupt==1'b1)
	   app_msi_req_reg <= app_msi_req_interrupt;
         else if (msi_sel_dmawr==1'b1)
           app_msi_req_reg <= app_msi_req_dmawr;
         else
           app_msi_req_reg <= app_msi_req_dmard;
      end
   end

   always @ (posedge clk_in) begin
      if (msi_sel_interrupt==1'b1)
	app_msi_num_reg <= app_msi_num_interrupt;
      else if (msi_sel_dmawr==1'b1)
        app_msi_num_reg <= app_msi_num_dmawr;
      else
        app_msi_num_reg <= app_msi_num_dmard;
   end

   always @ (posedge clk_in) begin
      if (msi_sel_interrupt==1'b1)
	app_msi_tc_reg <= app_msi_tc_interrupt;
      else if (msi_sel_dmawr==1'b1)
        app_msi_tc_reg <= app_msi_tc_dmawr;
      else
        app_msi_tc_reg <= app_msi_tc_dmard;
   end

   always @ (negedge g_rstn or posedge clk_in) begin
      if (g_rstn==1'b0) begin
	 msi_sel_interrupt <= 1'b0;
	 msi_sel_dmawr <= 1'b0;
	 msi_sel_dmard <= 1'b0;
      end
      else if ({msi_busy_dmard, msi_busy_dmawr, msi_busy_interrupt}==3'b000)begin
	 if (msi_ready_interrupt==1'b1) begin
	    msi_sel_interrupt <= 1'b1;
	    msi_sel_dmawr <= 1'b0;
	    msi_sel_dmard <= 1'b0;
	 end
	 else if (msi_ready_dmawr == 1'b1) begin
	    msi_sel_interrupt <= 1'b0;
	    msi_sel_dmawr <= 1'b1;
	    msi_sel_dmard <= 1'b0;
	 end
	 else if (msi_ready_dmard == 1'b1) begin
	    msi_sel_interrupt <= 1'b0;
	    msi_sel_dmawr <= 1'b0;
	    msi_sel_dmard <= 1'b1;
	 end
      end
      else if (msi_ready_interrupt==1'b1) begin
	 msi_sel_interrupt <= 1'b1;
	 msi_sel_dmawr <= 1'b0;
	 msi_sel_dmard <= 1'b0;
      end
      else if (msi_ready_dmard == 1'b1) begin
	 msi_sel_interrupt <= 1'b0;
	 msi_sel_dmawr <= 1'b0;
	 msi_sel_dmard <= 1'b1;
      end
      else begin
	 msi_sel_interrupt <= 1'b0;
	 msi_sel_dmawr <= 1'b1;
	 msi_sel_dmard <= 1'b0;
      end
   end

   //--------------------------------------------------------------
   // Interrupt/MSI IO signalling
   // Route arbitrated interrupt request to MSI if msi is enabled,
   // or to Legacy app_int_sts otherwise.
   //--------------------------------------------------------------

   assign msi_enable = cfg_msicsr_reg[0];

   // MSI REQUEST
   assign app_msi_req = (USE_MSI==0)?0:app_msi_req_reg;
   assign app_msi_num = (USE_MSI==0)?0:app_msi_num_reg;
   assign app_msi_tc  = (USE_MSI==0)?0:app_msi_tc_reg;

   // LEGACY INT REQUEST
   assign app_int_sts = (USE_MSI==0)?0:app_int_req;

   always @ (negedge g_rstn or posedge clk_in) begin
      if (g_rstn==1'b0) begin
         app_int_req      <= 1'b0;
         app_int_ack_reg  <= 1'b0;
         int_deassert     <= 1'b0;
      end
      else begin
         app_int_ack_reg <= app_int_ack;                                     // input boundary reg
         int_deassert    <= app_int_ack_reg ? ~int_deassert : int_deassert;  // track whether core is sending interrupt ASSERTION message or DEASSERTION message.

         if (app_int_ack_reg)                                                // deassert request when Interrupt ASSERTION is ack-ed
           app_int_req  <= 1'b0;
         else if ((~msi_enable & ~int_deassert) &
                  (((msi_sel_dmawr == 1'b1) &  (app_msi_req_dmawr == 1'b1)) |
                   ((msi_sel_dmawr == 1'b0) &  (app_msi_req_dmard == 1'b1)) ) ) begin  // assert if there is a request, and not waiting for the DEASSERTION ack for this request
            app_int_req  <= 1'b1;
         end
         else
           app_int_req  <= app_int_req;
      end
   end


   // MSI & LEGACY ACKNOWLEDGE - sent to the internal interrupt requestor

   assign interrupt_ack_int = (app_msi_ack &  msi_enable) |                     // Ack from MSI
                              (app_int_ack_reg & ~int_deassert & ~msi_enable);   // INT ASSERT Message Ack from Legacy



   //------------------------------------------------------------
   // Registering module for static side band signals
   //------------------------------------------------------------
   // cpl section
   reg [23:0] cpl_cnt_50ms;
   wire       tx_mrd; // Set to 1 when MRd on TX
   wire [6:0] tx_desc_fmt_type;
   reg 	      cpl_err0_r;

   assign tx_desc_fmt_type = tx_desc0[126:120];
   assign tx_mrd           = ((tx_ack0==1'b1)&&(tx_desc_fmt_type[4:0]==5'b00000)&&(tx_desc_fmt_type[6]==1'b0))?1'b1:1'b0;

   always @ (negedge g_rstn or posedge clk_in) begin : p_cpl_50ms
      if (g_rstn==1'b0) begin
         cpl_cnt_50ms <= 24'h0;
         cpl_pending  <= 1'b0;
         cpl_err0_r   <=1'b0;
      end
      else begin
         cpl_pending  <= cpl_pending_dmawr|cpl_pending_dmard;
         cpl_err0_r   <= (cpl_cnt_50ms==CNT_50MS)?1'b1:1'b0;
         if ((cpl_pending==1'b0)||(tx_mrd==1'b1))
           begin
              cpl_cnt_50ms <= 24'h0;
           end
         else if (cpl_cnt_50ms<CNT_50MS) begin
            cpl_cnt_50ms <= cpl_cnt_50ms+24'h1;
         end
      end
   end

   assign cpl_err[0]   = 1'b0; //cpl_err0_r;
   assign cpl_err[6:1] = 6'h0;
   assign err_desc     = 128'h0;


endmodule // sonic_single_port_logic

//-----------------------------------------------------------------------------
// Title         : PCI Express Reference Design Example Application
// Project       : PCI Express MegaCore function
//-----------------------------------------------------------------------------
// File          : sonic_single_port_logic.v
// Author        : Altera Corporation
//-----------------------------------------------------------------------------
// Description :
// This is the complete example application for the PCI Express Reference
// Design. This has all of the application logic for the example.
// We extended this file to encapsulate the logics for one port into one module.
// And duplicate the same module for the second port.
// We design an arbitor to arbitrate the PCI traffic between two ports.
// As a result, this module contains three main modules, port 0, port 1, and arbitor.
//-----------------------------------------------------------------------------
// Copyright (c) 2008 Altera Corporation. All rights reserved.  Altera products are
// protected under numerous U.S. and foreign patents, maskwork rights, copyrights and
// other intellectual property laws.
//
// This reference design file, and your use thereof, is subject to and governed by
// the terms and conditions of the applicable Altera Reference Design License Agreement.
// By using this reference design file, you indicate your acceptance of such terms and
// conditions between you and Altera Corporation.  In the event that you do not agree with
// such terms and conditions, you may not use the reference design file. Please promptly
// destroy any copies you have made.
//
// This reference design file being provided on an "as-is" basis and as an accommodation
// and therefore all warranties, representations or guarantees of any kind
// (whether express, implied or statutory) including, without limitation, warranties of
// merchantability, non-infringement, or fitness for a particular purpose, are
// specifically disclaimed.  By making this reference design file available, Altera
// expressly does not recommend, suggest or require that this reference design file be
// used in combination with any other product not provided by Altera.
//-----------------------------------------------------------------------------
