.data
failure_message: .asciiz "Test failed for some reason.\n"
success_message: .asciiz "Sanity checks passed! Make sure there are no CC violations.\n"
array:
    .word 1, 2, 3, 4, 5
exp_inc_array_result:
    .word 2, 3, 4, 5, 6

.text
.globl main
.globl failure

main:
    # Initialize saved registers for sanity checks
    li s0, 2623
    li s1, 2910
    li s11, 134

    # Test simple_fn
    jal simple_fn
    li t0, 1
    bne a0, t0, fail_simple_fn

    # Test naive_pow
    li a0, 2
    li a1, 7
    jal naive_pow
    li t0, 128
    bne a0, t0, fail_naive_pow

    # Test inc_arr
    la a0, array
    li a1, 5
    jal inc_arr
    jal check_arr # Verifies inc_arr

    # Sanity checks for saved registers
    li t0, 2623
    bne s0, t0, fail_sanity_s0
    li t1, 2910
    bne s1, t1, fail_sanity_s1
    li t2, 134
    bne s11, t2, fail_sanity_s11

    # Success
    li a0, 4
    la a1, success_message
    ecall
    li a0, 10
    ecall

fail_simple_fn:
    li a0, 4
    la a1, failure_message
    ecall
    li a0, 1  # Debug: Fail simple_fn
    ecall
    li a0, 10
    ecall

fail_naive_pow:
    li a0, 4
    la a1, failure_message
    ecall
    li a0, 2  # Debug: Fail naive_pow
    ecall
    li a0, 10
    ecall

fail_sanity_s0:
    li a0, 4
    la a1, failure_message
    ecall
    li a0, 3  # Debug: Fail sanity s0
    ecall
    li a0, 10
    ecall

fail_sanity_s1:
    li a0, 4
    la a1, failure_message
    ecall
    li a0, 4  # Debug: Fail sanity s1
    ecall
    li a0, 10
    ecall

fail_sanity_s11:
    li a0, 4
    la a1, failure_message
    ecall
    li a0, 5  # Debug: Fail sanity s11
    ecall
    li a0, 10
    ecall

failure:
    li a0, 4              # String print syscall
    la a1, failure_message
    ecall
    li a0, 10             # Exit syscall
    ecall

# Function: simple_fn
# Description: Returns 1 in a0.
simple_fn:
    li a0, 1
    ret

# Function: naive_pow
# Description: Computes a0 to the power of a1.
naive_pow:
    addi sp, sp, -4       # Prologue: Save s0
    sw s0, 0(sp)
    li s0, 1
naive_pow_loop:
    beq a1, zero, naive_pow_end
    mul s0, s0, a0
    addi a1, a1, -1
    j naive_pow_loop
naive_pow_end:
    mv a0, s0
    lw s0, 0(sp)          # Epilogue: Restore s0
    addi sp, sp, 4
    ret


# Function: inc_arr 
# Description: Increments each element of the array by 1.
# a0: Address of the start of the array
# a1: Number of elements in the array
inc_arr:
    # Prologue: Allocate space for ra, s0, s1, and a temp slot for t0
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)

    mv s0, a0             # Copy start of array to saved register
    mv s1, a1             # Copy length of array to saved register
    li t0, 0              # Initialize counter to 0
inc_arr_loop:
    beq t0, s1, inc_arr_end
    slli t1, t0, 2        # Convert array index to byte offset
    add a0, s0, t1        # Add offset to start of array (address of element)

    # Preserve t0 in its own dedicated stack slot before function call
    sw t0, 0(sp)
    jal helper_fn         # Call helper_fn
    # Restore t0 after function call
    lw t0, 0(sp)

    addi t0, t0, 1        # Increment counter
    j inc_arr_loop
inc_arr_end:
    # Epilogue: Restore ra, s0, s1 from their correct locations
    lw ra, 12(sp)
    lw s0, 8(sp)
    lw s1, 4(sp)
    addi sp, sp, 16
    ret


# Function: helper_fn
# Description: Increments the value at the memory address in a0.
helper_fn:
    addi sp, sp, -4       # Prologue: Save t1
    sw t1, 0(sp)
    lw t1, 0(a0)
    addi t1, t1, 1
    sw t1, 0(a0)
    lw t1, 0(sp)          # Epilogue: Restore t1
    addi sp, sp, 4
    ret

# Function: check_arr
# Description: Verifies that the array has been incremented correctly.
check_arr:
    la t0, exp_inc_array_result
    la t1, array
    addi t2, t1, 20       # Last element is 5 * 4 bytes off
check_arr_loop:
    beq t1, t2, check_arr_end
    lw t3, 0(t0)
    lw t4, 0(t1)
    bne t3, t4, failure   # Jump to failure if mismatch
    addi t0, t0, 4
    addi t1, t1, 4
    j check_arr_loop
check_arr_end:
    ret
