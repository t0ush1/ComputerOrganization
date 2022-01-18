`timescale 1ns / 1ps

`include "../../macros.v"

module BE (
    input [31:0] WD_orig,
    input [1:0] byteSel,
    input [2:0] ctrl,
    output [3:0] byteEn,
    output [31:0] WD
);

    assign byteEn = (ctrl == `BE_none) ? 4'b0000 :
                    (ctrl == `BE_word) ? 4'b1111 :
                    (ctrl == `BE_hfwd) ? (
                        (byteSel[1] == 1'b0) ? 4'b0011 :
                        (byteSel[1] == 1'b1) ? 4'b1100 :
                        4'bx
                    ) :
                    (ctrl == `BE_byte) ? (
                        (byteSel == 2'b00) ? 4'b0001 :
                        (byteSel == 2'b01) ? 4'b0010 :
                        (byteSel == 2'b10) ? 4'b0100 :
                        (byteSel == 2'b11) ? 4'b1000 :
                        4'bx
                    ) :
                    4'bx;

    assign WD = (ctrl == `BE_word) ? WD_orig                    :
                (ctrl == `BE_hfwd) ? WD_orig << (16*byteSel[1]) :
                (ctrl == `BE_byte) ? WD_orig << (8*byteSel)     :
                32'bx;

endmodule