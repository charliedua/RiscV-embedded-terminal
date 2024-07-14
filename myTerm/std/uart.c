#define UART_BASE 0x10000000    // Replace with the actual UART base address
#define MAX_BUFFER_SIZE 128     // Adjust as needed

#define UART_LCR_OFFSET \x0
#define UART_DIV_OFFSET \x4
#define UART_TRX_OFFSET \x8
#define UART_FCR_OFFSET \x0C
#define UART_LSR_OFFSET \x10


void 
printStr(const char *str) {

    // Check if end of string
    while (*str != '\0') {
        // Write byte/char to UART
        *(volatile unsigned char *)UART_BASE = *str; 
        // next byte/char
        str++;
    }
}

void 
readStr(char *ret) {
    char inputChar;
    int i = 0;

    // Read characters until a carriage return ('\r') is encountered
    do {
        // Wait for a character to be received
        while (!(*(volatile unsigned char *)UART_BASE & 0x01)); // Wait for RX data ready flag
        
        // Read byte/char from UART
        inputChar = *(volatile unsigned char *)UART_BASE;

        // Debounce delay (adjust as needed)
        for (volatile int delay = 0; delay < 100000; delay++); // Adjust delay based on your system speed


        // Store the character in the buffer
        ret[i] = inputChar;
        i++;
    } while (inputChar != '\r' && i < MAX_BUFFER_SIZE - 1); // Continue until '\r' or buffer full

    // Null-terminate the string in the buffer
    ret[i] = '\0';
}