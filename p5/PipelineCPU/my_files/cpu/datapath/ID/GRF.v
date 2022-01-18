`timescale 1ns / 1ps

module GRF(
    input clk,
    input reset,
    input WE,           //always 1
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,     //A3 != 0 <==> WE
    input [31:0] WD,
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
		else if (A3) begin
            regFile[A3] <= WD;
            $display("%d@%h: $%d <= %h", $time, PC, A3, WD);
        end
		else;
		
	assign RD1 = (A3 && A1 == A3) ? WD : regFile[A1];
	assign RD2 = (A3 && A2 == A3) ? WD : regFile[A2];
	
endmodule
