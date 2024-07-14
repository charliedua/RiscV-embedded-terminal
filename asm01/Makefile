ASM_FILE 	= myterm.S
C_FILE 		= start.c
LINKER_FILE = kernel.lds

ASM_BUILD_OUT_FILE = boot.o
C_BUILD_OUT_FILE = start.o
KERNEL = kernel.elf

# default
all: build

build:
	riscv64-unknown-elf-gcc -c $(C_FILE) -o $(C_BUILD_OUT_FILE) -g
	riscv64-unknown-elf-as $(ASM_FILE) -o $(ASM_BUILD_OUT_FILE) -g
	riscv64-unknown-elf-ld -T $(LINKER_FILE) $(ASM_BUILD_OUT_FILE) $(C_BUILD_OUT_FILE) -o $(KERNEL)
	rm -f $(ASM_BUILD_OUT_FILE) $(C_BUILD_OUT_FILE)

debug:
	qemu-system-riscv64 -machine virt -cpu rv64 -smp 1 -m 128M -nographic -serial mon:stdio -bios none -kernel $(KERNEL) -s -S

run:
	qemu-system-riscv64 -machine virt -cpu rv64 -smp 1 -m 128M -nographic -serial mon:stdio -bios none -kernel $(KERNEL)

clean:
	rm -f $(ASM_BUILD_OUT_FILE) $(C_BUILD_OUT_FILE) $(KERNEL)