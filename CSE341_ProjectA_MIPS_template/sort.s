.globl display_array

    #####################
# Do not modify the lines between the # boundaries
    #####################
.data
    example_sorted_arr: .word 10, 20, 30, 50, 60, 70, 80, 90, 95, 99 # Example of a sorted array just for prinitng the final output
    #####################
    input: .space 31 # Allocating space for 10 (base-10) integers including whitespaces
    #####################
.text    
main:
    #####################
    li $v0, 8      # Sycall number to read string from user 
    la $a0, input  # Address to store the user input
    la $a1, 31     # max length for user input 
    syscall
    #####################
    # Write your implementation below





    # Printing final ouput in the correct format (update $a0 with the address of your sorted int array)
    la $a0, example_sorted_arr # you can use the instruction move if your sorted array is in a different register than $a0
    jal display_array
    #####################
exit:
    addi $v0, $0, 10
    syscall                # Exit
    #####################

display_array:
    move $t0, $a0 # copy the starting address of the sorted sequence
    add $t2, $0, $0 # initialize the counter to 0 
    addi $t3, $0, 9 # number of times the loop will run for a 10-element array
    arr_loop: 
        lw $a0, 0($t0) 
        li $v0, 1         # syscall number for printing integer
        syscall
        addi $t0, $t0, 4  # increment address by 4
        beq $t2, $t3, exit
        li $a0, 32  # print space, 32 is ASCII code for space
        li $v0, 11  # syscall number for printing character
        syscall
        addi $t2,$t2, 1    # increment counter 
        j arr_loop
