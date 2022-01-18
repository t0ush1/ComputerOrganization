`timescale 1ns / 1ps

module CPU (
    input clk,
    input reset,
    input [5:0] HWInt,
    input [31:0] instr_F,
    input [31:0] memRD,
    output [31:0] PC_F,
    output [31:0] memAddr,
    output [31:0] memWD,
    output [3:0] byteEn,
    output [31:0] PC_M,
    output [4:0] regAddr,
    output [31:0] regWD,
    output [31:0] PC_W,
    output respUARTInt
);
///////// wires //////////////////////////////////////////
    wire [1:0] regAddrSel;
    wire [1:0] EXBackSel;
    wire [1:0] MEMBackSel;
    wire [2:0] WBBackSel;
    wire ALUSrcASel;
    wire ALUSrcBSel;
    wire MDUResultSel;
    wire start_D;
    wire [3:0] ALUCtrl;
    wire [3:0] MDUCtrl;
    wire [3:0] CMPCtrl;
    wire [2:0] EXTCtrl;
    wire [2:0] NPCCtrl;
    wire [2:0] BECtrl;
    wire [2:0] DECtrl;
    wire clrBrDelay;
    wire [2:0] Tnew;

    wire [1:0] regRD1Forward_D;
    wire [1:0] regRD2Forward_D;
    wire [1:0] regRD1Forward_E;
    wire [1:0] regRD2Forward_E;
    wire regRD2Forward_M;
    wire stall;

    wire excRI;
    wire calOv;
    wire load;
    wire store;
    wire eret;
    wire CP0Write_D;
    wire BD;

    wire [31:0] instr_D;
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

    wire start_E;
    wire busy;

    wire CP0Write_E;
    wire CP0Write_M;
    wire [4:0] rd_E;
    wire [4:0] rd_M;

///////// connection /////////////////////////////////////

    assign regAddr = regA3_W;

    Datapath datapath (
        .clk(clk),
        .reset(reset),

        .instr_F(instr_F),
        .memRD_orig(memRD),

        .regAddrSel_D(regAddrSel),
        .EXBackSel_D(EXBackSel),
        .MEMBackSel_D(MEMBackSel),
        .WBBackSel_D(WBBackSel),
        .ALUSrcASel_D(ALUSrcASel),
        .ALUSrcBSel_D(ALUSrcBSel),
        .MDUResultSel_D(MDUResultSel),
        .start_D(start_D),
        .ALUCtrl_D(ALUCtrl),
        .MDUCtrl_D(MDUCtrl),
        .CMPCtrl_D(CMPCtrl),
        .EXTCtrl_D(EXTCtrl),
        .NPCCtrl_D(NPCCtrl),
        .BECtrl_D(BECtrl),
        .DECtrl_D(DECtrl),
        .Tnew_D(Tnew),
        .clrBrDelay(clrBrDelay),

        .regRD1Forward_D(regRD1Forward_D),
        .regRD2Forward_D(regRD2Forward_D),
        .regRD1Forward_E(regRD1Forward_E),
        .regRD2Forward_E(regRD2Forward_E),
        .regRD2Forward_M(regRD2Forward_M),
        .stall(stall),

        .excRI_D(excRI),
        .calOv_D(calOv),
        .load_D(load),
        .store_D(store),
        .eret_D(eret),
        .CP0Write_D(CP0Write_D),
        .BD_F(BD),

        .HWInt(HWInt),
        .respUARTInt(respUARTInt),

        .PC_F(PC_F),
        .instr_D(instr_D),
        .CMPResult_D(CMPResult),
        .memAddr(memAddr),
        .memWD(memWD),
        .byteEn(byteEn),
        .PC_M(PC_M),
        .WBBack(regWD),
        .PC_W(PC_W),

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

        .start_E(start_E),
        .busy(busy),

        .CP0Write_E(CP0Write_E),
        .CP0Write_M(CP0Write_M),
        .rd_E(rd_E),
        .rd_M(rd_M)
    );

    Controller controller (
        .instr(instr_D),
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

        .start_E(start_E),
        .busy(busy),

        .CP0Write_E(CP0Write_E),
        .CP0Write_M(CP0Write_M),
        .rd_E(rd_E),
        .rd_M(rd_M),

        .regAddrSel(regAddrSel),
        .EXBackSel(EXBackSel),
        .MEMBackSel(MEMBackSel),
        .WBBackSel(WBBackSel),
        .ALUSrcASel(ALUSrcASel),
        .ALUSrcBSel(ALUSrcBSel),
        .MDUResultSel(MDUResultSel),
        .start_D(start_D),
        .ALUCtrl(ALUCtrl),
        .MDUCtrl(MDUCtrl),
        .CMPCtrl(CMPCtrl),
        .EXTCtrl(EXTCtrl),
        .NPCCtrl(NPCCtrl),
        .BECtrl(BECtrl),
        .DECtrl(DECtrl),
        .Tnew(Tnew),
        .clrBrDelay(clrBrDelay),

        .regRD1Forward_D(regRD1Forward_D),
        .regRD2Forward_D(regRD2Forward_D),
        .regRD1Forward_E(regRD1Forward_E),
        .regRD2Forward_E(regRD2Forward_E),
        .regRD2Forward_M(regRD2Forward_M),
        .stall(stall),

        .excRI(excRI),
        .calOv(calOv),
        .load(load),
        .store(store),
        .eret(eret),
        .CP0Write_D(CP0Write_D),
        .BD(BD)
    );

endmodule