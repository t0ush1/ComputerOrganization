`timescale 1ns / 1ps

module IM(
    input [31:0] A,
    output [31:0] RD
    );

	localparam ADDRBITS = 12;
	localparam MEMSIZE = 32'b1 << ADDRBITS;

	reg [31:0] insMem [0:MEMSIZE-1];
	
	wire [31:0] ASub3000;
	wire [ADDRBITS-1:0] addr;
	assign ASub3000 = A - 32'h3000; 
	assign addr = ASub3000[ADDRBITS+1:2];

	initial
		$readmemh("code.txt", insMem);
	
	assign RD = insMem[addr];

endmodule
