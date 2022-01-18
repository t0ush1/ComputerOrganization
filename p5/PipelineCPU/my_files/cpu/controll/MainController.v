`timescale 1ns / 1ps

`include "../macros.v"

module MainController (
    input [31:0] instr,
    input flag,
    output memWrite,
    output [1:0] regAddrSel,
    output [1:0] EXBackSel,
    output [1:0] MEMBackSel,
    output [1:0] WBBackSel,
    output ALUSrcASel,
    output ALUSrcBSel,
    output [3:0] ALUCtrl,
    output [3:0] CMPCtrl,
    output [2:0] EXTCtrl,
    output [2:0] NPCCtrl,
    output [2:0] DMCtrl,
    output [2:0] Tnew,
    output [2:0] Tuse_A1,
    output [2:0] Tuse_A2
);
    
    wire [5:0] op;
    wire [5:0] funct;
    wire [5:0] rt;
    assign op    = instr[31:26];
    assign funct = instr[5:0];
    assign rt    = instr[20:16];
                                    //bitwise   1            2          2           2                   2                 1               1             4         4        3               3                             3      3       3       3        
    assign                                  { memWrite, regAddrSel, EXBackSel    , MEMBackSel       , WBBackSel       , ALUSrcASel    , ALUSrcBSel    , ALUCtrl, CMPCtrl, EXTCtrl      , NPCCtrl                    , DMCtrl , Tnew, Tuse_A1, Tuse_A2 } = 
            (op == `ori  ) ?                { 1'b0    ,`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_or , 4'b0   ,`EXT_zero     ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `lw   ) ?                { 1'b0    ,`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_memRD    ,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_add, 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`DM_word, 3'd2, 3'd1   , 3'd5    } :
            (op == `sw   ) ?                { 1'b1    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            ,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_add, 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`DM_word, 3'd0, 3'd1   , 3'd2    } :
            (op == `beq  ) ?                { 1'b0    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            , 1'b0          , 1'b0          , 4'b0   ,`CMP_eq ,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4), 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            (op == `lui  ) ?                { 1'b0    ,`regAddr_rt,`EXBack_imm32 ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_or , 4'b0   ,`EXT_loadUpper,`NPC_add4                   , 3'b0   , 3'd0, 3'd5   , 3'd5    } :
            (op == `j    ) ?                { 1'b0    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            , 1'b0          , 1'b0          , 4'b0   , 4'b0   , 3'b0         ,`NPC_index                  , 3'b0   , 3'd0, 3'd5   , 3'd5    } :
            (op == `jal  ) ?                { 1'b0    ,`regAddr_31,`EXBack_PCAdd8,`MEMBack_PCAdd8   ,`WBBack_PCAdd8   , 1'b0          , 1'b0          , 4'b0   , 4'b0   , 3'b0         ,`NPC_index                  , 3'b0   , 3'd0, 3'd5   , 3'd5    } :
            (op == `addi ) ?                { 1'b0    ,`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_add, 4'b0   ,`EXT_sign     ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `addiu) ?                { 1'b0    ,`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_add, 4'b0   ,`EXT_sign     ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `slti ) ?                { 1'b0    ,`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_lt , 4'b0   ,`EXT_sign     ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `bgtz ) ?                { 1'b0    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            , 1'b0          , 1'b0          , 4'b0   ,`CMP_gt ,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4), 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            (op == `blez ) ?                { 1'b0    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            , 1'b0          , 1'b0          , 4'b0   ,`CMP_le ,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4), 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            (op == `bne  ) ?                { 1'b0    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            , 1'b0          , 1'b0          , 4'b0   ,`CMP_ne ,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4), 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            (op == `lh   ) ?                { 1'b0    ,`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_memRD    ,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_add, 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`DM_hfwd, 3'd2, 3'd1   , 3'd5    } :
            (op == `lhu  ) ?                { 1'b0    ,`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_memRD    ,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_add, 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`DM_ushw, 3'd2, 3'd1   , 3'd5    } :
            (op == `lb   ) ?                { 1'b0    ,`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_memRD    ,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_add, 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`DM_byte, 3'd2, 3'd1   , 3'd5    } :
            (op == `lbu  ) ?                { 1'b0    ,`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_memRD    ,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_add, 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`DM_usbt, 3'd2, 3'd1   , 3'd5    } :
            (op == `sh   ) ?                { 1'b1    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            ,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_add, 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`DM_hfwd, 3'd0, 3'd1   , 3'd2    } :
            (op == `sb   ) ?                { 1'b1    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            ,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_add, 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`DM_byte, 3'd0, 3'd1   , 3'd2    } :
            (op == `andi ) ?                { 1'b0    ,`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_and, 4'b0   ,`EXT_zero     ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `sltiu) ?                { 1'b0    ,`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_ltu, 4'b0   ,`EXT_sign     ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `xori ) ?                { 1'b0    ,`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 ,`ALU_xor, 4'b0   ,`EXT_zero     ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd5    } :

            (op == `R && funct == `addu ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_add, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `subu ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_sub, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `jr   ) ? { 1'b0    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            , 1'b0          , 1'b0          , 4'b0   , 4'b0   , 3'b0         ,`NPC_reg                    , 3'b0   , 3'd0, 3'd0   , 3'd5    } :
            (op == `R && funct == `sll  ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_shamt ,`ALUSrcB_regRD2,`ALU_sll, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd5   , 3'd1    } :
            (op == `R && funct == `add  ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_add, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `jalr ) ? { 1'b0    ,`regAddr_rd,`EXBack_PCAdd8,`MEMBack_PCAdd8   ,`WBBack_PCAdd8   , 1'b0          , 1'b0          , 4'b0   , 4'b0   , 3'b0         ,`NPC_reg                    , 3'b0   , 3'd0, 3'd0   , 3'd5    } :
            (op == `R && funct == `_and ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_and, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `_nor ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_nor, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `sllv ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_sll, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `slt  ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_lt , 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `sltu ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_ltu, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `srav ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_sra, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `srlv ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_srl, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `_xor ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_xor, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `sub  ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_sub, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `_or  ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2,`ALU_or , 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `srl  ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_shamt ,`ALUSrcB_regRD2,`ALU_srl, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd5   , 3'd1    } :
            (op == `R && funct == `sra  ) ? { 1'b0    ,`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_shamt ,`ALUSrcB_regRD2,`ALU_sra, 4'b0   , 3'b0         ,`NPC_add4                   , 3'b0   , 3'd1, 3'd5   , 3'd1    } :

            (op == `SPC1 && rt == `bgez ) ? { 1'b0    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            , 1'b0          , 1'b0          , 4'b0   ,`CMP_gez,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4), 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            (op == `SPC1 && rt == `bltz ) ? { 1'b0    ,`regAddr_0 , 2'b0         , 2'b0             , 2'b0            , 1'b0          , 1'b0          , 4'b0   ,`CMP_ltz,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4), 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            37'b0;

endmodule