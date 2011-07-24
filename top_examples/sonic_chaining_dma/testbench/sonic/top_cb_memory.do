onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/_sonic_cb_memory/write_intf/clk
add wave -noupdate /top/_sonic_cb_memory/read_intf/clk
add wave -noupdate -radix hexadecimal /top/_sonic_cb_memory/read_intf/address
add wave -noupdate -radix hexadecimal /top/_sonic_cb_memory/read_intf/data
add wave -noupdate -radix hexadecimal /top/_sonic_cb_memory/read_intf/enable
add wave -noupdate -radix hexadecimal /top/_sonic_cb_memory/write_intf/address
add wave -noupdate -radix hexadecimal /top/_sonic_cb_memory/write_intf/data
add wave -noupdate -radix hexadecimal /top/_sonic_cb_memory/write_intf/enable
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
WaveRestoreZoom {0 ps} {1806 ns}
