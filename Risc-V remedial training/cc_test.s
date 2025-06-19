# Just a simple function. Returns 1.
simple_fn:
    li a0, 1
    ret

# Computes a0 to the power of a1.
naive_pow:
    # BEGIN PROLOGUE
    addi sp, sp, -4
    sw s0, 0(sp)
    # END PROLOGUE
    li s0, 1
naive_pow_loop:
    beq a1, zero, naive_pow_end
    mul s0, s0, a0
    addi a1, a1, -1
    j naive_pow_loop
naive_pow_end:
    mv a0, s0
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    addi sp, sp, 4
    # END EPILOGUE
    ret

# Increments the elements of an array in-place.
inc_arr:
    # BEGIN PROLOGUE
    addi sp, sp, -12
    sw ra, 8(sp)
    sw s0, 4(sp)
    sw s1, 0(sp)
    # END PROLOGUE
    mv s0, a0 # Copy start of array to saved register
    mv s1, a1 # Copy length of array to saved register
    li t0, 0 # Initialize counter to 0
inc_arr_loop:
    beq t0, s1, inc_arr_end
    slli t1, t0, 2 # Convert array index to byte offset
    add a0, s0, t1 # Add offset to start of array
    sw t0, 0(sp)   # Preserve t0 before function call
    jal helper_fn
    lw t0, 0(sp)   # Restore t0 after function call
    addi t0, t0, 1 # Increment counter
    j inc_arr_loop
inc_arr_end:
    # BEGIN EPILOGUE
    lw ra, 8(sp)
    lw s0, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 12
    # END EPILOGUE
    ret

# This helper function adds 1 to the value at the memory address in a0.
helper_fn:
    # BEGIN PROLOGUE
    addi sp, sp, -4
    sw t1, 0(sp)
    # END PROLOGUE
    lw t1, 0(a0)
    addi t1, t1, 1
    sw t1, 0(a0)
    # BEGIN EPILOGUE
    lw t1, 0(sp)
    addi sp, sp, 4
    # END EPILOGUE
    ret
