module Control_Unit(input [5:0]OP,Funct,
					output reg RegWrite, RegDst, ULASrc, Branch, MemWrite, MemtoReg, Jump,
               output reg [2:0] ULAControl);

	always@(*)begin	
		if(OP == 6'b000000)begin
          case(Funct)
				6'd32:begin  RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b010; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
				6'd34:begin  RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b110; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
				6'd36:begin  RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b000; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
				6'd37:begin  RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b001; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
				6'd39:begin  RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b011; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
				6'd42:begin  RegWrite = 1; RegDst = 1; ULASrc = 0; ULAControl = 3'b111; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
          endcase
          end
     else begin
          case(OP)
				6'd35:begin  RegWrite = 1; RegDst = 0; ULASrc = 1; ULAControl = 3'b010; Branch = 0; MemWrite = 0; MemtoReg = 1; Jump = 0;end
				6'd43:begin  RegWrite = 0; RegDst = 0; ULASrc = 1; ULAControl = 3'b010; Branch = 0; MemWrite = 1; MemtoReg = 0; Jump = 0;end
				6'd4:begin   RegWrite = 0; RegDst = 0; ULASrc = 0; ULAControl = 3'b110; Branch = 1; MemWrite = 0; MemtoReg = 0; Jump = 0;end				
				6'd8:begin   RegWrite = 1; RegDst = 0; ULASrc = 1; ULAControl = 3'b010; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 0;end
				6'd2:begin   RegWrite = 0; RegDst = 0; ULASrc = 0; ULAControl = 3'b000; Branch = 0; MemWrite = 0; MemtoReg = 0; Jump = 1;end
          endcase
			 end
	end
endmodule
 
            