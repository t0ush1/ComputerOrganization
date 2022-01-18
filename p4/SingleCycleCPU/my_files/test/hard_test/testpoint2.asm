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

#--------------------------------------------

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

addi	$s0,$0,0
addi	$s2,$0,0
addi	$s1,$0,40

LOOP_BGEIN1:
	beq		$s0,$s1,END_LOOP1
	slti	$t0,$s0,30
	beq		$t0,$0,UPPER1
	slti	$t0,$s0,10
	beq		$t0,$0,MID1
	LOWER1:
		addi	$t0,$0,-1
		sw		$t0,0($s2)
		addi	$s2,$s2,4
		j		OUT1
	MID1:
		addi	$t0,$0,0
		sw		$t0,0($s2)
		addi	$s2,$s2,4
		j		OUT1
	UPPER1:
		addi	$t0,$0,1
		sw		$t0,0($s2)
		addi	$s2,$s2,4
	OUT1:
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	addi	$s0,$s0,1
	j 		LOOP_BGEIN1

END_LOOP1:

addi	$s1,$0,40
addi	$s0,$0,0

LOOP_BGEIN2:
	beq		$s0,$s1,END_LOOP2
	slti	$t0,$s0,10
	bne		$t0,$0,LOWER2
	slti	$t0,$s0,30
	bne		$t0,$0,MID2
	UPPER2:
		addi	$t0,$0,1
		sw		$t0,0($s2)
		addi	$s2,$s2,4
		j		OUT2
	MID2:
		addi	$t0,$0,0
		sw		$t0,0($s2)
		addi	$s2,$s2,4
		j		OUT2
	LOWER2:
		addi	$t0,$0,-1
		sw		$t0,0($s2)
		addi	$s2,$s2,4
	OUT2:
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	addi	$s0,$s0,1
	j 		LOOP_BGEIN2

END_LOOP2:

addi	$s0,$0,1
addi	$s1,$0,1
beq		$s0,$s1,FLASE1

FRUE1:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT1
FLASE1:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT1:

addi	$s0,$0,1
addi	$s1,$0,2
beq		$s0,$s1,FLASE2

FRUE2:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT2
FLASE2:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT2:

addi	$s0,$0,-1
addi	$s1,$0,-1
beq		$s0,$s1,FLASE3

FRUE3:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT3
FLASE3:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT3:

addi	$s0,$0,-2
addi	$s1,$0,-3
beq		$s0,$s1,FLASE4

FRUE4:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT4
FLASE4:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT4:

addi	$s0,$0,1
addi	$s1,$0,-1
beq		$s0,$s1,FLASE5

FRUE5:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT5
FLASE5:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT5:

addi	$s0,$0,-1
addi	$s1,$0,1
beq		$s0,$s1,FLASE6

FRUE6:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT6
FLASE6:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT6:

addi	$s0,$0,0
addi	$s1,$0,1
beq		$s0,$s1,FLASE7

FRUE7:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT7
FLASE7:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT7:

addi	$s0,$0,0
addi	$s1,$0,-1
beq		$s0,$s1,FLASE8

FRUE8:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT8
FLASE8:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT8:

addi	$s0,$0,1
addi	$s1,$0,0
beq		$s0,$s1,FLASE9

FRUE9:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT9
FLASE9:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT9:

addi	$s0,$0,-1
addi	$s1,$0,0
beq		$s0,$s1,FLASE10

FRUE10:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT10
FLASE10:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT10:

addi	$s0,$0,0
addi	$s1,$0,0
beq		$s0,$s1,FLASE11

FRUE11:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NEXT11
FLASE11:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NEXT11:

#-------------------------------

addi	$s0,$0,1
addi	$s1,$0,1
bne		$s0,$s1,NFLASE1

NFRUE1:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT1
NFLASE1:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT1:

addi	$s0,$0,1
addi	$s1,$0,2
bne		$s0,$s1,NFLASE2

NFRUE2:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT2
NFLASE2:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT2:

addi	$s0,$0,-1
addi	$s1,$0,-1
bne		$s0,$s1,NFLASE3

NFRUE3:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT3
NFLASE3:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT3:

addi	$s0,$0,-2
addi	$s1,$0,-3
bne		$s0,$s1,NFLASE4

NFRUE4:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT4
NFLASE4:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT4:

addi	$s0,$0,1
addi	$s1,$0,-1
bne		$s0,$s1,NFLASE5

NFRUE5:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT5
NFLASE5:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT5:

addi	$s0,$0,-1
addi	$s1,$0,1
bne		$s0,$s1,NFLASE6

NFRUE6:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT6
NFLASE6:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT6:

addi	$s0,$0,0
addi	$s1,$0,1
bne		$s0,$s1,NFLASE7

NFRUE7:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT7
NFLASE7:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT7:

