//Edit function, requires X6 as the desired register and X0 as the
//replacement string

//////////////////////////////////////////////////////////////////////
edit:
	STR X30, [SP, #-16]!
	LDR X0, =str11			//Load str11
	BL putstring		//Branch to putstring
	
	LDR X0,=szTemp		//Specify where to store
	MOV X1,#50			//Specify string length
	BL getstring		//Call getstring

	LDR X0, =szNull		//Load X0
	BL putstring		//Branch
	
	MOV X3, X6			//mov X6 to X3
	
	LDR	X19, =headPtr	//Load the address of headPtr
	LDR	X19, [X19]		//Load the contents
	
	
	neTop:				//Node Edit Top
	CMP X3,#0			//Compare X3 0
	BEQ neBot			//Branch if equal
	LDR	X1, [X19]		//Load The address of X19
	
	SUB X3, X3, #1		//Decrement
	
	
	ADD	X19,X19,#8		//Increment
	LDR X19,[X19]		//Load contents
	B	neTop			//Branch to top
	neBot:				//Node edit bottom
	
	LDR X3, =szTemp		//Load szTemp 
	MOV X6, #0			//Load #0
	STR X6, [X1]		//Store that into X6
	STR X3, [SP, #-16]!	//Store X3
	STR X1, [SP, #-16]! //Store X1
	
	MOV X0, X3			//Mov X0
	BL stringLength		//Branch to string length
	
	
	LDR  X1, [SP], #16	//Load X1
	LDR  X3, [SP], #16	//Load X3
	BL str_Copy			//BL str_Copy
	
	LDR  X30, [SP], #16	//Load X30
	RET					//Return
//////////////////////////////////////////////////////////////////////
