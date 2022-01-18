`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:05:46 10/24/2021 
// Design Name: 
// Module Name:    BlockChecker 
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

`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S5 4'b0101
`define S6 4'b0110
`define S7 4'b0111
`define S8 4'b1000
`define S9 4'b1001

module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output result
    );

	reg error = 0;
	reg signed [32:0] cnt = 0;
	reg [3:0] state = `S0;
	
	assign result = !error && cnt == 0;
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			error <= 0;
			cnt <= 0;
			state <= `S0;
		end
		else
			case (state)
				`S0: begin
					if (cnt < 0)
						error <= 1;
					if (in == "b" || in == "B")
						state <= `S1;
					else if (in == "e" || in == "E")
						state <= `S6;
					else if (in == " ")
						state <= `S0;
					else
						state <= `S9;
				end
				`S1:
					if (in == "e" || in == "E")
						state <= `S2;
					else if (in == " ")
						state <= `S0;
					else
						state <= `S9;
				`S2:
					if (in == "g" || in == "G")
						state <= `S3;
					else if (in == " ")
						state <= `S0;
					else
						state <= `S9;
				`S3:
					if (in == "i" || in == "I")
						state <= `S4;
					else if (in == " ")
						state <= `S0;
					else
						state <= `S9;
				`S4:
					if (in == "n" || in == "N") begin
						state <= `S5;
						cnt <= cnt + 1;
					end
					else if (in == " ")
						state <= `S0;
					else
						state <= `S9;
				`S5:
					if (in == " ")
						state <= `S0;
					else begin
						state <= `S9;
						cnt <= cnt - 1;
					end
				`S6:
					if (in == "n" || in == "N")
						state <= `S7;
					else if (in == " ")
						state <= `S0;
					else
						state <= `S9;
				`S7:
					if (in == "d" || in == "D") begin
						state <= `S8;
						cnt <= cnt - 1;
					end
					else if (in == " ")
						state <= `S0;
					else
						state <= `S9;
				`S8:
					if (in == " ")
						state <= `S0;
					else begin
						state <= `S9;
						cnt <= cnt + 1;
					end
				`S9:
					if (in == " ")
						state <= `S0;
					else
						state <= `S9;
			endcase
	end
	
endmodule
