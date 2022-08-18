module half_adder
(
	input			in1,
	input			in2,
	output			sum,
	output			cout
);

assign {cout,sum} = in1 + in2;
endmodule 