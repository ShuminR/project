module full_adder(
	input	wire	in1,
	input	wire	in2,
	input	wire	cin,
	output 	wire	cout,
	output  wire	sum
);

wire 		cout1;
wire		cout2;
wire		sum1;

assign cout = cout1||cout2;

half_adder half_adder_inst0
(
	.in1	(in1),
	.in2	(in2),
	.sum	(sum1),
	.cout	(cout1)
);

half_adder half_adder_inst1
(
	.in1	(sum1),
	.in2	(cin),
	.sum	(sum),
	.cout	(cout2)
);

endmodule
/*
if in1,in2,cin both 0, the sum and cout is 0
if in1,in2,cin summation is 1, the sum is 1 and the cout is 0
if in1,in2,cin summation is 2, the sum is 0 and the cout is 1
if in1,in2,cin summation is 3, the sum is 1 and the cout is 1
*/