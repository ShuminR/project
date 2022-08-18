module tb_half_adder();
reg		in1;
reg		in2;

initial begin
	in1 <= 1'b0;
	in2 <= 1'b0;
end

always #10 in1 <= {$random}%2;
always #10 in2 <= {$random}%2;

half_adder tb_half_adder
(
		.in1	(in1),
		.in2	(in2),
		.sum	(sum),
		.cout	(cont)
);

endmodule