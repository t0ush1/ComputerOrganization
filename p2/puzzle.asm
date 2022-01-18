.data
	dx: .word -1:1
			.word 0:1
			.word 1:1
			.word 0:1
	dy: .word 0:1
			.word 1:1
			.word 0:1
			.word -1:1
	mat: .space 640
	mark: .space 640

.macro readInt(%x)
	li $v0, 5
	syscall
	move %x, $v0
.end_macro

.macro getOffset(%des, %i, %j)
	sll %des, %i, 4
	add %des, %des, %j
	sll %des, %des, 2
.end_macro

.macro getElem(%e, %mat, %i, %j)
	getOffset(%e, %i, %j)
	lw %e, %mat(%e)
.end_macro

.macro setElem(%e, %mat, %i, %j)
	push($t0)
	getOffset($t0, %i, %j)
	sw %e, %mat($t0)
	pop($t0)
.end_macro

.macro push(%x)
	sw %x, 0($sp)
	addi $sp, $sp, -4
.end_macro

.macro pop(%x)
	addi $sp, $sp, 4
	lw %x, 0($sp)
.end_macro

.macro dfs(%x, %y)
	push($t0)
	push($ra)
	push($a1)
	push($a0)
	move $a0, %x
	move $a1, %y
	jal dfs
	pop($a0)
	pop($a1)
	pop($ra)
	pop($t0)
.end_macro

.text
main:
	readInt($s0)															#n -> $s0, m -> $s1, ans -> $s2
	readInt($s1)
	li $t0, 1
	for_1_begin:
	bgt $t0, $s0, for_1_end
		li $t1, 1
		for_2_begin:
		bgt $t1, $s1, for_2_end
			readInt($v0)
			xori $v0, $v0, 1
			setElem($v0, mat, $t0, $t1)
		addi $t1, $t1, 1
		j for_2_begin
		for_2_end:
	addi $t0, $t0, 1
	j for_1_begin
	for_1_end:
	readInt($t0)															#x0 -> $t0, y0 -> $t1, x1 -> $s3, y1 -> %s4
	readInt($t1)
	readInt($s3)
	readInt($s4)
	
	dfs($t0, $t1)

	move $a0, $s2
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall

dfs:
	bne $a0, $s3, if_1_end							#if (x == x1 && y == y1)
	bne $a1, $s4, if_1_end
		addi $s2, $s2, 1
		jr $ra
	if_1_end:
	
	li $t0, 1
	setElem($t0, mark, $a0, $a1)				#mark[x][y] = 1
	
	li $t0, 0
	for_3_begin:
	beq $t0, 4, for_3_end
		
		sll $t1, $t0, 2									#xx = x + dx[i] -> $t1
		lw $t1, dx($t1)
		add $t1, $t1, $a0
		sll $t2, $t0, 2									#yy = y + dy[i] -> $t2
		lw $t2, dy($t2)
		add $t2, $t2, $a1
		getElem($t3, mark, $t1, $t2)			#if (!mark[xx][yy] && mat[xx][yy])
		getElem($t4, mat, $t1, $t2)
		bne $t3, $zero, if_2_end
		beq $t4, $zero, if_2_end
			dfs($t1, $t2)
		if_2_end:
		
	addi $t0, $t0, 1
	j for_3_begin
	for_3_end:
	
	setElem($zero, mark, $a0, $a1)			#mark[x][y] = 0
	jr $ra