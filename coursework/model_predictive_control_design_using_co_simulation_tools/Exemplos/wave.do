-- Circuito Combinacional
-- Prof. Edson Antonio Batista
-- LABSSEM UFMS 
vcom logica1.vhd
vsim work.logica1

add wave  A
add wave  B
add wave  C
add wave  D
add wave  Saida



force A 0
force B 0
force C 0
force D 0
run 50

force A 1
force B 0
force C 0
force D 0
run 200

force A 0
force B 1
force C 0
force D 0
run 200

force A 1
force B 1
force C 0
force D 0
run 200

force A 0
force B 0
force C 1
force D 0
run 200

force A 1
force B 0
force C 1
force D 0
run 200

force A 0
force B 1
force C 1
force D 0
run 200

force A 1
force B 1
force C 1
force D 0
run 200


force A 0
force B 0
force C 0
force D 1
run 200

force A 1
force B 0
force C 0
force D 1
run 200

force A 0
force B 1
force C 0
force D 1
run 200
force A 1
force B 1
force C 0
force D 1
run 200
force A 0
force B 0
force C 1
force D 1
run 200
force A 1
force B 0
force C 1
force D 1
run 200
force A 0
force B 1
force C 1
force D 1
run 200
force A 1
force B 1
force C 1
force D 1
run 200
force A 0
force B 0
force C 0
force D 0
run 200
force A 1
force B 0
force C 0
force D 0
