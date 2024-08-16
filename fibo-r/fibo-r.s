.section .data
n: .word 11

.section .text
.globl _start

_start:
    la t0, n
    lw a0, 0(t0)
    call fib

    li a7, 93
    ecall

fib:
    addi sp, sp, -24
    sw ra, 16(sp)
    sw a0, 8(sp)

    li t0,0
    beq a0, t0, fib0
    li t0,1
    beq a0, t0, fib1

    addi a0, a0, -1
    call fib
    sw a0, 0(sp)

    lw a0, 8(sp)
    addi a0, a0, -2
    call fib

    lw a1, 0(sp)
    
    add a0, a0, a1

    j fibreturn

fib0:
    li a0, 0
    j fibreturn

fib1:
    li a0, 1
    j fibreturn

fibreturn:
    lw ra, 16(sp)      
    addi sp, sp, 24    
    ret                
