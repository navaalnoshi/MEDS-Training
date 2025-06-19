.data
array: .space 40

msg1: .asciiz "Printing array: "

.text
dataArray:

    add s0, x0, x0      # i = 0
    addi a0, x0, 100      # num
    la s1, array           # s1 = address of array
    addi t0, x0, 10
Loop:

    bge s0, t0, exit
    jal ra, compare

    addi t1,x0,4         # 4 bytes per word
    mul t2, s0, t1     # t4 = i * 4 (byte offset)

    add t2,t2,s1
    sw  a3, 0(t2)  ### store t1 to b[i]

    addi s0, s0, 1
    j Loop

     

compare:
    addi sp,sp,-4
    sw ra,0(sp)
    jal ra,sub

    lw ra,0(sp)
    addi sp,sp,4

    bge a2,x0,return1

    add a3,x0,x0
    jalr x0, ra, 0


return1:
    add a3,x0,x0
    addi a3,x0,1
    jalr x0, ra, 0
sub:
    sub a2, a0,s0
    jalr x0, ra, 0

##Printing array
    la a1, msg1    
    addi a0, x0, 4
    ecall

exit:

    la a1, msg2    
    addi a0, x0, 4
    ecall
  addi a1, x0, '\n'   # Load in ascii code for newline
    addi a0, x0, 11
    ecall
   
    add s0, x0, x0      # i = 0
    addi t0, x0, 10
     la s1, array

loop:

    bge s0, t0, exit1

    addi t1,x0,4         # 4 bytes per word
    mul t2, s0, t1     # t4 = i * 4 (byte offset)

    add t2,t2,s1

    lw  a1, 0(t2)  ### store t1 to b[i]
    addi a0, x0, 1
    ecall

    addi a1, x0, '\n'   # Load in ascii code for newline
    addi a0, x0, 11
    ecall


    addi s0, s0, 1
    j loop

exit1:

     
    