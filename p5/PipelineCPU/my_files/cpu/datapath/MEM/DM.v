`timescale 1ns / 1ps

`include "../../macros.v"

module DM(
    input clk,
    input reset,
    input WE,
    input [31:0] A,
    input [2:0] ctrl,
    input [31:0] WD,
    input [31:0] PC,
    output [31:0] RD
    );

	localparam ADDRBITS = 12;
	localparam MEMSIZE = 32'b1 << ADDRBITS;

	reg [31:0] dataMem [0:MEMSIZE];

	wire [ADDRBITS-1:0] addr;
	wire [1:0] byteSel;
	assign addr = A[ADDRBITS+1:2];
	assign byteSel = A[1:0];
	
	integer i;
	always @(posedge clk)
		if (reset)
			for (i = 0; i < MEMSIZE; i = i + 1)
				dataMem[i] <= 0;
		else if (WE)
			case (ctrl)
				`DM_word: begin
					dataMem[addr] <= WD;
					$display("%d@%h: *%h <= %h", $time, PC, A, WD);
				end
				`DM_hfwd: begin
					dataMem[addr][15 + 16*byteSel[1] -: 16] <= WD[15:0];
					$display("%d@%h: *%h <= %h", $time, PC, A, { 16'b0, WD[15:0] });
				end
				`DM_byte: begin
					dataMem[addr][7 + 8*byteSel -: 8] <= WD[7:0];
					$display("%d@%h: *%h <= %h", $time, PC, A, { 24'b0, WD[7:0] });
				end
			endcase
		else;

	wire [31:0] out_word;
	wire [15:0] out_hfwd;
	wire [7:0]  out_byte;
	assign out_word = dataMem[addr];
	assign out_hfwd = out_word[15 + 16*byteSel[1] -: 16];
	assign out_byte = out_word[7 + 8*byteSel -: 8];
	assign RD = (ctrl == `DM_word)	? out_word :
				(ctrl == `DM_hfwd)	? { {16{out_hfwd[15]}}, out_hfwd } :
				(ctrl == `DM_byte)	? { {24{out_byte[7]}}, out_byte }  :
				(ctrl == `DM_ushw)	? { 16'b0, out_hfwd }	:
				(ctrl == `DM_usbt)	? { 24'b0, out_byte }	:
				32'b0;
	
endmodule
