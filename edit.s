//Author:	Dawson Graf & Andrew Hua
//Lab:		RASM 3
//Purpose: 	Text Editor
//Modified:	5/16/2022	

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
