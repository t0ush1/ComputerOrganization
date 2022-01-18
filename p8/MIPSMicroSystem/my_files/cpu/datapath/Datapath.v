`timescale 1ns / 1ps

`include "../macros.v"

module Datapath (
    input clk,
    input reset,
    
    input [31:0] instr_F,
    input [31:0] memRD_orig,

    input [1:0] regAddrSel_D,
    input [1:0] EXBackSel_D,
    input [1:0] MEMBackSel_D,
    input [2:0] WBBackSel_D,
    input ALUSrcASel_D,
    input ALUSrcBSel_D,
    input MDUResultSel_D,
    input start_D,
    input [3:0] ALUCtrl_D,
    input [3:0] MDUCtrl_D,
    input [3:0] CMPCtrl_D,
    input [2:0] EXTCtrl_D,
    input [2:0] NPCCtrl_D,
    input [2:0] BECtrl_D,
    input [2:0] DECtrl_D,
    input [2:0] Tnew_D,
    input clrBrDelay,

    input [1:0] regRD1Forward_D,
    input [1:0] regRD2Forward_D,
    input [1:0] regRD1Forward_E,
    input [1:0] regRD2Forward_E,
    input regRD2Forward_M,
    input stall,

    input excRI_D,
    input calOv_D,
    input load_D,
    input store_D,
    input eret_D,
    input CP0Write_D,
    input BD_F,

    input [5:0] HWInt,
    output respUARTInt,

    output [31:0] PC_F,
    output [31:0] instr_D,
    output CMPResult_D,
    output [31:0] memAddr,
    output [31:0] memWD,
    output [3:0] byteEn,
    output [31:0] PC_M,
    output [31:0] WBBack,
    output [31:0] PC_W,

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
    output [4:0] regA3_W,
    
    output start_E,
    output busy,

    output CP0Write_E,
    output CP0Write_M,
    output [4:0] rd_E,
    output [4:0] rd_M
);

/////// wires /////////////////////////////////////////////////////////////
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
    wire [31:0] MDUResult_E;
    wire [31:0] regRD2_E;

    wire [1:0] EXBackSel_E;
    wire [1:0] MEMBackSel_E;
    wire [2:0] WBBackSel_E;
    wire ALUSrcASel_E;
    wire ALUSrcBSel_E;
    wire MDUResultSel_E;
    wire [3:0] ALUCtrl_E;
    wire [3:0] MDUCtrl_E;
    wire [2:0] BECtrl_E;
    wire [2:0] DECtrl_E;
	
	wire [31:0] ALUResult_M;
    wire [31:0] MDUResult_M;
    wire [31:0] regRD2_orig_M;
    wire [31:0] PCAdd8_M;
    wire [31:0] memRD_M;

    wire [1:0] MEMBackSel_M;
    wire [2:0] WBBackSel_M;
    wire [2:0] BECtrl_M;
    wire [2:0] DECtrl_M;
	
    wire [31:0] ALUResult_W;
    wire [31:0] MDUResult_W;
    wire [31:0] memRD_W;
    wire [31:0] PCAdd8_W;
	
	wire [2:0] WBBackSel_W;
	
    wire [31:0] EXBack;
    wire [31:0] MEMBack;
	
////// exception wires ////////////////////////////////////////////////////
    wire [31:0] PC_orig_F;
    wire excAdEL_F;
    wire [4:0] excCode_F;

    wire BD_D;
    wire [4:0] rd_D;
    wire [4:0] excCode_orig_D;
    wire [4:0] excCode_D;

    wire calOv_E;
    wire load_E;
    wire store_E;
    wire eret_E;
    wire BD_E;

    wire overflow_E;
    wire excOv_E;
    wire excAdOv_E;
    wire [4:0] excCode_orig_E;
    wire [4:0] excCode_E;

    wire [31:0] regRD2_M;
    wire load_M;
    wire store_M;
    wire eret_M;
    wire BD_M;

    wire hitDM_M;
    wire hitTC_M;
    wire hitDT_M;
    wire hitUART_M;
    wire hitIO_M;
    wire excAdOv_M;
    wire excAdEL_Align_M;
    wire excAdES_Align_M;
    wire excAdEL_TC_M;
    wire excAdES_TC_M;
    wire excAdEL_UART_M;
    wire excAdES_UART_M;
    wire excAdES_IO_M;
    wire excAdOutOfRange_M;
    wire excAdEL_M;
    wire excAdES_M;
    wire [4:0] excCode_orig_M;
    wire [4:0] excCode_M;
    wire [31:0] EPC_M;
    wire [31:0] CP0RD_M;

    wire [31:0] CP0RD_W;

    wire intExcReq;
    wire [3:0] byteEn_orig;

