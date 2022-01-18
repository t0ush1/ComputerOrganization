`timescale 1ns / 1ps

`include "../../macros.v"

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
