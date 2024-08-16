.section .data
n: .word 3
msg: .string "Move disk from %d%c%c\n"

.section .text
.globl _start

_start:
    la t0, n
    lw a0, 0(t0)
    li a1, 'A' #from rod
    li a2, 'C' #to rod
    li a3, 'B' #aux_rod
    jal ra, tow

    li a7, 93
    ecall


tow:
    addi sp, sp, -32
    sw ra, 24(sp)
    sw a0, 16(sp)
    sw a1, 12(sp)
    sw a2, 8(sp)
    sw a3, 4(sp)

    beqz a0, tow_ret
    

    #tow(n-1, from, aux, to)
    addi a0, a0, -1
    mv t1, a1 # A in t1
    mv t2, a2 # C in t2
    mv t3, a3 # B in t3

    mv a1, t1 # A in a1
    mv a2, t3 # B in a2
    mv a3, t2 # C in a3
    jal ra, tow

    lw a1, 12(sp)
    lw a2, 8(sp)
    lw a0, 16(sp)
    la a0, msg #load msg address
    li a7, 64
    ecall

    #tow(n-1, aux, to, from)
    lw a0, 16(sp)
    addi a0, a0, -1
    mv a1, t3
    mv a2, t2
    mv a3, t1
    jal ra, tow

tow_ret:
    lw ra, 24(sp)
    addi sp, sp, 32
    ret



