`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 11:31:49 AM
// Design Name: 
// Module Name: PC_Adder
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

//`include "ALU.v"
//`include "Control_Unit_Top.v"
module PC_Adder (a,b,c,jump_pc, Zero_flag, Branch, call_en, ret_en, stk_ret_inst);

    input [18:0]a,b, stk_ret_inst;
    output [18:0]c;
    
    input jump_pc, Zero_flag, Branch,call_en, ret_en;
    wire [18:0] PCPlus4;
    wire [18:0] pc_b, pc_j;
    wire beq, bne, beq_control, bne_control;
    //assign c = a + b;
    assign PCPlus4 = a + 19'd4;
   
    /*Control_Unit_Top Control_Unit_Top(
                            .Op(),
                            .RegWrite(),
                            .ImmSrc(),
                            .ALUSrc(),
                            .MemWrite(),
                            .ResultSrc(),
                            .Branch(Branch),
                            .funct3(),
                            .funct7(),
                            .jump(jump_pc),
                            .ALUControl()
    );
ALU ALU(
            .A(),
            .B(),
            .Result(),
            .ALUControl(),
            .OverFlow(),
            .Carry(),
            .Zero(Zero_flag),
            .Negative()
    );*/
    
    
    
   // assign  call_add = { {3{b[18]}},b[18:3]}; 
    
    assign pc_b ={ {12{b[18]}}, b[18:12]};
    assign pc_j ={ {3{b[18]}},b[18:3]};   
    
    
    
    assign beq = ((b[5:3] == 3'b000) & (Branch == 1)) ? 1'b1 :1'b0;
    assign bne = ((b[5:3] == 3'b001) & (Branch == 1)) ? 1'b1 :1'b0;
    
    assign beq_control = beq & Zero_flag;
    assign bne_control = bne & ~Zero_flag;
    
    assign c =((jump_pc == 1'b1) | (call_en == 1'b1))? pc_j:
                (ret_en == 1'b1) ? stk_ret_inst:
                        ((beq_control == 1'b1) | (bne_control == 1'b1)) ? pc_b : PCPlus4;
                        
    /*(jump_pc == 1'b1) ? pc_j:
                        ((beq_control == 1'b1) | (bne_control == 1'b1)) ? pc_b:
    */
endmodule