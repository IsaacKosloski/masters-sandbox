-- Autor: Prof. Dr Edson Antonio Batista
quit -sim

vsim work.exemplo6
add wave -divider "ENTRADAS / ESTIMULOS"
add wave -color Yellow clk 
add wave rst


add wave -divider "VETOR DE ESTADO"
add wave -color Cyan vector_estado

add wave -divider "LEI DE CONTROLE"
add wave -color Magenta ganho_Uk


force clk 0 0, 1 10 -r 20
force rst 1
run 50

force rst 0
run 400

wave zoom full