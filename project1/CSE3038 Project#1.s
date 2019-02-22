#######################################################################
#####################      CSE3038 Project#1      #####################
##################### Burak Canik 		150115502 #####################
##################### Sezin Gümüş 		150113841 #####################
##################### Gülşah Yılmaz 	150113854 #####################
#######################################################################

.data
#Question 1.
arrayV:  		.word 	0:100								# Base addr of arrayV . All elem. init to 0.
arrayV1: 		.word 	0:100								# Base addr of arrayV1. All elem. init to 0.
arrayV2: 		.word 	0:100								# Base addr of arrayV2. All elem. init to 0.
arrayV3: 		.word 	0:100								# Base addr of arrayV3. All elem. init to 0.
                                                              
#Question 2.
strInput: 		.space 	20
charInput: 		.space 	1
strMsg1:   		.asciiz "Enter an input string (max 20 chars): "
strMsg2:   		.asciiz "Enter an input char: "
strMsg3:   		.asciiz "\nThe number of "
strMsg4:   		.asciiz " in "
strMsg5:   		.asciiz " is "
strMsg6:   		.asciiz " ."

#Question 3.
strSkipNumber:  .asciiz "Please enter your choice to skip numbers (1-4): "
strNotBetween:	.asciiz "Your number is not between (1-4)\n"
numbers: 		.word 	100, -7, 11, 25, -66, 99, -1, 34, 12, 22, -2, -7, 100, 11, 4, 67, 2, -90, 22, 2
				.word	56, 3, -89, 12, -10, 21, 10, -25, -6, 9, 111, 34, 12, 22, -2, -17, 100, 111, -4, 7, 14, -19, -2, 29, 36, 31, -79, 2
#strSumIs:		.asciiz "The sum is: "					This is already defined below in Q5.

#Question 4.
#strLength:		.asciiz	"Enter length of array: "		This is already defined below in Q6.
#strElement:	.asciiz	"Enter array element "			This is already defined below in Q6.
#strColon:		.asciiz	": " 							This is already defined below in Q6.
alphabet: 		.byte 	' ', 'A', 'B' ,'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
				.byte		 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
arrayQ4: 		.space 	100 
strT0: 			.asciiz "\n $08 = 0x"
strT1: 			.asciiz "\n $09 = 0x"
#strInvldInpt:	.asciiz	"Invalid input.\n"				This is already defined below in General.

#Question 5.
strBuffer:		.space	40								# String buffer to read into. 40 bytes.
strFrac1:		.asciiz "Enter the first fraction: "
strFrac2:		.asciiz "Enter the second fraction: "
strSumIs:		.asciiz "The sum is: "
	
#Question 6.
tree:			.word	0:100                           # Array for binary tree.
strLength:		.asciiz	"Enter length of array: "
strElement:		.asciiz	"Enter array element "
strColon:		.asciiz	": "
strLengthIs:	.asciiz "Height of the tree is: "

#General.
strMenu:    	.ascii  "Please select an option:\n"
				.ascii  "  1. C-to-MIPS convert\n"
				.ascii  "  2. Char Finder\n"
				.ascii  "  3. Sum of Numbers\n"
				.ascii  "  4. Message Printer\n"
				.ascii  "  5. Sum of Rational Numbers\n"
				.ascii  "  6. Find the Tree Height\n"
				.ascii  "  7. Exit\n"
				.asciiz "Selection: "
strInvldInpt:	.asciiz	"Invalid input.\n"

.text
######################################################################
##########################      text      ############################
######################################################################
.globl main	
main:
	# DISPLAY MENU.
	la 		$a0, strMenu			# Put the address of menu in a0.
	li 		$v0, 4     				# Syscall code for print_string.
	syscall							# Display the menu.
	# GET USER INPUT.
	li 		$v0, 5					# Syscall code for read_int.
	syscall							# Get user input (for choice).
	# ACT ON USER INPUT.
	li 		$t0, 1					# t0 = 1.
	li 		$t1, 2          		# t1 = 2.
	li 		$t2, 3          		# t2 = 3.
	li 		$t3, 4          		# t3 = 4.
	li 		$t4, 5          		# t4 = 5.
	li 		$t5, 6          		# t5 = 6.
	li 		$t6, 7          		# t6 = 7.
	
	beq 	$t6, $v0, Exit			# Branch to "Exit" 	if choice is 7.
	beq 	$t0, $v0, q1 			# Branch to "q1"   	if choice is 1.
	beq 	$t1, $v0, q2            # Branch to "q2"   	if choice is 2.
	beq 	$t2, $v0, q3            # Branch to "q3"   	if choice is 3.
	beq 	$t3, $v0, q4            # Branch to "q4"   	if choice is 4.
	beq 	$t4, $v0, q5			# Branch to "q5"  	if choice is 5.
	beq 	$t5, $v0, q6     		# Branch to "q6"   	if choice is 6.
	
	# Handle invalid input.
	la 		$a0, strInvldInpt		# Put the address of invldInpt in a0.
	li 		$v0, 4     				# Syscall code for print_string.
	syscall							# Display the error prompt.
	j		main					# Jump back to the beginning of the program.

q1:
	la 		$a0, arrayV 			# a0 stores base address of v. 
	li 		$a1, 5 					# a1 (k) keeps the array processing loop count.	
	jal		C_To_MIPS_Convert
	j 		main
q2:
	jal		CharFinder
	j 		main
q3:
	jal		SumOfNumbers
	j 		main
q4:
	jal		MessagePrinter
	j 		main
q5:
	jal		SumOfRationalNumbers
	j		main
