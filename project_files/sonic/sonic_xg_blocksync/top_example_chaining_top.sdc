derive_pll_clocks 
derive_clock_uncertainty
create_clock -period 10.0 -name {free_100MHz} {free_100MHz}
create_clock -period 5.0 -name {clk_200MHz} [get_ports clk_200MHz]

create_generated_clock -add -source pll_644|inclk0 \
						-name clk_644MHz \
					   -multiply_by 33 \
						-divide_by 8 \
					   -duty_cycle 50 \
						[get_pins pll_644|c0]
						
create_generated_clock -add -source pll_156|inclk0 \
							  -name clk_156MHz \
							  -multiply_by 25 \
							  -divide_by 32 \
							  -duty_cycle 50 \
							  [get_pins pll_156|c0]
							  
create_generated_clock -add -source pll_156|inclk0 \
							  -name clk_50MHz \
							  -multiply_by 1 \
							  -divide_by 4 \
							  [get_pins pll_156|c1]
							  
create_generated_clock -add -source pll_156|inclk0 \
							  -name clk_125MHz \
							  -multiply_by 5 \
							  -divide_by 8 \
							  -duty_cycle 50 \
							  [get_pins pll_156|c2]

