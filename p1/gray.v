`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:43 10/22/2021 
// Design Name: 
// Module Name:    gray 
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

`define S0 3'b000
`define S1 3'b001
`define S2 3'b011
`define S3 3'b010
`define S4 3'b110
`define S5 3'b111
`define S6 3'b101
`define S7 3'b100

module gray(
    input Clk,
    input Reset,
    input En,
    output reg [2:0] Output = `S0,
    output reg Overflow = 1'b0
    );
	
	always @(posedge Clk) begin
		if (Reset) begin
			Output <= `S0;
			Overflow <= 1'b0;
		end
		else if (En) begin
			case (Output)
				`S0: Output <= `S1;
				`S1: Output <= `S2;
				`S2: Output <= `S3;
				`S3: Output <= `S4;
				`S4: Output <= `S5;
				`S5: Output <= `S6;
				`S6: Output <= `S7;
				`S7:
					begin
						Output <= `S0;
						Overflow <= 1'b1;
					end
				default:;
			endcase
		end
	end
	
endmodule
