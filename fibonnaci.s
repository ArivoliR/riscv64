.global _start

.section .data
n: .word 5

.section .text

_start:
    la t0, n           # Load address of n
    lw t1, 0(t0)       # Load value of n into t1
    li t2, 0           # Initialize first Fibonacci number (F0)
    li t3, 1           # Initialize second Fibonacci number (F1)
    beqz t1, done      # If n is 0, result is 0
    li t5, 1           # Initialize loop counter to 1

loop:
    beq t1, t5, done   # If loop counter equals n, we are done
    add t4, t2, t3     # Calculate next Fibonacci number
    mv t2, t3          # f(1) -> f(0)
    mv t3, t4          # f(2) -> f(1)
    addi t5, t5, 1     # Increment loop counter
    j loop             # Jump back to loop

done:
    # At this point, t3 holds the nth Fibonacci number
    mv a0, t3          # Move result to a0 for exiting
    li a7, 10          # ecall number for exit
    ecall


