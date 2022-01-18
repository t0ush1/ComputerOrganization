`timescale 1ns / 1ps

module Controller (
    input [31:0] instr,
    input CMPResult,

    input [4:0] regA1_D,
    input [4:0] regA2_D,
    input [4:0] regA1_E,
    input [4:0] regA2_E,
    input [4:0] regA2_M,

    input [2:0] Tnew_E,
    input [2:0] Tnew_M,
    input [2:0] Tnew_W,
    input [4:0] regA3_E,
    input [4:0] regA3_M,
    input [4:0] regA3_W,

    input start_E,
    input busy,

    output [1:0] regAddrSel,
    output [1:0] EXBackSel,
    output [1:0] MEMBackSel,
    output [1:0] WBBackSel,
    output ALUSrcASel,
    output ALUSrcBSel,
    output MDUResultSel,
    output start_D,
    output [3:0] ALUCtrl,
    output [3:0] MDUCtrl,
    output [3:0] CMPCtrl,
    output [2:0] EXTCtrl,
    output [2:0] NPCCtrl,
    output [2:0] BECtrl,
    output [2:0] DECtrl,
    output [2:0] Tnew,
    output clrBrDelay,

    output [1:0] regRD1Forward_D,
    output [1:0] regRD2Forward_D,
    output [1:0] regRD1Forward_E,
    output [1:0] regRD2Forward_E,
    output regRD2Forward_M,
    output stall
);
    
    wire [2:0] Tuse_A1;
    wire [2:0] Tuse_A2;
	wire md;
	wire mt;
	wire mf;

    MainController mainController (
        .instr(instr),
        .flag(CMPResult),

        .regAddrSel(regAddrSel),
        .EXBackSel(EXBackSel),
        .MEMBackSel(MEMBackSel),
        .WBBackSel(WBBackSel),
        .ALUSrcASel(ALUSrcASel),
        .ALUSrcBSel(ALUSrcBSel),
        .MDUResultSel(MDUResultSel),
        .start(start_D),
        .ALUCtrl(ALUCtrl),
        .MDUCtrl(MDUCtrl),
        .CMPCtrl(CMPCtrl),
        .EXTCtrl(EXTCtrl),
        .NPCCtrl(NPCCtrl),
        .BECtrl(BECtrl),
        .DECtrl(DECtrl),
        .Tnew(Tnew),
        .clrBrDelay(clrBrDelay),
        
        .Tuse_A1(Tuse_A1),
        .Tuse_A2(Tuse_A2),
        .md(md),
        .mt(mt),
        .mf(mf)
    );

    HazardSolveUnit hazardSolveUnit (
        .Tuse_A1_D(Tuse_A1),
        .Tuse_A2_D(Tuse_A2),
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

        .start(start_E),
        .busy(busy),
        .md(md),
        .mt(mt),
        .mf(mf),

        .regRD1Forward_D(regRD1Forward_D),
        .regRD2Forward_D(regRD2Forward_D),
        .regRD1Forward_E(regRD1Forward_E),
        .regRD2Forward_E(regRD2Forward_E),
        .regRD2Forward_M(regRD2Forward_M),
        .stall(stall)
    );

endmodule