addi	$s0,$0,0
addi	$s1,$0,-1
bne		$s0,$s1,NFLASE8

NFRUE8:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT8
NFLASE8:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT8:

addi	$s0,$0,1
addi	$s1,$0,0
bne		$s0,$s1,NFLASE9

NFRUE9:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT9
NFLASE9:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT9:

addi	$s0,$0,-1
addi	$s1,$0,0
bne		$s0,$s1,NFLASE10

NFRUE10:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT10
NFLASE10:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT10:

addi	$s0,$0,0
addi	$s1,$0,0
bne		$s0,$s1,NFLASE11

NFRUE11:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		NNEXT11
NFLASE11:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
NNEXT11:

#-------------------------------

addi	$s0,$0,1
bgtz	$s0,GTFLASE1

GTFRUE1:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		GTNEXT1
GTFLASE1:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
GTNEXT1:

addi	$s0,$0,-1
bgtz	$s0,GTFLASE2

GTFRUE2:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		GTNEXT2
GTFLASE2:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
GTNEXT2:

addi	$s0,$0,32767
bgtz	$s0,GTFLASE3

GTFRUE3:
	addi	$s0,$0,-32768
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		GTNEXT3
GTFLASE3:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
GTNEXT3:

addi	$s0,$0,2315
bgtz	$s0,GTFLASE4

GTFRUE4:
	addi	$s0,$0,-4523
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		GTNEXT4
GTFLASE4:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
GTNEXT4:

addi	$s0,$0,0
bgtz	$s0,GTFLASE5

GTFRUE5:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		GTNEXT5
GTFLASE5:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
GTNEXT5:

#-------------------------------

addi	$s0,$0,1
bgez	$s0,GEFLASE1

GEFRUE1:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		GENEXT1
GEFLASE1:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
GENEXT1:

addi	$s0,$0,-1
bgez	$s0,GEFLASE2

GEFRUE2:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		GENEXT2
GEFLASE2:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
GENEXT2:

addi	$s0,$0,32767
bgez	$s0,GEFLASE3

GEFRUE3:
	addi	$s0,$0,-32768
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		GENEXT3
GEFLASE3:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
GENEXT3:

addi	$s0,$0,2315
bgez	$s0,GEFLASE4

GEFRUE4:
	addi	$s0,$0,-4523
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		GENEXT4
GEFLASE4:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
GENEXT4:

addi	$s0,$0,0
bgez	$s0,GEFLASE5

GEFRUE5:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		GENEXT5
GEFLASE5:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
GENEXT5:

#-------------------------------

addi	$s0,$0,1
bltz	$s0,LTFLASE1

LTFRUE1:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		LTNEXT1
LTFLASE1:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
LTNEXT1:

addi	$s0,$0,-1
bltz	$s0,LTFLASE2

LTFRUE2:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		LTNEXT2
LTFLASE2:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
LTNEXT2:

addi	$s0,$0,32767
bltz	$s0,LTFLASE3

LTFRUE3:
	addi	$s0,$0,-32768
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		LTNEXT3
LTFLASE3:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
LTNEXT3:

addi	$s0,$0,2315
bltz	$s0,LTFLASE4

LTFRUE4:
	addi	$s0,$0,-4523
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		LTNEXT4
LTFLASE4:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
LTNEXT4:

addi	$s0,$0,0
bltz	$s0,LTFLASE5

LTFRUE5:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		LTNEXT5
LTFLASE5:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
LTNEXT5:

#-------------------------------

addi	$s0,$0,1
blez	$s0,LEFLASE1

LEFRUE1:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		LENEXT1
LEFLASE1:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
LENEXT1:

addi	$s0,$0,-1
blez	$s0,LEFLASE2

LEFRUE2:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		LENEXT2
LEFLASE2:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
LENEXT2:

addi	$s0,$0,32767
blez	$s0,LEFLASE3

LEFRUE3:
	addi	$s0,$0,-32768
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		LENEXT3
LEFLASE3:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
LENEXT3:

addi	$s0,$0,2315
blez	$s0,LEFLASE4

LEFRUE4:
	addi	$s0,$0,-4523
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		LENEXT4
LEFLASE4:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
LENEXT4:

addi	$s0,$0,0
blez	$s0,LEFLASE5

LEFRUE5:
	addi	$s0,$0,1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
	j		LENEXT5
LEFLASE5:
	addi	$s0,$0,-1
	sw		$s0,0($s2)
	addi	$s2,$s2,4
LENEXT5:

addi	$t2,$0,2222
sw		$t2,0($s2)
addi	$s2,$s2,4
addi	$t2,$0,3333
sw		$t2,0($s2)
addi	$s2,$s2,4
addi	$t2,$0,4444
sw		$t2,0($s2)
addi	$s2,$s2,4