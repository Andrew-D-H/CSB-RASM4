//Author:	Dawson Graf & Andrew Hua
//Lab:		RASM 3
//Purpose: 	Text Editor
//Modified:	5/16/2022	

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
