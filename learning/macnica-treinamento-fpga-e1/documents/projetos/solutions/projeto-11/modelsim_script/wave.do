onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/CNTMAX
add wave -noupdate /tb/clk
add wave -noupdate /tb/rst
add wave -noupdate /tb/key
add wave -noupdate /tb/cnt_max
add wave -noupdate /tb/cnt_reset
add wave -noupdate /tb/estavel
add wave -noupdate -radix decimal /tb/cnt
add wave -noupdate /tb/key_debounce
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {159 ps} {424 ps}
