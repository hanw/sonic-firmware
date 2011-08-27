/*
 * SoNIC transceiver initialization program
 *
 */

#include <stdio.h>
#include <sys/alt_irq.h>
#include "routines.h"
#include "sonic_io.h"
#include "debug.h"

#define ST_IDLE 	0
#define	ST_INIT		1
#define ST_LPBK_ON	2
#define ST_LPBK_OFF 3
#define ST_RESET	4

// Debug message level
int msglevel = 4;
int state = ST_IDLE;


/* Declare a global variable to hold the edge capture value. */
volatile int edge_capture;

#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
static void handle_pio_interrupts(void* context)
#else
static void handle_pio_interrupts(void* context, alt_u32 id)
#endif
{
    /* Cast context to edge_capture's type. It is important that this be
     * declared volatile to avoid unwanted compiler optimization.
     */
    volatile int* edge_capture_ptr = (volatile int*) context;
    /* Store the value in the Button's edge capture register in *context. */
    *edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(NIOS_BASE_EXT_CTRL_BASE);
    /* Reset the Button's edge capture register. */
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(NIOS_BASE_EXT_CTRL_BASE, 0);

    /*
     * Read the PIO to delay ISR exit. This is done to prevent a spurious
     * interrupt in systems with high processor -> pio latency and fast
     * interrupts.
     */
    IORD_ALTERA_AVALON_PIO_EDGE_CAP(NIOS_BASE_EXT_CTRL_BASE);
}

/* Initialize the button_pio. */

static void init_pio()
{
    /* Recast the edge_capture pointer to match the alt_irq_register() function
     * prototype. */
    void* edge_capture_ptr = (void*) &edge_capture;
    /* Enable all 4 button interrupts. */
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(NIOS_BASE_EXT_CTRL_BASE, 0xf);
    /* Reset the edge capture register. */
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(NIOS_BASE_EXT_CTRL_BASE, 0x0);
    /* Register the interrupt handler. */
#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
    alt_ic_isr_register(NIOS_BASE_EXT_CTRL_IRQ_INTERRUPT_CONTROLLER_ID, NIOS_BASE_EXT_CTRL_IRQ,
      handle_pio_interrupts, edge_capture_ptr, 0x0);
#else
    alt_irq_register( EXT_CTRL_IRQ, edge_capture_ptr,
      handle_pio_interrupts);
#endif
}

static void handle_pci_command() {
	if((edge_capture & 0x1) != 0){
		// reset
		pmesg (10, "init netlogic xcvr\n");
		state = ST_INIT;
		edge_capture &= ~0x1;
	} else if ((edge_capture & 0x2) != 0) {
		// loopback on
		pmesg (10, "xcvr loopback on\n");
		state = ST_LPBK_ON;
		edge_capture &= ~0x2;
	} else if ((edge_capture & 0x4) != 0) {
		// loopback off
		pmesg (10, "xcvr loopback off\n");
		state =ST_LPBK_OFF;
		edge_capture &= ~0x4;
	} else if ((edge_capture & 0x8) != 0) {
		edge_capture &= ~0x8;
	}
}
/*
 * The Nios Program execute state machine.
 *
 * It responds to the PCIe register command interface,
 * the interface signals includes:
 * - xcvr_init
 * - xcvr_loopback
 *
 */
void execute () {
	switch (state){
		case ST_INIT:
			ext_xcvr_reset();
			netlogic_init();
			state = ST_IDLE;
			break;
		case ST_RESET:
			//reset all registers
			state = ST_INIT;
			break;
		case ST_IDLE:
			//
			if (edge_capture != 0) {
				handle_pci_command();
			}
			break;
		case ST_LPBK_ON:
			set_pma_loopback();
			state = ST_IDLE;
			break;
		case ST_LPBK_OFF:
			unset_pma_loopback();
			state = ST_IDLE;
			break;
		default:
			// upon reset, goes to reset state.
			break;
	}
}

int main()
{
	pmesg(1, "Welcome to SoNIC Nios firmware!\n");

    init_pio();

    unsigned int tmp;
    tmp = read_mdio(0x0);
    pmesg (3, "PMA/PMD reg 0x0 = 0x%x\n", tmp);

    tmp = read_mdio(0x1);
    pmesg (3, "PMA/PMD reg 0x1 = 0x%x\n", tmp);

    tmp = read_mdio(0x2);
    pmesg (3, "PMA/PMD reg 0x2 = 0x%x\n", tmp);

    tmp = read_mdio(0x8);
    pmesg (3, "PMA/PMD reg 0x8 = 0x%x\n", tmp);

	while(1){
		execute();
	}
	return 0;
}
