//Author:	Dawson Graf & Andrew Hua
//Lab:		RASM 3
//Purpose: 	Text Editor
//Modified:	5/16/2022	

///////////////////////////////////////////////////////////////////////	
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
///////////////////////////////////////////////////////////////////////
