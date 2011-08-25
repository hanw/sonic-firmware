/*
 * sonic_io.c
 *
 * Note: Bit banging IO driver
 *
 */
#include "sonic_io.h"

void avalon_mm_write (unsigned int address, unsigned int value) {
	while (IORD(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_STATUS) & 0x4);
	IOWR(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_USER_BUFFER_DATA, value);
	IOWR(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_USER_WRITE_BUFFER, 0x1);
	IOWR(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_ADDR_BASE, address);
	IOWR(NIOS_BASE_AVALON_WRITE_MASTER_BASE, 0, 0x1);
	while (IORD(NIOS_BASE_AVALON_WRITE_MASTER_BASE, WR_STATUS) & 0x1);
}

unsigned int avalon_mm_read (unsigned int address) {
	unsigned int val;
	IOWR(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_ADDR_BASE, address);
	IOWR(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_CONTROL, 0x1);
	val = IORD(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_STATUS);
	while ((val & 0x1) != 1){
		val = IORD(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_STATUS);
		pmesg (10, "val = %x\n", val);
	}
	val = IORD(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_STATUS);
	while ((val&0x2) != 0x2){
		val = IORD(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_STATUS);
		pmesg (10, "val = %x\n", val);
	}
	IOWR(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_USER_READ_BUFFER, 0x1);
	val = IORD(NIOS_BASE_AVALON_READ_MASTER_BASE, RD_USER_BUFFER_DATA);
	return val;
}
