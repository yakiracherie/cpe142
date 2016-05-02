`timescale 1ns/1ns

module memorymodule(address, clk, rst);
	reg [15:0] instructions[0:26];

	always@(posedge clk or negedge rst) begin
	   if(!rst)
	   begin
		instructions[0] <= 16'b0000_0001_0010_1111;  //00 ADD R1, R2
		instructions[1] <= 16'b0000_0001_0010_1110; 	//02 SUB R1, R2
		instructions[2] <= 16'b0000_0011_0100_1100;  //04 OR R3, R4
		instructions[3] <= 16'b0000_0011_0010_1101;	//06 AND R3, R2
		instructions[4] <= 16'b0000_0101_0110_0001;	//08 MUL R5, R6
		instructions[5] <= 16'b0000_0001_0101_0010;	//0A DIV R1, R5
		instructions[6] <= 16'b0000_0000_0000_1110;	//0C SUB R0, R0
		instructions[7] <= 16'b0000_0100_0011_1010;	//0E SLL R4, 3
		instructions[8] <= 16'b0000_0100_0010_1011;	//10 SLR R4, 2
		instructions[9] <= 16'b0000_0110_0011_1000;	//12 ROL R6, 3
		instructions[10]<= 16'b0000_0110_0010_1001;	//14 ROR R6, 2
		instructions[11]<= 16'b0110_0111_0000_0100;	//16 BEQ R7, 4
		instructions[12]<= 16'b0000_1011_0001_1111;	//18 ADD R11, R1
		instructions[13]<= 16'b0100_0111_0000_0101;	//1A BLT R7, 5
		instructions[14]<= 16'b0000_1011_0010_1111;	//1C ADD R11, R2
		instructions[15]<= 16'b0101_0111_0000_0010;	//1E BGT R7, 2
		instructions[16]<= 16'b0000_0010_0001_1111;	//20 ADD R2, R1
		instructions[17]<= 16'b0000_0010_0001_1111;	//22 ADD R2, R1
		instructions[18]<= 16'b1000_1000_1001_0000;	//24 LW R8, 0(R9)
		instructions[19]<= 16'b0000_1000_0101_1111;	//26 ADD R8, R5
		instructions[20]<= 16'b1011_1000_1001_0010;	//28 SW R8, 2 (R9)
		instructions[21]<= 16'b1000_1010_1001_0010;	//2A LW R10, 2 (R9)
		instructions[22]<= 16'b0000_1100_1100_1111;	//2C ADD R12, R12
		instructions[23]<= 16'b0000_1101_1101_1110;	//2E SUB R13, R13
		instructions[24]<= 16'b0000_1100_1101_1111;	//30 ADD R12, R13
		instructions[25]<= 16'hEBCF;					//32 EBCF
	  end
	end
endmodule
