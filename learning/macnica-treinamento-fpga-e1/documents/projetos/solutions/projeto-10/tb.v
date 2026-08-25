// testbench

module tb();

reg clk;
initial begin
	clk = 1'b0;
	forever #5 clk = ~clk;
end

reg rst;
initial begin
	rst = 1'b1;
	#12 rst = 1'b0;
end

reg key;
initial begin
	key      = 1'b1;
	#152 key = ~key;
	#50  key = ~key;
	#30  key = ~key;
	#500 key = ~key;
	#50  key = ~key;
	#30  key = ~key;
	#10  key = ~key;
	#10  key = ~key;
	#10  key = ~key;
	#20  key = ~key;
	#20  key = ~key;
	#20  key = ~key;
	#30  key = ~key;
	#30  key = ~key;
	#50  key = ~key;
	#50  key = ~key;
end

wire cnt_max, cnt_reset;

debounce dut (
	.clock     (clk),
	.reset     (rst),
	.key_in    (key),
	.cnt_max   (cnt_max),
	.cnt_reset (cnt_reset),
	.estavel   (estavel)
);

localparam CNTMAX = 10;

reg [31:0] cnt;
always @(posedge clk, posedge cnt_reset) begin
	if (cnt_reset) cnt <= 0;
	else if (cnt<CNTMAX) cnt <= cnt+1;
end

assign cnt_max = (cnt==CNTMAX);

reg key_debounce;
always @(posedge clk, posedge rst) begin
	if (rst) key_debounce <= 1'b1;
	else if (estavel) key_debounce <= key;
end

endmodule

