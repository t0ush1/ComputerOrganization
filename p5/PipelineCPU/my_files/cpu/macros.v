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

// DMCtrl
`define DM_word 	3'b000
`define DM_hfwd 	3'b001
`define DM_byte 	3'b010
`define DM_ushw 	3'b011
`define DM_usbt		3'b100

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

// EXBackMUX
`define EXBack_imm32       2'b00
`define EXBack_PCAdd8      2'b01

// MEMBackMUX
`define MEMBack_ALUResult   2'b00
`define MEMBack_PCAdd8      2'b01

// WBBackMUX
`define WBBack_ALUResult   2'b00
`define WBBack_memRD       2'b01
`define WBBack_PCAdd8      2'b10

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
`define R       6'b000000
`define SPC1    6'b000001
`define ori     6'b001101
`define lw      6'b100011
`define sw      6'b101011
`define beq     6'b000100
`define lui     6'b001111
`define j       6'b000010
`define jal     6'b000011
`define addi    6'b001000
`define addiu   6'b001001
`define slti    6'b001010
`define bgtz    6'b000111
`define blez    6'b000110
`define bne     6'b000101
`define lh      6'b100001
`define lhu     6'b100101
`define lb      6'b100000
`define lbu     6'b100100
`define sh      6'b101001
`define sb      6'b101000
`define andi    6'b001100
`define sltiu   6'b001011
`define xori    6'b001110

`define addu    6'b100001
`define subu    6'b100011
`define jr      6'b001000
`define sll     6'b000000
`define add     6'b100000
`define jalr    6'b001001
`define _and    6'b100100
`define _nor    6'b100111
`define sllv    6'b000100
`define slt     6'b101010
`define sltu    6'b101011
`define srav    6'b000111
`define srlv    6'b000110
`define _xor    6'b100110
`define sub     6'b100010
`define _or     6'b100101
`define srl     6'b000010
`define sra     6'b000011

`define bgez    5'b00001
`define bltz    5'b00000