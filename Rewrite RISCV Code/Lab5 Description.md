This lab is an introduction to the RARS simulator for the RISC-V processor. The version of RARS we're using is RARS 1.6, which is a recent release, and therefore has a few kinks which we have to work around. Thanks in advance for your patience.

You may find this  [RISC-V Refference Sheet useful.](https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf)
1.  Launch the RARS 1.6 application

-   Note the layout of the window. The register values for the simulator are on the right, in their own tab, and the "base" assembly code (think of it like a very primitive operating system) is under the "Source" label of the Text Segment.

2.  Download the file sumRISCV.asm, saving it to your Lab 5 directory, and open it up with a text editor.

	-   The first thing you will notice is that comments begin with the # sign. Everything to the right of these on a line is ignored.
	-   Next you'll notice that there is a .data section and a .text section. The .data section is how how specify data to load into data memory, and the .text section contains the relevant assembly code.
	-   You'll also notice these "tags" along the left hand side of the text. Tags are mnenomics, or short-hand, for data memory locations. When you're writing assembly code, you can specify an immediate value via a tag, instead of specifying the memory location directly (this makes sense, because you never actually know where data will wind up in memory until the code is assembled and linked -- a topic we'll get to later this week)

	-   Some more detail on the code: the text segment starts at address 0x00400000. That is the address of several lines of code that start the simulator and then executes your program by calling it as a subroutine (jal main at address 0x00400014). Your actual written program actually begins at address 0x00400024. When your program ends, it returns control at this point, and the simulator executes syscall with argument 10 (in x10). This system call terminates the simulator run.

3.  Load  [sumRISCV.asm](https://nexus.union.edu/mod/resource/view.php?id=687846 "sumRISCV.asm")  from RARS 1.6. You'll notice that your LW instructions have been replaced by lui lw pairs. In each case, the value 4097 is used as the argument to lui. Keep a note of that for part 5 below, but we'll discuss the details of this in class wednesday.  
    
4.  The data in your .data field gets loaded into physical memory. You'll see that the numbers 17, -35 and 276 are stored beginning at physical memory location 0x10010000. (0x1001 is 0d4097. coincidence?). You may have to switch the display of data from hex to decimal in the Settings menu.
5.  Run the program and record the value printed to the console (see below about the screenshot application)  
    
6.  Set breakpoints at every LW and every add instruction (control-click), and then run the code by clicking the green "Play" button. You'll notice that the value of your registers updates each time you hit a break point. Record the value of the registers at a couple of breakpoints by taking a screenshot (Use the screenshot app)

	- 	the console appears at the bottom of the screen.
	-   don't go crazy on screenshots. I just need to enough to know your register values are changing.

7.  Edit a copy of  [sumRISCV.asm](https://nexus.union.edu/mod/resource/view.php?id=687846 "sumRISCV.asm")  (call it sum2RISCV.asm), changing the three integers being summed, and rerun the program. Add breakpoints, run the code again and record the value of the registers before, during, after execution in order to demonstrate that it works.  (again don't go crazy with screenshots, just show me it works)
8.  Write a RISC-V assembly-language program (swapRISCV.asm) that will swap the contents of two elements of an array, given the array and the indices of the elements to be swapped. Run the program and print screen snapshots of the data window before and after.  Mark the variable locations whose contents have been exchanged. Some notes:

	-   To declare an array, do something like the following:
	-   ar: .word 5, 17, -3, 22, 120, -1 # a six-element array

	-   note: the spaces after the commas are important!

	-   For the indices, use two more integer variables declared in the data section with  .word. (You can't use 'j' as a variable name, since 'j' is an opcode ("jump")).
	-   you will need to use the instruction "la" to load the  address  of a labeled variable into a register. example:
	-   la x5, ar

Hand In: 
-   your assembly files (sum2RISCV.asm and swapRISCV.asm)

-   be sure your name is written on the top of each file!

-   annotated screenshots of relevant portions above (enough to show me that registers change
-   and your code is doing what you expect.

How I will test your code:

-   I will run swapRISCV.asm on a variety of different array inputs, and confirm correct behavior
