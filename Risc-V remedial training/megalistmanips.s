map:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s1, 4(sp)
    sw s0, 8(sp)

    beq a0, x0, base_case    # if we were given a null pointer, we're done.

    add s0, a0, x0           # save address of this node in s0
    add s1, a1, x0           # save address of function in s1
    add t0, x0, x0           # t0 is a counter

mapLoop:
    lw t1, 0(s0)             # load the array pointer of the current node into t1
    lw t2, 4(s0)             # load the size of the node's array into t2

loop_body:
    slli t3, t0, 2           # offset index by 4 bytes
    add t4, t1, t3           # calculate array address
    lw a0, 0(t4)             # load the value at that address into a0

    jalr ra, s1              # call the function on that value.
    sw a0, 0(t4)             # store the returned value back into the array

    addi t0, t0, 1           # increment the count
    blt t0, t2, loop_body    # repeat if we haven't reached the array size yet

    lw a0, 8(s0)             # load the address of the next node into a0
    jal map                  # recurse

base_case:
    lw s0, 8(sp)
    lw s1, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12
    jr ra
