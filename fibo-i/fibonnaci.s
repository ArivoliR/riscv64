.section .data
n: .word 10           # Hardcoded value of n (10th Fibonacci number)

.section .text
.globl _start

_start:
    la t0, n           # load address of n
    lw t1, 0(t0)       # load value of n into t1
    li t2, 0           # (F0)
    li t3, 1           # (F1)
    li t4, 1           # loopc = 1

    beqz t1, done      # If n is 0, the result is 0

loop:
    bge t4, t1, done   # loop ka condition (n times)
    add t5, t2, t3     # F(n) = F(n-1) + F(n-2)
    mv t2, t3          # F(n-1) = F(n-2)
    mv t3, t5          # F(n-2) = F(n)
    addi t4, t4, 1     # counter incremenet
    j loop

done:
    # Result is stored in t3
    mv a0, t3          # move result to a0 and exit
    li a7, 93          # ecall to exit
    ecall
