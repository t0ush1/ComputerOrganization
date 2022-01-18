`timescale 1ns / 1ps

module mips(
    input clk,
    input reset
    );

    wire memWrite;
    wire [1:0] regAddrSel;
    wire [1:0] EXBackSel;
    wire [1:0] MEMBackSel;
    wire [1:0] WBBackSel;
    wire ALUSrcASel;
    wire ALUSrcBSel;
    wire [3:0] ALUCtrl;
    wire [3:0] CMPCtrl;
    wire [2:0] EXTCtrl;
    wire [2:0] NPCCtrl;
    wire [2:0] DMCtrl;
    wire [2:0] Tnew;

    wire [1:0] regRD1Forward_D;
    wire [1:0] regRD2Forward_D;
    wire [1:0] regRD1Forward_E;
    wire [1:0] regRD2Forward_E;
    wire regRD2Forward_M;
    wire stall;

    wire [31:0] instr;
    wire CMPResult;

    wire [4:0] regA1_D;
    wire [4:0] regA2_D;
    wire [4:0] regA1_E;
    wire [4:0] regA2_E;
    wire [4:0] regA2_M;

    wire [2:0] Tnew_E;
    wire [2:0] Tnew_M;
    wire [2:0] Tnew_W;
    wire [4:0] regA3_E;
    wire [4:0] regA3_M;
    wire [4:0] regA3_W;

    Datapath datapath (
        .clk(clk),
        .reset(reset),

        .memWrite_D(memWrite),
        .regAddrSel_D(regAddrSel),
        .EXBackSel_D(EXBackSel),
        .MEMBackSel_D(MEMBackSel),
        .WBBackSel_D(WBBackSel),
        .ALUSrcASel_D(ALUSrcASel),
        .ALUSrcBSel_D(ALUSrcBSel),
        .ALUCtrl_D(ALUCtrl),
        .CMPCtrl_D(CMPCtrl),
        .EXTCtrl_D(EXTCtrl),
        .NPCCtrl_D(NPCCtrl),
        .DMCtrl_D(DMCtrl),
        .Tnew_D(Tnew),

        .regRD1Forward_D(regRD1Forward_D),
        .regRD2Forward_D(regRD2Forward_D),
        .regRD1Forward_E(regRD1Forward_E),
        .regRD2Forward_E(regRD2Forward_E),
        .regRD2Forward_M(regRD2Forward_M),
        .stall(stall),

        .instr_D(instr),
        .CMPResult_D(CMPResult),

        .regA1_D(regA1_D),
        .regA2_D(regA2_D),
        .regA1_E(regA1_E),
        .regA2_E(regA2_E),
        .regA2_M(regA2_M),

        .Tnew_E(Tnew_E),
        .Tnew_M(Tnew_M),
        .Tnew_W(Tnew_W),
        .regA3_E(regA3_E),
        .regA3_M(regA3_M),
        .regA3_W(regA3_W)
    );

    Controller controller (
        .instr(instr),
        .CMPResult(CMPResult),

        .regA1_D(regA1_D),
        .regA2_D(regA2_D),
        .regA1_E(regA1_E),
        .regA2_E(regA2_E),
        .regA2_M(regA2_M),

        .Tnew_E(Tnew_E),
        .Tnew_M(Tnew_M),
        .Tnew_W(Tnew_W),
        .regA3_E(regA3_E),
        .regA3_M(regA3_M),
        .regA3_W(regA3_W),

        .memWrite(memWrite),
        .regAddrSel(regAddrSel),
        .EXBackSel(EXBackSel),
        .MEMBackSel(MEMBackSel),
        .WBBackSel(WBBackSel),
        .ALUSrcASel(ALUSrcASel),
        .ALUSrcBSel(ALUSrcBSel),
        .ALUCtrl(ALUCtrl),
        .CMPCtrl(CMPCtrl),
        .EXTCtrl(EXTCtrl),
        .NPCCtrl(NPCCtrl),
        .DMCtrl(DMCtrl),
        .Tnew(Tnew),

        .regRD1Forward_D(regRD1Forward_D),
        .regRD2Forward_D(regRD2Forward_D),
        .regRD1Forward_E(regRD1Forward_E),
        .regRD2Forward_E(regRD2Forward_E),
        .regRD2Forward_M(regRD2Forward_M),
        .stall(stall)
    );

endmodule