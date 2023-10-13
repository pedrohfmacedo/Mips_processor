`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
	input CLOCK_27, CLOCK_50,
//Chaves e Botoes	
	input [3:0] KEY,
	input [17:0] SW,
//Displays de 7 seg e LEDs
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
	output [8:0] LEDG,
	output [17:0] LEDR,
//Serial
	output UART_TXD,
	input UART_RXD,
	inout [7:0] LCD_DATA,
	output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
	inout [35:0] GPIO_0, GPIO_1
);
	assign GPIO_1 = 36'hzzzzzzzzz;
	assign GPIO_0 = 36'hzzzzzzzzz;
	assign LCD_ON = 1'b1;
	assign LCD_BLON = 1'b1;
	wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
	w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
	
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);

//---------- modifique a partir daqui --------
wire w_RegWrite,w_RegDst, w_ULASrc,w_MemWrite,w_MemtoReg,w_Z,w_PCSrc,w_Jump,w_Branch, w_We;
wire [2:0]w_ULAControl, w_wa3;
wire [7:0]w_PC,w_rd1SrcA ,w_rd2,w_SrcB, w_ULAResultWd3,w_pcp1,local_w,w_wd3,w_RData,w_PCBranch,w_m1,w_nPC, w_DataOut, w_DataIn, w_RegData;
wire [31:0]w_inst;
assign w_pcp1 = w_PC + 1;
assign w_d0x4 = w_PC;
assign LEDR[4] = w_ULAControl[0]; assign LEDR[5] = w_ULAControl[1]; assign LEDR[6] = w_ULAControl[2]; assign LEDR[7] = w_ULASrc; assign LEDR[8] = w_RegDst; assign LEDR [9] = w_RegWrite;
assign w_PCSrc = w_Z & w_Branch;
assign w_PCBranch = w_inst[7:0]+w_pcp1;
assign w_DataOut = w_d1x4;
assign w_DataIn  = SW[7:0];

MUX2_1 	PCSr(w_PCBranch,w_pcp1,w_PCSrc,w_m1);
MUX2_1	Jump(w_inst[7:0],w_m1,w_Jump,w_nPC);
Program_Counter PC(w_nPC, KEY[1],w_PC);
Control_Unit Controle(w_inst[31:26], w_inst[5:0],w_RegWrite, w_RegDst, w_ULASrc, w_Branch,w_MemWrite,w_MemtoReg, w_Jump, w_ULAControl[2:0]);
Register File(KEY[1],w_RegWrite,w_wd3,local_w,w_d0x0,w_d0x1,w_d0x2,w_d0x3,w_d1x0,w_d1x1,w_d1x2,w_d1x3);
MUX      RD1 (w_d0x0,w_d0x1,w_d0x2,w_d0x3,w_d1x0,w_d1x1,w_d1x2,w_d1x3,w_inst[25:21],w_rd1SrcA[7:0]);
MUX      RD2 (w_d0x0,w_d0x1,w_d0x2,w_d0x3,w_d1x0,w_d1x1,w_d1x2,w_d1x3,w_inst[20:16],w_rd2[7:0]);
MUX2_1   ULASrc(w_inst[7:0],w_rd2[7:0],w_ULASrc,w_SrcB[7:0]);
Decoder 	D(w_wa3,local_w);
ULA      ALU(w_rd1SrcA[7:0],w_SrcB[7:0],w_ULAControl[2:0],w_Z,w_ULAResultWd3[7:0]);
RAM Data_Mem(w_ULAResultWd3,CLOCK_50,w_rd2,w_We,w_RData);
MUX2_1   Dest(w_RegData,w_ULAResultWd3,w_MemtoReg,w_wd3);
MUX2_1   WR(w_inst[15:11], w_inst[20:16],w_RegDst,w_wa3);
RomInstMem_init Inst_Mem(w_PC,CLOCK_50,w_inst);
Parallel_Out Saida (.RegData(w_rd2), .Address(w_ULAResultWd3), .Clk(KEY[1]), .We(w_MemWrite), .Data_Out(w_DataOut), .Wren(w_We));
Parallel_In Entrada (.MemData(w_RData), .Address(w_ULAResultWd3), .Data_in(w_DataIn), .Reg_Data(w_RegData));
endmodule

module MUX(input [7:0]a,b,c,d,e,f,g,h,
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


module Register (input clk, enable, 
					  input [7:0]data,local,
					  output reg [7:0]s0,s1,s2,s3,s4,s5,s6,s7);
					  
	always@(posedge clk)begin
		if(enable) 
			case(local)
				8'b00000001:s0=data;
				8'b00000010:s1=data;
				8'b00000100:s2=data;
				8'b00001000:s3=data;
				8'b00010000:s4=data;
				8'b00100000:s5=data;
				8'b01000000:s6=data;
				8'b10000000:s7=data;
			endcase
	end
	

endmodule



