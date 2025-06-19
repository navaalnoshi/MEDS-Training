.globl map

.data
arrays: .word 5, 6, 7, 8, 9
        .word 1, 2, 3, 4, 7
        .word 5, 2, 7, 4, 3
        .word 1, 6, 3, 8, 4
        .word 5, 2, 7, 8, 1

start_msg:  .asciiz "Lists before: \n"
end_msg:    .asciiz "Lists after: \n"

.text
main:
    jal create_default_list
    mv s0, a0   # s0 is head of node list returned from create_default_list

    # Print "Lists before: " message
    la a1, start_msg
    li a0, 4
    ecall

    # Print the list
    add a0, s0, x0 # Pass head of list to a0
    jal print_list

    jal print_newline

    add a0, s0, x0      # load the address of the first node (head) into a0
    la  a1, mystery     # load the address of the 'mystery' function into a1 (the function pointer f)

    jal map             # Call the map function

    # Print "Lists after: " message
    la a1, end_msg
    li a0, 4
    ecall

    # Print the modified list
    add a0, s0, x0 # Pass head of list to a0
    jal print_list

    li a0, 10           # System call code for exit
    ecall

map:
    addi sp, sp, -12
    sw ra, 0(sp)        # Save return address
    sw s1, 4(sp)        # Save s1 (which will hold the function pointer f)
    sw s0, 8(sp)        # Save s0 (which will hold the current node's address, head)

    beq a0, x0, done

    add s0, a0, x0      # s0 = head (address of this node)
    add s1, a1, x0      # s1 = f (address of the function to apply)
    add t0, x0, x0      # Initialize loop counter 'i' to 0 (t0 = 0)

mapLoop:
    lw t1, 0(s0)        # t1 now holds the base address of the array (head->arr)

    # Load the size of the node's array (node->size) into t2.
    lw t2, 4(s0)        # t2 now holds the array size

   
    # slli t3, t0, 2 multiplies t0 (index) by 4 (size of int) to get byte offset.
    slli t3, t0, 2
    add t4, t1, t3      # t4 = address of head->arr[i]
    lw a0, 0(t4)        # a0 = head->arr[i]
    jalr s1             # Call the function f (mystery) on the value.
    sw a0, 0(t4)        # Store result (from a0) back into head->arr[i] (at address in t4)

    # Increment the loop counter 'i'.
    addi t0, t0, 1
    bne t0, t2, mapLoop
    lw a0, 8(s0)        # a0 = head->next (address of the next node)
    add a1, s1, x0      # a1 = f (address of the function)

    # Recurse: Call the map function for the next node in the list.
    jal map

done:
    # Restore saved registers from the stack in reverse order of saving.
    lw s0, 8(sp)        # Restore s0
    lw s1, 4(sp)        # Restore s1
    lw ra, 0(sp)        # Restore return address

    addi sp, sp, 12
    jr ra
print_newline:
    li a1, '\n'         # ASCII code for newline character
    li a0, 11           # Syscall code for print_char
    ecall
    jr ra               # Return from print_newline

mystery:
    mul t1, a0, a0      # t1 = a0 * a0 (temporary register, can be clobbered by caller)
    add a0, t1, a0      # a0 = t1 + a0 (result = x*x + x)
    jr ra               # Return from mystery

create_default_list:
    addi sp, sp, -24
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)

    # Initialize registers:
    li s0, 0    # s0 = pointer to the last node we handled (initially null)
    li s1, 0    # s1 = number of nodes handled (loop counter i)
    li s2, 5    # s2 = size of each array (fixed at 5)
    la s3, arrays # s3 = base address of the 'arrays' data section

loop: # do... (start of loop to create nodes)
    # Allocate memory for a new node (12 bytes).
    li a0, 12
    jal malloc      # Call malloc, address of new node returned in a0
    mv s4, a0       # Save address of new node in s4

    li a0, 20
    jal malloc      # Call malloc, address of new array returned in a0

    sw a0, 0(s4)    # node (at s4) -> arr (at offset 0) = malloc_array_addr (from a0)

    lw a0, 0(s4)    # a0 = node->arr (pass array destination)
    mv a1, s3       # a1 = source array address (from 'arrays' data)
    jal fillArray   # Call fillArray to copy data

    sw s2, 4(s4)    # node (at s4) -> size (at offset 4) = 5 (from s2)

    sw s0, 8(s4)    # node (at s4) -> next (at offset 8) = previously created node (from s0)
    add s0, x0, s4  # s0 = s4 (last = current_node)
    addi s1, s1, 1  # s1 = s1 + 1 (i++)
    addi s3, s3, 20 # s3 = s3 + 20 (points to next 5-int block)
    li t6, 5        # Load loop limit 5 into t6
    bne s1, t6, loop # ... while i != 5

    # Return the address of the head of the list (the last node created, which is the first node logically).
    mv a0, s4

    # Restore saved registers from the stack.
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    addi sp, sp, 24 # Restore stack pointer

    jr ra           # Return from create_default_list

fillArray:
    # Copies 5 integers from the source array (a1) to the destination array (a0).
    # Assumes a0 is dest, a1 is source.
    lw t0, 0(a1)    # t0 gets array element from source (offset 0)
    sw t0, 0(a0)    # dest gets array element (offset 0)
    lw t0, 4(a1)
    sw t0, 4(a0)
    lw t0, 8(a1)
    sw t0, 8(a0)
    lw t0, 12(a1)
    sw t0, 12(a0)
    lw t0, 16(a1)
    sw t0, 16(a0)
    jr ra           # Return from fillArray

print_list:
    # Base case: if the current node (a0) is null, return.
    bne a0, x0, printMeAndRecurse
    jr ra           # Nothing to print

printMeAndRecurse:
    mv t0, a0       # t0 gets address of current node
    lw t3, 0(a0)    # t3 gets base address of array of current node (node->arr)
    li t1, 0        # t1 is index into array (i = 0)

printLoop:
    slli t2, t1, 2  # t2 = i * 4 (byte offset)
    add t4, t3, t2  # t4 = address of current element (array_base + offset)
    lw a1, 0(t4)    # a1 gets value in current node's array at index t1 (value to print)
    li a0, 1        # syscall code for print_int
    ecall           # Print the integer

    li a1, ' '      # ASCII code for space character
    li a0, 11       # syscall code for print_char
    ecall           # Print a space

    addi t1, t1, 1  # Increment index (i++)
    li t6, 5        # Load array size (5) into t6 for comparison
    bne t1, t6, printLoop # ... while i != 5 (i.e., i < 5)

    li a1, '\n'     # ASCII code for newline character
    li a0, 11       # syscall code for print_char
    ecall           # Print a newline after printing all elements of the current array

    lw a0, 8(t0)    # Load the address of the next node (node->next) into a0
    j print_list

malloc:
    mv a1, a0       # Move requested size from a0 to a1 for syscall convention
    li a0, 9        # syscall code for sbrk (allocate heap memory)
    ecall           # Perform the syscall
    jr ra           # Return allocated address in a0
