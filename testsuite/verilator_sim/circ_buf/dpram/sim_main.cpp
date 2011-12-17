// DESCRIPTION: Verilator Example: Top level main for invoking model
//
// Copyright 2003-2011 by Wilson Snyder. This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.
//
#include <fstream>
#include <iostream>
#include <string>

#include <verilated.h>		// Defines common routines
#if VM_TRACE
#include <verilated_vcd_c.h>	// Trace file format header
#endif

#include "Vsonic_dpram_async_2_64.h"		// From Verilating "sonic_blocksync_xg.sv"

#define SIM_TIME    400
#define DEBUG       0
#define INPUT_VEC   1
using namespace std;

Vsonic_dpram_async_2_64 *top;	// Instantiation of module

vluint64_t main_time = 0;	// Current simulation time (64-bit unsigned)

ifstream indata;

double sc_time_stamp () {	// Called by $time in Verilog
    return main_time;		// Note does conversion to real, to match SystemC
}

static inline void set_data_in (WDataOutP owp, QData hbits, QData lbits) { 
    // Assume 66 bits
    owp[0] = (WData)(lbits & VL_ULL(0xFFFFFFFF));
    owp[1] = (WData)((lbits >> VL_ULL(32)) & VL_ULL(0xFFFFFFFF));
    owp[2] = (WData)(hbits & VL_ULL(0xFFFFFFFF));
}

int main(int argc, char **argv, char **env) {

    if (0 && argc && argv && env) {}	// Prevent unused variable warnings
    top = new Vsonic_dpram_async_2_64;		// Create instance of module

    Verilated::commandArgs(argc, argv);
    Verilated::debug(1);

#if VM_TRACE			// If verilator was invoked with --trace
    Verilated::traceEverOn(true);	// Verilator must compute traced signals
    VL_PRINTF("Enabling waves...\n");
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);	// Trace 99 levels of hierarchy
    tfp->open ("Vsonic_dpram_async_2_64.vcd");	// Open the dump file
#endif
    
    top->wraddress = 0;		// Initialize inputs
    top->data = 0;
    top->rdaddress = 0;
    top->inclock = 0;
    top->outclock = 0;
    top->wren = 1;
    
    string str;
    string block_lock;

    unsigned int i1, i2, i3;
    char *pEnd;
    const char *str_c;

    // Load test vector.
#if INPUT_VEC
    indata.open("test_vector.dat");
#endif

    while (main_time < SIM_TIME && !Verilated::gotFinish()) {

        // Parsing code is file specific.
        // ===========================================
        // wraddress <space> data <space> rdaddress 
        //   15bits          2bits          10bits
        // ===========================================
#if INPUT_VEC
        if (!indata.eof() && top->inclock == 0 ){
            getline(indata, str);
            str_c = str.c_str();
            i1 = strtol(str_c, &pEnd, 16);
            i2 = strtol(pEnd, &pEnd, 2);
            i3 = strtol(pEnd, &pEnd, 16);
#if DEBUG
            cout << "long int:" << hex << i1 << " " << hex << i2 << " " << hex << i3 << endl;
#endif
//            set_data_in(top->data_in, (Data)li1, (QData)li2);
        } 
#endif
        top->data = i2;
        top->rdaddress = i3;
        top->wraddress = i1;

        top->eval();		// Evaluate model

#if VM_TRACE
        if (tfp) tfp->dump (main_time);	// Create waveform trace for this timestamp
#endif

        // Read outputs
        VL_PRINTF ("[%" VL_PRI64 "d] %x 0x%04x %x 0x%04x 0x%016lx\n",
               main_time, top->inclock, top->wraddress, top->data, top->rdaddress, top->q );

        top->inclock = !top->inclock;
        top->outclock = !top->outclock;

        main_time++;		// Time passes...
    }
    
    top->final();

#if VM_TRACE
    if (tfp) tfp->close();
#endif

    indata.close();
    exit(0L);
}
