`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 11:31:49 AM
// Design Name: 
// Module Name: ALU
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


module ALU(A,B,Result,ALUControl,OverFlow,Carry,Zero,Negative);

    input [18:0]A,B;
    input [2:0]ALUControl;
    output Carry,OverFlow,Zero,Negative;
    output [18:0]Result;

    wire Cout;
    wire [18:0]Sum;

    assign {Cout,Sum} = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
    assign Result = (ALUControl == 3'b000) ? Sum ://ADD
                    (ALUControl == 3'b001) ? Sum ://SUB
                    (ALUControl == 3'b111) ? A * B ://MUL
                    (ALUControl == 3'b010) ? A / B ://DIV
                    (ALUControl == 3'b011) ? A & B ://AND
                    (ALUControl == 3'b100) ? A | B ://OR
                    (ALUControl == 3'b101) ?  A  ^ B://XOR
                    (ALUControl == 3'b110) ? ~A ://NOT
                                             {32{1'b0}};//ALU RESULT WILL ZERO 
    
    assign OverFlow = ((Sum[18] ^ A[18]) & 
                      (~(ALUControl[0] ^ B[18] ^ A[18])) &
                      (~ALUControl[1]));
    assign Carry = ((~ALUControl[1]) & Cout);
    assign Zero = (Result==19'd0) ? 1'b1: 1'b0;//assign Zero = &(~Result);
    assign Negative = Result[18];

endmodule
