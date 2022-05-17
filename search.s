//Author:	Dawson Graf & Andrew Hua
//Lab:		RASM 3
//Purpose: 	Text Editor
//Modified:	5/16/2022	

///////////////////////////////////////////////////////////////////////
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
