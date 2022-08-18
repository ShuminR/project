`timescale 1ns/1ns
module tb_mux2_1();
  reg	in1;
  reg	in2;
  reg	sel;
  wire 	out;
  
initial	begin
	in1 = 1'b1;
	#15
	in1 = 1'b0;
	#45
	in1 = 1'b1;
	#30
	in1 = 1'b0;
end

initial	begin
	sel = 1'b1;
	#20
	sel = 1'b0;
	#40
	sel = 1'b1;
	#20
	sel = 1'b0;
end
  
initial	begin
	in2 = 1'b1;
	#30
	in2 = 1'b0;
	#30
	in2 = 1'b1;
	#10
	in2 = 1'b0;
end
  
  
mux2_1 mux2_1_inst(
	.in1(in1),
	.in2(in2),
	.sel(sel),
	.out(out)
	);
	
endmodule