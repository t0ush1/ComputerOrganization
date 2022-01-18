.data

.macro mod(%re, %a, %b)					#re = a % b
	li %re, %b
	div %a, %re
	mfhi %re
.end_macro

.text
	li $v0, 5
	syscall
	move $t0, $v0								#input n -> $t0
	
	li $t2, 1										#ans = 1 -> $t2
	
	mod($t1, $t0, 400)						#if (n % 400 != 0)
	beq $t1, $zero, if_1_end
		
		mod($t1, $t0, 4)						#if (n % 4 != 0)
		beq $t1, $zero, if_2_end
			li $t2, 0
		if_2_end:
		
		mod($t1, $t0, 100)					#if (n % 100 == 0)
		bne $t1, $zero, if_3_end
			li $t2, 0
		if_3_end:
		
	if_1_end:
	
	move $a0, $t2								#output ans
	li $v0, 1
	syscall
	
	li $v0, 10										#done
	syscall