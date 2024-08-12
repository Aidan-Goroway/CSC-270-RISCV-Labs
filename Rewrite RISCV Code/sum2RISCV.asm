#   sum2.asm	David Hemmendinger	6 April 2002
        #   (RISC-V Modified by Aidan Goroway 3/9/2024)
#   Elementary program to add three numbers and store and print the sum.
#   Register use:
#	x5: temporary storage for data to be summed
#	x6: accumulates the sum
#	x17 (equivilent to MIPS $v0), x10 (equivilen to MIPS $a0): hold parameters to ecall

        .data                   # FYI: start of data section
num1:   .word    99             # three initial integer values
num2:   .word   543
num3:   .word   -256
sum:    .space    4             # allocate a word for the integer result

        .text                   # FYI: start of code section
        .align 2                # FYI: align to start code on a word boundary
        .globl main             # FYI: make 'main' visible to the simulator
main:                           
        lw   x5, num1           #    temp  = num1 
        add  x6, x0, x5         #    accum = temp
        lw   x5, num2           #    temp  = num2
        add  x6, x6, x5         #    accum = accum + temp
        lw   x5, num3           #    temp  = num3
        add  x6, x6, x5         #    accum = accum + temp
        addi x17, x0, 1          #    x17   = code for 'print-int'
        add  x10, x0, x6         #    x10   = accum
        ecall                   #    ecall(x17=1) prints x10
