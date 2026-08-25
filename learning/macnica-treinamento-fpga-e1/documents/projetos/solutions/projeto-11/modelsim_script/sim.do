# script em tcl para rodar simulação

# cria a pasta work e vicula a biblioteca
vlib work 

# compila o debounce
vlog ../debounce.v 

# compila o testebench
vlog ../tb.v  

#inicia a simulação do modulo tb dentro da biblioteca work 
vsim work.tb 

# recupera a forma de onda salva
do wave.do 

# rodar a simulação
run 1500 


