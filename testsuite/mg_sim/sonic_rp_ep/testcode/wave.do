onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider EP
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/xcvr_tx_datain
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/xcvr_tx_clkout
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/xcvr_rx_dataout
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/xcvr_rx_clkout
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_stream_valid0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_stream_ready0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_stream_fifo_empty0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_stream_data0_1
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_stream_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_stream_cred0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_st_valid0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_st_sop0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_st_ready0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_st_err0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_st_eop0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_st_empty0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/tx_st_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_stream_valid0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_stream_ready0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_stream_mask0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_stream_data0_1
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_stream_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_st_valid0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_st_sop0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_st_ready0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_st_err0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_st_eop0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_st_empty0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_st_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_st_be0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rx_st_bardec0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/pma_tx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/pma_rx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/pex_msi_num
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/open_pm_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/open_msi_stream_valid0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/open_msi_stream_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/open_aer_msi_num
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/ko_cpl_spc_vc0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/gnd_tx_stream_mask0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/gnd_pm_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/gnd_msi_stream_ready0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/gnd_cfg_tcvcmap_icm
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/gen2_speed
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/err_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/cpl_pending
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/cpl_err
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/cfg_tcvcmap
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/cfg_prmcsr
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/cfg_msicsr
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/cfg_linkcsr
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/cfg_devcsr
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/cfg_busdev
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app_msi_tc
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app_msi_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app_msi_num
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app_msi_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app_int_sts
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app_int_ack
add wave -noupdate -divider RP
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/pld_clk
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/rstn
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/cfg_io_bas
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/cfg_np_bas
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/cfg_pr_bas
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/rx_st_sop
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/rx_st_valid
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/rx_st_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/rx_st_eop
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/rx_st_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/rx_st_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/rx_st_be
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/rx_st_mask
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/tx_st_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/tx_st_sop
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/tx_st_eop
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/tx_st_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/tx_st_valid
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/tx_st_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/tx_fifo_empty
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_log_common_dummy_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/driver_rp_dummy_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common_dummy_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common_dummy_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/ltssm_dummy_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/tx_st_data_int
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/srstn_r
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/srstn_rr
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/tx_st_err
add wave -noupdate -group {VC Root Port} -divider VC
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/clk_in
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rstn
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_mask
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_cred
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/cfg_io_bas
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/cfg_np_bas
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/cfg_pr_bas
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_sop
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_valid
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_ready
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_eop
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_empty
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_data
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_be
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_ready
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_sop
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_eop
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_empty
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_valid
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_data
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_fifo_empty
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_stream_data_0
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_stream_data_1
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_sop_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_eop_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_empty_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_data_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_be_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_ready_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_valid_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_bardec
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/empty
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/almost_full
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/unused_st
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_ready_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_data_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_sop_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_eop_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_empty_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/tx_st_valid_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_stream_data_0_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_stream_data_1_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_st_valid_int
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/rx_ecrc_check_valid
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/ecrc_bad_cnt
add wave -noupdate -group {VC Root Port} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/ecrc_err
add wave -noupdate -group {VC ast 128} -divider {VC ast 128}
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/clk_in
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rstn
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_mask
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_be
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_cred
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_err
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/cfg_io_bas
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/cfg_np_bas
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/cfg_pr_bas
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_st_sop
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_st_valid
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_st_ready
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_st_eop
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_st_empty
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_st_data
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_ecrc_err
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_state
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_st_data
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_st_valid
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_st_sop
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_st_eop
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_st_empty
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_st_ready
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_fifo_empty
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_state
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/exp_compl_tag
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/exp_compl_bcount
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_tx_req
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_tx_desc
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_tx_shmem_addr
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_tx_bcount
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_tx_byte_enb
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_rx_ack
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_payld_length
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_payld_length
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_update_pkt_count
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_update_pkt_count
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_desc_int
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_desc_int_v
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_st_data_128
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/clr_pndg
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_pkts
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_qwords
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/tx_dwords
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_pkts
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_qwords
add wave -noupdate -group {VC ast 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/rx_dwords
add wave -noupdate -group vc_intf_common -divider vc_intf_common
add wave -noupdate -group vc_intf_common /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common/dummy_out
add wave -noupdate -group vc_intf_common /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common/perf_req
add wave -noupdate -group vc_intf_common /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common/perf_ack
add wave -noupdate -group vc_intf_common /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common/last_perf_timestamp
add wave -noupdate -group vc_intf_common /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common/reset_in_progress
add wave -noupdate -group vc_intf_common /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common/bfm_max_payload_size
add wave -noupdate -group vc_intf_common /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common/bfm_ep_max_rd_req
add wave -noupdate -group vc_intf_common /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common/bfm_rp_max_rd_req
add wave -noupdate -group vc_intf_common /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common/tc2vc_map
add wave -noupdate -group vc_intf_common /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_req_intf_common/i
add wave -noupdate -expand -group dma_set_header -divider dma_set_header
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/unused_result
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/bar_table
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/setup_bar
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/multi_message_enable
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/msi_traffic_class
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/msi_number
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/ep_offset
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/dt_size
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/dt_msi
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/dt_eplast
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/dt_dw0
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/dt_dw1
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/dt_dw2
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/dt_direction
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/dt_bdt_msb
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/dt_bdt_lsb
add wave -noupdate -expand -group dma_set_header -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/dma_set_header/stop_dma_loop
add wave -noupdate -group req_intf_vc_req -divider req_intf_vc_req
add wave -noupdate -group req_intf_vc_req -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/req_intf_vc_req/vcnum
add wave -noupdate -group req_intf_vc_req -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/req_intf_vc_req/info_v
add wave -noupdate -group req_intf_vc_req -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/req_intf_vc_req/dummy
add wave -noupdate -group vc_intf_get_req -divider vc_intf_get_req
add wave -noupdate -group vc_intf_get_req -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/vc_intf_get_req/vc_num
add wave -noupdate -group vc_intf_get_req -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/vc_intf_get_req/req_valid
add wave -noupdate -group vc_intf_get_req -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/vc_intf_get_req/req_desc
add wave -noupdate -group vc_intf_get_req -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/vc_intf_get_req/lcladdr
add wave -noupdate -group vc_intf_get_req -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/vc_intf_get_req/imm_valid
add wave -noupdate -group vc_intf_get_req -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/app_vc0/vc_intf_genblk/vc_intf_128_genblk/vc_intf_128/vc_intf_get_req/imm_data
add wave -noupdate -expand -group ebfm_barwr_imm -divider ebfm_barwr_imm
add wave -noupdate -expand -group ebfm_barwr_imm -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/ebfm_barwr_imm/bar_num
add wave -noupdate -expand -group ebfm_barwr_imm -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/ebfm_barwr_imm/bar_table
add wave -noupdate -expand -group ebfm_barwr_imm -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/ebfm_barwr_imm/byte_len
add wave -noupdate -expand -group ebfm_barwr_imm -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/ebfm_barwr_imm/cbar
add wave -noupdate -expand -group ebfm_barwr_imm -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/ebfm_barwr_imm/dummy
add wave -noupdate -expand -group ebfm_barwr_imm -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/ebfm_barwr_imm/imm_data
add wave -noupdate -expand -group ebfm_barwr_imm -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/ebfm_barwr_imm/pcie_offset
add wave -noupdate -expand -group ebfm_barwr_imm -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/drvr/ebfm_barwr_imm/tclass
add wave -noupdate -divider {Descriptor Data Port0}
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_ws0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_req0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_mask0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_err0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_dv0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_dfr0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_desc0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_ack0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_ws0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_req0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_mask0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_dfr0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_dv0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_desc0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_data0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_be0
add wave -noupdate -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_ack0
add wave -noupdate -group {Port 1} -divider {Port 1}
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_int_ack_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_int_req
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_req_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cpl_err0_r
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cpl_pending
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/int_deassert
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/msi_sel_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/msi_sel_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/msi_sel_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/pci_bus_master_enable
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/pci_mem_addr_space_decoder_enable
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ecrc_failure
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_req_p1
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_req_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_mask_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_command_r
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_descriptor_dmard_r
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_descriptor_dmawr_r
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_interrupt_r
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmard_r
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmawr_r
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_req_dmard_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_req_dmawr_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_reg_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_reg_descriptor_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_reg_descriptor_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_reg_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_reg_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_reg_requester_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_reg_requester_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_stream_ready0_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/AVALON_BYTE_WIDTH
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/AVALON_ST_128
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/AVALON_WADDR
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/AVALON_WDATA
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/BOARD_DEMO
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/CDMA_AST_RXWS_LATENCY
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/CHECK_BUS_MASTER_ENA
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/CLK_250_APP
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/CNT_50MS
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/DMA_READ_PRIORITY
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/DMA_WRITE_PRIORITY
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/FIFO_DEPTH
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/FIFO_WIDTHU
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/INTENDED_DEVICE_FAMILY
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/MAX_NUMTAG
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/MAX_PAYLOAD_SIZE_BYTE
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/PORT_NUM
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/RC_64BITS_ADDR
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/RC_SLAVE_USETAG
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/TL_SELECTION
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/TXCRED_WIDTH
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/USE_CREDIT_CTRL
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/USE_DMAREAD
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/USE_DMAWRITE
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/USE_MSI
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_num_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_tc_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_busdev_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_link_negociated
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_maxpload
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_maxpload_dw
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_maxrdreq
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_maxrdreq_dw
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_maxrdreq_rxbuffer
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_msicsr_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cpl_cnt_50ms
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/kod_cfg_compare
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/kod_cfg_maxrdreq
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/koh_cfg_compare
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/koh_cfg_maxrdreq
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_cred0_reg
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/address_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/address_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_int_ack
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_int_sts
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_ack
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_num
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_num_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_num_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_num_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_req
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_req_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_req_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_req_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_tc
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_tc_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_tc_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/app_msi_tc_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/arb_grant
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_busdev
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_devcsr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_linkcsr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_msicsr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_prmcsr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cfg_tcvcmap
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/clk_in
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cmd_ctl_irq_prg_addr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cmd_ctl_irq_prg_wrdata
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cmd_ctl_irq_prg_wrena
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cmd_prg_rddata
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cmd_prg_wrena
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cpl_err
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cpl_pending_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cpl_pending_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cpld_rx_buffer_ready
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cst_one
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cst_std_logic_vector_type_one
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cst_std_logic_vector_type_zero
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/cst_zero
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/ctl_addr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/ctl_wr_data
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/ctl_wr_req
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/descriptor_mrd_cycle_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/descriptor_mrd_cycle_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/dma_fifo_wrreq
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/dma_rd_prg_rddata
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/dma_rd_prg_wrena
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/dma_tx_idle
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/dma_tx_idle_p0_tx_sel
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/dma_wr_prg_rddata
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/dma_wr_prg_wrena
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/enable_sfp1
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/err_desc
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/g_rstn
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/hw_rstn
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/init_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/init_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/interrupt_ack_int
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/ko_cpl_spc_vc0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/msi_busy_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/msi_busy_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/msi_busy_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/msi_enable
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/msi_ready_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/msi_ready_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/msi_ready_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/open_read_data
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/pci_tx_idle
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/pci_tx_idle_p0_tx_sel
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/pma_rx_ready
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/pma_tx_ready
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rc_slave_irq_prg_rddata
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rc_slave_irq_prg_wrena
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rc_slave_prg_addr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rc_slave_prg_wrdata
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rc_slave_tx_prg_rddata
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rc_slave_tx_prg_wrena
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/read_dma_status
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/read_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/readdata_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/requester_mrdmwr_cycle_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/requester_mrdmwr_cycle_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/reset_nios
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ack0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ack_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ack_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ack_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_be0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_block_size
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_buffer_cpl_max_dw
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ctl_irq_prg_addr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ctl_irq_prg_wrdata
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ctl_irq_prg_wrena
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ctl_reset
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_data0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_data_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_desc0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_desc_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_dfr0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_dfr_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_dv0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_dv_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ecrc_bad_cnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_mask0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_req0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_req_p0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_req_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ring_wptr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ws0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ws_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ws_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/rx_ws_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/set_lpbk
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sm_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sm_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sw_rstn
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tag_cpl
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ack0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ack_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_busy_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_busy_descriptor_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_busy_descriptor_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_busy_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_busy_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_busy_requester_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_busy_requester_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_cred0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ctl_reset
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_data0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_data_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_data_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_data_dmard_mux
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_data_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_data_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_data_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_desc0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_desc_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_desc_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_desc_dmard_mux
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_desc_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_desc_fmt_type
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_desc_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_desc_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dfr0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dfr_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dfr_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dfr_dmard_mux
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dfr_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dfr_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dfr_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dv0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dv_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dv_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dv_dmard_mux
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dv_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dv_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_dv_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_err0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_err_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_err_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_err_dmard_mux
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_err_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_err_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_err_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_mask0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_mrd
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_rdy
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_rdy_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_rdy_descriptor_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_rdy_descriptor_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_rdy_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_rdy_requester_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_rdy_requester_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_command_others
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_descriptor_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_descriptor_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_interrupt_others
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_req0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_req_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_req_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_req_dmard_mux
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_req_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_req_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_req_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ring_rptr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_command
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_command_p0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmard_p0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmawr_p0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_interrupt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_interrupt_p0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_pcnt_p0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmard_p0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmawr_p0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_sel_slave
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_stop_dma_write
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_stream_ready0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ws0
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/tx_ws_pcnt
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/unset_lpbk
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/waitrequest_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/waitrequest_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/write_byteena_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/write_byteena_dmawr
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/write_dma_status
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/write_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/write_priority_over_read
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/writedata_dmard
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/xcvr_rx_clkout
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/xcvr_rx_dataout
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/xcvr_tx_clkout
add wave -noupdate -group {Port 1} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/xcvr_tx_datain
add wave -noupdate -group {Port 0} -divider Port0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cpl_pending
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_int_req
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_int_ack_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/int_deassert
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_mask_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_stream_ready0_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_req_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_req_p1
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/pci_bus_master_enable
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/pci_mem_addr_space_decoder_enable
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_descriptor_dmawr_r
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_requester_dmawr_r
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/msi_sel_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_command_r
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_interrupt_r
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/msi_sel_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_descriptor_dmard_r
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_requester_dmard_r
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/msi_sel_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_req_dmard_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_req_dmawr_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_reg_descriptor_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_reg_descriptor_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_reg_requester_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_reg_requester_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_reg_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_reg_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_reg_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ecrc_failure
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_req_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cpl_err0_r
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/MAX_NUMTAG
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/AVALON_WADDR
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/CHECK_BUS_MASTER_ENA
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/AVALON_WDATA
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/MAX_PAYLOAD_SIZE_BYTE
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/BOARD_DEMO
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/TL_SELECTION
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/TXCRED_WIDTH
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/CLK_250_APP
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/RC_64BITS_ADDR
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/USE_CREDIT_CTRL
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/USE_MSI
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/USE_DMAWRITE
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/USE_DMAREAD
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/AVALON_ST_128
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/INTENDED_DEVICE_FAMILY
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/CDMA_AST_RXWS_LATENCY
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/PORT_NUM
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/AVALON_BYTE_WIDTH
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/FIFO_WIDTHU
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/FIFO_DEPTH
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/RC_SLAVE_USETAG
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/DMA_READ_PRIORITY
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/DMA_WRITE_PRIORITY
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/CNT_50MS
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_maxpload_dw
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_maxrdreq_dw
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_maxrdreq_rxbuffer
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/koh_cfg_maxrdreq
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/kod_cfg_maxrdreq
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_maxrdreq
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_maxpload
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_link_negociated
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_busdev_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_msicsr_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_cred0_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/koh_cfg_compare
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/kod_cfg_compare
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_num_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_tc_reg
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cpl_cnt_50ms
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/clk_in
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/hw_rstn
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_busdev
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_devcsr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_prmcsr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_tcvcmap
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_linkcsr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cfg_msicsr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/ko_cpl_spc_vc0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cpl_err
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/err_desc
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_ack
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_req
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_tc
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_num
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_int_sts
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_int_ack
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/xcvr_rx_clkout
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/xcvr_tx_clkout
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/xcvr_rx_dataout
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/xcvr_tx_datain
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/pma_tx_ready
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/pma_rx_ready
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/reset_nios
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/set_lpbk
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/unset_lpbk
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ack0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_mask0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ws0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_req0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_desc0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_data0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_be0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_dv0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_dfr0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ecrc_bad_cnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_req0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ack0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_desc0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dv0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dfr0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ws0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_data0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_err0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_mask0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cpld_rx_buffer_ready
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_cred0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_buffer_cpl_max_dw
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_stream_ready0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/arb_grant
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_rdy
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/dma_tx_idle
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/dma_tx_idle_p0_tx_sel
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/pci_tx_idle
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/pci_tx_idle_p0_tx_sel
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/g_rstn
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sw_rstn
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/interrupt_ack_int
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/msi_enable
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/writedata_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/address_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/write_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/waitrequest_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/write_byteena_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/open_read_data
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/readdata_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/address_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/read_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/waitrequest_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/write_byteena_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/ctl_wr_req
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/ctl_wr_data
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/ctl_addr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rc_slave_prg_wrdata
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rc_slave_prg_addr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/dma_rd_prg_wrena
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/dma_wr_prg_wrena
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rc_slave_irq_prg_wrena
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rc_slave_tx_prg_wrena
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cpl_pending_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cpl_pending_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/read_dma_status
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/write_dma_status
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/dma_wr_prg_rddata
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/dma_rd_prg_rddata
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rc_slave_irq_prg_rddata
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rc_slave_tx_prg_rddata
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cst_one
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cst_zero
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cst_std_logic_vector_type_one
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cst_std_logic_vector_type_zero
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_req_p0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ack_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ws_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_req_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_desc_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_err_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dv_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dfr_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_data_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_descriptor_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_requester_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_descriptor_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_requester_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_busy_descriptor_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_descriptor_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_busy_requester_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_requester_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_stop_dma_write
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/requester_mrdmwr_cycle_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/descriptor_mrd_cycle_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/init_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sm_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_req_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_tc_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_num_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/msi_ready_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/msi_busy_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_rdy_descriptor_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_rdy_requester_dmawr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_rdy_descriptor_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_rdy_requester_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_rdy_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_rdy_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ring_wptr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ring_rptr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/dma_fifo_wrreq
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_req_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_desc_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dfr_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dv_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_data_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_err_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_busy_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_command
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_command_others
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_req_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_desc_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dfr_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dv_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_data_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_err_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_busy_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_interrupt_others
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_req_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_tc_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_num_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/msi_ready_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/msi_busy_interrupt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cmd_prg_rddata
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cmd_prg_wrena
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cmd_ctl_irq_prg_wrdata
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cmd_ctl_irq_prg_wrena
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/cmd_ctl_irq_prg_addr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_block_size
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/enable_sfp1
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ctl_irq_prg_wrena
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ctl_irq_prg_wrdata
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ctl_irq_prg_addr
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ctl_reset
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tag_cpl
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ctl_reset
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ack_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ws_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_req_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_desc_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_err_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dv_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dfr_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_data_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_busy_descriptor_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_descriptor_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_busy_requester_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_requester_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_req_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_tc_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/app_msi_num_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/msi_ready_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/msi_busy_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/requester_mrdmwr_cycle_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/descriptor_mrd_cycle_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/init_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sm_dmard
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_req_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ack_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_desc_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_data_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_ws_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_dv_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/rx_dfr_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_req_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ack_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_desc_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ws_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_err_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dv_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dfr_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_data_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_busy_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_ready_pcnt
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dv_dmard_mux
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_dfr_dmard_mux
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_req_dmard_mux
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_err_dmard_mux
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_desc_dmard_mux
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_data_dmard_mux
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_slave
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/write_priority_over_read
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_descriptor_dmawr_p0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_descriptor_dmard_p0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_requester_dmawr_p0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_requester_dmard_p0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_pcnt_p0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_interrupt_p0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_sel_command_p0
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_mrd
add wave -noupdate -group {Port 0} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/tx_desc_fmt_type
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_descriptor_dmawr
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_requester_dmawr
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_dmawr
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_descriptor_dmard
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_requester_dmard
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_pcnt
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_interrupt
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_command
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_descriptor_dmawr_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_requester_dmawr_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_dmawr_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_descriptor_dmard_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_requester_dmard_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_pcnt_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_interrupt_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_sel_command_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_mask_reg
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_stream_ready0_reg
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/rst_n
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/clk
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/req
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_mask0
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_stream_ready0
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/pci_bus_master_enable
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/pci_tx_idle
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/pci_tx_idle_p0_tx_sel
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/grant
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/select
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_interrupt
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_command
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_requester_dmard
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_requester_dmawr
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_descriptor_dmard
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_descriptor_dmawr
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_ready_pcnt
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_interrupt_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_command_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_requester_dmard_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_requester_dmawr_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_descriptor_dmard_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_rdy_descriptor_dmawr_p1
add wave -noupdate -group {Channel Arbiter} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter/tx_ready_pcnt_p1
add wave -noupdate -group {Two Channels} -divider {Two Channels}
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_msi_req
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_msi_tc
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_msi_num
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/clk_in
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/hw_rstn
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cfg_busdev
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cfg_devcsr
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cfg_prmcsr
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cfg_tcvcmap
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cfg_linkcsr
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cfg_msicsr
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/ko_cpl_spc_vc0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cpl_pending
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cpl_err
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/err_desc
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_msi_ack
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_int_sts
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_int_ack
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/xcvr_rx_clkout
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/xcvr_tx_clkout
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/xcvr_rx_dataout
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/xcvr_tx_datain
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/pma_tx_ready
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/pma_rx_ready
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/reset_nios
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/set_lpbk
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/unset_lpbk
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_ack0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_mask0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_ws0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_req0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_desc0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_data0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_be0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_dv0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_dfr0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_ecrc_bad_cnt
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_req0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_ack0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_desc0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_dv0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_dfr0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_ws0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_data0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_err0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_mask0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cpld_rx_buffer_ready
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_cred0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_buffer_cpl_max_dw
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_stream_ready0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_req_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_desc_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_dv_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_dfr_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_data_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_err_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_req_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_desc_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_dv_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_dfr_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_data_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_err_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_ack_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_ack_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_ws_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_ws_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_mask_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/rx_mask_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_int_sts_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_int_sts_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cpl_err_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cpl_err_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/err_desc_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/err_desc_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cpl_pending_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/cpl_pending_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_msi_req_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_msi_req_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_msi_tc_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_msi_tc_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_msi_num_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/app_msi_num_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter_req
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter_grant
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter_select
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/arbiter_valid
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_rdy_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/tx_rdy_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/pci_tx_idle
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/pci_tx_idle_p0_tx_sel
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/dma_tx_idle_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/dma_tx_idle_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/dma_tx_idle_p0_tx_sel_p1
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/dma_tx_idle_p0_tx_sel_p0
add wave -noupdate -group {Two Channels} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/port_sel
add wave -noupdate -expand -group {Port 1 DS INTF} -divider {Port 1 DS intf}
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_bar_hit_n
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_ack
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_be
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_data
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_desc
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_dfr
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_do_cpl
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_dv
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_msg_n
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_rdreq
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_rdreq_n
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_wrreq
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_wrreq_n
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_req
add wave -noupdate -expand -group {Port 1 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_ws
add wave -noupdate -expand -group {Port 0 DS INTF} -divider {Port 0 DS intf}
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_bar_hit_n
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_ack
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_be
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_data
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_desc
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_dfr
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_do_cpl
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_dv
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_downstream_req_n
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_msg_n
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_rdreq
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_rdreq_n
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_wrreq
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_wrreq_n
add wave -noupdate -expand -group {Port 0 DS INTF} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_req
add wave -noupdate /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/clk_in
add wave -noupdate -group {Rx AST 128} -divider rx_ast_128
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/count_eop_in_rxfifo
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/count_eop_nop
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrl_next_rx_req
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_3dw
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_3dw_del
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_3dw_nonaligned
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_count_length_dqword
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_count_length_dqword_zero
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_count_length_dword
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_digest
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_dw_addroffeset
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_length
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_payload
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_qword_aligned
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/ctrlrx_single_cycle
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/data_tail_be_mask
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_3dw_aligned_dataless
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_3dw_aligned_withdata
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_3dw_dqw_aligned_withdata
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_3dw_dqw_nonaligned_withdata
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_3dw_nonaligned_dataless
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_3dw_nonaligned_withdata
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_4dw_aligned_dataless
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_4dw_aligned_withdata
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_4dw_dqw_aligned_withdata
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_4dw_dqw_nonaligned_withdata
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_4dw_nonaligned_dataless
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/debug_4dw_nonaligned_withdata
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/got_eop
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/insert_extra_dfr_cycle
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/last_eop_in_fifo
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/need_extra_dfr_cycle
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rstn
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_ack0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_ack_pending
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_ack_pending_del
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_be0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_data0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_desc0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_dfr0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_dfr_digest
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_dv0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_ecrc_check_valid
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_eop
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_eop_next
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_eop_p0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_eop_p1
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_rd_req
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_rd_req_del
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_req0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_req_cycle
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_req_del
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_req_phase2
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_sop
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_sop_last
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_sop_next
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_sop_p0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_sop_p1
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_stream_ready0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rx_stream_valid0
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rxdata
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rxdata_be
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rxfifo_d
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rxfifo_empty
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rxfifo_full
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rxfifo_q
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rxfifo_rreq
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rxfifo_usedw
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/rxfifo_wrreq
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/tlp_in_rxfifo
add wave -noupdate -group {Rx AST 128} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/ep_top/app/HIPCAB_128/genblk1/altpcierd_cdma_ast_rx_i_128/wait_rdreq
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097088]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097089]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097090]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097091]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097092]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097093]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097094]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097095]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097096]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097097]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097098]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097099]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097100]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097101]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097102]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097103]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097104]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097105]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097106]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097107]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097108]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097109]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097110]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097111]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097112]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097113]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097114]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097115]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097116]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097117]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097118]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097119]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097120]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097121]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097122]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097123]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097124]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097125]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097126]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097127]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097128]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097129]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097130]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097131]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097132]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097133]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097134]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097135]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097136]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097137]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097138]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097139]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097140]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097141]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097142]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097143]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097144]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097145]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097146]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097147]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097148]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097149]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097150]}
add wave -noupdate -group shmem -radix hexadecimal {/top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_top/bfm_shmem_common/shmem[2097151]}
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/clk_in
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/ctrltx_3dw
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/ctrltx_3dw_reg
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/ctrltx_count_length_dword
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/ctrltx_dw_addroffset_reg
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/ctrltx_length
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/ctrltx_length_reg
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/ctrltx_payload
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/ctrltx_payload_reg
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/ctrltx_single_cycle
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/ctrltx_single_cycle_reg
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/data_tail_be_mask
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/rstn
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_bardec
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_be
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_data
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_data_r
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_empty
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_empty_r
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_eop
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_eop_p0
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_eop_p1
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_eop_r
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_err
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_err_r
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_sop
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_sop_p0
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_sop_p1
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_sop_r
add wave -noupdate -group {Bardec BE} -radix hexadecimal /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_valid
add wave -noupdate -group {Bardec BE} /top/tb/sonic_rp_ep_sim_inst/sonic_rp_ep_top_0/rp_tx_st/tx_st_valid_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {336010 ps} 0}
configure wave -namecolwidth 567
configure wave -valuecolwidth 289
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {11934300 ps}
