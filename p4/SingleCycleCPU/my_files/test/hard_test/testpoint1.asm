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

addi	$s1,$0,40
addi	$s2,$0,0

la		$a1,TAG5
add		$t2,$0,$a1
jalr	$a0,$t2
sw		$t1,0($s2)
addi	$s2,$s2,4

la		$a1,TAG7
add		$t2,$0,$a1
jalr	$a0,$t2
sw		$t1,0($s2)
addi	$s2,$s2,4

la		$a1,TAG18
add		$t2,$0,$a1
jalr	$a0,$t2
sw		$t1,0($s2)
addi	$s2,$s2,4

la		$a1,TAG15
add		$t2,$0,$a1
jalr	$a0,$t2
sw		$t1,0($s2)
addi	$s2,$s2,4

la		$a1,TAG2
add		$t2,$0,$a1
jalr	$a0,$t2
sw		$t1,0($s2)
addi	$s2,$s2,4

j		AFTER

TAG1:
addi	$t1,$0,1
jr		$a0
TAG2:
addi	$t1,$0,2
jr		$a0
TAG3:
addi	$t1,$0,3
jr		$a0
TAG4:
addi	$t1,$0,4
jr		$a0
TAG5:
addi	$t1,$0,5
jr		$a0
TAG6:
addi	$t1,$0,6
jr		$a0
TAG7:
addi	$t1,$0,7
jr		$a0
TAG8:
addi	$t1,$0,8
jr		$a0
TAG9:
addi	$t1,$0,9
jr		$a0
TAG10:
addi	$t1,$0,10
jr		$a0
TAG11:
addi	$t1,$0,11
jr		$a0
TAG12:
addi	$t1,$0,12
jr		$a0
TAG13:
addi	$t1,$0,13
jr		$a0
TAG14:
addi	$t1,$0,14
jr		$a0
TAG15:
addi	$t1,$0,15
jr		$a0
TAG16:
addi	$t1,$0,16
jr		$a0
TAG17:
addi	$t1,$0,17
jr		$a0
TAG18:
addi	$t1,$0,18
jr		$a0
TAG19:
addi	$t1,$0,19
jr		$a0
TAG20:
addi	$t1,$0,20
jr		$a0

AFTER:

la		$a0,TAG13
add		$t2,$0,$a0
jalr	$a0,$t2
sw		$t1,0($s2)
addi	$s2,$s2,4

la		$a0,TAG9
add		$t2,$0,$a0
jalr	$a0,$t2
sw		$t1,0($s2)
addi	$s2,$s2,4

la		$a0,TAG1
add		$t2,$0,$a0
jalr	$a0,$t2
sw		$t1,0($s2)
addi	$s2,$s2,4

la		$a0,TAG17
add		$t2,$0,$a0
jalr	$a0,$t2
sw		$t1,0($s2)
addi	$s2,$s2,4

la		$a0,TAG10
add		$t2,$0,$a0
jalr	$a0,$t2
sw		$t1,0($s2)
addi	$s2,$s2,4

addi	$s0,$0,0
j		LOOP_BGEIN1

PRINT11:
	addi	$t0,$0,-1
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$31
PRINT12:
	addi	$t0,$0,0
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$31
PRINT13:
	addi	$t0,$0,1
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$31

LOOP_BGEIN1:
	beq		$s0,$s1,END_LOOP1
	slti	$t0,$s0,30
	beq		$t0,$0,UPPER1
	slti	$t0,$s0,10
	beq		$t0,$0,MID1
	LOWER1:
		jal		PRINT11
		j		OUT1
	MID1:
		jal		PRINT12
		j		OUT1
	UPPER1:
		jal		PRINT13
		j		OUT1
	OUT1:
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	addi	$s0,$s0,1
	j		LOOP_BGEIN1
END_LOOP1:

addi	$s0,$0,0

LOOP_BGEIN2:
	beq		$s0,$s1,END_LOOP2
	slti	$t0,$s0,30
	beq		$t0,$0,UPPER2
	slti	$t0,$s0,10
	beq		$t0,$0,MID2
	LOWER2:
		jal		PRINT21
		j		OUT2
	MID2:
		jal		PRINT22
		j		OUT2
	UPPER2:
		jal		PRINT23
		j		OUT2
	OUT2:
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	addi	$s0,$s0,1
	j		LOOP_BGEIN2
END_LOOP2:
	j		TEST3

PRINT21:
	addi	$t0,$0,-1
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$31
PRINT22:
	addi	$t0,$0,0
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$31
PRINT23:
	addi	$t0,$0,1
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$31

TEST3:

addi	$s0,$0,0

