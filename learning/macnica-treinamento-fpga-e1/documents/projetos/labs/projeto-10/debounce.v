// debounce

module debounce (
	input clock,
	input reset,
	input key_in,
	input cnt_max,
	output cnt_reset,
	output estavel
);

localparam ST_ESTAVEL_ZERO  = 2'b00;
localparam ST_INSTAVEL_ZERO = 2'b01;
localparam ST_INSTAVEL_UM   = 2'b10;
localparam ST_ESTAVEL_UM    = 2'b11;

reg [1:0] r_estado_atual;
reg [1:0] w_proximo_estado;

always @ (posedge clock, posedge reset) begin
	if (reset) begin
		r_estado_atual <= ST_ESTAVEL_UM;
	end else begin
		r_estado_atual <= w_proximo_estado;
	end
end

always @* begin
	w_proximo_estado <= r_estado_atual;
	case (r_estado_atual)
		ST_ESTAVEL_ZERO:
			if (key_in) w_proximo_estado <= ST_INSTAVEL_UM;
		ST_ESTAVEL_UM:
			if (~key_in) w_proximo_estado <= ST_INSTAVEL_ZERO;
		ST_INSTAVEL_ZERO:
			if (cnt_max) w_proximo_estado <= ST_ESTAVEL_ZERO;
			else if (key_in) w_proximo_estado <= ST_INSTAVEL_UM;
		ST_INSTAVEL_UM:
			if (cnt_max) w_proximo_estado <= ST_ESTAVEL_UM;
			else if (~key_in) w_proximo_estado <= ST_INSTAVEL_ZERO;
	endcase
end

reg r_reset_out;
always @ (posedge clock, posedge reset) begin
	if (reset) begin
		r_reset_out <= 1'b1;
	end else begin
		r_reset_out <= 1'b0;
		case (r_estado_atual)
			ST_ESTAVEL_ZERO:  r_reset_out <= 1'b1;
			ST_ESTAVEL_UM:    r_reset_out <= 1'b1;
			ST_INSTAVEL_ZERO: r_reset_out <= key_in;
			ST_INSTAVEL_UM:   r_reset_out <= ~key_in;
		endcase
	end
end

assign cnt_reset = r_reset_out | reset;
assign estavel = (w_proximo_estado==ST_ESTAVEL_ZERO || w_proximo_estado==ST_ESTAVEL_UM);

endmodule

