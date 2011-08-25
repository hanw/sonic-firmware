/*
 * routines.h
 *
 *  Created on: Aug 14, 2011
 *      Author: hwang
 */

#ifndef ROUTINES_H_
#define ROUTINES_H_



#define OFF		0
#define ON		1

/*
 * Device Base Address
 */
#define MDIO_BASE_ADDR 		0x800
#define EXT_XCVR_BASE_ADDR 	0x1000
#define PMA_BASE_ADDR		0x50000

/*
 * PMA Address Map
 */
#define ALT_PMA_CONTROLLER_BASE_ADDR 	0x00000080
#define ALT_PMA_RESET_BASE_ADDR		 	0x00000100
#define ALT_PMA_CH_CONTROLLER_BASE_ADDR 0x00000180

/*
 * MDIO constants
 */
#define MDIO_CSR_ADDR_CL45 	0x84
#define MDIO_RW_ADDR 		0x80

void netlogic_init();
void ext_xcvr_reset();
void set_pma_loopback();
void unset_pma_loopback();

#endif /* ROUTINES_H_ */
