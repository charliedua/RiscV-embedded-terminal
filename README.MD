
## resources
- https://github.com/mit-pdos/xv6-riscv


## Privilage modes
machine
supervisor
user


## Machine mode

- set bit `11` and `12` in mstatus register to `0x11`


## FAQ

things on my mind while programming


### Why static inline?

- `static`: This keyword ensures that the function has internal linkage. It means that the function is only visible within the file it is defined in. This can help prevent naming conflicts in larger projects where multiple files might define similar utility functions.
- `inline`: This keyword suggests to the compiler that it should attempt to embed the function's code directly into each place the function is called, rather than generating a separate function call. This can improve performance by avoiding the overhead of a function call, particularly for small functions like the ones provided.


### asm volatile and colon `:`

- volatile: stops optimizing
    ```c
    asm ( assembler template 
        : output operands                  /* optional */
        : input operands                   /* optional */
        : clobbered registers              /* optional */
    );
    ```