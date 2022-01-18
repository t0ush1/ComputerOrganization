# li $t0, 0x12
# sb $t0, 0x7f57($0)
# li $t0, 1
# sb $t0, 0x7f58($0)

li $s0, 0 #before
li $s1, 8 #loop_limit
li $sp, 0x2000 #buffer

loop:

    lw $t0, 0x7f58($0)
    andi $t0, $t0, 1
    beq $t0, $s0, if_1_end
    nop
        
        addu $s0, $0, $t0

    beq $t0, $0, if_1_end
    nop
        
        lw $t0, 0x7f54($0)
        sw $t0, 0x7f40($0)

        li $t2, 0
        for_1_begin:
        beq $t2, $s1, for_1_end
        nop

            andi $t1, $t0, 0xf
            sll $t1, $t1, 3
            la $a0, table
            addu $a0, $a0, $t1
            jr $a0
            nop
            table:

            j table_end
            li $a1, 48
            j table_end
            li $a1, 49
            j table_end
            li $a1, 50
            j table_end
            li $a1, 51
            j table_end
            li $a1, 52
            j table_end
            li $a1, 53
            j table_end
            li $a1, 54
            j table_end
            li $a1, 55
            j table_end
            li $a1, 56
            j table_end
            li $a1, 57
            j table_end
            li $a1, 65
            j table_end
            li $a1, 66
            j table_end
            li $a1, 67
            j table_end
            li $a1, 68
            j table_end
            li $a1, 69
            j table_end
            li $a1, 70
            
            table_end:

            addiu $sp, $sp, -1
            sb $a1, 0($sp)

        srl $t0, $t0, 4
        addi $t2, $t2, 1
        j for_1_begin
        nop
        for_1_end:

    if_1_end:

    lw $t0, 0x7f30($0)
    andi $t1, $t0, 32
    beqz $t1, if_2_end
    nop
    bge $sp, 0x3000, if_2_end
    nop
        lb $t0, 0($sp)
        addiu $sp, $sp, 1
        sw $t0, 0x7f20($0)
    if_2_end:

beq $0, $0, loop
nop
