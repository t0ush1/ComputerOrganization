ori $1, $0, 3
ori $2, $0, 1
ori $3, $0, 0
ori $4, $0, 3
sw $1, 0($0)
sw $3, 4($0)
sw $4, 8($0)
sw $3, 12($0)
sw $3, 16($0)
sw $2, 20($0)
sw $2, 24($0)
sw $2, 28($0)
sw $3, 32($0)
sw $2, 36($0)
sw $4, 40($0)
sw $1, 44($0)
sw $1, 48($0)
sw $4, 52($0)
sw $2, 56($0)
sw $1, 60($0)
sw $4, 64($0)
sw $3, 68($0)
sw $4, 72($0)
sw $3, 76($0)
sw $4, 80($0)
sw $1, 84($0)
sw $4, 88($0)
sw $4, 92($0)
sw $3, 96($0)
sw $2, 100($0)
sw $4, 104($0)
sw $1, 108($0)
sw $4, 112($0)
sw $2, 116($0)
sw $1, 120($0)
sw $3, 124($0)
mflo $4
mult $2, $4
sb $2, 0($2)
sb $4, 0($2)
TAG1:
beq $4, $4, TAG2
mflo $2
blez $2, TAG2
sb $4, 0($4)
TAG2:
lw $2, 0($2)
mtlo $2
mthi $2
lui $3, 6
TAG3:
bne $3, $3, TAG4
mult $3, $3
bltz $3, TAG4
mflo $4
TAG4:
bne $4, $4, TAG5
mtlo $4
mfhi $2
beq $2, $2, TAG5
TAG5:
sltiu $4, $2, 6
sltu $3, $2, $2
lhu $4, 0($2)
beq $3, $4, TAG6
TAG6:
sb $4, 0($4)
bne $4, $4, TAG7
div $4, $4
sb $4, 0($4)
TAG7:
lb $4, 0($4)
mflo $4
lui $4, 1
multu $4, $4
TAG8:
sll $1, $4, 8
sltu $2, $4, $1
mfhi $4
lui $3, 14
TAG9:
mult $3, $3
mtlo $3
sll $0, $0, 0
sll $0, $0, 0
TAG10:
mflo $4
addu $1, $3, $4
or $1, $4, $4
srav $3, $3, $1
TAG11:
sll $0, $0, 0
lui $3, 4
mflo $4
bltz $2, TAG12
TAG12:
sll $0, $0, 0
bgez $4, TAG13
srlv $3, $4, $4
lui $3, 1
TAG13:
ori $3, $3, 11
sll $0, $0, 0
bgez $3, TAG14
lui $1, 1
TAG14:
srl $3, $1, 5
lui $3, 10
lui $2, 8
sll $0, $0, 0
TAG15:
bgez $3, TAG16
sltu $2, $3, $3
blez $2, TAG16
sb $2, 0($3)
TAG16:
ori $2, $2, 0
mflo $4
srav $2, $2, $4
sh $4, 0($2)
TAG17:
mthi $2
multu $2, $2
beq $2, $2, TAG18
mthi $2
TAG18:
lh $1, 0($2)
mfhi $1
lui $2, 12
sll $0, $0, 0
TAG19:
bgtz $3, TAG20
srl $3, $3, 4
mult $3, $3
lw $1, 0($3)
TAG20:
sb $1, 0($1)
blez $1, TAG21
mult $1, $1
blez $1, TAG21
TAG21:
sub $1, $1, $1
mflo $2
sll $1, $1, 9
blez $2, TAG22
TAG22:
sw $1, 0($1)
lb $1, 0($1)
mult $1, $1
bltz $1, TAG23
TAG23:
mtlo $1
sra $1, $1, 1
bgtz $1, TAG24
sb $1, 0($1)
TAG24:
lbu $1, 0($1)
lui $1, 2
mthi $1
mthi $1
TAG25:
lui $4, 9
bltz $1, TAG26
mfhi $1
mthi $4
TAG26:
or $4, $1, $1
sll $0, $0, 0
sll $0, $0, 0
sltu $1, $1, $1
TAG27:
multu $1, $1
lui $1, 11
mult $1, $1
sll $0, $0, 0
TAG28:
bne $2, $2, TAG29
mtlo $2
mtlo $2
mthi $2
TAG29:
sra $4, $2, 8
xori $2, $4, 6
xori $2, $4, 4
mthi $2
TAG30:
lui $1, 13
lbu $1, 0($2)
bgtz $1, TAG31
mthi $1
TAG31:
sub $2, $1, $1
mtlo $2
lbu $4, 0($2)
bgtz $1, TAG32
TAG32:
lw $1, 0($4)
lui $1, 3
beq $4, $1, TAG33
slt $2, $1, $1
TAG33:
bltz $2, TAG34
mthi $2
bgez $2, TAG34
sll $3, $2, 0
TAG34:
beq $3, $3, TAG35
slti $3, $3, 7
mtlo $3
beq $3, $3, TAG35
TAG35:
addiu $4, $3, 13
lhu $3, 0($4)
andi $1, $3, 4
sb $1, 0($3)
TAG36:
bgtz $1, TAG37
mfhi $4
lb $3, 0($4)
bgez $3, TAG37
TAG37:
mult $3, $3
lhu $1, 0($3)
xor $1, $3, $1
beq $1, $3, TAG38
TAG38:
lh $3, 0($1)
mtlo $1
mult $1, $3
bgez $3, TAG39
TAG39:
addi $4, $3, 13
divu $3, $4
multu $3, $4
lui $1, 14
TAG40:
addiu $3, $1, 4
lui $4, 5
sll $0, $0, 0
sll $0, $0, 0
TAG41:
addu $2, $4, $4
sll $0, $0, 0
sll $0, $0, 0
bne $1, $4, TAG42
TAG42:
sll $0, $0, 0
multu $3, $3
mtlo $1
sll $0, $0, 0
TAG43:
lui $4, 6
mfhi $2
beq $4, $4, TAG44
addiu $2, $4, 12
TAG44:
lui $2, 11
blez $2, TAG45
mfhi $3
bne $2, $3, TAG45
TAG45:
sb $3, -196($3)
addiu $3, $3, 14
lb $2, -210($3)
mtlo $3
TAG46:
slti $1, $2, 2
nor $1, $1, $1
mthi $1
lui $2, 2
TAG47:
sll $2, $2, 3
mthi $2
lui $1, 3
mtlo $2
TAG48:
sll $0, $0, 0
mfhi $1
lui $2, 7
sll $0, $0, 0
TAG49:
div $4, $4
blez $4, TAG50
divu $4, $4
bne $4, $4, TAG50
TAG50:
lui $3, 13
blez $3, TAG51
nor $1, $3, $3
mtlo $1
TAG51:
sll $0, $0, 0
addu $4, $1, $1
lui $4, 4
bgez $1, TAG52
TAG52:
lui $2, 1
bne $2, $2, TAG53
mfhi $2
lui $4, 0
TAG53:
multu $4, $4
lui $3, 9
addiu $1, $3, 7
lui $2, 6
TAG54:
sll $0, $0, 0
mtlo $2
bne $2, $2, TAG55
mfhi $1
TAG55:
slti $4, $1, 1
sra $2, $4, 13
lbu $1, 0($2)
lui $4, 0
TAG56:
mult $4, $4
mtlo $4
mult $4, $4
bgtz $4, TAG57
TAG57:
lui $4, 6
ori $3, $4, 13
sra $4, $4, 13
mthi $4
TAG58:
beq $4, $4, TAG59
or $1, $4, $4
mfhi $2
ori $2, $4, 9
TAG59:
sw $2, 0($2)
mfhi $4
mflo $1
multu $1, $2
TAG60:
subu $4, $1, $1
multu $1, $1
sra $1, $4, 3
addi $2, $1, 11
TAG61:
div $2, $2
lbu $1, 0($2)
bne $2, $2, TAG62
lbu $2, 0($2)
TAG62:
addu $1, $2, $2
beq $2, $2, TAG63
xor $4, $2, $2
mthi $1
TAG63:
addi $4, $4, 11
mthi $4
mthi $4
beq $4, $4, TAG64
TAG64:
sra $3, $4, 15
mthi $3
bne $4, $4, TAG65
mflo $2
TAG65:
sltiu $1, $2, 8
srl $2, $2, 5
lbu $1, 0($1)
mult $1, $1
TAG66:
lb $2, 0($1)
lhu $4, 0($2)
ori $1, $2, 0
beq $2, $2, TAG67
TAG67:
lui $3, 6
andi $3, $1, 6
sw $1, 0($3)
bgez $1, TAG68
TAG68:
mflo $3
mfhi $4
mthi $3
blez $4, TAG69
TAG69:
sb $4, 0($4)
multu $4, $4
mult $4, $4
mult $4, $4
TAG70:
lbu $1, 0($4)
beq $1, $1, TAG71
andi $4, $4, 6
bne $4, $1, TAG71
TAG71:
multu $4, $4
beq $4, $4, TAG72
mthi $4
and $4, $4, $4
TAG72:
mfhi $3
mflo $1
lui $1, 2
lui $3, 3
TAG73:
xori $1, $3, 14
lui $2, 5
lui $3, 11
mflo $3
TAG74:
lh $3, 0($3)
lui $2, 1
mult $2, $2
add $2, $3, $2
TAG75:
lui $1, 14
subu $2, $2, $2
mfhi $1
sh $1, 0($2)
TAG76:
lbu $1, 0($1)
lui $2, 2
sw $1, 0($1)
srl $4, $2, 2
TAG77:
addiu $1, $4, 10
divu $4, $1
bgez $1, TAG78
mflo $4
TAG78:
bne $4, $4, TAG79
lh $1, 0($4)
bgez $1, TAG79
nor $3, $1, $1
TAG79:
or $1, $3, $3
sb $1, 1($3)
mflo $2
sra $2, $3, 10
TAG80:
bgez $2, TAG81
lui $4, 12
mtlo $4
sw $4, 1($2)
TAG81:
bltz $4, TAG82
mflo $2
bgtz $2, TAG82
mfhi $4
TAG82:
sll $0, $0, 0
mflo $2
lui $3, 2
mult $3, $4
TAG83:
sll $0, $0, 0
nor $3, $3, $3
lui $1, 12
xori $4, $1, 9
TAG84:
sll $0, $0, 0
mfhi $3
bne $1, $3, TAG85
xori $2, $3, 0
TAG85:
mflo $1
mult $2, $1
beq $1, $1, TAG86
divu $2, $2
TAG86:
lh $1, 0($1)
addiu $3, $1, 1
lui $3, 9
bltz $1, TAG87
TAG87:
sll $0, $0, 0
addu $3, $3, $3
mthi $3
mfhi $3
TAG88:
beq $3, $3, TAG89
divu $3, $3
sb $3, 0($3)
sltiu $4, $3, 8
TAG89:
beq $4, $4, TAG90
mtlo $4
beq $4, $4, TAG90
or $2, $4, $4
TAG90:
bgez $2, TAG91
xor $4, $2, $2
lui $2, 7
sb $2, 0($4)
TAG91:
subu $2, $2, $2
and $2, $2, $2
bltz $2, TAG92
lui $4, 1
TAG92:
multu $4, $4
lui $1, 15
sll $0, $0, 0
bltz $4, TAG93
TAG93:
ori $4, $1, 3
mflo $2
lui $2, 8
sra $4, $4, 6
TAG94:
mult $4, $4
divu $4, $4
mult $4, $4
mtlo $4
TAG95:
mflo $1
blez $1, TAG96
addu $3, $4, $4
sltiu $3, $3, 10
TAG96:
lbu $3, 0($3)
lh $1, 0($3)
sw $1, 0($3)
addiu $3, $3, 14
TAG97:
mfhi $2
mtlo $2
mtlo $3
xor $4, $3, $2
TAG98:
sh $4, 0($4)
mult $4, $4
subu $3, $4, $4
mfhi $2
TAG99:
lw $2, 0($2)
beq $2, $2, TAG100
mfhi $1
lui $3, 1
TAG100:
blez $3, TAG101
lh $2, 0($3)
lh $1, 0($2)
divu $1, $1
TAG101:
addi $1, $1, 9
bltz $1, TAG102
lbu $2, 0($1)
beq $1, $1, TAG102
TAG102:
mfhi $2
bltz $2, TAG103
lw $1, 0($2)
lb $1, 0($2)
TAG103:
lhu $2, 0($1)
mtlo $2
sb $1, 0($1)
mult $2, $1
TAG104:
lhu $1, 0($2)
mfhi $3
bltz $2, TAG105
mtlo $2
TAG105:
beq $3, $3, TAG106
mult $3, $3
add $4, $3, $3
lbu $4, 0($3)
TAG106:
slti $3, $4, 2
lw $3, 0($3)
blez $4, TAG107
sb $4, 0($3)
TAG107:
beq $3, $3, TAG108
multu $3, $3
lbu $1, 0($3)
and $3, $1, $1
TAG108:
lui $4, 7
blez $4, TAG109
mfhi $1
bne $4, $4, TAG109
TAG109:
lbu $1, 0($1)
lhu $2, 0($1)
sb $2, 0($1)
mult $2, $1
TAG110:
beq $2, $2, TAG111
lb $4, 0($2)
sub $2, $4, $2
sb $2, 0($2)
TAG111:
sb $2, 0($2)
sh $2, 0($2)
lui $3, 7
mthi $3
TAG112:
and $3, $3, $3
mflo $1
mult $1, $3
lui $3, 9
TAG113:
lui $3, 6
multu $3, $3
sll $0, $0, 0
sll $0, $0, 0
TAG114:
mflo $2
mtlo $3
lb $4, 0($2)
lw $1, 0($2)
TAG115:
blez $1, TAG116
lb $1, 0($1)
addiu $1, $1, 0
mthi $1
TAG116:
sh $1, 0($1)
lui $4, 10
sll $0, $0, 0
lui $2, 10
TAG117:
addu $3, $2, $2
sll $0, $0, 0
sll $2, $2, 11
subu $3, $2, $2
TAG118:
blez $3, TAG119
mult $3, $3
lui $2, 4
ori $2, $3, 12
TAG119:
subu $1, $2, $2
sw $1, 0($1)
lui $4, 11
bltz $2, TAG120
TAG120:
lui $4, 12
mthi $4
ori $2, $4, 3
sll $0, $0, 0
TAG121:
addiu $4, $4, 1
sll $0, $0, 0
lui $2, 14
beq $4, $4, TAG122
TAG122:
mflo $3
sllv $1, $2, $2
sll $0, $0, 0
lui $3, 2
TAG123:
mthi $3
bgez $3, TAG124
sll $0, $0, 0
lui $2, 15
TAG124:
bltz $2, TAG125
mfhi $4
mthi $2
divu $4, $2
TAG125:
mthi $4
mult $4, $4
sll $0, $0, 0
mult $4, $4
TAG126:
bgtz $4, TAG127
mfhi $3
multu $4, $4
mtlo $4
TAG127:
bgtz $3, TAG128
lui $1, 11
mult $3, $3
lui $1, 2
TAG128:
mflo $2
mtlo $2
beq $2, $1, TAG129
sll $0, $0, 0
TAG129:
and $4, $2, $2
bgtz $4, TAG130
mult $4, $4
sb $4, 0($4)
TAG130:
multu $4, $4
lui $3, 7
bne $4, $4, TAG131
mflo $3
TAG131:
bgez $3, TAG132
mthi $3
addu $2, $3, $3
bne $3, $3, TAG132
TAG132:
mtlo $2
lw $3, 0($2)
lui $3, 11
lhu $4, 0($2)
TAG133:
mult $4, $4
multu $4, $4
lui $1, 11
mult $1, $4
TAG134:
lui $2, 5
beq $1, $1, TAG135
andi $3, $1, 12
sb $1, 0($1)
TAG135:
srav $4, $3, $3
srav $4, $4, $3
addu $1, $3, $4
add $4, $3, $1
TAG136:
mtlo $4
sllv $3, $4, $4
lh $2, 0($4)
lui $3, 1
TAG137:
addu $1, $3, $3
addu $2, $3, $1
lui $4, 14
subu $1, $1, $4
TAG138:
sll $0, $0, 0
sll $0, $0, 0
sllv $3, $4, $1
or $2, $4, $1
TAG139:
bgtz $2, TAG140
mfhi $2
bgtz $2, TAG140
lui $1, 2
TAG140:
beq $1, $1, TAG141
div $1, $1
mthi $1
beq $1, $1, TAG141
TAG141:
ori $2, $1, 2
divu $2, $1
bltz $1, TAG142
sll $0, $0, 0
TAG142:
addiu $1, $2, 10
bne $2, $1, TAG143
lui $1, 8
subu $2, $2, $1
TAG143:
beq $2, $2, TAG144
slt $4, $2, $2
xori $4, $4, 2
lui $1, 4
TAG144:
sltiu $1, $1, 6
mtlo $1
mult $1, $1
addu $3, $1, $1
TAG145:
bne $3, $3, TAG146
nor $4, $3, $3
mtlo $4
bgtz $4, TAG146
TAG146:
xori $1, $4, 8
divu $1, $4
mtlo $1
mult $4, $4
TAG147:
lui $2, 6
lb $2, 9($1)
mthi $2
sb $2, 9($1)
TAG148:
multu $2, $2
beq $2, $2, TAG149
mtlo $2
mult $2, $2
TAG149:
sw $2, 0($2)
multu $2, $2
bne $2, $2, TAG150
lui $1, 12
TAG150:
mult $1, $1
lui $2, 13
mfhi $3
div $3, $3
TAG151:
multu $3, $3
bne $3, $3, TAG152
divu $3, $3
lui $2, 5
TAG152:
mthi $2
mflo $1
mtlo $1
mfhi $4
TAG153:
subu $1, $4, $4
lb $3, 0($1)
srl $2, $3, 0
blez $2, TAG154
TAG154:
mtlo $2
lbu $2, 0($2)
slti $1, $2, 13
lui $4, 0
TAG155:
beq $4, $4, TAG156
mfhi $2
beq $2, $4, TAG156
lui $4, 8
TAG156:
lui $4, 12
sll $0, $0, 0
sll $0, $0, 0
sll $0, $0, 0
TAG157:
mflo $4
blez $3, TAG158
sll $4, $3, 2
sw $4, 0($4)
TAG158:
mtlo $4
bgtz $4, TAG159
lhu $4, 0($4)
bgez $4, TAG159
TAG159:
srav $3, $4, $4
lb $1, 0($4)
multu $4, $4
lui $4, 2
TAG160:
lui $1, 8
sll $0, $0, 0
sll $0, $0, 0
mfhi $1
TAG161:
bltz $1, TAG162
srav $4, $1, $1
sw $4, 0($4)
lui $4, 0
TAG162:
mthi $4
bne $4, $4, TAG163
lbu $3, 0($4)
sra $4, $4, 11
TAG163:
sll $2, $4, 10
lbu $2, 0($4)
multu $4, $2
bne $2, $2, TAG164
TAG164:
slti $1, $2, 6
bltz $2, TAG165
lui $2, 5
mflo $3
TAG165:
sh $3, 0($3)
mflo $4
ori $2, $4, 10
mflo $3
TAG166:
lhu $4, 0($3)
lui $3, 7
beq $3, $4, TAG167
mflo $3
TAG167:
addiu $2, $3, 7
sb $2, 0($3)
mult $3, $2
mfhi $2
TAG168:
multu $2, $2
lui $2, 0
mtlo $2
mthi $2
TAG169:
lui $3, 6
mult $2, $2
sw $3, 0($2)
beq $3, $3, TAG170
TAG170:
nor $1, $3, $3
addiu $2, $3, 9
blez $1, TAG171
lui $1, 12
TAG171:
bne $1, $1, TAG172
sll $0, $0, 0
sll $0, $0, 0
sll $0, $0, 0
TAG172:
sll $0, $0, 0
bgez $3, TAG173
mfhi $4
bgez $4, TAG173
TAG173:
mflo $4
sllv $2, $4, $4
bne $4, $2, TAG174
slt $1, $4, $4
TAG174:
lui $3, 1
lui $1, 1
mtlo $3
addu $1, $1, $1
TAG175:
bltz $1, TAG176
mflo $2
sll $0, $0, 0
lui $4, 14
TAG176:
beq $4, $4, TAG177
sll $0, $0, 0
multu $4, $4
lui $3, 4
TAG177:
div $3, $3
lui $2, 2
sll $0, $0, 0
xor $1, $2, $3
TAG178:
bne $1, $1, TAG179
divu $1, $1
addiu $2, $1, 9
sll $0, $0, 0
TAG179:
mflo $1
sll $0, $0, 0
bgez $3, TAG180
mfhi $4
TAG180:
blez $4, TAG181
mtlo $4
sltiu $1, $4, 5
bgez $1, TAG181
TAG181:
sb $1, 0($1)
bltz $1, TAG182
mfhi $2
lbu $1, 0($2)
TAG182:
mfhi $2
lui $4, 8
mfhi $2
sll $0, $0, 0
TAG183:
sh $2, 0($2)
mtlo $2
mtlo $2
mfhi $3
TAG184:
beq $3, $3, TAG185
andi $4, $3, 0
bgtz $4, TAG185
mthi $3
TAG185:
bne $4, $4, TAG186
lbu $4, 0($4)
lui $1, 5
addiu $4, $1, 2
TAG186:
sll $0, $0, 0
subu $1, $4, $4
lbu $4, 0($1)
beq $1, $4, TAG187
TAG187:
or $2, $4, $4
addi $2, $2, 3
beq $2, $4, TAG188
mtlo $4
TAG188:
srl $4, $2, 9
mthi $2
srlv $1, $2, $4
mfhi $1
TAG189:
bgez $1, TAG190
andi $3, $1, 3
bne $3, $1, TAG190
mfhi $4
TAG190:
bne $4, $4, TAG191
sb $4, 0($4)
bltz $4, TAG191
and $3, $4, $4
TAG191:
xor $3, $3, $3
bne $3, $3, TAG192
sh $3, 0($3)
ori $1, $3, 8
TAG192:
sb $1, 0($1)
bgez $1, TAG193
sh $1, 0($1)
or $2, $1, $1
TAG193:
multu $2, $2
mtlo $2
mfhi $3
lb $2, 0($2)
TAG194:
add $1, $2, $2
multu $1, $1
addiu $3, $1, 0
mult $1, $2
TAG195:
mfhi $3
mult $3, $3
lui $4, 3
mflo $2
TAG196:
bne $2, $2, TAG197
sltu $3, $2, $2
lui $2, 11
lui $2, 6
TAG197:
sll $4, $2, 11
ori $4, $4, 3
lui $3, 6
andi $2, $2, 10
TAG198:
mfhi $2
sltu $2, $2, $2
mtlo $2
lbu $3, 0($2)
TAG199:
bne $3, $3, TAG200
sh $3, 0($3)
mfhi $4
lh $3, 0($3)
TAG200:
bne $3, $3, TAG201
lbu $1, 0($3)
sll $2, $3, 0
addu $2, $2, $2
TAG201:
sw $2, 0($2)
mtlo $2
mflo $1
subu $1, $2, $1
TAG202:
bgtz $1, TAG203
multu $1, $1
mult $1, $1
beq $1, $1, TAG203
TAG203:
sw $1, 0($1)
addi $4, $1, 6
lbu $1, 0($4)
lb $3, 0($1)
TAG204:
mtlo $3
addiu $4, $3, 12
lui $3, 11
lh $4, 0($4)
TAG205:
mtlo $4
lbu $3, 0($4)
lui $2, 13
multu $4, $4
TAG206:
beq $2, $2, TAG207
sll $0, $0, 0
bgez $2, TAG207
sh $2, 0($2)
TAG207:
mfhi $1
beq $1, $1, TAG208
sw $3, 0($1)
bne $1, $3, TAG208
TAG208:
mtlo $1
sub $1, $1, $1
multu $1, $1
sh $1, 0($1)
TAG209:
lbu $4, 0($1)
bgez $1, TAG210
lb $3, 0($1)
mfhi $1
TAG210:
slt $2, $1, $1
ori $3, $2, 5
bgez $1, TAG211
mthi $2
TAG211:
bne $3, $3, TAG212
or $1, $3, $3
mtlo $1
bgtz $1, TAG212
TAG212:
mfhi $2
sb $1, 0($1)
bne $2, $1, TAG213
mfhi $1
TAG213:
lhu $4, 0($1)
mtlo $1
lbu $2, 0($1)
mfhi $4
TAG214:
mult $4, $4
sh $4, 0($4)
lw $2, 0($4)
bne $4, $2, TAG215
TAG215:
xori $3, $2, 9
mult $3, $2
or $3, $2, $2
lb $4, 0($3)
TAG216:
sltu $1, $4, $4
mthi $1
lui $3, 14
mflo $4
TAG217:
multu $4, $4
slti $1, $4, 9
sll $4, $4, 7
multu $4, $1
TAG218:
bgtz $4, TAG219
lui $3, 5
mthi $3
sh $3, 0($4)
TAG219:
bne $3, $3, TAG220
multu $3, $3
or $4, $3, $3
addu $2, $4, $4
TAG220:
multu $2, $2
lui $2, 6
lui $2, 2
mthi $2
TAG221:
sllv $1, $2, $2
mfhi $2
beq $2, $2, TAG222
lui $1, 9
TAG222:
beq $1, $1, TAG223
mfhi $2
sub $4, $2, $1
mtlo $4
TAG223:
and $2, $4, $4
lui $2, 3
sll $0, $0, 0
bgez $2, TAG224
TAG224:
lui $3, 9
mfhi $4
divu $4, $3
mfhi $1
TAG225:
sltiu $1, $1, 3
lui $1, 5
lui $1, 1
lui $4, 13
TAG226:
lui $2, 5
sll $0, $0, 0
sll $0, $0, 0
lui $1, 12
TAG227:
srl $2, $1, 14
sw $2, 0($2)
sb $2, 0($2)
sll $0, $0, 0
TAG228:
beq $2, $2, TAG229
sltiu $3, $2, 7
mfhi $2
sllv $2, $3, $2
TAG229:
lbu $1, 0($2)
mtlo $2
beq $1, $2, TAG230
mult $2, $1
TAG230:
sb $1, 0($1)
beq $1, $1, TAG231
mtlo $1
lb $1, 0($1)
TAG231:
andi $3, $1, 13
mult $3, $3
sw $1, 0($3)
xori $4, $3, 9
TAG232:
addiu $2, $4, 14
or $3, $2, $4
sb $4, 0($4)
bltz $3, TAG233
TAG233:
mthi $3
lui $4, 1
multu $3, $3
mflo $2
TAG234:
bltz $2, TAG235
sllv $4, $2, $2
lui $2, 15
sllv $1, $4, $2
TAG235:
mthi $1
lui $1, 13
divu $1, $1
blez $1, TAG236
TAG236:
lui $2, 10
lui $1, 3
andi $1, $2, 4
mthi $2
TAG237:
bgtz $1, TAG238
lui $1, 13
mtlo $1
beq $1, $1, TAG238
TAG238:
sll $1, $1, 7
bgtz $1, TAG239
lui $4, 14
blez $1, TAG239
TAG239:
mflo $3
sll $0, $0, 0
mthi $3
beq $3, $4, TAG240
TAG240:
mthi $4
lui $1, 0
bne $1, $1, TAG241
xori $1, $4, 5
TAG241:
bne $1, $1, TAG242
lui $3, 7
bne $1, $3, TAG242
subu $1, $3, $3
TAG242:
mtlo $1
and $4, $1, $1
mthi $4
multu $1, $1
TAG243:
lui $3, 6
lui $2, 15
mfhi $2
mflo $1
TAG244:
mthi $1
mtlo $1
lui $3, 13
bne $3, $1, TAG245
TAG245:
addiu $3, $3, 4
beq $3, $3, TAG246
lui $3, 4
xori $3, $3, 3
TAG246:
sll $2, $3, 6
div $2, $2
sll $0, $0, 0
addu $1, $2, $3
TAG247:
mfhi $3
blez $3, TAG248
sll $0, $0, 0
bgtz $3, TAG248
TAG248:
sll $0, $0, 0
beq $1, $1, TAG249
sll $0, $0, 0
mflo $4
TAG249:
sltu $4, $4, $4
mfhi $2
beq $4, $4, TAG250
srl $2, $4, 6
TAG250:
srav $1, $2, $2
bgez $1, TAG251
sll $3, $1, 4
mult $3, $3
TAG251:
sw $3, 0($3)
mfhi $1
lbu $4, 0($3)
lhu $3, 0($3)
TAG252:
lui $3, 10
beq $3, $3, TAG253
mult $3, $3
multu $3, $3
TAG253:
sll $0, $0, 0
sll $0, $0, 0
sb $1, 0($2)
xor $3, $2, $2
TAG254:
lui $3, 9
srl $3, $3, 2
sll $0, $0, 0
bne $3, $3, TAG255
TAG255:
sll $0, $0, 0
lui $3, 12
mfhi $4
lui $1, 14
TAG256:
mthi $1
addiu $4, $1, 9
sll $0, $0, 0
sll $0, $0, 0
TAG257:
mtlo $4
lui $4, 2
lui $2, 7
sll $0, $0, 0
TAG258:
bne $2, $2, TAG259
sll $0, $0, 0
div $2, $2
lui $4, 1
TAG259:
mtlo $4
bne $4, $4, TAG260
subu $4, $4, $4
mflo $1
TAG260:
bltz $1, TAG261
lui $2, 2
multu $2, $2
bne $2, $2, TAG261
TAG261:
srav $1, $2, $2
mfhi $1
sll $0, $0, 0
lui $4, 13
TAG262:
lui $4, 15
sllv $4, $4, $4
blez $4, TAG263
lui $1, 4
TAG263:
addiu $1, $1, 9
bne $1, $1, TAG264
sll $0, $0, 0
xori $2, $3, 5
TAG264:
beq $2, $2, TAG265
mthi $2
lhu $1, 0($2)
sb $1, 0($2)
TAG265:
mthi $1
mthi $1
srl $2, $1, 7
div $1, $1
TAG266:
sll $2, $2, 5
slti $4, $2, 4
sra $2, $2, 0
mult $4, $4
TAG267:
sll $0, $0, 0
mtlo $2
multu $2, $2
divu $2, $2
TAG268:
sh $4, 0($4)
add $1, $4, $4
lui $4, 5
sh $4, 0($1)
TAG269:
addiu $2, $4, 8
beq $2, $4, TAG270
mfhi $4
mfhi $1
TAG270:
mthi $1
sll $2, $1, 7
lui $4, 9
bltz $4, TAG271
TAG271:
lui $3, 10
divu $4, $4
srl $2, $3, 15
beq $3, $4, TAG272
TAG272:
lui $3, 8
lui $3, 12
divu $2, $2
lui $1, 1
TAG273:
lui $2, 2
lui $1, 3
bne $1, $2, TAG274
multu $1, $1
TAG274:
mfhi $3
bgtz $1, TAG275
sra $3, $1, 14
sb $3, 0($3)
TAG275:
mthi $3
lb $1, 0($3)
mflo $3
lbu $1, 0($3)
TAG276:
sra $3, $1, 7
mthi $1
lhu $3, 0($3)
bgez $1, TAG277
TAG277:
mthi $3
bgtz $3, TAG278
lui $4, 2
sh $3, 0($3)
TAG278:
srlv $3, $4, $4
mthi $4
sll $0, $0, 0
mfhi $2
TAG279:
mfhi $3
lui $2, 9
bgez $2, TAG280
sll $0, $0, 0
TAG280:
bltz $2, TAG281
mflo $2
beq $2, $2, TAG281
mfhi $2
TAG281:
sll $0, $0, 0
mult $2, $2
mult $2, $2
mflo $4
TAG282:
xor $4, $4, $4
multu $4, $4
bne $4, $4, TAG283
xori $3, $4, 2
TAG283:
sb $3, 0($3)
sll $3, $3, 14
xor $1, $3, $3
mthi $3
TAG284:
beq $1, $1, TAG285
sb $1, 0($1)
bne $1, $1, TAG285
lh $2, 0($1)
TAG285:
lui $1, 3
divu $1, $2
xor $2, $1, $2
mflo $1
TAG286:
lui $4, 13
divu $4, $1
sll $2, $4, 12
lbu $4, 0($1)
TAG287:
bne $4, $4, TAG288
mult $4, $4
andi $4, $4, 6
andi $3, $4, 11
TAG288:
mfhi $2
multu $3, $3
bgez $2, TAG289
sh $2, 0($2)
TAG289:
beq $2, $2, TAG290
mfhi $3
and $1, $2, $3
bgtz $3, TAG290
TAG290:
sb $1, 0($1)
sb $1, 0($1)
lui $1, 9
sll $0, $0, 0
TAG291:
sh $2, 0($2)
bgtz $2, TAG292
sra $1, $2, 15
mflo $2
TAG292:
beq $2, $2, TAG293
mthi $2
lb $3, 0($2)
mthi $3
TAG293:
slti $1, $3, 15
bne $1, $1, TAG294
lb $3, 0($1)
bne $3, $3, TAG294
TAG294:
lhu $1, 0($3)
lbu $1, 0($3)
beq $1, $1, TAG295
mult $1, $1
TAG295:
bltz $1, TAG296
lui $2, 10
andi $1, $1, 8
nor $3, $1, $1
TAG296:
lui $4, 7
mflo $4
multu $4, $3
beq $3, $4, TAG297
TAG297:
lui $1, 13
lbu $1, 0($4)
bne $4, $1, TAG298
mfhi $4
TAG298:
beq $4, $4, TAG299
slti $2, $4, 9
bne $4, $2, TAG299
mfhi $1
TAG299:
slt $1, $1, $1
bne $1, $1, TAG300
lb $1, 0($1)
sb $1, 0($1)
TAG300:
sub $2, $1, $1
mflo $1
sh $1, 0($1)
bne $1, $1, TAG301
TAG301:
lbu $2, 0($1)
sub $1, $1, $1
beq $1, $1, TAG302
lh $3, 0($1)
TAG302:
multu $3, $3
lbu $4, 0($3)
sw $4, 0($4)
slti $4, $3, 12
TAG303:
multu $4, $4
sb $4, 0($4)
lui $1, 3
sll $0, $0, 0
TAG304:
lui $1, 8
multu $1, $1
div $1, $1
srl $4, $1, 3
TAG305:
sll $0, $0, 0
mfhi $2
sll $0, $0, 0
lh $4, 0($3)
TAG306:
div $4, $4
lh $3, -256($4)
xor $3, $4, $4
beq $3, $4, TAG307
TAG307:
sltiu $3, $3, 13
lbu $3, 0($3)
bgtz $3, TAG308
div $3, $3
TAG308:
mfhi $4
beq $3, $4, TAG309
mult $4, $4
mult $3, $4
TAG309:
slti $3, $4, 7
sra $3, $3, 13
srl $2, $3, 8
sra $3, $4, 2
TAG310:
mthi $3
blez $3, TAG311
srav $3, $3, $3
lui $4, 12
TAG311:
bgez $4, TAG312
lhu $3, 0($4)
sub $4, $3, $3
add $2, $4, $3
TAG312:
mtlo $2
sh $2, 0($2)
blez $2, TAG313
lw $3, 0($2)
TAG313:
lhu $3, 0($3)
nor $3, $3, $3
beq $3, $3, TAG314
mult $3, $3
TAG314:
bne $3, $3, TAG315
lui $1, 1
sll $0, $0, 0
lhu $1, 1($3)
TAG315:
multu $1, $1
mthi $1
mflo $3
bgez $3, TAG316
TAG316:
multu $3, $3
beq $3, $3, TAG317
mthi $3
blez $3, TAG317
TAG317:
sh $3, 0($3)
sh $3, 0($3)
multu $3, $3
mthi $3
TAG318:
lw $2, 0($3)
xor $1, $2, $2
bgez $1, TAG319
addi $3, $2, 4
TAG319:
multu $3, $3
mflo $4
srlv $2, $4, $4
slt $2, $4, $2
TAG320:
lui $1, 13
lui $3, 9
sll $0, $0, 0
beq $1, $2, TAG321
TAG321:
sll $0, $0, 0
nor $1, $3, $3
sll $0, $0, 0
lui $2, 7
TAG322:
beq $2, $2, TAG323
sll $0, $0, 0
sb $2, 0($4)
bgez $2, TAG323
TAG323:
lui $1, 6
bgez $1, TAG324
sll $0, $0, 0
lui $3, 0
TAG324:
bne $3, $3, TAG325
mfhi $1
sra $2, $3, 1
sll $0, $0, 0
TAG325:
sb $1, 0($1)
bltz $1, TAG326
lhu $4, 0($1)
slti $2, $1, 12
TAG326:
mflo $2
mtlo $2
sltiu $4, $2, 2
lui $1, 5
TAG327:
blez $1, TAG328
addu $1, $1, $1
sll $0, $0, 0
sll $0, $0, 0
TAG328:
blez $3, TAG329
sll $0, $0, 0
mfhi $1
sll $0, $0, 0
TAG329:
sll $0, $0, 0
sll $4, $3, 8
mflo $2
slti $1, $2, 15
TAG330:
or $1, $1, $1
multu $1, $1
srav $4, $1, $1
slt $1, $4, $4
TAG331:
lui $1, 6
mthi $1
sll $0, $0, 0
lui $3, 0
TAG332:
beq $3, $3, TAG333
mult $3, $3
mflo $3
mfhi $2
TAG333:
bltz $2, TAG334
subu $3, $2, $2
lbu $3, 0($2)
bgez $3, TAG334
TAG334:
sltiu $3, $3, 13
div $3, $3
blez $3, TAG335
mfhi $1
TAG335:
bne $1, $1, TAG336
subu $1, $1, $1
lui $2, 10
mthi $1
TAG336:
mflo $1
sll $0, $0, 0
mthi $4
sltu $1, $1, $4
TAG337:
mthi $1
lbu $2, 0($1)
multu $1, $1
lui $4, 1
TAG338:
slt $4, $4, $4
lb $3, 0($4)
xor $4, $4, $4
sb $4, 0($4)
TAG339:
bgez $4, TAG340
mfhi $4
lhu $4, 0($4)
bgtz $4, TAG340
TAG340:
lui $4, 2
sll $0, $0, 0
lui $1, 6
addu $4, $1, $1
TAG341:
mthi $4
beq $4, $4, TAG342
sll $0, $0, 0
lui $3, 15
TAG342:
lw $3, 0($3)
mult $3, $3
lbu $2, 0($3)
multu $3, $3
TAG343:
sb $2, 0($2)
subu $3, $2, $2
bltz $3, TAG344
mult $3, $2
TAG344:
mflo $3
sra $4, $3, 9
sh $3, 0($3)
sra $4, $3, 12
TAG345:
lw $1, 0($4)
sh $1, 0($1)
lui $2, 3
bltz $2, TAG346
TAG346:
lui $3, 5
mthi $2
lui $2, 11
lui $2, 6
TAG347:
slt $1, $2, $2
mthi $2
mfhi $2
sll $0, $0, 0
TAG348:
mflo $3
and $1, $2, $2
mtlo $3
mthi $2
TAG349:
bgez $1, TAG350
sll $0, $0, 0
mflo $2
blez $1, TAG350
TAG350:
slt $3, $2, $2
mult $3, $3
mult $3, $2
lui $2, 9
TAG351:
mtlo $2
addiu $3, $2, 3
multu $3, $2
mthi $2
TAG352:
addiu $4, $3, 11
andi $1, $3, 1
mfhi $2
beq $2, $4, TAG353
TAG353:
slti $3, $2, 5
bgtz $3, TAG354
multu $2, $2
slti $3, $3, 13
TAG354:
bltz $3, TAG355
div $3, $3
divu $3, $3
subu $3, $3, $3
TAG355:
bne $3, $3, TAG356
mflo $2
sh $3, 0($3)
mthi $3
TAG356:
mfhi $1
add $3, $1, $1
addu $1, $2, $1
mthi $3
TAG357:
srlv $2, $1, $1
multu $1, $1
beq $2, $1, TAG358
lw $2, 0($2)
TAG358:
xor $4, $2, $2
beq $4, $4, TAG359
mthi $4
lhu $1, 0($4)
TAG359:
sb $1, 0($1)
mthi $1
bgez $1, TAG360
mtlo $1
TAG360:
sb $1, 0($1)
mthi $1
lbu $2, 0($1)
addiu $2, $2, 12
TAG361:
nor $1, $2, $2
sb $2, 0($2)
mthi $2
lui $4, 12
TAG362:
bne $4, $4, TAG363
mfhi $2
sll $0, $0, 0
mult $4, $4
TAG363:
bne $3, $3, TAG364
sltu $2, $3, $3
sb $2, 0($2)
lui $3, 0
TAG364:
blez $3, TAG365
sltu $3, $3, $3
mtlo $3
bltz $3, TAG365
TAG365:
add $4, $3, $3
addiu $4, $4, 9
mult $3, $3
div $4, $4
TAG366:
nor $1, $4, $4
mtlo $4
beq $1, $1, TAG367
lui $1, 0
TAG367:
sb $1, 0($1)
beq $1, $1, TAG368
mult $1, $1
lui $4, 11
TAG368:
sb $4, 0($4)
sb $4, 0($4)
lui $2, 13
ori $4, $4, 11
TAG369:
beq $4, $4, TAG370
mtlo $4
lhu $2, 0($4)
mfhi $2
TAG370:
multu $2, $2
div $2, $2
beq $2, $2, TAG371
mthi $2
TAG371:
bne $2, $2, TAG372
sll $0, $0, 0
sll $0, $0, 0
mthi $2
TAG372:
xori $4, $4, 14
subu $2, $4, $4
div $2, $4
lui $4, 13
TAG373:
lui $3, 12
beq $4, $3, TAG374
sltiu $3, $4, 14
bne $3, $3, TAG374
TAG374:
xori $3, $3, 2
mtlo $3
mtlo $3
lui $3, 9
TAG375:
blez $3, TAG376
addiu $1, $3, 12
bne $1, $1, TAG376
sll $0, $0, 0
TAG376:
mthi $1
srl $3, $1, 10
bne $1, $3, TAG377
addiu $2, $3, 6
TAG377:
mfhi $1
mthi $2
addiu $3, $2, 15
sb $3, -597($3)
TAG378:
sll $0, $0, 0
and $2, $1, $1
mult $3, $1
sll $0, $0, 0
TAG379:
sll $0, $0, 0
mult $2, $2
mthi $2
mthi $2
TAG380:
addu $1, $2, $2
nor $2, $2, $1
sll $0, $0, 0
srav $3, $1, $3
TAG381:
lb $2, 0($3)
sltiu $2, $3, 0
mult $2, $2
addi $3, $3, 12
TAG382:
blez $3, TAG383
and $2, $3, $3
mflo $4
bne $3, $2, TAG383
TAG383:
lb $4, 0($4)
srav $3, $4, $4
bltz $4, TAG384
slt $4, $4, $4
TAG384:
mthi $4
sw $4, 0($4)
lui $3, 9
sh $4, 0($4)
TAG385:
bltz $3, TAG386
sll $0, $0, 0
sll $0, $0, 0
blez $3, TAG386
TAG386:
sll $3, $3, 0
mult $3, $3
mtlo $3
subu $3, $3, $3
TAG387:
multu $3, $3
mfhi $3
mflo $3
bne $3, $3, TAG388
TAG388:
addu $4, $3, $3
lui $3, 1
srlv $3, $3, $4
or $2, $3, $4
TAG389:
divu $2, $2
sll $0, $0, 0
sltu $2, $2, $2
mflo $4
TAG390:
lbu $3, 0($4)
sltu $1, $3, $4
mflo $2
mflo $4
TAG391:
div $4, $4
sb $4, 0($4)
sb $4, 0($4)
subu $1, $4, $4
TAG392:
lhu $1, 0($1)
sltu $3, $1, $1
lb $1, -256($1)
lui $1, 13
TAG393:
sll $0, $0, 0
lui $4, 14
bltz $4, TAG394
sra $1, $1, 6
TAG394:
mthi $1
lw $4, -13312($1)
bne $4, $1, TAG395
xori $3, $1, 8
TAG395:
slti $4, $3, 15
lui $2, 1
srl $4, $2, 2
lbu $3, -16384($4)
TAG396:
mflo $1
andi $2, $1, 5
mthi $2
mult $2, $2
TAG397:
bgtz $2, TAG398
mflo $1
divu $1, $1
lb $2, 0($2)
TAG398:
or $4, $2, $2
mthi $2
mthi $2
nor $3, $4, $4
TAG399:
mflo $2
bne $2, $3, TAG400
mthi $3
mult $2, $2
TAG400:
bgtz $2, TAG401
sb $2, 0($2)
mtlo $2
xor $3, $2, $2
TAG401:
mfhi $1
bne $1, $1, TAG402
andi $4, $1, 3
mfhi $4
TAG402:
mtlo $4
slt $2, $4, $4
lbu $1, 0($2)
addi $1, $2, 10
TAG403:
sltu $3, $1, $1
div $3, $1
bltz $3, TAG404
slti $4, $3, 7
TAG404:
bne $4, $4, TAG405
sb $4, 0($4)
sb $4, 0($4)
srlv $2, $4, $4
TAG405:
sw $2, 0($2)
lh $2, 0($2)
mthi $2
lui $1, 1
TAG406:
srav $2, $1, $1
sll $0, $0, 0
lui $3, 0
bne $2, $4, TAG407
TAG407:
mtlo $3
blez $3, TAG408
mtlo $3
bgez $3, TAG408
TAG408:
xori $2, $3, 1
and $4, $3, $2
sb $2, 0($4)
beq $3, $3, TAG409
TAG409:
addiu $3, $4, 12
multu $3, $4
multu $3, $3
mthi $4
TAG410:
sltu $3, $3, $3
mflo $2
sltu $4, $3, $2
mflo $2
TAG411:
mflo $3
mthi $3
lb $1, -144($3)
mfhi $2
TAG412:
sll $0, $0, 0
addiu $2, $2, 12
lb $3, -156($2)
lui $3, 0
TAG413:
mult $3, $3
sb $3, 0($3)
lui $1, 1
bne $1, $3, TAG414
TAG414:
addu $4, $1, $1
sll $0, $0, 0
sllv $4, $4, $4
sll $0, $0, 0
TAG415:
bne $2, $2, TAG416
sb $2, -156($2)
beq $2, $2, TAG416
div $2, $2
TAG416:
slti $2, $2, 4
lui $3, 11
sll $0, $0, 0
sll $0, $0, 0
TAG417:
mflo $3
sb $3, 0($3)
xor $1, $2, $3
mtlo $2
TAG418:
mthi $1
bne $1, $1, TAG419
lui $2, 15
multu $2, $1
TAG419:
mflo $3
sll $0, $0, 0
sll $0, $0, 0
mthi $2
TAG420:
bne $4, $4, TAG421
addiu $4, $4, 11
lui $4, 12
mthi $4
TAG421:
beq $4, $4, TAG422
sll $0, $0, 0
blez $2, TAG422
srl $3, $2, 7
TAG422:
bne $3, $3, TAG423
slti $2, $3, 0
beq $2, $3, TAG423
and $3, $3, $2
TAG423:
lbu $3, 0($3)
beq $3, $3, TAG424
mflo $4
lui $4, 10
TAG424:
mflo $1
addu $3, $1, $1
mult $3, $3
mflo $3
TAG425:
beq $3, $3, TAG426
mfhi $3
sh $3, 0($3)
mfhi $3
TAG426:
mflo $4
subu $2, $4, $4
mthi $2
slt $3, $3, $3
TAG427:
mfhi $2
mthi $2
bgtz $2, TAG428
mfhi $4
TAG428:
blez $4, TAG429
mfhi $1
mthi $4
bne $1, $4, TAG429
TAG429:
mfhi $1
multu $1, $1
lui $1, 10
sllv $2, $1, $1
TAG430:
srlv $4, $2, $2
mtlo $2
sll $0, $0, 0
ori $3, $2, 0
TAG431:
sltu $1, $3, $3
bne $3, $1, TAG432
mthi $3
ori $4, $3, 12
TAG432:
mult $4, $4
addiu $2, $4, 9
and $4, $2, $2
mult $4, $2
TAG433:
bltz $4, TAG434
mflo $4
sll $0, $0, 0
beq $4, $2, TAG434
TAG434:
ori $2, $2, 12
beq $2, $2, TAG435
multu $2, $2
bne $2, $2, TAG435
TAG435:
sll $0, $0, 0
mtlo $2
bne $2, $2, TAG436
divu $2, $2
TAG436:
sll $0, $0, 0
bgtz $4, TAG437
lui $3, 14
lui $4, 13
TAG437:
sra $1, $4, 7
bne $1, $4, TAG438
lui $2, 7
mflo $1
TAG438:
sll $0, $0, 0
sll $0, $0, 0
multu $2, $1
blez $1, TAG439
TAG439:
div $2, $2
sll $0, $0, 0
sll $0, $0, 0
bne $2, $3, TAG440
TAG440:
div $3, $3
sll $0, $0, 0
bltz $3, TAG441
sll $0, $0, 0
TAG441:
sll $0, $0, 0
sll $3, $3, 6
sll $0, $0, 0
lui $1, 10
TAG442:
mtlo $1
addiu $1, $1, 6
sll $0, $0, 0
mfhi $3
TAG443:
sltu $2, $3, $3
lui $3, 12
sll $0, $0, 0
srlv $3, $3, $3
TAG444:
lui $3, 9
beq $3, $3, TAG445
div $3, $3
lh $1, 0($3)
TAG445:
blez $1, TAG446
mfhi $2
sll $0, $0, 0
nor $1, $1, $1
TAG446:
beq $1, $1, TAG447
mthi $1
xori $2, $1, 7
lui $1, 6
TAG447:
sll $0, $0, 0
multu $2, $2
bltz $2, TAG448
sll $0, $0, 0
TAG448:
mfhi $2
sll $0, $0, 0
xori $4, $3, 5
sra $3, $3, 1
TAG449:
bne $3, $3, TAG450
sll $0, $0, 0
srl $1, $3, 11
mult $1, $1
TAG450:
lui $1, 0
bltz $1, TAG451
multu $1, $1
mflo $4
TAG451:
bgtz $4, TAG452
sll $3, $4, 6
bgez $3, TAG452
addu $4, $3, $3
TAG452:
xori $4, $4, 8
beq $4, $4, TAG453
addiu $2, $4, 3
subu $4, $2, $4
TAG453:
ori $2, $4, 1
sra $1, $2, 14
lb $3, 0($2)
divu $4, $3
TAG454:
mtlo $3
sb $3, 0($3)
lb $2, 0($3)
andi $1, $3, 7
TAG455:
sltiu $3, $1, 12
lbu $2, 0($3)
mfhi $2
sltu $2, $2, $2
TAG456:
mult $2, $2
lui $4, 3
mthi $2
multu $4, $2
TAG457:
mfhi $2
bne $2, $4, TAG458
sh $4, 0($2)
divu $4, $4
TAG458:
slt $1, $2, $2
mtlo $1
mthi $2
beq $1, $1, TAG459
TAG459:
sw $1, 0($1)
multu $1, $1
multu $1, $1
sllv $1, $1, $1
TAG460:
addu $2, $1, $1
bne $2, $2, TAG461
mflo $3
sw $2, 0($1)
TAG461:
sllv $4, $3, $3
mult $3, $3
mflo $4
lui $1, 11
TAG462:
sll $0, $0, 0
sll $0, $0, 0
mflo $4
mtlo $1
TAG463:
sltu $3, $4, $4
lui $2, 5
mthi $4
mult $4, $4
TAG464:
slti $4, $2, 7
addu $1, $2, $2
sll $0, $0, 0
beq $1, $3, TAG465
TAG465:
sb $3, 0($3)
beq $3, $3, TAG466
multu $3, $3
addi $4, $3, 6
TAG466:
subu $4, $4, $4
mflo $4
mfhi $4
xori $4, $4, 13
TAG467:
mflo $2
beq $4, $2, TAG468
sltiu $2, $2, 6
bgtz $2, TAG468
TAG468:
lui $4, 12
lb $4, 0($2)
ori $4, $2, 10
beq $4, $4, TAG469
TAG469:
or $1, $4, $4
bltz $4, TAG470
addu $2, $1, $1
lui $1, 2
TAG470:
beq $1, $1, TAG471
srav $1, $1, $1
blez $1, TAG471
slt $3, $1, $1
TAG471:
multu $3, $3
mthi $3
subu $2, $3, $3
sb $2, 0($2)
TAG472:
lw $2, 0($2)
multu $2, $2
mtlo $2
lh $3, 0($2)
TAG473:
mflo $2
mtlo $3
slt $2, $3, $2
lui $2, 8
TAG474:
sll $0, $0, 0
addiu $3, $2, 8
and $1, $3, $2
lui $2, 2
TAG475:
mtlo $2
beq $2, $2, TAG476
lui $3, 5
andi $1, $3, 10
TAG476:
beq $1, $1, TAG477
mtlo $1
bltz $1, TAG477
mthi $1
TAG477:
sllv $1, $1, $1
div $1, $1
bgtz $1, TAG478
divu $1, $1
TAG478:
addiu $1, $1, 8
div $1, $1
bne $1, $1, TAG479
ori $2, $1, 9
TAG479:
lui $3, 9
sllv $4, $3, $3
mflo $2
sll $0, $0, 0
TAG480:
slti $1, $1, 13
bne $1, $1, TAG481
xori $1, $1, 8
bne $1, $1, TAG481
TAG481:
multu $1, $1
bne $1, $1, TAG482
mult $1, $1
blez $1, TAG482
TAG482:
mflo $2
nor $3, $2, $2
bltz $3, TAG483
mtlo $2
TAG483:
mflo $4
addiu $3, $4, 4
blez $3, TAG484
mthi $4
TAG484:
sb $3, 0($3)
divu $3, $3
lhu $4, 0($3)
lui $4, 15
TAG485:
srav $3, $4, $4
bltz $3, TAG486
lui $1, 15
mthi $1
TAG486:
lui $1, 10
sll $0, $0, 0
blez $1, TAG487
mfhi $4
TAG487:
divu $4, $4
sll $0, $0, 0
mtlo $3
mult $3, $3
TAG488:
mtlo $3
lui $2, 8
bgtz $3, TAG489
and $3, $2, $2
TAG489:
srlv $1, $3, $3
mflo $2
addiu $1, $1, 8
lui $3, 2
TAG490:
mthi $3
sll $0, $0, 0
mult $3, $1
blez $1, TAG491
TAG491:
srl $1, $1, 4
bne $1, $1, TAG492
mfhi $1
lb $1, 0($1)
TAG492:
beq $1, $1, TAG493
slt $3, $1, $1
lui $2, 10
mfhi $3
TAG493:
lbu $4, 0($3)
mult $3, $4
bne $3, $4, TAG494
nor $2, $4, $3
TAG494:
and $4, $2, $2
mflo $2
sw $2, 1($4)
beq $2, $2, TAG495
TAG495:
mtlo $2
lui $1, 8
sb $2, 0($2)
sb $1, 0($2)
TAG496:
mflo $3
mthi $3
lh $2, 0($3)
multu $1, $3
TAG497:
srav $4, $2, $2
lhu $1, 0($2)
mthi $2
mult $4, $2
TAG498:
lb $2, 0($1)
bne $1, $1, TAG499
lui $2, 11
mult $1, $2
TAG499:
mfhi $1
bne $1, $1, TAG500
slt $4, $2, $1
sll $0, $0, 0
TAG500:
or $1, $4, $4
beq $1, $1, TAG501
mfhi $1
mthi $1
TAG501:
mflo $1
ori $3, $1, 15
bltz $3, TAG502
lb $3, 0($1)
TAG502:
mfhi $4
mult $4, $3
bgtz $3, TAG503
lui $2, 3
TAG503:
mult $2, $2
bgtz $2, TAG504
lui $4, 5
sh $4, 0($4)
TAG504:
mult $4, $4
sltiu $3, $4, 2
div $4, $4
beq $4, $3, TAG505
TAG505:
lui $2, 1
sra $4, $2, 9
addiu $3, $4, 8
sltu $2, $3, $4
TAG506:
multu $2, $2
lw $1, 0($2)
mflo $1
mtlo $1
TAG507:
mfhi $2
lb $4, 0($2)
and $4, $2, $2
mult $4, $1
TAG508:
mtlo $4
sub $1, $4, $4
beq $1, $1, TAG509
mtlo $1
TAG509:
sllv $1, $1, $1
lw $1, 0($1)
mult $1, $1
mthi $1
TAG510:
lui $1, 10
divu $1, $1
sll $0, $0, 0
mthi $1
TAG511:
mthi $1
bgez $1, TAG512
sll $0, $0, 0
beq $1, $1, TAG512
TAG512:
andi $4, $1, 14
lb $4, 0($4)
ori $2, $4, 2
mult $4, $2
TAG513:
srlv $4, $2, $2
mtlo $2
xor $4, $2, $4
lui $3, 1
TAG514:
lui $2, 14
xor $4, $2, $2
mthi $3
mfhi $2
TAG515:
mfhi $4
sra $2, $4, 12
addu $2, $2, $4
sltu $1, $2, $2
TAG516:
sb $1, 0($1)
add $3, $1, $1
mult $1, $1
mthi $3
TAG517:
bgez $3, TAG518
sw $3, 0($3)
andi $2, $3, 10
mthi $3
TAG518:
mflo $2
mthi $2
sw $2, 0($2)
lbu $1, 0($2)
TAG519:
xori $4, $1, 15
srl $3, $4, 6
multu $4, $1
lb $1, 0($4)
TAG520:
lhu $2, 0($1)
sb $2, 0($1)
srav $1, $2, $2
and $4, $1, $2
TAG521:
lhu $2, 0($4)
lhu $3, 0($2)
lw $3, 0($4)
sh $2, 0($3)
TAG522:
bltz $3, TAG523
slti $2, $3, 12
sh $2, 0($3)
lui $1, 10
TAG523:
sltu $4, $1, $1
lb $1, 0($4)
lui $1, 6
mtlo $1
TAG524:
lui $3, 2
sll $0, $0, 0
sll $0, $0, 0
lui $2, 15
TAG525:
xor $2, $2, $2
nor $2, $2, $2
multu $2, $2
lui $1, 11
TAG526:
mthi $1
mthi $1
beq $1, $1, TAG527
mthi $1
TAG527:
bltz $1, TAG528
slt $2, $1, $1
blez $2, TAG528
mthi $1
TAG528:
lui $3, 6
srlv $1, $3, $3
mtlo $1
lui $2, 12
TAG529:
mthi $2
mflo $2
bne $2, $2, TAG530
srav $1, $2, $2
TAG530:
sll $0, $0, 0
lui $1, 12
beq $1, $1, TAG531
mtlo $4
TAG531:
lui $2, 13
div $2, $1
slt $4, $2, $1
mthi $2
TAG532:
bltz $4, TAG533
addi $3, $4, 11
mtlo $3
sb $4, 0($3)
TAG533:
mfhi $2
beq $3, $2, TAG534
mflo $2
mtlo $2
TAG534:
mtlo $2
nor $3, $2, $2
lui $1, 11
sll $0, $0, 0
TAG535:
bne $2, $2, TAG536
mtlo $2
lui $1, 8
beq $1, $2, TAG536
TAG536:
sll $0, $0, 0
mflo $2
blez $2, TAG537
lui $3, 7
TAG537:
mflo $1
lui $3, 10
addu $4, $3, $3
sll $0, $0, 0
TAG538:
bgtz $4, TAG539
lui $1, 13
sllv $1, $1, $4
mult $1, $4
TAG539:
bgez $1, TAG540
sra $1, $1, 11
lui $1, 4
lui $3, 0
TAG540:
mflo $2
sb $2, 0($2)
sltiu $3, $3, 6
beq $2, $3, TAG541
TAG541:
and $1, $3, $3
sh $1, 0($1)
bgez $1, TAG542
mfhi $4
TAG542:
mtlo $4
sll $0, $0, 0
mthi $4
sll $0, $0, 0
TAG543:
lui $2, 2
blez $2, TAG544
divu $2, $2
div $2, $2
TAG544:
mfhi $1
ori $3, $2, 3
sll $0, $0, 0
mthi $2
TAG545:
sll $2, $2, 3
mthi $2
bgez $2, TAG546
sll $0, $0, 0
TAG546:
mflo $4
sll $3, $2, 6
div $3, $3
mtlo $3
TAG547:
bgez $3, TAG548
xor $3, $3, $3
addiu $4, $3, 10
sw $4, 0($3)
TAG548:
mflo $1
blez $4, TAG549
lui $3, 7
sll $0, $0, 0
TAG549:
mthi $3
slt $1, $3, $3
or $2, $3, $1
sll $0, $0, 0
TAG550:
div $2, $2
lui $1, 12
lui $2, 13
xori $1, $1, 12
TAG551:
lui $2, 0
lb $1, 0($2)
sb $1, 0($2)
lw $4, 0($1)
TAG552:
mult $4, $4
lui $3, 12
blez $3, TAG553
lui $3, 6
TAG553:
xor $4, $3, $3
mult $4, $4
srav $3, $3, $4
mflo $4
TAG554:
mtlo $4
mfhi $3
mfhi $2
mflo $4
TAG555:
lui $4, 5
mfhi $1
mult $1, $1
lw $2, 0($1)
TAG556:
andi $2, $2, 4
addi $3, $2, 15
bne $2, $2, TAG557
addiu $1, $3, 7
TAG557:
lui $3, 14
xori $4, $1, 10
addu $4, $3, $4
blez $3, TAG558
TAG558:
sra $1, $4, 4
addiu $1, $4, 5
mflo $4
mfhi $1
TAG559:
mflo $2
beq $2, $2, TAG560
lhu $2, 0($2)
div $2, $2
TAG560:
mfhi $2
lui $1, 13
multu $1, $2
and $1, $1, $2
TAG561:
lui $3, 11
bltz $1, TAG562
sw $1, 0($1)
slt $3, $3, $3
TAG562:
addi $4, $3, 10
bltz $3, TAG563
sb $3, 0($3)
xori $3, $3, 12
TAG563:
mtlo $3
srlv $2, $3, $3
mtlo $3
beq $2, $2, TAG564
TAG564:
sra $3, $2, 10
lb $1, 0($2)
beq $2, $3, TAG565
mfhi $3
TAG565:
lb $2, 0($3)
mflo $3
and $2, $3, $2
lh $3, 0($2)
TAG566:
lh $2, 0($3)
lh $3, 0($3)
bgez $2, TAG567
lui $1, 12
TAG567:
xori $4, $1, 6
mult $1, $1
slti $2, $4, 10
beq $1, $1, TAG568
TAG568:
sb $2, 0($2)
subu $1, $2, $2
beq $2, $2, TAG569
lui $4, 1
TAG569:
lui $2, 15
mtlo $4
bne $4, $2, TAG570
lui $2, 13
TAG570:
sll $0, $0, 0
addiu $1, $4, 13
beq $2, $2, TAG571
mult $1, $4
TAG571:
mflo $3
subu $1, $1, $1
bne $1, $3, TAG572
mthi $1
TAG572:
ori $4, $1, 9
bne $1, $1, TAG573
sltu $1, $1, $4
mthi $1
TAG573:
sb $1, 0($1)
mflo $4
mfhi $2
lb $2, 0($1)
TAG574:
beq $2, $2, TAG575
lbu $2, 0($2)
bgez $2, TAG575
mflo $2
TAG575:
slti $2, $2, 15
lbu $2, 0($2)
sb $2, 0($2)
bltz $2, TAG576
TAG576:
srlv $2, $2, $2
sh $2, 0($2)
and $2, $2, $2
mfhi $3
TAG577:
sb $3, 0($3)
lb $1, 0($3)
divu $1, $3
addiu $1, $3, 15
TAG578:
lui $4, 1
addiu $1, $1, 7
addiu $4, $1, 3
div $1, $1
TAG579:
sh $4, 0($4)
beq $4, $4, TAG580
lh $4, 0($4)
divu $4, $4
TAG580:
mflo $4
bgez $4, TAG581
subu $2, $4, $4
sb $2, 0($4)
TAG581:
lui $1, 13
beq $2, $2, TAG582
multu $1, $2
mtlo $1
TAG582:
mtlo $1
blez $1, TAG583
sll $0, $0, 0
mfhi $2
TAG583:
bgtz $2, TAG584
mult $2, $2
mtlo $2
lw $3, 0($2)
TAG584:
mult $3, $3
div $3, $3
divu $3, $3
lui $2, 14
TAG585:
mthi $2
bltz $2, TAG586
sra $4, $2, 1
srl $3, $4, 1
TAG586:
bne $3, $3, TAG587
sll $0, $0, 0
mtlo $3
bgtz $3, TAG587
TAG587:
sll $0, $0, 0
sll $0, $0, 0
sll $0, $0, 0
andi $3, $2, 8
TAG588:
mflo $3
sll $0, $0, 0
div $3, $3
mtlo $3
TAG589:
mult $3, $3
mthi $3
or $4, $3, $3
beq $3, $3, TAG590
TAG590:
mtlo $4
divu $4, $4
subu $3, $4, $4
lui $1, 14
TAG591:
sll $0, $0, 0
sll $0, $0, 0
bne $1, $1, TAG592
mult $1, $1
TAG592:
sll $0, $0, 0
lui $3, 5
beq $3, $4, TAG593
slt $1, $3, $1
TAG593:
multu $1, $1
mflo $4
div $1, $4
nor $1, $4, $4
TAG594:
slt $2, $1, $1
mfhi $3
mult $1, $3
divu $1, $1
TAG595:
or $4, $3, $3
lui $2, 15
lui $1, 9
lui $4, 11
TAG596:
sll $0, $0, 0
mtlo $2
sll $0, $0, 0
nor $4, $4, $2
TAG597:
mflo $4
bne $4, $4, TAG598
mflo $2
sll $0, $0, 0
TAG598:
multu $2, $2
mflo $3
xori $3, $2, 14
lui $1, 4
TAG599:
mtlo $1
sltu $4, $1, $1
lui $4, 7
blez $1, TAG600
TAG600:
addiu $4, $4, 1
mflo $2
mfhi $3
bltz $4, TAG601
TAG601:
sb $3, -225($3)
mflo $4
lui $4, 14
lh $4, -225($3)
TAG602:
sltiu $2, $4, 13
beq $4, $2, TAG603
lw $4, -481($4)
addu $3, $4, $2
TAG603:
xori $4, $3, 10
lui $3, 13
multu $4, $3
beq $4, $3, TAG604
TAG604:
sll $0, $0, 0
sll $0, $0, 0
sll $0, $0, 0
bgez $3, TAG605
TAG605:
mflo $1
bne $3, $3, TAG606
sll $0, $0, 0
xori $4, $3, 6
TAG606:
mfhi $3
mthi $3
multu $4, $4
bne $4, $3, TAG607
TAG607:
sll $0, $0, 0
bgtz $3, TAG608
sh $3, 31($3)