q6:
	jal		FindTheTreeHeight
	j 		main
Exit:
	li		$a0, 0					# Return 0 to indicate success.
	li 		$v0, 17					# Syscall code for exit.
	syscall							# Exit.
	
######################################################################
##########################   PROCEDURES   ############################
######################################################################

#######################   C_To_MIPS_Convert   ########################
# Args: a0 = base address of array, a1 = max iteration count k.		 #
# Returns: v0 = first element of the array.							 #
# Does some processing on 3 arrays & sums & prints their 1st elem.	 #
######################################################################
C_To_MIPS_Convert:
	# SAVE REGISTERS.
	addi	$sp, $sp, -32			# Make room on stack for 8 regs.
	sw		$ra, 28( $sp )			# Save ra on stack.
	sw		$a3, 24( $sp )			# Save a3 on stack.
	sw		$a2, 20( $sp )			# Save a2 on stack.
	sw		$a1, 16( $sp )			# Save a1 on stack.
	sw		$a0, 12( $sp )			# Save a0 on stack.
	sw   	$s2,  8( $sp ) 			# Save s2 on stack.
	sw   	$s1,  4( $sp ) 			# Save s1 on stack.
	sw   	$s0,  0( $sp ) 			# Save s0 on stack.
	
	li 		$t1, 100 				# To check the k value which is stored in a1 register.
				
	la 		$s0, arrayV1  			# s0 stores base address of v1.
	la 		$s1, arrayV2  			# s1 stores base address of v2.
	la 		$s2, arrayV3  			# s2 stores base address of v3.
  
	# if( k > 100 )
	slt  	$t2, $t1, 	$a1
	bne  	$t1, $zero, ContinueK100 
		addi 	$v0, $zero, -1 		# Return -1.
		j		FinishCToMIPS

	ContinueK100:
	move 	$t0, $zero 				# t0 (i) = 0.
	# for( i = 0 ; i < k ; i++ )
    Loop1CToMIPS:
		sll 	$t1, $t0,	2 			# t1 = i * 4.
					
		add 	$t2, $t1,	$s0 		# t2 has the address of v1[ i ].
		lw  	$t3, 0( $t2 )  			# t3 = v1[ i ].
		add 	$t4, $t1,	$s1         # t4 has the address of v2[ i ].
		lw  	$t5, 0( $t4 )  			# t5 = v2[ i ].
		add 	$t6, $t1,	$s2         # t6 has the address of v3[ i ].
		lw  	$t7, 0( $t6 )  			# t7 = v3[ i ].
					
		addi 	$t3, $t0,	1  			# t3 		= i + 1.
		sw    	$t3, 0( $t2 )			# v1[ i ] 	= i + 1
		addi 	$t5, $t0,	2  			# t5 		= i + 2.
		sw   	$t5, 0( $t4 ) 			# v2[ i ] 	= i + 2.
		addi 	$t7, $t0,	3  			# t7 		= i + 3.
		sw   	$t7, 0( $t6 )			# v3[ i ] 	= i + 3.
					
		addi 	$t0, $t0,	1			# i++.
		slt  	$a2, $t0,	$a1  		# If i < k,
		bne  	$a2, $zero,	Loop1CToMIPS # Then loop again.
     
    move 	$t0, $zero 				# Re-init i to 0.
    Loop2CToMIPS:       
		sll 	$t1, $t0,	2 			# t1 = i * 4.
					
		add 	$t2, $t1,	$s0 		# t2 has the address of v1[ i ].
		lw  	$t3, 0( $t2 )  			# t3 = v1[ i ].
		add 	$t4, $t1,	$s1         # t4 has the address of v2[ i ].
		lw  	$t5, 0( $t4 )  			# t5 = v2[ i ].
		add 	$t6, $t1,	$s2         # t6 has the address of v3[ i ].
		lw  	$t7, 0( $t6 )  			# t7 = v3[ i ].	
		
		add 	$a3, $t1,	$a0			# a3 = i * 4 + base address of v[]. 
					
		add 	$s3, $t3,	$t5   		# s3 = v1[ i ] + v2[ i ].
		add 	$s3, $s3,	$t7  		# s3 = v1[ i ] + v2[ i ] + v[ 3 ].
		sw  	$s3, 0( $a3 )			# v[ i ] = v1[ i ] + v2[ i ] + v[ 3 ].
					
		addi 	$t0, $t0,	1			# i++.
		slt  	$a2, $t0,	$a1   		# If i < k,
		bne  	$a2, $zero, Loop2CToMIPS # Then loop again.
    
    lw 		$v0, 0( $a0 )    		# Return v[ 0 ] in v0 register.
	
	move	$a0, $v0				# a0 = return value v[ 0 ].
	li 		$v0, 1   				# Syscall code of print_int.
	syscall  						# Print result v[0].
	
	li 		$v0, 11   				# Syscall code of print_char.
	li		$a0, '\n'				# a0 = ASCII of '\n'.
	syscall  						# Print newline.
	syscall  						# Print newline.
		
	FinishCToMIPS:
	# RESTORE REGISTERS.
	lw 		$s0,  0( $sp )          # Restore s0 from stack.
	lw 		$s1,  4( $sp )  		# Restore s1 from stack.
	lw 		$s2,  8( $sp )          # Restore s2 from stack.
	lw		$a0, 12( $sp )			# Restore a0 from stack.
	lw		$a1, 16( $sp )			# Restore a1 from stack.
	lw		$a2, 20( $sp )			# Restore a2 from stack.
	lw		$a3, 24( $sp )			# Restore a3 from stack.
	lw		$ra, 28( $sp )			# Restore ra from stack.
	addi	$sp, $sp, 32			# Restore stack pointer.
	
	jr 		$ra						# Return back to caller.
	
