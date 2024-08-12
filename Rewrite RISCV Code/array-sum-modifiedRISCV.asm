## Sum an array with a subroutine.
## Kevin Welch and Aidan Goroway Feb. 2024
##      (RISC-v Modified by Aidan Goroway 3/12/2024)

                                   
        .data
PR_INT: .word 1
array:  .word -123, 548, 923, 431, 560, -348, 961
endarr:
str:    .byte 'T', 'h', 'e', ' ', 's', 'u', 'm', ' ', 'o', 'f', ' ', 't', 'h', 'e', ' ', 'a', 'r', 'r', 'a', 'y', ' ', 'i', 's', ' ', '=', ' ' 
        .text
        .align 2
main:   addi x30, x0, 2      # x30 = 2, for srl opporation
        lw x5, PR_INT
        la x10, array        # x10 points into array
        la x11, endarr       # x11 points to array end
        sub x6, x11, x10    # Calculating endarr before shift
        srl x6, x6, x30      # Divides by 4 to calculate endarr
        mv x11, x6
	addi x2, x2, -4    # push 
	sw x1, 0(x2)       #   ret addr on stack
        jal arrsum
        add x7, x17, x0
	lw x1, 0(x2)       # pop
	addi x2, x2, 4     #   ret addr
        la x10, str        # integer to print
        li x17, 4        # system call code for print_string
        ecall          # print 

        add x10, x0, x7     # copy sum into x10
        add x17, x0, x5 # print code in x17
        ecall
        j program_end


        jr x1                  

## array-summation subroutine
## register use:
##	x10: parameter: array addr; used as pointer to current element
##	x11: parameter: points just after the array end
##	x17: accumulator and return value
##	x29: temporary copy of current array element

arrsum: mv x17, x0         # x17 accumulates sum
        add x28, x0, x0
sum:    
        addi x28, x28, 1
        lw x29, 0(x10)       #    get next array element
        add x17, x17, x29    #    add it in
        addi x10, x10, 4     #    point to next word
        blt x28, x11, sum   # while counter < endarr do           #    and do it again
        jr x1

program_end:
