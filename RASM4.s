//FILE MODES
.equ	READONLY,	00
.equ	WRITEONLY,	01
.equ	READWRITE,	02
.equ	CREATEWO,	0101

// FILE PERMS
.equ	RW_RW__,	660
.equ AT_FDCWD, -100

	.data

//MENU STRINGS
szTE:		.asciz	"\tRASM4 TEXT EDITOR\n"
szMemCon:	.asciz	"\tData Structure Heap Memory Consumption "
szBytes:	.asciz	" bytes\n"
szNumNodes:	.asciz	"\tNumber of Nodes: "

szOpt1:		.asciz	"<1> View all strings\n\n"

szOpt2:		.asciz	"<2> Add string\n"
szOpt2a:	.asciz	"\t<a> From Keyboard\n"
szOpt2b:	.asciz	"\t<b> From File. Static file named input.txt\n\n"

szOpt3:		.asciz	"<3> Delete string. Given am index #, delete the entire string and de-allocate memory (including the node)\n\n"

szOpt4:		.asciz	"<4> Edit string. Given and index #, replace old string w/ new string. Allocate/De-allocate as needed.\n\n"

szOpt5:		.asciz	"<5> String search. Regaurdless of case, return all strings that match the substring given.\n\n"

szOpt6:		.asciz	"<6> Save File (output.txt)\n\n"

szOpt7:		.asciz	"<7> Quit\n\n\n"

szSubOpt:	.asciz	"Please select a sub-option: "

// OTHER STRINGS
szNL:		.asciz	"\n"
szGetOpt:	.asciz	"Please select an option: "
szValidIn:	.asciz	"Please select a valid option: "
szEnterStr:	.asciz	"Enter a string to search for: "
szEnterStrI:	.asciz	"Enter the index of string: "
szStrToReplace:	.asciz	"Enter the string to replace: "
szWriteToOut:	.asciz	"Enter what you want to write to output.txt: "

// File Locations 
szOutFile:	.asciz "./output.txt"
szInFile:	.asciz	"./input.txt"


kbBuf:		.skip	512		// keyboard buffer
szBuf:		.skip	90000
szInFileBuf:	.skip	90000

	.global	_start
	.text

_start:

	ldr	X0,	=szNL  //load new line
	bl	putstring  //call putsring
	ldr	X0,	=szNL  //load new line
	bl	putstring  //call putstring

	// Below prints the menu
	ldr	X0,	=szTE   //load szTE
	bl	putstring   //call putstring
	ldr	X0,	=szMemCon  //load szMemCon
	bl	putstring   //load szTE
	
	// print num bytes here
	ldr	X0,	=szBytes //load szBytes
	bl	putstring //call putstring
	ldr	X0,	=szNumNodes //loadNumNodes
	bl	putstring //call putstring
	ldr	X0,	=szNL  //load szNL
	bl	putstring //call putstring
	ldr	X0,	=szNL //load szNL
	bl	putstring //call putstring
	ldr	X0,	=szOpt1  //load szOpt1
	bl	putstring //call putstring
	ldr	X0,	=szOpt2 //load szOpt2
	bl	putstring //call putstring
	ldr	X0,	=szOpt2a //load szOpt2
	bl	putstring //call putstring
	ldr	X0,	=szOpt2b //load szOpt2B
	bl	putstring //call putstring
	ldr	X0,	=szOpt3 //load szOpt3
	bl	putstring //call putstring
	ldr	X0,	=szOpt4 //load szOpt4
	bl	putstring //call putstring
	ldr	X0,	=szOpt5 //load szOpt5
	bl	putstring //call putstring
	ldr	X0,	=szOpt6 //load szOpt6
	bl	putstring //call putstring
	ldr	X0,	=szOpt7 //load szOpt7
	bl	putstring //call putstring


	// load the input file into szbuf
	MOV X0, #AT_FDCWD	//local directory	
	mov	X8,	#56 //call load in file
	ldr	X1,	=szInFile //load file
	mov	X2,	#READONLY //mark file read only
	svc	0	  //SYSTEM CALL
	mov	X26,	X0
	

	// reads 90000 bytes into the szBuf
	mov	X8,	#63  //call read in file
	ldr	X1,	=szInFileBuf //call szFileBuffer
	mov	X2,	#45000  //load 4500
	add	X2,	X2,	X2  //multiple by 2
	mov	X19, X2  //move number of bytes to read into X19
	svc	0  //system call

	// closes input file	
	mov	X0,	X26  
	mov	X8,	#57 //close input file
	svc	0

	// Asking for user input
	ldr	X0,	=szGetOpt //load szGetOpt
	bl	putstring	 //call putstring 



