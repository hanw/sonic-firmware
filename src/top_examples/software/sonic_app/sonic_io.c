/*
 * sonic_io.c
 *
 */
#include "sonic_io.h"
#include <system.h>

void avalon_mm_write (unsigned int address, unsigned int value) {
	unsigned int val;

	// wait if output fifo full;
	val = IORD(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_STATUS);
	while ((val & 0x4) == 0x4){
		val = IORD(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_STATUS);
		pmesg (10, "mm_wr fifo full, wr_status = %x\n", val);
	}

	// write data and address
	IOWR(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_USER_BUFFER_DATA, value);
	IOWR(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_USER_WRITE_BUFFER, 0x1);
	IOWR(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_ADDR_BASE, address);
	IOWR(NIOS_BASE_AVALON_WRITE_MASTER_BASE, 0, 0x1);

	// wait until done.
	val = IORD(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_STATUS);
	while ((val & 0x1) != 0x1){
		val = IORD(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_STATUS);
		pmesg (10, "mm_wr done, wr_status = %x\n", val);
	}
}

unsigned int avalon_mm_read (unsigned int address) {
	unsigned int val;

	// set control_read_base
	IOWR(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_ADDR_BASE, address);
	// control_read_length is by default 4.
	// control_fixed_location is by default 1
	// set control_go, to begin transfer.
	IOWR(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_CONTROL, 0x1);

	// Wait for control_done.
	val = IORD(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_STATUS);
	while ((val & 0x1) != 1){
		val = IORD(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_STATUS);
		pmesg (10, "mm_rd done, rd_status = %x\n", val);
	}

	// wait for data_valid
	val = IORD(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_STATUS);
	while ((val&0x2) != 0x2){
		val = IORD(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_STATUS);
		pmesg (10, "mm_rd data_valid, rd_status = %x\n", val);
	}

	// read data
	IOWR(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_USER_READ_BUFFER, 0x1);
	val = IORD(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_USER_BUFFER_DATA);
	return val;
}
