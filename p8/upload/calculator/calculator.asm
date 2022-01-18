# 0->7 : & | ^ + - << >> >>>
# priority 0 > ... > 7

# li $t0, 1
# li $t1, 2
# li $t2, 0x8
# sw $t0, 0x7f54($0)
# sw $t1, 0x7f50($0)
# sb $t2, 0x7f58($0)

endless_loop:

    # get operands and operator
    lw $a0, 0x7f54($0)
    lw $a1, 0x7f50($0)
    lb $a2, 0x7f58($0)

    # jump table
    li $t0, 0
    while_1_begin:
    beqz $a2, while_1_end
    nop
        and $t1, $a2, 1
        beqz $t1, if_1_end
        nop
            la $ra, op_begin
            addu $ra, $ra, $t0 
            jr $ra
            nop
        if_1_end:
        srl $a2, $a2, 1
        addiu $t0, $t0, 8
    j while_1_begin
    nop
    while_1_end:
    j endless_loop
    nop

op_begin:
    j op_end
    and $s0, $a0, $a1
    j op_end
    or $s0, $a0, $a1
    j op_end
    xor $s0, $a0, $a1
    j op_end
    addu $s0, $a0, $a1
    j op_end
    subu $s0, $a0, $a1
    j op_end
    sllv $s0, $a0, $a1
    j op_end
    srlv $s0, $a0, $a1
    j op_end
    srav $s0, $a0, $a1

op_end:
    sw $s0, 0x7f40($0)
    j endless_loop
    nop
