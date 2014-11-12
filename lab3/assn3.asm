;=================================================
; Name: Luk, Ryan
; Username: rluk001
; 
; Assignment name: Assignment 3
; Lab section: 022
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;=================================================
.orig x3000
LD R1, ABCD
LD R2, SEC_COUNT
LD R5, COUNT
LD R3, MASK

loop
	AND R6, R1, R3		; Checks if the MSB is positive or negative from MASK
	BRn ELSE_IF			; Goes to ELSE_IF if MSB is negative
IF_STATEMENT
	LD R0, ZERO 		; Prints out '0'
	OUT 				; Output
	BR NEXT 			; Goes to the NEXT branch
ELSE_IF
	LD R0, ONE 			; Prints out '1'
	OUT  				; Output
NEXT	
	ADD R1, R1, R1 		; Left shifting
	ADD R2, R2, #1 		; Adds a secondary count for spaces		
	ADD R4, R2, #0 		; Saves R2's data into R4
	SECOND_IF
		BRp POS_IF 		; Branch if LMR is positive
		BRn NEG_IF 		; Branch if LMR is negative
		BRz ZERO_IF 	; Branch if LMR is zero
	POS_IF
		ADD R2, R2, -4 	; Subtracts 4 from the number
		BR SECOND_IF 	; Sends it back to the loop to check if NZP
	NEG_IF
		ADD R2, R4, #0 	; Returns R2's data with its original data
		BR SECOND_IF_END 	; Ends the loop
	ZERO_IF
		LD R0, SPACE 	; Prints out a space if 4 bits have been printed out
		OUT 			; Output
		ADD R2, R4, #0 	; Return R2's data with its original data
	SECOND_IF_END
	ADD R5, R5, -1 		; Decrements count
	BRp loop			; Repeat through loop, until it stops at 0
loop_END 				; End of loop

HALT

ABCD .FILL xABCD
MASK .FILL x8000
DEC_169 .FILL #169
COUNT .FILL #16
ZERO .FILL x30
ONE .FILL x31
SPACE .FILL x20
SEC_COUNT .FILL #0

.END