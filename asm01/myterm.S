.macro push reg
    addi    sp, sp, -4
    sw      \reg, (sp)
.endm

.macro pop reg
    lwu      \reg, (sp)
    addi    sp, sp, 4
.endm

.section .data

.equ UART_BASE, 0x10000000      # PORT
tempdata: .string "Hello World!\n\0"

.section .text.init
.global _start

_start:
    csrr    t0, mhartid
    bnez    t0, _wait
    la      sp, __stack_top

    la      a0, tempdata
    push    a0
    li      a0, 0
    pop     a0

    jal     _write_string

    call    start
    j       _wait



_write_string:
    lb      t1, 0(a0)               # get first byte of string
    beqz    t1, _write_string_end   # return if end of string
    li      t2, UART_BASE           # load uart into t2
    sb      t1, 0(t2)               # put the byte in uart bus
    addi    a0, a0, 0x1             # a0++
    j       _write_string           # back to check if string ends
_write_string_end:
    ret

_write_uart_byte:
    li      t2, UART_BASE   # load uart into t2
    sb      a0, 0(t2)       # put the byte in uart bus
    ret

_wait:
    wfi
