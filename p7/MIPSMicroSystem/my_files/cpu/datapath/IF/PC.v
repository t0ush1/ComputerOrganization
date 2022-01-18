`timescale 1ns / 1ps

`include "../../macros.v"

module PC(
    input clk,
    input reset,
    input WE,
    input [31:0] nextPC,
    output reg [31:0] PC
    );

	always @(posedge clk)
		if (reset) PC <= `Instr_Base_Addr;
		else if (WE) PC <= nextPC;
		else;

endmodule
