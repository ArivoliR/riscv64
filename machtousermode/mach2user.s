.section .text
.global main

main :
    la t0, mtrap_handler
    csrw mtvec, t0
    csrr t0, mstatus
    csrw mstatus, t0
    
    csrr t2, mcause
    csrr t3, mepc
    csrr t4, mstatus
    csrr t5, mtvec
    
    la t0, ucode
    csrw mepc, t0
    mret

mtrap_handler :
    csrr t2, mcause
    csrr t3, mepc
    csrr t4, mstatus
    csrr t5, mtvec

    la t1, ucode
    csrw mepc, t1
    mret
    
ucode :
     ecall
