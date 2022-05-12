.data
# parsed input values
IN: .space 30
 .align 2
# MAX: .word 0, 0  # stores 10 place max, 0 place max
# MIN: .word 0, 0  # stores 10 place min, 0 place min
MAX: .word 0
MIN: .word 0
N: .word 10  # loop count
str: .asciiz "pathetic"
SPCE: .asciiz " "

.text
.globl main
      
main: li $v0, 4
      la $a0, str
      syscall
      # Read + store value into $t0
      li $v0, 8
      la $a0 IN
      li $a1, 32
      syscall

      # move $t0, $a0
      la $t0 IN
      lw $s0, N
      # init registers
      # li $t1, 0
      # li $t2, 0

      # store first value into MIN & MAX
loop: add $t1, $0, $0
      add $t2, $0, $0
      lb $t1, 0($t0)  # t1 holds 10 place
      lb $t2, 1($t0)  # t2 holds 1 place
      addi $t1, $t1, -48  # -48 bc ascii
      addi $t2, $t2, -48
      add $t7, $t1, $0  # t7 holds $t1 value for testing
      addi $s2, $0, 10
      mul $t1, $t1, $s2
      add $t1, $t1, $t2  # t1 now holds final value
      addi $s1, $0, 20
      bne $s0, $s1 eval  # skips to eval if loop counter = 20
      sw $t1, MIN
      sw $t1, MAX
      j incr
eval: lw $s1, MIN
      slt $s1, $s1, $t1
      bne $s1, $0, evalx
      sw $t1, MIN
evalx:lw $s1, MAX
      slt $s1, $t1, $s1
      bne $s1, $0, incr
      sw $t1, MAX
incr: addi $t0, $t0, 3
      addi $s0, $s0, -1
      beq $s0, $0, prnt
      j loop

# smin: sw $t1, MIN
#       j cont

# smax: sw $t1, MAX
#       beq $0, $zero, prnt

# loop: addi $s0, $s0, -1  # decrement loop counter
#       addi $t0, $t0, 2  # increment loop value for $t0
#       lb $t1, 0($t0)  # t1 holds 10 place
#       lb $t2, 1($t0)  # t2 holds 1 place
#       addi $t1, $t1, -48  # -48 bc ascii
#       addi $t2, $t2, -48
#       addi $s0, $0, 10
#       mul $t1, $t1, $s0
#       add $t1, $t1, $t2  # t1 now holds final value
#       lw $s1, MIN
#       slt $s1, $t1, $s1
#       beq $s1, $zero, smin  # jumps to SMIN if MIN $t1 is smaller
# cont: lw $s1, MAX
#       slt $s1, $s1, $t1
#       beq $s1, $zero, smax  # jumps to SMAX if MIN $t1 is larger
#       bne $s0, $zero, loop

      # addi $t0, $0, 2
      # addi $t1, $0, 10
      # mul $t0, $t0, $t1
      # addi $t1, $0, 6
      # add $t0, $t0, $t1

      # sw $t0, MIN
      # sw $t0, MAX
      # add $t0, $zero, $zero

prnt: lw $t0, MIN
      li $v0, 1
      move $a0, $t0
      syscall

      li $v0, 4
      la $a0, SPCE
      syscall

      lw $t1, MAX
      li $v0, 1
      move $a0, $t1
      syscall

      j DONE


# loop: 
#       j loop

DONE: li $v0 10
      syscall
