.option norvc
.section .data

# welcome is an address
welcome:    .ascii  "Welcome to PseudOS\0"
hartid:     .ascii  "HartID:  \0"
newline:    .ascii  "\n\0"

.equ UART_REG_TXFIFO, 0x00
.equ UART_BASE, 0x10000000      # PORT

_scratchpad:
    .skip 1024,0

_scratchpad2:
    .skip 1

.section .text.init
.global _start

_start:
    csrr    s1, mhartid
    # bnez    s1, _wait
    la      a0, welcome
    jal     _writeln

    la      a0, hartid
    addi    t0, a0, 0x08        # replace index 8 of string to number
    addi    s1, s1, 0x30        # number to ascii
    sb      s1, (t0)
    call     _writeln

    wfi

# a0 addr to string to print
# will write to serial out + \n
_writeln:
    call    _write_uart
    mv      s2, a0
    la      a0, newline
    call    _write_uart
    mv      a0, s2
    ret

_write_uart:
    lb      t1, (a0)            # get first byte of string
    beqz    t1, _write_uart_end # return if end of string
    li      t2, UART_BASE       # load uart into t2
    sb      t1, (t2)            # put the byte in uart bus
    addi    a0, a0, 0x1         # a0++
    j       _write_uart         # back to check if string ends
_write_uart_end:
    ret

_wait:
    wfi                         # wfi - wait for interrupt
