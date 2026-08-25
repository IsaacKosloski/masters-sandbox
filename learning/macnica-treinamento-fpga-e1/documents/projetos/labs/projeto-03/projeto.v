// Projeto 03

module projeto (
	input  [1:0] KEY,
	input  [9:0] SW,
	output [9:0] LEDR
);

wire w_and;
assign w_and = ~KEY[0] & ~KEY[1];

assign LEDR[0] = SW[0] ? w_and : 1'b1;

endmodule

