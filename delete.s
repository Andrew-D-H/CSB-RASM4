//Author:	Dawson Graf & Andrew Hua
//Lab:		RASM 3
//Purpose: 	Text Editor
//Modified:	5/16/2022	

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
