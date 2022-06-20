.data
IN: .space 30
 .align 2
N: .word 10  # counter 1 -- used to iterate through string
J: .word 10  # counter 2 -- used to keep track of amount of iterations of string
SPCE: .asciiz " "
str: .asciiz "oonga boonga"
# OUT: .word 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
OUT: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
.globl main
main: # Read + store value into $t0
      li $v0, 8
      la $a0 IN
      li $a1, 32
      syscall

       # move $t0, $a0
      la $t0 IN
      la $t1, OUT
      lw $t2, N

      ###   GET USER INPUT FIRST #####
parse:lb $s0, 0($t0)  # t1 holds 10 place
      lb $s1, 1($t0)  # t2 holds 1 place
      addi $s0, $s0, -48  # -48 bc ascii
      addi $s1, $s1, -48
      addi $s3, $0, 10
      mul $s0, $s0, $s3
      add $s0, $s0, $s1  # s0 now holds final value
      sw $s0, 0($t1)
      addi $t0, $t0, 3
      addi $t1, $t1, 4
      addi $t2, $t2, -1
      bne $t2, $0, parse

      ### SORTING STARTS HERE
      addi $t3, $0, 9
start:addi $t2, $0, 9
      la $t1, OUT
sort: lw $s0, 0($t1)
      lw $s1, 4($t1)
      slt $s2, $s0, $s1  # s2 = 1 if $s0 < $s1
      bne $s2, $zero, skip
swap: sw $s1, 0($t1)
      sw $s0, 4($t1)
skip: addi $t1, $t1, 4
      addi $t2, $t2, -1
      bne $t2, $0, sort
      addi $t3, $t3, -1
      bne $t3, $0 start
      

# store:sw $t1, OUT
      ### PRINTING CONTENTS OF OUT
      addi $t2, $0,10
      la $t1, OUT
print:lw $s4, 0($t1)
      li $v0, 1
      move $a0, $s4
      syscall

      li $v0, 4
      la $a0, SPCE
      syscall

      addi $t1, $t1, 4
      addi $t2, $t2, -1
      bne $t2, $0, print

      # lw $s5, 4($t1)
      # li $v0, 1
      # move $a0, $s5
      # syscall

done: li $v0,10
      syscall
