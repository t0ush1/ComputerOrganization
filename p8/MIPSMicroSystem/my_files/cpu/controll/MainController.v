`timescale 1ns / 1ps

`include "../macros.v"

module MainController (
    input [31:0] instr,
    input flag,

    output [1:0] regAddrSel,
    output [1:0] EXBackSel,
    output [1:0] MEMBackSel,
    output [2:0] WBBackSel,
    output ALUSrcASel,
    output ALUSrcBSel,
    output MDUResultSel,
    output start,
    output [3:0] ALUCtrl,
    output [3:0] MDUCtrl,
    output [3:0] CMPCtrl,
    output [2:0] EXTCtrl,
    output [2:0] NPCCtrl,
    output [2:0] BECtrl,
    output [2:0] DECtrl,
    output [2:0] Tnew,
    output clrBrDelay,

    output [2:0] Tuse_A1,
    output [2:0] Tuse_A2,
    output md,
    output mt,
    output mf,

    output excRI,
    output calOv,
    output load,
    output store,
    output eret,
    output CP0Write,
    output BD
);
    
    wire [5:0] op;
    wire [5:0] funct;
    wire [4:0] rt;
    wire [4:0] rs;
    assign op    = instr[31:26];
    assign funct = instr[5:0];
    assign rt    = instr[20:16];
    assign rs    = instr[25:21];

    assign clrBrDelay = 1'b0;
    assign md = op == `R && (funct == `mult || funct == `multu || funct == `div || funct == `divu);
    assign mt = op == `R && (funct == `mthi || funct == `mtlo);
    assign mf = op == `R && (funct == `mfhi || funct == `mflo);

    assign excRI = Tuse_A2 == 3'd7;
    assign calOv = (op == `R && funct == `add) || (op == `R && funct == `sub) || (op == `addi);
    assign load = (op == `lw) || (op == `lh) || (op == `lhu) || (op == `lb) || (op == `lbu);
    assign store = (op == `sw) || (op == `sh) || (op == `sb);
    assign eret = (op == `SPC2 && funct == `eret);
    assign CP0Write = (op == `SPC2 && rs == `mtc0);
    
    wire branch;
    wire jump;
    assign branch = (op == `beq) || (op == `bgtz) || (op == `blez) || (op == `bne) || (op == `SPC1 && rt == `bgez) || (op == `SPC1 && rt == `bltz);
    assign jump = (op == `j) || (op == `jal) || (op == `R && funct == `jr) || (op == `R && funct == `jalr);
    assign BD = branch | jump;

                                    //bitwise     2          2              2                   3                 1               1                1          1       4        4         4        3               3                            3       3       3       3        3        
    assign                                  { regAddrSel, EXBackSel    , MEMBackSel       , WBBackSel       , ALUSrcASel    , ALUSrcBSel    , MDUResultSel, start, ALUCtrl, MDUCtrl  , CMPCtrl, EXTCtrl      , NPCCtrl                    , BECtrl , DECtrl , Tnew, Tuse_A1, Tuse_A2 } = 
            (op == `R && funct == `and  ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_and,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `or   ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_or ,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `nor  ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_nor,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `xor  ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_xor,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `addu ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `add  ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `subu ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_sub,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `sub  ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_sub,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `slt  ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_lt ,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `sltu ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_ltu,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `sllv ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_sll,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `srlv ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_srl,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :
            (op == `R && funct == `srav ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_sra,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd1    } :

            (op == `andi ) ?                {`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_and,`MDU_none , 4'b0   ,`EXT_zero     ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `ori  ) ?                {`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_or ,`MDU_none , 4'b0   ,`EXT_zero     ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `xori ) ?                {`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_xor,`MDU_none , 4'b0   ,`EXT_zero     ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `addiu) ?                {`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `addi ) ?                {`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `slti ) ?                {`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_lt ,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `sltiu) ?                {`regAddr_rt, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_ltu,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd1   , 3'd5    } :
            (op == `lui  ) ?                {`regAddr_rt,`EXBack_imm32 ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_or ,`MDU_none , 4'b0   ,`EXT_loadUpper,`NPC_add4                   ,`BE_none, 3'b0   , 3'd0, 3'd5   , 3'd5    } :

            (op == `R && funct == `sll  ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_shamt ,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_sll,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd5   , 3'd1    } :
            (op == `R && funct == `srl  ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_shamt ,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_srl,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd5   , 3'd1    } :
            (op == `R && funct == `sra  ) ? {`regAddr_rd, 2'b0         ,`MEMBack_ALUResult,`WBBack_ALUResult,`ALUSrcA_shamt ,`ALUSrcB_regRD2, 1'b0        , 1'b0 ,`ALU_sra,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd5   , 3'd1    } :

            (op == `beq  ) ?                {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none ,`CMP_eq ,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4),`BE_none, 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            (op == `bgtz ) ?                {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none ,`CMP_gt ,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4),`BE_none, 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            (op == `blez ) ?                {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none ,`CMP_le ,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4),`BE_none, 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            (op == `bne  ) ?                {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none ,`CMP_ne ,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4),`BE_none, 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            (op == `SPC1 && rt == `bgez ) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none ,`CMP_gez,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4),`BE_none, 3'b0   , 3'd0, 3'd0   , 3'd0    } :
            (op == `SPC1 && rt == `bltz ) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none ,`CMP_ltz,`EXT_brOffset ,(flag?`NPC_offset:`NPC_add4),`BE_none, 3'b0   , 3'd0, 3'd0   , 3'd0    } :

            (op == `j    ) ?                {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none , 4'b0   , 3'b0         ,`NPC_index                  ,`BE_none, 3'b0   , 3'd0, 3'd5   , 3'd5    } :
            (op == `jal  ) ?                {`regAddr_31,`EXBack_PCAdd8,`MEMBack_PCAdd8   ,`WBBack_PCAdd8   , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none , 4'b0   , 3'b0         ,`NPC_index                  ,`BE_none, 3'b0   , 3'd0, 3'd5   , 3'd5    } :
            (op == `R && funct == `jr   ) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none , 4'b0   , 3'b0         ,`NPC_reg                    ,`BE_none, 3'b0   , 3'd0, 3'd0   , 3'd5    } :
            (op == `R && funct == `jalr ) ? {`regAddr_rd,`EXBack_PCAdd8,`MEMBack_PCAdd8   ,`WBBack_PCAdd8   , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none , 4'b0   , 3'b0         ,`NPC_reg                    ,`BE_none, 3'b0   , 3'd0, 3'd0   , 3'd5    } :

            (op == `lw   ) ?                {`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_memRD    ,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_none,`DE_word, 3'd2, 3'd1   , 3'd5    } :
            (op == `lh   ) ?                {`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_memRD    ,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_none,`DE_hfwd, 3'd2, 3'd1   , 3'd5    } :
            (op == `lhu  ) ?                {`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_memRD    ,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_none,`DE_ushw, 3'd2, 3'd1   , 3'd5    } :
            (op == `lb   ) ?                {`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_memRD    ,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_none,`DE_byte, 3'd2, 3'd1   , 3'd5    } :
            (op == `lbu  ) ?                {`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_memRD    ,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_none,`DE_usbt, 3'd2, 3'd1   , 3'd5    } :

            (op == `sw   ) ?                {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            ,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_word, 3'b0   , 3'd0, 3'd1   , 3'd2    } :
            (op == `sh   ) ?                {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            ,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_hfwd, 3'b0   , 3'd0, 3'd1   , 3'd2    } :
            (op == `sb   ) ?                {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            ,`ALUSrcA_regRD1,`ALUSrcB_imm32 , 1'b0        , 1'b0 ,`ALU_add,`MDU_none , 4'b0   ,`EXT_sign     ,`NPC_add4                   ,`BE_byte, 3'b0   , 3'd0, 3'd1   , 3'd2    } :

            (op == `R && funct == `mult ) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b1 , 4'b0   ,`MDU_mult , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd0, 3'd1   , 3'd1    } :
            (op == `R && funct == `multu) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b1 , 4'b0   ,`MDU_multu, 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd0, 3'd1   , 3'd1    } :
            (op == `R && funct == `div  ) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b1 , 4'b0   ,`MDU_div  , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd0, 3'd1   , 3'd1    } :
            (op == `R && funct == `divu ) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b1 , 4'b0   ,`MDU_divu , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd0, 3'd1   , 3'd1    } :

            (op == `R && funct == `mthi ) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_mthi , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd0, 3'd1   , 3'd5    } :
            (op == `R && funct == `mtlo ) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_mtlo , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd0, 3'd1   , 3'd5    } :

            (op == `R && funct == `mfhi ) ? {`regAddr_rd, 2'b0         ,`MEMBack_MDUResult,`WBBack_MDUResult, 1'b0          , 1'b0          ,`MDUResult_HI, 1'b0 , 4'b0   ,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd5   , 3'd5    } :
            (op == `R && funct == `mflo ) ? {`regAddr_rd, 2'b0         ,`MEMBack_MDUResult,`WBBack_MDUResult, 1'b0          , 1'b0          ,`MDUResult_LO, 1'b0 , 4'b0   ,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd1, 3'd5   , 3'd5    } :

            (op == `SPC2 && rs == `mfc0 ) ? {`regAddr_rt, 2'b0         , 2'b0             ,`WBBack_CP0RD    , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd2, 3'd5   , 3'd5    } :
            (op == `SPC2 && rs == `mtc0 ) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd0, 3'd5   , 3'd2    } :
            (op == `SPC2 && funct==`eret) ? {`regAddr_0 , 2'b0         , 2'b0             , 3'b0            , 1'b0          , 1'b0          , 1'b0        , 1'b0 , 4'b0   ,`MDU_none , 4'b0   , 3'b0         ,`NPC_add4                   ,`BE_none, 3'b0   , 3'd0, 3'd5   , 3'd5    } :
            { 43'b0, 3'd7 }; //use Tuse_A2 bits to gnrt excRI

endmodule