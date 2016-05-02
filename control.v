module control(opcode, funct, Branch, Jump, RegDst, MemtoReg, MemRead, ALUOp1, ALUOp0, MemWrite, ALUSrc, RegWrite);

input [3:0] opcode, funct;

output reg Branch, Jump, RegDst, MemtoReg, MemRead, ALUOp1, ALUOp0, MemWrite, ALUSrc, RegWrite;

always @(*) 
begin
	case (opcode)
		4'b0000: // type A
		begin
			Branch = 1'b0;
			Jump = 1'b0;
 			RegDst = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			ALUOp1 = 1'b0;
			ALUOp0 = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
		endcase	
		end
		4'b1000: // lw
		begin
 			Branch = 1'b0;
			Jump = 1'b0;
 			RegDst = 1'b0;
			MemRead = 1'b1;
			MemtoReg = 1'b1;
			ALUOp1 = 1'b1;
			ALUOp0 = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			RegWrite = 1'b1;
		end
		4'b1011: // sw
 		begin
 			Branch = 1'b0;
			Jump = 1'b0;
 			RegDst = 1'bx;
			MemRead = 1'b0;
			MemtoReg = 1'bx;
			ALUOp1 = 1'b1;
			ALUOp0 = 1'b0;
			MemWrite = 1'b1;
			ALUSrc = 1'b1;
			RegWrite = 1'b0;
		end
		4'b0100: // blt
		begin
 			Branch = 1'b1;
			Jump = 1'b0;
 			RegDst = 1'bx;
			MemRead = 1'b0;
			MemtoReg = 1'bx;
			ALUOp1 = 1'b0;
			ALUOp0 = 1'b1;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;
			RegWrite = 1'b0;
		end
		4'b0101: // bgt
		begin
 			Branch = 1'b1;
			Jump = 1'b0;
 			RegDst = 1'bx;
			MemRead = 1'b0;
			MemtoReg = 1'bx;
			ALUOp1 = 1'b0;
			ALUOp0 = 1'b1;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;
			RegWrite = 1'b0;
		end
		4'b0110: // beq
		begin
 			Branch = 1'b1;
			Jump = 1'b0;
 			RegDst = 1'bx;
			MemRead = 1'b0;
			MemtoReg = 1'bx;
			ALUOp1 = 1'b0;
			ALUOp0 = 1'b1;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;
			RegWrite = 1'b0;
		end
		4'b1100: // jmp
		begin
 			Branch = 1'b0;
			Jump = 1'b1;
 			RegDst = 1'bx;
			MemRead = 1'b0;
			MemtoReg = 1'bx;
			ALUOp1 = 1'b0;
			ALUOp0 = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;
			RegWrite = 1'b0;
		end
		4'b1111: // Halt
		begin
 			Branch = 1'b0;
			Jump = 1'b0;
 			RegDst = 1'bx;
			MemRead = 1'b0;
			MemtoReg = 1'bx;
			ALUOp1 = 1'b0;
			ALUOp0 = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;
			RegWrite = 1'b0;
		end
		default: 
		begin
 			Branch = 1'b0;
			Jump = 1'b0;
 			RegDst = 1'b0;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			ALUOp1 = 1'b0;
			ALUOp0 = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;
			RegWrite = 1'b0;
		end
	endcase
end
endmodule
