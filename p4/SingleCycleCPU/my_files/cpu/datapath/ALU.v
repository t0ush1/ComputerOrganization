`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:27:47 11/13/2021 
// Design Name: 
// Module Name:    ALU 
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

`define ALU_and 	5'b00000
`define ALU_or		5'b00001
`define ALU_add 	5'b00010
`define ALU_sub 	5'b00011
`define ALU_xor 	5'b00100
`define ALU_srl		5'b00101
`define ALU_sll		5'b00110
`define ALU_sllv 	5'b00111
`define ALU_lt		5'b01000
`define ALU_gt		5'b01001
`define ALU_eq		5'b01010
`define ALU_ltu		5'b01011
`define ALU_gtu		5'b01100
`define ALU_ltz		5'b01101
`define ALU_gez		5'b01110
`define ALU_le		5'b01111
`define ALU_ge		5'b10000
`define ALU_ne		5'b10001
`define ALU_nor		5'b10010
`define ALU_srav	5'b10011
`define ALU_srlv	5'b10100
`define ALU_sra		5'b10101

module ALU(
    input [31:0] srcA,
    input [31:0] srcB,
    input [4:0] shamt,
    input [4:0] ctrl,
    output [31:0] out,
    output flag
    );
	
	assign flag = out[0];
	
	assign out = (ctrl == `ALU_and) 	? srcA & srcB 								:
				 (ctrl == `ALU_or)		? srcA | srcB 								:
				 (ctrl == `ALU_add)		? srcA + srcB 								:
				 (ctrl == `ALU_sub)		? srcA - srcB 								:
				 (ctrl == `ALU_xor)		? srcA ^ srcB 								:
				 (ctrl == `ALU_srl)		? srcB >> shamt								:
				 (ctrl == `ALU_sll)		? srcB << shamt								:
				 (ctrl == `ALU_sllv)	? srcB << srcA[4:0]							:
				 (ctrl == `ALU_lt)		? $signed($signed(srcA) < $signed(srcB)) 	:
				 (ctrl == `ALU_gt)		? $signed($signed(srcA) > $signed(srcB)) 	:
				 (ctrl == `ALU_eq)		? srcA == srcB								:
				 (ctrl == `ALU_ltu)		? srcA < srcB								:
				 (ctrl == `ALU_gtu)		? srcA > srcB								:
				 (ctrl == `ALU_ltz)		? { 31'b0, srcA[31] } 						:
				 (ctrl == `ALU_gez)		? { 31'b0, ~srcA[31] }						:
				 (ctrl == `ALU_le)		? $signed($signed(srcA) <= $signed(srcB))	:
				 (ctrl == `ALU_ge)		? $signed($signed(srcA) >= $signed(srcB))	:
				 (ctrl == `ALU_ne)		? srcA != srcB								:
				 (ctrl == `ALU_nor)		? ~(srcA | srcB)							:
				 (ctrl == `ALU_srav)	? $signed($signed(srcB) >>> srcA[4:0])		:
				 (ctrl == `ALU_srlv)	? srcB >> srcA[4:0]							:
				 (ctrl == `ALU_sra)		? $signed($signed(srcB) >>> shamt)			:
				 32'b0;

endmodule
