#Guojun Chen - 1400011379
#3/28/2018
#Search a charactor in a string input
		.data
BUFF:	.byte	0:1024
BUFFLEN:.word	1024
INPUT_LEN: .word	0
SUCC:	.asciiz "Success! Location: "
FAIL:	.asciiz "Fail!\n"
ENDL:	.asciiz "\n"
NOTES:	.asciiz "\nNAME: Guojun Chen\nID: 1400011379"
RESULT:	.word	0
		.text
INPUTLINE:
	li	$v0, 8				#input a line (without '?')
	la	$a0, BUFF
	la	$a1, BUFFLEN
	lw	$a1, ($a1)
	syscall

CAL_LENTH:
	move $t0, $zero
	CAL_LOOP:
	add $t2, $a0, $t0
	lb	$t1, ($t2)
	add $t0, $t0, 1
	bnez $t1, CAL_LOOP
	addi $t0, $t0, -2		#ignore the 'enter'
	la	$t3, INPUT_LEN
	sw	$t0, ($t3)			#store the input length
	
INPUTCHAR:
	li	$v0, 12				#input a char
	syscall
	li	$t7, 0x3F			#'?'
	beq	$v0, $t7, ENDD
	move $t6, $v0			#free $v0
	
	la	$a0, ENDL			#endl
	li	$v0, 4
	syscall
	
	lw	$t0, ($t3)			#load the length of input
	la	$a0, BUFF			#get address of string
	move $t1, $zero			#begin with 0
	SEARCH:
	add $t4, $a0, $t1
	add $t1, $t1, 1
	lb	$t5, ($t4)
	beq	$t6, $t5, CASE_SUCC	#find!
	bne $t0, $t1, SEARCH
	
CASE_FAIL:
	la	$a0, FAIL
	li	$v0, 4
	syscall
	j INPUTCHAR
	
CASE_SUCC:
	la	$a0, SUCC
	li	$v0, 4
	syscall
	move $a0, $t1			#print location
	li	$v0, 1
	syscall
	la	$a0, ENDL			#endl
	li	$v0, 4
	syscall
	j INPUTCHAR
	
ENDD:
	la	$a0, NOTES			#print author
	li	$v0, 4
	syscall
	li	$v0, 10				#exit
	syscall