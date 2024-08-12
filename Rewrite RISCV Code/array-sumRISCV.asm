## Sum an array with a subroutine.
## David Hemmendinger 4 April 2006
        # (RISC-V Modified by Aidan Goroway 3/9/2024)

                             # REMOVE this comment and the next one
        .data
PR_INT: .word 1                   # (example of defining a constant)
array:  .word -123, 548, 923, 431, 560, -348, 961
endarr:
        .text
        .align 2
main:   lw x5, PR_INT # assign x5 to the constant PR_INT
        la x10, array        # a0 points into array
        la x11, endarr       # a1 points to array end
	addi x2, x2, -4    # push 
	sw x1, 0(x2)       #   ret addr on stack
        jal arrsum
	lw x1, 0(x2)       # pop
	addi x2, x2, 4     #   ret addr
        add x10, x0, x17     # copy sum into x10
        add x17, x0, x5 # print code in x17
        ecall
        j program_end
# "jr x1" at the end of a program seems to cause issues, unlike "jr $ra" did in MIPS.
# my fix for this is to instead use a normal j, jumping to a label past any accessable code.     

## array-summation subroutine
## register use:
##	x10: parameter: array addr; used as pointer to current element
##	x11: parameter: points just after the array end
##	x17: accumulator and return value
##	x6: temporary copy of current array element

arrsum: mv x17, x0         # x17 accumulates sum
sum:    bge x10, x11, done   # while x10 < endarr do
        lw x6, 0(x10)       #    get next array element
        add x17, x17, x6    #    add it in
        addi x10, x10, 4     #    point to next word
        j sum                #    and do it again
done:   jr x1

program_end: