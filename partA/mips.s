.data # Put Global Data here
  N: .word 5 # loop count
  X: .word 2, 4, 6, 8, 10 # array of numbers to be added
  SUM: .word 0 # location of the finalsum
  str: .asciiz "The sum of the array is= "

.text # Put program here
.globl main # globally define main
main: lw $s0, N # load loop counter into $s0
la $t0, X # load the address of X into $t0
and $s1, $s1, $zero # clear $s1 aka temp sum

loop:
lw $t1, 0($t0) # load the next value of x
add $s1, $s1, $t1 # add it to the running sum
addi $t0, $t0, 4 # increment to the next address
addi $s0, $s0, -1 # decrement the loop counter
bne $0, $s0, loop # loop back until complete

sw $s1, SUM # store the final total

li $v0, 4 # 4 is system call code for print_str
la $a0, str
syscall # system call for print_str

li $v0, 1 # 1 is system call code for print_int
move $a0, $s1
syscall # system call for print_int

li $v0, 10 # 10 is system call code for exit
syscall # system call for exit
