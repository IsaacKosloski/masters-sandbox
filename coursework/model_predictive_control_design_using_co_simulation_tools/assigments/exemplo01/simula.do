quit -sim

vlib ieee_proposed.lib
vmap ieee_proposed ./ieee_proposed.lib
vcom -2008 -work ieee_proposed real_matrix_pkg.vhdl
vcom -2008 -work ieee_proposed real_matrix_pkg_body.vhdl

vlib work
vmap work work
vcom -2008 exemplo01.vhd
vsim work.exemplo01

add wave -radix decimal /exemplo01/rst
add wave -radix decimal /exemplo01/a
add wave -radix decimal /exemplo01/b
add wave -radix decimal /exemplo01/c

force rst 1 0
run 20 ns
force rst 0
run 20 ns

wave zoom full