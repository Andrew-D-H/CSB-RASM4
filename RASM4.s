//FILE MODES
.equ	READONLY,	00
.equ	WRITEONLY,	01
.equ	READWRITE,	02
.equ	CREATEWO,	0101

// FILE PERMS
.equ	RW_RW__,	660

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


kbBuf:		.skip	512		// keyboard buffer
szBuf:		.skip	90000
szInFileBuf:	.skip	90000

	.global	_start
	.text

_start:

	ldr	X0,	=szNL
	bl	putString
	ldr	X0,	=szNL
	bl	putString

	// Bellow prints the menu
	ldr	X0,	=szTE
	bl	putString
	ldr	X0,	=szMemCon
	bl	putString
	// print num bytes here
	ldr	X0,	=szBytes
	bl	putString
	ldr	X0,	=szNumNodes
	bl	putString
	ldr	X0,	=szNL
	bl	putString
	ldr	X0,	=szNL
	bl	putString
	ldr	X0,	=szOpt1
	bl	putString
	ldr	X0,	=szOpt2
	bl	putString
	ldr	X0,	=szOpt2a
	bl	putString
	ldr	X0,	=szOpt2b
	bl	putString
	ldr	X0,	=szOpt3
	bl	putString
	ldr	X0,	=szOpt4
	bl	putString
	ldr	X0,	=szOpt5
	bl	putString
	ldr	X0,	=szOpt6
	bl	putString
	ldr	X0,	=szOpt7
	bl	putString



	// Asking for user input
	ldr	X0,	=szGetOpt
	bl	putString


getIn1:
	ldr	X1,	=kbBuf		// arg for getString
	mov	X2,	#2		// accepting 2 characters for selecting option
	bl	getString		// see what option user selected

	// Checking what option was selected
	ldrb	W0,	[X1]		// derefference the first byte and store in X0
	bl	getOption		// jump to check what option was selected

Opt1:	// CODE FOR OPTION 1 GOES HERE

	b	_start

Opt2:	// CODE FOR OPTION 2 GOES HERE

Opt2a: 	// CODE FOR OPTION 2.a GOES HERE

	b	_start	

Opt2b:	// CODE FOR OPTION 2.b GOES HERE
	b	_start	

Opt3:	// CODE FOR OPTION 3 GOES HERE
	
	b	_start

Opt4:	// CODE FOR OPTION 4 GOES HERE

Opt4Loop:

	b	Opt4Loop

Opt4IFound:

	b	_start

Opt5: 	// CODE FOR OPTION 5 GOES HERE

checkOpt5:

	b	stringFound	

itterateLL:

	b	checkOpt5

stringFound:
	b	_start

Opt6:	// CODE FOR OPTION 6 GOES HERE

	b	_start

getOption:
	b	getIn1

exit:
						// setup parameters to end the program
						// and then call Linux to do it
	mov X0, #0				// use 0 as return code
	mov X8, #93				// service command code 93 terminates this program
	svc 0					// call Linux to terminate the program

.end
