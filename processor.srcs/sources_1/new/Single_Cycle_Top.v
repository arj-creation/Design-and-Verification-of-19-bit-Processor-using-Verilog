`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 11:31:49 AM
// Design Name: 
// Module Name: Single_Cycle_Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`include "PC.v"
`include "Instruction_Memory.v"
`include "Register_File.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit_Top.v"
`include "Data_Memory.v"
`include "PC_Adder.v"
`include "Mux.v"
`include "stack.v"

module Single_Cycle_Top(clk,rst);

    input clk,rst;

    wire [18:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result, stk_out;
    wire RegWrite,MemWrite,ALUSrc,ResultSrc,jump_pc, Zero_flag, Branch,ret_read, call_write,en_stak, call_en, ret_en;
    wire [1:0]ImmSrc;
    wire [2:0]ALUControl_Top;

    PC_Module PC(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(PCPlus4)
    );

  Instruction_Memory Instruction_Memory1(
                            .rst(rst),
                            .A(PC_Top),
                            .RD(RD_Instr)
    );
    PC_Adder PC_Adder1(
                    .a(PC_Top),
                    .b(RD_Instr),
                    .c(PCPlus4),
                    .jump_pc(jump_pc),
                    .Zero_flag(Zero_flag),
                    .Branch(Branch),
                    .stk_ret_inst(stk_out),
                    .call_en(call_en),
                    .ret_en(ret_en)
    );
    
   
    stack STack1(.Instr_in(PC_Top + 19'd4),
                .read(ret_en),
                .write(call_en),
                .clk(clk),
                .rst(rst),
                .en_stack(en_stk),
                .Inst_out(stk_out)
                            );

  


    Register_File Register_File1(
                            .clk(clk),
                            .rst(rst),
                            .WE3(RegWrite),
                            .WD3(Result),
                            .A1(RD_Instr[8:6]),
                            .A2(RD_Instr[11:9]),
                            .A3(RD_Instr[14:12]),
                            .RD1(RD1_Top),
                            .RD2(RD2_Top)
    );

    Sign_Extend Sign_Extend1(
                        .In(RD_Instr),
                        .ImmSrc(ImmSrc[0]),
                        .Imm_Ext(Imm_Ext_Top)
    );

    Mux Mux_Register_to_ALU(
                            .a(RD2_Top),
                            .b(Imm_Ext_Top),
                            .s(ALUSrc),
                            .c(SrcB)
    );

    ALU ALU1(
            .A(RD1_Top),
            .B(SrcB),
            .Result(ALUResult),
            .ALUControl(ALUControl_Top),
            .OverFlow(),
            .Carry(),
            .Zero(Zero_flag),
            .Negative()
    );

    Control_Unit_Top Control_Unit_Top1(
                            .Op(RD_Instr[2:0]),
                            .RegWrite(RegWrite),
                            .ImmSrc(ImmSrc),
                            .ALUSrc(ALUSrc),
                            .MemWrite(MemWrite),
                            .ResultSrc(ResultSrc),
                            .Branch(Branch),
                            .funct3(RD_Instr[5:3]),
                            .funct7(RD_Instr[18:15]),
                            .jump(jump_pc),
                            .ALUControl(ALUControl_Top),
                            .call_en(call_en), 
                            .ret_en(ret_en),
                            .en_stack(en_stk)
    );

    Data_Memory Data_Memory1(
                        .clk(clk),
                        .rst(rst),
                        .WE(MemWrite),
                        .WD(RD2_Top),
                        .A(ALUResult),
                        .RD(ReadData)
    );

    Mux Mux_DataMemory_to_Register(
                            .a(ALUResult),
                            .b(ReadData),
                            .s(ResultSrc),
                            .c(Result)
    );

endmodule
