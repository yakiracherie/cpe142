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
wire [15:0] PCOut;

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

PC pc(.clk(clk), .rst(rst), .PCin(PCin), .PCout());
memorymodule memorymodule(clk, rst, readAddress, instruction);
ALUControl ALUControl(.clk(clk), .rst(rst), .ALUOp1(), .ALUOp0(), .funct, ALUControl);
ALUOp ALUOp(A, B, Crtl, R, O, N, Z);
BranchAND BranchAND(in1, in2, out);
EXMEM EXMEM(clk, WB, M, zero, ALU_result, writeData, regRd, MOut, WBOut, zeroOut, ALU_resultOut, writeDataOut, regRdOut);
HazardDetection HazardDetection(IFIDRegRs, IFIDRegRt, IDEXRegRt, IDEXMemRead, PCWrite, IFIDWrite, mux);
IDEX IDEX(clk, pc_Add2In, WB, M, EX, dataA, dataB, immed, regRs, regRt, regRd, pc_Add2Out, WBOut, MOut, ExOut, dataAOut, dataBOut, immedOut, regRsOut, regRtOut, regRdOut);
IFID IFID(flush, clk, IFIDWrite, pc_Add2In, pc_Add2Out, instr_In, instr_Out);
MEMWB MEMWB(clk, WB, readData, ALU_result, regRd, WBOut, readDataOut, ALU_resultOut, regRdOut);
MUX16bit MUX16bit(in0, in1, select, out);
MUX4bit MUX4bit(in0, in1, select, out);
PCAdder PCAdder(PCin, i, PCout);
ShiftLeft1 ShiftLeft1(in, out);
SignExtend4 SignExtend4(in, out);
SignExtend8 SignExtend8(in, out);
control control(opcode, Branch, Jump, RegDst, MemtoReg, MemRead, ALUOp1, ALUOp0, MemWrite, ALUSrc, RegWrite);
registerFile registerFile(clk, rst, readReg1, readReg2, writeReg, readData1, readData2, writeData, RegWrite);

endmodule
