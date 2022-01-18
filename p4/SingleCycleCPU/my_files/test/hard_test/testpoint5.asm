li		$t2,80
sw		$t2,0($0)
li		$t2,-10
sw		$t2,4($0)
li		$t2,-9
sw		$t2,8($0)
li		$t2,-8
sw		$t2,12($0)
li		$t2,-7
sw		$t2,16($0)
li		$t2,-6
sw		$t2,20($0)
li		$t2,-5
sw		$t2,24($0)
li		$t2,-4
sw		$t2,28($0)
li		$t2,-3
sw		$t2,32($0)
li		$t2,-2
sw		$t2,36($0)
li		$t2,-1
sw		$t2,40($0)
li		$t2,0
sw		$t2,44($0)
li		$t2,1
sw		$t2,48($0)
li		$t2,2
sw		$t2,52($0)
li		$t2,3
sw		$t2,56($0)
li		$t2,4
sw		$t2,60($0)
li		$t2,5
sw		$t2,64($0)
li		$t2,6
sw		$t2,68($0)
li		$t2,7
sw		$t2,72($0)
li		$t2,8
sw		$t2,76($0)
li		$t2,9
sw		$t2,80($0)
li		$t2,10
sw		$t2,84($0)
li		$t2,2147483647
sw		$t2,88($0)
li		$t2,-2147483648
sw		$t2,92($0)

#-----------------------------------------

addi	$1,$1,23333
addi	$2,$2,23333
addi	$3,$3,23333
addi	$4,$4,23333
addi	$5,$5,23333
addi	$6,$6,23333
addi	$7,$7,23333
addi	$8,$8,23333
addi	$9,$9,23333
addi	$10,$10,23333
addi	$11,$11,23333
addi	$12,$12,23333
addi	$13,$13,23333
addi	$14,$14,23333
addi	$15,$15,23333
addi	$16,$16,23333
addi	$17,$17,23333
addi	$18,$18,23333
addi	$19,$19,23333
addi	$20,$20,23333
addi	$21,$21,23333
addi	$22,$22,23333
addi	$23,$23,23333
addi	$24,$24,23333
addi	$25,$25,23333
addi	$26,$26,23333
addi	$27,$27,23333
addi	$28,$28,23333
addi	$29,$29,23333
addi	$30,$30,23333
addi	$31,$31,23333

addi	$s0,$0,100
addi	$s2,$0,0
addi	$s1,$0,96

