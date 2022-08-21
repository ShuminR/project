`timescale 1ns/1ns
module tb_key_filter();
parameter	CNT_1MS = 20'd19 	,
			CNT_11MS = 21'd69 	,
			CNT_41MS = 22'd149 	,
			CNT_51MS = 22'd199 	,
			CNT_60MS = 22'd249 	;

reg	 [19:0]		cnt;
reg 			sys_clk;
reg 			sys_rst_n;
reg				key_in;
wire 			key_flag;

initial begin
	sys_clk 	<= 1'b0;
	sys_rst_n	<= 1'b0;
	key_in 		<= 1'b1;
	//cnt 		<= 20'b0;
	#20
	sys_rst_n 	<= 1'b1;
end

always #10 sys_clk = ~sys_clk;

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		key_in <= 1'b1;
	else if(cnt == CNT_60MS)
		key_in <= 1'b1;
	else if(cnt >= CNT_11MS && cnt <= CNT_41MS)
		key_in <= 1'b0;
	else if((cnt >= CNT_1MS && cnt <= CNT_11MS)||
				(cnt >= CNT_41MS && cnt <= CNT_51MS))
		key_in <= {$random}%2;
	else 
		key_in <= 1'b1;

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt <= 20'b0;
	else if (cnt == CNT_60MS)
		cnt	<= 20'b0;
	else 
		cnt <= cnt + 1'b1;

key_filter key_filter_inst
(
	.sys_clk	(sys_clk),
	.sys_rst_n	(sys_rst_n),
	.key_in		(key_in),
	.key_flag	(key_flag)	
);

endmodule