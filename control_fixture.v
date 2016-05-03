`include "control.v"

//Top level stimulus module
module stimulus;

//Declare variables for stimulating input
reg [3:0]opcode;
wire Branch, Jump, RegDst, MemtoReg, MemRead, ALUOp1, ALUOp0, MemWrite, ALUSrc, RegWrite;

initial
	$vcdpluson;
initial
$monitor($time,"opcode = %b Branch = %b Jump = %b, RegDst = %b, MemtoReg = %b, MemRead = %b ALUOp1 = %b, ALUOp0 = %b, MemWrite = %b, ALUSrc = %b RegWrite = %b, opcode, Branch, Jump, RegDst, MemtoReg, MemRead, ALUOp1, ALUOp0, MemWrite, ALUSrc, RegWrite
control ctrl(opcode, Branch, Jump, RegDst, MemtoReg, MemRead, ALUOp1, ALUOp0, MemWrite, ALUSrc, RegWrite);

initial
begin
	opcode = 4'b0000;
end

initial
begin
	opcode = 4'b0000; // type A

	#10
	opcode = 4'b1000; // lw
	
	#10	
	opcode = 4'b1011; // sw

	#10
	opcode = 4'b0100; // blt 

	#10
	opcode = 4'b0101; // bgt

	#10
	opcode = 4'b0110; // beq

	#10
	opcode = 4'b1100; // jmp

	#10
	opcode = 4'b1111; // Halt

end

initial
begin
#80 $finish;
end


endmodule