###########################   CharFinder   ###########################
# Args: None		 			 									 #
# Returns: None					 									 #
# Takes a string & a char & finds the occurrences of char in string. #
######################################################################
CharFinder:
	# SAVE REGISTERS.
	addi	$sp, $sp, -24			# Make room on stack for 6 regs.
	sw		$ra, 20( $sp )			# Save ra on stack.
	sw		$a1, 16( $sp )			# Save a1 on stack.
	sw		$a0, 12( $sp )			# Save a0 on stack.
	sw   	$s2,  8( $sp ) 			# Save s2 on stack. Char input base address.
	sw   	$s1,  4( $sp ) 			# Save s1 on stack. String input size. 
	sw   	$s0,  0( $sp ) 			# Save s0 on stack. String input base address.
	
    la 		$a0, strMsg1			# a0 = base address of strMsg1.
    li 		$v0, 4    				# Syscall code of print_string.
    syscall 						# Print strMsg1.

    li 		$v0, 8         			# Syscall code of read_string.
    la 		$a0, strInput  			# a0 = base address of strInput.
    li 		$a1, 20     			# a1 = length of 20.
    syscall        					# Read a string from user into strInput.
	
    move 	$s0, $a0   				# s0 register stores base addr of strInput.
    
    la 		$a0, strMsg2			# a0 = base address of strMsg2.
    li 		$v0, 4        			# Syscall code of print_string.
    syscall 						# Print strMsg2.

    li 		$v0, 12					# Syscall code of read_char.
    syscall        					# Read a char into v0
   
    move 	$s2, $v0   				# s2 stores user entered char.

    move 	$t0, $zero 				# t0 = loop var i. Init to 0.
    move 	$t1, $zero 				# t1 counts how many chars exist in string.

    li   	$s1, 20  				# s1 = Max. size of string.
	Loop1CharFinder:
		add 	$t2, $s0, $t0			# t2 = address of current character in the string.
		lbu 	$t3, 0( $t2 )    		# t3 = current character.
		
		beq 	$t3, $s2, inc   		# if ( strInput[ i ] == char ), go to inc label
	Loop2CharFinder:
		addi 	$t0, $t0, 1     		# i++.
		slt  	$t4, $t0, $s1   		# If i < 20, t4 = 1, otherwise t4 = 0.
		bne  	$t4, $zero Loop1CharFinder # If t4 != 0, go back to loop1.
                        
    la 		$a0, strMsg3     		# a0 = base address of strMsg3.
    li 		$v0, 4          		# Syscall code of print_string.
    syscall							# Print strMsg3.

    move 	$a0, $s2				# a0 = user entered char.
    li 		$v0, 11       			# Syscall code of print_char.
    syscall							# Print user entered char.

    la 		$a0, strMsg4			# a0 = base address of strMsg4.
    li 		$v0, 4         			# Syscall code of print_string.
    syscall                         # Print strMsg4.

    move 	$a0, $s0                # a0 = base address of strInput.
    li 		$v0, 4         			# Syscall code of print_string.
    syscall                         # Print strInput.

    la 		$a0, strMsg5            # a0 = base address of strMsg5.
    li 		$v0, 4        			# Syscall code of print_string.
    syscall                         # Print strMsg5.
 
    move 	$a0, $t1				# a0 = occurrences of char in string.
    li 		$v0, 1         			# Syscall code of print_int.
    syscall          				# Print occurrences of char in string.

    la 		$a0, strMsg6            # a0 = base address of strMsg6.
    li 		$v0, 4        			# Syscall code of print_string.
    syscall                         # Print strMsg6.
   
    # RESTORE REGISTERS.
    lw   	$s0,   0( $sp )         # Restore s0 from stack.
	lw   	$s1,   4( $sp )         # Restore s1 from stack.
	lw   	$s2,   8( $sp )         # Restore s2 from stack.
	lw   	$a0,  12( $sp )         # Restore a0 from stack.
	lw   	$a1,  16( $sp )         # Restore a1 from stack.
	lw   	$ra,  20( $sp )    		# Restore ra from stack.
    addi 	$sp, $sp, 24			# Restore stack pointer.

	jr		$ra
	
	inc:
	addi 	$t1, $t1, 1				# Increment matching char count.
	j 		Loop2CharFinder			# Go back to loop2.
	
