`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/22/2024 04:02:25 PM
// Design Name: 
// Module Name: stack
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


module stack(Instr_in, read, write, clk, rst, en_stack, Inst_out);
  //port decleration
  input [18:0] Instr_in;
  input read;
  input write;
  input clk;
  input rst;
  input en_stack;
  output reg [18:0] Inst_out;
  
  reg [18:0] STACK [15:0];
  reg [3:0] SP;
  

  always @(negedge clk)
  begin
    if(~rst)
      begin
        SP <= 4'd15;
      end
    else
      begin
        if(en_stack)
          begin
            if(write)
              begin
                	
              		STACK[SP] <= Instr_in;
              		SP = SP - 1;             	
              end
            else if(read)
              begin
                	SP = SP + 1;
              		Inst_out <= STACK[SP];
              end
          end
      end
  end


endmodule
