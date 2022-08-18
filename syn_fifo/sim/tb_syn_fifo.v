`timescale 1ns/1ps
module tb_syn_fifo;
	reg				sys_rst_n;
	reg  				sys_clk;
	reg 	[15:0]	data_in;
	wire	[15:0]	data_out;
	wire 			full;
	wire			empty;
	reg				rd_req;
	reg				wr_req;

syn_fifo syn_fifo_inst	
(
	.sys_clk	(sys_clk),
	.sys_rst_n	(sys_rst_n),
	.data_in	(data_in),
	.wr_req		(wr_req),
	.rd_req		(rd_req),

	.data_out	(data_out),
	.empty		(empty),
	.full		(full)
);
initial	sys_clk = 1'b0;
always	#10	sys_clk = ~sys_clk;

initial begin 
	sys_rst_n <= 1'b0;
	wr_req <= 1'b0;
	rd_req <= 1'b0;
	#200
	sys_rst_n <= 1'b1;
	#20000
	wr_req <= 1'b1;
	#20000
	wr_req <= 1'b0;
	rd_req <= 1'b1;
	#20000
	rd_req <= 1'b0;
	//$stop
	wr_req <= 1'b0;
end

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		data_in <= 16'd0;
	else if(wr_req == 1'b1)
		data_in <= data_in + 1'b1;
	else
		data_in <= data_in;
	
endmodule
