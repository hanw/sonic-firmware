onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/AVALON_WADDR
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/AVALON_WDATA
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/MAX_NUMTAG
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/MAX_PAYLOAD_SIZE_BYTE
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_st_bardec0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_st_be0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_st_data0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_st_empty0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_st_err0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_st_sop0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_st_eop0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_st_valid0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_st_ready0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_st_data0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_st_empty0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_st_eop0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_st_err0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_st_sop0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_st_valid0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_st_ready0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_stop_dma_write
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/pex_msi_num
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app_msi_req
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app_msi_ack
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app_msi_tc
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app_msi_num
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app_int_sts
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app_int_ack
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_stream_mask0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_stream_cred0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_stream_fifo_empty0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/cfg_busdev
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/cfg_devcsr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/cfg_prmcsr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/cfg_tcvcmap
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/cfg_linkcsr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/cfg_msicsr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/cpl_pending
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/cpl_err
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/err_desc
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/xcvr_rx_clkout
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/xcvr_tx_clkout
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/xcvr_rx_dataout
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/xcvr_tx_datain
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/pma_tx_ready
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/pma_rx_ready
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/gen2_speed
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/clk_in
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/reset_reset_n
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/rst_controller_reset_out_reset
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_stream_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_stream_data0_1
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_stream_valid0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/rx_stream_ready0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_stream_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_stream_data0_1
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_stream_ready0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/tx_stream_valid0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/open_msi_stream_data0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/open_msi_stream_valid0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/gnd_msi_stream_ready0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/open_pm_data
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/gnd_cfg_tcvcmap_icm
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/open_aer_msi_num
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/ko_cpl_spc_vc0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/gnd_tx_stream_mask0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/gnd_pm_data
add wave -noupdate -divider Application
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_ack0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_ws0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_req0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_desc0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_be0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_dv0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_dfr0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_req0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_mask0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_ack0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_desc0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_ws0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_err0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_dv0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_dfr0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_descriptor_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_requester_dmawr
add wave -noupdate -divider {CMD RC UPDATE}
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_dv
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_busy
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/sfp1_on
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/sfp2_on
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/intr_data_upd_cycle
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_dfr_complete
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/addrval_32b_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_delay
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_p1
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/START_TX
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/MWR_REQ
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/MWR_DV
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/MODE
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/DATA_DWORDS
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/DATA_OWORDS
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/base_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/cmd_response
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/cmd_error_code
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/byte_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/byte_sent
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/byte_dropped_tx
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/byte_dropped_rx
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_dfr_ow_counter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_desc_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_data_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/init
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_ws
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_dfr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_err
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_ready_others
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_dfr_p0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_ws_val
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_tag
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_lbe_d
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_fbe_d
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_pulse
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_p0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/cstate
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/rc_update/nstate
add wave -noupdate -divider {CMD REG}
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_3dw_rcadd
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/init
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/soft_cmd_reset
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/init_shift
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW4_is_zero
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_rddata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_type
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_param0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_param1
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_param2
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_base_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW1
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW2
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW3
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW4
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW5
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_addr_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_wrena_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_wrdata_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_wrdata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_addr
add wave -noupdate -divider {TX CTRL}
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/wr_clock
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/rd_clock
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/wr_address_owords
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/wr_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/wr_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/rd_data
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/tag_cpl
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/tx_prg_wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/tx_prg_wrdata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/tx_prg_addr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/tx_prg_rddata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/tx_empty
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/tx_full
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/tx_almost_full
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/tx_almost_empty
add wave -noupdate -divider {Tx Usedw calculator}
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/rdena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/reset
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/wrclock
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/rdclock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/wrusedqwords_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/full
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/almost_full
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/empty
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/almost_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/rdusedqwords_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/full_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/almost_full_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/empty_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/almost_empty_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/wrcounter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/clock_crossed_rdcounter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/clock_crossed_rdcounter_prev
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/reads_this_write_cycle
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/reads_this_write_cycle_delay
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/rdreq
add wave -noupdate -radix decimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/wrusedqwords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/writes_this_read_cycle_delay
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/wrreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/rdcounter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/writes_this_read_cycle
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/clock_crossed_wrcounter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/clock_crossed_wrcounter_prev
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/usedw_calculator/rdusedqwords
add wave -noupdate -divider {Tx Circular Buffer}
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/write_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/wr_address_owords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/rdptr_qwords
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_rdreq
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/data_out
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/wrreq
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/rdena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/waitrequest
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/tag_cpl
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/reset
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/rdclock
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/wrclock
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/empty
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/full
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/almost_full
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/almost_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/dpram_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/wrusedqwords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/rdusedqwords
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/rd_tag_cpl
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/rd_cpld_qword_count
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_ena
add wave -noupdate -divider {Tx Gearbox}
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/rdreq
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/clk
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/reset
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/ena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/data_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/data_out
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/state
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/next_state
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/sr0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/shift_r
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/sr1
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/ep_tx_dpram/gearbox_downstream/shift
add wave -noupdate -divider {DMA WRITE}
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/ctl_wr_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/ctl_wr_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/ctl_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_req_p0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_req_p1
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_ws
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_be
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_dv
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_dfr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_buffer_cpl_max_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_ws
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_err
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_dv
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_dfr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_sel_descriptor
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_busy_descriptor
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_ready_descriptor
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_sel_requester
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_busy_requester
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_ready_requester
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/cpl_pending
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tag_cpl
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_ready_other_dma
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_cred
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_have_creds
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/app_msi_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/app_msi_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/app_msi_tc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/app_msi_num
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/msi_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/msi_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/msi_busy
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/cfg_maxpload
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/cfg_maxrdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/cfg_maxpload_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/cfg_maxrdreq_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/cfg_busdev
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/cfg_link_negociated
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/write_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/write_address
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/write
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/write_wait
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/write_byteena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/read_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/read_address
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/read
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/read_wait
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_fifo_wrreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg_wrdata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg_wrena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg_rddata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_sm
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor_mrd_cycle
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/requester_mrdmwr_cycle
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_status
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/init
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_rc_last
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_rc_last_sync
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_3dw_rcadd
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_base_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_eplast_ena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_msi
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_fifo_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_req_descriptor
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_desc_descriptor
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_req_requester
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/tx_desc_requester
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_ack_descriptor
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_ack_requester
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/rx_ws_requester
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_fifo_rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_fifo_q
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dt_fifo_q_4K_bound
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_sm_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_sm_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/cpl_pending_descriptor
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/cpl_pending_requestor
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_tx_buf/tx_almost_empty
add wave -noupdate -divider {RX BUF}
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wr_clock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rd_clock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rd_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/enable_sfp
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wrena_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wrreq_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rdena_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rd_address_owords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rd_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wr_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rxusedqwords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rx_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rx_full
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rx_almost_full
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rx_almost_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wrena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wrreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rdena
add wave -noupdate -divider {RX CTL}
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wr_clock
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rd_clock
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/reset
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rd_req
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/enable_sfp
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wrena_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wrreq_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rdena_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rd_address_owords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rd_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wr_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rxusedqwords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rx_ring_wptr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_datavalid
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rx_empty
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rx_full
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rx_almost_full
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rx_almost_empty
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/wrreq
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/rdena
add wave -noupdate -divider {RX DPRAM}
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/wrreq
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rdena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rdreq
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/waitrequest
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/reset
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rdclock
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/wrclock
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/empty
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/full
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/almost_full
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/almost_empty
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_datavalid
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/data_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/read_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rd_address_owords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rdusedqwords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/wrptr_qwords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/wrusedqwords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_out
add wave -noupdate -divider usedw_calculator
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/wrusedqwords_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/wrusedqwords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/writes_this_read_cycle_delay
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/writes_this_read_cycle
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/WRITE_TO_READ_DELAY
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/wrena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/WR_INCREMENT
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/WIDTH
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/UPSTREAM
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/reads_this_write_cycle_delay
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/reads_this_write_cycle
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/READ_TO_WRITE_DELAY
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/rdusedqwords_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/rdusedqwords
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/rdena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/rdcounter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/rdclock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/RD_INCREMENT
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/QWORD_DEPTH
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/full_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/full
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/empty_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/wrclock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/wrreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/wrcounter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/clock_crossed_wrcounter_prev
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/clock_crossed_wrcounter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/clock_crossed_wptr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/clock_crossed_rdcounter_prev
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/clock_crossed_rdcounter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/almost_full_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/almost_full
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/almost_empty_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/usedw_calculator/almost_empty
add wave -noupdate -divider {Gearbox Upstream}
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/clk
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/valid
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/INPUT_WIDTH
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/OUTPUT_WIDTH
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/data_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/data_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/sr0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/sr1
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/state
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_upstream/next_state
add wave -noupdate -divider IRQ_REG
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_ws
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_ring_wptr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_ready_others
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_err
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_dv
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_dfr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_busy
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/tx_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/rx_ring_wptr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/rx_ring_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/rx_block_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/rd_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/msi_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/msi_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/msi_busy
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_prg_wrena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_prg_wrdata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_prg_rddata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_prg_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_msi_enable
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_init
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_base_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/enable_sfp
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/app_msi_tc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/app_msi_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/app_msi_num
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/app_msi_ack
add wave -noupdate -divider {IRQ Generator}
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/rx_rc_update_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/irq_generated_count
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dt_rc_last_sync
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dt_eplast_ena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dt_msi
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dt_3dw_rcadd
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/init
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/soft_dma_reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/init_shift
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/prg_reg_DW1_is_zero
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/USED_QWORDS_WIDTH
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/USE_MSI
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_ws
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_ring_wptr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_ready_others
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_err
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_dv
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_dfr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_busy
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/tx_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/temp
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/rx_ring_wptr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/rx_ring_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/rx_block_size_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/rx_block_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/nstate
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/msi_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/msi_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/msi_ptr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/msi_offset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/msi_busy
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/irq_msi_enable
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/irq_base_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/INTR_DATA_OWORDS
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/INTR_DATA_DWORDS
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/init
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/enable_sfp
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/cstate
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/clk_in
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/app_msi_req
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_irq/irq_gen/app_msi_ack
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dma_prg_wrena_reg
add wave -noupdate -divider {DMA WRITE REG}
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dma_prg_rddata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dt_rc_last
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dt_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dt_base_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/app_msi_num
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/app_msi_tc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/prg_reg_DW0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/prg_reg_DW1
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/prg_reg_DW2
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/prg_reg_DW3
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dma_prg_wrdata_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dma_prg_addr_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dma_prg_wrena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dma_prg_wrdata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/dma_prg/dma_prg_addr
add wave -noupdate -divider {DMA WRITE DESCRIPTOR}
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/descriptor_mrd_cycle
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/cpl_pending
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/addrval_32b
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_tx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_cnt_eq_zero
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/loop_dma
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/valid_rx_dv_descriptor_cpld
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_ack_pipe
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_cpld_data_on_rx_req_p0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_req_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_req_p1
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/descr_tag_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_cred_non_posted_header_valid
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_rc_last_size_dw_gt_cfg_maxrdreq_dw_fifo_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/init
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/nstate
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/cstate
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_addr_offset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_desc_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_desc_addr_3dw_pipe
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_cnt
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_length_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_length_dw_md
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_length_byte
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/cfg_maxrdreq_dw_fifo_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_rc_last_size_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_rc_last_size_dw_minus_cfg_maxrdreq_dw_fifo_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_rc_last
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_rc_last_sync
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_base_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_3dw_rcadd
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_q
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_q_4K_bound
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/cfg_maxrdreq_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_busy
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_cred
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_have_creds
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_ws
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_buffer_cpl_max_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_dv
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_dfr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dma_sm
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/descr_tag
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_addr_offset_dw_ext
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_addr_offset_qw_ext
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_desc_addr_pipe
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_q_int
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_sclr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_full
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_buffer_cpl_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/scfifo_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_usedw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_data_int
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/dt_fifo_wrreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_lbe_d
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_fbe_d
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tlp_rx_type
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tlp_rx_fmt
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_tag_descriptor_wire
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_length_dw_ext16
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/tx_length_dw_max
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_ack_descrpt_ena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_ack_descrpt_ena_p0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/descriptor/rx_req_p0
add wave -noupdate -divider {RC SLAVE}
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/prg_wrdata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/prg_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/err_status_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/read_dma_status_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/write_dma_status_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/dma_rd_prg_rddata_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/dma_wr_prg_rddata_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/irq_prg_rddata_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/cmd_prg_rddata_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_addr_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_addr_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_data_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/sel_ep_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_ena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_ena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/dma_rd_prg_rddata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/dma_wr_prg_rddata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/irq_prg_rddata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/cmd_prg_rddata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/read_dma_status
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/write_dma_status
add wave -noupdate -divider RXTX_DOWNSTREAM_INTF
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_be
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/reg_wr_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/reg_rd_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/reg_wr_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/cstate_rx
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/cstate_tx
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/cfg_busdev_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_tag
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_reqid
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_length
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_tag
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_req_id
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_lbe
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_length
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/num_dw_to_read
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/mem_num_to_read
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/mem_num_to_read_minus_one
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_rd_count
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/mem_read_count
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_data_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/cfg_busdev
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_be
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_dv
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_dfr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_ws
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ws
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_data_valid
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/reg_rd_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/reg_rd_data_valid
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_bar_hit_n
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/tx_arb_granted
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/start_tx
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_rd
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_almost_full
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_downstream_req_n
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_rdreq_n
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_wrreq_n
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_msg_n
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_data_out
add wave -noupdate -divider {Write Requester}
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/DT_FIFO
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/DT_FIFO_RD_QW0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/DT_FIFO_RD_QW1
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/TX_LENGTH
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/START_TX
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/MWR_REQ
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/MWR_DV
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/DONE
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/TX_DONE_WS
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/START_TX_UPD_DT
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/MWR_REQ_UPD_DT
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/MWR_DV_UPD_DT
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/IDLE_MSI
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/START_MSI
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/MWR_REQ_MSI
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_length_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_length_ow
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_length_ow_minus_one_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cfg_maxpload_dw_plus_two
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cdt_length_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_desc_addr_4k_3dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_desc_addr_4k_4dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/calc_4kbnd_done_byte
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/maxpload_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cstate
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/nstate
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cstate_last
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cstate_msi
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/nstate_msi
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_ep_last
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/address_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/wrreq_d
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_dfr_ow_counter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_desc_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_max_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_addr_eplast
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_data_eplast
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/readdata_m_next
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/performance_counter
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_desc_addr_n_reg
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_desc_addr_plus_tx_length_byte_32ext
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_fifo_rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_fifo_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_fifo_q
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cfg_maxpload_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cfg_maxpload
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cfg_link_negociated
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_base_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_3dw_rcadd
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_eplast_ena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_msi
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_fifo_q_4K_bound
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_ready_dmard
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_cred
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_dfr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_ws
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/ep_lastupd_cycle
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/app_msi_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/app_msi_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/msi_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/msi_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/msi_busy
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/address
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/waitrequest
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/read
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/readdata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/descriptor_mrd_cycle
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dma_sm
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dma_status
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dma_fifo_wrreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_ep_last
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/init
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_length_ow_minus_one
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_length_byte
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_length_byte_32ext
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_length_byte_64ext
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cfg_maxpayload_dw_ext_10
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cdt_length_byte
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/cfg_maxpload_byte
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_desc_addr_4k
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_fifo_q_addr_4k
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/calc_4kbnd_dt_fifo_byte
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/calc_4kbnd_done_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/calc_4kbnd_dt_fifo_dw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/read_int
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_sclr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_ep_last
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_wrreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_ready_to_read
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_q
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_usedw
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_full
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_dfr_p0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_dfr_add
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_dv_ws_wait
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_ws_val
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_dfr_non_qword_aligned_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_desc_addr_pipe
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_addr_eplast_pipe
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_data_avalon
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/readdata_m
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_tag
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_lbe_d
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_fbe_d
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_cred_posted_header_valid
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_cred_posted_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_cred_posted_data_inf
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_req_pulse
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_req_p0
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/dt_fifo_ep_addr_byte
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/inhibit_fifo_rd_n
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/addr_end
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_start_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_start_addr_n
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/tx_desc_addr_n
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/txadd_3dw_n
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/epmem_read_cycle
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/addrval_32b
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_write/genblk1/genblk1/write_requester_128/addrval_32b_eplast
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/clk_in
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/hw_rstn
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_busdev
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_devcsr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_prmcsr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_tcvcmap
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_linkcsr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_msicsr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/ko_cpl_spc_vc0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cpl_pending
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cpl_err
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/err_desc
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_ack
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_req
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_tc
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_num
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_int_sts
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_int_ack
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/xcvr_rx_clkout
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/xcvr_tx_clkout
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/xcvr_rx_dataout
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/xcvr_tx_datain
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ack0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_mask0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ws0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_req0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_desc0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_data0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_be0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_dv0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_dfr0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ecrc_bad_cnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_req0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ack0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_desc0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dv0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dfr0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ws0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_data0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_err0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_mask0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cpld_rx_buffer_ready
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_cred0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_buffer_cpl_max_dw
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_stream_ready0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/g_rstn
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sw_rstn
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_int_req
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_int_ack_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/interrupt_ack_int
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/msi_enable
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/int_deassert
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/writedata_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/address_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/write_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/waitrequest_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/write_byteena_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/open_read_data
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/readdata_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/address_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/read_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/waitrequest_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/write_byteena_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/ctl_wr_req
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/ctl_wr_data
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/ctl_addr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_maxpload_dw
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_maxrdreq_dw
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_maxrdreq_rxbuffer
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/koh_cfg_maxrdreq
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/kod_cfg_maxrdreq
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_maxrdreq
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_maxpload
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_link_negociated
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_busdev_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cfg_msicsr_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_cred0_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_mask_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_stream_ready0_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rc_slave_prg_wrdata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rc_slave_prg_addr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_rd_prg_wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_wr_prg_wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rc_slave_irq_prg_wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rc_slave_tx_prg_wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cpl_pending_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cpl_pending_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/read_dma_status
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/write_dma_status
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_wr_prg_rddata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_rd_prg_rddata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rc_slave_irq_prg_rddata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rc_slave_tx_prg_rddata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cst_one
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cst_zero
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cst_std_logic_vector_type_one
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cst_std_logic_vector_type_zero
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_req_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_req_p1
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_req_p0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/pci_bus_master_enable
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/pci_mem_addr_space_decoder_enable
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/koh_cfg_compare
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/kod_cfg_compare
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ack_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ws_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_req_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_desc_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_err_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dv_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dfr_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_data_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_descriptor_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_busy_descriptor_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_descriptor_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_descriptor_dmawr_r
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_requester_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_busy_requester_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_requester_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_requester_dmawr_r
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/requester_mrdmwr_cycle_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/descriptor_mrd_cycle_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/init_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sm_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_req_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_tc_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_num_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/msi_ready_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/msi_busy_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/msi_sel_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_rdy_descriptor_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_rdy_requester_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_rdy_descriptor_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_rdy_requester_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_rdy_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_rdy_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_fifo_wrreq
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_req_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_desc_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dfr_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dv_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_data_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_err_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_busy_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_command_r
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_command_others
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_req_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_desc_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dfr_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dv_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_data_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_err_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_busy_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_interrupt_r
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_interrupt_others
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_req_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_tc_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_num_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/msi_sel_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/msi_ready_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/msi_busy_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cmd_prg_rddata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cmd_prg_wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cmd_ctl_irq_prg_wrdata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cmd_ctl_irq_prg_wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cmd_ctl_irq_prg_addr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/enable_sfp1
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ctl_irq_prg_wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ctl_irq_prg_wrdata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ctl_irq_prg_addr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ctl_prg_wrena
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ctl_prg_wrdata
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ctl_prg_addr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tag_cpl
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ack_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ws_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_req_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_desc_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_err_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dv_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dfr_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_data_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_descriptor_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_busy_descriptor_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_descriptor_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_descriptor_dmard_r
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_requester_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_busy_requester_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_requester_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_requester_dmard_r
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_req_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_tc_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_num_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/msi_ready_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/msi_busy_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/msi_sel_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/requester_mrdmwr_cycle_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/descriptor_mrd_cycle_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/init_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sm_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_req_dmard_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_req_dmawr_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_req_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ack_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_desc_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_data_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ws_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_dv_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_dfr_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_req_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ack_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_desc_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ws_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_err_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dv_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dfr_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_data_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_busy_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_ready_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dv_dmard_mux
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_dfr_dmard_mux
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_req_dmard_mux
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_err_dmard_mux
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_desc_dmard_mux
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_data_dmard_mux
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_slave
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_tx_idle
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/dma_tx_idle_p0_tx_sel
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/write_priority_over_read
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_descriptor_dmawr_p0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_descriptor_dmard_p0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_requester_dmawr_p0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_requester_dmard_p0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_pcnt_p0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_interrupt_p0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_command_p0
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_reg_descriptor_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_reg_descriptor_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_reg_requester_dmawr
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_reg_requester_dmard
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_reg_pcnt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_reg_interrupt
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_sel_reg_command
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/rx_ecrc_failure
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_req_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_num_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/app_msi_tc_reg
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cpl_cnt_50ms
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_mrd
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/tx_desc_fmt_type
add wave -noupdate /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/cpl_err0_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15813253 ps} 0}
configure wave -namecolwidth 226
configure wave -valuecolwidth 324
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {210 us}
