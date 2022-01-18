.data
	A: .space 256											#int A[8][8]
	B: .space 256											#int B[8][8]
	C: .space 256											#int C[8][8]
	space: .asciiz " "
	line: .asciiz "\n"
	
.macro readInt(%x)
	li $v0, 5
	syscall
	move %x, $v0
.end_macro
	
.macro writeInt(%x)
	move $a0, %x
	li $v0, 1
	syscall
.end_macro
	
.macro writeString(%s)
	la $a0, %s
	li $v0, 4
	syscall
.end_macro
	
.macro getAddr(%addr, %i, %j)
	sll %addr, %i, 3
	add %addr, %addr, %j
	sll %addr, %addr, 2
.end_macro

.text
	readInt($s0)											#read n -> $s0
	
	li $t0, 0												#for (int i = 0; i < n; i ++) i -> $t0
	for_1_begin:
	beq $t0, $s0, for_1_end
		li $t1, 0											#for (int j = 0; j < n; j ++) j -> $t1
		for_2_begin:
		beq $t1, $s0, for_2_end
			getAddr($t2, $t0, $t1)				#read A[i][j]
			readInt($t3)
			sw $t3, A($t2)
		addi $t1, $t1, 1
		j for_2_begin
		for_2_end:
	addi $t0, $t0, 1
	j for_1_begin
	for_1_end:
	
	li $t0, 0												#for (int i = 0; i < n; i ++) i -> $t0
	for_3_begin:
	beq $t0, $s0, for_3_end
		li $t1, 0											#for (int j = 0; j < n; j ++) j -> $t1
		for_4_begin:
		beq $t1, $s0, for_4_end
			getAddr($t2, $t0, $t1)				#read B[i][j]
			readInt($t3)
			sw $t3, B($t2)
		addi $t1, $t1, 1
		j for_4_begin
		for_4_end:
	addi $t0, $t0, 1
	j for_3_begin
	for_3_end:
	
	li $t0, 0												#for (int i = 0; i < n; i ++) i -> $t0
	for_5_begin:
	beq $t0, $s0, for_5_end
		li $t1, 0											#for (int j = 0; j < n; j ++) j -> $t1
		for_6_begin:
		beq $t1, $s0, for_6_end
			
			li $t3, 0										#int sum = 0 -> $t3
			li $t2, 0										#for (int k = 0; k < n; k ++) k -> $t2
			for_7_begin:
			beq $t2, $s0, for_7_end
				getAddr($t4, $t0, $t2)			#sum += A[i][k] * B[k][j]
				lw $t5, A($t4)
				getAddr($t4, $t2, $t1)
				lw $t6, B($t4)
				mult $t5, $t6
				mflo $t4
				add $t3, $t3, $t4
			addi $t2, $t2, 1
			j for_7_begin
			for_7_end:
			getAddr($t4, $t0, $t1)				#C[i][j] = sum
			sw $t3, C($t4)
		
		addi $t1, $t1, 1
		j for_6_begin
		for_6_end:
	addi $t0, $t0, 1
	j for_5_begin
	for_5_end:
	
	li $t0, 0												#for (int i = 0; i < n; i ++) i -> $t0
	for_8_begin:
	beq $t0, $s0, for_8_end
		li $t1, 0											#for (int j = 0; j < n; j ++) j -> $t1
		for_9_begin:
		beq $t1, $s0, for_9_end
			getAddr($t2, $t0, $t1)				#write C[i][j]
			lw $t3, C($t2)
			writeInt($t3)
			writeString(space)
			sw $t3, B($t2)
		addi $t1, $t1, 1
		j for_9_begin
		for_9_end:
		writeString(line)
	addi $t0, $t0, 1
	j for_8_begin
	for_8_end:
	
	li $v0, 10
	syscall
