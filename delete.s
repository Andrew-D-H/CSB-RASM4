//Delete function. Just requires X3 as a input for the index.

///////////////////////////////////////////////////////////////////////
delete:
	STR X30, [SP, #-16]!	//Store X30
	LDR	X19, =headPtr		//Load headPtr
	LDR	X19, [X19]			//Load the contents
	
	MOV X6, #0				//Innialize the index count to 0
	
	nnTop:					//Node number top
	CMP X19,#0				//Compare X19 to 0
	BEQ nnBot				//Branch if equal
	LDR	X0, [X19]			//Load the contents
	
	ADD X6, X6, #1			//Increment the node count
	
	ADD	X19,X19,#8			//Increment headPtr
	LDR X19,[X19]			//Load the contents
	B	nnTop				//Branch to nnTop
	nnBot:					//Node number Bottom
	
	CMP X3, X6				//Compare X3 to X6
	BLS skipCheck			//Branch if less than
	
	LDR X0, =szWarn			//Load X0
	BL putstring			//Branch if putstring
	LDR  X30, [SP], #16		//Load X30
	RET						//Return
	
	skipCheck:				//Skip Check
	
	LDR	X19, =headPtr		//Load headPtr
	LDR	X19, [X19]			//Load the contents
	
	
	nsTop:					//Node select
	CMP X3,#0				//Compare X3 to 0
	BEQ nsBot				//Branch To bottom
	LDR	X0, [X19]			//Load contents
	
	SUB X3, X3, #1			//Sub
	
	ADD	X19,X19,#8			//Increment
	LDR X19,[X19]			//Load contents
	B	nsTop				//Branch to top
	nsBot:					//Bottom of node select
	
	BL free					//Branch to free
	
	LDR  X30, [SP], #16		//Load X30
	RET						//Return
//////////////////////////////////////////////////////////////////////
