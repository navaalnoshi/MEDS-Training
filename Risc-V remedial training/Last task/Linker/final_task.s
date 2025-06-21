.section .text
.globl _start

_start:
    la a0, num         # Load address of num
    ld a0, 0(a0)       # Load num into a0
    call factorial     # Call factorial(num)

    la t0, result      # Address to store result
    sd a0, 0(t0)       # Store result

    j write_tohost     # Terminate

# uint64_t factorial(uint64_t num)
factorial:
    addi sp, sp, -16   # Make stack space
    sd ra, 8(sp)       # Save return address
    sd a0, 0(sp)       # Save argument (num)

    li t0, 1
    bge t0, a0, base_case # if num <= 1, return 1

    addi a0, a0, -1    # a0 = num - 1
    call factorial     # recursive call

    ld t1, 0(sp)       # Load original num
    mul a0, a0, t1     # result = num * factorial(num - 1)

base_case:
    ld ra, 8(sp)       # Restore return address
    addi sp, sp, 16    # Restore stack
    ret

# Termination for SPIKE
write_tohost:
    li x1, 1
    la t5, tohost
    sd x1, 0(t5)
    j write_tohost
.section .data

num:    .dword 5        # 64-bit integer input
result: .dword 0        # 64-bit result placeholder

.align 12
.section ".tohost","aw",@progbits
.align 4; .global tohost; tohost: .dword 0
.align 4; .global fromhost; fromhost: .dword 0
