#   sum.asm	David Hemmendinger	6 April 2002
        # (RISC-V Modified by Aidan Goroway 3/8/2024)
#   Elementary program to add three numbers and store and print the sum.
#   Register use:
#	x5: temporary storage for data to be summed
#	x6: accumulates the sum
#	x17 (equivilent to MIPS $v0), x10 (equivilent to MIPS $a0): hold parameters to syscall

        .data                   # FYI: start of data section
num1:   .word    17             # three initial integer values
num2:   .word   -35
num3:   .word   276
sum:    .space    4             # allocate a word for the integer result

        .text                   # FYI: start of code section
        .align 2                # FYI: align to start code on a word boundary
        .globl main             # FYI: make 'main' visible to the simulator            
main:   
        lw   x5, num1           # temp = num1
        add   x6, x0, x5        # x6 (accumulate) = num1
        lw   x5, num2           # temp = num2
        add  x6, x6, x5         # x6 = num1 + num2
        lw   x5, num3           # temp = num3
        add  x6, x6, x5         # x6 = (num1 + num2) + num3
        addi x17, x0, 1          # Getting ready to print
        add  x10, x0,  x6        # x10 = x6
        ecall                   # Prints x10 
                               