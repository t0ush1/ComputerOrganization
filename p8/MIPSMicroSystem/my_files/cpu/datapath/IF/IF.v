`timescale 1ns / 1ps

module IF (
    input clk,
    input reset,
    input PCWrite,
    input [31:0] nextPC,
    output [31:0] PC
);

    PC programCounter (
        .clk(clk),
        .reset(reset),
        .WE(PCWrite),
        .nextPC(nextPC),
        .PC(PC)
    );

endmodule