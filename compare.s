//Author:	Dawson Graf & Andrew Hua
//Lab:		RASM 3
//Purpose: 	Text Editor
//Modified:	5/16/2022	

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
