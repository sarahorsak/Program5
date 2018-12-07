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
	LD R3, charA
	AND R2, R2, #0
	AND R1, R1, #0
	STI R1, Buffer
	
CheckStart
	JSR GetChar
CheckA
	LD R2, charA
	ADD R2, R2, R0
	BRz CheckU
	BRnzp CheckStart
	

CheckU 
	JSR GetChar
	LD R2, charU
	ADD R2, R2, R0; if zero, means char is U
	BRz CheckG
	BRnp CheckA
	
CheckG
	JSR GetChar
	LD R2, charG
	ADD R2, R2, R0
	BRz PrintPipe
	BRnp CheckA
	

PrintPipe
	LD R0, Pipe
	TRAP x21
	BRnzp CheckStop


CheckStop
	JSR GetChar
BR CheckStop

GCR7		.BLKW 1
BOS		.FILL x4000
Buffer		.FILL x4600
Pipe		.FILL 124
charA		.FILL -65
charC		.FILL -67
charG		.FILL -71
charU		.FILL -85
Routine		.FILL x2600
Interrupt	.FILL x0180
KBSR 		.FILL xFE00
KBDR		.FILL xFE02
Mask		.FILL x4000

		.END