##########################   SumOfNumbers   ##########################
# Args: None		 			 									 #
# Returns: None					 									 #
# Computes the sum of numbers in an array, skipping over n numbers.  #
######################################################################
SumOfNumbers:
	# SAVE REGISTERS.
	addi	$sp, $sp, -12			# Make room on stack for 3 regs.
	sw		$ra, 8( $sp )			# Save ra on stack.
	sw		$a0, 4( $sp )			# Save a0 on stack.
	sw		$s0, 0( $sp )			# Save s0 on stack.
	
	li 		$v0, 4                	# Syscall code of print_string.
	la 		$a0, strSkipNumber      # a0 = base address of strSkipNumber.
	syscall							# Print strSkipNumber.
	
    li 		$v0, 5                	# Syscall code of read_int
    syscall                  		# Read skip number from user.

	# Error Checking
    addu 	$t5, $v0, $0        	# t5 = just read number.
    li	 	$t6, 1					# t6 = 1.
    slt 	$t6, $t5, $t6			# t6 = t5 > t6.
    bne 	$t6, $zero, SkipNoError	# if( t6 != 0 ) go to SkipNoError
    addi 	$t7, $t7, 4             # t7 = 4.
    slt 	$t7, $t7, $t5           # t7 = t7 > t5.
    bne 	$t7, $zero, SkipNoError # if( t7 != 0 ) go to SkipNoError

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    li		$s0, 0    				# s0 = sum of numbers.
    la 		$t0, numbers          	# t0 = base address of numbers.
    li		$t1, 48					# t1 = 48 (index of last element in the array + 1).
    add 	$t2, $zero, $zero    	# t2 (i) = 0.
    NumberSumLoop:
            sll 	$t3, $t2, 2         # t3 = i * 4.
            add 	$t3, $t0, $t3		# t3 = base address of numbers + i * 4.
            lw 		$t4, 0( $t3 )       # t4 = numbers[ i ].
            add 	$s0, $s0, $t4       # sum += numbers[ i ].

            add 	$t2, $t2, $t5	    # i = i + skip number
            slt 	$t3, $t2, $t1       # t3 = ( i < size )
            bne 	$t3, $zero, NumberSumLoop # if( t3 != 0 ) go to NumberSumLoop.

	# Print the result.
	li 		$v0, 4                	# Syscall code of print_string.
	la 		$a0, strSumIs      		# a0 = base address of strSumIs.
	syscall							# Print strSumIs.
	
	li 		$v0, 1                	# Syscall code of print_int.
	move 	$a0, $s0	        	# a0 = sum.
	syscall							# Print sum.
	
	la 		$a0, '\n'				# a0 = ASCII of '\n'.
	li 		$v0, 11					# Syscall code of print_char.
	syscall							# Print newline.
	syscall							# Print newline.

	j		FinishSumOfNumbers
	
	SkipNoError:
	li $v0, 4               		# Syscall code of print_string.
	la $a0, strNotBetween           # a0 = base address of strNotBetween.
	syscall							# Print strNotBetween.
	
	FinishSumOfNumbers:
	# RESTORE REGISTERS.
    lw   	$s0, 0( $sp )          # Restore s0 from stack.
	lw   	$a0, 4( $sp )          # Restore a0 from stack.
	lw   	$ra, 8( $sp )          # Restore ra from stack.
    addi 	$sp, $sp, 12           # Restore stack pointer.
	                               
	jr		$ra
	
