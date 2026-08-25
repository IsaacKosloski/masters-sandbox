// Projeto 03

module projeto (
	input  [1:0] KEY,
	input  [9:0] SW,
	output [9:0] LEDR
);

wire w_and;
assign w_and = ~KEY[0] & ~KEY[1];

assign LEDR[0] = SW[0] ? w_and : 1'b1;

reg w_and2;
always @* begin
	if ( SW[0] ) begin
		w_and2 <= ~KEY[0] & ~KEY[1];
	end else begin
		w_and2 <= 1'b1;
	end
end

assign LEDR[1] = w_and2;

endmodule

