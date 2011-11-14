/*
 * sonic_io.h
 *
 *  Created on: Aug 14, 2011
 *      Author: hwang
 */

#ifndef SONIC_IO_H_
#define SONIC_IO_H_

#include <stdio.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>
#include <sys/alt_irq.h>
#include "debug.h"

//word offset from AVALON_READ_MASTER_BASE
#define RD_CONTROL				0
#define RD_STATUS				1
#define RD_ADDR_BASE			2
#define RD_USER_BUFFER_DATA		4
#define RD_USER_READ_BUFFER		5

//word offset from AVALON_WRITE_MASTER_BASE
#define WR_CONTROL				0
#define WR_STATUS				1
#define WR_ADDR_BASE			3
#define WR_USER_BUFFER_DATA		4
#define WR_USER_WRITE_BUFFER	5

void avalon_mm_write (unsigned int address, unsigned int value);
unsigned int avalon_mm_read (unsigned int address);
void system_io_init ();

#endif /* SONIC_IO_H_ */
