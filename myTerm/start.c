#include "types.h"
#include "riscv.h"
#include "std/uart.c"

void switchToMachineMode();

__attribute__ ((aligned (16))) char stack0[4096 * 8];

void
start()
{
    switchToMachineMode();

    char * hello = "hello world\n";
    printStr(hello);

    char input[128];
    readStr(input);

    printStr(input);
}

void 
switchToMachineMode() {
    uint64 x = readMachineStatus();
    x &= ~MSTATUS_MODE_CHANGE_HI_BITS;  // 0x11 setting to 1s to clear bits
    x |= MSTATUS_M_MODE_ENCODING;       // OR to set it to 0x11 ;machine mode
    writeMachineStatus(x);
}