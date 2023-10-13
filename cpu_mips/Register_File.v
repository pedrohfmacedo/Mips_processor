module Register_File(input [2:0]inputs,
							input clk, enable,
							input [7:0]wd3,we3,
							input [3:0] ra1,ra2,
							output reg [7:0] wa3,rd1_SrcA,rd2,
							output reg [7:0]s0,s1,s2,s3,s4,s5,s6,s7);
							//wd3 = dados, we3 = local
							//inputs = endereço
							//wa3 = endereço decodificado
							//Sx = saída dos registradores
							//ra1/ra2 = seleciona saida dos muxx
	//decoder				
	always@(*)begin
		case(inputs)
			3'b000:wa3=8'b00000001;
			3'b001:wa3=8'b00000010;
			3'b010:wa3=8'b00000100;
			3'b011:wa3=8'b00001000;
			3'b100:wa3=8'b00010000;
			3'b101:wa3=8'b00100000;
			3'b110:wa3=8'b01000000;
			3'b111:wa3=8'b10000000;
		endcase
	end

	//registradores			  
	always@(posedge clk)begin
		if(enable) 
			case(we3)
				8'b00000001:s0=wd3;
				8'b00000010:s1=wd3;
				8'b00000100:s2=wd3;
				8'b00001000:s3=wd3;
				8'b00010000:s4=wd3;
				8'b00100000:s5=wd3;
				8'b01000000:s6=wd3;
				8'b10000000:s7=wd3;
			endcase
	end
//mux d1
//mux d2
	MUX2 D1(s0,s1,s2,s3,s4,s5,s6,s7,ra1,rd1_SrcA);
	MUX2 D2(s0,s1,s2,s3,s4,s5,s6,s7,ra2,rd2);
	
endmodule

module MUX2(input [7:0]a,b,c,d,e,f,g,h,
			  input [3:0] sel,		  
			  output reg[7:0] out );
			  
    always @(*) begin
        case (sel)
            4'd0: out = a;
            4'd1: out = b;
            4'd2: out = c;
            4'd3: out = d;
            4'd4: out = e;
            4'd5: out = f;
            4'd6: out = g;
            4'd7: out = h;
            default: out = {8{1'b1}};  
        endcase
		  
    end
endmodule
