`include "memorymodule.v"

module stimulus;

reg [15:0] readAddress;
reg clk, rst;
wire [15:0] instruction;

initial
	$vcdpluson;
initial
$monitor($time,"	readAddress = %b, instruction = %b, rst = %b" , readAddress, instruction, rst);

memorymodule memmod(.instruction(instruction), .readAddress(readAddress), .clk(clk), .rst(rst));
initial
begin	
	clk = 0;
	rst = 0;
	readAddress = 16'b0000_0000_0000_0000;
end

always
	#5 clk = !clk;

initial
begin
	readAddress = 16'b0000_0000_0000_0000;

	#10
	rst = 1;
	readAddress = 16'b0000_0000_0000_0001;

	#10
	readAddress = 16'b0000_0000_0000_0010;
	
	#10
	readAddress = 16'b0000_0000_0000_0011;
end

initial
begin
#100 $finish;
end

endmodule
