`timescale 1ns / 1ps

module PC(
    input clk,
    input reset,
    input WE,
    input [31:0] nextPC,
    output reg [31:0] PC
    );

	always @(posedge clk)
		if (reset) PC <= 32'h0000_3000;
		else if (WE) PC <= nextPC;
		else;

endmodule