getIn1:
	ldr	X0,	=kbBuf		// load kbBuf
	mov	X2,	#2		// get string length
	bl getstring

	// Checking what option was selected
	LDR X0, =kbBuf		//load keyboard buffer
	LDRB W0, [X0]
	bl	getOption		// jump to check what option was selected

Opt1:	// CODE FOR OPTION 1 GOES HERE

	// Option 1 reads and prints everything from output.txt (just do 90000  bytes)

	// load the input file into szbuf 
	MOV X0, #AT_FDCWD	//local directory
	mov	X8,	#56			 // OPENAT
	ldr	X1,	=szOutFile //load file
	
	mov	X2,	#READONLY //mark file read only
	svc	0	  //SYSTEM CALL
	mov	X26,	X0

	// reads 90000 bytes into the szBuf
	mov	X8,	#63  //call read in file
	ldr	X1,	=szBuf //call szFilebuf
	mov	X2,	#45000  //load 4500
	add	X2,	X2,	X2  //multiple by 2
	svc	0  //system call

	// prints using putstring
	ldr	X0,	=szBuf //find szbuffer
	bl	putstring  //print everything
	

	// closes input file	
	mov	X0,	X26  
	mov	X8,	#57 //close input file
	svc	0 //system call

	b	_start

Opt2:	// CODE FOR OPTION 2 GOES HERE

	ldr	X0,	=szSubOpt	// option 2 has 2 sub options 2.a and 2.b
	bl	putstring
	
getIn2:
	ldr	X0,	=kbBuf		// arg for getstring
	mov	X2,	#2		// only accepting 2 characters for selecting the suboption
	bl	getstring		// see what suboption was selected
	
	
	LDR X0, =kbBuf		//load keyboard buffer
	LDRB W0, [X0]	// dereffernce the first byte stored in kbbuf 

	cmp	X0,	#0x61		// compare to a
	b.eq	Opt2a		//go to 2a
	cmp	X0,	#0x62		// compare to b
	b.eq	Opt2b       // go to 2b
	
	ldr	X0,	=szValidIn	// if not a or b get something else
	bl	putstring  //print string
	b	getIn2

Opt2a: 	// CODE FOR OPTION 2.a GOES HERE
	
	ldr	X0,	=szWriteToOut  //ask for suboptions
	bl	putstring 			//print out string

	// what to write to output file
	ldr	X0,	=kbBuf //load keyboard buffer
	mov	X2,	#512  //get string length
	bl	getstring  //call getstring
	mov	X19,	X0		// preserve bytes read

	cmp	X25, #3   //compare with 3
	beq	Opt2aAfterOpen //link to opt2afteropen
	
	// opens output file
	MOV X0, #AT_FDCWD	//local directory
	mov	X8,	#56
	ldr	X1,	=szOutFile
	mov	X2,	#WRITEONLY
	svc	0
	mov	X25,	X0

Opt2aAfterOpen: 

	// writes was in kbbuf to output file
	mov	X0,	X25
	mov	X8,	#64
	ldr	X1,	=kbBuf
	mov	X2,	X19
	svc	0

	b	_start	

Opt2b:	// CODE FOR OPTION 2.b GOES HERE
	// CURRENTLY JUST ADDED THE ENTIRE INPUT FILE TO THE OUTPUT FILE AND DID NOT MAKE A LINKED LIST FROM IT
	 
	cmp	X25,	#3
	beq	Opt2bAfterOpen

	// opens output file
	MOV X0, #AT_FDCWD	//local directory
	mov	X8,	#56
	ldr	X1,	=szOutFile
	mov	X2,	#WRITEONLY
	svc	0
	mov	X25,	X0


Opt2bAfterOpen:
	// writes what is on szbuf to output.txt
	mov	X0,	X25
	mov	X8,	#64
	ldr	X1,	=szInFileBuf
	mov	X2,	#40000
	svc	0	

	b	_start	


getOption:
	cmp	X0,	#0x31		// option 1	
	b.eq	Opt1
	cmp	X0,	#0x32		// option 2
	b.eq	Opt2
	cmp	X0,	#0x37	// option 7
	b.eq	exit			// if 7 just exit

	ldr	X0,	=szValidIn	// antyhing else ... return to getting input
	bl	putstring
	b	getIn1

exit:
						// setup parameters to end the program
						// and then call Linux to do it
	mov X0, #0				// use 0 as return code
	mov X8, #93				// service command code 93 terminates this program
	svc 0					// call Linux to terminate the program

.end
