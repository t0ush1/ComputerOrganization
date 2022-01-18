.data
	f: .space 400
	h: .space 400
	g: .space 400
	space: .asciiz " "
	line: .asciiz "\n"

.macro readInt(%x)
	li $v0, 5
	syscall
	move %x, $v0
.end_macro

.macro getOffset(%des, %i, %j, %col)
	mult %i, %col
	mflo %des
	add %des, %des, %j
	sll %des, %des, 2
.end_macro

.text
	readInt($s0)													#m1, n1, m2, n2 -> $s0 ~ $s3
	readInt($s1)
	readInt($s2)
	readInt($s3)
	sub $t0, $s0, $s2										#m3 = m1-m2+1 -> $s4, n3 = n1-n2+1 -> $s5
	addi $s4, $t0, 1
	sub $t0, $s1, $s3
	addi $s5, $t0, 1
	
	li $t0, 0														#for (int i = 0; i < m1; i ++) i -> $t0
	for_0_begin:
	beq $t0, $s0, for_0_end
		li $t1, 0													#for (int j = 0; j < n1; j ++) j -> $t1
		for_1_begin:
		beq $t1, $s1, for_1_end
			readInt($v0)											#read f[i][j]
			getOffset($t2, $t0, $t1, $s1)
			sw $v0, f($t2)
		addi $t1, $t1, 1
		j for_1_begin
		for_1_end:
	addi $t0, $t0, 1
	j for_0_begin
	for_0_end:
	
	li $t0, 0														#for (int i = 0; i < m2; i ++) i -> $t0
	for_2_begin:
	beq $t0, $s2, for_2_end
		li $t1, 0													#for (int j = 0; j < n2; j ++) j -> $t1
		for_3_begin:
		beq $t1, $s3, for_3_end
			readInt($v0)											#read h[i][j]
			getOffset($t2, $t0, $t1, $s3)
			sw $v0, h($t2)
		addi $t1, $t1, 1
		j for_3_begin
		for_3_end:
	addi $t0, $t0, 1
	j for_2_begin
	for_2_end:
	
	li $t0, 0																#for (int i = 0; i < m3; i ++) i -> $t0
	for_4_begin:
	beq $t0, $s4, for_4_end
		li $t1, 0															#for (int j = 0; j < n3; j ++) j -> $t1
		for_5_begin:
		beq $t1, $s5, for_5_end
		
			li $t4, 0														#sum = 0
			
			li $t2, 0														#for (int k = 0; k < m2; k ++) k -> $t2
			for_6_begin:
			beq $t2, $s2, for_6_end
				li $t3, 0													#for (int l = 0; l < n2; l ++) l -> $t3
				for_7_begin:
				beq $t3, $s3, for_7_end
					
					add $t5, $t0, $t2								#i + k -> $t5, j + l -> $t6
					add $t6, $t1, $t3
					getOffset($t7, $t5, $t6, $s1)		#f[i+k][j+l] -> $t5
					lw $t5, f($t7)
					getOffset($t7, $t2, $t3, $s3)		#h[k][l] -> $t6
					lw $t6, h($t7)
					
					mult $t5, $t6
					mflo $t7
					add $t4, $t4, $t7								#sum += $t5 * $t6
					
				addi $t3, $t3, 1
				j for_7_begin
				for_7_end:
			addi $t2, $t2, 1
			j for_6_begin
			for_6_end:
			
			getOffset($t5, $t0, $t1, $s5)
			sw $t4, g($t5)
			
		addi $t1, $t1, 1
		j for_5_begin
		for_5_end:
	addi $t0, $t0, 1
	j for_4_begin
	for_4_end:
	
	li $t0, 0														#for (int i = 0; i < m3; i ++) i -> $t0
	for_8_begin:
	beq $t0, $s4, for_8_end
		
		li $t1, 0													#for (int j = 0; j < n3; j ++) j -> $t1
		for_9_begin:
		beq $t1, $s5, for_9_end
			
			getOffset($t2, $t0, $t1, $s5)
			lw $a0, g($t2)
			li $v0, 1
			syscall
			
			la $a0, space
			li $v0, 4
			syscall
			
		addi $t1, $t1, 1
		j for_9_begin
		for_9_end:
		
		la $a0, line
		li $v0, 4
		syscall
		
	addi $t0, $t0, 1
	j for_8_begin
	for_8_end:
	
	li $v0, 10
	syscall