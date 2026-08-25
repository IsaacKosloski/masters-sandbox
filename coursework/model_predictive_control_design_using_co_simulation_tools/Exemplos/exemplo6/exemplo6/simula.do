quit -sim

vsim work.exemplo6

add wave clk
add wave rst
add wave vector_estado
add wave ganho_Uk


force clk 0 0, 1 10 -r 20
force rst 1
run 50

force rst 0
run 100