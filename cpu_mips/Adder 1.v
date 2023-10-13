module adder(input [7:0]lcd,
				output [7:0]s);

		assign s = lcd+1'b1;

endmodule
