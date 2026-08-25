// Projeto 01 

module projeto (
	input  [1:0] KEY,
	output [0:0] LEDR
);

assign LEDR[0] = ~KEY[0] & ~KEY[1];

endmodule

