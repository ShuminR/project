module mux2_1
(
	input 		wire		in1,
	input 		wire		in2,
	input 		wire		sel,
	output		reg			out
);
always@(*)
	case(sel)
		1'b1:out =in1;
		1'b0:out =in2;
		default:out = in1;
	endcase
endmodule