#########################   MessagePrinter   #########################
# Args: None		 			 									 #
# Returns: None					 									 #
# Takes an array as input from the user and prints letters using it. #
######################################################################
MessagePrinter:
	# SAVE REGISTERS.
	addi	$sp, $sp, -16			# Make room on stack for 4 regs.
	sw		$ra, 12( $sp )			# Save ra on stack.
	sw		$a0,  8( $sp )			# Save a0 on stack.
	sw   	$s2,  4( $sp ) 			# Save s2 on stack.
	sw   	$s1,  0( $sp ) 			# Save s1 on stack.
	
	li 		$v0, 4                	# Syscall code of print_string.
	la 		$a0, strLength        	# a0 = base address of strLength.
	syscall							# Print strLength.
				
	li 		$v0, 5                	# Syscall code of read_int.
	syscall                  		# Read an integer array length from user.

	addu 	$t1, $v0, $zero        	# t1 = user given array length.
	la  	$s2, arrayQ4      		# s2 = address of the array.
	
	xor		$t6, $t6, $t6			# t6 = 0 (loop counter i).
				
	MessageLoop:		
		li 		$v0, 4                	# Syscall code of print_string.
		la 		$a0, strElement         # a0 = base address of strElement.
		syscall							# Print strElement.
		
		move 	$a0, $t6          		# a0 = i.
		li 		$v0, 1              	# Syscall code of print_int.
		syscall							# Print i.
		
		li 		$v0, 4                	# Syscall code of print_string.
		la 		$a0, strColon           # a0 = base address of strColon.
		syscall							# Print strColon.
		
		li 		$v0, 5                	# Syscall code of read_int.
		syscall                  		# Read a value from user.
		
		la    	$t5, alphabet  			# t5 = base address of alphabet.
		addu 	$t0, $v0, $zero        	# t0 = the value user just gave.
		
		# Error-check the size of alphabet.
		li	 	$t3, 0 					# t3 = 0.  
		slt 	$t3, $t0,   $t3			# t3 = t0 < t3
		bne 	$t3, $zero, MsgPrintError # if( t3 != 0 ) go to MsgPrintError.
		li 		$t7, 26					# t7 = 0.
		slt 	$t7, $t7,   $t0			# t7 = t7 < t0.
		bne 	$t7, $zero, MsgPrintError # if( t7 != 0 ) go to MsgPrintError.

		# Put the value inside the array.
		add 	$t5, $t5, $t0  			# Point to the current element in the alphabet.
		lb 		$s1, ( $t5 ) 			# s1 = letter corresponding to given value.
		sb 		$s1, ( $s2 )			# store that value in its place in the array.
		addi 	$s2, $s2, 1				# Increment array index.
			 
		addi 	$t6, $t6, 1  			# i++.
		bne 	$t6, $t1, MessageLoop   # if( i < array length ) go back to MessageLoop.

	# Print the array.
	la 		$a0, arrayQ4			# a0 = base address of arrayQ4.
	li 		$v0, 4					# Syscall code of print_string.
	syscall							# Print arrayQ4.
	
	la 		$a0, '\n'				# a0 = ASCII of '\n'.
	li 		$v0, 11					# Syscall code of print_char.
	syscall							# Print newline.
	
	la 		$a0, strT0
    li 		$v0, 4
   	syscall
	
	la 		$t0, arrayQ4	
   	li 		$t8, 0

	hex:
		andi 	$t9, $t0, 0xf 			# add hex value in here
		slt 	$t3, $t9, 10   			# after 10 Alphabet in hex
		beq 	$t3, 1, jump   
		addi 	$t9, $t9, 7	 			# Alphabet code number 55 other 48 add 7 and complate 55
		jump:	
		addi 	$t9, $t9, 48  			#Otherwise stand 48
		addi 	$sp, $sp, -1  			# reserve one byte value in stack
		sb 		$t9, 0( $sp )	 		# save value in stack because invers of value
   		srl 	$t0, $t0, 4	 			# add t0 4 so other value will be set
		addi 	$t8, $t8, 1   			# add counter
		bne 	$t8, 8, hex	 			# loop
		
		li 		$t8, 0
		
	printhex:	
		lb 		$t9, 0( $sp )   		# load value in stack
		addi 	$sp, $sp, 1  			# increase stack value so next element will be set
			
		move 	$a0, $t9    			# load value for print
		li 		$v0, 11   
   		syscall
   		addi 	$t8, $t8, 1  			# increase counter
		bne 	$t8, 8, printhex 		# loop
   			
   	la 		$a0, strT1
    li 		$v0, 4
   	syscall
   		
	la 		$t0, alphabet	
   	li 		$t8, 0

	hex2:
		andi 	$t9, $t0, 0xf 			# add hex value in here
		slt 	$t3, $t9, 10   			# after 10 Alphabet in hex
		beq 	$t3, 1, jump2   
		addi 	$t9, $t9, 7	 			# Alphabet code number 55 other 48 add 7 and complate 55
		jump2:
		addi 	$t9, $t9, 48  			#Otherwise stand 48
		addi 	$sp, $sp, -1  			# reserve one byte value in stack
		sb 		$t9, 0( $sp )	 		# save value in stack because invers of value
   		srl 	$t0, $t0, 4	 			# add t0 4 so other value will be set
		addi 	$t8, $t8, 1   			# add counter
		bne 	$t8, 8, hex2	 		# loop
		
	li 		$t8, 0
		
	printhex2:	
		lb 		$t9, 0( $sp )   		# load value in stack
		addi 	$sp, $sp, 1  			# increase stack value so next element will be set
			
		move 	$a0, $t9    			# load value for print
		li 		$v0, 11   
   		syscall
   		addi 	$t8, $t8, 1  			# increase counter
		bne 	$t8, 8, printhex2 		# loop

	la 		$t0,arrayQ4
	la 		$t1,alphabet
	
	j		FinishMessagePrinter
	
	MsgPrintError:
	li 		$v0, 4                	# Syscall code of print_string.
	la 		$a0, strInvldInpt     	# a0 = base address of strInvldInpt.
	syscall					 		# Print strInvldInpt.
	
	FinishMessagePrinter:
	la 		$a0, '\n'				# a0 = ASCII of '\n'.
	li 		$v0, 11					# Syscall code of print_char.
	syscall							# Print newline.
	
	# RESTORE REGISTERS.
	lw   	$s1,   0( $sp )			# Restore s1 from stack.
	lw   	$s2,   4( $sp )     	# Restore s2 from stack.
	lw   	$a0,   8( $sp )     	# Restore a0 from stack.
	lw   	$ra,  12( $sp )     	# Restore ra from stack.
    addi 	$sp, $sp, 20        	# Restore stack pointer.
	
	jr		$ra

