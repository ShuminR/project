/*
normally, the key is 1'b1, every time press key, the key get 1'b0, release key, key go back to 1'b1.
so we want to get falling edge, we use reg to delay 1 clock time and detect falling edge as an enable signal
to reverse the led signal
*/
module touch_ctrl_led
(
	input 	wire 		sys_clk,
	input 	wire		sys_rst_n,
	input 	wire		touch_key,
	output	reg			led
);

reg touch_key_dly1;
reg touch_key_dly2;
wire touch_en;

assign touch_en = ((touch_key_dly1 == 1'b0) && (touch_key_dly2 == 1'b1));

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		begin
			touch_key_dly1 <= 1'b0;
			touch_key_dly2 <= 1'b0;
		end
	else
		begin
			touch_key_dly1 <= touch_key;
			touch_key_dly2 <= touch_key_dly1;
		end
	
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		led <= 1'b1;
	else if(touch_en == 1'b1)
		led <= ~led;
		
endmodule