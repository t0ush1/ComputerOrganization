`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:01:43 11/13/2021 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input WE,
    input clk,
    input reset,
    input [31:0] PC,
    output [31:0] RD1,
    output [31:0] RD2
    );

	reg [31:0] regFile [0:31];
	
	integer i;
	always @(posedge clk)
		if (reset)
			for (i = 0; i < 32; i = i + 1)
				regFile[i] <= 0;
		else if (WE && A3 != 5'b0) begin
            regFile[A3] <= WD;
            $display("@%h: $%d <= %h", PC, A3, WD);
        end
		else;
		
	assign RD1 = regFile[A1];
	assign RD2 = regFile[A2];
	
endmodule
