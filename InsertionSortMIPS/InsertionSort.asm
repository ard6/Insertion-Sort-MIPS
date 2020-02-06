#####################################################################
#                                                                   #
# Name:Arda Duman - Cansu Doganay                                   #
# KUSIS ID: 60609 - 60601                                           #
#####################################################################

# This file serves as a template for creating 
# your MIPS assembly code for assignment 2

.eqv MAX_LEN_BYTES 400

#====================================================================
# Variable definitions
#====================================================================

.data

input_data:        .space    MAX_LEN_BYTES     #Define length of input list
arg_err_msg:       .asciiz   "Argument error"
input_msg:         .asciiz   "Input integers"

#  You can define other data as per your need. 
size_err_msg:      .asciiz    "Input n must be 0 < N < 100"
int_num:           .asciiz   "Input number of values to be sorted (0 < N < 100): "
newLine:            .asciiz   "\n"
space:              .asciiz   " "
colon:               .asciiz   ": "
enter_integers:     .asciiz   "Enter Integers:"
integers:           .asciiz   "integer "
sorted_list:        .asciiz   "Sorted List"
sorted_list_wo_dup: .asciiz   "Sorted list without duplicates"
list_sum:           .asciiz   "List Sum"
oparan:              .asciiz  "[ "
cparan:               .asciiz  "]"


#==================================================================== 
# Program start
#====================================================================

.text
.globl main

main:
  
   jal Data_Input   #takes the inputs from the user and put into an array
   jal sort_data    #sorts the array
   jal print_w_dup  #prints the array
   jal remove_duplicates  #removes the duplicate elements from the array
   jal print_wo_dup #prints the reduced array
   jal print_sum    #prints the sum of the elements
  

Data_Input:
  
 li $v0,4            
 la $a0, int_num   #prints the message
 syscall
 
 li $v0,5
 syscall	 #takes the number of elements to sort from the user
 addi $t1,$v0,0  # iteration number(size of the array)
 
 bge $t1,100,Sz_Err  #prints error if the number is greater than or equal to 100
 ble $t1,0,Sz_Err    #prints error if the number is less than or equal to 0
 
 
 addi $t0, $zero, 0  #counter for the loop
 addi $t9,$zero,0    #index for the array
 
 read_loop:          #the loop takes inputs from the user and stores in an array
 	bge $t0,$t1, return_main  #if counter exceeds the size finish loop
 	addi $t0,$t0,1            #counter++
 	
 	li $v0,4
 	la $a0,integers		#prints "integer "
 	syscall
 	
 	li $v0,4
 	la $a0,space           #prints a space
 	syscall
 	
 	
 	li $v0,1
 	move $a0,$t0          #prints the integer number to be given ("integer 1")
 	syscall
 	
 	li $v0,4
 	la $a0,colon          #prints a colon after the number ("integer number 1: ")
 	syscall
 	
 	li $v0,5             
 	syscall              #takes the input integer from the user
 	addi $a0,$v0,0       
 	move $t8,$a0         
 	
 	
 	sw $t8,input_data($t9)     #stores the input integer to the array
 	addi $t9,$t9,4             #increments the index for the next word

 	j read_loop               #returns to the top of the loop
 


sort_data:
   
   addi $t0, $zero, 4  #counter i for loop1
   sll $t4,$t1,2       #the address of the last word in the array
  
   j sort_loop1        #goes to the first loop
   return_from_loop1:  # when the loop ends continues here.
   
    
   j return_main       #when sorting ends returns to the main
   

	    
sort_loop1:          #first loop
 
 
 	bge $t0,$t4,return_from_loop1   #if the counter exceeds the size the loop ends
 	
 	
 	lw $t8, input_data($t0)  #key element
   	subi $t2,$t0,4  #j       
   	
   	 
   	
   	lw $t7,input_data($t2) #arr[j]
   	
   	addi $t3,$t2,4  #j+1
   	
   	j sort_loop2  #  goes to the second loop
   	
	return_from_loop2:  	# when the second loop ends continues from here
   	
   	addi $t3,$t2,4  # updating j+1
   	
   
   	sw $t8,input_data($t3)    # stores the key element to j+1 th place
 	
   	
   	addi $t0,$t0,4  # counter++
   	
   	j sort_loop1    #return to the top of the loop1
   	
   	
