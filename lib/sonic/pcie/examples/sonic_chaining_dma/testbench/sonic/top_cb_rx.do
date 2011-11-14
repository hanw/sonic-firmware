onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/wr_addr_counter/count
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rd_addr_counter/count
add wave -noupdate -divider Read
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/buffer_memory/read_intf/address
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/buffer_memory/read_intf/data
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/buffer_memory/read_intf/enable
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rd_port/address
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rd_port/data
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rd_port/enable
add wave -noupdate -divider Write
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/buffer_memory/write_intf/address
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/buffer_memory/write_intf/data
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/buffer_memory/write_intf/enable
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/wr_port/address
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/wr_port/data
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/wr_port/enable
add wave -noupdate -divider {Address Convert}
add wave -noupdate /top/_sonic_dma_circular_buffer_rx/rx_wr_addr_converter/clk_in
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rx_wr_addr_converter/address_in
add wave -noupdate /top/_sonic_dma_circular_buffer_rx/rx_wr_addr_converter/ena
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rx_wr_addr_converter/col_sel
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rx_wr_addr_converter/row_sel
add wave -noupdate -divider Testbench
add wave -noupdate /top/cb_intf/clk_wr
add wave -noupdate /top/cb_intf/clk_rd
add wave -noupdate -radix hexadecimal /top/cb_intf/data_in
add wave -noupdate -radix hexadecimal /top/cb_intf/data_out
add wave -noupdate /top/cb_intf/rden
add wave -noupdate /top/cb_intf/wren
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/cb_intf/data_in
add wave -noupdate -radix hexadecimal -subitemconfig {{/top/_sonic_dma_circular_buffer_rx/rx_wr_enable_mux/sel[0]} {-height 16 -radix hexadecimal} {/top/_sonic_dma_circular_buffer_rx/rx_wr_enable_mux/sel[1]} {-height 16 -radix hexadecimal} {/top/_sonic_dma_circular_buffer_rx/rx_wr_enable_mux/sel[2]} {-height 16 -radix hexadecimal} {/top/_sonic_dma_circular_buffer_rx/rx_wr_enable_mux/sel[3]} {-height 16 -radix hexadecimal} {/top/_sonic_dma_circular_buffer_rx/rx_wr_enable_mux/sel[4]} {-height 16 -radix hexadecimal}} /top/_sonic_dma_circular_buffer_rx/rx_wr_enable_mux/sel
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rx_wr_enable_mux/ena_out
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/ac_intf/address
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/ac_intf/sel
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/buffer_memory/write_intf/address
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/buffer_memory/write_intf/data
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/buffer_memory/write_intf/enable
add wave -noupdate -radix hexadecimal {/top/_sonic_dma_circular_buffer_rx/buffer_memory/genblk1[0]/cb_ram/data}
add wave -noupdate -radix hexadecimal {/top/_sonic_dma_circular_buffer_rx/buffer_memory/genblk1[0]/cb_ram/wraddress}
add wave -noupdate -radix hexadecimal {/top/_sonic_dma_circular_buffer_rx/buffer_memory/genblk1[0]/cb_ram/wrclock}
add wave -noupdate -radix hexadecimal {/top/_sonic_dma_circular_buffer_rx/buffer_memory/genblk1[0]/cb_ram/wren}
add wave -noupdate -radix hexadecimal {/top/_sonic_dma_circular_buffer_rx/buffer_memory/genblk1[0]/cb_ram/rdaddress}
add wave -noupdate -radix hexadecimal {/top/_sonic_dma_circular_buffer_rx/buffer_memory/genblk1[0]/cb_ram/rdclock}
add wave -noupdate -radix hexadecimal {/top/_sonic_dma_circular_buffer_rx/buffer_memory/genblk1[0]/cb_ram/rden}
add wave -noupdate -radix hexadecimal {/top/_sonic_dma_circular_buffer_rx/buffer_memory/genblk1[0]/cb_ram/q}
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rx_data_mux/data_in
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rx_data_mux/sel
add wave -noupdate -radix hexadecimal /top/_sonic_dma_circular_buffer_rx/rx_data_mux/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {123243 ps} 0}
configure wave -namecolwidth 228
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
WaveRestoreZoom {102593 ps} {160607 ps}
