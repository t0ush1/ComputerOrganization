li $s0, 0 #before0
li $s1, 0 #before1

.text
loop:

    lw $t2, 0x7f58($0)
    andi $t0, $t2, 1
    andi $t1, $t2, 2
    
    beq $t0, $s0, if_1_end
    nop
        addu $s0, $0, $t0
    beq $t0, $0, if_1_end
    nop

        lw $t0, 0x7f50($0)
        lw $t1, 0x7f54($0)
        sw $t1, 0x7f40($0)
        sw $t1, 0($t0)

    if_1_end:

    beq $t1, $s1, if_2_end
    nop
        addu $s1, $0, $t1
    beq $t1, $0, if_2_end
    nop
        lw $t0, 0x7f50($0)
        lw $t1, 0($t0)
        sw $t1, 0x7f40($0)
    if_2_end:

beq $0, $0, loop
nop

.ktext 0x4180
la $t0, loop
mtc0 $t0, $14
eret