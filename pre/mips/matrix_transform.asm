.data
	array: .space 30000							#int array[2500][3]
	space: .asciiz " "
	line: .asciiz "\n"
	
.macro readInt(%x)									#i	nput int -> $x
	li $v0, 5
	syscall
	move %x, $v0
.end_macro

.macro writeInt(%x)								#output int $x
	move $a0, %x
	li $v0, 1
	syscall
.end_macro

.macro writeString(%s)							#output string $s
	la $a0, %s
	li $v0, 4
	syscall
.end_macro

.macro getOffset(%i, %off)					#%off = %i * sizeof(array[0])
	li %off 12
	mult %i, %off
	mflo %off
.end_macro

.text
	readInt($t0)											#input n -> $t0
	readInt($t1)											#input m -> $t1
	li $t2, 0												#cnt = 0 -> $t2
																	#for (int i = 0; i < n; i ++)
	li $t3, 0												#i = 0 -> $t3
	for_1_begin:
	bge $t3, $t0, for_1_end					#i < n
																	#for (int j = 0; j < m; j ++)
		li $t4, 0											#j = 0 -> $t4
		for_2_begin:
		bge $t4, $t1, for_2_end				#j < m
			
			readInt($t5)									#input a -> $t5
			beq $t5, $zero, if_1_end			#if (a != 0)
				getOffset($t2, $t6)				#array[cnt][0] = i + 1
				addi $t7, $t3, 1
				sw $t7, array($t6)
				
				addi $t6, $t6, 4						#array[cnt][1] = j + 1
				addi $t7, $t4, 1
				sw $t7, array($t6)
				
				addi $t6, $t6, 4						#array[cnt][2] = a
				sw $t5, array($t6)
				
				addi $t2, $t2, 1						#cnt ++
			if_1_end:
			
		addi $t4, $t4, 1								#j ++
		j for_2_begin
		for_2_end:	
	
	addi $t3, $t3, 1									#i ++
	j for_1_begin
	for_1_end:
				
	while_1_begin:										#while (cnt > 0)
	ble $t2, $zero, while_1_end
		subi $t2, $t2, 1								#cnt --
		
		getOffset($t2, $t0)						#output array[cnt][0]
		lw $t1, array($t0)
		writeInt($t1)
		writeString(space)
		
		addi $t0, $t0, 4								#output array[cnt][1]
		lw $t1, array($t0)
		writeInt($t1)
		writeString(space)
		
		addi $t0, $t0, 4								#output array[cnt][2]
		lw $t1, array($t0)
		writeInt($t1)
		writeString(line)
	j while_1_begin
	while_1_end:
	
	li $v0, 10												#end
	syscall
