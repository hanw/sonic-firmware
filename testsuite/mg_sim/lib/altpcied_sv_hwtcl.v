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


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

module altpcied_sv_hwtcl # (
   parameter use_crc_forwarding_hwtcl        = 0,
   parameter lane_mask_hwtcl                 = "x4",
   parameter max_payload_size_hwtcl          = 256,
   parameter gen123_lane_rate_mode_hwtcl     = "Gen1 (2.5 Gbps)",
   parameter ast_width_hwtcl                 = "Avalon-ST 64-bit",
   parameter port_width_data_hwtcl           = 64,
   parameter port_width_be_hwtcl             = 8,
   parameter extend_tag_field_hwtcl          = 32,
   parameter avalon_waddr_hwltcl             = 12,
   parameter check_bus_master_ena_hwtcl      = 1,
   parameter check_rx_buffer_cpl_hwtcl       = 1,
   parameter port_type_hwtcl                 = "Native endpoint",
   parameter number_of_reconfig_interfaces   = 10,
   parameter reconfig_to_xcvr_width          = 350,
   parameter reconfig_from_xcvr_width        = 230,
   parameter use_ast_parity                  = 0

) (
      // Reset signals

      output                 crst,
      output                 srst,
      output                 hiphardreset,
      input                  reset_status,
      input                  rc_pll_locked,

      // Clock
      input                  pld_clk,
      input                  reconfig_xcvr_clk,
      input                  pld_pcierst,
      input                  testin_zero,

      // Reconfig GXB
      output              [reconfig_to_xcvr_width-1:0]   reconfig_to_xcvr,
      input               [reconfig_from_xcvr_width-1:0] reconfig_from_xcvr,

      // HIP control signals
      output  [4 : 0]        hpg_ctrler,

      // Application signals inputs
      output  [4 : 0]        aer_msi_num,
      output                 app_int_sts,
      output  [4 : 0]        app_msi_num,
      output                 app_msi_req,
      output  [2 : 0]        app_msi_tc,
      output  [4 : 0]        pex_msi_num,

      output  [11 : 0]       lmi_addr,
      output  [31 : 0]       lmi_din,
      output                 lmi_rden,
      output                 lmi_wren,
      output                 pm_auxpwr,
      output  [9 : 0]        pm_data,
      output                 pme_to_cr,
      output                 pm_event,

      output  [port_width_data_hwtcl-1  : 0] tx_st_data,
      output  [1:0]                          tx_st_empty,
      output                                 tx_st_eop,
      output                                 tx_st_err,
      output                                 tx_st_sop,
      output                                 tx_st_valid,
      output  [port_width_be_hwtcl-1:0]      tx_st_parity,
      input                                  tx_st_ready,

      output  [12:0]         cfglink2csrpld,
      output  [6 :0]         cpl_err,
      output                 cpl_pending,

      // Output HIP Status signals
      input [1 : 0]        currentspeed,
      input                derr_cor_ext_rcv,
      input                derr_cor_ext_rcv1,
      input                derr_cor_ext_rpl,
      input                derr_rpl,
      input                dlup,
      input                dlup_exit,
      input                resetstatus,
      input                ratetiedtognd,
      input                ev128ns,
      input                ev1us,
      input                hotrst_exit,
      input [3 : 0]        int_status,
      input                l2_exit,
      input [3:0]          lane_act,
      input [4 : 0]        ltssmstate,
      input [7:0]          ko_cpl_spc_header,
      input [11:0]         ko_cpl_spc_data,

      input                app_int_ack,
      input                app_msi_ack,
      input                lmi_ack,
      input [31 : 0]       lmi_dout,
      input                pme_to_sr,

      input [port_width_be_hwtcl-1  :0] rx_st_parity,
      input [port_width_data_hwtcl-1:0] rx_st_data,
      output                            rx_st_ready,
      input                             rx_st_sop,
      input                             rx_st_valid,
      input [1:0]                       rx_st_empty,
      input                             rx_st_eop,
      input                             rx_st_err,

      input [port_width_be_hwtcl-1  :0] rx_st_be,
      output                            rx_st_mask,
      input [7 : 0]                     rx_st_bar,

      input                serr_out,
      input                sim_pipe_pclk_out,

      input [3 : 0]        tl_cfg_add,
      input [31 : 0]       tl_cfg_ctl,
      input [52 : 0]       tl_cfg_sts,

      // tx credits
      input [11 : 0]       tx_cred_datafccp,
      input [11 : 0]       tx_cred_datafcnp,
      input [11 : 0]       tx_cred_datafcp,
      input [5 : 0]        tx_cred_fchipcons,
      input [5 : 0]        tx_cred_fcinfinite,
      input [7 : 0]        tx_cred_hdrfccp,
      input [7 : 0]        tx_cred_hdrfcnp,
      input [7 : 0]        tx_cred_hdrfcp

      );

