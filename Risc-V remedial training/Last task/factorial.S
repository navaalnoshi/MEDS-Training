.section .rodata
fmt: .string "Factorial is %ld\n"

.section .data
num: .dword 5
result: .dword 0

.section .text
.globl main

main:
    # Load input
    la a0, num
    ld a0, 0(a0)

    call factorial

    # Store result
    la t0, result
    sd a0, 0(t0)

    # Print result
    la a0, fmt     # a0 = format string
    ld a1, 0(t0)   # a1 = result
    call printf

    li a0, 0
    call exit

# uint64_t factorial(uint64_t n)
factorial:
    addi sp, sp, -16
    sd ra, 8(sp)
    sd a0, 0(sp)

    li t0, 1
    bge t0, a0, base_case

    addi a0, a0, -1
    call factorial

    ld t1, 0(sp)
    mul a0, a0, t1

base_case:
    ld ra, 8(sp)
    addi sp, sp, 16
    ret
