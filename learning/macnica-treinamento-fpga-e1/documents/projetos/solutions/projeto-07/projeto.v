// Projeto 07 

module projeto (
	input  MAX10_CLK1_50,
	input  [1:0] KEY,
	output [7:0] HEX0,
	output [7:0] HEX1,
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

// detecta borda

reg r_enable_anterior;
always @ (posedge w_sysclk, negedge w_resetsinc_n) begin
	if (~w_resetsinc_n) begin
		r_enable_anterior <= 1'b1;
	end else begin
		r_enable_anterior <= w_enablesinc_n;
	end
end

wire w_enable_borda = r_enable_anterior & ~w_enablesinc_n;

// contador

reg [9:0] r_contador;
always @ (posedge w_sysclk, negedge w_resetsinc_n) begin
	if (~w_resetsinc_n) begin
		r_contador <= 10'd0;
	end else begin
		if (w_enable_borda) begin
			r_contador <= r_contador + 1;
		end
	end
end

// saida

assign LEDR = r_contador;

// instancia da memoria
wire [7:0] w_memdata;
onchip_mem	onchip_mem_inst (
	.address ( r_contador ),
	.clock ( w_sysclk ),
	.data ( 7'd0 ),
	.wren ( 1'b0 ),
	.q ( w_memdata )
);

// instancia do conversor binario -> sete segmentos
seven_seg u0 (
	.in_8bit (w_memdata),
	.hex0    (HEX0),
	.hex1    (HEX1)
);

endmodule

