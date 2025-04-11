.data
ARRAY: .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29
SIZE:  .word 15
RESULT: .asciiz "The array elements average is: "

.text
.globl main

main:
    # Initialize registers
    la $t0, ARRAY                  # Loading ARRAY address into $t0
    lw $t1, SIZE                   # Loading array size into $t1
    add $t2, $zero, $zero          # Initialize total to 0
    add $t3, $zero, $zero          # Initialize index to 0

loop:
    bne $t3, $t1, process_element  # If index != size, process element part
    j calculate_average              # Jump to calculate average after condition is true

process_element:
    lw $t4, 0($t0)       # Loading the current array element into $t4
    add $t2, $t2, $t4    # Add the array current element to total
    addi $t0, $t0, 4     # Move to the next element (which is 4 bytes of every elements)
    addi $t3, $t3, 1     # Increment (i++)
    j loop               # Follow up the loop

calculate_average:
    # Calculating average
    div $t2, $t1         # Divide total by size
    mflo $t5             # Storing quotient (average) to $t5
	mfhi $t6             # Storing divident to $t6
	
    # Print the RESULT part
    li $v0, 4            # print string load syscall 
    la $a0, RESULT       # Load address of result string
    syscall              # Print the string

	#Print the Total part
    li $v0, 1            # Load syscall for print integer
    move $a0, $t5        # Move average to $a0 for printing
    syscall              # Print the average

    # Exit program
    li $v0, 10           # Load exit syscall
    syscall
