`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:14 09/17/2021 
// Design Name: 
// Module Name:    counting 
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
`define S3 2'b11

module counting(
    input [1:0] num,
    input clk,
    output ans
    );

	reg[1:0] status;

	initial begin
		status <= `S0;
	end
	
	always @(posedge clk) begin
		case (status)
			`S0:
				if (num == 2'b01) status <= `S1;
				else status <= `S0;
			`S1:
				if (num == 2'b01) status <= `S1;
				else if (num == 2'b10) status <= `S2;
				else status <= `S0;
			`S2:
				if (num == 2'b01) status <= `S1;
				else if (num == 2'b10) status <= `S2;
				else if (num == 2'b11) status <= `S3;
				else status <= `S0;
			`S3:
				if (num == 2'b01) status <= `S1;
				else if (num == 2'b11) status <= `S3;
				else status <= `S0;
		endcase
	end
	
	assign ans = (status == `S3) ? 1'b1 : 1'b0;

endmodule

