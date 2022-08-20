`timescale 1ns/1ns
module tb_divider_six();
reg sys_clk;
reg sys_rst_n;
wire cnt_clk;

initial begin
	sys_clk = 1'b0;
	sys_rst_n <= 1'b0;
	#20
	sys_rst_n <= 1'b1;
end

always #10 sys_clk = ~sys_clk;

divider_six diveder_six_inst
(
	.sys_clk	(sys_clk),
	.sys_rst_n	(sys_rst_n),
	.cnt_clk	(cnt_clk)
);
endmodule