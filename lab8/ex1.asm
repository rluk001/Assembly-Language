;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 08
; Lab section: 022
; TA: Bryan Marsh
;=================================================

.orig x3000

LD R6, getString
JSRR R6

PUTS

LD R0, newLineChar
OUT

HALT
getString .FILL x3200
newLineChar .FILL x0A
ARRAY .FILL x3300
.orig x3200

ST R7, R7_BACKUP_3200

LEA R0, PROMPT
PUTS

LD R1, newLine
NOT R1, R1
ADD R1, R1, #1
LD R6, userArray
LD R5, COUNT

RESTART
	GETC
	OUT
	ADD R2, R1, R0
	BRz LOOP_END
	LD R3, asciia
	ADD R2, R0, R3
	BRn SKIP
	LD R4, asciiz
	ADD R2, R0, R4
	BRp SKIP
	LD R3, conversion
	ADD R0, R0, R3
	SKIP
	ADD R5, R5, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	BR RESTART
LOOP_END

LD R0, userArray
LD R7, R7_BACKUP_3200

RET

userArray .FILL x3300
R7_BACKUP_3200 .BLKW #1
newLine .FILL x0A
COUNT .FILL #0
asciia .FILL #-97
asciiz .FILL #-122
conversion .FILL #-32
PROMPT .STRINGZ "Please enter a string followed by an ENTER: "
.END
