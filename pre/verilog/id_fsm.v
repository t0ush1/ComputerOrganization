`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:21:22 09/17/2021 
// Design Name: 
// Module Name:    id_fsm 
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

`define S0 2'b00
`define S1 2'b01
`define S2 2'b10

module id_fsm(
    input [7:0] char,
    input clk,
    output out
    );

	reg[2:0] state;
	
	initial begin
		state <= `S0;
	end
	
	always @(posedge clk) begin
		case (state)
			`S0: begin
					if ((char >= "a" && char <= "z") || (char >= "A" && char <= "Z"))
						state <= `S1;
					else
						state <= `S0;
				end
			`S1: begin
					if ((char >= "a" && char <= "z") || (char >= "A" && char <= "Z"))
						state <= `S1;
					else if (char >= "0" && char <= "9")
						state <= `S2;
					else
						state <= `S0;
				end
			`S2: begin
					if ((char >= "a" && char <= "z") || (char >= "A" && char <= "Z"))
						state <= `S1;
					else if (char >= "0" && char <= "9")
						state <= `S2;
					else
						state <= `S0;
				end
		endcase
	end
	
	assign out = (state == `S2) ? 1'b1 : 1'b0;
	
endmodule
