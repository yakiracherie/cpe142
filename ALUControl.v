`timescale 1ns / 1ns

module ALUControl(clk, rst, ALUOp1, ALUOp0, funct, ALUControl);

input clk, rst; 
input wire ALUOp1, ALUOp0;
input wire[3:0] funct;

output wire[3:0] ALUControl; 
reg [3:0] ALUCtrl= 4'b0000;
reg [1:0] ALUOp= 2'b00;

always @(posedge clk or negedge rst)
	if(!rst)
		begin
			ALUOp <= 2'b00;
	else
		begin
 			ALUOp[1:0] <= {ALUOp1, ALUOp0};  // put ALUOp into one 2 bit number
		end

always @(*)
begin
	case(ALUOp) // first 2 bits of opcode
		2'b10: ALUCtrl[3:0] = 4'b0011; // lw, sw
		2'b01: ALUCtrl[3:0] = 4'b0100; // blt, bgt, beq
		2'b00: // type A, jmp, halt but ignore jmp & halt because no funct
		begin
			case(funct)
				4'b1111: ALUCtrl[3:0] = 4'b1111; // add
				4'b1110: ALUCtrl[3:0] = 4'b1110; // sub
				4'b1101: ALUCtrl[3:0] = 4'b1101; // and
				4'b1100: ALUCtrl[3:0] = 4'b1100; // or
				4'b0001: ALUCtrl[3:0] = 4'b0001; // mul
		 		4'b0010: ALUCtrl[3:0] = 4'b0010; // div
				4'b1010: ALUCtrl[3:0] = 4'b1010; // sll	
				4'b1011: ALUCtrl[3:0] = 4'b1011; // slr
				4'b1000: ALUCtrl[3:0] = 4'b1000; // rol
				4'b1001: ALUCtrl[3:0] = 4'b1001; // ror
			endcase
		end	
	endcase
end
assign ALUControl = ALUCtrl;
endmodule