function [1:0] int2_2b;
   input [31:0] iint;
   int2_2b=iint[1:0];
endfunction


function [2:0] int2_3b;
   input [31:0] iint;
   int2_3b=iint[2:0];
endfunction

function [3:0] int2_4b;
   input [31:0] iint;
   int2_4b=iint[3:0];
endfunction

function [5:0] int2_5b;
   input [31:0] iint;
   int2_5b=iint[5:0];
endfunction

function [6:0] int2_7b;
   input [31:0] iint;
   int2_7b=iint[6:0];
endfunction

function [7:0] int2_8b;
   input [31:0] iint;
   int2_8b=iint[7:0];
endfunction

function [10:0] int2_11b;
   input [31:0] iint;
   int2_11b=iint[10:0];
endfunction

function [10:0] int2_12b;
   input [31:0] iint;
   int2_12b=iint[10:0];
endfunction

function [12:0] int2_13b;
   input [31:0] iint;
   int2_13b=iint[12:0];
endfunction

function [15:0] int2_16b;
   input [31:0] iint;
   int2_16b=iint[15:0];
endfunction

function [19:0] int2_20b;
   input [31:0] iint;
   int2_20b=iint[19:0];
endfunction

function [23:0] int2_24b;
   input [31:0] iint;
   int2_24b=iint[23:0];
endfunction

function [28:0] int2_29b;
   input [31:0] iint;
   int2_29b=iint[28:0];
endfunction

function [29:0] int2_30b;
   input [31:0] iint;
   int2_30b=iint[29:0];
endfunction


function [8*25:1] low_str;
// Convert parameter strings to lower case
   input [8*25:1] input_string;
   reg [8*25:1] return_string;
   reg [8*25:1] reg_string;
   reg [8:1] tmp;
   reg [8:1] conv_char;
   integer byte_count;
   begin
      reg_string = input_string;
      for (byte_count = 25; byte_count >= 1; byte_count = byte_count - 1) begin
         tmp = reg_string[8*25:(8*(25-1)+1)];
         reg_string = reg_string << 8;
         if ((tmp >= 65) && (tmp <= 90)) // ASCII number of 'A' is 65, 'Z' is 90
            begin
            conv_char = tmp + 32; // 32 is the difference in the position of 'A' and 'a' in the ASCII char set
            return_string = {return_string, conv_char};
            end
         else
            return_string = {return_string, tmp};
      end
   low_str = return_string;
   end
endfunction

