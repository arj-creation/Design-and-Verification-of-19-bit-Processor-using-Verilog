`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 11:31:49 AM
// Design Name: 
// Module Name: Main_Decoder
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


module Main_Decoder(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp,jump, call_en, ret_en,en_stack);
    input [2:0]Op;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,jump,call_en, ret_en,en_stack;
    output [1:0]ImmSrc,ALUOp;

    assign RegWrite = (Op == 3'b000 | Op == 3'b010) ? 1'b1 :
                                                              1'b0 ;
    assign ImmSrc = (Op == 3'b000 | Op == 3'b011) ? 2'b01 : 
                    (Op == 3'b100) ? 2'b10 :    
                                         2'b00 ;
    assign ALUSrc = (Op == 3'b000 | Op == 3'b001 | Op == 3'b011) ? 1'b1 :
                                                                                1'b0 ;
    assign MemWrite = (Op == 3'b001) ? 1'b1 :
                                           1'b0 ;
    assign ResultSrc = (Op == 3'b000) ? 1'b1 :
                                            1'b0 ;
    assign Branch = (Op == 3'b100) ? 1'b1 :
                                         1'b0 ;
                                         
    assign jump = (Op == 3'b101) ? 1'b1 :
                                         1'b0 ;
    assign ALUOp = (Op == 3'b010) ? 2'b10 :
                   (Op == 3'b100) ? 2'b01 :
                   (Op == 3'b011) ? 2'b11 :
                                        2'b00 ;
      
      assign call_en = (Op == 3'b110) ? 1'b1 : 1'b0;
      assign ret_en = (Op == 3'b111) ? 1'b1 : 1'b0;
      assign en_stack = ((Op == 3'b111) | (Op == 3'b110)) ? 1'b1 : 1'b0;                                   

endmodule
