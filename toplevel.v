`timescale 1ns / 1ns

`include "ALUControl.v"
`include "ALUOp.v"
`include "BranchAND.v"
`include "EXMEM.v"
`include "HazardDetection.v"
`include "IDEX.v"
`include "IFID.v"
`include "MEMWB.v"
`include "MUX16bit.v"
`include "MUX4bit.v"
`include "PC.v"
`include "PCAdder.v"
`include "ShiftLeft1.v"
`include "SignExtend4.v"
`include "SignExtend8.v"
`include "control.v"
`include "memorymodule.v"
`include "registerFile.v"

module toplevel(clk, rst);

input wire clk, rst;

// PC.v
wire PCout[15:0];

// memorymodule.v
wire instruction[15:0];

// ALUControl.v
wire ALUControl [3:0];

// ALUOp.v
wire O, N, Z;
wire [7:0] Result;

// BranchAND.v
wire branchZero;

// EXMEM.v
wire [1:0] WBOut;
wire [2:0] MOut;
wire zeroOut;
wire [15:0] ALU_resultOut, writeDataOut;
wire [3:0] regRdOut; 

// HazardDetection.v
wire PCWrite, IFIDWrite, mux;

// IDEX.v
wire [2:0] MOut;
wire [3:0] EXOut;
wire [15:0] pc_Add2Out, dataAOut, dataBOut, immedOut;  
wire [3:0] regRsOut, regRtOut, regRdOut; 

// IFID.v
wire [15:0] instr_Out, pc_Add4Out;

// MEMWB.v
wire [1:0] WBOut; 
wire [15:0] readDataOut, ALU_resultOut; 
wire [3:0] regRdOut; 

// MUX16bit.v
wire [15:0] outMux16;

// MUX4bit.v
wire [3:0] outMux4;

// PCAdder.v
wire [15:0] PCAddout;

// ShiftLeft1.v
wire [15:0] outSL;

// SignExtend4.v
wire [15:0] out SE4;

// SignExtend8.v
wire [15:0] out SE8;

// control.v
wire Branch, Jump, RegDst, MemtoReg, MemRead, ALUOp1, ALUOp0, MemWrite, ALUSrc, RegWrite;

// registerFile.v
wire [15:0] readData1, readData2;

PC pc(.clk(clk), .rst(rst), .PCin(), .PCout(PCout));
memorymodule memorymodule(.clk(clk), .rst(rst), .readAddress(PCOut), .instruction(instruction));
ALUControl ALUControl(.clk(clk), .rst(rst), .ALUOp1(), .ALUOp0(), .funct(), .ALUControl(ALUControl));
ALUOp ALUOp(.A(), .B(), .Crtl(), .R(Result), .O(O), .N(N), .Z(Z));
BranchAND BranchAND(.in1(Z), .in2(Branch), .out(branchZero));
EXMEM EXMEM(.clk(clk), .WB(), .M(), .zero(), .ALU_result(), .writeData(), .regRd(), .MOut(MOut), .WBOut(WBOut), 
            .zeroOut(zeroOut), .ALU_resultOut(ALU_resultOut), .writeDataOut(writeDataOut), .regRdOut(regRdOut));
HazardDetection HazardDetection(.IFIDRegRs(), .IFIDRegRt(), .IDEXRegRt(), .IDEXMemRead(), .PCWrite(PCWrite), .IFIDWrite(IFIDWrite), .mux(mux));
IDEX IDEX(.clk(clk), .pc_Add2In(), .WB(), .M(), .EX(), .dataA(), .dataB(), .immed(), .regRs(), 
          .regRt(), .regRd(), .pc_Add2Out(pc_Add2Out), .WBOut(WBOut), .MOut(MOut), .ExOut(ExOut), 
          .dataAOut(dataAOut), .dataBOut(dataBOut), .immedOut(immedOut), .regRsOut(regRSOut), .regRtOut(regRtOut), .regRdOut(regRdOut));
IFID IFID(.flush(), .clk(clk), .IFIDWrite(), .pc_Add2In(), .pc_Add2Out(pc_Add2Out), .instr_In(), .instr_Out(instr_Out));
MEMWB MEMWB(.clk(clk), .WB(), .readData(), .ALU_result(), .regRd(), .WBOut(WBOut), .readDataOut(readDataOut), .ALU_resultOut(ALU_resultOut), .regRdOut(regRdOut));
MUX16bit MUX16bit_a(.in0(), .in1(), .select(branchZero), .out(outMux16_a));
MUX16bit MUX16bit_b(.in0(), .in1(), .select(Jump), .out(outMux16_b));
MUX16bit MUX4bit_a(.in0(), .in1(), .select(RegDst), .out(outMux4_a));
MUX16bit MUX4bit_b(.in0(), .in1(), .select(ALUSrc), .out(outMux4_b));
MUX4bit MUX4bit_c(.in0(), .in1(), .select(MemtoReg), .out(outMux4_c));
PCAdder PCAdder.PCin(), .i(2), .PCout(PCAddout));
ShiftLeft1 ShiftLeft1_a(.in(), .out(outSL_a));
ShiftLeft1 ShiftLeft1_b(.in(), .out(outSL_b));
SignExtend4 SignExtend4_a(.in(), .out(outSE4_a));
SignExtend4 SignExtend4_b(.in(), .out(outSE4_b));
SignExtend8 SignExtend8(.in(), .out(outSE8));
control control(.opcode(), .Branch(Branch), .Jump(Jump), .RegDst(RegDst), .MemtoReg(MemtoReg), .MemRead(MemRead), .ALUOp1(ALUOp1), .ALUOp0(ALUOp0), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));
registerFile registerFile(clk(clk), rst(rst), readReg1(), readReg2(), writeReg(), readData1(readData1), readData2(readData2), writeData(), .RegWrite());

endmodule
