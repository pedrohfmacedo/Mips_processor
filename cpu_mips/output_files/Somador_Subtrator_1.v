module Somador_Subtrator(input [3:0]S, S2,
			  input Se,
			  output reg [3:0] L);
	
	always@*
		begin
			if(Se == 0)
				L = S+S2;
			else
				if(S>S2)
					L = S-S2;
				else
					L = S2-S;
		end

	
endmodule
