module Parallel_Out (input [7:0] RegData, Address, 
							input Clk, We,
							output reg [7:0] Data_Out, 
							output reg Wren);
	
		always@(posedge Clk)begin 
			if(Address == 8'hff & We==1'h1) Data_Out = RegData;			
			if(Address != 8'hff & We) Wren = 1;
 		end
endmodule
							