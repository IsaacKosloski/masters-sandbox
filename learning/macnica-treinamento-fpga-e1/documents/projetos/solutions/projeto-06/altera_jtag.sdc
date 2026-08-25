#JTAG Signal Constraints
#constrain the TCK port
create_clock -name altera_reserved_tck -period 33 [get_ports altera_reserved_tck]
#cut all paths to and from altera_reserved_tck
set_clock_groups -exclusive -group [get_clocks altera_reserved_tck]
#constrain the TDI port
set_input_delay -clock altera_reserved_tck -clock_fall 5 [get_ports altera_reserved_tdi]
#constrain the TMS port
set_input_delay -clock altera_reserved_tck -clock_fall 5 [get_ports altera_reserved_tms]
#constrain the TDO port
set_output_delay -clock altera_reserved_tck -clock_fall 5 [get_ports altera_reserved_tdo]

