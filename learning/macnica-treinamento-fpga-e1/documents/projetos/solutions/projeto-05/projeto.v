// Projeto 05

module projeto (
	input  MAX10_CLK1_50,
	input  [1:0] KEY,
	input  [9:0] SW,
	output [9:0] LEDR
);

wire w_enable_n = KEY[0];
wire w_reset_n  = KEY[1];
wire w_sysclk   = MAX10_CLK1_50;

// sincroniza reset

reg r_resetsinc1, r_resetsinc2;
always @ (posedge w_sysclk, negedge w_reset_n) begin
	if (~w_reset_n) begin
		r_resetsinc1 <= 1'b0;
		r_resetsinc2 <= 1'b0;
	end else begin
		r_resetsinc1 <= 1'b1;
		r_resetsinc2 <= r_resetsinc1;
	end
end

wire w_resetsinc_n = r_resetsinc2;

// sincroniza enable

reg r_enablesinc1, r_enablesinc2;
always @ (posedge w_sysclk, negedge w_resetsinc_n) begin
	if (~w_resetsinc_n) begin
		r_enablesinc1 <= 1'b1;
		r_enablesinc2 <= 1'b1;
	end else begin
		r_enablesinc1 <= w_enable_n;
		r_enablesinc2 <= r_enablesinc1;
	end
end

wire w_enablesinc_n = r_enablesinc2;

// contador

reg [31:0] r_contador;
always @ (posedge w_sysclk, negedge w_resetsinc_n) begin
	if (~w_resetsinc_n) begin
		r_contador <= 10'd0;
	end else begin
		if (~w_enablesinc_n) begin
			r_contador <= r_contador + 1;
		end
	end
end

// saida

assign LEDR = r_contador[31:22];

endmodule

