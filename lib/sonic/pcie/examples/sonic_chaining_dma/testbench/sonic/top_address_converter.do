onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/_sonic_address_converter/clk_in
add wave -noupdate -radix hexadecimal /top/_sonic_address_converter/address_in
add wave -noupdate -radix hexadecimal /top/_sonic_address_converter/read_addr_upper_9bits_r
add wave -noupdate -radix hexadecimal /top/_sonic_address_converter/read_addr_lower_4bits_r
add wave -noupdate -radix hexadecimal /top/_sonic_address_converter/col_sel
add wave -noupdate -radix hexadecimal /top/_sonic_address_converter/row_sel
add wave -noupdate /top/_sonic_address_converter/rden_reg
add wave -noupdate -radix hexadecimal /top/ac_intf/address
add wave -noupdate -radix hexadecimal /top/ac_intf/sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1030559 ps} 0}
configure wave -namecolwidth 287
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
WaveRestoreZoom {875313 ps} {1006563 ps}
