.text
    # li $t0, 10
    # sw $t0, 0x7f50($0)
    
    # set default values and init
    li $t0, 0x1401      # 1_0100_0000_0001
    mtc0 $t0, $12
    li $t0, 60000000    # frequency -> preset
    sw $t0, 0x7f04($0)
    li $a0, 9  # 1001
    li $a1, -1 # 111...111
    
    li $s0, 0 # cnt
    li $s1, 0 # pre-value

    loop:
        lw $t0, 0x7f50($0)
        beq $s1, $t0, if_1_end
        nop
            sw $0, 0x7f00($0) # stop count
            addu $s1, $0, $t0
            addu $s0, $0, $t0 # reload
            sw $0, 0x7f60($0) # LED off
            sw $a0, 0x7f00($0) # restart count
            if_2_end:
        if_1_end:
        sw $s0, 0x7f40($0) # digitalTube
    j loop
    nop

.ktext 0x4180
    sw $a0, 0x7f00($0)
    sw $0, 0x7f60($0) # LED off
    bnez $s0, if_3_end
    nop
        addu $s0, $0, $s1 # reload
        eret
    if_3_end:
    addiu $s0, $s0, -1
    bnez $s0, if_4_end
    nop
        sw $a1, 0x7f60($0) # LED on
        eret
    if_4_end:
    eret  