LOOP_BEGIN1:
	beq 	$s2,$s1,END_LOOP1
	lw		$t0,0($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,4
	j		LOOP_BEGIN1
END_LOOP1:

addi	$s2,$0,0
addi	$s1,$0,96

LOOP_BEGIN2:
	beq 	$s2,$s1,END_LOOP2
	lh		$t0,0($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,2
	j		LOOP_BEGIN2
END_LOOP2:

addi	$s2,$0,0
addi	$s1,$0,96

LOOP_BEGIN3:
	beq 	$s2,$s1,END_LOOP3
	lhu		$t0,0($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,2
	j		LOOP_BEGIN3
END_LOOP3:

addi	$s2,$0,0
addi	$s1,$0,96

LOOP_BEGIN4:
	beq 	$s2,$s1,END_LOOP4
	lb		$t0,0($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,1
	j		LOOP_BEGIN4
END_LOOP4:

addi	$s2,$0,0
addi	$s1,$0,96

LOOP_BEGIN5:
	beq 	$s2,$s1,END_LOOP5
	lbu		$t0,0($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,1
	j		LOOP_BEGIN5
END_LOOP5:

addi	$s2,$0,4
addi	$s1,$0,96

LOOP_BEGINA1:
	beq 	$s2,$s1,END_LOOPA1
	lw		$t0,-4($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,4
	j		LOOP_BEGINA1
END_LOOPA1:

addi	$s2,$0,6
addi	$s1,$0,96

LOOP_BEGINA2:
	beq 	$s2,$s1,END_LOOPA2
	lh		$t0,-6($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,2
	j		LOOP_BEGINA2
END_LOOPA2:

addi	$s2,$0,2
addi	$s1,$0,96

LOOP_BEGINA3:
	beq 	$s2,$s1,END_LOOPA3
	lhu		$t0,-2($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,2
	j		LOOP_BEGINA3
END_LOOPA3:

addi	$s2,$0,5
addi	$s1,$0,96

LOOP_BEGINA4:
	beq 	$s2,$s1,END_LOOPA4
	lb		$t0,-5($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,1
	j		LOOP_BEGINA4
END_LOOPA4:

addi	$s2,$0,3
addi	$s1,$0,96

LOOP_BEGINA5:
	beq 	$s2,$s1,END_LOOPA5
	lbu		$t0,-3($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,1
	j		LOOP_BEGINA5
END_LOOPA5:

addi	$s2,$0,-4
addi	$s1,$0,96

LOOP_BEGINS1:
	beq 	$s2,$s1,END_LOOPS1
	lw		$t0,4($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,4
	j		LOOP_BEGINS1
END_LOOPS1:

addi	$s2,$0,-6
addi	$s1,$0,96

LOOP_BEGINS2:
	beq 	$s2,$s1,END_LOOPS2
	lh		$t0,6($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,2
	j		LOOP_BEGINS2
END_LOOPS2:

addi	$s2,$0,-2
addi	$s1,$0,96

LOOP_BEGINS3:
	beq 	$s2,$s1,END_LOOPS3
	lhu		$t0,2($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,2
	j		LOOP_BEGINS3
END_LOOPS3:

addi	$s2,$0,-5
addi	$s1,$0,96

LOOP_BEGINS4:
	beq 	$s2,$s1,END_LOOPS4
	lb		$t0,5($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,1
	j		LOOP_BEGINS4
END_LOOPS4:

addi	$s2,$0,-3
addi	$s1,$0,96

LOOP_BEGINS5:
	beq 	$s2,$s1,END_LOOPS5
	lbu		$t0,3($s2)
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,1
	j		LOOP_BEGINS5
END_LOOPS5:

#-----------------------------------------

addi	$s2,$0,0
addi	$s1,$0,96
addi	$s0,$s0,8

LOOP_BEGIN6:
	beq 	$s2,$s1,END_LOOP6
	lw		$t0,0($s2)
	sw		$t0,-4($s0)
	addi	$s0,$s0,4
	sw		$t0,0($s0)
	addi	$s0,$s0,4
	sw		$t0,4($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,4
	j		LOOP_BEGIN6
END_LOOP6:

addi	$s2,$0,0
addi	$s1,$0,96
addi	$s0,$s0,8

LOOP_BEGIN7:
	beq 	$s2,$s1,END_LOOP7
	lw		$t0,0($s2)
	sh		$t0,-6($s0)
	addi	$s0,$s0,4
	sh		$t0,-4($s0)
	addi	$s0,$s0,4
	sh		$t0,-2($s0)
	addi	$s0,$s0,4
	sh		$t0,0($s0)
	addi	$s0,$s0,4
	sh		$t0,2($s0)
	addi	$s0,$s0,4
	sh		$t0,4($s0)
	addi	$s0,$s0,4
	sh		$t0,6($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,4
	j		LOOP_BEGIN7
END_LOOP7:

addi	$s2,$0,0
addi	$s1,$0,96
addi	$s0,$s0,8

LOOP_BEGIN8:
	beq 	$s2,$s1,END_LOOP8
	lw		$t0,0($s2)
	sb		$t0,-5($s0)
	addi	$s0,$s0,4
	sb		$t0,-4($s0)
	addi	$s0,$s0,4
	sb		$t0,-3($s0)
	addi	$s0,$s0,4
	sb		$t0,-2($s0)
	addi	$s0,$s0,4
	sb		$t0,-1($s0)
	addi	$s0,$s0,4
	sb		$t0,0($s0)
	addi	$s0,$s0,4
	sb		$t0,1($s0)
	addi	$s0,$s0,4
	sb		$t0,2($s0)
	addi	$s0,$s0,4
	sb		$t0,3($s0)
	addi	$s0,$s0,4
	sb		$t0,4($s0)
	addi	$s0,$s0,4
	sb		$t0,5($s0)
	addi	$s0,$s0,4
	addi	$s2,$s2,4
	j		LOOP_BEGIN8
END_LOOP8:

addi	$t2,$0,2222
sw		$t2,0($s0)
addi	$s0,$s0,4
addi	$t2,$0,3333
sw		$t2,0($s0)
addi	$s0,$s0,4
addi	$t2,$0,4444
sw		$t2,0($s0)
addi	$s0,$s0,4