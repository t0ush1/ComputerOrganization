`timescale 1ns / 1ps

module mips(
    input clk,
    input reset,
    input [31:0] i_inst_rdata,
    input [31:0] m_data_rdata,
    output [31:0] i_inst_addr,
    output [31:0] m_data_addr,
    output [31:0] m_data_wdata,
    output [3 :0] m_data_byteen,
    output [31:0] m_inst_addr,
    output w_grf_we,
    output [4:0] w_grf_addr,
    output [31:0] w_grf_wdata,
    output [31:0] w_inst_addr
);

    wire [1:0] regAddrSel;
    wire [1:0] EXBackSel;
    wire [1:0] MEMBackSel;
    wire [1:0] WBBackSel;
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

    wire start_E;
    wire busy;

    assign w_grf_we = 1'b1;
    assign w_grf_addr = regA3_W;

    Datapath datapath (
        .clk(clk),
        .reset(reset),

        .instr_F(i_inst_rdata),
        .memRD_orig(m_data_rdata),

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

        .PC_F(i_inst_addr),
        .instr_D(instr),
        .CMPResult_D(CMPResult),
        .memAddr(m_data_addr),
        .memWD(m_data_wdata),
        .byteEn(m_data_byteen),
        .PC_M(m_inst_addr),
        .WBBack(w_grf_wdata),
        .PC_W(w_inst_addr),

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
        .busy(busy)
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

        .start_E(start_E),
        .busy(busy),

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
        .stall(stall)
    );

endmodule