`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 11:31:49 AM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(rst,A,RD);

  input rst;
  input [18:0]A;
  output [18:0]RD;

  reg [18:0] mem [1023:0];
  
  assign RD = (~rst) ? {19{1'b0}} : mem[A[18:2]];


/*
About instruction

---------LOAD instruction---------------------------------
data transfer from data memory to register

instruction[2:0] opcode = 000, 3 bit
instruction[5:3] funct3, 3 bit , here not use
instruction[8:6] Rs1 or Source Register, 3 bit,  base address of data memory store in this register
instruction[11:9] Immadiate Value
instruction[14:12] Rd or Destination Register , 3 bit,  invalue will load to this register
instruction[18:15] Imm value, total 7 bit , use for address of data memory

final address = immediate value + base address(Rs1)
data store at datamemory[final adress] to resigster Rd

--------------------------------------------------------------

---------STORE instruction---------------------------------
data transfer from data register to memory

instruction[2:0] opcode = 001, 3 bit
instruction[5:3] funct3, 3 bit , here not use
instruction[8:6] Rs1 or Source Register, 3 bit,  base address of data memory store in this register
instruction[11:9] Rs2 or another source register , 3 bit, data store at this register will go to memory


instruction[18:12] immediate value, 7 bit, use for address of data memory

final address = immediate value + base address(Rs1)
data in register Rs2 will go to datamemory[final address]

--------------------------------------------------------------

---------R Type instruction---------------------------------
ALU Operation performe

instruction[2:0] opcode = 010, 3 bit
instruction[5:3] funct3, 3 bit , use for different-2 ALU operation
instruction[8:6] Rs1 or Source Register, 3 bit,  in this First data is store
instruction[11:9] Rs2 or another source register , 3 bit, in this Second data is store
instruction[14:12] Rd or Destination Register , 3 bit,  in this register final alu result will store
instruction[18:15] funct7, 4 bit, it use for difference between ADD(func7 = 0) and SUB(func7 = 1)

--------------------------------------------------------------

---------INC DEC instruction---------------------------------
data transfer from data memory to register

instruction[2:0] opcode = 011, 3 bit
instruction[5:3] funct3, 3 bit , if 000 INC and 001 DEC
instruction[8:6] Rs1 or Source Register, 3 bit,  value of this register will increase or decrease
instruction[11:9] Imm value
instruction[14:12] Rd or Destination Register , 3 bit,  in this register final alu result will store
instruction[18:15] Imm value, total 7 bit , by how much value change

--------------------------------------------------------------

---------BRANCH instruction---------------------------------
Compare data if true jump to Given address

instruction[2:0] opcode = 100, 3 bit
instruction[5:3] funct3, 3 bit , use if 000 for BEQ,if 001 for BNE 
instruction[8:6] Rs1 or Source Register, 3 bit,  in this First data is store
instruction[11:9] Rs2 or another source register , in this Second data is store
instruction[18:12] immediate value, 7 bit, at this adsress PC will jump, next instruction here

--------------------------------------------------------------

---------JUMP instruction---------------------------------
 jump to Given address

instruction[2:0] opcode = 101, 3 bit
instruction[18:3] immediate value, 16 bit, at this adsress PC will jump, next instruction here

--------------------------------------------------------------

---------CALL instruction---------------------------------
 jump to Given address where subroutine is store

instruction[2:0] opcode = 110, 3 bit
instruction[18:3] immediate value, 16 bit, at this adsress PC will jump, subroutine store from here

--------------------------------------------------------------

---------RET instruction---------------------------------
 coming out to subroutine and go to home instruction

instruction[2:0] opcode = 111, 3 bit
instruction[18:3] immediate value, here not use

--------------------------------------------------------------





*/

  initial begin
   
    //$readmemh("mem.hex",mem);
    //$readmemd("mem.data",mem);
    //mem[0] = 19'b0000_100_011_010_000_010; //ADD
   // mem[0] = 19'b0001_100_011_010_000_010; //SUB
   //mem[0] = 19'b0000_100_011_010_101_010; //xor
   //mem[0] = 19'b0001_110_001_101_000_000;// load
   //mem[0] = 19'b0001_001_011_101_000_001;// store
   //mem[0] = 19'b0000_000_000_001_000_101;//jump
   
   //mem[0] = 19'b0001_100_011_010_000_100;// beq branch if equal
  // mem[0] = 19'b0001_100_011_010_001_100;// bne branch if not equal
   
   //mem[1] = 19'b0001_001_011_101_000_001;// store
  // mem[2] = 19'b0001_001_011_101_000_001;// store
  // mem[0] = 19'b0000_100_011_010_000_010;// ADD
  
   
  mem[0] = 19'b0000_000_000_001_100_110;//call
    mem[1] = 19'b0001_100_011_010_000_010;// SUB
    
    
     mem[3] = 19'b0000_100_011_010_000_010;// ADD
     mem[4] = 19'b0000_100_011_010_000_111;// RET
  
   
    
  end

endmodule
