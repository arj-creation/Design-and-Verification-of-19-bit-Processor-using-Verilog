`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 11:31:49 AM
// Design Name: 
// Module Name: ALU_Decoder
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


module ALU_Decoder(ALUOp,funct3,funct7,op,ALUControl);

    input [1:0]ALUOp;
    input [2:0]funct3;
    input [2:0]op;
    input [3:0] funct7;
    output [2:0]ALUControl;

    
    assign ALUControl = (ALUOp == 2'b00) ? 3'b000 ://by default addition
                        (ALUOp == 2'b01) ? 3'b001 ://branch operation BNE, BEQ
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & (funct7[0] == 1'b1)) ? 3'b001 : //SUB
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & (funct7[0] != 1'b1)) ? 3'b000 : //ADD
                        ((ALUOp == 2'b10) & (funct3 == 3'b001)) ? 3'b111 : //MUL
                        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b010 : //DIV
                        ((ALUOp == 2'b10) & (funct3 == 3'b011)) ? 3'b011 ://AND
                        ((ALUOp == 2'b10) & (funct3 == 3'b100)) ? 3'b100 ://OR
                        ((ALUOp == 2'b10) & (funct3 == 3'b101)) ? 3'b101 ://XOR
                        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b110 : //NOT
                        ((ALUOp == 2'b11) & (funct3 == 3'b000)) ? 3'b000 : //INC
                        ((ALUOp == 2'b11) & (funct3 == 3'b001)) ? 3'b001 : //DEC
                                                                  3'b000 ;//OTHERWISE ADDITION
endmodule