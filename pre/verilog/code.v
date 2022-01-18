`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:59 09/17/2021 
// Design Name: 
// Module Name:    code 
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
module code(
    input Clk,
    input Reset,
    input Slt,
    input En,
    output reg [63:0] Output0,
    output reg [63:0] Output1
    );

	reg[2:0] cycles;
	
	initial begin
		Output0 = 64'b00;
		Output1 = 64'b00;
		cycles = 2'b00;
	end
	
	always @(posedge Clk) begin
		if (Reset == 1'b1) begin
			cycles <= 2'b00;
			Output0 <= 64'b00;
			Output1 <= 64'b00;
		end
		else if (En == 1'b0);
		else if (Slt == 1'b0)
			Output0 <= Output0 + 1;
		else if (cycles == 2'b11) begin
			Output1 <= Output1 + 1;
			cycles <= 2'b00;
		end
		else
			cycles <= cycles + 1;
	end
	
endmodule
