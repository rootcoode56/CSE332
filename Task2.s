# Use .set noreorder to prevent the assembler from filling branch
# delay slots, if you want to fill delay slots manually.
# .set noreorder

.global _start
_start:
.data
prompt: .asciiz "Enter your name in one line using space(First name,Last name): "  #Code for showing message asking for name
name: .space 200                                                                   #Allocating store space for name
max_ascii: .asciiz "Maximum Value of name ASCII is: "                              #Print message of Max ASCII Value
min_ascii: .asciiz "Minimum value of name ASCII is: "                              #Print message of Min ASCII Value
newline: .asciiz "\n"                                                              #New line for displaying MAX and MIN value

.text
.globl main
main:

	#Displaying Message for asking name
	li $v0, 4            #Command for write String
	la $a0, prompt       #We already write "Prompt" message at starting
	syscall              #finish message part
	
	#Read Input name
	li $v0, 8            #Command for read string
	la $a0, name         #Load address for name
	li $a1, 200          #load immidate for name space,we took 200 space for it
	syscall              #finish read input name
	
	#ASCII part
	la $t0, name        #Load address firt and put "name" in register
	li $t1, 127         #We know total ASCII value is 128 which is 0-127. We store Max value is $t1
	li $t2, 0           #Low ASCII
	
	#Loop part
loop:
	lb $t3, 0($t0)            #Load command for name($t0) and load inside $t3
	beq $t3, 0,  end_loop     #Loop will end when $t3==0
	beq $t3, 32, skip_space   #As we took space between firt name and last name,so we have to skip that word space
	
	#Check for Minimun ASCII value
	blt $t3, $t1, New_min     #Compare $t0 and $t3 and put it New_min
	j skip_min                #End finding minumum ascii
	
New_min:
	move $t1, $t3             #Move mninimum ascii value to $t1 register
	
skip_min:                     #Check Maximum implementation
	bgt $t3, $t2, New_max	  #comparing 
	j skip_max
	
New_max:
	move $t2, $t3             #We move compare register value($t3) to $t2
	
skip_max:                     #Max check done and skiping to next character
	addi $t0, $t0, 1          #Increment 1, like $t0++
	j loop                    #continue to loop
	
skip_space:                   #Skip space between name and move to next character
 	addi $t0, $t0, 1		  #increment 1
	j loop                    #continue to loop
	
end_loop:					  #end loop here
	#Display Maximum ASCII value
	li $v0, 4                 #String Output
	la $a0, max_ascii         #Show maximum ASCII value
	syscall                   #System Call
	li $v0, 1                 #Command for integer output
	move $a0, $t2             #Move Maximum Value to $t2
	syscall
	#Command for print newline
	li $v0, 4                 #Print command
	la $a0, newline			  #From Newline
	syscall
	
	#Display Minumum ASCII Value(same as Maximum ASCII
	li $v0, 4
	la $a0, min_ascii
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	
	#End the program
	li $v0, 10               #Exit command
	syscall
	
	
										
	