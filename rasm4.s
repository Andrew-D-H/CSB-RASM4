//Author:	Dawson Graf & Andrew Hua
//Lab:		RASM 3
//Purpose: 	Text Editor
//Modified:	5/16/2022	
//FILE MODES
.equ R,00
.equ W,01
.equ RW,02
.equ T_RW, 01002
.equ C_W,0101	
.equ AT_FDCWD,-100
.equ RW_______,0600
.equ RW_RW____,0644

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
szB1:		.asciz	"["
szB2:		.asciz	"] "
szGetOpt:	.asciz	"Please select an option: "
szValidIn:	.asciz	"Please select a valid option: "
szEnterStr:	.asciz	"Enter a string to search for: "
szEnterStrI:	.asciz	"Enter the index of string: "
szStrToReplace:	.asciz	"Enter the string to replace: "
szWriteToOut:	.asciz	"Enter what you want to write to output.txt: "

// File Locations 
szOutFile:	.asciz "./output.txt"
szInFile:	.asciz	"./Input.txt"

szTemp9: .asciz "0A"


szTemp: .skip	21
szTemp1: .skip	21
szTemp2: .skip	21
tempInt: .quad 0
tempInt2: .quad 0
tempInt3: .quad 0
tempInt4: .quad 0
tempInt5: .quad 0
tempInt6: .quad 0
tempInt7: .quad 0



str8:	.asciz "\n\n\n"
str9:	.asciz "Enter Index to Delete: "
str14:	.asciz "Enter Index to Delete: "
str10:	.asciz "Enter Index to Edit: "
str15:	.asciz "Enter Index to Edit: "
str11:	.asciz "Enter String: "
str12:	.asciz "Matching Strings: \n"
szWarn:	.asciz "Node does not exist.\n\n"
szNull: .asciz "\n\n"
cLF: .byte 10 //char value of new line
ptrString:  .quad 0
data:	.quad	0
headPtr:  .quad  0
tailPtr:  .quad  0

szFile: .asciz "./input.txt"
szBuffer: .skip 21
szBufferMsg: .asciz "\n\nPress any key to continue.."

fileBuf: .skip 512
iFD: .quad 0
szEOF:   .asciz	 "Reached the End of the File\n"
szERROR: .asciz	 "FILE READ ERROR\n"





kbBuf:		.skip	512		// keyboard buffer
szBuf:		.skip	90000
szInFileBuf:	.skip	90000

	.global	_start
	.text
