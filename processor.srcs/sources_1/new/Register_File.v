`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 11:31:49 AM
// Design Name: 
// Module Name: Register_File
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


module Register_File(clk,rst,WE3,WD3,A1,A2,A3,RD1,RD2);

    input clk,rst,WE3;
    input [2:0]A1,A2,A3;
    input [18:0]WD3;
    output [18:0]RD1,RD2;

    reg [18:0] Register [7:0];

    always @ (posedge clk)
    begin
        if(WE3)
            Register[A3] <= WD3;
    end

    assign RD1 = (~rst) ? 19'd0 : Register[A1];
    assign RD2 = (~rst) ? 19'd0 : Register[A2];

    initial begin
        
        Register[2] = 19'd5;
        Register[3] = 19'd4;
        Register[5] = 19'd40;
        
        
        
    end

endmodule
