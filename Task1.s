.data
array: .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29
size: .word 15       #Array size given in question
message: .asciiz "Array elements average is: "  #Print Average

.text
.globl main
main:
	la $t0, array    #Loading array address into $t0
	lw $t1, size     #Loading arrat size into $t1
	add $t2 , $zero, $zero  #Initialize sum to 0
	add $t3,  $zero, $zero  #Initialize loop counter(int i) to 0
	
loop:
	beq $t3, $t1, end_loop   #Exit loop if counter(i)==size
	lw $t4, 0($t0)           #Load word array elements
	add $t2, $t2, $t4		 #Add every elements to the sum
	addi $t0, $t0, 4         #Transfer to array next element
	addi $t3, $t3, 1         #increment the loop counter i++
	j loop                   #Jump back to loop
	
end_loop:
	div $t2, $t1			#Divide the sum by the size of array
	mflo $s2				#Store the average in $s2
	mfhi $s3                #Store the remainder in $s3
	
	#Display Message on terminal
	li $v0, 4              #Command for printing string
	la $a0, message		   #Printing message part
	syscall
	
	#Print Average on terminal
	li $v0, 1              #Print integer command
	move $a0, $s2          #Move the average to $a0
	syscall
	
	#Exit Program Command
	li $v0, 10             #Exit command
	syscall
	