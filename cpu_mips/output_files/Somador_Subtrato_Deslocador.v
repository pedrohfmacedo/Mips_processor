  module Somador_Subtrator_Deslocador(input [3:0]S, S2,
												input [1:0] Se,
												output reg [3:0] L);
	
	always@*
		begin
			if(Se == 2'b00)
				L = S + S2;
			else if (Se == 2'b01)
				L = S - S2;
			else if (Se== 2'b10)
				L = S >> S2;
			else
				L = S << S2;
		end
		
endmodule