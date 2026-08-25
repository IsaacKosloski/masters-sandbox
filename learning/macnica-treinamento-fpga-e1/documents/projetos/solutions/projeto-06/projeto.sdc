create_clock -name clk50 -period 50MHz [get_ports MAX10_CLK1_50]

derive_clock_uncertainty

set_false_path -from [get_ports {KEY[0]}]
set_false_path -from [get_ports {KEY[1]}]
set_false_path -to   [get_ports {LED*}]

