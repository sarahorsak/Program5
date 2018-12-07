; Main.asm
; Name: Sarah Orsak
; UTEid: sgo277
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
               .ORIG x4000
; initialize the stack pointer
	LD R6, BOS
	
; set up the keyboard interrupt vector table entry
	LD R1, Routine	
	STI R1, Interrupt

; enable keyboard interrupts
	LD R2, Mask
	STI R2, KBSR

; start of actual program

Loop   BRnzp Loop

	; if AUG then start and print pipe

	CheckA
	LD R1, charA
	ADD R1, R1, R6
	BRz CheckU
	BRnp CheckA
	;Test Pull
	
	CheckU 
	LD R1, charU
	ADD R1, R1, R6
	BRz CheckG
	BRnp CheckA

	CheckG
	LD R1, charG
	ADD R1, R1, R6
	BRz Start
	BRnp CheckA
	

	Start
	LD R0, Pipe
	TRAP x21

	

	; if UAG, UAA, or UGA stop


	CheckU2 
	LD R1, charU
	ADD R1, R1, R6
	BRz CheckAorG
	BRnp CheckU2

	CheckAorG
	LD R1, charA
	ADD R1, R1, R6
	BRz CheckAorG2
	
	LD R1, charG
	ADD R1, R1, R6
	BRz CheckAorG2
	BRnp CheckU2

	CheckAorG2
	LD R1, charA
	ADD R1, R1, R6
	BRz Terminate
	
	LD R1, charG
	ADD R1, R1, R6
	BRz Terminate
	BRnp CheckU2

Terminate
	TRAP x25
	

Pipe		.FILL 124
charA		.FILL -65
charC		.FILL -67
charG		.FILL -71
charU		.FILL -85
BOS		.FILL x4000
Routine		.FILL x2600
Interrupt	.FILL x0180
Value		.FILL x4600
KBSR 		.FILL xFE00
KBDR		.FILL xFE02
Mask		.FILL x4000

		.END