sort_loop2:     #second loop

	
	blt $t2,0,return_from_loop2    #if j becomes less then 0 the loop ends
	ble $t7,$t8,return_from_loop2   #if j th element is less than or equal to the key element the loop ends
	
	
	
	lw $t6, input_data($t2)	     #loads the j th element from the array
	sw $t6,input_data($t3)       #stores the element to the j+1 th location 
	
	subi $t2,$t2,4              #decrements j by 1
	
	lw $t7,input_data($t2)  # updates arr[j] 
   	addi $t3,$t2,4  # updates j+1
	
	
	j sort_loop2   #return to the top of the loop2
	
	

remove_duplicates:
   
   addi $t0, $zero, 1  #counter
   sll $t4,$t1,2  # adress of last element
   addi $t9,$zero,0   #index
   
   
   lw $t8, input_data($t9)  #the first element of the array
   
   remove_loop:
   	bge  $t0,$t1, return_main   #if the counter exceeds the size, the loop ends
   	addi $t0,$t0,1               # counter++
   	addi $t9,$t9,4               #increments the index
   	
   	lw $t7, input_data($t9)      #loads the next element
   	
   	bne $t8,$t7,increment        #if the next element is same with the current element, loop ends
   
   	

   	
   	
   	j reduce_array           # returns to the top of the loop

   	
   	
   	
 	increment:              #makes the next element, the current element
   	
   	add $t8,$t7,$zero       #copy the next element to the current element
   	
   	
   	
 	j remove_loop         # returns to the top of the loop
   	
   

	
	
reduce_array:       #it eliminates the duplicates

	addi $t6, $t9,0  #copy of the current index
	addi $t5, $t6,4  #copy of the next index
	
	reduce_loop:   #it eliminates 1 duplicate each time
		
		bgt $t5,$t4,decrement_size     #if the next index is the last element of the array, the loop ends
		
		lw $t3,input_data($t5)       #loads the next element 
		sw $t3,input_data($t6)        # stores it to the current 
		
		addi $t6,$t6,4               #increments the current element index
		addi $t5,$t5,4              # increments the next element index
		
		
		j reduce_loop             #returns to the top of the loop
	
	


decrement_size:              #eliminates the empty index at the end of the array
	subi $t1,$t1,1       #size--
	 sll $t4,$t1,2  # updates the index of last element 
	 
	 j remove_duplicates    #returns to remove_duplicates in order to check the array again

print_w_dup:     # prints the array with duplicates

   
   li $v0,4
   la $a0,sorted_list    #prints a message
   syscall
   
   li $v0,4
   la $a0,newLine       #prints a new line
   syscall
   
   j print_array        # jumps to print 
   
print_array:          #prints the current array

   addi $t0, $zero, 0  #counter for the print loop  
   addi $t9,$zero,0    #index 
   addi $t3,$zero,0    # sum 
   
   
   li $v0,4
   la $a0,oparan     #prints an open paranthesis "[ "
   syscall
   
   print_loop:    #loop for print
   
   	bge $t0,$t1, close_array    #if the counter exceeds the size, the loop ends
   	addi $t0,$t0,1              #counter++
   	
   	lw $t8, input_data($t9)     #loads the 'index' th element
   	addi $t9,$t9,4              # updates the index for the next word
   	
   	add $t3,$t3,$t8             #adds the current element to sum
   	
   	li $v0,1
   	move $a0,$t8               #prints the 'index' th element
   	syscall
   	
   	
   	
   	li $v0,4
 	la $a0,space               #prints a space
 	syscall
 	
 	
 	
 	j print_loop            #return to the top of the loop
   	
   	
   	
close_array:   #it prints a closed paranthesis when the loop ends


	li $v0,4
 	la $a0,cparan   # prints closed paranthesis "]"
 	syscall
 	
 	li $v0,4
 	la $a0,newLine  #prints a new line
 	syscall
 	
 	
 	
 	j return_main   #returns to the main
  	
   
print_wo_dup:        # prints array without duplicates



   li $v0,4
   la $a0,sorted_list_wo_dup         #prints a message
   syscall
   
   li $v0,4
   la $a0,newLine                 #prints a new line
   syscall

  j print_array                #jumps to print__array

   
return_main:  #it returns to the main
	
	   jr $ra  


 print_sum:    #print the sum of the unique elements
 
 
 li $v0,4
 la $a0,list_sum    #prints a message
 syscall
 
 li $v0,4
 la $a0,newLine     #prints a new line
 syscall
 

 
  li  $v0, 1
  addi $a0, $t3, 0      # $t3 contains the sum  
  syscall

   j Exit             #terminates the program
   
   
Sz_Err:  #if the size is not valid givees an error
  
   la $a0, size_err_msg
   li $v0, 4              #prints a message
   syscall
   j Exit

Exit:   

   li $v0, 10    #terminates the program
   syscall
