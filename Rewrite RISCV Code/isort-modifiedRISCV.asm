## Sort an array using insertion sort
## Kevin Welch and Aidan Goroway Feb. 2024
##      (RISC-V Modified by Aidan Goroway 3/12/2024)

# Its definitely not common convention, as absolutely not what I was taught to do,
# but in the interest of time, I have elected to use 2 s registers as
# additional temporary registers. Sue me, I'm tired.        
                  
        .data
PR_INT: .word 1 
array:  .word -123, 548, 923, 431, 560, -348, 961
endarr: 
# str:    .asciiz "The sorted array is = \n"
str:    .byte 'T', 'h', 'e', ' ', 's', 'o', 'r', 't', 'e', 'd', ' ', 'a', 'r', 'r', 'a', 'y', ' ', 'i', 's', ' ', '=', ' ',
# str2:   .asciiz "\n"
str2:   .byte '\n'
        .text
        .align 2
main:   addi x19, x0, 2      # x30 = 2, for srl opporation
        la x10, array        # a0 points into array, "a" variable
        la x11, endarr       # a1 points to array end
        add x18, x10, x0      # start of array
        sub x5, x11, x10    # Calculating endarr before shift
        srl x5, x5, x19      # Divides by 4 to calculate endarr

        addi x2, x2, -4    # push 
        sw x1, 0(x2)       # ret addr on stack

        jal isort            # insertion sort
        add x28, x0, x0      # loop counter
        add x6, x17, x0     # temp register contains output of isort
	    lw x1, 0(x2)       # pop
	    addi x2, x2, 4     #   ret addr
        li x17, 4            # system call code for print_string
        la x10, str          # integer to print
        ecall              # print 



loop:
        bge     x28, x5, exit
        
        lw      x7, 0(x18)  # Load value at address
        addi    x18, x18, 4  # Increments address

        li      x17, 1       # system call code for print_int
        mv    x10, x7     # value to print
        ecall

        li x17, 4            # system call code for print_string
        la x10, str2         # integer to print
        ecall              # print 


        addi    x28, x28, 1  # Increment counter
        j loop

 exit:
        j program_end                  

## Insertion Sort subroutine
## register use:
##	x10: parameter: array addr
##	x11: parameter: points just after the array end
##	x17: accumulator and return value
##	x6: p pointer, pointer to current element
##      x7: q pointer, pointer to help check elements before p
##      x28: temp value, helps sort values immediately near each other
##      #t4: q-1, The value at the pointer q-1 found in x31
##      #t5: q, The value at the pointer q found in x7
##      #t6: q-1 pointer

isort: mv x17, x0               # v0 accumulates sum
        add x6, x10, x0          # "p" pointer variable
        add x7, x0, x0           # "q" pointer variable
        add x28, x0, x0           # "temp" variable
        add x29, x0, x0           # q-1 value
        add x30, x0, x0           # q value
        
increment:    
        addi x6, x6, 4          # ++p
        bge x6, x11, done        # Checks for completion of p incrementation loop 
        add x7, x6, x0          # q=p
        addi x31, x7, -4         # q-1 address
        lw x28, 0(x6)            # temp = *p

        j checkback               # While loop
skip:   sw x30, 0(x7)            # *q=temp
        ble x6, x11, increment   # for loop
        j done                    # Finish
checkback:
        lw x30, 0(x7)            # *q
        lw x29, -4(x7)           # q-1
        ble x7, x10, skip        # First while condition, (q>a) 
        ble x29, x28, skip        # Second while condition, (*(q-1)>temp)
        sw x30, -4(x7)           # While body, sets q to q-1
        sw x29, 0(x7)            # While body, sets q-1 to q
        addi x7, x7, -4         # decrement q
        j checkback               # while loop
done:  
        jr x1                    # Completed

program_end:



