/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios_base_cpu' in SOPC Builder design 'sonic_v1_15'
 * SOPC Builder design path: ../../sonic_v1_15.sopcinfo
 *
 * Generated: Fri Aug 26 09:37:36 EDT 2011
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_qsys"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x820
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x13
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x20020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x12
#define ALT_CPU_NAME "nios_base_cpu"
#define ALT_CPU_RESET_ADDR 0x20000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x820
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x13
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x20020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x12
#define NIOS2_RESET_ADDR 0x20000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_TIMER
#define __ALTERA_NIOS2_QSYS
#define __AVALON_READ_MASTER
#define __AVALON_WRITE_MASTER


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Stratix IV"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/nios_base_jtag_uart"
#define ALT_STDERR_BASE 0x42030
#define ALT_STDERR_DEV nios_base_jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/nios_base_jtag_uart"
#define ALT_STDIN_BASE 0x42030
#define ALT_STDIN_DEV nios_base_jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/nios_base_jtag_uart"
#define ALT_STDOUT_BASE 0x42030
#define ALT_STDOUT_DEV nios_base_jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "sonic_v1_15"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK NIOS_BASE_SYS_CLK_TIMER
#define ALT_TIMESTAMP_CLK none


/*
 * nios_base_avalon_read_master configuration
 *
 */

#define ALT_MODULE_CLASS_nios_base_avalon_read_master avalon_read_master
#define NIOS_BASE_AVALON_READ_MASTER_BASE 0x100
#define NIOS_BASE_AVALON_READ_MASTER_IRQ -1
#define NIOS_BASE_AVALON_READ_MASTER_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NIOS_BASE_AVALON_READ_MASTER_NAME "/dev/nios_base_avalon_read_master"
#define NIOS_BASE_AVALON_READ_MASTER_SPAN 64
#define NIOS_BASE_AVALON_READ_MASTER_TYPE "avalon_read_master"


/*
 * nios_base_avalon_write_master configuration
 *
 */

#define ALT_MODULE_CLASS_nios_base_avalon_write_master avalon_write_master
#define NIOS_BASE_AVALON_WRITE_MASTER_BASE 0x200
#define NIOS_BASE_AVALON_WRITE_MASTER_IRQ -1
#define NIOS_BASE_AVALON_WRITE_MASTER_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NIOS_BASE_AVALON_WRITE_MASTER_NAME "/dev/nios_base_avalon_write_master"
#define NIOS_BASE_AVALON_WRITE_MASTER_SPAN 64
#define NIOS_BASE_AVALON_WRITE_MASTER_TYPE "avalon_write_master"


/*
 * nios_base_ext_ctrl configuration
 *
 */

#define ALT_MODULE_CLASS_nios_base_ext_ctrl altera_avalon_pio
#define NIOS_BASE_EXT_CTRL_BASE 0x400
#define NIOS_BASE_EXT_CTRL_BIT_CLEARING_EDGE_REGISTER 0
#define NIOS_BASE_EXT_CTRL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define NIOS_BASE_EXT_CTRL_CAPTURE 1
#define NIOS_BASE_EXT_CTRL_DATA_WIDTH 4
#define NIOS_BASE_EXT_CTRL_DO_TEST_BENCH_WIRING 0
#define NIOS_BASE_EXT_CTRL_DRIVEN_SIM_VALUE 0x0
#define NIOS_BASE_EXT_CTRL_EDGE_TYPE "RISING"
#define NIOS_BASE_EXT_CTRL_FREQ 50000000u
#define NIOS_BASE_EXT_CTRL_HAS_IN 1
#define NIOS_BASE_EXT_CTRL_HAS_OUT 0
#define NIOS_BASE_EXT_CTRL_HAS_TRI 0
#define NIOS_BASE_EXT_CTRL_IRQ 5
#define NIOS_BASE_EXT_CTRL_IRQ_INTERRUPT_CONTROLLER_ID 0
#define NIOS_BASE_EXT_CTRL_IRQ_TYPE "EDGE"
#define NIOS_BASE_EXT_CTRL_NAME "/dev/nios_base_ext_ctrl"
#define NIOS_BASE_EXT_CTRL_RESET_VALUE 0x0
#define NIOS_BASE_EXT_CTRL_SPAN 16
#define NIOS_BASE_EXT_CTRL_TYPE "altera_avalon_pio"


