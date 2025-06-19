.import lotsofaccumulators.s

.data
inputarray: .word 1,2,3,4,5,6,7,0
emptyarray: .word 0               # Test for empty array
oneelementarray: .word 10,0      # Test for one element array
negativearray: .word 1,-2,3,0     # Test for negative numbers (sum should be 2)

TestPassed: .asciiz "Test Passed!\n"
TestFailed: .asciiz "Test Failed!\n"

FailOneMsg: .asciiz " (Failed accumulatorone)\n"
FailTwoMsg: .asciiz " (Failed accumulatortwo)\n"
FailThreeMsg: .asciiz " (Failed accumulatorthree)\n"
FailFourMsg: .asciiz " (Failed accumulatorfour)\n"
FailFiveMsg: .asciiz " (Failed accumulatorfive)\n"

.text
main:
    # Test accumulatorone
    la a0 emptyarray
    jal accumulatorone
    li t0 0
    bne a0 t0 FailOne

    la a0 inputarray
    jal accumulatorone
    li t0 28
    bne a0 t0 FailOne

    # Test accumulatortwo
    la a0 inputarray
    jal accumulatortwo
    li t0 28
    bne a0 t0 FailTwo

    # Test accumulatorthree
    la a0 oneelementarray
    jal accumulatorthree
    li t0 10
    bne a0 t0 FailThree

    la a0 inputarray
    jal accumulatorthree
    li t0 28
    bne a0 t0 FailThree

    # Test accumulatorfour (Corrected version of the function)
    la a0 inputarray
    jal accumulatorfour
    li t0 28
    bne a0 t0 FailFour

    # Test accumulatorfive
    la a0 oneelementarray
    jal accumulatorfive
    li t0 10
    bne a0 t0 FailFive

    la a0 inputarray
    jal accumulatorfive
    li t0 28
    bne a0 t0 FailFive

    # If all tests pass
    la a0 TestPassed
    jal print_string
    j End

FailOne:
    la a0 TestFailed
    jal print_string
    la a0 FailOneMsg
    jal print_string
    j End

FailTwo:
    la a0 TestFailed
    jal print_string
    la a0 FailTwoMsg
    jal print_string
    j End

FailThree:
    la a0 TestFailed
    jal print_string
    la a0 FailThreeMsg
    jal print_string
    j End

FailFour:
    la a0 TestFailed
    jal print_string
    la a0 FailFourMsg
    jal print_string
    j End

FailFive:
    la a0 TestFailed
    jal print_string
    la a0 FailFiveMsg
    jal print_string
    j End

End:
    jal exit

# Helper Functions
print_int:
    mv a1, a0
    li a0, 1
    ecall
    jr ra

print_string:
    mv a1, a0
    li a0, 4
    ecall
    jr ra

exit:
    li a0, 10
    ecall

# Corrected accumulatorfour (Example logic)
accumulatorfour:
    addi sp, sp, -8        # Prologue
    sw ra, 0(sp)
    sw s1, 4(sp)

    li s1, 0               # Initialize sum
Loop:
    lw t0, 0(a0)           # Load current element
    beq t0, x0, EndLoop    # Exit loop if element is 0
    add s1, s1, t0         # Add to sum
    addi a0, a0, 4         # Move to next element
    j Loop

EndLoop:
    mv a0, s1              # Move sum to return register

    lw ra, 0(sp)           # Epilogue
    lw s1, 4(sp)
    addi sp, sp, 8
    jr ra
