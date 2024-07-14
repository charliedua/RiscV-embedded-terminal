.macro push reg
    addi    sp, sp, -4
    sw      \reg, (sp)
.endm

.macro pop reg
    lwu      \reg, (sp)
    addi    sp, sp, 4
.endm

.section .data

.equ UART_BASE, 0x10000000 # PORT

.section .text.init
.global _start

_start:
    la      sp, stack0      # stack top
    li      a0, 1024*4      # 4kb stack for each thread
    csrr    a1, mhartid     # a1 = mhartid
    addi    a1, a1, 1       # a1 = mhartid +1 
    mul     a0, a0, a1      # a0 = 4kb * (mhartid + 1)
    add     sp, sp, a0      # sp += a0

    # Call start() in start.c
    call    start
    wfi
