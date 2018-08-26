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
INPUT:
	li	$v0, 12				#input a char
	syscall
	li	$t7, 0x3F			#'?'
	beq	$v0, $t7, ENDD
	move $t6, $v0			#save the input letter (if it's number, this line is no use)
	move $t5, $v0			#free the $v0 for syscall

	la	$a0, ENDL			#endl
	li	$v0, 4
	syscall
	
	addi $t5, $t6, -0x30	#subtract with '0'
	sltiu $t1, $t5, 10		#unsigned compare, is input in '0'~'9'?
	bnez $t1, CASE_NUMBER
	addi $t5, $t6, -0x41	#subtract with 'A'
	sltiu $t1, $t5, 26		#unsigned compare, is input in 'A'~'Z'?
	bnez $t1, CASE_LETTER
	addi $t5, $t6, -0x61	#subtract with 'a'
	sltiu $t1, $t5, 26		#unsigned compare, is input in 'a'~'z'?
	bnez $t1, CASE_LETTER
	j 	CASE_OTHER			#not number or letter
	
CASE_LETTER:		
	sll	$t1, $t5, 2			#get the offset in OFF_W
	la	$t2, OFF_W
	add $t2, $t2, $t1
	lw	$t3, ($t2)
	la 	$t2, WORD_LETTERS
	
	move $a0, $t6			#print first letter of words
	li	$v0, 11
	syscall
	
	add $a0, $t2, $t3		#get the rest of word for input letter
	li	$v0, 4
	syscall
	j	INPUT
	
CASE_NUMBER:
	sll	$t1, $t5, 2			#get the offset in OFF_N
	la	$t2, OFF_N
	add $t2, $t2, $t1
	lw	$t3, ($t2)			#get the offset in NUMBS
	la 	$t2, WORD_NUMBERS
	add $a0, $t2, $t3		#get the word for input number
	li	$v0, 4
	syscall
	j	INPUT
	
CASE_OTHER:
	la	$a0, WORD_OTHER			#print '*'
	li	$v0, 4
	syscall
	j	INPUT
	
ENDD:
	la	$a0, NOTES			#print author
	li	$v0, 4
	syscall
	li	$v0, 10				#exit
	syscall
