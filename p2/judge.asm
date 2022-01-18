.data
	s: .space 20										#char s[20]

.text
	li $v0, 5											#read n -> $s0
	syscall
	move $s0, $v0
	
	li $t0, 0											#for (int i = 0; i < n; i ++) i -> $t0
	for_1_begin:
	beq $t0, $s0, for_1_end
		li $v0, 12
		syscall
		sb $v0, s($t0)
	addi $t0, $t0, 1
	j for_1_begin
	for_1_end:
	
	li $a0, 1											#flag = 1
	li $t0, 0											#for (int i = 0, j = n-1; i < j; i ++, j --)
	addi $t1, $s0, -1
	for_2_begin:
	beq $t0, $s0, for_2_end
		lb $t2, s($t0)
		lb $t3, s($t1)
		beq $t2, $t3, if_1_end				#if (s[i] != s[j])
			li $a0, 0
			j for_2_end
		if_1_end:
	addi $t0, $t0, 1
	addi $t1, $t1, -1
	j for_2_begin
	for_2_end:
	
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall