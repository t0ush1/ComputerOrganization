// ALUCtrl
`define ALU_and 	4'b0000
`define ALU_or		4'b0001
`define ALU_add 	4'b0010
`define ALU_sub 	4'b0011
`define ALU_xor 	4'b0100
`define ALU_sll		4'b0101
`define ALU_srl     4'b0110
`define ALU_lt      4'b0111
`define ALU_ltu     4'b1000
`define ALU_sra     4'b1001
`define ALU_nor     4'b1010
`define ALU_slc     4'b1011
`define ALU_src     4'b1100

// MDUCtrl
`define MDU_none    4'b0000
`define MDU_mult    4'b0001
`define MDU_multu   4'b0010
`define MDU_div     4'b0011
`define MDU_divu    4'b0100
`define MDU_mthi    4'b0101
`define MDU_mtlo    4'b0110

// MDUState
`define MDUState_begin      2'b00
`define MDUState_mulDelay   2'b01
`define MDUState_divDelay   2'b10

// CMPCtrl
`define CMP_lt  4'b0000
`define CMP_gt  4'b0001
`define CMP_le  4'b0010
`define CMP_ge  4'b0011
`define CMP_eq  4'b0100
`define CMP_ne  4'b0101
`define CMP_ltz 4'b0110
`define CMP_gez 4'b0111

// EXTCtrl
`define EXT_zero		3'b000
`define EXT_sign		3'b001
`define EXT_loadUpper	3'b010
`define EXT_brOffset	3'b011

// NPCCtrl
`define NPC_add4    3'b000
`define NPC_offset 	3'b001
`define NPC_index 	3'b010
`define NPC_reg		3'b011

// BECtrl
`define BE_none     3'b000
`define BE_word 	3'b001
`define BE_hfwd 	3'b010
`define BE_byte 	3'b011

// DECtrl
`define DE_word 	3'b000
`define DE_hfwd 	3'b001
`define DE_byte 	3'b010
`define DE_ushw 	3'b011
`define DE_usbt		3'b100

// regAddrMUX
`define regAddr_rt  2'b00
`define regAddr_rd  2'b01
`define regAddr_31  2'b10
`define regAddr_0   2'b11

// ALUSrcAMUX
`define ALUSrcA_regRD1  1'b0
`define ALUSrcA_shamt   1'b1

// ALUSrcBMUX
`define ALUSrcB_regRD2  1'b0
`define ALUSrcB_imm32   1'b1

// MDUResultMUX
`define MDUResult_HI    1'b0
`define MDUResult_LO    1'b1

// EXBackMUX
`define EXBack_imm32       2'b00
`define EXBack_PCAdd8      2'b01

// MEMBackMUX
`define MEMBack_ALUResult   2'b00
`define MEMBack_PCAdd8      2'b01
`define MEMBack_MDUResult   2'b10

// WBBackMUX
`define WBBack_ALUResult   3'b000
`define WBBack_memRD       3'b001
`define WBBack_PCAdd8      3'b010
`define WBBack_MDUResult   3'b011
`define WBBack_CP0RD       3'b100

// forward_D_MUX
`define forward_D_orig      2'b00
`define forward_D_EXBack    2'b01
`define forward_D_MEMBack   2'b10

// forward_E_MUX
`define forward_E_orig      2'b00
`define forward_E_MEMBack   2'b01
`define forward_E_WBBack    2'b10

// forward_M_MUX
`define forward_M_orig      1'b0
`define forward_M_WBBack    1'b1

// ins
`define R     6'b000000
`define SPC1  6'b000001
`define SPC2  6'b010000

`define and   6'b100100
`define or    6'b100101
`define nor   6'b100111
`define xor   6'b100110
`define addu  6'b100001
`define add   6'b100000
`define subu  6'b100011
`define sub   6'b100010
`define slt   6'b101010
`define sltu  6'b101011
`define sllv  6'b000100
`define srlv  6'b000110
`define srav  6'b000111

`define andi  6'b001100
`define ori   6'b001101
`define xori  6'b001110
`define addiu 6'b001001
`define addi  6'b001000
`define slti  6'b001010
`define sltiu 6'b001011
`define lui   6'b001111

`define sll   6'b000000
`define srl   6'b000010
`define sra   6'b000011

`define beq   6'b000100
`define bgtz  6'b000111
`define blez  6'b000110
`define bne   6'b000101
`define bgez  5'b00001
`define bltz  5'b00000

`define j     6'b000010
`define jal   6'b000011
`define jr    6'b001000
`define jalr  6'b001001

`define lw    6'b100011
`define lh    6'b100001
`define lhu   6'b100101
`define lb    6'b100000
`define lbu   6'b100100

`define sw    6'b101011
`define sh    6'b101001
`define sb    6'b101000

`define mult  6'b011000
`define multu 6'b011001
`define div   6'b011010
`define divu  6'b011011

`define mthi  6'b010001
`define mtlo  6'b010011

`define mfhi  6'b010000
`define mflo  6'b010010

`define mfc0  5'b00000
`define mtc0  5'b00100
`define eret  6'b011000

// CP0
`define IM SR[15:10]
`define EXL SR[1]
`define IE SR[0]
`define BD Cause[31]
`define IP Cause[15:10]
`define ExcCode Cause[6:2]

`define CP0Addr_SR 5'd12
`define CP0Addr_Cause 5'd13
`define CP0Addr_EPC 5'd14
`define CP0Addr_PrID 5'd15

// EXC
`define EXC_None 5'd0
`define EXC_AdEL 5'd4
`define EXC_AdES 5'd5
`define EXC_RI   5'd10
`define EXC_Ov   5'd12

// address
`define Instr_Base_Addr  32'h3000
`define Instr_Limit_Addr 32'h6fff
`define Data_Base_Addr   32'h0000
`define Data_Limit_Addr  32'h2fff
`define Exc_Handler_Addr 32'h4180
`define TC1_Base_Addr    32'h7f00
`define TC1_Limit_Addr   32'h7f0b
`define TC2_Base_Addr    32'h7f10
`define TC2_Limit_Addr   32'h7f1b