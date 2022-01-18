`timescale 1ns / 1ps

`include "../../macros.v"

module CMP (
    input [31:0] srcA,
    input [31:0] srcB,
    input [3:0] ctrl,
    output result
);
    
    assign result = (ctrl == `CMP_lt)  ? $signed($signed(srcA) < $signed(srcB))  :
                    (ctrl == `CMP_gt)  ? $signed($signed(srcA) > $signed(srcB))  :
                    (ctrl == `CMP_le)  ? $signed($signed(srcA) <= $signed(srcB)) :
                    (ctrl == `CMP_ge)  ? $signed($signed(srcA) >= $signed(srcB)) :
                    (ctrl == `CMP_eq)  ? srcA == srcB :
                    (ctrl == `CMP_ne)  ? srcA != srcB :
                    (ctrl == `CMP_ltz) ? srcA[31]     :
                    (ctrl == `CMP_gez) ? ~srcA[31]    :
                    1'bx;

endmodule