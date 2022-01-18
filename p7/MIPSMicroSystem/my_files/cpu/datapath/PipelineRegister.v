`timescale 1ns / 1ps

`include "../macros.v"

////// IF_ID ////////////////////////////////////////////////////
module IF_ID(
    input clk,
    input reset,
    input WE,
    input nop,
    input [31:0] instr_I,
    input [31:0] PC_I,

    input BD_I,
    input [4:0] excCode_I,

    output reg [31:0] instr_O,
    output reg [31:0] PC_O,

    output reg BD_O,
    output reg [4:0] excCode_O,

    input spare_1bit_I,
    input [4:0] spare_5bit_I,
    input [31:0] spare_32bit_I,
    output reg spare_1bit_O,
    output reg [4:0] spare_5bit_O,
    output reg [31:0] spare_32bit_O
);

    always @(posedge clk)
        if (reset | (nop & WE)) begin
            instr_O   <= 32'b0;
            PC_O      <= reset ? `Instr_Base_Addr : PC_I;
            BD_O      <= reset ? 1'b0 : BD_I;
            excCode_O <= reset ? 5'b0 : excCode_I;

            spare_1bit_O    <= 1'b0;
            spare_5bit_O    <= 5'b0;
            spare_32bit_O   <= 32'b0;
        end else if (WE) begin
            instr_O   <= instr_I;
            PC_O      <= PC_I;
            BD_O      <= BD_I;
            excCode_O <= excCode_I;

            spare_1bit_O    <= spare_1bit_I;
            spare_5bit_O    <= spare_5bit_I;
            spare_32bit_O   <= spare_32bit_I;
        end

endmodule

///////////// ID_EX //////////////////////////////////////////////
module ID_EX(
    input clk,
    input reset,
    input WE,
    input nop,
    input intExcReq,

    input [4:0] shamt_I,
    input [4:0] regA1_I,
    input [4:0] regA2_I,
    input [4:0] regA3_I,
    input [31:0] regRD1_I,
    input [31:0] regRD2_I,
    input [31:0] imm32_I,
    input [31:0] PCAdd8_I,
    input [31:0] PC_I,
    input [31:0] instr_I,

    input [1:0] EXBackSel_I,
    input [1:0] MEMBackSel_I,
    input [2:0] WBBackSel_I,
    input ALUSrcASel_I,
    input ALUSrcBSel_I,
    input MDUResultSel_I,
    input start_I,
    input [3:0] ALUCtrl_I,
    input [3:0] MDUCtrl_I,
    input [2:0] BECtrl_I,
    input [2:0] DECtrl_I,
    input [2:0] Tnew_I,

    input [4:0] rd_I,
    input [4:0] excCode_I,
    input calOv_I,
    input load_I,
    input store_I,
    input eret_I,
    input CP0Write_I,
    input BD_I,

    output reg [4:0] shamt_O,
    output reg [4:0] regA1_O,
    output reg [4:0] regA2_O,
    output reg [4:0] regA3_O,
    output reg [31:0] regRD1_O,
    output reg [31:0] regRD2_O,
    output reg [31:0] imm32_O,
    output reg [31:0] PCAdd8_O,
    output reg [31:0] PC_O,
    output reg [31:0] instr_O,

    output reg [1:0] EXBackSel_O,
    output reg [1:0] MEMBackSel_O,
    output reg [2:0] WBBackSel_O,
    output reg ALUSrcASel_O,
    output reg ALUSrcBSel_O,
    output reg MDUResultSel_O,
    output reg start_O,
    output reg [3:0] ALUCtrl_O,
    output reg [3:0] MDUCtrl_O,
    output reg [2:0] BECtrl_O,
    output reg [2:0] DECtrl_O,
    output reg [2:0] Tnew_O,

    output reg [4:0] rd_O,
    output reg [4:0] excCode_O,
    output reg calOv_O,
    output reg load_O,
    output reg store_O,
    output reg eret_O,
    output reg CP0Write_O,
    output reg BD_O,

    input spare_1bit_I,
    input [4:0] spare_5bit_I,
    input [31:0] spare_32bit_I,
    output reg spare_1bit_O,
    output reg [4:0] spare_5bit_O,
    output reg [31:0] spare_32bit_O
);

	always @(posedge clk)
		if (reset | (nop & WE) | intExcReq) begin
			shamt_O     <= 5'b0;
            regA1_O     <= 5'b0;
            regA2_O     <= 5'b0;
			regA3_O     <= 5'b0;
			regRD1_O    <= 32'b0;
			regRD2_O    <= 32'b0;
			imm32_O     <= 32'b0;
			PCAdd8_O    <= 32'b0;
            PC_O        <= reset ? `Instr_Base_Addr :
                            intExcReq ? `Exc_Handler_Addr :
                            nop ? PC_I :
                            32'b0;
            instr_O     <= 32'b0;

            EXBackSel_O     <= 2'b0;
            MEMBackSel_O    <= 2'b0;
            WBBackSel_O     <= 2'b0;
            ALUSrcASel_O    <= 1'b0;
            ALUSrcBSel_O    <= 1'b0;
            MDUResultSel_O  <= 1'b0;
            start_O         <= 1'b0;
            ALUCtrl_O       <= 4'b0;
            MDUCtrl_O       <= 4'b0;
            BECtrl_O        <= 3'b0;
            DECtrl_O        <= 3'b0;
            Tnew_O          <= 3'b0;

            rd_O            <= 5'b0;
            excCode_O       <= (reset | intExcReq) ? 5'b0 : excCode_I;
            calOv_O         <= 1'b0;
            load_O          <= 1'b0;
            store_O         <= 1'b0;
            eret_O          <= 1'b0;
            CP0Write_O      <= 1'b0;
            BD_O            <= (reset | intExcReq) ? 1'b0 : BD_I;

            spare_1bit_O    <= 1'b0;
            spare_5bit_O    <= 5'b0;
            spare_32bit_O   <= 32'b0;
        end else if (WE) begin
            shamt_O     <= shamt_I;
            regA1_O     <= regA1_I;
            regA2_O     <= regA2_I;
			regA3_O     <= regA3_I;
			regRD1_O    <= regRD1_I;
			regRD2_O    <= regRD2_I;
			imm32_O     <= imm32_I;
			PCAdd8_O    <= PCAdd8_I;
            PC_O        <= PC_I;
            instr_O     <= instr_I;

            EXBackSel_O     <= EXBackSel_I;
            MEMBackSel_O    <= MEMBackSel_I;
            WBBackSel_O     <= WBBackSel_I;
            ALUSrcASel_O    <= ALUSrcASel_I;
            ALUSrcBSel_O    <= ALUSrcBSel_I;
            MDUResultSel_O  <= MDUResultSel_I;
            start_O         <= start_I;
            ALUCtrl_O       <= ALUCtrl_I;
            MDUCtrl_O       <= MDUCtrl_I;
            BECtrl_O        <= BECtrl_I;
            DECtrl_O        <= DECtrl_I;
            Tnew_O          <= Tnew_I;

            rd_O            <= rd_I;
            excCode_O       <= excCode_I;
            calOv_O         <= calOv_I;
            load_O          <= load_I;
            store_O         <= store_I;
            eret_O          <= eret_I;
            CP0Write_O      <= CP0Write_I;
            BD_O            <= BD_I;

            spare_1bit_O    <= spare_1bit_I;
            spare_5bit_O    <= spare_5bit_I;
            spare_32bit_O   <= spare_32bit_I;
        end

endmodule

////// EX_MEM ////////////////////////////////////////////////////////
module EX_MEM(
    input clk,
    input reset,
    input WE,
    input intExcReq,

    input [4:0] regA2_I,
    input [4:0] regA3_I,
    input [31:0] ALUResult_I,
    input [31:0] MDUResult_I,
    input [31:0] regRD2_I,
    input [31:0] PCAdd8_I,
    input [31:0] PC_I,
    input [31:0] instr_I,

    input [1:0] MEMBackSel_I,
    input [2:0] WBBackSel_I,
    input [2:0] BECtrl_I,
    input [2:0] DECtrl_I,
    input [2:0] Tnew_I,

    input [4:0] rd_I,
    input [4:0] excCode_I,
    input excAdOv_I,
    input load_I,
    input store_I,
    input eret_I,
    input CP0Write_I,
    input BD_I,

    output reg [4:0] regA2_O,
    output reg [4:0] regA3_O,
    output reg [31:0] ALUResult_O,
    output reg [31:0] MDUResult_O,
    output reg [31:0] regRD2_O,
    output reg [31:0] PCAdd8_O,
    output reg [31:0] PC_O,
    output reg [31:0] instr_O,

    output reg [1:0] MEMBackSel_O,
    output reg [2:0] WBBackSel_O,
    output reg [2:0] BECtrl_O,
    output reg [2:0] DECtrl_O,
    output reg [2:0] Tnew_O,

    output reg [4:0] rd_O,
    output reg [4:0] excCode_O,
    output reg excAdOv_O,
    output reg load_O,
    output reg store_O,
    output reg eret_O,
    output reg CP0Write_O,
    output reg BD_O,

    input spare_1bit_I,
    input [4:0] spare_5bit_I,
    input [31:0] spare_32bit_I,
    output reg spare_1bit_O,
    output reg [4:0] spare_5bit_O,
    output reg [31:0] spare_32bit_O
);

    always @(posedge clk)
        if (reset | intExcReq) begin
            regA2_O     <= 5'b0;
            regA3_O     <= 5'b0;
            ALUResult_O <= 32'b0;
            MDUResult_O <= 32'b0;
            regRD2_O    <= 32'b0;
            PCAdd8_O    <= 32'b0;
            PC_O        <= reset ? `Instr_Base_Addr : `Exc_Handler_Addr;
            instr_O     <= 32'b0;

            MEMBackSel_O    <= 2'b0;
            WBBackSel_O     <= 2'b0;
            BECtrl_O        <= 3'b0;
            DECtrl_O        <= 3'b0;
            Tnew_O          <= 3'b0;

            rd_O            <= 5'b0;
            excCode_O       <= 5'b0;
            excAdOv_O       <= 1'b0;
            load_O          <= 1'b0;
            store_O         <= 1'b0;
            eret_O          <= 1'b0;
            CP0Write_O      <= 1'b0;
            BD_O            <= 1'b0;

            spare_1bit_O    <= 1'b0;
            spare_5bit_O    <= 5'b0;
            spare_32bit_O   <= 32'b0;
        end else if (WE) begin
            regA2_O     <= regA2_I;
            regA3_O     <= regA3_I;
            ALUResult_O <= ALUResult_I;
            MDUResult_O <= MDUResult_I;
            regRD2_O    <= regRD2_I;
            PCAdd8_O    <= PCAdd8_I;
            PC_O        <= PC_I;
            instr_O     <= instr_I;

            MEMBackSel_O    <= MEMBackSel_I;
            WBBackSel_O     <= WBBackSel_I;
            BECtrl_O        <= BECtrl_I;
            DECtrl_O        <= DECtrl_I;
            Tnew_O          <= (Tnew_I == 3'b0) ? 3'b0 : Tnew_I - 1;

            rd_O            <= rd_I;
            excCode_O       <= excCode_I;
            excAdOv_O       <= excAdOv_I;
            load_O          <= load_I;
            store_O         <= store_I;
            eret_O          <= eret_I;
            CP0Write_O      <= CP0Write_I;
            BD_O            <= BD_I;

            spare_1bit_O    <= spare_1bit_I;
            spare_5bit_O    <= spare_5bit_I;
            spare_32bit_O   <= spare_32bit_I;
        end

endmodule

////// MEM_WB ////////////////////////////////////////////////
module MEM_WB(
    input clk,
    input reset,
    input WE,
    input intExcReq,

    input [4:0] regA3_I,
    input [31:0] ALUResult_I,
    input [31:0] MDUResult_I,
    input [31:0] memRD_I,
    input [31:0] PCAdd8_I,
    input [31:0] PC_I,
    input [31:0] instr_I,
    input [31:0] CP0RD_I,

    input [2:0] WBBackSel_I,
    input [2:0] Tnew_I,
    
    output reg [4:0] regA3_O,
    output reg [31:0] ALUResult_O,
    output reg [31:0] MDUResult_O,
    output reg [31:0] memRD_O,
    output reg [31:0] PCAdd8_O,
    output reg [31:0] PC_O,
    output reg [31:0] instr_O,
    output reg [31:0] CP0RD_O,

    output reg [2:0] WBBackSel_O,
    output reg [2:0] Tnew_O,

    input spare_1bit_I,
    input [4:0] spare_5bit_I,
    input [31:0] spare_32bit_I,
    output reg spare_1bit_O,
    output reg [4:0] spare_5bit_O,
    output reg [31:0] spare_32bit_O
);

    always @(posedge clk)
        if (reset | intExcReq) begin
            regA3_O     <= 5'b0;
            ALUResult_O <= 32'b0;
            MDUResult_O <= 32'b0;
            memRD_O     <= 32'b0;
            PCAdd8_O    <= 32'b0;
            PC_O        <= reset ? `Instr_Base_Addr : `Exc_Handler_Addr;
            instr_O     <= 32'b0;
            CP0RD_O     <= 32'b0;

            WBBackSel_O <= 2'b0;
            Tnew_O      <= 3'b0;

            spare_1bit_O    <= 1'b0;
            spare_5bit_O    <= 5'b0;
            spare_32bit_O   <= 32'b0;
        end else if (WE) begin
            regA3_O     <= regA3_I;
            ALUResult_O <= ALUResult_I;
            MDUResult_O <= MDUResult_I;
            memRD_O     <= memRD_I;
            PCAdd8_O    <= PCAdd8_I;
            PC_O        <= PC_I;
            instr_O     <= instr_I;
            CP0RD_O     <= CP0RD_I;

            WBBackSel_O <= WBBackSel_I;
            Tnew_O      <= (Tnew_I == 3'b0) ? 3'b0 : Tnew_I - 1;

            spare_1bit_O    <= spare_1bit_I;
            spare_5bit_O    <= spare_5bit_I;
            spare_32bit_O   <= spare_32bit_I;
        end

endmodule