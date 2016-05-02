`timescale 1ns / 1ns

module registerFile(clk, rst, readReg1, readReg2, writeReg, readData1, readData2, writeData, RegWrite);

input clk, rst;
input [3:0] readReg1, readReg2;
input [3:0] writeData; 
input RegWrite;

output reg [15:0] readData1, readData2;
reg [15:0] registerfile[0:15];

always @(*) 
begin
	readData1 = registerfile[readReg1];
	readData2 = registerfile[readReg2];
end

always @(posedge clk or negedge rst) 
begin
	if (!reset)
	begin
		registerfile[0] <= 16'b0000_0000_0000_0000; 
		registerfile[1] <= 16'b0000_1111_0000_0000;	
		registerfile[2] <= 16'b0000_0000_0101_0000;
		registerfile[3] <= 16'b1111_1111_0000_1111;
		registerfile[4] <= 16'b1111_0000_1111_1111;
		registerfile[5] <= 16'b0000_0000_0100_0000;
		registerfile[6] <= 16'b0000_0000_0010_0100;
		registerfile[7] <= 16'b0000_0000_1111_1111;
		registerfile[8] <= 16'b1010_1010_1010_1010;
		registerfile[9] <= 16'b0000_0000_0000_0000;
		registerfile[10] <= 16'b0000_0000_0000_0000;
		registerfile[11] <= 16'b0000_0000_0000_0000;
		registerfile[12] <= 16'b1111_1111_1111_1111;
		registerfile[13] <= 16'b0000_0000_0000_0010;
		registerfile[14] <= 16'b0000_0000_0000_0000;
		registerfile[15] <= 16'b0000_0000_0000_0000;						
	end
	else if (RegWrite)
	begin
		registerfile[readReg1] <= writeData;
	end
end
endmodule
