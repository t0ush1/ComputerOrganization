`timescale 1ns / 1ps

module EX (
    input clk,
    input reset,

    input [4:0] shamt,
    input [31:0] regRD1_orig,
    input [31:0] regRD2_orig,
    input [31:0] imm32,
    input [31:0] MEMBack,
    input [31:0] WBBack,

    input ALUSrcASel,
    input ALUSrcBSel,
    input MDUResultSel,
    input start,
    input [3:0] ALUCtrl,
    input [3:0] MDUCtrl,
    input [1:0] regRD1Forward,
    input [1:0] regRD2Forward,

    output [31:0] ALUResult,
    output [31:0] MDUResult,
    output [31:0] regRD2,

    output busy
);
    
    wire [31:0] ALUSrcA;
    wire [31:0] ALUSrcB;
    wire [31:0] regRD1;
    wire [31:0] HI;
    wire [31:0] LO;

    MUX4_1 #(.BITS(32)) regRD1MUX (
        .sel(regRD1Forward),
        .in0(regRD1_orig),
        .in1(MEMBack),
        .in2(WBBack),
        .in3(32'b0),
        .out(regRD1)
    );

    MUX4_1 #(.BITS(32)) regRD2MUX (
        .sel(regRD2Forward),
        .in0(regRD2_orig),
        .in1(MEMBack),
        .in2(WBBack),
        .in3(32'b0),
        .out(regRD2)
    );

    MUX2_1 #(.BITS(32)) ALUSrcAMUX (
        .sel(ALUSrcASel),
        .in0(regRD1),
        .in1({27'b0, shamt}),
        .out(ALUSrcA)
    );

    MUX2_1 #(.BITS(32)) ALUSrcBMUX (
        .sel(ALUSrcBSel),
        .in0(regRD2),
        .in1(imm32),
        .out(ALUSrcB)
    );

    ALU arithmeticLogicalUnit (
        .srcA(ALUSrcA),
        .srcB(ALUSrcB),
        .ctrl(ALUCtrl),
        .result(ALUResult)
    );

    MDU multiplyDivideUnit (
        .clk(clk),
        .reset(reset),
        .srcA(regRD1),
        .srcB(regRD2),
        .start(start),
        .ctrl(MDUCtrl),
        .busy(busy),
        .HI(HI),
        .LO(LO)
    );

    MUX2_1 #(.BITS(32)) MDUResultMUX (
        .sel(MDUResultSel),
        .in0(HI),
        .in1(LO),
        .out(MDUResult)
    );

endmodule