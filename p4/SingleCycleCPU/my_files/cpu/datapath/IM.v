`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:45:27 11/13/2021 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [9:0] A,
    output [31:0] RD
    );

	reg [31:0] insMem [0:1023];
	
	initial
		$readmemh("code.txt", insMem);
	
	assign RD = insMem[A];

endmodule
