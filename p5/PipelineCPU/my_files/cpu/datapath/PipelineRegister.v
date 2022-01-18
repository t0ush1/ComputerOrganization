`timescale 1ns / 1ps

////// IF_ID ////////////////////////////////////////////////////
module IF_ID(
    input clk,
    input reset,
    input WE,
    input [31:0] instr_I,
    input [31:0] PC_I,
    output reg [31:0] instr_O,
    output reg [31:0] PC_O
);

    always @(posedge clk)
        if (reset) begin
            instr_O   <= 32'b0;
            PC_O    <= 32'b0;
        end else if (WE) begin
            instr_O   <= instr_I;
            PC_O    <= PC_I;
        end

endmodule

///////////// ID_EX //////////////////////////////////////////////
module ID_EX(
    input clk,
    input reset,
    input WE,

    input [4:0] shamt_I,
    input [4:0] regA1_I,
    input [4:0] regA2_I,
    input [4:0] regA3_I,
    input [31:0] regRD1_I,
    input [31:0] regRD2_I,
    input [31:0] imm32_I,
    input [31:0] PCAdd8_I,
    input [31:0] PC_I,

    input memWrite_I,
    input [1:0] EXBackSel_I,
    input [1:0] MEMBackSel_I,
    input [1:0] WBBackSel_I,
    input ALUSrcASel_I,
    input ALUSrcBSel_I,
    input [3:0] ALUCtrl_I,
    input [2:0] DMCtrl_I,
    input [2:0] Tnew_I,

    output reg [4:0] shamt_O,
    output reg [4:0] regA1_O,
    output reg [4:0] regA2_O,
    output reg [4:0] regA3_O,
    output reg [31:0] regRD1_O,
    output reg [31:0] regRD2_O,
    output reg [31:0] imm32_O,
    output reg [31:0] PCAdd8_O,
    output reg [31:0] PC_O,

    output reg memWrite_O,
    output reg [1:0] EXBackSel_O,
    output reg [1:0] MEMBackSel_O,
    output reg [1:0] WBBackSel_O,
    output reg ALUSrcASel_O,
    output reg ALUSrcBSel_O,
    output reg [3:0] ALUCtrl_O,
    output reg [2:0] DMCtrl_O,
    output reg [2:0] Tnew_O
);

	always @(posedge clk)
		if (reset) begin
			shamt_O     <= 5'b0;
            regA1_O     <= 5'b0;
            regA2_O     <= 5'b0;
			regA3_O     <= 5'b0;
			regRD1_O    <= 32'b0;
			regRD2_O    <= 32'b0;
			imm32_O     <= 32'b0;
			PCAdd8_O    <= 32'b0;
            PC_O        <= 32'b0;

            memWrite_O      <= 1'b0;
            EXBackSel_O     <= 2'b0;
            MEMBackSel_O    <= 2'b0;
            WBBackSel_O     <= 2'b0;
            ALUSrcASel_O    <= 1'b0;
            ALUSrcBSel_O    <= 1'b0;
            ALUCtrl_O       <= 4'b0;
            DMCtrl_O        <= 3'b0;
            Tnew_O          <= 3'b0;
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

            memWrite_O      <= memWrite_I;
            EXBackSel_O     <= EXBackSel_I;
            MEMBackSel_O    <= MEMBackSel_I;
            WBBackSel_O     <= WBBackSel_I;
            ALUSrcASel_O    <= ALUSrcASel_I;
            ALUSrcBSel_O    <= ALUSrcBSel_I;
            ALUCtrl_O       <= ALUCtrl_I;
            DMCtrl_O        <= DMCtrl_I;
            Tnew_O          <= Tnew_I;
        end

endmodule

////// EX_MEM ////////////////////////////////////////////////////////
module EX_MEM(
    input clk,
    input reset,
    input WE,

    input [4:0] regA2_I,
    input [4:0] regA3_I,
    input [31:0] ALUResult_I,
    input [31:0] regRD2_I,
    input [31:0] PCAdd8_I,
    input [31:0] PC_I,

    input memWrite_I,
    input [1:0] MEMBackSel_I,
    input [1:0] WBBackSel_I,
    input [2:0] DMCtrl_I,
    input [2:0] Tnew_I,

    output reg [4:0] regA2_O,
    output reg [4:0] regA3_O,
    output reg [31:0] ALUResult_O,
    output reg [31:0] regRD2_O,
    output reg [31:0] PCAdd8_O,
    output reg [31:0] PC_O,

    output reg memWrite_O,
    output reg [1:0] MEMBackSel_O,
    output reg [1:0] WBBackSel_O,
    output reg [2:0] DMCtrl_O,
    output reg [2:0] Tnew_O
);

    always @(posedge clk)
        if (reset) begin
            regA2_O     <= 5'b0;
            regA3_O     <= 5'b0;
            ALUResult_O <= 32'b0;
            regRD2_O    <= 32'b0;
            PCAdd8_O    <= 32'b0;
            PC_O        <= 32'b0;

            memWrite_O      <= 1'b0;
            MEMBackSel_O    <= 2'b0;
            WBBackSel_O     <= 2'b0;
            DMCtrl_O        <= 3'b0;
            Tnew_O          <= 3'b0;
        end else if (WE) begin
            regA2_O     <= regA2_I;
            regA3_O     <= regA3_I;
            ALUResult_O <= ALUResult_I;
            regRD2_O    <= regRD2_I;
            PCAdd8_O    <= PCAdd8_I;
            PC_O        <= PC_I;

            memWrite_O      <= memWrite_I;
            MEMBackSel_O    <= MEMBackSel_I;
            WBBackSel_O     <= WBBackSel_I;
            DMCtrl_O        <= DMCtrl_I;
            Tnew_O          <= (Tnew_I == 3'b0) ? 3'b0 : Tnew_I - 1;
        end

endmodule

////// MEM_WB ////////////////////////////////////////////////
module MEM_WB(
    input clk,
    input reset,
    input WE,

    input [4:0] regA3_I,
    input [31:0] ALUResult_I,
    input [31:0] memRD_I,
    input [31:0] PCAdd8_I,
    input [31:0] PC_I,

    input [1:0] WBBackSel_I,
    input [2:0] Tnew_I,
    
    output reg [4:0] regA3_O,
    output reg [31:0] ALUResult_O,
    output reg [31:0] memRD_O,
    output reg [31:0] PCAdd8_O,
    output reg [31:0] PC_O,

    output reg [1:0] WBBackSel_O,
    output reg [2:0] Tnew_O
);

    always @(posedge clk)
        if (reset) begin
            regA3_O     <= 5'b0;
            ALUResult_O <= 32'b0;
            memRD_O     <= 32'b0;
            PCAdd8_O    <= 32'b0;
            PC_O        <= 32'b0;

            WBBackSel_O <= 2'b0;
            Tnew_O      <= 3'b0;
        end else if (WE) begin
            regA3_O     <= regA3_I;
            ALUResult_O <= ALUResult_I;
            memRD_O     <= memRD_I;
            PCAdd8_O    <= PCAdd8_I;
            PC_O        <= PC_I;

            WBBackSel_O <= WBBackSel_I;
            Tnew_O      <= (Tnew_I == 3'b0) ? 3'b0 : Tnew_I - 1;
        end

endmodule