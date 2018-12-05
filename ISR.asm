; ISR.asm
; Name: Sarah Orsak
; UTEid: sgo277
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
               .ORIG x2600
; Save registers
	LD R1, SR1
	LD R3, SR3
; Read input character
	LDI R3, KBDR
	
;Check A
	LD R1, charA
	ADD R1, R1, R3
	BRz Write
	
;Check C
	LD R1, charC
	ADD R1, R1, R3
	BRz Write

;Check U 
	LD R1, charU
	ADD R1, R1, R3
	BRz Write

;Check G
	LD R1, charG
	ADD R1, R1, R3
	BRz Write

BRnzp Empty

; Write if valid to x4600
Write
	STI R3, Value


Empty
;Load registers	
	ST R1, SR1
	ST R3, SR3

	
charA	.FILL -65
charC	.FILL -67
charG	.FILL -71
charU	.FILL -85
KBSR	.FILL xFE00
KBDR	.FILL xFE02
SR1	.BLKW 1
SR3	.BLKW 1
Value	.FILL x4600

	.END