# R3000

Simulate MIPS32 R3000 CPU with VHDL.

To simulate the CPU, commands are in " run.sh " (Work with mac os and ghdl 0.37).

The testbench of R3000 simulate the following code :

```
// To compile the program with MIPS32 R3000
// clang --target=mips-linux-none-eabi -march=mips32r3 -c dump.c -o dump.o
// To display assembly code
// llvm-objdump -D dump.o

int main(int argc, char const *argv[])
{
    int a = 5;
    int b = 3;
    
    int c = a + b;

    c <<= 2;

    if (c < 64)
        c = c - 4;

    return 0;
}
```