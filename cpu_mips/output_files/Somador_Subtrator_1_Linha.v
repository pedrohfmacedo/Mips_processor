module Somador_Subtrator_1L(input [3:0]S, S2,
			  input Se,
			  output reg [3:0] L);
	
	always@*
	L = Se ? S-S2 : S+S2;
	
endmodule