#####################   GetIntegersFromString   ######################
# Args: None.													 	 #
# Returns: t0 = ErrorState, v0 = Numerator, v1 = Denominator.			 #
# Reads a string from user, parses and returns 2 integers from it.	 #
######################################################################
GetIntegersFromString: 
	# SAVE REGISTERS.
	addi	$sp, $sp, -12			# Make room on stack for 3 regs.
	sw		$ra, 8( $sp )			# Save ra on stack.
	sw		$a1, 4( $sp )			# Save a1 on stack.
	sw		$a0, 0( $sp )			# Save a0 on stack.
	
	# ACTUAL PROCEDURE BODY
	# 1) Read a fraction (in the from of a string) from the user.
	li		$v0, 8					# Syscall code of read_string.
	la		$a0, strBuffer			# a0 = Address of the buffer.
	li		$a1, 50					# a1 = length of buffer.
	syscall							# Read the fraction.
	
	# 2) Handle error checking.
	xor		$v0, $v0, $v0			# v0 will hold the return value for numerator.
	xor		$v1, $v1, $v1			# v1 will hold the return value for denominator.
	xor		$t0, $t0, $t0			# t0 will be the loop variable i FOR NOW. Init to 0.
	li		$t1, -1					# t1 will keep track of '/' position in the string. Init to -1.
	
	lb		$t2, 0( $a0 )			# t2 = first element on the string.
	li		$t3, '/'				# t3 = ASCII of '/'.
	li		$t4, '\n'				# t4 = ASCII of '\n'.
	li		$t6, '9'				# t6 = ASCII of '9'.
	li		$t7, -1					# t7 = -1. To check if slashPos is -1.
	
	beq		$t2, $t3, InvalidFraction # If the first character is '/', signal error.
	
	ErrorCheckingLoop:		
		lb		$t2, 0( $a0 )						# Load the current character into t2.
		beq		$t2, $t4, ExitErrorCheckingLoop 	# If current character is '\n', exit the loop.
		
		# if( frac[ i ] == '/' )
			bne		$t2, $t3, ElseIfIsDigit			# If it is not a '/', continue to next block.
				# if( slashPos != -1 )
				bne		$t1, $t7, InvalidFraction 	# If there are more than 2 of '/', signal error.
				# else
				move	$t1, $t0 					# slashPos = i.
				j		IterateErrorCheckingLoop
		
		# else if( !isdigit( frac[ i ] ) )
		ElseIfIsDigit:
			blt		$t2, $zero, InvalidFraction 	# >= '0'.
			ble		$t2, $t6, Numerator 			# <= '9'.
			j		InvalidFraction					# If it is not a digit, signal error.
		
		# else if( slashPos == -1 )
		Numerator:
			bne		$t1, $t7, Denominator 			# If '/' was found before, it's a denom digit.
			sll		$t5, $v0, 1 					# t5 = numerator * 2.
			sll		$v0, $v0, 3						# numerator *= 8. Still need to add 2 * old numer.
			add		$v0, $v0, $t5					# Now we have 10 * old numerator.
			add		$v0, $v0, $t2					# numer. = numer_Old. * 10 + frac[ i ].
			addi	$v0, $v0, -48					# numer. = numer_Old. * 10 + frac[ i ] - 48.
			j		IterateErrorCheckingLoop		# Skip denominator since we handled the numerator.
		
		# else
		Denominator:
			sll		$t5, $v1, 1 					# t5 = denominator * 2.
			sll		$v1, $v1, 3						# denominator *= 8. Still need to add 2 * old denom.
			add		$v1, $v1, $t5					# Now we have 10 * old denominator.
			add		$v1, $v1, $t2					# denom. = denom_Old. * 10 + frac[ i ].
			addi	$v1, $v1, -48					# denom. = denom_Old. * 10 + frac[ i ] - 48.
		
		IterateErrorCheckingLoop:
		addi	$t0, $t0, 1			# i++.
		addi	$a0, $a0, 1			# Increment a0 to point to next element.
		j		ErrorCheckingLoop
	
	ExitErrorCheckingLoop:
	addi 	$a0, $a0, -1			# Point to the last character. Need to check if it is '/'.
	lb		$t2, 0( $a0 )			# t2 = last character.
	move	$t0, $zero				# From here on, t0 holds the "errorState". Return 0 for success.
	bne		$t2, $t3, FinishFractionProcedure
	
	InvalidFraction:
	li 		$t0, -1					# Return -1 for error.
	
	# RESTORE REGISTERS.
	FinishFractionProcedure:
	lw		$a0, 0( $sp )			# Restore a0 from stack.
	lw		$a1, 4( $sp )			# Restore a1 from stack.
	lw		$ra, 8( $sp )			# Restore ra from stack.
	addi	$sp, $sp, 12			# Restore stack pointer.
	
	jr 		$ra						# Return back to caller.
	