/*
 * nios_base_jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_nios_base_jtag_uart altera_avalon_jtag_uart
#define NIOS_BASE_JTAG_UART_BASE 0x42030
#define NIOS_BASE_JTAG_UART_IRQ 1
#define NIOS_BASE_JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define NIOS_BASE_JTAG_UART_NAME "/dev/nios_base_jtag_uart"
#define NIOS_BASE_JTAG_UART_READ_DEPTH 64
#define NIOS_BASE_JTAG_UART_READ_THRESHOLD 8
#define NIOS_BASE_JTAG_UART_SPAN 8
#define NIOS_BASE_JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define NIOS_BASE_JTAG_UART_WRITE_DEPTH 64
#define NIOS_BASE_JTAG_UART_WRITE_THRESHOLD 8


/*
 * nios_base_onchip_ram configuration
 *
 */

#define ALT_MODULE_CLASS_nios_base_onchip_ram altera_avalon_onchip_memory2
#define NIOS_BASE_ONCHIP_RAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define NIOS_BASE_ONCHIP_RAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define NIOS_BASE_ONCHIP_RAM_BASE 0x20000
#define NIOS_BASE_ONCHIP_RAM_CONTENTS_INFO ""
#define NIOS_BASE_ONCHIP_RAM_DUAL_PORT 0
#define NIOS_BASE_ONCHIP_RAM_GUI_RAM_BLOCK_TYPE "Automatic"
#define NIOS_BASE_ONCHIP_RAM_INIT_CONTENTS_FILE "onchip_ram"
#define NIOS_BASE_ONCHIP_RAM_INIT_MEM_CONTENT 1
#define NIOS_BASE_ONCHIP_RAM_INSTANCE_ID "NONE"
#define NIOS_BASE_ONCHIP_RAM_IRQ -1
#define NIOS_BASE_ONCHIP_RAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NIOS_BASE_ONCHIP_RAM_NAME "/dev/nios_base_onchip_ram"
#define NIOS_BASE_ONCHIP_RAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define NIOS_BASE_ONCHIP_RAM_RAM_BLOCK_TYPE "Auto"
#define NIOS_BASE_ONCHIP_RAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define NIOS_BASE_ONCHIP_RAM_SINGLE_CLOCK_OP 0
#define NIOS_BASE_ONCHIP_RAM_SIZE_MULTIPLE 1
#define NIOS_BASE_ONCHIP_RAM_SIZE_VALUE 131072u
#define NIOS_BASE_ONCHIP_RAM_SPAN 131072
#define NIOS_BASE_ONCHIP_RAM_TYPE "altera_avalon_onchip_memory2"
#define NIOS_BASE_ONCHIP_RAM_WRITABLE 1


/*
 * nios_base_sys_clk_timer configuration
 *
 */

#define ALT_MODULE_CLASS_nios_base_sys_clk_timer altera_avalon_timer
#define NIOS_BASE_SYS_CLK_TIMER_ALWAYS_RUN 1
#define NIOS_BASE_SYS_CLK_TIMER_BASE 0x42040
#define NIOS_BASE_SYS_CLK_TIMER_COUNTER_SIZE 32
#define NIOS_BASE_SYS_CLK_TIMER_FIXED_PERIOD 1
#define NIOS_BASE_SYS_CLK_TIMER_FREQ 50000000u
#define NIOS_BASE_SYS_CLK_TIMER_IRQ 16
#define NIOS_BASE_SYS_CLK_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define NIOS_BASE_SYS_CLK_TIMER_LOAD_VALUE 499999ull
#define NIOS_BASE_SYS_CLK_TIMER_MULT 0.0010
#define NIOS_BASE_SYS_CLK_TIMER_NAME "/dev/nios_base_sys_clk_timer"
#define NIOS_BASE_SYS_CLK_TIMER_PERIOD 10.0
#define NIOS_BASE_SYS_CLK_TIMER_PERIOD_UNITS "ms"
#define NIOS_BASE_SYS_CLK_TIMER_RESET_OUTPUT 0
#define NIOS_BASE_SYS_CLK_TIMER_SNAPSHOT 0
#define NIOS_BASE_SYS_CLK_TIMER_SPAN 32
#define NIOS_BASE_SYS_CLK_TIMER_TICKS_PER_SEC 100u
#define NIOS_BASE_SYS_CLK_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define NIOS_BASE_SYS_CLK_TIMER_TYPE "altera_avalon_timer"


/*
 * nios_base_sysid configuration
 *
 */

#define ALT_MODULE_CLASS_nios_base_sysid altera_avalon_sysid_qsys
#define NIOS_BASE_SYSID_BASE 0x42038
#define NIOS_BASE_SYSID_ID 953745243
#define NIOS_BASE_SYSID_IRQ -1
#define NIOS_BASE_SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NIOS_BASE_SYSID_NAME "/dev/nios_base_sysid"
#define NIOS_BASE_SYSID_SPAN 8
#define NIOS_BASE_SYSID_TIMESTAMP 1314327916
#define NIOS_BASE_SYSID_TYPE "altera_avalon_sysid_qsys"

#endif /* __SYSTEM_H_ */
