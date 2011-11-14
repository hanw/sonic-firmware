onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Problematic signals}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/rx_dma_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/waitrequest
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/open_rx_retry0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/open_rx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/open_rx_be0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/open_read_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/ctl_wr_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/ctl_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/ctl_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_req_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_desc_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_data_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_dv_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_dfr_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ack_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ws_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/enable_sfp1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/enable_sfp2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_write/ctl_wr_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_write/ctl_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_write/ctl_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_write/rx_be
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_write/write_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_write/write_address
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/ctl_wr_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/ctl_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/ctl_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/read_address
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/read_data
add wave -noupdate -divider {Rx DPRAM}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/almost_empty
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/almost_full
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/BUFFER_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/data_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/empty
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/full
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_datavalid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/gearbox_out
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/INPUT_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/OUTPUT_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rd_address_owords
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rd_allowed
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rdclock
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rdena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/rdusedqwords
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/READ_BYTE_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/read_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/reset
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/waitrequest
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/wrclock
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/wrptr_qwords
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/wrreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/ep_rx_dpram/wrusedqwords
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/init
add wave -noupdate -divider {IRQ PRG REG}
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/irq_msi_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/app_msi_num
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/app_msi_tc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/AVALON_ST_128
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/EP_ADDR_DW0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/EP_ADDR_DW1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/EP_ADDR_DW2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/EP_ADDR_DW3
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/init
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/init_shift
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/irq_base_rc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/irq_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/irq_prg_addr_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/irq_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/irq_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/irq_prg_wrdata_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/irq_prg_wrena_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/prg_reg_DW0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/prg_reg_DW1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/prg_reg_DW2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/prg_reg_DW3
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/RC_64BITS_ADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/rstn
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/rx_block_size
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_reg/soft_irq_reset
add wave -noupdate -divider {IRQ GEN}
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/irq_msi_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/init
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_err
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_busy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/tx_ready_others
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/app_msi_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/app_msi_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/msi_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/msi_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/msi_busy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/rx_block_size
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/rdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/irq_base_rc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/cstate
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/nstate
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/reset
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/rx_dma_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/dmaed_data_count
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_gen/rx_block_size_reg
add wave -noupdate -divider Sonic_rx_ctl
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_msi_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/app_msi_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/app_msi_num
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/app_msi_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/app_msi_tc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_base_rc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/msi_busy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/msi_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/msi_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/rd_clock
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/rd_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/rd_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/rdena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/rdena_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/reset
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/rx_almost_empty
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/rx_almost_full
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/rx_empty
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/rx_full
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/tx_busy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/tx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/tx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/tx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/tx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/tx_err
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/tx_ready_others
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/tx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/tx_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/wr_clock
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/wrena_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/wrreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rx_buf/wrreq_reg
add wave -noupdate -divider RC_slave
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/AVALON_BYTE_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/AVALON_ST_128
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/AVALON_WADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/AVALON_WDATA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/cfg_busdev
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/cmd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/cmd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/dma_rd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/dma_rd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/dma_wr_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/dma_wr_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/irq_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/mem_rd_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/mem_rd_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/mem_rd_data_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/mem_rd_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/mem_wr_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/mem_wr_be
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/mem_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/mem_wr_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/read_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/reg_rd_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/reg_rd_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/reg_rd_data_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/reg_wr_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/reg_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/rx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/rx_be
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/rx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/rx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/rx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/rx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/rx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/rx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/sel_ep_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/sel_epmem
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/tx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/tx_busy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/tx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/tx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/tx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/tx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/tx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/tx_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/tx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/write_dma_status
add wave -noupdate -divider bar_reg_access
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/ADDR_LSW
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/ADDR_MSW
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/CMD_PARAM0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/CMD_PARAM1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/CMD_PARAM2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/cmd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/cmd_prg_rddata_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/cmd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/CMD_RESP
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/CMD_TYPE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/CNTL_FIELD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/COMMAND
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/dma_rd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/dma_rd_prg_rddata_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/dma_rd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/DMA_READ_PRG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/dma_wr_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/dma_wr_prg_rddata_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/dma_wr_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/DMA_WRITE_PRG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/ERR_STATUS
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/err_status_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/IRQ_ADDR_HI
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/IRQ_ADDR_LO
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/irq_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/irq_prg_rddata_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/MISC
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/read_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/read_dma_status_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/READ_DMA_STATUS_REG_HI
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/READ_DMA_STATUS_REG_LO
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_addr_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_data_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_ena_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_ena_reg2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_rd_ena_reg3
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_addr_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_data_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/reg_wr_ena_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/RX_IRQ
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/sel_ep_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/sel_ep_reg_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/write_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/write_dma_status_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/WRITE_DMA_STATUS_REG_HI
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_rc_slave/bar_reg_access/WRITE_DMA_STATUS_REG_LO
add wave -noupdate -divider {CMD ctrl}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_3dw_rcadd
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_base_rc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_cycle
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_done
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_param0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_param0_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_param1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_param1_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_param2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_param2_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_type
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_type_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cstate
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/enable_sfp1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/enable_sfp2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/init
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/irq_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/irq_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/local_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/local_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/local_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/mux_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/mux_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/mux_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/nstate
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/reset
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/RESP_DATA_DWORDS
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/RESP_DATA_OWORDS
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/response_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/response_error_code
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/RX_RING_SIZE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_busy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_err
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_ready_others
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/tx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/USEDW_WIDTH
add wave -noupdate -divider {CMD reg}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/AVALON_ST_128
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_3dw_rcadd
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_base_rc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_param0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_param1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_param2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/cmd_type
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/EP_ADDR_DW0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/EP_ADDR_DW1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/EP_ADDR_DW2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/EP_ADDR_DW3
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/EP_ADDR_DW4
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/EP_ADDR_DW5
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/init
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/init_shift
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW3
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW4
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW4_is_zero
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/prg_reg_DW5
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/RC_64BITS_ADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/soft_cmd_reset
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_addr_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_wrdata_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/cmd_prg_reg/sonic_cmd_prg_wrena_reg
add wave -noupdate -divider {CMD RC UPDATE}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/base_rc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/cstate
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/DATA_DWORDS
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/DATA_OWORDS
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/init
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/intr_data_upd_cycle
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/MWR_DV
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/MWR_REQ
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/nstate
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/reset
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/START_TX
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_busy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_data_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_desc_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_dfr_complete
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_dfr_ow_counter
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_dfr_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_err
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_fbe_d
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_lbe_d
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_ready_others
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_delay
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_p1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_pulse
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_req_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_tag
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_cmd/rc_update/tx_ws_val
add wave -noupdate -divider Application
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sw_rstn
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/hw_rstn
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/g_rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/address_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/address_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_int_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_int_ack_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_int_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_int_sts
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_num
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_num_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_num_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_num_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_num_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_req_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_req_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_req_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_req_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_tc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_tc_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_tc_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_tc_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_tc_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/AVALON_BYTE_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/AVALON_ST_128
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/AVALON_WADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/AVALON_WDATA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/BOARD_DEMO
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/CDMA_AST_RXWS_LATENCY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_busdev
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_busdev_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_devcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_link_negociated
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_linkcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_maxpload
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_maxpload_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_maxrdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_maxrdreq_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_maxrdreq_rxbuffer
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_msicsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_msicsr_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_prmcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_tcvcmap
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/CHECK_BUS_MASTER_ENA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/clk_100
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/CLK_250_APP
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cmd_ctl_irq_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cmd_ctl_irq_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cmd_ctl_irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cmd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cmd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/CNT_50MS
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cpl_cnt_50ms
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cpl_err
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cpl_err0_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cpl_pending
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cpl_pending_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cpl_pending_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cpld_rx_buffer_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cst_one
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cst_std_logic_vector_type_one
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cst_std_logic_vector_type_zero
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cst_zero
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/ctl_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/ctl_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/ctl_wr_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/descriptor_mrd_cycle_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/descriptor_mrd_cycle_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_rd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_rd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/DMA_READ_PRIORITY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_tx_idle
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_tx_idle_p0_tx_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_wr_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_wr_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/DMA_WRITE_PRIORITY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/err_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/FIFO_DEPTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/FIFO_WIDTHU
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/init_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/init_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/int_deassert
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/INTENDED_DEVICE_FAMILY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/interrupt_ack_int
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/ko_cpl_spc_vc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/kod_cfg_compare
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/kod_cfg_maxrdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/koh_cfg_compare
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/koh_cfg_maxrdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/MAX_NUMTAG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/MAX_PAYLOAD_SIZE_BYTE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/msi_busy_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/msi_busy_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/msi_busy_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/msi_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/msi_ready_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/msi_ready_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/msi_ready_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/msi_sel_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/msi_sel_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/msi_sel_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/open_read_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/pci_bus_master_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/pci_mem_addr_space_decoder_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/phy_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/RC_64BITS_ADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rc_slave_irq_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rc_slave_irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rc_slave_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rc_slave_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/RC_SLAVE_USETAG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/read_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/read_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/readdata_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/requester_mrdmwr_cycle_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/requester_mrdmwr_cycle_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ack_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ack_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ack_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_be0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_buffer_cpl_max_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ctl_irq_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ctl_irq_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ctl_irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_data_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_desc_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_dfr_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_dv_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ecrc_failure
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_req_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_req_p1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_req_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_req_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/RX_RING_SIZE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ws_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ws_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ws_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sm_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sm_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/TL_SELECTION
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ack_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_busy_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_busy_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_busy_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_busy_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_busy_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_busy_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_busy_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_cred0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_cred0_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_data_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_data_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_data_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_data_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_data_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_data_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_desc_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_desc_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_desc_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_desc_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_desc_fmt_type
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_desc_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_desc_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dfr_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dfr_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dfr_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dfr_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dfr_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dfr_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dv_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dv_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dv_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dv_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dv_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dv_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_err0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_err_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_err_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_err_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_err_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_err_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_err_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_mask_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_mrd
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_rdy_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_rdy_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_rdy_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_rdy_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_rdy_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_rdy_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_command_others
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_command_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_descriptor_dmard_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_descriptor_dmawr_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_interrupt_others
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_interrupt_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_requester_dmard_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ready_requester_dmawr_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_req_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_req_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_req_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_req_dmard_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_req_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_req_dmawr_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_req_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_req_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_descriptor_dmard_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_descriptor_dmawr_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_interrupt_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_pcnt_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_reg_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_reg_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_reg_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_reg_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_reg_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_reg_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_requester_dmard_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_requester_dmawr_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_sel_slave
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_stop_dma_write
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_stream_ready0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_stream_ready0_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ws_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/TXCRED_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/USE_CREDIT_CTRL
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/USE_DMAREAD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/USE_DMAWRITE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/USE_MSI
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/waitrequest_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/waitrequest_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/write_byteena_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/write_byteena_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/write_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/write_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/write_priority_over_read
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/writedata_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/xcvr_rx_clkout
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/xcvr_rx_dataout
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/app_msi_ack
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/app_msi_num
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/app_msi_req
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/app_msi_tc
add wave -noupdate -divider {DMA read}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/AVALON_BYTE_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/AVALON_ST_128
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/AVALON_WADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/AVALON_WDATA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/BOARD_DEMO
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/CDMA_AST_RXWS_LATENCY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/cfg_busdev
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/cfg_link_negociated
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/cfg_maxpload
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/cfg_maxpload_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/cfg_maxrdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/cfg_maxrdreq_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/cpl_pending
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/cpl_pending_descriptor
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/cpl_pending_requestor
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/ctl_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/ctl_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/ctl_wr_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/descriptor_mrd_cycle
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/DIRECTION
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/DISPLAY_SM
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dma_fifo_wrreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dma_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dma_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dma_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dma_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dma_sm
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dma_sm_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dma_sm_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_3dw_rcadd
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_base_rc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/DT_EP_ADDR_SPEC
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_eplast_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_fifo_empty
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_fifo_q
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_fifo_q_4K_bound
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_fifo_rdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_msi
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_rc_last
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_rc_last_sync
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/dt_size
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/FIFO_DEPTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/FIFO_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/FIFO_WIDTHU
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/init
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/INTENDED_DEVICE_FAMILY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/MAX_NUMTAG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/MAX_NUMTAG_LIMIT
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/MAX_PAYLOAD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/msi_busy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/msi_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/msi_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/RC_64BITS_ADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/RC_SLAVE_USETAG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/read
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/read_address
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/read_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/read_wait
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/requester_mrdmwr_cycle
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_ack_descriptor
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_ack_requester
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_be
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_buffer_cpl_max_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_req_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_req_p1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/rx_ws_requester
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tag_cpl
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/TL_SELECTION
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_busy_descriptor
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_busy_requester
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_cred
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_desc_descriptor
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_desc_requester
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_err
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_have_creds
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_ready_descriptor
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_ready_other_dma
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_ready_requester
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_req_descriptor
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_req_requester
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_sel_descriptor
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_sel_requester
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/tx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/TXCRED_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/USE_CREDIT_CTRL
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/USE_DMAREAD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/USE_DMAWRITE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/USE_MSI
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/write
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/write_address
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/write_byteena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_read/write_data
add wave -noupdate -divider XCVR
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/ael_powerdown
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/ael_reset_n
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/alive_cnt
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/busy
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/cal_blk_clk
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/csr_address
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/csr_read
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/csr_readdata
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/csr_waitrequest
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/csr_write
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/csr_writedata
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/data_error
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/enable_sfp
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/gxb_powerdown
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/mdc
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/mdio
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/mdio_in
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/mdio_oen
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/mdio_out
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/phy_ready
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/phy_reconfig_done
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/phy_reset
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/pll_156_lock
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/pll_156m
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/pll_locked
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/pll_powerdown
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/reconfig_fromgxb
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/reconfig_togxb
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/ref_clk_100
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/ref_clk_644_locked
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/ref_clk_644m
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_analogreset
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_buf_almost_empty
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_buf_almost_full
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_buf_empty
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_buf_full
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_clkout
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_cnt
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_datain
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_dataout
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_digitalreset
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_freqlocked
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_pll_locked
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/rx_syncstatus
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/sample_clk
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/sys_reset
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/sys_reset_in
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/tx_clkout
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/tx_cnt
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/tx_ctrlenable
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/tx_datain
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/tx_dataout
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/tx_digitalreset
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/user_led
add wave -noupdate /sonic_chaining_testbench/ep/xcvr/verifier_lock
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15567300 ps} 0}
configure wave -namecolwidth 298
configure wave -valuecolwidth 116
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
WaveRestoreZoom {25151065 ps} {40718365 ps}
