	# AdEL_Instr
	ori $1, $0, 0x300e
	ori $2, $0, 0x2fff
	ori $3, $0, 0x6ffd
	jr $1
	nop
	jr $2
	nop
	jr $3
	nop
	jalr $31, $1
	nop
	jalr $31, $2
	nop
	jalr $31, $3
	nop