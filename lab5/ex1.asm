;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 05
; Lab section: 022
; TA: Bryan Marsh
;=================================================
.orig x3000

LD R6, NUM
LD R1, ARRAY_1
LD R3, NINE

FOR
	STR R6, R1, #0
	LD R4, SUB_PRINT_BINARY
	JSRR R4
	ADD R1, R1, #1
	ADD R6, R6, R6	
	ADD R3, R3, #-1
	BRzp FOR
FOR_END

HALT

SUB_PRINT_BINARY	.FILL x3200
NINE .FILL #9
NUM .FILL #1
ARRAY_1 .FILL x4000
.BLKW #10



.orig x3200
ST R1, BACKUP_R1_3200
ST R3, BACKUP_R3_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

LD R6, NNE

LDR R2, R1, #0
LD R3, SEC_COUNT
LD R5, COUNT
LD R0, CHAR_B
OUT
loop
	ADD R2, R2, #0
	BRn ELSE_IF			; Goes to ELSE_IF if MSB is negative
IF_STATEMENT
	LD R0, ZERO 		; Prints out '0'
	OUT 				; Output
	BR NEXT 			; Goes to the NEXT branch
ELSE_IF
	LD R0, ONE 			; Prints out '1'
	OUT  				; Output
NEXT	
	ADD R2, R2, R2 		; Left shifting
	ADD R3, R3, #1 		; Adds a secondary count for spaces		
	ADD R4, R3, #0 		; Saves R3's data into R4
	SECOND_IF
		BRp POS_IF 		; Branch if LMR is positive
		BRn NEG_IF 		; Branch if LMR is negative
		BRz ZERO_IF 	; Branch if LMR is zero
	POS_IF
		ADD R3, R3, #-4 	; Subtracts 4 from the number
		BR SECOND_IF 	; Sends it back to the loop to check if NZP
	NEG_IF
		ADD R3, R4, #0 	; Returns R3's data with its original data
		BR SECOND_IF_END 	; Ends the loop
	ZERO_IF
		LD R0, SPACE 	; Prints out a space if 4 bits have been printed out
		OUT 			; Output
		ADD R3, R4, #0 	; Return R3's data with its original data
	SECOND_IF_END
	ADD R5, R5, #-1 	; Decrements count
	BRp loop			; Repeat through loop, until it stops at 0
loop_END 				; End of loop
LD R0, NLINE
OUT
ADD R1, R1, #1
ADD R6, R6, #-1

LD R1, BACKUP_R1_3200
LD R3, BACKUP_R3_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET

ONE .FILL x31
COUNT .FILL #16
SPACE .FILL x20
SEC_COUNT .FILL #0
ZERO .FILL x30
NLINE .FILL x0A
CHAR_B .FILL #98
ARRAY1 .FILL x4000
NNE .FILL #9
BACKUP_R1_3200	.BLKW #1
BACKUP_R3_3200	.BLKW #1
BACKUP_R6_3200 	.BLKW #1
BACKUP_R7_3200 	.BLKW #1

.END
