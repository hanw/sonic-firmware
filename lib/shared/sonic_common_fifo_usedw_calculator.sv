// synthesis translate_off
`timescale 1ns / 1ns
// synthesis translate_on

`include "sonic_constants.sv"
// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030
//-----------------------------------------------------------------------------
// Title         : 
// Project       : 
//-----------------------------------------------------------------------------
// File          : sonic_common_fifo_usedw_calculator.sv
// Author        : 
//-----------------------------------------------------------------------------
// Description : 
//					
// 
//-----------------------------------------------------------------------------

// We assume the dual clock mode, thus
// single clock mode implementation is skipped.
module sonic_common_fifo_usedw_calculator 
  #(
    parameter int WIDTH = 8,
    parameter int QWORD_DEPTH = 9,
    parameter int UPSTREAM = 0, 
    parameter int READ_TO_WRITE_DELAY = 3,
    parameter int WRITE_TO_READ_DELAY = 3
    ) (
       // clocks, enables and reset
       input logic rdclock,
       input logic rdena,
       input logic wrclock,
       input logic wrena,
       input logic reset,

       // triggers
       input logic wrreq,
       input logic rdreq,

       // information signals calculated (write side)
       output logic [`USED_QWORDS_WIDTH-1:0] wrusedqwords,
       output logic full,
       output logic almost_full,

       // information signals calculated (read side)
       output logic [`USED_QWORDS_WIDTH-1:0] rdusedqwords,
       output logic [WIDTH-1:0] clock_crossed_wptr,	//for Rx
       output logic [WIDTH-1:0] clock_crossed_rptr,	//for Tx
       output logic empty,
       output logic almost_empty
       );

   //if UPSTREAM==1, every WR is a Qword, every RD is an Oword.
   //if UPSTREAM==0, every WR is an Oword, every RD is a Qword.
   localparam WR_INCREMENT = (UPSTREAM==1)?1:2;
   localparam RD_INCREMENT = (UPSTREAM==1)?2:1;

   logic [WIDTH-1:0] rdusedqwords_reg;
   logic [WIDTH-1:0] wrusedqwords_reg;
   logic 	     full_reg;
   logic 	     almost_full_reg;
   logic 	     empty_reg;
   logic 	     almost_empty_reg;

   // in dual clock mode, need to maintain separate counters which only
   // increment cross clock domains by converting to gray, avoiding
   // metastability with shift registers and converting back.
   //
   // these counters are incremented when rdreqs and wrreqs happen, they are
   // then propagated across the clock domains and positive deltas in their
   // values are looked for at the other side
   logic [WIDTH-1:0] wrcounter, rdcounter;
   
   // the counters in their destination once they've crossed the clock
   // domains
   logic [WIDTH-1:0] clock_crossed_wrcounter, clock_crossed_rdcounter;	
   
   // monitors how much the counters have changed
   logic [WIDTH-1:0] clock_crossed_wrcounter_prev, clock_crossed_rdcounter_prev;
   logic [WIDTH-1:0] writes_this_read_cycle, reads_this_write_cycle;

   // sometimes extra delay is required after the clock crossing delay
   logic [WIDTH-1:0] writes_this_read_cycle_delay, reads_this_write_cycle_delay;

   // update the rdcounter in reponse to rdreq on the rdclock
   always @ (posedge rdclock or posedge reset) begin
      if (reset == 1'b1) begin
	 rdcounter <= 0;
      end
      else if ((rdena == 1'b1) && (rdreq == 1'b1)) begin
	 rdcounter <= rdcounter + RD_INCREMENT;
      end
   end
   
   // update the wrcounter in response to wrreq on the wrclock
   always @ (posedge wrclock or posedge reset) begin
      if (reset == 1'b1) begin
	 wrcounter <= 0;
      end
      else if ((wrena == 1'b1) && (wrreq == 1'b1)) begin
	 //wrcounter <= wrcounter + 1;
	 wrcounter <= wrcounter + WR_INCREMENT;
      end
   end

   // propagate the wrcounter across to the read clock domain and monitor 
   // how much it advances each cycle
   sonic_common_gray_clock_crosser wrcounter_to_rdclock(
							.inclock(wrclock),
							.outclock(rdclock),
							.inena(wrena),
							.outena(1'b1),
							.reset(reset),
							.data(wrcounter),
							.q(clock_crossed_wrcounter)
							);
   defparam wrcounter_to_rdclock.WIDTH = WIDTH;

   // track the previous value of clock_crossed_wrcounter
   always @(posedge reset or posedge rdclock) begin
      if (reset == 1'b1) 
	clock_crossed_wrcounter_prev <= 0;
      else
	clock_crossed_wrcounter_prev <= clock_crossed_wrcounter;
   end

   // combinationally update the wrcounter delta this read cycle,
   // fixme??
   assign writes_this_read_cycle = clock_crossed_wrcounter - clock_crossed_wrcounter_prev;

   sonic_common_gray_clock_crosser rdcounter_to_wrclock(
							.inclock(rdclock),
							.outclock(wrclock),
							.inena(rdena),
							.outena(1'b1),
							.reset(reset),
							.data(rdcounter),
							.q(clock_crossed_rdcounter)
							);
   defparam rdcounter_to_wrclock.WIDTH = WIDTH;

   // track the previous value of clock_crossed_rdcounter
   always @(posedge reset or posedge wrclock) begin
      if (reset == 1'b1)
	clock_crossed_rdcounter_prev <= 0;
      else
	clock_crossed_rdcounter_prev <= clock_crossed_rdcounter;
   end
   // combinationally update the rdcounter delta this read cycle
   assign	reads_this_write_cycle = clock_crossed_rdcounter - clock_crossed_rdcounter_prev;

   // delay writes_this_read_cycle as requested
   sonic_common_logic_vector_delay writes_this_read_cycle_delayer(
								  .clock(rdclock),	//FIXME: who should drive this??
								  .ena(1'b1),
								  .reset(reset),
								  .data(writes_this_read_cycle),
								  .q(writes_this_read_cycle_delay)
								  );
   defparam writes_this_read_cycle_delayer.WIDTH = WIDTH,
     writes_this_read_cycle_delayer.DELAY = WRITE_TO_READ_DELAY;

   sonic_common_logic_vector_delay reads_this_write_cycle_delayer(
								  .clock(wrclock),	//FIXME:
								  .ena(1'b1),
								  .reset(reset),
								  .data(reads_this_write_cycle),
								  .q(reads_this_write_cycle_delay)
								  );
   defparam reads_this_write_cycle_delayer.WIDTH = WIDTH,
     reads_this_write_cycle_delayer.DELAY = READ_TO_WRITE_DELAY;

   // this process updates the wrusedqwords and full signals
   always @(posedge reset or posedge wrclock) begin
      if (reset == 1'b1) begin
	 // start empty
	 full_reg <= 0;
	 almost_full_reg <= 0;
	 wrusedqwords_reg <= 0;
      end
      else begin
	 // update based on wrreq and the number of reads which we've been
	 // told about this write cycle
	 if ((wrreq == 1'b1) && (wrena == 1'b1)) begin
	    //prevent wrusedqwords_reg from underflow
	    if ((wrusedqwords_reg + WR_INCREMENT - reads_this_write_cycle_delay) > (wrusedqwords_reg + WR_INCREMENT))
	      wrusedqwords_reg <= 0;
	    //prevent wrusedqwords_reg from overflow               
	    else if ((wrusedqwords_reg + WR_INCREMENT - reads_this_write_cycle_delay) > QWORD_DEPTH)
              wrusedqwords_reg <= QWORD_DEPTH;
            else
	      wrusedqwords_reg <= wrusedqwords_reg + WR_INCREMENT - reads_this_write_cycle_delay;
	 end
	 else begin
            //prevent wrusedqwords_reg from underflow
            if ((wrusedqwords_reg - reads_this_write_cycle_delay) > wrusedqwords_reg)
              wrusedqwords_reg <= 0;
            else if ((wrusedqwords_reg - reads_this_write_cycle_delay) > QWORD_DEPTH)
              wrusedqwords_reg <= QWORD_DEPTH;
            else
	      wrusedqwords_reg <= wrusedqwords_reg - reads_this_write_cycle_delay;
	 end

	 if (wrusedqwords_reg >= QWORD_DEPTH)
	   full_reg <= 1'b1;
	 else
	   full_reg <= 1'b0;
	 
	 if (wrusedqwords_reg >= QWORD_DEPTH - 10)
	   almost_full_reg <= 1'b1;
	 else
	   almost_full_reg <= 1'b0;
      end
   end
   
   // drive output line from registers
   assign wrusedqwords = wrusedqwords_reg;
   assign full = full_reg;
   assign almost_full = (QWORD_DEPTH > 1)? almost_full_reg : 1'b1;

   // this process updates the rdusedqwords and empty signals
   always @ (posedge reset or posedge rdclock) begin
      if (reset == 1'b1) begin
	 // start empty
	 empty_reg <= 1'b1;
	 almost_empty_reg <= 1'b1;
	 rdusedqwords_reg <= 0;
      end
      else begin
	 if ((rdreq == 1'b1) && (rdena == 1'b1))
	   begin
	      //prevent rdusedwqwords from underflow
	      if ((rdusedqwords_reg - RD_INCREMENT + writes_this_read_cycle_delay) > rdusedqwords_reg + writes_this_read_cycle_delay) 
		rdusedqwords_reg <= 0;
              //prevent rdusedqwords from overflow
              else if ((rdusedqwords_reg - RD_INCREMENT + writes_this_read_cycle_delay) > QWORD_DEPTH)
                rdusedqwords_reg <= QWORD_DEPTH;
	      else
		rdusedqwords_reg <= rdusedqwords_reg - RD_INCREMENT + writes_this_read_cycle_delay;
	   end
	 else begin
	    rdusedqwords_reg <= rdusedqwords_reg + writes_this_read_cycle_delay;
	 end

	 // update empty
	 if (rdusedqwords_reg == 0)	//fixme: or, rdusedqwords_reg == 0??
	   empty_reg <= 1'b1;
	 else
	   empty_reg <= 1'b0;
	 // update almost empty
	 if (rdusedqwords_reg <= 10) 
	   almost_empty_reg <= 1'b1;
	 else
	   almost_empty_reg <= 1'b0;
      end
   end

   // drive output lines from registers
   assign rdusedqwords = rdusedqwords_reg;
   assign clock_crossed_wptr = clock_crossed_wrcounter;	//For rx
   assign clock_crossed_rptr = clock_crossed_rdcounter;	//For tx
   assign empty = empty_reg;
   assign almost_empty = (QWORD_DEPTH > 1) ? almost_empty_reg : 1'b1;

endmodule
