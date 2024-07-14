

#define MSTATUS_M_MODE_ENCODING (3L << 11) // Encoding: 0x11 - machine mode
#define MSTATUS_MODE_CHANGE_HI_BITS (3L << 11) // Encoding: 0x11 at 11 and 12 to clear machine mode

static inline uint64 
readMachineStatus() {
    uint64 x;
    
    // in `=r` : r means use register here and = means to write to register 
    // asm ( code : ouput : input )
    asm volatile("csrr      %0, mstatus" : "=r" (x) ); 
    return x;
}

static inline void
writeMachineStatus(uint64 x) {
    asm volatile("csrw      mstatus, %0" : : "r" (x) );
}