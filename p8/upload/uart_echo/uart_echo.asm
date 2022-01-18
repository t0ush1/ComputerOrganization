.text
li $sp, 0x2fff  # buffer
li $t0, 0x1001
mtc0 $t0, $12
li $t0, 0xb
sb $t0, 0x7f44($0)
li $t0, 0x96
sb $t0, 0x7f41($0)
# li $t0, 1000        # check per 1000 cycles
# sw $t0, 0x7f04($0)
# li $t0, 11          # 1011
# sw $t0, 0x7f00($0)  # start timer in mode 1
li $s0, 0

loop: 

    lb $a0, 0x7f58($0)
    andi $a0, $a0, 0xf
    beq $s0, $a0, loop
    nop

    addiu $s0, $a0, 0
    
    bne $a0, 1, if_3_else_1
    nop
        li $t0, 389
        li $t1, 3124
        li $t2, 0x92
        li $t3, 0x01
        j if_3_end
        nop
    if_3_else_1:
    
    bne $a0, 2, if_3_else_2
    nop
        li $t0, 194
        li $t1, 1561
        li $t2, 0x84
        li $t3, 0x03
        j if_3_end
        nop
    if_3_else_2:
    
    bne $a0, 4, if_3_else_3
    nop
        li $t0, 129
        li $t1, 1040
        li $t2, 0x76
        li $t3, 0x05
        j if_3_end
        nop
    if_3_else_3:
    
    bne $a0, 8, if_3_else_4
    nop
        li $t0, 64
        li $t1, 519
        li $t2, 0x52
        li $t3, 0x11
        j if_3_end
        nop
    if_3_else_4:

    li $t0, 780
    li $t1, 6249
    li $t2, 0x96
    li $t3, 0x00

    if_3_end:
    sw $t0, 0x7f34($0)
    sw $t1, 0x7f38($0)
    sb $t2, 0x7f41($0)
    sb $t3, 0x7f42($0)

beq $0, $0, loop
nop

.ktext 0x4180
lw $t0, 0x7f30($0)
andi $t1, $t0, 1
andi $t2, $t0, 32
beqz $t1, if_1_end
nop
    lw $t0, 0x7f20($0)
    sb $t0, 0($sp)
    addiu $sp, $sp, -1
if_1_end:
beqz $t2, if_2_end
nop
bge $sp, 0x2fff, if_2_end
nop
    addiu $sp, $sp, 1
    lb $t0, 0($sp)
    sw $t0, 0x7f20($0) # echo
    
    lb $t0, 0x7f43($0)
    addiu $t0, $t0, 1
    sb $t0, 0x7f43($0) # update digital tube
if_2_end:

eret