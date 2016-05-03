`include "ALUControl.v"

//Top level stimulus module
module stimulus;

//Declare variables for stimulating input
reg [3:0] funct;
reg ALUOp1, ALUOp0
wire ALUCtrl;

initial
	$vcdpluson;
initial
$monitor($time,"ALUOp1 = %b ALUOp0 = %b funct = %b, ALUCtrl = %b", ALUOp1, ALUOp0, funct, ALUCtrl);
ALUControl ALUCtrl(ALUOp1, ALUOp0, funct, ALUCtrl);
initial
begin
  ALUOp1 = 1'b0;
  ALUOp0 = 1'b0;
	funct = 4'b0000;
end
initial
begin
	ALUOp1 = 1'b0; // type A
  ALUOp0 = 1'b0;
	funct = 4'b1111; // add
	
	#10
	ALUOp1 = 1'b0; // type A
  ALUOp0 = 1'b0;
	funct = 4'b1110; // sub
	
	#10	
	ALUOp1 = 1'b0; // type A
  ALUOp0 = 1'b0;
	funct = 4'b1101; // and
	
	#10
	ALUOp1 = 1'b0; // type A
  ALUOp0 = 1'b0;
	funct = 4'b1100; // or
	
	#10
	ALUOp1 = 1'b0; // type A
  ALUOp0 = 1'b0;
	funct = 4'b0001; // mul
	
	#10
	ALUOp1 = 1'b0; // type A
  ALUOp0 = 1'b0;
	funct = 4'b0010; // div
	
	#10
	ALUOp1 = 1'b0; // type A
  ALUOp0 = 1'b0;
	funct = 4'b1010; // sll
	
	#10
	ALUOp1 = 1'b0; // type A
  ALUOp0 = 1'b0;
	funct = 4'b1011; // slr
	
	#10
	ALUOp1 = 1'b0; // type A
  ALUOp0 = 1'b0;
	funct = 4'b1000; // rol
	
	#10
	ALUOp1 = 1'b0; // type A
  ALUOp0 = 1'b0;
	funct = 4'b1001; // ror
	
	#10
	ALUOp1 = 1'b1; // type B
  ALUOp0 = 1'b0;
	funct = 4'bxxxx; // lw, sw
	
	#10
	ALUOp1 = 1'b0; // type C
  ALUOp0 = 1'b1;
	funct = 4'bxxxx; // blt, bgt, beq
	
end
initial
begin
#120 $finish;
end
endmodule
