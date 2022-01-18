.data
	array: .space 400
	message_input_n: .asciiz "Please input an integer as the length of the sequence:\n"
	message_input_array: .asciiz "Please input an integer followed with a line break:\n"
	message_output_array: .asciiz "The sorted sequence is:\n"
	space: .asciiz " "
	stack: .space 100

.globl main

.text
	
	main:
		la $sp, stack										#$sp -> bottom of stack
		addiu $sp, $sp, 100
		addiu $sp, $sp, -20							#malloc
		
		jal input												#n = input() -> $t0
		nop
		move $t0, $v0
		
		move $a0, $t0										#sort(n)
		sw $t0, 16($sp)
		jal sort
		nop
		lw $t0, 16($sp)
		
		move $a0, $t0										#output(n)
		jal output
		nop
		
		li $v0, 10
		syscall
	
	input:															#int input()
		la $a0, message_input_n
		li $v0, 4
		syscall
		
		li $v0, 5												#input n -> $t0
		syscall
		move $t0, $v0
																		#for (int i = 0; i < n; i ++)
		li $t1, 0												#i -> $t1, i = 0
		for_1_begin:	
			slt $t2, $t1, $t0							#i < n
			beq $t2, $zero, for_1_end
			nop
																		#{
			la $a0, message_input_array
			li $v0, 4
			syscall
			
			li $v0, 5											#input a[i]
			syscall		
			sll $t2, $t1, 2
			sw $v0, array($t2)
																		#}
			addi $t1, $t1, 1								#i ++
			j for_1_begin
			nop
		for_1_end:	
		
		move $v0, $t0										#return n
		jr $ra
	
	output:														#void output(int n)
		move $t0, $a0										#n -> $t0
		
		la $a0, message_output_array
		li $v0, 4
		syscall
																		#for (int i = 0; i < n; i ++)
		li $t1, 0												#i -> $t1, i = 0
		for_2_begin:
			slt $t2, $t1, $t0							#i < n
			beq $t2, $zero, for_2_end
			nop
																		#{
			sll $t2, $t1, 2								#output a[i]
			lw $a0, array($t2)
			li $v0, 1
			syscall
			
			la $a0, space
			li $v0, 4
			syscall
																		#}
			addi $t1, $t1, 1								#i ++
			j for_2_begin
			nop
		for_2_end:
		
		jr $ra														#return
		nop
		
	findmin:														#int findmin(int n, int start)
		move $t0, $a0										#n -> $t0
		move $t1, $a1										#min -> $t1
																		#for (int i = min+1; i < n; i ++)
		addi $t2, $t1, 1									#i -> $t2, i = min + 1
		for_3_begin:
			slt $t3, $t2, $t0							#i < n
			beq $t3, $zero, for_3_end
			nop
																		#{ for_3
			sll $t3, $t1, 2								#a[min] -> $4
			lw $t4, array($t3)
			sll $t3, $t2, 2								#a[i] -> $t5
			lw $t5, array($t3)
			
			slt $t3, $t5, $t4							#if (a[i] < a[min])
			beq $t3, $zero, if_1_end
			nop
				move $t1, $t2								#min = i
			if_1_end:
																		#} for_3
			addi $t2, $t2, 1								#i ++
			j for_3_begin
			nop
		for_3_end:
		
		move $v0, $t1										#return min
		jr $ra
		nop
		
		
	sort:															#void sort(int n)
		addiu $sp, $sp, -28							#malloc
		move $t0, $a0										#n -> $t0
																		#for (int i = 0; i < n; i ++)
		li $t1, 0												#i -> $t1, i = 0
		for_4_begin:	
			slt $t2, $t1, $t0							#i < n
			beq $t2, $zero, for_4_end
			nop
																		#{
			move $a0, $t0									#args -> findmin
			move $a1, $t1
			sw $t1, 24($sp)								#tmps -> stack
			sw $t0, 20($sp)
			sw $ra, 16($sp)
			jal findmin										#findmin(n, i)
			nop
			lw $ra, 16($sp)								#stack -> tmps
			lw $t0, 20($sp)
			lw $t1, 24($sp)
			
			sll $t2, $t1, 2
			sll $t3, $v0, 2
			lw $t4, array($t3)							#swap array[i] & array[min]
			lw $t5, array($t2)
			sw $t4, array($t2)
			sw $t5, array($t3)
																		#}
			addi $t1, $t1, 1								#i ++
			j for_4_begin
			nop
		for_4_end:
		
		addiu $sp, $sp, 28								#free
		
		jr $ra														#return
		nop
