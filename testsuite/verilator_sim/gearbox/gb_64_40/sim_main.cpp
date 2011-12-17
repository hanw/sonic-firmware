// DESCRIPTION: Verilator Example: Top level main for invoking model
//
// Copyright 2003-2011 by Wilson Snyder. This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.

#include <verilated.h>		// Defines common routines
#include "Vsonic_downstream_gearbox.h"		// From Verilating "sonic_downstream_gearbox.sv"
#if VM_TRACE
# include <verilated_vcd_c.h>	// Trace file format header
#endif

Vsonic_downstream_gearbox *top;			// Instantiation of module

vluint64_t main_time = 0;	// Current simulation time (64-bit unsigned)

double sc_time_stamp () {	// Called by $time in Verilog
    return main_time;		// Note does conversion to real, to match SystemC
}

int main(int argc, char **argv, char **env) {
    if (0 && argc && argv && env) {}	// Prevent unused variable warnings
    top = new Vsonic_downstream_gearbox;		// Create instance of module

    Verilated::commandArgs(argc, argv);
    Verilated::debug(0);

#if VM_TRACE			// If verilator was invoked with --trace
    Verilated::traceEverOn(true);	// Verilator must compute traced signals
    VL_PRINTF("Enabling waves...\n");
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);	// Trace 99 levels of hierarchy
    tfp->open ("vlt_dump.vcd");	// Open the dump file
#endif

    top->reset = 1;		// Set some inputs
    top->ena = 1;
    top->rdreq = 1;
    top->clk = 0;
    top->data_in = 0x55ff55ff;

    while (main_time < 60 && !Verilated::gotFinish()) {

	if (main_time > 10) {
	    top->reset = 0;	// Deassert reset
	} else if (main_time > 1) {
	    top->reset = 1;	// Assert reset
	}

	top->eval();		// Evaluate model
#if VM_TRACE
	if (tfp) tfp->dump (main_time);	// Create waveform trace for this timestamp
#endif

	// Read outputs
	VL_PRINTF ("[%" VL_PRI64 "d] %x %x %x %x %08x %08x\n",
		   main_time, top->clk, top->reset, top->ena,
		   top->data_in, top->data_out);

	top->clk = !top->clk;
	main_time++;		// Time passes...
    }

    top->final();

#if VM_TRACE
    if (tfp) tfp->close();
#endif

    exit(0L);
}
