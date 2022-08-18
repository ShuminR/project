module syn_fifo
#(
	parameter DATA_WIDTH = 16,
	parameter DATA_DEPTH = 8,
	parameter RAM_DEPTH  = DATA_DEPTH-1 
)
(
	input 						sys_clk,
	input   					sys_rst_n,
	input	[DATA_DEPTH-1:0]	data_in,
	input	reg					wr_req,
	input	reg					rd_req,
	
	output reg [DATA_DEPTH-1:0]	data_out,
	output						empty,
	output						full
);
reg		[DATA_DEPTH-1:0]	wr_cnt;
reg		[DATA_DEPTH-1:0]	rd_cnt;
reg		[DATA_DEPTH-1:0]	data_cnt;

assign	full = (data_cnt == (RAM_DEPTH-1))?1'b1:1'b0;	// full signal
assign 	empty = (data_cnt == 0)?1'b1:1'b0;				// empty signal
	
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		wr_cnt <= 0;
	else if(wr_cnt == RAM_DEPTH-1)
		wr_cnt <= 0;
	else if(wr_req == 1'b1)
		wr_cnt <= wr_cnt + 1'b1;
	else
		wr_cnt <= wr_cnt;
		
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		rd_cnt <= 0;
	else if(rd_cnt == RAM_DEPTH-1)
		rd_cnt <= 0;	
	else if(rd_req == 1'b1)
		rd_cnt <= rd_cnt + 1'b1;
	else
		rd_cnt <= rd_cnt;
		
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		data_cnt <= 0;
	else if(rd_req &&(!wr_req)&&(data_cnt !=0))
		data_cnt <= data_cnt - 1;
	else if(wr_req &&(!rd_req)&&(data_cnt !=DATA_DEPTH-1))
		data_cnt <= data_cnt + 1;
	else
		data_cnt <=	data_cnt;

/*
Syn Dual Port RAM
One clock, one for read adress, one for write adress
*/
integer i;
reg		[DATA_DEPTH-1:0]	register[RAM_DEPTH-1:0];

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)begin
		for(i = 0; i <= RAM_DEPTH-1; i=i+1)
			register[i] <= 0;
		end
	else if(wr_req == 1'b1)
		register[wr_cnt] <= data_in;

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		data_out <= 0;
	else if(rd_req == 1'b1)
		data_out <= register[rd_cnt];
	else
		data_out <= data_out;

endmodule