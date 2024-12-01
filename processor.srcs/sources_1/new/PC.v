`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 11:31:49 AM
// Design Name: 
// Module Name: PC_Module
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


module PC_Module(clk,rst,PC,PC_Next);
    input clk,rst;
    input [18:0]PC_Next;
    output [18:0]PC;
    reg [18:0]PC;

    always @(posedge clk)
    begin
        if(~rst)
            PC <= {19{1'b0}};
        else
            PC <= PC_Next;
    end
    
    
endmodule