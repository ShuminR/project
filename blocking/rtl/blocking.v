/*
blocking assign "="	whatever how many ,only delay one clock time
now_blocking assign "<=" how may time use,delay how may clock time
*/
module blocking
(   input		wire					sys_clk,
	input		wire					sys_rst_n,
	input		wire	[1:0]		in,
	output		reg		[1:0]		led_out
);
reg		[1:0]	reg_in;
reg		[1:0]	reg_in1;
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)begin
		reg_in 		= 2'b0;
		reg_in1 	= 2'b0;
		led_out		= 2'b0;
		end
	else begin
		reg_in1 	= in;
		reg_in   	= reg_in1;
		led_out 	= reg_in;
		end
		
endmodule
