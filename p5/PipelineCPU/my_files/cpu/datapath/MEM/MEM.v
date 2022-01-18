`timescale 1ns / 1ps

module MEM (
    input clk,
    input reset,

    input [31:0] ALUResult,
    input [31:0] regRD2_orig,
    input [31:0] PC,
    input [31:0] WBBack,
    
    input memWrite,
    input [2:0] DMCtrl,
    input regRD2Forward,

    output [31:0] memRD
);

    wire [31:0] regRD2;

    MUX2_1 #(.BITS(32)) regRD2MUX (
        .sel(regRD2Forward),
        .in0(regRD2_orig),
        .in1(WBBack),
        .out(regRD2)
    );

    DM dataMemory (
        .clk(clk),
        .reset(reset),
        .WE(memWrite),
        .A(ALUResult),
        .ctrl(DMCtrl),
        .WD(regRD2),
        .PC(PC),
        .RD(memRD)
    );

endmodule