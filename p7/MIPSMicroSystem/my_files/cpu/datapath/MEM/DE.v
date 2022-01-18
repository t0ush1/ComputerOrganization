`timescale 1ns / 1ps

`include "../../macros.v"

module DE (
    input [31:0] RD_orig,
    input [1:0] byteSel,
    input [2:0] ctrl,
    output [31:0] RD
);

    wire [15:0] hfwd;
	wire [7:0]  byte;
    assign hfwd = RD_orig[15 + 16*byteSel[1] -: 16];
	assign byte = RD_orig[7 + 8*byteSel -: 8];

    assign RD = (ctrl == `DE_word) ? RD_orig                  :
                (ctrl == `DE_hfwd) ? { {16{hfwd[15]}}, hfwd } :
                (ctrl == `DE_byte) ? { {24{byte[7]}}, byte }  :
                (ctrl == `DE_ushw) ? { 16'b0, hfwd }	      :
                (ctrl == `DE_usbt) ? { 24'b0, byte }	      :
				32'bx;

endmodule