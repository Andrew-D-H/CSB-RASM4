//Author:	Dawson Graf
//Lab:		17
//Purpose: 	Linked List
//Modified:	5/2/2022


.data
szTemp: .skip	21
szTemp1: .skip	21
szTemp2: .skip	21
str1:  .asciz "The Cat in the Hat"
str2:  .asciz "\n"
str3:  .asciz  "By Dr. Seuss"
str4:  .asciz  "\n"
str5:  .asciz "The sun did not shine."
str6:  .asciz "\nTest node 1.\n"
str7:  .asciz "\nTest node 2.\n"
str8:	.asciz "\n\n\n"
str9:	.asciz "Enter Index to Delete: "
str10:	.asciz "Enter Index to Edit: "
str11:	.asciz "Enter String: "
str12:	.asciz "Matching Strings: \n"
szWarn:	.asciz "Node does not exist.\n\n"
szNull: .asciz "\n\n"
cLF: .byte 10 //char value of new line
ptrString:  .quad 0
data:	.quad	0
headPtr:  .quad  0
tailPtr:  .quad  0


	.global _start		//Declare start
	
	.text
_start:					//Program Start

	LDR X0, =str1		//load szStr
	BL stringLength		//Branch
	MOV X0, X2			//Move 15 into X0
	BL malloc			//Branch and link to Malloc
	
	LDR X1, =data;		//Load data into X1
	STR X0, [X1]		// Load the address
	
	MOV X2, #20			//Move 4 into X2
	LDR X3,=str1		//Load the first string into X3
	LDR X1,[X1]			//Save the address of X1
	
	BL str_Copy			//Branch
	BL createNode		//Branch
	BL insert			//Branch
	
	
	
	
	LDR X0, =str2		//load szStr
	BL stringLength		//Branch
	MOV X0, X2			//Move 15 into X0
	BL malloc			//Branch and link to Malloc
	
	LDR X1, =data;		//Load data into X1
	STR X0, [X1]		// Load the address
	
	MOV X2, #20			//Move 4 into X2
	LDR X3,=str2		//Load the first string into X3
	LDR X1,[X1]			//Save the address of X1
	
	BL str_Copy			//Branch
	BL createNode		//Branch
	BL insert			//Branch
	
	
	

    LDR X0, =str3		//load szStr
	BL stringLength		//Branch
	MOV X0, X2			//Move 15 into X0
	BL malloc			//Branch and link to Malloc
	
	LDR X1, =data;		//Load data into X1
	STR X0, [X1]		// Load the address
	
	MOV X2, #20			//Move 4 into X2
	LDR X3,=str3		//Load the first string into X3
	LDR X1,[X1]			//Save the address of X1
	
	BL str_Copy			//Branch
	BL createNode		//Branch
	BL insert			//Branch			
	
	
	

    LDR X0, =str4		//load szStr
	BL stringLength		//Branch
	MOV X0, X2			//Move 15 into X0
	BL malloc			//Branch and link to Malloc
	
	LDR X1, =data;		//Load data into X1
	STR X0, [X1]		// Load the address
	
	MOV X2, #20			//Move 4 into X2
	LDR X3,=str4		//Load the first string into X3
	LDR X1,[X1]			//Save the address of X1
	
	BL str_Copy			//Branch
	BL createNode		//Branch
	BL insert			//Branch
    
    
    
    
    LDR X0, =str5		//load szStr
	BL stringLength		//Branch
	MOV X0, X2			//Move 15 into X0
	BL malloc			//Branch and link to Malloc
	
	LDR X1, =data;		//Load data into X1
	STR X0, [X1]		// Load the address
	
	MOV X2, #24			//Move 4 into X2
	LDR X3,=str5		//Load the first string into X3
	LDR X1,[X1]			//Save the address of X1
	
	BL str_Copy			//Branch
	BL createNode		//Branch
	BL insert			//Branch
	
	
	
	
	bl traverse			//traverse
	
	LDR X0, =str8
	BL putstring
	
	
	
	
	
	LDR X0, =str8
	BL putstring
	
	////////////////////////////////////////////////////////////////////
	LDR X0, =str10		//load szStr
	BL putstring
	
	
	LDR X0,=szTemp		//Specify where to store
	MOV X1,#21			//Specify string length
	BL getstring		//Call getstring
	
	LDR X0,=szTemp
	
	BL ascint64
	MOV X6, X0
	////////////////////////////////////////////////////////////////////
	
	BL edit
	
	bl traverse			//traverse
	
	LDR X0, =szNull
	BL putstring
	
	////////////////////////////////////////////////////////////////////
	LDR X0, =str9		//load szStr
	BL putstring
	
	
	LDR X0,=szTemp		//Specify where to store
	MOV X1,#21			//Specify string length
	BL getstring		//Call getstring
	
	break8:
	LDR X0,=szTemp
	
	BL ascint64
	MOV X3, X0
	////////////////////////////////////////////////////////////////////
	
	BL delete
	
	bl traverse			//traverse
	
	Bl search
	
	
exit:
	LDR X0, =szNull
	BL putstring

	//MOV X0, #0
	MOV X8, #93
	svc 0			//Exit Sequence
	
	
	
	
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
	MOV X1,#50			//Specify string length
	BL getstring		//Call getstring

	LDR X0, =szNull
	BL putstring
	
	//LDR X0,=szTemp1		//Specify where to store
	//MOV X1,#21			//Specify string length
	//BL getstring		//Call getstring
	
	//LDR X0,=szTemp1
	
	//BL ascint64
	MOV X3, X6
	
	
//Reenter code here
	
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
	
	//re enter code here
	
	LDR X3, =szTemp
	MOV X6, #0
	STR X6, [X1]
	STR X6, [X1, #8]
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
	MOV X1,#21			//Specify string length
	BL getstring		//Call getstring

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

//////////////////////////////////////////////////////////////////////
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
	
	LDR X0,=szTemp
	BL stringLength
	
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
	
	comparebot1:			//Bottom of first function
	
	MOV X0, X15
	BL putstring
	
	LDR X0, =cLF
	BL putch
	
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





	
traverse:
	break1:
	STR X19, [SP, #-16]!
	STR X30, [SP, #-16]!
	
	
	LDR	X19, =headPtr
	LDR	X19, [X19]
	
travTop:
	CMP X19,#0
	BEQ travBot
	LDR	X0, [X19]
	
	BL putstring
	
	break5:
	
	ADD	X19,X19,#8
	LDR X19,[X19]
	B	travTop
	
travBot:
	LDR  X30, [SP], #16
	LDR  X19, [SP], #16
	RET
	
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
	
	
	
	.end

