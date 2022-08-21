module key_filter
#(
parameter	CNT_MAX_20MS = 20'd24
)
(
	input 	wire	 sys_clk,
	input 	wire	 sys_rst_n,
	input 	wire	 key_in,
	output 	reg	 	 key_flag		//key_flag == 1'b1 is not press
									//key_flag == 1'b0 is press
);

reg	[19:0]	cnt_20ms;	//count the time key keep press

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt_20ms <= 20'b0;
	else if(key_in == 1'b1)
		cnt_20ms <= 20'b0;
	else if(cnt_20ms == CNT_MAX_20MS && key_in == 1'b0)
		cnt_20ms <= cnt_20ms;
	else 
		cnt_20ms <= cnt_20ms + 1'b1;

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		key_flag <= 1'b0;
	else if (cnt_20ms == CNT_MAX_20MS - 1'b1)
		key_flag <= 1'b1;
	else 
		key_flag <= 1'b0;
		
endmodule