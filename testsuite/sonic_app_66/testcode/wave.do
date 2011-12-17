onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Tx_cbuf
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/data_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/data_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/rd_clock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/wr_clock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/wr_address
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/wrreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/enable_sfp
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/xcvr_tx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tag_cpl
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_ring_rptr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox_rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf_data_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf_wrena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf_wrreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf_rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf_rdena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox_ena
add wave -noupdate -group {Sync Ring} -divider {Sync Ring}
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/wren
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/wr_clock
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/wr_address
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/rd_clock
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/rd_address
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/mapped_read_address
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/data_sel
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/data_out_ms
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/data_out_ls
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/data_out
add wave -noupdate -group {Sync Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/sync_ring/data_in
add wave -noupdate -group {Data Ring} -divider {Data Ring}
add wave -noupdate -group {Data Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_ring/wren
add wave -noupdate -group {Data Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_ring/wrclock
add wave -noupdate -group {Data Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_ring/wraddress
add wave -noupdate -group {Data Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_ring/sub_wire0
add wave -noupdate -group {Data Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_ring/rden
add wave -noupdate -group {Data Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_ring/rdclock
add wave -noupdate -group {Data Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_ring/rdaddress
add wave -noupdate -group {Data Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_ring/q
add wave -noupdate -group {Data Ring} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_ring/data
add wave -noupdate -group {GearBox 66 40} -divider Gearbox_66_40
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/clk_in
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/reset
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/ena
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/data_out
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/sr1
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/rd_req
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/state
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/state_r
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/state_rr
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/rd_req_r
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/rd_req_rr
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/rd_req_rrr
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/sr0
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/rd_req_out
add wave -noupdate -group {GearBox 66 40} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/data_in
add wave -noupdate -group {Tx Circular Buffer 66} -divider {Tx Circular Buffer 66}
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_out
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/wrreq
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/wren_sync
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/wren_data
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/wr_clk
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/wr_address_sync
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/wr_address_data
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/wr_address
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/reset
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/rdreq
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/rdena
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/rd_clk
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/rd_address
add wave -noupdate -group {Tx Circular Buffer 66} -radix binary /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/dout_sync
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/dout_data
add wave -noupdate -group {Tx Circular Buffer 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/data_in
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/dataa_0
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/dataa_1
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/datab_0
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/datab_1
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/result
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/sub_wire0
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/sub_wire6
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/sub_wire3
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/sub_wire1
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/sub_wire2
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/sub_wire4
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/sub_wire5
add wave -noupdate -group SonicMultAdd -divider {addr translate}
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/reset
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/pgn
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/int_read_addr
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/ext_read_addr_r
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/ext_read_addr
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/clk
add wave -noupdate -group SonicMultAdd -divider {addr calc}
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/sta/multadd/clock0
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/clk_in
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/reset
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/incr
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/ena
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/addr_out
add wave -noupdate -group SonicMultAdd -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_cbuf/gen_rd_addr/next_address
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/data_in
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/wr_address
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/wr_clock
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rd_clock
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/reset
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/wrena
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rdreq
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/wrreq
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rdena
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tag_cpl
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/data_out
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/gearbox_ena
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/tx_ring_rptr
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/curr_page
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/prev_page
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rd_ready
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rx_empty
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rx_full
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rx_almost_empty
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rx_almost_full
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/page_ready
add wave -noupdate -group {Tx Ctl 66} /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rd_page_ready
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rd_tag_cpl
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rd_cpld_qword_count
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/wrusedqwords
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rdusedqwords
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rx_cbuf_rdena
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rx_cbuf_rdreq
add wave -noupdate -group {Tx Ctl 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/tx_cbuf/rx_cbuf_wrena
add wave -noupdate -divider Rx_cbuf
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/data_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/rd_clock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/wr_clock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/rd_address
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/enable_sfp
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/xcvr_rx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/dma_rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/data_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/rx_ring_wptr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox_data_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync_data_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox_valid
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync_lock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/rx_cbuf_rdena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/rx_cbuf_rdreq
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/rx_cbuf_wrena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/rx_cbuf_wrreq
add wave -noupdate -divider {IRQ Gen}
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_ws
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_ring_rptr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_ready_others
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_err
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_dv
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_dfr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_desc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_data
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_busy
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/tx_ack
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/rx_ring_wptr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/rx_ring_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/rx_block_size
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/rd_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/msi_sel
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/msi_ready
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/msi_busy
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/irq_prg_wrena
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/irq_prg_wrdata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/irq_prg_rddata
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/irq_prg_addr
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/irq_msi_enable
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/irq_init
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/irq_base_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/force_flush_rc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/enable_sfp
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/clk_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/app_msi_tc
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/app_msi_req
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/app_msi_num
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_irq/app_msi_ack
add wave -noupdate -divider Blocksync
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/data_in
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/valid
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/clk
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/reset
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/block_lock
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/data_out
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/state
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/sh_cnt
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/sh_invalid_cnt
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/sh_valid
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/slip_done
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/test_sh
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/rx_coded
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/rx_b1
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/rx_b2
add wave -noupdate -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/blocksync/offset
add wave -noupdate -group {Gearbox 40 66} -divider Gearbox_40_66
add wave -noupdate -group {Gearbox 40 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/clk_in
add wave -noupdate -group {Gearbox 40 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/reset
add wave -noupdate -group {Gearbox 40 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/data_in
add wave -noupdate -group {Gearbox 40 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/data_out
add wave -noupdate -group {Gearbox 40 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/data_valid
add wave -noupdate -group {Gearbox 40 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/state
add wave -noupdate -group {Gearbox 40 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/sr0
add wave -noupdate -group {Gearbox 40 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/sr1
add wave -noupdate -group {Gearbox 40 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/valid
add wave -noupdate -group {Gearbox 40 66} -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/gearbox/data_in
add wave -noupdate -group Application -divider app
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_stream_ready0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_stream_data0_0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_stream_data0_1
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_stream_valid0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_stream_fifo_empty0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_data0_0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_data0_1
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_valid0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_ready0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_mask0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/msi_stream_ready0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/msi_stream_data0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/msi_stream_valid0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/aer_msi_num
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/pex_msi_num
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_req
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_ack
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_tc
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_num
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_int_sts
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_int_ack
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_stream_mask0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_stream_cred0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/cfg_busdev
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/cfg_devcsr
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/cfg_prmcsr
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/cfg_tcvcmap
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/cfg_linkcsr
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/cfg_msicsr
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/cpl_pending
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/cpl_err
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/err_desc
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/ko_cpl_spc_vc0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/pm_data
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/test_sim
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/xcvr_rx_clkout
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/xcvr_tx_clkout
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/xcvr_rx_dataout
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/xcvr_tx_datain
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/pma_tx_ready
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/pma_rx_ready
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/reset_nios
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/set_lpbk
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/unset_lpbk
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/clk_in
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rstn
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/open_rx_retry0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/open_rx_mask0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/open_rx_be0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_ack0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_ws0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_req0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_desc0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_data0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_be0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_dv0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_dfr0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_ecrc_bad_cnt
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_req0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_mask0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_ack0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_desc0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_ws0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_err0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_dv0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_dfr0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_data0
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_req_int
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_tc_int
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_num_int
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_ack_int
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_ack_reg
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_stream_ready0_reg
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_data0_0_reg
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_data0_1_reg
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_valid0_reg
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_data0_0_reg2
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_data0_1_reg2
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_stream_valid0_reg2
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_req_synced
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_fifo_empty_timer
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_local_fifo_empty
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_req_synced_n
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/tx_fifo_empty_timer_n
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/msi_req_state
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/msi_req_state_n
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/app_msi_ack_dd
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/srst
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/cpld_rx_buffer_ready
add wave -noupdate -group Application -radix hexadecimal /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/rx_buffer_cpl_max_dw
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3342886 ps} 0}
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
WaveRestoreZoom {0 ps} {30058350 ps}
