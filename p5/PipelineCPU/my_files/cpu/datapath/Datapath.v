`timescale 1ns / 1ps

module Datapath (
    input clk,
    input reset,
    
    input memWrite_D,
    input [1:0] regAddrSel_D,
    input [1:0] EXBackSel_D,
    input [1:0] MEMBackSel_D,
    input [1:0] WBBackSel_D,
    input ALUSrcASel_D,
    input ALUSrcBSel_D,
    input [3:0] ALUCtrl_D,
    input [3:0] CMPCtrl_D,
    input [2:0] EXTCtrl_D,
    input [2:0] NPCCtrl_D,
    input [2:0] DMCtrl_D,
    input [2:0] Tnew_D,

    input [1:0] regRD1Forward_D,
    input [1:0] regRD2Forward_D,
    input [1:0] regRD1Forward_E,
    input [1:0] regRD2Forward_E,
    input regRD2Forward_M,
    input stall,

    output [31:0] instr_D,
    output CMPResult_D,

    output [4:0] regA1_D,
    output [4:0] regA2_D,
    output [4:0] regA1_E,
    output [4:0] regA2_E,
    output [4:0] regA2_M,

    output [2:0] Tnew_E,
    output [2:0] Tnew_M,
    output [2:0] Tnew_W,
    output [4:0] regA3_E,
    output [4:0] regA3_M,
    output [4:0] regA3_W
);

/////// wires /////////////////////////////////////////////////////////////
	wire [31:0] PC_F;
    wire [31:0] instr_F;

	wire [31:0] PC_D;
    wire [4:0] shamt_D;
    wire [4:0] regA3_D;
    wire [31:0] regRD1_D;
    wire [31:0] regRD2_D;
    wire [31:0] imm32_D;
    wire [31:0] PCAdd8_D;
    wire [31:0] nextPC_D;

	wire [4:0] shamt_E;
    wire [31:0] regRD1_orig_E;
    wire [31:0] regRD2_orig_E;
    wire [31:0] imm32_E;
    wire [31:0] PCAdd8_E;
    wire [31:0] PC_E;
    wire [31:0] ALUResult_E;
    wire [31:0] regRD2_E;

    wire memWrite_E;
    wire [1:0] EXBackSel_E;
    wire [1:0] MEMBackSel_E;
    wire [1:0] WBBackSel_E;
    wire ALUSrcASel_E;
    wire ALUSrcBSel_E;
    wire [3:0] ALUCtrl_E;
    wire [2:0] DMCtrl_E;
	
	wire [31:0] ALUResult_M;
    wire [31:0] regRD2_orig_M;
    wire [31:0] PCAdd8_M;
    wire [31:0] PC_M;
    wire [31:0] memRD_M;

    wire memWrite_M;
    wire [1:0] MEMBackSel_M;
    wire [1:0] WBBackSel_M;
    wire [2:0] DMCtrl_M;
	
    wire [31:0] ALUResult_W;
    wire [31:0] memRD_W;
    wire [31:0] PCAdd8_W;
    wire [31:0] PC_W;
	
	wire [1:0] WBBackSel_W;
	
    wire [31:0] EXBack;
    wire [31:0] MEMBack;
    wire [31:0] WBBack;
	
/////// IF + IF_ID ////////////////////////////////////////////////////////
    IF instructionFetch (
        .clk(clk),
        .reset(reset),
        .PCWrite(~stall),
        .nextPC(nextPC_D),
        .PC(PC_F),
        .instr(instr_F)
    );

    IF_ID pipelineRegisterIF_ID (
        .clk(clk),
        .reset(reset),
        .WE(~stall),
        .instr_I(instr_F),
        .PC_I(PC_F),
        .instr_O(instr_D),
        .PC_O(PC_D)
    );

/////// ID + ID_EX ////////////////////////////////////////////////////////
    ID instructionDecode (
        .clk(clk),
        .reset(reset),

        .PC_F(PC_F),
        .PC_D(PC_D),
        .PC_W(PC_W),
        .instr(instr_D),
        .regAddr(regA3_W),
        .EXBack(EXBack),
        .MEMBack(MEMBack),
        .WBBack(WBBack),

        .regWrite(1'b1),
        .regAddrSel(regAddrSel_D),
        .CMPCtrl(CMPCtrl_D),
        .EXTCtrl(EXTCtrl_D),
        .NPCCtrl(NPCCtrl_D),
        .regRD1Forward(regRD1Forward_D),
        .regRD2Forward(regRD2Forward_D),

        .shamt(shamt_D),
        .regA1(regA1_D),
        .regA2(regA2_D),
        .regA3(regA3_D),
        .regRD1(regRD1_D),
        .regRD2(regRD2_D),
        .imm32(imm32_D),
        .CMPResult(CMPResult_D),
        .PCAdd8(PCAdd8_D),
        .nextPC(nextPC_D)
    );

    ID_EX pipelineRegisterID_EX (
        .clk(clk),
        .reset(reset | stall),
        .WE(1'b1),

        .shamt_I(shamt_D),
        .regA1_I(regA1_D),
        .regA2_I(regA2_D),
        .regA3_I(regA3_D),
        .regRD1_I(regRD1_D),
        .regRD2_I(regRD2_D),
        .imm32_I(imm32_D),
        .PCAdd8_I(PCAdd8_D),
        .PC_I(PC_D),

        .memWrite_I(memWrite_D),
        .EXBackSel_I(EXBackSel_D),
        .MEMBackSel_I(MEMBackSel_D),
        .WBBackSel_I(WBBackSel_D),
        .ALUSrcASel_I(ALUSrcASel_D),
        .ALUSrcBSel_I(ALUSrcBSel_D),
        .ALUCtrl_I(ALUCtrl_D),
        .DMCtrl_I(DMCtrl_D),
        .Tnew_I(Tnew_D),

        .shamt_O(shamt_E),
        .regA1_O(regA1_E),
        .regA2_O(regA2_E),
        .regA3_O(regA3_E),
        .regRD1_O(regRD1_orig_E),
        .regRD2_O(regRD2_orig_E),
        .imm32_O(imm32_E),
        .PCAdd8_O(PCAdd8_E),
        .PC_O(PC_E),

        .memWrite_O(memWrite_E),
        .EXBackSel_O(EXBackSel_E),
        .MEMBackSel_O(MEMBackSel_E),
        .WBBackSel_O(WBBackSel_E),
        .ALUSrcASel_O(ALUSrcASel_E),
        .ALUSrcBSel_O(ALUSrcBSel_E),
        .ALUCtrl_O(ALUCtrl_E),
        .DMCtrl_O(DMCtrl_E),
        .Tnew_O(Tnew_E)
    );

/////// EX + EX_MEM ////////////////////////////////////////////////////////
    EX execute (
        .shamt(shamt_E),
        .regRD1_orig(regRD1_orig_E),
        .regRD2_orig(regRD2_orig_E),
		.imm32(imm32_E),
        .MEMBack(MEMBack),
        .WBBack(WBBack),

        .ALUSrcASel(ALUSrcASel_E),
        .ALUSrcBSel(ALUSrcBSel_E),
        .ALUCtrl(ALUCtrl_E),
        .regRD1Forward(regRD1Forward_E),
        .regRD2Forward(regRD2Forward_E),

        .ALUResult(ALUResult_E),
        .regRD2(regRD2_E)
    );

    EX_MEM pipelineRegisterEX_MEM (
        .clk(clk),
        .reset(reset),
        .WE(1'b1),

        .regA2_I(regA2_E),
        .regA3_I(regA3_E),
        .ALUResult_I(ALUResult_E),
        .regRD2_I(regRD2_E),
        .PCAdd8_I(PCAdd8_E),
        .PC_I(PC_E),

        .memWrite_I(memWrite_E),
        .MEMBackSel_I(MEMBackSel_E),
        .WBBackSel_I(WBBackSel_E),
        .DMCtrl_I(DMCtrl_E),
        .Tnew_I(Tnew_E),

        .regA2_O(regA2_M),
        .regA3_O(regA3_M),
        .ALUResult_O(ALUResult_M),
        .regRD2_O(regRD2_orig_M),
        .PCAdd8_O(PCAdd8_M),
        .PC_O(PC_M),

        .memWrite_O(memWrite_M),
        .MEMBackSel_O(MEMBackSel_M),
        .WBBackSel_O(WBBackSel_M),
        .DMCtrl_O(DMCtrl_M),
        .Tnew_O(Tnew_M)
    );

/////// MEM + ID_EX ////////////////////////////////////////////////////////
    MEM memory (
        .clk(clk),
        .reset(reset),

        .ALUResult(ALUResult_M),
        .regRD2_orig(regRD2_orig_M),
        .PC(PC_M),
        .WBBack(WBBack),

        .memWrite(memWrite_M),
        .DMCtrl(DMCtrl_M),
        .regRD2Forward(regRD2Forward_M),

        .memRD(memRD_M)
    );

    MEM_WB pipelineRegisterMEM_WB (
        .clk(clk),
        .reset(reset),
        .WE(1'b1),

        .regA3_I(regA3_M),
        .ALUResult_I(ALUResult_M),
        .memRD_I(memRD_M),
        .PCAdd8_I(PCAdd8_M),
        .PC_I(PC_M),

        .WBBackSel_I(WBBackSel_M),
        .Tnew_I(Tnew_M),

        .regA3_O(regA3_W),
        .ALUResult_O(ALUResult_W),
        .memRD_O(memRD_W),
        .PCAdd8_O(PCAdd8_W),
        .PC_O(PC_W),

        .WBBackSel_O(WBBackSel_W),
        .Tnew_O(Tnew_W)
    );

/////// forward ///////////////////////////////////////////////////////////
    MUX4_1 #(.BITS(32)) EXBackMUX (
        .sel(EXBackSel_E),
        .in0(imm32_E),
        .in1(PCAdd8_E),
        .in2(32'b0),
        .in3(32'b0),
        .out(EXBack)
    );

    MUX4_1 #(.BITS(32)) MEMBackMUX (
        .sel(MEMBackSel_M),
        .in0(ALUResult_M),
        .in1(PCAdd8_M),
        .in2(32'b0),
        .in3(32'b0),
        .out(MEMBack)
    );

    MUX4_1 #(.BITS(32)) WBBackMUX (
        .sel(WBBackSel_W),
        .in0(ALUResult_W),
        .in1(memRD_W),
        .in2(PCAdd8_W),
        .in3(32'b0),
        .out(WBBack)
    );

////////////// debug ///////////////////////////////////////////
//`define __DEBUG__
`ifdef __DEBUG__
	wire [32*8-1:0] asm;
	DASM dasm(
		.pc(PC_D),
		.instr(instr_D),
		.imm_as_dec(1'b1),
		.reg_name(1'b0),
		.asm(asm)
	);
`endif
///////////////////////////////////////////////////////////////////

endmodule