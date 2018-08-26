#Guojun Chen - 1400011379
#3/28/2018
#Simple Input and Output
		.data
WORD_LETTERS:	.asciiz "lpha\n\0ravo\n\0hina\n\0elta\n\0cho\n\0oxtrot\n\0olf\n\0otel\n\0ndia\n\0uliet\n\0ilo\n\0ima\n\0ary\n\0ovember\n\0scar\n\0aper\n\0uebec\n\0esearch\n\0ierra\n\0ango\n\0niform\n\0ictor\n\0hisky\n\0-ray\n\0ankee\n\0ulu\n\0"
WORD_NUMBERS:	.asciiz	"Zero\n\0First\n\0Second\n\0Third\n\0Fourth\n\0Fifth\n\0Sixth\n\0Seventh\n\0Eighth\n\0Ninth\n\0"
WORD_OTHER:	.asciiz "*\n\0"
ENDL:	.asciiz "\n"
OFF_W:	.word	0,6,12,18,24,29,37,42,48,54,61,66,71,76,85,91,97,104,113,120,126,134,141,148,154,161
OFF_N:	.word	0,6,13,21,28,36,43,50,59,67
NOTES:	.asciiz "\nNAME: Guojun Chen\nID: 1400011379"

		.text
	li $t6, 0x10010040
	sw $zero, ($t6)
	li $t7, 1
	sw $t7, 4($t6)
	li $t3, 0
	li $t4, 4
	li $t5, 8
	li $t8, 0x2c
	li $t9, 0x14

LOOP:
	add $t7, $t6, $t3
	lw $t0, ($t7)
	add $t7, $t6, $t4
	lw $t1, ($t7)
	add $t7, $t6, $t5
	add $t2, $t0, $t1
	sw $t2, ($t7)
	move $t3, $t4
	move $t4, $t5
	addi $t5, $t5, 4
	bgt $t5, $t8, EXIT
	blt $t2, $t9, LOOP
EXIT: