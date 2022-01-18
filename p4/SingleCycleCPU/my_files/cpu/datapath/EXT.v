`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:25:30 11/13/2021 
// Design Name: 
// Module Name:    EXT 
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

`define EXT_zero		3'b000
`define EXT_sign		3'b001
`define EXT_loadUpper	3'b010
`define EXT_brOffset	3'b011

module EXT(
    input [15:0] imm16,
    input [2:0] ctrl,
    output [31:0] imm32
    );

	assign imm32 = (ctrl == `EXT_zero)		? { 16'b0, imm16 }					:
				   (ctrl == `EXT_sign)		? { {16{imm16[15]}}, imm16 }		:
				   (ctrl == `EXT_loadUpper)	? { imm16, 16'b0 }					:
				   (ctrl == `EXT_brOffset)	? { {14{imm16[15]}}, imm16, 2'b0 } 	:
				   32'b0;

endmodule
