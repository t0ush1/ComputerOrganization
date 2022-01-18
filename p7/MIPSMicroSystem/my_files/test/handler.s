.ktext 0x4180
	
	mfc0 $k0, $12
	mfc0 $k0, $13
	mfc0 $k0, $14

	mfhi $k0
	mflo $k0

	addiu $k1, $k1, 16
	mtc0 $k1, $14
	eret
	mfc0 $k0, $14