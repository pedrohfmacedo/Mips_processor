module Parallel_In (input [7:0] MemData, Address, Data_in,
						  output reg [7:0]Reg_Data);
						 always@(*)begin 
      Reg_Data = (Address == 8'hff)? Data_in : MemData;  
						end
endmodule
							