LOOP_BGEIN3:
	beq		$s0,$s1,END_LOOP3
	slti	$t0,$s0,30
	j		SKIP1
	PRINT31:
		addi	$t0,$0,-1
		sw		$t0,0($s2)
		addi	$s2,$s2,4
		jr		$31
	SKIP1:
	beq		$t0,$0,UPPER3
	slti	$t0,$s0,10
	beq		$t0,$0,MID3
	LOWER3:
		jal		PRINT31
		j		SKIP3
		PRINT33:
			addi	$t0,$0,1
			sw		$t0,0($s2)
			addi	$s2,$s2,4
			jr		$31
		SKIP3:
		j		OUT3
	MID3:
		jal		PRINT32
		j		OUT3
	UPPER3:
		jal		PRINT33
		j		OUT3
	OUT3:
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		SKIP2
	PRINT32:
		addi	$t0,$0,0
		sw		$t0,0($s2)
		addi	$s2,$s2,4
		jr		$31
	SKIP2:
	addi	$s0,$s0,1
	j		LOOP_BGEIN3
END_LOOP3:

j		LOOP_BGEINN1

PRINTN11:
	addi	$a0,$31,0
	addi	$t0,$0,-1
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$a0
PRINTN12:
	addi	$a0,$31,0
	addi	$t0,$0,0
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$a0
PRINTN13:
	addi	$a0,$31,0
	addi	$t0,$0,1
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$a0

addi	$s0,$0,0

LOOP_BGEINN1:
	beq		$s0,$s1,END_LOOPN1
	slti	$t0,$s0,30
	beq		$t0,$0,UPPERN1
	slti	$t0,$s0,10
	beq		$t0,$0,MIDN1
	LOWERN1:
		jal		PRINTN11
		j		OUTN1
	MIDN1:
		jal		PRINTN12
		j		OUTN1
	UPPERN1:
		jal		PRINTN13
		j		OUTN1
	OUTN1:
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	addi	$s0,$s0,1
	j		LOOP_BGEINN1
END_LOOPN1:

addi	$s0,$0,0

LOOP_BGEINN2:
	beq		$s0,$s1,END_LOOPN2
	slti	$t0,$s0,30
	beq		$t0,$0,UPPERN2
	slti	$t0,$s0,10
	beq		$t0,$0,MIDN2
	LOWERN2:
		jal		PRINTN21
		j		OUTN2
	MIDN2:
		jal		PRINTN22
		j		OUTN2
	UPPERN2:
		jal		PRINTN23
		j		OUTN2
	OUTN2:
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	addi	$s0,$s0,1
	j		LOOP_BGEINN2
END_LOOPN2:
	j		TESTN3

PRINTN21:
	addi	$a0,$31,0
	addi	$t0,$0,-1
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$a0
PRINTN22:
	addi	$a0,$31,0
	addi	$t0,$0,0
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$a0
PRINTN23:
	addi	$a0,$31,0
	addi	$t0,$0,1
	sw		$t0,0($s2)
	addi	$s2,$s2,4
	jr		$a0

TESTN3:

addi	$s0,$0,0

LOOP_BGEINN3:
	beq		$s0,$s1,END_LOOPN3
	slti	$t0,$s0,30
	j		SKIPN1
	PRINTN31:
		addi	$a0,$31,0
		addi	$t0,$0,-1
		sw		$t0,0($s2)
		addi	$s2,$s2,4
		jr		$a0
	SKIPN1:
	beq		$t0,$0,UPPERN3
	slti	$t0,$s0,10
	beq		$t0,$0,MIDN3
	LOWERN3:
		jal		PRINTN31
		j		SKIPN3
		PRINTN33:
			addi	$a0,$31,0
			addi	$t0,$0,1
			sw		$t0,0($s2)
			addi	$s2,$s2,4
			jr		$a0
		SKIPN3:
		j		OUTN3
	MIDN3:
		jal		PRINTN32
		j		OUTN3
	UPPERN3:
		jal		PRINTN33
		j		OUTN3
	OUTN3:
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		SKIPN2
	PRINTN32:
		addi	$a0,$31,0
		addi	$t0,$0,0
		sw		$t0,0($s2)
		addi	$s2,$s2,4
		jr		$a0
	SKIPN2:
	addi	$s0,$s0,1
	j		LOOP_BGEINN3
END_LOOPN3:

addi	$t2,$0,2222
sw		$t2,0($s2)
addi	$s2,$s2,4
addi	$t2,$0,3333
sw		$t2,0($s2)
addi	$s2,$s2,4
addi	$t2,$0,4444
sw		$t2,0($s2)
addi	$s2,$s2,4