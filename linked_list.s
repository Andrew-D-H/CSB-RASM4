// linked_list.s
//Subroutine: constructs a linked list and inserts new nodes
// LR: Contains the return address
// Return register contents:
// All AAPCS registers aretpreserved.	
//	X0, X1, X3, X4, and  X5 are modified and not preserved


	.data
	
head:		.skip		16
tail:		.quad		0
current:	.quad		0

info:		.quad		0
newNode:	.quad		0
acume:		.byte		0

kBuff:		.skip	 	512

	.global _start
	.text
	
_start:

up:
	ldr		X1, =kBuff			// dynamic strings address
	mov		X2, #511			// load length of keyboard buffer
	bl		getstring		    // call getstring	
	mov		X0, X1				// move the keyboard buffer into X0
	ldr		X1, =info			// load string
	bl		String_copy			// X0 = new string in the heap
	
	mov		X0, #16				// load in amount of memory to be allocated
	bl		malloc				// allocate enought memory for a new node
	
	ldr		X1, =newNode		// create first node
	str		X0, [X1]			// store the address to the allocated memory into newNode
	
	ldr		X1, [X1]			// derefernce the pointer of new node address to get the freed 16 bytes
	ldr		X0, =info			//load string
	ldr		X0, [X0]			// get the derefrenced data from info into X0
	str		X0, [X1]			// store the address to the string into X1, which is newnode
	
	mov		X2, #0				// load 0 for the null pointer
	str		X2, [X1, #8]		// put the tail in back half of node by offsetting by 8 bytes
	
	// comapre to see if head is null	
	ldr		X3, =head			// grab the address for the head
	ldr		X3, [X3]			// derefrence the address to get the values
	cmp		X3, #0				// see if it its null
	bne		else				// if it is not null go to else
	
	ldr		X1, =newNode		// grab the address for new node
	ldr		X1, [X1]			// dereference
	
	ldr		X3, =head			// get address to the head
	str		X1, [X3]			// place the address to the node inside
	
	ldr		X3, =tail			// copy the same as the head
	str		X1, [X3]			// place the address to the node inside
		
	ldr		X0, =kBuff			// load address to keyboard buffer
	bl		strlength			// get the length of that string
	mov		X2, X0				// move length to x0
	ldr		X0, =kBuff			// get address again
	mov		X4, #0				// clear that string
		
	b		up					// go back to top to iterate		
	
else: 
	ldr		X1, =newNode		// grab the new node address
	ldr		X1, [X1]			// load the address
	
	ldr		X3, =tail			// grab the address stored in tail
	ldr		X3, [X3]			// dereference to get stored address
	
	str		X1, [X3, #8]		// store the address to a new node in the "next" portion or last 8 bytes
	
	ldr		X3, =tail			// grab the address stored in tail
	str		X1, [X3]			// store this node so the next time it goes through it will automatically place last 8 bytes at new tail
	
	ldr		X0, =kBuff			// load address to keyboard buffer
	bl		strLength			// get the length of that string
	mov		X2, X0				// move length to x0
	ldr		X0, =kBuff			// get address again
	mov		X4, #0				// clear the string
	
	ldr		X2, =acume			// grab accumulator address
	ldrb	W2, [X2]			// load the value from it
	cmp		X2, #3				// comparer 
	beq		get_out				// exit the linked list
	add		X2, X2, #1			// increment
	ldr		X1, =acume			//load accumlator
	strb	W2, [X1]		   //store a byte of accumlator
	b		up					//go back to beginning

	
loop_clear:
	mov		X1, #0			// move 0 into X1
	strb	W1, [X0], #1	// store 0 to reset string
	cmp		X4, X2			// comapre to exit loop
	beq		exit_clear		//exit loop
	add		X4, X4, #1		// increment X2
	b 		loop_clear		// branch back to loop clear

exit_clear:
	ret		LR				// return Link Register

// get_out:					//to be used when methods are ready
//	ldr		X0, =head
//	mov		X1, #2
//	bl		deleteLink
	
//	ldr		X0, =head
//	bl		printList
	
//	mov		X0, #0
//	mov		X8, #93
//	svc		0