/////// IF + IF_ID ////////////////////////////////////////////////////////
    IF instructionFetch (
        .clk(clk),
        .reset(reset),
        .PCWrite(~stall | intExcReq),
        .nextPC(nextPC_D),
        .PC(PC_orig_F)
    );

    assign PC_F = intExcReq ? `Exc_Handler_Addr :
                    eret_D ? EPC_M :
                    PC_orig_F;

    assign excAdEL_F = (|PC_F[1:0]) || PC_F < `Instr_Base_Addr || PC_F > `Instr_Limit_Addr;
    assign excCode_F = excAdEL_F ? `EXC_AdEL : `EXC_None;
    
    IF_ID pipelineRegisterIF_ID (
        .clk(clk),
        .reset(reset),
        .WE(~stall | intExcReq),
        .nop(clrBrDelay | excAdEL_F),

        .instr_I(instr_F),
        .PC_I(PC_F),

        .BD_I(BD_F),
        .excCode_I(excCode_F),

        .instr_O(instr_D),
        .PC_O(PC_D),

        .BD_O(BD_D),
        .excCode_O(excCode_orig_D)
    );

/////// ID + ID_EX ////////////////////////////////////////////////////////
    ID instructionDecode (
        .clk(clk),
        .reset(reset),

        .PC_F(PC_F),
        .PC_D(PC_D),
		  .instr(instr_D),
        .regAddr(regA3_W),
        .EXBack(EXBack),
        .MEMBack(MEMBack),
        .WBBack(WBBack),

        .regAddrSel(regAddrSel_D),
        .CMPCtrl(CMPCtrl_D),
        .EXTCtrl(EXTCtrl_D),
        .NPCCtrl(intExcReq ? `NPC_add4 : NPCCtrl_D),
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
        .nextPC(nextPC_D),
        .rd(rd_D)
    );

    assign excCode_D = excCode_orig_D ? excCode_orig_D :
                        excRI_D ? `EXC_RI :
                        `EXC_None;

    ID_EX pipelineRegisterID_EX (
        .clk(clk),
        .reset(reset),
        .WE(1'b1),
        .nop(stall | excRI_D),
        .intExcReq(intExcReq),

        .shamt_I(shamt_D),
        .regA1_I(regA1_D),
        .regA2_I(regA2_D),
        .regA3_I(regA3_D),
        .regRD1_I(regRD1_D),
        .regRD2_I(regRD2_D),
        .imm32_I(imm32_D),
        .PCAdd8_I(PCAdd8_D),
        .PC_I(PC_D),

        .EXBackSel_I(EXBackSel_D),
        .MEMBackSel_I(MEMBackSel_D),
        .WBBackSel_I(WBBackSel_D),
        .ALUSrcASel_I(ALUSrcASel_D),
        .ALUSrcBSel_I(ALUSrcBSel_D),
        .MDUResultSel_I(MDUResultSel_D),
        .start_I(start_D),
        .ALUCtrl_I(ALUCtrl_D),
        .MDUCtrl_I(MDUCtrl_D),
        .BECtrl_I(BECtrl_D),
        .DECtrl_I(DECtrl_D),
        .Tnew_I(Tnew_D),

        .rd_I(rd_D),
        .excCode_I(excCode_D),
        .calOv_I(calOv_D),
        .load_I(load_D),
        .store_I(store_D),
        .eret_I(eret_D),
        .CP0Write_I(CP0Write_D),
        .BD_I(BD_D),

        .shamt_O(shamt_E),
        .regA1_O(regA1_E),
        .regA2_O(regA2_E),
        .regA3_O(regA3_E),
        .regRD1_O(regRD1_orig_E),
        .regRD2_O(regRD2_orig_E),
        .imm32_O(imm32_E),
        .PCAdd8_O(PCAdd8_E),
        .PC_O(PC_E),

        .EXBackSel_O(EXBackSel_E),
        .MEMBackSel_O(MEMBackSel_E),
        .WBBackSel_O(WBBackSel_E),
        .ALUSrcASel_O(ALUSrcASel_E),
        .ALUSrcBSel_O(ALUSrcBSel_E),
        .MDUResultSel_O(MDUResultSel_E),
        .start_O(start_E),
        .ALUCtrl_O(ALUCtrl_E),
        .MDUCtrl_O(MDUCtrl_E),
        .BECtrl_O(BECtrl_E),
        .DECtrl_O(DECtrl_E),
        .Tnew_O(Tnew_E),

        .rd_O(rd_E),
        .excCode_O(excCode_orig_E),
        .calOv_O(calOv_E),
        .load_O(load_E),
        .store_O(store_E),
        .eret_O(eret_E),
        .CP0Write_O(CP0Write_E),
        .BD_O(BD_E)
    );

/////// EX + EX_MEM ///////////////////////////////////////////////////////
    EX execute (
        .clk(clk),
        .reset(reset),

        .shamt(shamt_E),
        .regRD1_orig(regRD1_orig_E),
        .regRD2_orig(regRD2_orig_E),
		.imm32(imm32_E),
        .MEMBack(MEMBack),
        .WBBack(WBBack),

        .ALUSrcASel(ALUSrcASel_E),
        .ALUSrcBSel(ALUSrcBSel_E),
        .start(start_E & ~intExcReq),
        .MDUResultSel(MDUResultSel_E),
        .ALUCtrl(ALUCtrl_E),
        .MDUCtrl(intExcReq ? `MDU_none : MDUCtrl_E),
        .regRD1Forward(regRD1Forward_E),
        .regRD2Forward(regRD2Forward_E),

        .ALUResult(ALUResult_E),
        .MDUResult(MDUResult_E),
        .regRD2(regRD2_E),

        .busy(busy),

        .overflow(overflow_E)
    );

    assign excOv_E = overflow_E & calOv_E;
    assign excAdOv_E = overflow_E & (load_E | store_E);
    assign excCode_E = excCode_orig_E ? excCode_orig_E :
                        excOv_E ? `EXC_Ov :
                        `EXC_None;

    EX_MEM pipelineRegisterEX_MEM (
        .clk(clk),
        .reset(reset),
        .WE(1'b1),
        .intExcReq(intExcReq),

        .regA2_I(regA2_E),
        .regA3_I(regA3_E),
        .ALUResult_I(ALUResult_E),
        .MDUResult_I(MDUResult_E),
        .regRD2_I(regRD2_E),
        .PCAdd8_I(PCAdd8_E),
        .PC_I(PC_E),

        .MEMBackSel_I(MEMBackSel_E),
        .WBBackSel_I(WBBackSel_E),
        .BECtrl_I(BECtrl_E),
        .DECtrl_I(DECtrl_E),
        .Tnew_I(Tnew_E),

        .rd_I(rd_E),
        .excCode_I(excCode_E),
        .excAdOv_I(excAdOv_E),
        .load_I(load_E),
        .store_I(store_E),
        .eret_I(eret_E),
        .CP0Write_I(CP0Write_E),
        .BD_I(BD_E),

        .regA2_O(regA2_M),
        .regA3_O(regA3_M),
        .ALUResult_O(ALUResult_M),
        .MDUResult_O(MDUResult_M),
        .regRD2_O(regRD2_orig_M),
        .PCAdd8_O(PCAdd8_M),
        .PC_O(PC_M),

        .MEMBackSel_O(MEMBackSel_M),
        .WBBackSel_O(WBBackSel_M),
        .BECtrl_O(BECtrl_M),
        .DECtrl_O(DECtrl_M),
        .Tnew_O(Tnew_M),

        .rd_O(rd_M),
        .excCode_O(excCode_orig_M),
        .excAdOv_O(excAdOv_M),
        .load_O(load_M),
        .store_O(store_M),
        .eret_O(eret_M),
        .CP0Write_O(CP0Write_M),
        .BD_O(BD_M)
    );

/////// MEM + ID_EX ///////////////////////////////////////////////////////
    assign memAddr = ALUResult_M;
    assign byteEn = intExcReq ? 4'b0 : byteEn_orig;

    MEM memory (
        .regRD2_orig(regRD2_orig_M),
        .WBBack(WBBack),
        .memRD_orig(memRD_orig),
        .byteSel(memAddr[1:0]),

        .BECtrl(BECtrl_M),
        .DECtrl(DECtrl_M),
        .regRD2Forward(regRD2Forward_M),

        .byteEn(byteEn_orig),
        .memWD(memWD),
        .memRD(memRD_M),
        .regRD2(regRD2_M)
    );

    assign hitDM_M = memAddr >= `Data_Base_Addr && memAddr <= `Data_Limit_Addr;
    assign hitTC_M = memAddr >= `TC_Base_Addr && memAddr <= `TC_Limit_Addr;
    assign hitDT_M = memAddr >= `DT_Base_Addr && memAddr <= `DT_Limit_Addr;
    assign hitUART_M = memAddr >= `UART_Base_Addr && memAddr <= `UART_Limit_Addr;
    assign hitIO_M = memAddr >= `IO_Base_Addr && memAddr <= `IO_Limit_Addr;

    assign excAdEL_Align_M = (DECtrl_M == `DE_word && (|memAddr[1:0])) ||
                            ((DECtrl_M == `DE_hfwd || DECtrl_M == `DE_ushw) && memAddr[0]);
    assign excAdES_Align_M = (BECtrl_M == `BE_word && (|memAddr[1:0])) ||
                            (BECtrl_M == `BE_hfwd && memAddr[0]);

    assign excAdEL_TC_M = (hitTC_M) && DECtrl_M != `DE_word;
    assign excAdES_TC_M = (hitTC_M && (BECtrl_M == `BE_hfwd || BECtrl_M == `BE_byte)) ||
                            (memAddr >= `TC_Base_Addr + 32'd8 && memAddr <= `TC_Limit_Addr);

    assign excAdEL_UART_M = hitUART_M && DECtrl_M != `DE_word;
    assign excAdES_UART_M = (hitUART_M && (BECtrl_M == `BE_hfwd || BECtrl_M == `BE_byte)) ||
                            (memAddr >= `UART_Base_Addr + 32'd16 && memAddr <= `UART_Base_Addr + 32'd19);

    assign excAdES_IO_M = memAddr >= `IO_Base_Addr && memAddr <= `IO_Base_Addr + 32'd12;

    assign excAdOutOfRange_M = ~hitDM_M & ~hitTC_M & ~hitDT_M & ~hitUART_M & ~hitIO_M;

    assign excAdEL_M = load_M & (excAdEL_Align_M | excAdOutOfRange_M | excAdOv_M | excAdEL_TC_M | excAdEL_UART_M);
    assign excAdES_M = store_M & (excAdES_Align_M | excAdOutOfRange_M | excAdOv_M | excAdES_TC_M | excAdES_UART_M | excAdES_IO_M);

    assign excCode_M = excCode_orig_M ? excCode_orig_M :
                        excAdEL_M ? `EXC_AdEL :
                        excAdES_M ? `EXC_AdES :
                        `EXC_None;

    CP0 coprocessor0 (
        .clk(clk),
        .reset(reset),
        .A1(rd_M),
        .A2(rd_M),
        .WD(regRD2_M),
        .PC(PC_M),
        .excCode(excCode_M),
        .HWInt(HWInt),
        .WE(CP0Write_M),
        .EXLReset(eret_M),
        .BD(BD_M),
        .intExcReq(intExcReq),
        .EPC(EPC_M),
        .RD(CP0RD_M),
        .respUARTInt(respUARTInt)
    );

    MEM_WB pipelineRegisterMEM_WB (
        .clk(clk),
        .reset(reset),
        .WE(1'b1),
        .intExcReq(intExcReq),

        .regA3_I(regA3_M),
        .ALUResult_I(ALUResult_M),
        .MDUResult_I(MDUResult_M),
        .memRD_I(memRD_M),
        .PCAdd8_I(PCAdd8_M),
        .PC_I(PC_M),
        .CP0RD_I(CP0RD_M),

        .WBBackSel_I(WBBackSel_M),
        .Tnew_I(Tnew_M),

        .regA3_O(regA3_W),
        .ALUResult_O(ALUResult_W),
        .MDUResult_O(MDUResult_W),
        .memRD_O(memRD_W),
        .PCAdd8_O(PCAdd8_W),
        .PC_O(PC_W),
        .CP0RD_O(CP0RD_W),

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
        .in2(MDUResult_M),
        .in3(32'b0),
        .out(MEMBack)
    );

    MUX8_1 #(.BITS(32)) WBBackMUX (
        .sel(WBBackSel_W),
        .in0(ALUResult_W),
        .in1(memRD_W),
        .in2(PCAdd8_W),
        .in3(MDUResult_W),
        .in4(CP0RD_W),
        .in5(32'b0),
        .in6(32'b0),
        .in7(32'b0),
        .out(WBBack)
    );

endmodule