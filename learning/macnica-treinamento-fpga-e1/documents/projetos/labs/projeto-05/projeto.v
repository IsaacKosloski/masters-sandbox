// Projeto 05 

module projeto (
	input  MAX10_CLK1_50,
	input  [1:0] KEY,
	input  [9:0] SW,
	output [9:0] LEDR
);

wire w_enable = ~KEY[0];
wire w_reset_n = KEY[1];
wire w_sysclk  = MAX10_CLK1_50;

// contador

reg [31:0] r_contador;
always @ (posedge w_sysclk, negedge w_reset_n) begin
	if (~w_reset_n) begin
		r_contador <= 10'd0;
	end else begin
		if (w_enable) begin
			r_contador <= r_contador + 1;
		end
	end
end

// saida

assign LEDR = r_contador[31:22];

endmodule

