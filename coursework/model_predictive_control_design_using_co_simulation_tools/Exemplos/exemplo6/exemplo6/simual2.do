-- ============================================================
-- Autor: Prof. Dr. Edson Antonio Batista
-- Versão didática para visualização no ModelSim
-- Exemplo 6 / 7 - Espaço de estados e lei de controle
-- ============================================================

quit -sim
vlib work
vsim work.exemplo6

-- ============================================================
-- Configuração geral da janela Wave
-- ============================================================
--view wave
--wave clear

--configure wave -namecolwidth 250
--configure wave -valuecolwidth 120
--configure wave -justifyvalue left
--configure wave -signalnamewidth 1
--configure wave -timelineunits ns
--configure wave -snapdistance 10
--configure wave -gridoffset 0
--configure wave -gridperiod 20
--configure wave -griddelta 2
--configure wave -rowmargin 4
--configure wave -childrowmargin 2

-- ============================================================
-- BLOCO 1 - ENTRADAS / ESTÍMULOS
-- ============================================================
add wave -divider "ENTRADAS / ESTIMULOS"

add wave -color Yellow \
    -label "clock" sim:/exemplo6/clk

add wave -color Red \
    -label "reset" sim:/exemplo6/rst

-- ============================================================
-- BLOCO 2 - VARIÁVEIS DE ESTADO
-- ============================================================
add wave -divider "VETOR DE ESTADO"

add wave -color Cyan \
    -label "x(k+1) = vector_estado" sim:/exemplo6/vector_estado

-- ============================================================
-- BLOCO 3 - LEI DE CONTROLE
-- ============================================================
add wave -divider "LEI DE CONTROLE"

add wave -color Magenta \
    -label "u(k) = ganho_Uk" sim:/exemplo6/ganho_Uk

-- ============================================================
-- ESTÍMULOS
-- Clock com período de 20 ns
-- ============================================================
force -freeze sim:/exemplo6/clk 0 0, 1 10 -r 20

-- Reset inicialmente ativo
force -freeze sim:/exemplo6/rst 1

-- Executa durante o reset para inicialização
run 40 ns

-- Libera o reset
force -freeze sim:/exemplo6/rst 0

-- Executa a dinâmica do sistema
run 160 ns

-- ============================================================
-- AJUSTE FINAL DA VISUALIZAÇÃO
-- ============================================================
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40 ns} 0}
quietly wave cursor active 1
WaveRestoreZoom {0 ns} {220 ns}