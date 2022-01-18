`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:45 11/13/2021 
// Design Name: 
// Module Name:    NPC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`define NPC_add4 	3'b000
`define NPC_offset 	3'b001
`define NPC_index 	3'b010
`define NPC_reg		3'b011

module NPC(
    input [31:0] PC,
    input [31:0] offset,
    input [25:0] index,
    input [31:0] register,
    input [2:0] ctrl,
    output [31:0] PCAdd4,
    output [31:0] nextPC
    );

	assign PCAdd4 = PC + 4;
	
	assign nextPC = (ctrl == `NPC_add4)		? PCAdd4						:
					(ctrl == `NPC_offset)	? offset + PCAdd4				:
					(ctrl == `NPC_index)	? { PC[31:28], index, 2'b0 }	:
					(ctrl == `NPC_reg)		? register						:
					32'b0;
	
endmodule