function integer is_pld_clk_250MHz;
   input [8*25:1] l_ast_width;
   input [8*25:1] l_gen123_lane_rate_mode;
   input [8*25:1] l_lane_mask;
   begin
           if ((low_str(l_ast_width)=="Avalon-ST 64-bit" ) && (low_str(l_gen123_lane_rate_mode)=="Gen2 (5.0 Gbps)") && (low_str(l_lane_mask)=="x4"))  is_pld_clk_250MHz=1;
      else if ((low_str(l_ast_width)=="Avalon-ST 64-bit" ) && (low_str(l_gen123_lane_rate_mode)=="Gen1 (2.5 Gbps)") && (low_str(l_lane_mask)=="x8"))  is_pld_clk_250MHz=1;
      else if ((low_str(l_ast_width)=="Avalon-ST 128-bit") && (low_str(l_gen123_lane_rate_mode)=="Gen2 (5.0 Gbps)") && (low_str(l_lane_mask)=="x8"))  is_pld_clk_250MHz=1;
      else                                                                                                                                            is_pld_clk_250MHz=0;
   end
endfunction

localparam IS_ROOTPORT= (port_type_hwtcl == "Root port")?1:0;

wire [  7: 0] open_msi_stream_data0;
wire          open_msi_stream_valid0;
wire [23: 0]  open_cfg_tcvcmap;

wire           app_rstn;
wire [127: 0]  err_desc;
wire [12: 0]   cfg_busdev;
wire [31: 0]   cfg_devcsr;
wire [19: 0]   cfg_io_bas;
wire [31: 0]   cfg_linkcsr;
wire [15: 0]   cfg_msicsr;
wire [11: 0]   cfg_np_bas;
wire [43: 0]   cfg_pr_bas;
wire [31: 0]   cfg_prmcsr;
wire [ 6: 0]   cpl_err_in;

wire [255:0] ZEROS = 256'h0;

// tl_cfg strobes not used in SV Reva Silicon
wire tl_cfg_ctl_wr=1'b0;
wire tl_cfg_sts_wr=1'b0;

wire app_clk;
wire npor;
reg[1:0] por_r;

