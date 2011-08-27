onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Read Master}
add wave -noupdate /test_top/tb/nios_base_inst/avalon_read_master/avs_csr_write_reg
add wave -noupdate /test_top/tb/nios_base_inst/avalon_read_master/avs_csr_read
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/avs_csr_write
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/avs_csr_address
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/avs_csr_readdata
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/avs_csr_writedata
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/master_waitrequest
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/master_readdata
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/master_readdatavalid
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/master_read
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/master_byteenable
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/master_address
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/control_go
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/user_read_buffer
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/user_data_available
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/user_buffer_data
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/fifo_used
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/fifo_empty
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/clk
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/control_early_done
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/control_done
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/too_many_pending_reads_d1
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/too_many_pending_reads
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/reset
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/reads_pending
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/length
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/address
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/increment_address
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/FIFOUSEMEMORY
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/FIFODEPTH_LOG2
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/FIFODEPTH
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/DATAWIDTH
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/csr_status
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/control_read_length
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/control_read_base
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/BYTEENABLEWIDTH
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/ADDRESSWIDTH
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/control_fixed_location_d1
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_read_master/control_fixed_location
add wave -noupdate -divider {Write Master}
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/clk
add wave -noupdate /test_top/tb/nios_base_inst/avalon_read_master/avs_csr_read
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/avs_csr_write
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/avs_csr_writedata
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/avs_csr_readdata
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/avs_csr_address
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/user_write_buffer
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/user_buffer_full
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/user_buffer_empty
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/user_buffer_data
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/reset
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/read_fifo
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/master_writedata
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/master_write
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/master_waitrequest
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/master_byteenable
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/master_address
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/length
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/increment_address
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/csr_status
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/control_write_length
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/control_write_base
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/control_go
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/address
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/control_fixed_location_d1
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/control_fixed_location
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/control_done
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/FIFOUSEMEMORY
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/FIFODEPTH_LOG2
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/FIFODEPTH
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/DATAWIDTH
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/BYTEENABLEWIDTH
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/avalon_write_master/ADDRESSWIDTH
add wave -noupdate -divider {external ctrl}
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/writedata
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/write_n
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/reset_n
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/readdata
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/read_mux_out
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/irq_mask
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/irq
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/in_port
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/edge_detect
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/edge_capture_wr_strobe
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/edge_capture
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/data_in
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/d2_data_in
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/d1_data_in
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/clk_en
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/clk
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/chipselect
add wave -noupdate -radix hexadecimal /test_top/tb/nios_base_inst/ext_ctrl/address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4051965768 ps} 0}
configure wave -namecolwidth 437
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {1723229550 ps}
