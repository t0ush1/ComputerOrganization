`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:18:03 10/22/2021 
// Design Name: 
// Module Name:    string 
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

module string(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );
	
	reg[1:0] state = `S0;

	always @(posedge clk, posedge clr) begin
		if (clr) state <= `S0;
		else begin
			case (state)
				`S0:
					begin
						if (in >= "0" && in <= "9")
							state <= `S1;
						else
							state <= `S2;
					end
				`S1:
					begin
						if (in >= "0" && in <= "9")
							state <= `S2;
						else
							state <= `S0;
					end
				default;
			endcase
		end
	end

	assign out = state == `S1;

endmodule
