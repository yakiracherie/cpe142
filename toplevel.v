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
wire [15:0] outMux16_a;
wire [15:0] outMux16_b;

// MUX4bit.v
wire [3:0] outMux4_a;
wire [3:0] outMux4_b;
wire [3:0] outMux4_c;

// PCAdder.v
wire [15:0] PCAddout;

// ShiftLeft1.v
wire [15:0] outSL_a;
wire [15:0] outSL_b;

// SignExtend4.v
wire [15:0] out SE4_a;
wire [15:0] out SE4_b;

// SignExtend8.v
wire [15:0] outSE8;

// control.v
wire Branch, Jump, RegDst, MemtoReg, MemRead, ALUOp1, ALUOp0, MemWrite, ALUSrc, RegWrite;

// registerFile.v
wire [15:0] readData1, readData2;

PC pc(.clk(clk), .rst(rst), .PCin(PCWrite), .PCout(PCout));
memorymodule memorymodule(.clk(clk), .rst(rst), .readAddress(PCOut), .instruction(instruction));
ALUControl ALUControl(.clk(clk), .rst(rst), .ALUOp1(ALUOp1), .ALUOp0(ALUOp2), .funct(instr_Out[3:0]), .ALUControl(ALUControl));
ALUOp ALUOp(.A(ReadData1), .B(outMux4_b), .Crtl(ALUControl), .R(Result), .O(O), .N(N), .Z(Z));
BranchAND BranchAND(.in1(Z), .in2(Branch), .out(branchZero));
EXMEM EXMEM(.clk(clk), .WB(), .M(), .zero(), .ALU_result(), .writeData(), .regRd(), .MOut(MOut), .WBOut(WBOut), 
            .zeroOut(zeroOut), .ALU_resultOut(ALU_resultOut), .writeDataOut(writeDataOut), .regRdOut(regRdOut));
HazardDetection HazardDetection(.IFIDRegRs(), .IFIDRegRt(), .IDEXRegRt(), .IDEXMemRead(), .PCWrite(PCWrite), .IFIDWrite(IFIDWrite), .mux(mux));
IDEX IDEX(.clk(clk), .pc_Add2In(), .WB(), .M(), .EX(), .dataA(), .dataB(), .immed(), .regRs(), 
          .regRt(), .regRd(), .pc_Add2Out(pc_Add2Out), .WBOut(WBOut), .MOut(MOut), .ExOut(ExOut), 
          .dataAOut(dataAOut), .dataBOut(dataBOut), .immedOut(immedOut), .regRsOut(regRSOut), .regRtOut(regRtOut), .regRdOut(regRdOut));
IFID IFID(.flush(), .clk(clk), .IFIDWrite(), .pc_Add2In(), .pc_Add2Out(pc_Add2Out), .instr_In(instruction), .instr_Out(instr_Out));
MEMWB MEMWB(.clk(clk), .WB(), .readData(), .ALU_result(), .regRd(), .WBOut(WBOut), .readDataOut(readDataOut), .ALU_resultOut(ALU_resultOut), .regRdOut(regRdOut));
MUX16bit MUX16bit_a(.in0(), .in1(PCAddout), .select(branchZero), .out(outMux16_a));
MUX16bit MUX16bit_b(.in0(outMux16_a), .in1(outSL_b), .select(Jump), .out(outMux16_b));
MUX4bit MUX4bit_a(.in0(instr_Out[7:4]), .in1(instr_Out[11:8]), .select(RegDst), .out(outMux4_a));
MUX4bit MUX4bit_b(.in0(ReadData2), .in1(outSE8), .select(ALUSrc), .out(outMux4_b));
MUX4bit MUX4bit_c(.in0(Result), .in1(ReadData), .select(MemtoReg), .out(outMux4_c));
PCAdder PCAdder(.PCin(PCout), .i(2), .PCout(PCAddout));
ShiftLeft1 ShiftLeft1_a(.in(outSE4_a), .out(outSL_a));
ShiftLeft1 ShiftLeft1_b(.in(outSE4_b), .out(outSL_b));
SignExtend4 SignExtend4_a(.in(instr_Out[7:4]), .out(outSE4_a));
SignExtend4 SignExtend4_b(.in(instr_Out[11:8]), .out(outSE4_b));
SignExtend8 SignExtend8(.in(instr_Out[7:0]), .out(outSE8));
control control(.opcode(instr_Out[15:12]), .Branch(Branch), .Jump(Jump), .RegDst(RegDst), .MemtoReg(MemtoReg), .MemRead(MemRead), .ALUOp1(ALUOp1), .ALUOp0(ALUOp0), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));
registerFile registerFile(clk(clk), rst(rst), readReg1(instr_Out[11:8]), readReg2(instr_Out[7:4]), writeReg(outMux4_a), readData1(readData1), readData2(readData2), writeData(), .RegWrite());

endmodule
