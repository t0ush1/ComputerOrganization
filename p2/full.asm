.data
	ar: .space 24											#int ar[6]
	mark: .space 28										#int mark[7]
	space: .asciiz " "
	line: .asciiz "\n"

.macro FP(%index)										#void fullPermutation(int index)
	push($t0)
	push($ra)
	push($a0)
	add $a0, $zero, %index
	jal FP
	pop($a0)
	pop($ra)
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

.macro writeString(%s)
	la $a0, %s
	li $v0, 4
	syscall
.end_macro

.text
main:
	li $v0, 5
	syscall
	move $s0, $v0											#read n -> $s0
	FP(0)
	li $v0, 10
	syscall
		
FP:
	bne $a0, $s0, if_1_end						#if (index == n)
		li $t0, 0											#for (int i = 0; i < n; i ++) i -> $t0
		for_1_begin:
		beq $t0, $s0, for_1_end
			sll $t1, $t0, 2
			lw $a0, ar($t1)
			li $v0, 1
			syscall											#output ar[i] + " "
			writeString(space)
		addi $t0, $t0, 1
		j for_1_begin
		for_1_end:
		writeString(line)
		jr $ra
	if_1_end:

	li $t0, 1											#for (int i = 1; i <= n; i ++) i -> $t0
	for_2_begin:
	bgt $t0, $s0, for_2_end
		sll $t1, $t0, 2
		lw $t1, mark($t1)
		bne $t1, $zero, if_2_end			#if (mark[i] == 0)
			sll $t1, $a0, 2						#ar[index] = i
			sw $t0, ar($t1)
			
			li $t2, 1									#mark[i] = 1
			sll $t1, $t0, 2
			sw $t2, mark($t1)
			
			addi $t1, $a0, 1						#FP(index + 1)
			FP($t1)
			
			sll $t1, $t0, 2						#mark[i] = 0
			sw $zero, mark($t1)
		if_2_end:
	addi $t0, $t0, 1
	j for_2_begin
	for_2_end:
	
	jr $ra