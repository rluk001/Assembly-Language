;=================================================
; Name: Luk, Ryan
; Username: rluk001
; 
; Assignment name: Assignment 2
; Lab section: 022
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;=================================================
.orig x3000
;--------------
; Instructions
;--------------

LD R4, HEX_30		; Setting this register as a way of adding x30
GETC				; Getting a character of the digit
ADD R1, R0, #0 		; Setting R1 to the inputted character
OUT

LD R0, DEC_32		; Getting the ' ' sign for output
OUT

LD R0, DEC_45		; Getting the '-' sign for output
OUT

LD R0, DEC_32		; Getting the ' ' sign for output
OUT

GETC				; Getting a character of the digit
OUT
ADD R2, R0, #0 		; Setting R2 to the inputted character
NOT R2, R2			; Inverting R2
ADD R2, R2, #1		; Incrementing 1 for 2's Complement

LD R0, DEC_32		; Getting the ' ' sign for output
OUT

LD R0, DEC_61		; Getting the '=' sign for output
OUT

LD R0, DEC_32		; Getting the ' ' sign for output
OUT

IF_STATEMENT
	ADD R3, R1, R2		; Adding both numbers together
	BRzp POSITIVE		; if (R3[the result] >= 0)
NEGATIVE 				; If Statement for negative numbers
	LD R0, DEC_45		; Setting this register as a way of adding #45
	OUT 				; Outputs the negative sign
	NOT R0, R3			; Inverting R3 into R0
	ADD R0, R0, #1		; Incrementing 1 for 2's Complement
	BR END_IF 			; Breaks out of loop
POSITIVE 				; If Statement for positive numbers
	LD R0, DEC_0 		; Resetting R0 to #0
	ADD R0, R0, R3		; Adding R3(the result)
END_IF
	ADD R0, R0, R4		; Adding x30 in order to get the ASCII codes for numbers
	OUT 				; Prints out the number

HALT
	;------------
	; Local Data
	;------------
	HEX_30	.FILL x30 ; put x30 into memory here
	DEC_32	.FILL #32 ; put #32 into memory here
	DEC_45	.FILL #45 ; put #45 into memory here
	DEC_0	.FILL #0  ; put #0 into memory here
	DEC_61	.FILL #61 ; put #61 into memory here

.END