#####################   SumOfRationalNumbers   #######################
# Args:	None.													 	 #
# Returns: None.									 				 #
# Reads 2 fractions from user & prints their sum in simplified form. #
######################################################################
SumOfRationalNumbers: 
	# SAVE REGISTERS.
	addi	$sp, $sp, -28			# Make room on stack for 7 regs.
	sw		$ra, 24( $sp )			# Save ra on stack.
	sw		$a1, 20( $sp )			# Save a1 on stack.
	sw		$a0, 16( $sp )			# Save a0 on stack.
	sw		$s3, 12( $sp )			# Save s3 on stack.
	sw		$s2,  8( $sp )			# Save s2 on stack.
	sw		$s1,  4( $sp )			# Save s1 on stack.
	sw		$s0,  0( $sp )			# Save s0 on stack.
	
	# ACTUAL PROCEDURE BODY.
	xor		$s0, $s0, 0				# s0 will hold the numerator1.   Init to 0.
	xor		$s1, $s1, 0				# s1 will hold the denominator1. Init to 0.
	xor		$s2, $s2, 0				# s2 will hold the numerator2.   Init to 0.
	xor		$s3, $s3, 0				# s3 will hold the denominator2. Init to 0.
		
	GetFirstFraction:
		la		$a0, strFrac1			# a0 = address of strFrac1.
		li		$v0, 4					# Syscall code of print_string.
		syscall							# Print strFrac1.
	
		jal		GetIntegersFromString	# Read a string and parse 2 integers to form 1st fraction.
		move	$s0, $v0				# Move return numerator into numerator1.
		move	$s1, $v1				# Move return denominator into denominator1.
		beq		$t0, $zero, GetSecondFraction
	
		la		$a0, strInvldInpt		# a0 = address of strInvldInpt.
		li		$v0, 4					# Syscall code of print_string.
		syscall							# Print strInvldInpt.
		j		GetFirstFraction
	
	GetSecondFraction:
		la		$a0, strFrac2			# a0 = address of strFrac2.
		li		$v0, 4					# Syscall code of print_string.
		syscall							# Print strFrac2.
		
		jal		GetIntegersFromString	# Read a string and parse 2 integers to form 2nd fraction.
		move	$s2, $v0				# Move return numerator into numerator2.
		move	$s3, $v1				# Move return denominator into denominator2.
		beq		$t0, $zero, SumFractions
		
		la		$a0, strInvldInpt		# a0 = address of strInvldInpt.
		li		$v0, 4					# Syscall code of print_string.
		syscall							# Print strInvldInpt.
		j		GetSecondFraction
	
	SumFractions:
	mult	$s0, $s3
	mflo	$t0						# t0 = numerator1 * denominator2.
	mult	$s1, $s2
	mflo	$t1						# t1 = numerator2 * denominator1.
	add		$s0, $t0, $t1			# numeratorSum (old numerator1) = num1* denom2 + num2* denom1.
	
	mult	$s1, $s3			
	mflo	$s1						# denominatorSum (old denominator1) = denom1 * denom2.
	
	# We now have the numerator and denominator of the sum, but we need to simplify it.
	
	# if( numerator1 == denominator1 )
	bne		$s0, $s1, SimplifyFraction  # If they are not equal, simplify.
		li		$s0, 1					# If they are equal, fraction = 1/1. numerator   = 1.
		li		$s1, 1					# If they are equal, fraction = 1/1. denominator = 1.
		j		FinishRationalProcedure # Skip simplification of the fraction.
	
	# else
	SimplifyFraction:
		li		$t0, 2					# t0 = "factor" to divide to. Init to 2 (smallest prime).
		
		move	$t1, $s0				# t1 will hold the "bigger" of numeratorSum & denominatorSum.
		bgt		$s0, $s1, SimplifyFractionLoop # If Numerator is the bigger one, skip to the loop.
		move	$t1, $s1				# Else, make "bigger" = denominator.
		
		SimplifyFractionLoop:
			# while( factor < bigger )
			bge 	$t0, $t1, 	FinishRationalProcedure	# Continue when factor < bigger, exit otherwise.
			#if( numeratorSum % factor == 0 && denominatorSum % factor == 0 )
			div		$s0, $t0				# Divide numeratorSum to factor. Remainder is in HI.
			mfhi	$t3
			bne		$t3, $zero, ElseFactorZero	# If remainder is not zero, jump to else.
			mflo	$t2						# Move the result to t2 for now.
			div		$s1, $t0				# Divide denominatorSum to factor. Remainder is in HI.
			mfhi	$t3
			bne		$t3, $zero, ElseFactorZero  # If remainder is not zero, jump to else.
				move	$s0, $t2					# numeratorSum   /= factor.
				mflo	$s1							# denominatorSum /= factor.
				div		$t1, $t0					# bigger / factor.
				mflo	$t1							# bigger		 /= factor.
				j		SimplifyFractionLoop		# Reiterate.
			#else
			ElseFactorZero:
				add 	$t0, $t0, 1					# factor++.
		
			j SimplifyFractionLoop
		
		
	FinishRationalProcedure:
	la		$a0, strSumIs			# a0 = address of strSumIs.
	li		$v0, 4					# Syscall code of print_string.
	syscall							# Print strSumIs.
	
	move	$a0, $s0				# a0 = numeratorSum.
	li		$v0, 1					# Syscall code of print_int.
	syscall							# Print index.
	
	li		$a0, '/'				# a0 = 0x2F (ASCII for '/').
	li		$v0, 11					# Syscall code of print_char.
	syscall							# Print slash.
	
	move	$a0, $s1				# a0 = denominatorSum.
	li		$v0, 1					# Syscall code of print_int.
	syscall							# Print index.
	
	li		$a0, '\n'				# a0 = 0x0A (ASCII for '\n').
	li		$v0, 11					# Syscall code of print_char.
	syscall							# Print newline.
	syscall							# Print newline.
	
	# RESTORE REGISTERS.
	lw		$s0,  0( $sp )			# Restore s0 from stack.
	lw		$s1,  4( $sp )			# Restore s1 from stack.
	lw		$s2,  8( $sp )			# Restore s2 from stack.
	lw		$s3, 12( $sp )			# Restore s3 from stack.
	lw		$a0, 16( $sp )			# Restore a0 from stack.
	lw		$a1, 20( $sp )			# Restore a1 from stack.
	lw		$ra, 24( $sp )			# Restore ra from stack.
	addi	$sp, $sp, 28			# Restore stack pointer.
	
	jr 		$ra						# Return back to caller.
	