wire         reconfig_busy;             //     reconfig_busy.export               output wire
wire [6:0]   reconfig_mgmt_address;     //     reconfig_mgmt.address              input  wire
wire         reconfig_mgmt_read;        //                  .read                 input  wire
wire [31:0]  reconfig_mgmt_readdata;    //                  .readdata             output wire
wire         reconfig_mgmt_waitrequest; //                  .waitrequest          output wire
wire         reconfig_mgmt_write;       //                  .write                input  wire
wire [31:0]  reconfig_mgmt_writedata;   //                  .writedata            input  wire
reg          mgmt_rst_reset;


   //cfglink2csrpld
   assign cfglink2csrpld = 13'h0;

   // Parity is currently not supported in the design example
   assign tx_st_parity =ZEROS[ port_width_be_hwtcl-1:0];

   assign app_clk      = pld_clk;
   assign npor         = ~pld_pcierst;
   assign hiphardreset = 1'b0;

   altpcierd_tl_cfg_sample #(
      .HIP_SV(1)
      ) cfgbus (
      .pld_clk          (app_clk),
      .rstn             (app_rstn),
      .cfg_busdev       (cfg_busdev),
      .cfg_devcsr       (cfg_devcsr),
      .cfg_io_bas       (cfg_io_bas),
      .cfg_linkcsr      (cfg_linkcsr),
      .cfg_msicsr       (cfg_msicsr),
      .cfg_np_bas       (cfg_np_bas),
      .cfg_pr_bas       (cfg_pr_bas),
      .cfg_prmcsr       (cfg_prmcsr),
      .cfg_tcvcmap      (open_cfg_tcvcmap),
      .tl_cfg_add       (tl_cfg_add),
      .tl_cfg_ctl       (tl_cfg_ctl),
      .tl_cfg_ctl_wr    (tl_cfg_ctl_wr),
      .tl_cfg_sts       (tl_cfg_sts),
      .tl_cfg_sts_wr    (tl_cfg_sts_wr)
   );

   generate begin : g_enpoint
      if (IS_ROOTPORT == 0) begin
         wire open_cplerr_lmi_busy;
         altpcierd_cplerr_lmi lmi_blk (
            .clk_in (app_clk),
            .rstn (app_rstn),
            .cpl_err_in (cpl_err_in),
            .cpl_err_out (cpl_err),
            .cplerr_lmi_busy (open_cplerr_lmi_busy),
            .err_desc (err_desc),
            .lmi_ack (lmi_ack),
            .lmi_addr (lmi_addr),
            .lmi_din (lmi_din),
            .lmi_rden (lmi_rden),
            .lmi_wren (lmi_wren)
         );
      end
   end
   endgenerate

   altpcierd_hip_rs rs_hip (
      .app_rstn (app_rstn),
      .crst (crst),
      .dlup_exit (dlup_exit),
      .hotrst_exit (~reset_status),
      .l2_exit (l2_exit),
      .ltssm (ltssmstate),
      .npor (npor & rc_pll_locked),
      .pld_clk (pld_clk),
      .srst (srst),
      .test_sim (testin_zero)
   );

   wire    [ 81: 0] rx_stream_data0;
   wire    [ 81: 0] rx_stream_data0_1;

   generate begin : g_rxstream
      if (ast_width_hwtcl=="Avalon-ST 128-bit") begin
         assign rx_stream_data0   = {rx_st_be[7 : 0], rx_st_sop, rx_st_empty[0], rx_st_bar, rx_st_data[63 : 0]} ;
         assign rx_stream_data0_1 = {rx_st_be[15 : 8], rx_st_sop, rx_st_eop, rx_st_bar, rx_st_data[127 : 64]} ;
      end
      else begin
         assign rx_stream_data0   = {rx_st_be[7:0], rx_st_sop, rx_st_eop, rx_st_bar, rx_st_data};
         assign rx_stream_data0_1 = 82'h0;
      end
   end
   endgenerate


   generate begin : g_chaining_dma

      if (((ast_width_hwtcl=="Avalon-ST 64-bit")||(ast_width_hwtcl=="Avalon-ST 128-bit")) && (IS_ROOTPORT == 0)) begin

         wire    [ 74: 0] tx_stream_data0;
         wire    [ 74: 0] tx_stream_data0_1;
         wire    [127:0]  tx_st_data_int;

         assign tx_st_sop     = tx_stream_data0[73];
         assign tx_st_err     = tx_stream_data0[74];
         assign tx_st_eop                             = (ast_width_hwtcl=="Avalon-ST 128-bit")?tx_stream_data0_1[72]                              : tx_stream_data0[72];
         assign tx_st_empty[0]                        = (ast_width_hwtcl=="Avalon-ST 128-bit")?tx_stream_data0[72]                                : 1'b0;
         assign tx_st_data_int                        = (ast_width_hwtcl=="Avalon-ST 128-bit")?{tx_stream_data0_1[63 : 0],tx_stream_data0[63 : 0]}: {64'h0,tx_stream_data0[63 : 0]} ;
         assign tx_st_data[port_width_data_hwtcl-1:0] = tx_st_data_int[port_width_data_hwtcl-1:0];

         altpcierd_example_app_chaining # (

            .AVALON_WADDR           (avalon_waddr_hwltcl),
            .CHECK_BUS_MASTER_ENA   (check_bus_master_ena_hwtcl),
            .CHECK_RX_BUFFER_CPL    (check_rx_buffer_cpl_hwtcl ),
            .CLK_250_APP            (is_pld_clk_250MHz(ast_width_hwtcl, gen123_lane_rate_mode_hwtcl, lane_mask_hwtcl )),
            .ECRC_FORWARD_CHECK     (0),
            .ECRC_FORWARD_GENER     (0),
            .MAX_NUMTAG             (extend_tag_field_hwtcl),
            .MAX_PAYLOAD_SIZE_BYTE  (max_payload_size_hwtcl),
            .TL_SELECTION           ((ast_width_hwtcl=="Avalon-ST 128-bit")?7:6),
            .TXCRED_WIDTH           (36)

            ) app (

            .clk_in      (app_clk),
            .rstn        (app_rstn),
            .test_sim    (testin_zero),

            .aer_msi_num (aer_msi_num),
            .app_int_ack (app_int_ack),
            .app_int_sts (app_int_sts),
            .app_msi_ack (app_msi_ack),
            .app_msi_num (app_msi_num),
            .app_msi_req (app_msi_req),
            .app_msi_tc  (app_msi_tc),

            .pex_msi_num (pex_msi_num),
            .pm_data     (pm_data),

            .cfg_busdev  (cfg_busdev),
            .cfg_devcsr  (cfg_devcsr),
            .cfg_linkcsr (cfg_linkcsr),
            .cfg_msicsr  (cfg_msicsr),
            .cfg_prmcsr  (cfg_prmcsr),
            .cfg_tcvcmap (ZEROS[23:0]),

            .cpl_err          (cpl_err_in),
            .cpl_pending      (cpl_pending),
            .err_desc         (err_desc),
            .ko_cpl_spc_vc0   ({ko_cpl_spc_data,ko_cpl_spc_header}),

            .msi_stream_data0    (open_msi_stream_data0),
            .msi_stream_ready0   (1'b0),
            .msi_stream_valid0   (open_msi_stream_valid0),
            .tx_stream_fifo_empty0  (1'b1),

            .rx_stream_data0_0      (rx_stream_data0),
            .rx_stream_data0_1      (rx_stream_data0_1),
            .rx_stream_mask0        (rx_st_mask),
            .rx_stream_ready0       (rx_st_ready),
            .rx_stream_valid0       (rx_st_valid),

            .tx_stream_cred0        ({tx_cred_datafccp[11 : 0], tx_cred_hdrfccp[2 : 0], tx_cred_datafcnp[2 : 0],tx_cred_hdrfcnp[2 : 0],tx_cred_datafcp[11 : 0],tx_cred_hdrfcp[2 : 0]}),
            .tx_stream_data0_0      (tx_stream_data0),
            .tx_stream_data0_1      (tx_stream_data0_1),
            .tx_stream_mask0        (1'b0),
            .tx_stream_ready0       (tx_st_ready),
            .tx_stream_valid0       (tx_st_valid)
         );
   end
end
endgenerate

generate begin : g_target
   if ((ast_width_hwtcl=="Avalon-ST 256-bit") && (IS_ROOTPORT == 0)) begin
      wire [1:0] rx_st_empty_int;
      wire [1:0] tx_st_empty_int;

      assign rx_st_empty_int = rx_st_empty;
      assign tx_st_empty = tx_st_empty_int;

      altpcierd_ast256_downstream # (
         .AVALON_WADDR           (avalon_waddr_hwltcl),
         .CLK_250_APP            (0),
         .ECRC_FORWARD_CHECK     (0),
         .ECRC_FORWARD_GENER     (0),
         .MAX_NUMTAG             (extend_tag_field_hwtcl),
         .MAX_PAYLOAD_SIZE_BYTE  (max_payload_size_hwtcl),
         .TL_SELECTION           (9)
         ) app (

         .rstn                   (app_rstn),
         .clk_in                 (app_clk),
         .test_sim               (testin_zero),

         .aer_msi_num            (aer_msi_num),
         .app_int_ack            (app_int_ack),
         .app_int_sts            (app_int_sts),
         .app_msi_ack            (app_msi_ack),
         .app_msi_num            (app_msi_num),
         .app_msi_req            (app_msi_req),
         .app_msi_tc             (app_msi_tc),

         .pex_msi_num            (pex_msi_num),
         .pm_data                (pm_data),

         .cfg_busdev             (cfg_busdev),
         .cfg_devcsr             (cfg_devcsr),
         .cfg_linkcsr            (cfg_linkcsr),
         .cfg_msicsr             (cfg_msicsr),
         .cfg_prmcsr             (cfg_prmcsr),
         .cfg_tcvcmap            (ZEROS[23:0]),

         .cpl_err                (cpl_err_in),
         .cpl_pending            (cpl_pending),
         .err_desc               (err_desc),

         .ko_cpl_spc_vc0         ({ko_cpl_spc_data,ko_cpl_spc_header}),

         .rx_st_bardec0          (rx_st_bar     ),
         .rx_st_be0              (rx_st_be      ),
         .rx_st_data0            (rx_st_data    ),
         .rx_st_empty0           (rx_st_empty_int),
         .rx_st_eop0             (rx_st_eop     ),
         .rx_st_err0             (rx_st_err     ),
         .rx_st_mask0            (rx_st_mask    ),
         .rx_st_ready0           (rx_st_ready   ),
         .rx_st_sop0             (rx_st_sop     ),
         .rx_st_valid0           (rx_st_valid   ),

         .tx_cred_datafccp       (tx_cred_datafccp),
         .tx_cred_datafcnp       (tx_cred_datafcnp),
         .tx_cred_datafcp        (tx_cred_datafcp),
         .tx_cred_fchipcons      (tx_cred_fchipcons),
         .tx_cred_fcinfinite     (tx_cred_fcinfinite),
         .tx_cred_hdrfccp        (tx_cred_hdrfccp),
         .tx_cred_hdrfcnp        (tx_cred_hdrfcnp),
         .tx_cred_hdrfcp         (tx_cred_hdrfcp),

         .tx_st_data0            (tx_st_data),
         .tx_st_empty0           (tx_st_empty_int),
         .tx_st_eop0             (tx_st_eop),
         .tx_st_err0             (tx_st_err),
         .tx_st_ready0           (tx_st_ready),
         .tx_st_sop0             (tx_st_sop),
         .tx_st_valid0           (tx_st_valid));
   end
end
endgenerate

generate begin : g_root_port
   if (IS_ROOTPORT == 1) begin
      assign  aer_msi_num   = ZEROS[4 : 0]  ;
      assign  app_int_sts   = 1'b0          ;
      assign  app_msi_num   = ZEROS[4 : 0]  ;
      assign  app_msi_req   = 1'b0          ;
      assign  app_msi_tc    = ZEROS[2 : 0]  ;
      assign  pex_msi_num   = ZEROS[4 : 0]  ;
      assign  lmi_addr      = ZEROS[11 : 0] ;
      assign  lmi_din       = ZEROS[31 : 0] ;
      assign  lmi_rden      = 1'b0          ;
      assign  lmi_wren      = 1'b0          ;
      assign  cpl_err       = ZEROS[6:0]    ;
      assign  cpl_pending   = 1'b0          ;

   //////////////// SIMULATION-ONLY CONTENTS
   //synthesis translate_off
  //delay reset for RP
      reg srstn_r, srstn_rr;
      initial begin
         srstn_r  = 1'b0;
         srstn_rr = 1'b0;
      end

      wire [3:0] swdn_out=4'h1;
      wire       bfm_log_common_dummy_out;
      wire       driver_rp_dummy_out;
      wire       bfm_req_intf_common_dummy_out;
      wire       bfm_shmem_common_dummy_out;
      wire       ltssm_dummy_out;
      wire [127:0] tx_st_data_int;

      always @(posedge pld_clk or posedge pld_pcierst) begin
         if (pld_pcierst == 1'b1) begin
             srstn_r <= 0;
             srstn_rr <= 0;
         end
         else begin
             srstn_r <= 1;
             srstn_rr <= srstn_r;
         end
      end

      altpcietb_bfm_vc_intf_ast  # (
        .AVALON_ST_128       ((ast_width_hwtcl=="Avalon-ST 128-bit")?1:0),
        .ECRC_FORWARD_CHECK  (0),
        .ECRC_FORWARD_GENER  (0),
        .VC_NUM              (0)
          ) app_vc0 (
        .cfg_io_bas    (cfg_io_bas),
        .cfg_np_bas    (cfg_np_bas),
        .cfg_pr_bas    (cfg_pr_bas),
        .clk_in        (pld_clk),
        .rstn          (srstn_rr),
        .rx_mask       (rx_st_mask),
        .rx_st_be      ((ast_width_hwtcl=="Avalon-ST 128-bit")?rx_st_be  :{8'h0,rx_st_be}),
        .rx_st_data    ((ast_width_hwtcl=="Avalon-ST 128-bit")?rx_st_data:{64'h0,rx_st_data}),
        .rx_st_empty   (rx_st_empty[0]),
        .rx_st_eop     (rx_st_eop),
        .rx_st_ready   (rx_st_ready),
        .rx_st_sop     (rx_st_sop),
        .rx_st_valid   (rx_st_valid),
        .tx_cred       (36'hFFFFFFFFF),
        .tx_fifo_empty (1'b1),
        .tx_st_data    (tx_st_data_int),
        .tx_st_empty   (tx_st_empty[0]),
        .tx_st_eop     (tx_st_eop),
        .tx_st_ready   (tx_st_ready),
        .tx_st_sop     (tx_st_sop),
        .tx_st_valid   (tx_st_valid)
      );
      assign tx_st_data[port_width_data_hwtcl-1:0]  = tx_st_data_int[port_width_data_hwtcl-1:0];
      assign tx_st_err     = 1'b0;

      altpcietb_bfm_log_common bfm_log_common ( .dummy_out (bfm_log_common_dummy_out));
      altpcietb_bfm_req_intf_common bfm_req_intf_common ( .dummy_out (bfm_req_intf_common_dummy_out));
      altpcietb_bfm_shmem_common bfm_shmem_common ( .dummy_out (bfm_shmem_common_dummy_out));
      altpcietb_ltssm_mon ltssm_mon ( .dummy_out (ltssm_dummy_out), .ep_ltssm (5'h0), .rp_clk (sim_pipe_pclk_out), .rp_ltssm (ltssmstate), .rstn (npor));

      altpcietb_bfm_driver_rp # (
         .TEST_LEVEL(1)
         ) drvr (
         .INTA (swdn_out[0]),
         .INTB (swdn_out[1]),
         .INTC (swdn_out[2]),
         .INTD (swdn_out[3]),
         .clk_in (sim_pipe_pclk_out),
         .dummy_out (driver_rp_dummy_out),
         .rstn (srstn_rr));

   //////////////// END SIMULATION-ONLY CONTENTS
   //synthesis translate_on
   // The section bellow is for synthesis only and is not used for simulation
   // The RP DUT is using basic loopback rx AST --> AST
   //synthesis read_comments_as_HDL on
   //     reg [port_width_data_hwtcl-1:0] tx_st_data_loop;
   //     reg                             tx_st_sop_loop   ;
   //     reg                             tx_st_eop_loop   ;
   //     reg                             tx_st_empty_loop ;
   //     reg                             tx_st_valid_loop  ;
   //     reg [port_width_be_hwtcl-1:0]   tx_st_data_r;
   //     reg                             tx_st_sop_r   ;
   //     reg                             tx_st_eop_r   ;
   //     reg                             tx_st_empty_r ;
   //     reg                             tx_st_valid_r  ;
   //
   //     always @(posedge pld_clk or posedge pld_pcierst) begin
   //        if (pld_pcierst == 1'b1) begin
   //           tx_st_data_loop  <= ZEROS[port_width_data_hwtcl-1:0];
   //           tx_st_sop_loop   <= 1'b0;
   //           tx_st_eop_loop   <= 1'b0;
   //           tx_st_empty_loop <= 1'b0;
   //           tx_st_valid_loop <= 1'b0;
   //           tx_st_data_r     <= ZEROS[port_width_data_hwtcl-1:0] ;
   //           tx_st_sop_r      <= 1'b0;
   //           tx_st_eop_r      <= 1'b0;
   //           tx_st_empty_r    <= 1'b0;
   //           tx_st_valid_r    <= 1'b0;
   //        end
   //        else begin
   //           tx_st_data_loop    <= rx_st_data   ;
   //           tx_st_sop_loop     <= rx_st_sop    ;
   //           tx_st_eop_loop     <= rx_st_eop    ;
   //           tx_st_empty_loop   <= rx_st_empty[0]  ;
   //           tx_st_valid_loop   <= rx_st_valid  ;
   //
   //           tx_st_data_r       <= tx_st_data_loop ;
   //           tx_st_sop_r        <= tx_st_sop_loop     ;
   //           tx_st_eop_r        <= tx_st_eop_loop     ;
   //           tx_st_empty_r      <= tx_st_empty_loop   ;
   //           tx_st_valid_r      <= tx_st_valid_loop   ;
   //        end
   //     end
   //
   //     assign tx_st_data         = tx_st_data_r   ;
   //     assign tx_st_sop          = tx_st_sop_r    ;
   //     assign tx_st_eop          = tx_st_eop_r    ;
   //     assign tx_st_empty[0]     = tx_st_empty_r  ;
   //     assign tx_st_valid        = tx_st_valid_r  ;
   //
   //     assign rx_st_ready        = 1'b1;
   //     assign rx_st_mask         = 1'b0;
   //synthesis read_comments_as_HDL off
   end
end
endgenerate


// Power management
assign pm_auxpwr  =1'b0;
assign pme_to_cr  =1'b0;
assign pm_event   =1'b0;
// Hot plug
assign hpg_ctrler = 5'h0;


// Reconfiguration
//
assign reconfig_mgmt_address   = 7'h0;    //     reconfig_mgmt.address              input  wire
assign reconfig_mgmt_read      = 1'b0;    //                  .read                 input  wire
assign reconfig_mgmt_write     = 1'b0;    //                  .write                input  wire
assign reconfig_mgmt_writedata = 32'h0;   //                  .writedata            input  wire
  //reset Synchronizer
   always @(posedge reconfig_xcvr_clk or negedge npor) begin
      if (npor == 1'b0) begin
         por_r           <= 2'b11;
         mgmt_rst_reset  <= 1'b1;
      end
      else begin
         por_r[0]       <= 1'b0;
         por_r[1]       <= por_r[0];
         mgmt_rst_reset <= por_r[1];
      end
   end

   alt_xcvr_reconfig #(
           .device_family                 ("Stratix V"),
           .number_of_reconfig_interfaces (number_of_reconfig_interfaces),
           .enable_offset                 (1),
           .enable_analog                 (0),
           .enable_eyemon                 (0),
           .enable_dfe                    (0),
           .enable_direct                 (0)
   ) top_inst (
           .reconfig_to_xcvr          (reconfig_to_xcvr),          //   reconfig_to_gxb.export
           .reconfig_from_xcvr        (reconfig_from_xcvr),        // reconfig_from_gxb.export
           .reconfig_busy             (reconfig_busy),             //     reconfig_busy.export
           .mgmt_clk_clk              (reconfig_xcvr_clk),                  //    mgmt_rst_reset.reset
           .mgmt_rst_reset            (mgmt_rst_reset),    //    mgmt_rst_reset.reset
           .reconfig_mgmt_address     (reconfig_mgmt_address),     //     reconfig_mgmt.address
           .reconfig_mgmt_read        (reconfig_mgmt_read),        //                  .read
           .reconfig_mgmt_readdata    (reconfig_mgmt_readdata),    //                  .readdata
           .reconfig_mgmt_waitrequest (reconfig_mgmt_waitrequest), //                  .waitrequest
           .reconfig_mgmt_write       (reconfig_mgmt_write),       //                  .write
           .reconfig_mgmt_writedata   (reconfig_mgmt_writedata)    //                  .writedata
   );


endmodule
