module divider_six
#(
	parameter cnt_max = 3'd2
)
(
	input wire		sys_clk,
	input wire		sys_rst_n,
	output reg		cnt_clk
);

reg [2:0]	cnt;
reg 		flag;

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt <= 2'b0;
	else if(cnt == cnt_max)
		cnt <= 2'b0;
	else 
		cnt <= cnt + 1;
		
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		flag <= 1'b0;
	else if (cnt == cnt_max)
		flag <= 1'b1;
	else 
		flag <= 1'b0;
		
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt_clk <= 1'b0;
	else if(flag == 1'b1)
		cnt_clk <= ~cnt_clk;
	else cnt_clk <= cnt_clk;
	
endmodule