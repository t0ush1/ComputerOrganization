.data
	num: .space 1024

.text
	li $v0, 5
	syscall
	move $s0, $v0												#read n -> $s0
	li $s1, 1														#len = 1 -> $s1
	sw $s1, num($zero)										#num[0] = 1
	
	while_1_begin:												#while (n)
	beqz $s0, while_1_end
		
		li $t0, 0													#for (int i = 0; i < len; i ++)
		for_1_begin:
		beq $t0, $s1, for_1_end
			sll $t1, $t0, 2
			lw $t2, num($t1)
			mul $t2, $s0, $t2
			sw $t2, num($t1)									#num *= n
		addi $t0, $t0, 1
		j for_1_begin
		for_1_end:
	
		li $t0, 0													#for (int i = 0; i < len; i ++)
		for_2_begin:
		beq $t0, $s1, for_2_end
			
			sll $t1, $t0, 2
			addi $t2, $t1, 4
			lw $t3, num($t1)
			lw $t4, num($t2)									#get num[i], num[i+1]
			
			li $t5, 1000000
			div $t3, $t5
			mflo $t5
			add $t4, $t4, $t5
			sw $t4, num($t2)									#num[i+1] += num[i] / 1000000;
			mfhi $t5
			sw $t5, num($t1)									#num[i] %= 1000000;
		
		addi $t0, $t0, 1
		j for_2_begin
		for_2_end:
	
		sll $t0, $s1, 2										#if (num[len]) len ++;
		lw $t1, num($t0)
		beqz $t1, if_1_end
			addi $s1, $s1, 1
		if_1_end:
		
		addi $s0, $s0, -1									#n --
		
	j while_1_begin
	while_1_end:
	
	li $v0, 1
	sll $t0, $s1, 2
	addi $t0, $t0, -4
	lw $a0, num($t0)
	syscall
	
	while_3_begin:
	beqz $t0, while_3_end
		
		addi $t0, $t0, -4
		lw $t1, num($t0)
		
		li $t2, 100000
		li $a0, 0
		while_4_begin:
			bge $t1, $t2, while_4_end
			syscall
			div $t2, $t2, 10
		j while_4_begin
		while_4_end:
		
		beqz $t1, if_2_end
			move $a0, $t1
			syscall
		if_2_end:
		
	j while_3_begin
	while_3_end:
	
	li $v0, 10
	syscall
