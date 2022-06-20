.globl display

.data
    input: .space 31 # Allocating space for 10 (base-10) integers including whitespaces
.text    
main:
    li $v0, 8      # Sycall number to read string from user 
    la $a0, input  # Address to store the user input
    la $a1, 31 # max length for user input 
    syscall
    # Write your implementation below (Do not change the lines above)

    #   la $t0 IN
    #   lw $s0, N
      # init registers
      # li $t1, 0
      # li $t2, 0

      addi $a0, $0, 10  # $a0imum value (Update with $a0imum from your implementation)
    addi $a1, $0, 99  # maximum value (Update with maximum from your implementation)

      addi $s0, $0, 10
      # store first value into $a0 & MAX
loop: lb $t1, 0($t0)  # t1 holds 10 place
      lb $t2, 1($t0)  # t2 holds 1 place
      addi $t1, $t1, -48  # -48 bc ascii
      addi $t2, $t2, -48
      add $t7, $t1, $0  # t7 holds $t1 value for testing
      addi $s2, $0, 10
      mul $t1, $t1, $s2
      add $t1, $t1, $t2  # t1 now holds final value
      addi $s1, $0, 10
      bne $s0, $s1 eval  # skips to eval if loop counter = 20
      move $t1, $a0
      move $t1, $a1
      j incr
eval: move $s1, $a0
      slt $s1, $s1, $t1
      bne $s1, $0, evalx
      move $t1, $a0
evalx:move $s1, $a1
      slt $s1, $t1, $s1
      bne $s1, $0, incr
      move $t1, $a1
incr: addi $t0, $t0, 3
      addi $s0, $s0, -1
      beq $s0, $0, prnt
      j loop


    # Printing final ouput in the correct format (update registers $a0 & $a1 with $a0imum and maximum)
    
    jal display
    # Do not change the lines below
exit:
    addi $v0, $0, 10
    syscall                # Exit

display:
    li $v0, 1         # syscall number for printing integer
    syscall
    li $a0, 32  # print space, 32 is ASCII code for space
    li $v0, 11  # syscall number for printing character
    syscall
    add $a0, $0, $a1
    li $v0, 1         # syscall number for printing integer
    syscall
    jr $ra