#######################   FindTheTreeHeight_R   ######################
# Args: a0 = tree[], a1 = current height, a2 = current node index. 	 #
# Returns: v0 = tree height.								 		 #
# Finds & returns the height of given binary tree recursively.		 #
######################################################################
FindTheTreeHeight_R:
	# SAVE REGISTERS.
	addi	$sp, $sp, -28			# Make room on stack for 7 regs.
	sw		$ra, 24( $sp )			# Save ra on stack.
	sw		$s1, 20( $sp )			# Save s1 on stack. Variable "rightChildHeight".
	sw		$s0, 16( $sp )			# Save s0 on stack. Variable "leftChildHeight".
	sw		$t2, 12( $sp )			# Save t2 on stack. It holds the address of the node.
	sw		$a2,  8( $sp )			# Save a2 on stack.
	sw		$a1,  4( $sp )			# Save a1 on stack.
	sw		$a0,  0( $sp )			# Save a0 on stack.
	
	# ACTUAL PROCEDURE BODY	
	xor		$s0, $s0, $s0           # s0 will hold the variable "rightChildHeight". Init to 0.
	xor		$s1, $s1, $s1           # s1 will hold the variable "leftChildHeight".  Init to 0.
	
	sll		$a2, $a2, 2				# a2 = 4 * node index.
	add		$t2, $a0, $a2			# t2 += a2 (t2 holds the address of the node.)
	
	# Check if LEFT child exists.
	li		$t0, -1
	lw		$t1, 4( $t2 )
	beq 	$t0, $t1, LeftChildElseBlock #If the left child index is -1, jump to else block.
	LeftChildIfBlock:				
		la		$a0, tree				# Load base address of tree to a0.
		addi	$a1, $a1, 1				# Increment current height.
		lw		$a2, 4( $t2 )			# Left child of the node.
		jal		FindTheTreeHeight_R		# Call recursive function with height++ and left child.
		move	$s0, $v0				# Move return value to "leftChildHeight".
		addi	$a1, $a1, -1			# Restore a1.
		j		ContinueToRightChild
	LeftChildElseBlock:
		move	$s0, $a1				# "leftChildHeight" is the current height.
	
	ContinueToRightChild:
	# Check if RIGHT child exists.
	li		$t0, -1
	lw		$t1, 8( $t2 )
	beq 	$t0, $t1, RightChildElseBlock #If the right child index is -1, jump to else block.
	RightChildIfBlock:				
		la		$a0, tree				# Load base address of tree to a0.
		addi	$a1, $a1, 1				# Increment current height.
		lw		$a2, 8( $t2 )			# Right child of the node.
		jal		FindTheTreeHeight_R		# Call recursive function with height++ and right child.
		move	$s1, $v0				# Move return value to "rightChildHeight".
		addi	$a1, $a1, -1			# Restore a1.
		j		ContinueToReturnStatement
	RightChildElseBlock:
		move	$s1, $a1				# "rightChildHeight" is the current height.
	
	ContinueToReturnStatement:
	# Return leftChildHeight > rightChildHeight ? leftChildHeight : rightChildHeight ;
	bgt		$s0, $s1, ReturnLeftChildHeight
	ReturnRightChildHeight:
		move	$v0, $s1
		j		FinishRecursiveProcedure
	ReturnLeftChildHeight:
		move	$v0, $s0
	
	FinishRecursiveProcedure:
	# RESTORE REGISTERS.
	lw		$a0,  0( $sp )			# Restore a0 from stack.
	lw		$a1,  4( $sp )			# Restore a1 from stack.
	lw		$a2,  8( $sp )			# Restore a2 from stack.
	lw		$t2, 12( $sp )			# Restore t2 from stack.
	lw		$s0, 16( $sp )			# Restore s0 from stack.
	lw		$s1, 20( $sp )			# Restore s1 from stack.
	lw		$ra, 24( $sp )			# Restore ra from stack.
	addi	$sp, $sp, 28			# Restore stack pointer.

	jr 		$ra						# Return back to caller.
	
########################   FindTheTreeHeight   #######################
# Args: None.														 #
# Returns: None.									 				 #
# Finds & displays the height of the user entered binary tree.		 #
######################################################################
FindTheTreeHeight: 
	# SAVE REGISTERS.
	addi	$sp, $sp, -16			# Make room on stack for 4 regs.
	sw		$ra, 12( $sp )			# Save ra on stack.
	sw		$a2,  8( $sp )			# Save a2 on stack.
	sw		$a1,  4( $sp )			# Save a1 on stack.
	sw		$a0,  0( $sp )			# Save a0 on stack.
	
	# ACTUAL PROCEDURE BODY
	la		$a0, strLength			# a0 = address of strLength.
	li		$v0, 4					# Syscall code of print_string.
	syscall							# Print array length message.
	
	li		$v0, 5					# Syscall code of read_int.
	syscall							# Read array length.
	
	# Read elements of the tree.
	xor		$t0, $t0, $t0			# t0 will be the loop counter "i". Init to 0.
	move 	$t2, $v0				# t2 = array length.
	la		$t3, tree				# t3 = base address of tree.
	ReadElements:
		la		$a0, strElement				# a0 = address of strElement.
		li		$v0, 4						# Syscall code of print_string.
		syscall								# Print array element message.
		
		move	$a0, $t0					# a0 = t3 (i).
		li		$v0, 1						# Syscall code of print_int.
		syscall								# Print index.
		
		la	 	$a0, strColon				# a0 = base addr of strColon.
		li		$v0, 4						# Syscall code of print_string.
		syscall								# Print ": ".
			
		li		$v0, 5						# Syscall code of read_int.
		syscall								# Read an array element.
		
		sw		$v0, 0( $t3 )				# Put that element in its position in array. 
		addi	$t3, $t3,	4				# Make t3 point to next array element.

		li		$t1, 1						# t1 = 1.
		add		$t0, $t0, 	$t1				# t0++ (i++).
		bne 	$t0, $t2, 	ReadElements	# Check if i == array length. Continue loop if not.
	
	# Call recursive function to find height.
	la		$a0, tree				# Load base address of tree to a0.
	li		$a1, 1					# Start with a current height of 1.
	li		$a2, 0					# Start from node 0 (root).
	jal		FindTheTreeHeight_R		# Call the recursive function for the first time.
	
	move	$t4, $v0				# Stash return value (tree height) in t4.
	
	la		$a0, strLengthIs        # a0 = base addr of strLengthIs.
	li		$v0, 4                  # Syscall code of print_string.
	syscall                         # Print "Height of the tree is: ".
	
	move	$a0, $t4				# t4 has the height of the tree, move it to a0 to print.
	li		$v0, 1					# Syscall code of print_int.
	syscall							# Print the height of the tree.
	
	li		$a0, 10					# a0 = 10 (ASCII for newline).
	li		$v0, 11					# Syscall code of print_char.
	syscall							# Print newline.
	syscall							# Print newline.
	
	# RESTORE REGISTERS.
	lw		$a0,  0( $sp )			# Restore a0 from stack.
	lw		$a1,  4( $sp )			# Restore a1 from stack.
	lw		$a2,  8( $sp )			# Restore a2 from stack.
	lw		$ra, 12( $sp )			# Restore ra from stack.
	addi	$sp, $sp, 16			# Restore stack pointer.

	jr 		$ra						# Return back to caller.
