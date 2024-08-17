.section .data
n: .word 3

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
    addi sp, sp, -40
    sw ra, 32(sp)
    sw a0, 24(sp)
    sw a1, 16(sp)
    sw a2, 8(sp)
    sw a3, 0(sp)

    beqz a0, tow_ret

    #first function call
    lw a0, 24(sp)
    addi a0, a0, -1
    lw a1, 16(sp)    #A -> from
    lw a2, 8(sp)     #C -> to
    lw a3, 0(sp)     #B -> spare
    jal ra, tow
    jal ra, movedisk

    #print disk's number
    li a7, 64 #write 
    li a0, 1
    lw t0, 24(sp) #address of a0
    addi t0, t0, '0'
    sw t1, 24(sp)
    mv a1, sp
    li a2, 1
    ecall

    #correcting a0
    lw t1, 24(sp)
    addi t1, t1, -'0'
    sw t1, 24(sp)


    #print 'from rod'
    li a7, 64
    li a0, 1
    mv a1, sp
    addi a1, a1, 16
    li a2, 1
    ecall

    #print 'to rod'
    li a7, 64
    li a0, 1
    mv a1, sp
    addi a1, a1, 8
    li a2, 1
    ecall


    #next function call setup
    lw a0, 24(sp)
    lw a1, 8(sp)
    lw a2, 0(sp)
    lw a3, 16(sp)

    jal ra, tow 
    
    
    j tow_ret


movedisk:
    li a7, 64
    li a0, 1
    la a1, strmd
    li a2, 10
    ecall
    ret

tow_ret:
    lw ra, 32(sp)
    addi sp, sp, 40
    ret

.section .data
strmd: .ascii "Move disk "

