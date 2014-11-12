;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 06
; Lab section: 022
; TA: Bryan Marsh
;=================================================

.orig x3000
LEA R0, PROMPT
PUTS

GETC
OUT

ADD R1, R0, #0

LD R0, newLine
OUT

LD R6, SUB_INPUT
JSRR R6

LEA R0, NUM1
PUTS

LD R2, ZEROPLUS
ADD R0, R4, #0
ADD R0, R0, R2
OUT

LD R0, newLine
OUT

HALT
SUB_INPUT .FILL x3200
ZEROPLUS .FILL #48
PROMPT .STRINGZ "Please enter a single character: "
newLine .FILL x0A
NUM1 .STRINGZ "The number of 1's is: "
.END

.orig x3200

ST R7, BACKUP_R7_3200

LD R5, COUNT
LD R4, NUM
LD R3, MASK

loop
	AND R6, R1, R3		; Checks if the MSB is positive or negative from MASK
	BRn ELSE_IF			; Goes to ELSE_IF if MSB is negative
IF_STATEMENT
	BR NEXT 			; Goes to the NEXT branch
ELSE_IF
	ADD R4, R4, #1
NEXT	
	ADD R1, R1, R1 		; Left shifting
	ADD R5, R5, -1 		; Decrements count
	BRp loop			; Repeat through loop, until it stops at 0
loop_END 				; End of loop

LD R7, BACKUP_R7_3200
RET

MASK .FILL x8000
COUNT .FILL #16
BACKUP_R7_3200 .BLKW #1
NUM .FILL #0

.END
