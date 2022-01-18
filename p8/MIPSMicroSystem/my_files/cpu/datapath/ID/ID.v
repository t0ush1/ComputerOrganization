`timescale 1ns / 1ps

module ID (
    input clk,
    input reset,

    input [31:0] PC_F,
    input [31:0] PC_D,
    input [31:0] instr,
    input [4:0] regAddr,
    input [31:0] EXBack,
    input [31:0] MEMBack,
    input [31:0] WBBack,
	
    input [1:0] regAddrSel,
    input [3:0] CMPCtrl,
    input [2:0] EXTCtrl,
    input [2:0] NPCCtrl,
    input [1:0] regRD1Forward,
    input [1:0] regRD2Forward,

    output [4:0] shamt,
    output [4:0] regA1,
    output [4:0] regA2,
    output [4:0] regA3,
    output [31:0] regRD1,
    output [31:0] regRD2,
    output [31:0] imm32,
    output CMPResult,
    output [31:0] PCAdd8,
    output [31:0] nextPC,
    output [4:0] rd
);
    
    wire [4:0] rs;
    wire [4:0] rt;
    wire [15:0] imm16;
    wire [25:0] index;
    wire [31:0] regRD1_orig;
    wire [31:0] regRD2_orig;

    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign shamt = instr[10:6];
    assign imm16 = instr[15:0];
    assign index = instr[25:0];
    assign regA1 = rs;
    assign regA2 = rt;

    MUX4_1 #(.BITS(5)) regAddrMUX  (
        .sel(regAddrSel),
        .in0(rt),
        .in1(rd),
        .in2(5'd31),
        .in3(5'd0),
        .out(regA3)
    );

    MUX4_1 #(.BITS(32)) regRD1MUX (
        .sel(regRD1Forward),
        .in0(regRD1_orig),
        .in1(EXBack),
        .in2(MEMBack),
        .in3(32'b0),
        .out(regRD1)
    );

    MUX4_1 #(.BITS(32)) regRD2MUX (
        .sel(regRD2Forward),
        .in0(regRD2_orig),
        .in1(EXBack),
        .in2(MEMBack),
        .in3(32'b0),
        .out(regRD2)
    );

    GRF generalRegisterFile (
        .clk(clk),
        .reset(reset),
        .A1(rs),
        .A2(rt),
        .A3(regAddr),
        .WD(WBBack),
        .RD1(regRD1_orig),
        .RD2(regRD2_orig)
    );

    EXT extender (
        .imm16(imm16),
        .ctrl(EXTCtrl),
        .imm32(imm32)
    );

    CMP comparer (
        .srcA(regRD1),
        .srcB(regRD2),
        .ctrl(CMPCtrl),
        .result(CMPResult)
    );

    NPC nextProgramCounter (
        .PC_F(PC_F),
        .PC_D(PC_D),
        .offset(imm32),
        .index(index),
        .register(regRD1),
        .ctrl(NPCCtrl),
        .PCAdd8(PCAdd8),
        .nextPC(nextPC)
    );

endmodule