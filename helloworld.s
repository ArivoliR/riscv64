.global _start

.section .text
_start: 
  li a0, 1
  la a1, hello
  li a2, 13
  li a7, 64
  ecall 

  li a0, 3
  li a7, 93
  ecall

.section .data
hello: .ascii "Hello World!\n"


