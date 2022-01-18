.text
    # li $t0, 10
    # sw $t0, 0x7f50($0)
    
    # set default values and init
    li $t0, 0x1401      # 1_0100_0000_0001
    mtc0 $t0, $12
    
    li $s0, 0 # cnt
    li $s1, 9 # end
    li $s2, 0 # seconds
    li $s3, 9 # 1001

    loop:
        lw $v0, 0x7f50($0)
        li $t0, 2
        ble $v0, $t0, if_5_end
        nop
            addiu $v0, $0, 2
        if_5_end:
        
        beq $s2, $v0, if_1_end
        nop
            sw $0, 0x7f00($0) # stop count
            addu $s2, $0, $v0

            li $t0, 2
            bne $s2, $t0, if_2_else_1
            nop
                li $a0, 120000000
                j if_2_end
                nop
            if_2_else_1:
            
            li $t0, 1
            bne $s2, $t0, if_2_else_2
            nop
                li $a0, 60000000
                j if_2_end
                nop
            if_2_else_2:

                li $s0, 0
                j if_1_end
                nop

            if_2_end:

            sw $a0, 0x7f04($0)
            sw $s3, 0x7f00($0) # restart count
        if_1_end:

        sw $s0, 0x7f40($0) # digitalTube

    j loop
    nop

.ktext 0x4180
    sw $s3, 0x7f00($0)
    bne $s0, $s1, if_3_end
    nop
        addu $s0, $0, $0 # reload
        eret
    if_3_end:
    addiu $s0, $s0, 1
    eret