///////////////////////////////////////////////////////////////////////
_start:
	LDR	X19, =headPtr	//Load Head pointer
	LDR	X19, [X19]		//Load value at address
	
	MOV X6, #0			//Mov #0
	nodeNumberTop:		//nodeNumberTop
	CMP X19,#0			//Mov #0
	BEQ nodeNumberBot	//nodeNumberBot
	
	
	LDR	X0, [X19]		//Load Value
	MOV X5, X0			//Mov X0
    LDR X5, [X5]		//Load Value
    CMP X5, #0			//Compare to zero
    BEQ NodeCountSkip	//Branch to Node Count skip
	
	ADD X6, X6, #1		//Increment
	NodeCountSkip:		//Node Count skip
	
	ADD	X19,X19,#8		//Add 8 to X19
	LDR X19,[X19]		//Load value
	B	nodeNumberTop	//
	nodeNumberBot:
	
	break38:
	MOV X7, #0
	MOV X9, #16
	MUL X7, X6, X9
	STR X7, [SP, #-16]!
	STR X6, [SP, #-16]!

	ldr	X0,	=szNL  //load new line
	bl	putstring  //call putsring
	ldr	X0,	=szNL  //load new line
	bl	putstring  //call putstring

	// Below prints the menu
	ldr	X0,	=szTE   //load szTE
	bl	putstring   //call putstring
	ldr	X0,	=szMemCon  //load szMemCon
	bl	putstring   //load szTE
	LDR  X6, [SP], #16
	LDR  X7, [SP], #16
	LDR X1, =tempInt
	MOV X0, X7
	STR X6, [SP, #-16]!
	bl int64asc
	
	LDR X0, =tempInt
	bl	putstring
	
	
	// print num bytes here
	ldr	X0,	=szBytes //load szBytes
	bl	putstring //call putstring
	ldr	X0,	=szNumNodes //loadNumNodes
	bl	putstring //call putstring
	
	break27:
	LDR  X6, [SP], #16
	LDR X1, =tempInt
	MOV X0, X6
	bl int64asc
	
	LDR X0, =tempInt
	bl	putstring
	
	
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

	BL traverse
	
	ldr	X0,	=szBufferMsg  //load new line
	bl	putstring  //call putstring
	
	ldr	X0,	=szBuffer	// load kbBuf
	mov	X2,	#2		// get string length
	bl getstring
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
	
	bl addNode

	b	_start	

Opt2b:	// CODE FOR OPTION 2.b GOES HERE

	MOV X0, #AT_FDCWD	//Open AT
	MOV X8, #56			//Move 56 into X8
	LDR X1, =szFile		//Load File name
	
	MOV X2, #R	//Open CREATEWO
	MOV X3, #RW_______	//Mode
	SVC 0				//Service call
	
	LDR X4, =iFD
	STR X0,[X4]
	
topLoop:
	LDR X1, =fileBuf
	
	break18:
	
	BL getLine
	CMP X0, #0
	BEQ last
	
	break17:
	
	LDR X0, =fileBuf		//load szStr
	BL stringLength		//Branch
	MOV X0, X2			//Move 15 into X0
	STR X2, [SP, #-16]!
	BL malloc			//Branch and link to Malloc
	
	LDR X1, =data;		//Load data into X1
	STR X0, [X1]		// Load the address
	
	LDR  X2, [SP], #16
	LDR X3,=fileBuf		//Load the first string into X3
	LDR X1,[X1]			//Save the address of X1
	
	BL str_Copy			//Branch
	BL createNode		//Branch
	BL insert			//Branch
	
	LDR X4, =iFD
	LDR X0,[X4]

B topLoop
	
	last:
	MOV X8, #58			//Move 57 into X8
	SVC 0				//Service call
	

	b	_start	
	
	
	
////////////////////////////////////////////////////////////////////
Opt3:
	break33:
	LDR X0, =str9		//load szStr
	BL putstring
	
	break24:
	
	LDR X0,=szTemp		//Specify where to store
	MOV X1,#21			//Specify string length
	BL getstring		//Call getstring
	
	break8:
	LDR X0,=szTemp
	
	BL ascint64
	MOV X3, X0

	
	BL delete
	
ldr	X0,	=szBufferMsg  //load new line
bl	putstring  //call putstring
	
ldr	X0,	=szBuffer	// load kbBuf
mov	X2,	#2		// get string length
bl getstring
b	_start	
////////////////////////////////////////////////////////////////////
	
	
////////////////////////////////////////////////////////////////////
Opt4:
	break32:

	LDR X0, =str10		//load szStr
	BL putstring
	
	
	LDR X0,=szTemp		//Specify where to store
	MOV X1,#21			//Specify string length
	BL getstring		//Call getstring
	
	LDR X0,=szTemp
	
	BL ascint64
	MOV X6, X0
	
	
	BL edit
	
b	_start	
////////////////////////////////////////////////////////////////////
	
	
//////////////////////////////////////////////////////////////////////
Opt5:
	
bl search

ldr	X0,	=szBufferMsg  //load new line
bl	putstring  //call putstring
	
ldr	X0,	=szBuffer	// load kbBuf
mov	X2,	#2		// get string length
bl getstring
b	_start	


//////////////////////////////////////////////////////////////////////
Opt6:
	B _start
	MOV X0, #AT_FDCWD	//Open AT
	MOV X8, #56			//Move 56 into X8
	LDR X1, =szOutFile	//Load File name
	MOV X2, #C_W	//Open CREATEWO
	MOV X3, #RW_RW____	//Mode
	SVC 0				//Service call
	
	LDR	X19, =headPtr
	LDR	X19, [X19]
	break28:
writeTop:
	CMP X19,#0
	BEQ writeBot
	LDR	X6, [X19]
	
	MOV X8, #64			//Write
	MOV X1, X6			//Load the message
	break29:
	MOV X2, #32			//Move 15 into X2
	SVC 0				//Service Call
	
	
	ADD	X19,X19,#8
	LDR X19,[X19]
	B	writeTop
	
writeBot:
	
	
	
	
	MOV X8, #58			//Move 57 into X8
	SVC 0				//Service call
	
	
b	_start	
	


getOption:
	cmp	X0,	#0x31		// option 1	
	b.eq	Opt1
	cmp	X0,	#0x32		// option 2
	b.eq	Opt2
	cmp	X0,	#0x33		// option 3
	b.eq	Opt3
	cmp	X0,	#0x34		// option 4
	b.eq	Opt4
	cmp	X0,	#0x35		// option 5
	b.eq	Opt5
	cmp	X0,	#0x36		// option 6
	b.eq	Opt6
	cmp	X0,	#0x37	// option 7
	b.eq	exit			// if 7 just exit

	ldr	X0,	=szValidIn	// antyhing else ... return to getting input
	bl	putstring
	b	getIn1

exit:
	//LDR	X19, =headPtr
	//LDR	X19, [X19]
	
	//nodeClearTop:
	//CMP X19,#0
	//BEQ nodeClearBot
	//LDR	X0, [X19]
	
	//Bl free
	
	
	//ADD	X19,X19,#8
	//LDR X19,[X19]
	//B	nodeClearTop
	//nodeClearBot:

						// setup parameters to end the program
						// and then call Linux to do it
	mov X0, #0				// use 0 as return code
	mov X8, #93				// service command code 93 terminates this program
	svc 0					// call Linux to terminate the program
	
	
	
	
	
	
	
	
	
	
	
	
	
str_Copy:
	break11:
	top1:				//Top of the first function
	CMP X2, #0			//Compare X2 to 0
	BEQ bot1			//if X2 = 0 branch
	LDRB W4, [X3],#1	//Load the first byte
	STRB W4, [X1],#1	//Store the first byte
	SUB X2, X2, #1		//Decrement X2
	b top1				//Branch to top
	
	bot1:			//Bottom of first function
	
	RET
	
	
	
	
getLine:
	str X30, [SP, #-16]!	//Push
	
	top:
	BL getchar
	LDRB W2, [X1]
	CMP W2, #0xa
	
	BEQ EOLINE
	
	CMP X0,#0x0
	BEQ EOF
	
	CMP X0,#0x0
	BLT ERROR
	
	ADD X1, X1, #1
	LDR X0,=iFD
	LDR X0,[X0]
	b top
	
EOLINE:
	ADD X1,X1,#1
	MOV W2,#0
	STRB W2,[X1]
	B  skip
	
EOF:
	MOV X19, X0
	LDR X0, =szEOF
	BL putstring
	MOV X0, X19
	B skip
	
	
	
ERROR:
	MOV X19, X0
	
	skip:
	LDR X30, [SP], #16	//Pop
	ret
	
	
	
	
getchar:
	mov X2, #1		//Load buffer size
	MOV X8,#63			//Load 63 into X8
	SVC 0				//Service Call
	RET				//Return
	
	
	
insert:
	break2:
	LDR X1,=headPtr
	LDR X2,=tailPtr
	LDR X3,[X1]
	CMP X3, #0
	BNE nonEmpty
	STR X0, [X1]
	STR X0, [X2]
	B skip1
	
	

	
	nonEmpty:
	LDR X4, [X2]
	ADD X4,X4,#8
	STR X0, [X4]
	STR X0, [X2]
	
	
skip1:
	RET
	
	
	createNode:
	str X30, [SP, #-16]!
	
	MOV X0,#16
	BL malloc
	
	LDR X30, [SP], #16
	
	LDR X1, =data
	LDR X1, [X1]
	STR X1, [X0]
	
	MOV X1, #0
	STR X1, [X0,#8]
	RET
	
	
	
traverse:
	break1:
	STR X19, [SP, #-16]!
	STR X30, [SP, #-16]!
	
	MOV X23, #1
	
	LDR	X19, =headPtr
	LDR	X19, [X19]
	MOV X6, #1
	
travTop:
	CMP X19,#0
	BEQ travBot
	
	
	CMP X6, #1
	BNE notEqualSkip
	LDR X0, =szB1
	BL putstring
	LDR X1, =tempInt
	MOV X0, X23
	BL int64asc
	LDR X0, =tempInt
	BL putstring
	LDR X0, =szB2
	BL putstring
	notEqualSkip:
	
	break37:
	MOV X6, #0
	LDR	X0, [X19]
	MOV X5, X0
	LDR X5, [X5]
	CMP X5, #0
	BEQ traverseSkip
	MOV X6, #1
	BL putstring
	
	ADD X23, X23, #1
	traverseSkipBack:
	ADD	X19,X19,#8
	LDR X19,[X19]
	B	travTop
	
travBot:
	LDR  X30, [SP], #16
	LDR  X19, [SP], #16
	RET
	
traverseSkip:
break36:
b traverseSkipBack
	
	
search:
	STR X30, [SP, #-16]!
	
	LDR X0, =cLF
	BL putch
	
	LDR X0, =cLF
	BL putch
	
	LDR X0, =str11
	BL putstring

	LDR X0,=szTemp		//Specify where to store
	MOV X1,#21			//Specify string length
	BL getstring		//Call getstring
	
	LDR X0, =szNull
	BL putstring
	
	LDR X0, =str12
	BL putstring
	
	break13:
	
	LDR X0,=szTemp
	BL Str_toUpperCase		//Call toUpper
	
	LDR	X19, =headPtr
	LDR	X19, [X19]
	
	
	MOV X23, #0
	searchTop:
	CMP X19,#0
	BEQ searchBot
	LDR	X0, [X19]
	MOV X3, X0
	MOV X15, X0
	BL  stringLength
	MOV X16, X2
	MOV X5, #0
	
	LDR X1, =szTemp2
	STR X5, [X1]
	STR X5, [X1, #8]
	
	LDR X1, =szTemp2
	BL str_Copy
	
	LDR X0, =szTemp2		//Load ptrString into X0
	bl Str_toUpperCase		//Call toUpper
	
	break14:
	
	LDR X1, =szTemp
	LDR X3, =szTemp2
	ADD X23, X23, #1
	BL compare
	
	
	ADD	X19,X19,#8
	LDR X19,[X19]
	B	searchTop
	searchBot:


	LDR  X30, [SP], #16
	RET
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
	compare:
	STR X30, [SP, #-16]!
	STR X3, [SP, #-16]!
	STR X1, [SP, #-16]!
	STR X23, [SP, #-16]!
	
	LDR X0,=szTemp
	BL stringLength
	

	LDR  X23, [SP], #16
	LDR  X1, [SP], #16
	LDR  X3, [SP], #16
	
	break15:
	
	MOV X11, #0
	MOV X10, #0
	
	compareTop:				//Top of the first function
	CMP X2, #0			//Compare X2 to 0
	BEQ comparebot1			//if X2 = 0 branch
	LDRB W4, [X3, X11]	//Load the first byte
	LDRB W5, [X1, X10]	//Store the first byte
	
	CMP X4, X5
	BNE compareFail
	
	ADD X10, X10, #1
	ADD X11, X11, #1
	SUB X2, X2, #1		//Decrement X2
	MOV X6, #1
	
	b compareTop				//Branch to top
	
	comparebot1:
	LDR X0, =szB1
	BL putstring
	LDR X1, =tempInt
	MOV X0, X23
	break31:
	BL int64asc
	LDR X0, =tempInt
	BL putstring
	LDR X0, =szB2
	BL putstring
	
	MOV X0, X15
	BL putstring
	
	B compareEnd
	
	compareFail:
	CMP X6, #1
	BEQ compareEnd
	
	CMP X11, X16
	BEQ compareEnd
	ADD X11, X11, #1
	
	B compareTop
	
	compareEnd:
	LDR  X30, [SP], #16
	RET
//////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
delete:
	break3:
	STR X30, [SP, #-16]!
	LDR	X19, =headPtr
	LDR	X19, [X19]
	
	MOV X6, #0
	
	nnTop:
	CMP X19,#0
	BEQ nnBot
	LDR	X0, [X19]
	
	ADD X6, X6, #1
	
	
	ADD	X19,X19,#8
	LDR X19,[X19]
	B	nnTop
	nnBot:
	
	break6:
	
	
	CMP X3, X6
	BLS skipCheck
	
	LDR X0, =szWarn
	BL putstring
	LDR  X30, [SP], #16
	RET
	
	skipCheck:
	
	//SUB X6, X6, X3
	
	LDR	X19, =headPtr
	LDR	X19, [X19]
	
	
	nsTop:
	CMP X3,#0
	BEQ nsBot
	LDR	X0, [X19]
	
	SUB X3, X3, #1
	
	
	ADD	X19,X19,#8
	LDR X19,[X19]
	B	nsTop
	nsBot:
	
	
	BL free
	
	break4:
	
	LDR  X30, [SP], #16
	RET
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
edit:
	

	STR X30, [SP, #-16]!
	LDR X0, =str11
	BL putstring
	
	
	
	LDR X0,=szTemp		//Specify where to store
	MOV X1,#1024			//Specify string length
	BL getstring		//Call getstring
	
	break34:
	
	LDR X0, =szTemp
	BL stringLength
	LDR X3, =szTemp
	
	SUB X2, X2, #1
	
	topEnterLoop:				//Top of the first function
	LDRB W4, [X3],#1
	CMP X2, #0			//Compare X2 to 0
	BEQ botEnterLoop			//if X2 = 0 branch
	SUB X2, X2, #1		//Decrement X2
	b topEnterLoop				//Branch to top
	
	botEnterLoop:			//Bottom of first function
	break35:
	
	MOV W4, 0xA
	STRB W4, [X3]
	LDR X0, =szTemp
	

	LDR X0, =szNull
	BL putstring
	
	//LDR X0,=szTemp1		//Specify where to store
	//MOV X1,#21			//Specify string length
	//BL getstring		//Call getstring
	
	//LDR X0,=szTemp1
	
	//BL ascint64
	MOV X3, X6
	
	
	break21:
	
	LDR	X19, =headPtr
	LDR	X19, [X19]
	
	
	neTop:
	CMP X3,#0
	BEQ neBot
	LDR	X1, [X19]
	
	SUB X3, X3, #1
	
	
	ADD	X19,X19,#8
	LDR X19,[X19]
	B	neTop
	neBot:
	
	break12:
	
	
	
	LDR X3, =szTemp
	MOV X6, #0
	STR X6, [X1]
	STR X6, [X1, #8]
	STR X6, [X1, #16]
	STR X6, [X1, #24]
	STR X3, [SP, #-16]!
	STR X1, [SP, #-16]!
	
	MOV X0, X3
	BL stringLength
	
	
	LDR  X1, [SP], #16
	LDR  X3, [SP], #16
	BL str_Copy
	
	LDR  X30, [SP], #16
	RET
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
addNode:
	STR X30, [SP, #-16]!
	LDR X0, =str11
	BL putstring
	
	LDR X0,=szTemp		//Specify where to store
	MOV X1,#32			//Specify string length
	BL getstring		//Call getstring
	
	LDR X0, =szTemp
	BL stringLength
	LDR X3, =szTemp
	
	SUB X2, X2, #1
	
	topaddNodeLoop:				//Top of the first function
	LDRB W4, [X3],#1
	CMP X2, #0			//Compare X2 to 0
	BEQ botaddNodeLoop			//if X2 = 0 branch
	SUB X2, X2, #1		//Decrement X2
	b topaddNodeLoop				//Branch to top
	
	botaddNodeLoop:			//Bottom of first function
	
	
	MOV W4, 0xA
	STRB W4, [X3]

	LDR X0, =szNull
	BL putstring

	LDR X0, =szTemp		//load szStr
	BL stringLength		//Branch
	MOV X0, X2			//Move 15 into X0
	BL malloc			//Branch and link to Malloc
	
	str X0, [SP, #-16]!
	
	
	LDR X1, =data;		//Load data into X1
	STR X0, [X1]		// Load the address
	
	
	
	LDR X0, =szTemp		//load szStr
	BL stringLength		//Branch
	
	LDR  X0, [SP], #16
	
	LDR X1, =data
	LDR X3,=szTemp		//Load the first string into X3
	LDR X1,[X1]			//Save the address of X1
	
	BL str_Copy			//Branch
	BL createNode		//Branch
	BL insert			//Branch
	
	LDR  X30, [SP], #16
	RET
//////////////////////////////////////////////////////////////////////
	

.end
