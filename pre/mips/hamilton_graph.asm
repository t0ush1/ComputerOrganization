.data
	adj: .space 256															#int adj[8][8]
	mark: .space 32															#int mark[8]
	
.macro readInt(%x)
	li $v0, 5
	syscall
	move %x, $v0
.end_macro

.macro getOffset(%i, %j, %off)
	add %off, $zero, %i
	sll %off, %off, 3
	add %off, %off, %j
	sll %off, %off, 2
.end_macro

.macro dfs(%v, %cnt)
	add $a0, $zero, %v
	add $a1, $zero, %cnt
	jal dfs
.end_macro

.macro push(%x)
	addi $sp, $sp, -4
	sw %x, 0($sp)
.end_macro

.macro pop(%x)
	lw %x, 0($sp)
	addi $sp, $sp, 4
.end_macro

.text
main:
	readInt($s0)																	#input n -> $s0
	readInt($t1)																	#input m -> $t1
	
	while_1_begin:																#while (m --)
	beq $t1, $zero, while_1_end
	addi $t1, $t1, -1
		readInt($t2)																#input a -> $t2
		readInt($t3)																#input b -> $t3
		li $t0, 1
		getOffset($t2, $t3, $t4)										#adj[a][b] = 1
		sw $t0, adj($t4)
		getOffset($t3, $t2, $t4)										#adj[b][a] = 1
		sw $t0, adj($t4)
	j while_1_begin
	while_1_end:
	
	dfs(1, 1)																		#dfs(1, 1)
	
	move $a0, $v0																#output ret
	li $v0, 1
	syscall
	
	li $v0, 10																		#end
	syscall
	
dfs:
push($t3)
push($t2)
push($t1)
push($t0)
push($ra)
	
	move $t0, $a0
	move $t1, $a1
	
	blt $t1, $s0, if_1_end											#if (cnt == n)
		getOffset($t0, 1, $t2)
		lw $v0, adj($t2)													#return adj[n][1]
		j dfs_return	
	if_1_end:
	
	li $t2, 0																	#ret = 0 -> $t2
	
	li $t3, 1																	#mark[v] = 1
	sll $t4, $t0, 2
	sw $t3, mark($t4)
																						#for (int i = 1; i <= n; i ++)
	li $t3, 1																	#i = 1 -> $t3
	for_1_begin:
	bgt $t3, $s0, for_1_end										#i <= n
		
		sll $t4, $t3, 2													#if (!mark[i] && adj[v][i])
		lw $t5, mark($t4)
		beq $t5, 1, if_2_end
		getOffset($t0, $t3, $t4)
		lw $t5, adj($t4)
		beq $t5, $zero, if_2_end
			addi $t4, $t1, 1												#dfs(i, cnt+1)
			dfs($t3, $t4)
			or $t2, $t2, $v0												#ret |= dfs()
		if_2_end:
		
	addi $t3, $t3, 1														#i ++
	j for_1_begin
	for_1_end:
	
	sll $t3, $t0, 2														#mark[v] = 0
	sw $zero, mark($t3)
	
	move $v0, $t2															#return ret
	
dfs_return:
pop($ra)
pop($t0)
pop($t1)
pop($t2)
pop($t3)
jr $ra
