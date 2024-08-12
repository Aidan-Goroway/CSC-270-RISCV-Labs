#   swap.asm	David Hemmendinger	6 April 2002
    #   (swap.asm (RISC-V Modified)	Aidan Goroway	3/9/2024)
#   Elementary program to swap the contents of two elements in an array.

#   Register use:
#	x5: Holds the array
#	x6 & x7: Points to the data at 2 indicies of the array
#   x28 & x29: Stores the data from the prior 2 registers
#   x30: Stores the word 2 in a register, so I can perform sll operations with it

        .data                   # FYI: start of data section
ar:     .word   10, 20, 30, 40, 50, 60      # array
indexi: .word   1
indexj: .word   4


        .text                   # FYI: start of code section
        .align 2                # FYI: align to start code on a word boundary
        .globl main             # FYI: make 'main' visible to the simulator

main:
        addi x30, x0, 2         # x30 = 2 (for the sake of sll opperations)
        la x5, ar               # x5 = array
        lw x6 indexi            # x6 = array[1]
        lw x7 indexj            # x7 = array[4]

        sll x6 x6 x30           # multiples the contents of x6 by 4
        add x6 x6 x5            
        lw x28 0(x6)            # x28 = contents of array[1]

        sll x7 x7 x30           # multiples the contents of x7 by 4
        add x7 x7 x5
        lw x29 0(x7)            # x29 = contents of array[4]

        sw x29 0(x6)            # array[1] = contents of x29 (array[4])
        sw x28 0(x7)            # array[4] = contents of x28 (array[1])

