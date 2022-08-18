`timescale 1ns/1ns
module tb_flip_flop();
reg key_in;
reg sys_clk;
reg	sys_rst_n;
wire led_out;
initial begin
	sys_clk <= 1'b0;
	sys_rst_n <= 1'b0;
	key_in <= 1'b0;
	#30
	sys_rst_n <= 1'b1;
	key_in <= 1'b1;
	#10
	key_in <= 1'b0;
	#40
	key_in <= 1'b1;
	sys_rst_n <= 1'b1;
	#5
	key_in <= 1'b0;
	#5
	key_in <= 1'b1;
	#5
	key_in <= 1'b0;
	#5
	key_in <= 1'b1;
	#40
	sys_rst_n <= 1'b0;
	#5
	key_in <= 1'b0;
	end
always #20 sys_clk <= ~sys_clk;

flip_flop flip_flop_inst
(
	.sys_clk	(sys_clk),
	.sys_rst_n	(sys_rst_n),
	.key_in		(key_in),
	.led_out	(led_out)
);
endmodule