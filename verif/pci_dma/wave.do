onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/xcvr_tx_datain
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/xcvr_tx_clkout
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/xcvr_rx_dataout
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/xcvr_rx_clkout
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/USE_RCSLAVE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/USE_MSI
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/USE_DMAWRITE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/USE_DMAREAD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/USE_CREDIT_CTRL
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/TXCRED_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_stream_valid0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_stream_ready0_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_stream_ready0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_stream_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_stream_fifo_empty0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_stream_data0_1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_stream_data0_0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_stream_cred0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_local_fifo_empty
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_fifo_empty_timer_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_fifo_empty_timer
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_err0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/tx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/TL_SELECTION
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/test_sim
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/srst
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_valid0_reg2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_valid0_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_valid0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_ready0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_data0_1_reg2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_data0_1_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_data0_1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_data0_0_reg2
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_data0_0_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_stream_data0_0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_buffer_cpl_max_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_be0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/RC_64BITS_ADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/pma_tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/pma_rx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/pm_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/pex_msi_num
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/open_rx_retry0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/open_rx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/open_rx_be0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/MSI_WAIT_LOCAL_EMPTY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/MSI_WAIT_LATENCY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/MSI_WAIT_CORE_EMPTY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/MSI_WAIT_CORE_ACK
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/msi_stream_valid0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/msi_stream_ready0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/msi_stream_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/msi_req_state_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/msi_req_state
add wave -noupdate -divider {DMA READ}
add wave -noupdate -divider {DMA WRITE}
add wave -noupdate -divider {Application Core Logic}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/USE_MSI
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/USE_DMAWRITE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/USE_DMAREAD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/USE_CREDIT_CTRL
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/TXCRED_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/TL_SELECTION
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_buffer_cpl_max_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_be0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/rx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/RC_64BITS_ADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/pma_tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/pma_rx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/MAX_PAYLOAD_SIZE_BYTE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/MAX_NUMTAG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/ko_cpl_spc_vc0
add wave -noupdate -radix ascii /sonic_chaining_testbench/ep/app/chaining_dma_arb/INTENDED_DEVICE_FAMILY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/hw_rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/err_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cpld_rx_buffer_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cpl_pending
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cpl_err
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/CLK_250_APP
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/CHECK_BUS_MASTER_ENA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_tcvcmap
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_prmcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_msicsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_linkcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_devcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/cfg_busdev
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/CDMA_AST_RXWS_LATENCY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/BOARD_DEMO
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/AVALON_WDATA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/AVALON_WADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/AVALON_ST_128
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_tc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_num
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_msi_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_int_sts
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/app_int_ack
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/sel_ctl_sts
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_sel_epmem
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_bar_hit_n
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/sel_ctl_sts
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_sel_epmem
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_bar_hit_n
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_do_cpl
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_do_cpl
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/cstate_tx
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/cstate_rx
add wave -noupdate -divider Arbiter
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/width
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/select_width
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/select
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/grant
add wave -noupdate -radix hexadecimal {/sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/select[3]}
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/pci_tx_idle
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/pci_tx_idle_p0_tx_sel
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_tx_idle_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_tx_idle_p0_tx_sel_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_tx_idle_p0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_tx_idle_p0_tx_sel_p0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/port_sel
add wave -noupdate -divider {Tx Channel}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_stream_ready0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_err0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_cred0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/tx_ack0
add wave -noupdate -divider {Tx Chan0}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_err0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_cred0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_rdy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_write/genblk1/genblk1/write_requester_128/nstate
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_write/genblk1/genblk1/write_requester_128/cstate
add wave -noupdate -divider {Tx Chan1}
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ws0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_mask0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_err0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dv0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_cred0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_rdy
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_write/genblk1/genblk1/write_requester_128/nstate
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_write/genblk1/genblk1/write_requester_128/cstate
add wave -noupdate -divider {Arbiter One}
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/width
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_stream_ready0_reg
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_stream_ready0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_requester_dmawr
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_requester_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_pcnt
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_interrupt
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_dmawr
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_descriptor_dmawr
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_descriptor_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_command
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_ready_pcnt
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_requester_dmawr
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_requester_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_interrupt
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_descriptor_dmawr
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_descriptor_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_command
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_mask_reg
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_mask0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/select_width
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/select
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/rst_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/req
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/pci_tx_idle_p0_tx_sel
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/pci_tx_idle
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/pci_bus_master_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/grant
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/clk
add wave -noupdate -divider Bug
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/grant
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/pci_tx_idle
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/pci_tx_idle_p0_tx_sel
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_tx_idle_p0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_tx_idle_p0_tx_sel_p0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_tx_idle_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/dma_tx_idle_p0_tx_sel_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/clk
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_reg_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_reg_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_reg_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_reg_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_reg_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_reg_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_reg_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_read/genblk1/genblk1/read_requester_128/cstate_tx
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_read/genblk1/genblk1/read_requester_128/cstate_tx
add wave -noupdate -divider Arbiter
add wave -noupdate -radix hexadecimal {/sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/select[3]}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_req_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_req_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_req_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_req_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_req_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_stop_dma_write
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_mask_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_stream_ready0_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_tx_idle_p0_tx_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_tx_idle
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_ready_to_read
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_write/genblk1/genblk1/write_requester_128/tx_ready_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_write/genblk1/genblk1/write_requester_128/cstate
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_read/genblk1/genblk1/read_requester_128/tx_cred_posted_data_valid
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_read/genblk1/genblk1/read_requester_128/tx_cred_non_posted_header_valid
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_read/genblk1/genblk1/read_requester_128/rx_buffer_cpl_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_read/genblk1/genblk1/read_requester_128/rx_buffer_cpl_max_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_read/genblk1/genblk1/read_requester_128/maxrdreq_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_read/genblk1/genblk1/read_requester_128/cdt_length_dw_tx
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_read/genblk1/genblk1/read_requester_128/cstate_tx
add wave -noupdate -divider {Tx channel 1}
add wave -noupdate -radix hexadecimal {/sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/select[3]}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_command
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_write/genblk1/genblk1/write_requester_128/wr_fifo_ready_to_read
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_write/genblk1/genblk1/write_requester_128/tx_ready_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_write/genblk1/genblk1/write_requester_128/cstate
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_read/genblk1/genblk1/read_requester_128/tx_cred_posted_data_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_read/genblk1/genblk1/read_requester_128/tx_cred_non_posted_header_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_read/genblk1/genblk1/read_requester_128/rx_buffer_cpl_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_read/genblk1/genblk1/read_requester_128/rx_buffer_cpl_max_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_read/genblk1/genblk1/read_requester_128/maxrdreq_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_read/genblk1/genblk1/read_requester_128/cstate_tx
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_read/genblk1/genblk1/read_requester_128/cdt_length_dw_tx
add wave -noupdate -divider {Arbiter X2}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/select
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/grant
add wave -noupdate -divider {arbiter Level 0}
add wave -noupdate -divider {Arbiter Level 1 1}
add wave -noupdate -divider {Arbiter Level 1 0}
add wave -noupdate -divider Port0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/xcvr_tx_datain
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/xcvr_tx_clkout
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/xcvr_rx_dataout
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/xcvr_rx_clkout
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/writedata_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/write_priority_over_read
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/write_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/write_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/write_byteena_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/write_byteena_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/waitrequest_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/waitrequest_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/USE_MSI
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/USE_DMAWRITE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/USE_DMAREAD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/USE_CREDIT_CTRL
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/unset_lpbk
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/TXCRED_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ws_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_stream_ready0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_slave
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_descriptor_dmard_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_requester_dmawr_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_requester_dmard_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_reg_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_reg_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_reg_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_reg_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_reg_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_reg_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_reg_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_pcnt_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_interrupt_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_descriptor_dmawr_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_sel_command_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ring_rptr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_req_dmawr_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_req_dmard_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_req_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_requester_dmawr_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_requester_dmard_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_interrupt_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_interrupt_others
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_descriptor_dmawr_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_descriptor_dmard_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_command_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ready_command_others
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_rdy_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_rdy_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_rdy_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_rdy_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_rdy_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_rdy_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_mrd
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_err_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_err_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_err_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_err_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_err_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_err_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_err0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dv_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dv_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dv_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dv_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dv_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dv_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dfr_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dfr_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dfr_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dfr_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dfr_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dfr_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_desc_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_desc_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_desc_fmt_type
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_desc_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_desc_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_desc_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_desc_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_data_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_data_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_data_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_data_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_data_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_data_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ctl_reset
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ctl_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ctl_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ctl_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_cred0_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_cred0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_busy_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_busy_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_busy_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_busy_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_busy_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_busy_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_busy_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ack_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/TL_SELECTION
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/tag_cpl
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sw_rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sm_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sm_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/set_lpbk
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ws_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ws_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ws_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ring_wptr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_req_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_req_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_req_p1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_req_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ecrc_failure
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_dv_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_dfr_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_desc_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_data_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ctl_reset
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ctl_irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ctl_irq_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ctl_irq_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_buffer_cpl_max_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_block_size
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_be0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ack_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ack_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ack_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/reset_nios
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/requester_mrdmwr_cycle_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/requester_mrdmwr_cycle_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/readdata_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/read_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/read_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/RC_SLAVE_USETAG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rc_slave_tx_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rc_slave_tx_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rc_slave_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rc_slave_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rc_slave_irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/rc_slave_irq_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/RC_64BITS_ADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/pma_tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/pma_rx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/pci_mem_addr_space_decoder_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/pci_bus_master_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/open_read_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/msi_sel_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/msi_sel_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/msi_sel_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/msi_ready_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/msi_ready_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/msi_ready_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/msi_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/msi_busy_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/msi_busy_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/msi_busy_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/MAX_PAYLOAD_SIZE_BYTE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/MAX_NUMTAG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/koh_cfg_maxrdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/koh_cfg_compare
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/kod_cfg_maxrdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/kod_cfg_compare
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/ko_cpl_spc_vc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/interrupt_ack_int
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/INTENDED_DEVICE_FAMILY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/int_deassert
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/init_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/init_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/hw_rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/g_rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/FIFO_WIDTHU
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/FIFO_DEPTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/err_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/enable_sfp1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/DMA_WRITE_PRIORITY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_wr_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_wr_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/DMA_READ_PRIORITY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_rd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_rd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/dma_fifo_wrreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/descriptor_mrd_cycle_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/descriptor_mrd_cycle_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/ctl_wr_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/ctl_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/ctl_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cst_zero
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cst_std_logic_vector_type_zero
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cst_std_logic_vector_type_one
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cst_one
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cpld_rx_buffer_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cpl_pending_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cpl_pending_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cpl_pending
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cpl_err0_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cpl_err
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cpl_cnt_50ms
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/CNT_50MS
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cmd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cmd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cmd_ctl_irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cmd_ctl_irq_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cmd_ctl_irq_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/CLK_250_APP
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/CHECK_BUS_MASTER_ENA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_tcvcmap
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_prmcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_msicsr_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_msicsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_maxrdreq_rxbuffer
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_maxrdreq_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_maxrdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_maxpload_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_maxpload
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_linkcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_link_negociated
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_devcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_busdev_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/cfg_busdev
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/CDMA_AST_RXWS_LATENCY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/BOARD_DEMO
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/AVALON_WDATA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/AVALON_WADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/AVALON_ST_128
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/AVALON_BYTE_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_tc_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_tc_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_tc_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_tc_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_tc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_req_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_req_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_req_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_req_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_num_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_num_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_num_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_num_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_num
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_msi_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_int_sts
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_int_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_int_ack_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/app_int_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/address_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/address_dmard
add wave -noupdate -divider {Port 1}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/xcvr_tx_datain
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/xcvr_tx_clkout
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/xcvr_rx_dataout
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/xcvr_rx_clkout
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/writedata_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/write_priority_over_read
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/write_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/write_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/write_byteena_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/write_byteena_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/waitrequest_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/waitrequest_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/USE_MSI
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/USE_DMAWRITE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/USE_DMAREAD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/USE_CREDIT_CTRL
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/unset_lpbk
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/TXCRED_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ws_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_stream_ready0_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_stream_ready0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_stop_dma_write
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_slave
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmawr_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmard_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_pcnt_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_interrupt_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmawr_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmard_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_command_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_sel_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ring_rptr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_dmawr_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_dmard_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmawr_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmard_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_interrupt_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_interrupt_others
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_descriptor_dmawr_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_descriptor_dmard_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_command_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_command_others
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ready_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_rdy_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_rdy_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_rdy_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_rdy_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_rdy_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_rdy_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_mrd
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_mask_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_err_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_err_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_err_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_err_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_err_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_err_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_err0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dv_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dv_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dv_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dv_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dv_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dv_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dfr_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dfr_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dfr_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dfr_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dfr_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dfr_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_desc_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_desc_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_desc_fmt_type
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_desc_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_desc_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_desc_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_desc_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_data_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_data_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_data_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_data_dmard_mux
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_data_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_data_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ctl_reset
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ctl_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ctl_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ctl_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_cred0_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_cred0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_busy_requester_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_busy_requester_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_busy_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_busy_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_busy_descriptor_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_busy_descriptor_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_busy_command
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ack_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/TL_SELECTION
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/tag_cpl
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sw_rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sm_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sm_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/set_lpbk
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ws_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ws_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ws_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ws0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ring_wptr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_req_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_req_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_req_p1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_req_p0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_req0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_mask0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ecrc_failure
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_dv_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_dv0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_dfr_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_dfr0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_desc_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_desc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_data_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_data0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ctl_reset
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ctl_irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ctl_irq_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ctl_irq_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_buffer_cpl_max_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_block_size
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_be0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ack_pcnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ack_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ack_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rx_ack0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/reset_nios
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/requester_mrdmwr_cycle_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/requester_mrdmwr_cycle_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/readdata_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/read_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/read_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/RC_SLAVE_USETAG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rc_slave_tx_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rc_slave_tx_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rc_slave_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rc_slave_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rc_slave_irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/rc_slave_irq_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/RC_64BITS_ADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/pma_tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/pma_rx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/pci_mem_addr_space_decoder_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/pci_bus_master_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/open_read_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/msi_sel_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/msi_sel_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/msi_sel_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/msi_ready_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/msi_ready_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/msi_ready_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/msi_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/msi_busy_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/msi_busy_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/msi_busy_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/MAX_PAYLOAD_SIZE_BYTE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/MAX_NUMTAG
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/koh_cfg_maxrdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/koh_cfg_compare
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/kod_cfg_maxrdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/kod_cfg_compare
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/ko_cpl_spc_vc0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/interrupt_ack_int
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/INTENDED_DEVICE_FAMILY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/int_deassert
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/init_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/init_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/hw_rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/g_rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/FIFO_WIDTHU
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/FIFO_DEPTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/err_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/enable_sfp1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/DMA_WRITE_PRIORITY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_wr_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_wr_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_tx_idle_p0_tx_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_tx_idle
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/DMA_READ_PRIORITY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_rd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_rd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/dma_fifo_wrreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/descriptor_mrd_cycle_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/descriptor_mrd_cycle_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/ctl_wr_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/ctl_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/ctl_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cst_zero
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cst_std_logic_vector_type_zero
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cst_std_logic_vector_type_one
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cst_one
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cpld_rx_buffer_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cpl_pending_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cpl_pending_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cpl_pending
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cpl_err0_r
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cpl_err
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cpl_cnt_50ms
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/CNT_50MS
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cmd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cmd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cmd_ctl_irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cmd_ctl_irq_prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cmd_ctl_irq_prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/CLK_250_APP
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/CHECK_BUS_MASTER_ENA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_tcvcmap
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_prmcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_msicsr_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_msicsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_maxrdreq_rxbuffer
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_maxrdreq_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_maxrdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_maxpload_dw
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_maxpload
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_linkcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_link_negociated
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_devcsr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_busdev_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/cfg_busdev
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/CDMA_AST_RXWS_LATENCY
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/BOARD_DEMO
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/AVALON_WDATA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/AVALON_WADDR
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/AVALON_ST_128
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/AVALON_BYTE_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/arb_grant
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_tc_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_tc_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_tc_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_tc_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_tc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_req_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_req_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_req_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_req_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_num_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_num_interrupt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_num_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_num_dmard
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_num
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_msi_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_int_sts
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_int_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_int_ack_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/app_int_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/address_dmawr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/address_dmard
add wave -noupdate -divider {Unified Arbiter}
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/width
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_stream_ready0_reg
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_stream_ready0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_requester_dmawr
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_requester_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_descriptor_dmawr
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_descriptor_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_dmawr
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_command
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_interrupt
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_pcnt
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_requester_dmawr
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_requester_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_interrupt
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_descriptor_dmawr
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_descriptor_dmard
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_command
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_ready_pcnt
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_requester_dmawr_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_requester_dmard_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_descriptor_dmawr_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_descriptor_dmard_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_dmawr_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_command_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_interrupt_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_sel_pcnt_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_requester_dmawr_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_requester_dmard_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_interrupt_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_descriptor_dmawr_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_descriptor_dmard_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_rdy_command_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_ready_pcnt_p1
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_mask_reg
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/tx_mask0
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/select_width
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/select
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/rst_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/req
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/pci_tx_idle_p0_tx_sel
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/pci_tx_idle
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/pci_bus_master_enable
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/grant
add wave -noupdate /sonic_chaining_testbench/ep/app/chaining_dma_arb/arbiter/clk
add wave -noupdate -divider {Bus config}
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_sts_wr_rrr
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_sts_wr_rr
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_sts_wr_r
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_sts_wr
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_sts
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_ctl_wr_rrr
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_ctl_wr_rr
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_ctl_wr_r
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_ctl_wr
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_ctl
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/tl_cfg_add
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/rstn
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/pld_clk
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/HIP_SV
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_tcvcmap
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_prmcsr
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_pr_lim
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_pr_bas
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_np_lim
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_np_bas
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_msicsr
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_linkcsr
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_io_lim
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_io_bas
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_devcsr
add wave -noupdate /sonic_chaining_testbench/ep/cfgbus/cfg_busdev
add wave -noupdate -divider {Bar Reg access}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/write_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/reg_wr_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/reg_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/reg_wr_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/reg_rd_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/reg_rd_data_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/reg_rd_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/reg_rd_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/read_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/irq_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/err_status_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/dma_wr_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/dma_wr_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/dma_rd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/dma_rd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/cmd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/cmd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/bar_reg_access/clk_in
add wave -noupdate -divider {Port 1 Regacc}
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/write_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/rx_ecrc_bad_cnt
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/reg_wr_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/reg_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/reg_wr_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/reg_rd_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/reg_rd_data_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/reg_rd_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/reg_rd_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/read_dma_status
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/prg_wrdata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/prg_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/irq_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/irq_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/dma_wr_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/dma_wr_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/dma_rd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/dma_rd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/cmd_prg_wrena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/cmd_prg_rddata
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/bar_reg_access/clk_in
add wave -noupdate -divider rxtx_port0
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/TX_WAIT_ARB
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/TX_SEND_REQ
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/TX_SEND_DV_WAIT_ACK
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ready_del
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/TX_IDLE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/TX_DV_PAYLD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_tag
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_req_id
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_length
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_lbe
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_busy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_arb_granted
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/start_tx
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/sel_epmem
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/sel_ctl_sts
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/RX_WAIT_END_CPL
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_start_write
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_start_read
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/RX_START_CPL
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_sel_epmem
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_wrreq_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_wrreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_rdreq_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_rdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_msg_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_downstream_req_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/RX_IDLE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_tag
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_reqid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_length
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/RX_DV_PAYLD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_do_cpl
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/RX_DESC2_ACK
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_be
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_bar_hit_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/reg_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/reg_wr_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/reg_rd_data_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/reg_rd_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/reg_rd_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/PORT_NUM
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/num_dw_to_read
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_be
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_read_count
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_data_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_num_to_read_minus_one
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/mem_num_to_read
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/MEM_ADDR_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_wr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_rd_count
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_rd
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_prefetch
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_empty
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_data_out
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_data_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_almost_full
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/cstate_tx
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/cstate_rx
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/cfg_busdev_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/cfg_busdev
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/AVALON_WDATA_WIDTHU
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/AVALON_WDATA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/AVALON_ST_128
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port0/sonic_rc_slave/sonic_rxtx_mem_intf/AVALON_BE_WIDTH
add wave -noupdate -divider rxtx_port1
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/TX_WAIT_ARB
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/TX_SEND_REQ
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/TX_SEND_DV_WAIT_ACK
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_sel
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ready_del
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ready
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/TX_IDLE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/TX_DV_PAYLD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_tag
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_req_id
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_length
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_lbe
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_busy
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_arb_granted
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/tx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/start_tx
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/sel_epmem
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/sel_ctl_sts
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_ws
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/RX_WAIT_END_CPL
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_start_write
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_start_read
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/RX_START_CPL
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_sel_epmem
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_req
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_wrreq_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_wrreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_rdreq_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_rdreq
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_msg_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_is_downstream_req_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/RX_IDLE
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_tag
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_reqid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_length
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_hold_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/RX_DV_PAYLD
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_dv
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_do_cpl
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_dfr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/RX_DESC2_ACK
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_desc
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_be
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_bar_hit_n
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rx_ack
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/rstn
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/reg_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/reg_wr_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/reg_rd_data_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/reg_rd_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/reg_rd_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/PORT_NUM
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/num_dw_to_read
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_be
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_wr_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_read_count
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_ena
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_data_valid
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_data
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_rd_addr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_num_to_read_minus_one
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/mem_num_to_read
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/MEM_ADDR_WIDTH
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_wr
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_rd_count
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_rd
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_prefetch
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_empty
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_data_out
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_data_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/fifo_almost_full
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/cstate_tx
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/cstate_rx
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/clk_in
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/cfg_busdev_reg
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/cfg_busdev
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/AVALON_WDATA_WIDTHU
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/AVALON_WDATA
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/AVALON_ST_128
add wave -noupdate -radix hexadecimal /sonic_chaining_testbench/ep/app/chaining_dma_arb/sonic_port1/sonic_rc_slave/sonic_rxtx_mem_intf/AVALON_BE_WIDTH
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {38517618 ps} 0}
configure wave -namecolwidth 780
configure wave -valuecolwidth 118
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
WaveRestoreZoom {38426112 ps} {38609124 ps}
