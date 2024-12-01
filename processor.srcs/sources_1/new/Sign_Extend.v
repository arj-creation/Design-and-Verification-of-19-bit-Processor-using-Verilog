`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 11:31:49 AM
// Design Name: 
// Module Name: Sign_Extend
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


module Sign_Extend (In,Imm_Ext,ImmSrc);

    input [18:0]In;
    input ImmSrc;
    output [18:0]Imm_Ext;

    assign Imm_Ext = (ImmSrc == 1'b1) ? ({{12{In[18]}},In[18:15], In[11:9] }):
                                        {{12{In[18]}},In[18:12]};
                                
endmodule
