add wave -noupdate -divider {nios_base_tb_nios_base_inst_cpu: top-level ports}
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/d_irq
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/d_waitrequest
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/d_address
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/d_byteenable
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/d_read
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/d_readdata
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/d_write
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/d_writedata
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/i_waitrequest
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/i_address
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/i_read
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/i_readdata
add wave -noupdate -divider {nios_base_tb_nios_base_inst_cpu: common}
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/clk
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/reset_n
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/F_pcb_nxt
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/F_pcb
add wave -noupdate -format Logic -radix ascii /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/F_vinst
add wave -noupdate -format Logic -radix ascii /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/D_vinst
add wave -noupdate -format Logic -radix ascii /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/R_vinst
add wave -noupdate -format Logic -radix ascii /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/E_vinst
add wave -noupdate -format Logic -radix ascii /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/W_vinst
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/F_valid
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/D_valid
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/R_valid
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/E_valid
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/W_valid
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/D_wr_dst_reg
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/D_dst_regnum
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/W_wr_data
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/F_iw
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/D_iw
add wave -noupdate -divider {nios_base_tb_nios_base_inst_cpu: breaks}
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/hbreak_req
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/oci_hbreak_req
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/hbreak_enabled
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_nios_base_tb_nios_base_inst_cpu/wait_for_one_post_bret_inst

configure wave -justifyvalue right
configure wave -signalnamewidth 1
TreeUpdate [SetDefaultTree]
