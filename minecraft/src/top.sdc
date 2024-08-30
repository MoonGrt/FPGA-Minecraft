create_clock -name clk -period 37.037 [get_ports {clk}] -add

create_clock -name mem_clk -period 2.5 -waveform {0 1.25} [get_nets {memory_clk}]
report_timing -hold -from_clock [get_clocks {clk*}] -to_clock [get_clocks {clk*}] -max_paths 25 -max_common_paths 1
report_timing -setup -from_clock [get_clocks {clk*}] -to_clock [get_clocks {clk*}] -max_paths 25 -max_common_paths 1
