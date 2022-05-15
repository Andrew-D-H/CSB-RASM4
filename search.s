//Search function. I am tired Ill add comments later.


//////////////////////////////////////////////////////////////////////
search:
	STR X30, [SP, #-16]!
	
	LDR X0, =cLF
	BL putch
	
	LDR X0, =cLF
	BL putch
	
	LDR X0, =str11
	BL putstring

	LDR X0,=szTemp		
	MOV X1,#21			
	BL getstring		
	
	LDR X0, =szNull
	BL putstring
	
	LDR X0, =str12
	BL putstring
	
	break13:
	
	LDR X0,=szTemp
	BL Str_toUpperCase		
	
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
	
	LDR X0, =szTemp2		
	bl Str_toUpperCase		
	
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
	
	compareTop:				
	CMP X2, #0			
	BEQ comparebot1			
	LDRB W4, [X3, X11]	
	LDRB W5, [X1, X10]	
	
	CMP X4, X5
	BNE compareFail
	
	ADD X10, X10, #1
	ADD X11, X11, #1
	SUB X2, X2, #1		
	MOV X6, #1
	
	b compareTop				
	
	comparebot1:			
	
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
