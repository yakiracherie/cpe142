`include "registerFile.v"

module stimulus;

reg [3:0] readReg1, readReg2, writeReg;
reg [15:0] writeData; 
reg RegWrite;
reg clk, rst;
wire [15:0] readData1, readData2;

initial
	$vcdpluson;
initial
$monitor($time,"RegWrite = %b readReg1 = %b, readReg2 = %b, readData1 = %h, readData2 = %b, writeReg = %b writeData = %b rst = %b", RegWrite, readReg1, readReg2, readData1, readData2, writeReg, writeData, rst);

registerFile regFile(.clk(clk),.rst(rst), .readData1(readData1), .readData2(readData2), .writeReg(writeReg), .writeData(writeData), .RegWrite(RegWrite), .readReg1(readReg1), .readReg2(readReg2));
initial
begin
	clk = 0;
	rst = 0;	
	RegWrite = 1'b0;
	readReg1 = 0;
	readReg2 = 0;
	writeReg = 0;
end

always
	#5 clk = !clk;

initial
begin
	RegWrite = 1'b0;
	readReg1 = 4'b0001;
	readReg2 = 4'b0010;

	#10
	RegWrite = 1'b0;
	readReg1 = 4'b0011;
	readReg2 = 4'b0100;
	
	#10
	RegWrite = 1'b0;
	readReg1 = 4'b0101;
	readReg2 = 4'b0110;
	
	#10
	RegWrite = 1'b0;
	readReg1 = 4'b0111;
	readReg2 = 4'b1000;
	
	#10
	RegWrite = 1'b0;
	readReg1 = 4'b1001;
	readReg2 = 4'b1010;
	
	#10
	RegWrite = 1'b0;
	readReg1 = 4'b1011;
	readReg2 = 4'b1100;
	
	#10
	RegWrite = 1'b0;
	readReg1 = 4'b1101;
	readReg2 = 4'b1110;
	
	#10
	RegWrite = 1'b0;
	readReg1 = 4'b1111;
	readReg2 = 4'b0000;
	
	#10
	RegWrite = 1'b1;
	writeReg = 4'b1111;
	readReg1 = 4'b1111;
	readReg2 = 4'b0000;
	writeData = 16'b0000_1111_0000_1111;

end

initial
begin
#100 $finish;
end


endmodule
