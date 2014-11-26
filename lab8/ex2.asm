;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 08
; Lab section: 022
; TA: Bryan Marsh
;=================================================
.orig x3000

LD R6, SUB_PRINT_OPCODES
JSRR R6

HALT

SUB_PRINT_OPCODES .FILL x3400

.orig x3100
OPCODE_PRINT

ST R1, R1_BACKUP_3100
ST R2, R2_BACKUP_3100
ST R3, R3_BACKUP_3100
ST R4, R4_BACKUP_3100
ST R5, R5_BACKUP_3100
ST R6, R6_BACKUP_3100
ST R7, R7_BACKUP_3100

LD R6, DEC_0
LD R5, COUNT
LD R3, MASK
LD R2, COUNTTWELVE

LEFTSHIFT
	ADD R1, R1, R1
	ADD R2, R2, #-1
	BRp LEFTSHIFT
	
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
	ADD R5, R5, -1 		; Decrements count
	BRp loop			; Repeat through loop, until it stops at 0
loop_END 	

LD R1, R1_BACKUP_3100
LD R2, R2_BACKUP_3100
LD R3, R3_BACKUP_3100
LD R4, R4_BACKUP_3100
LD R5, R5_BACKUP_3100
LD R6, R6_BACKUP_3100
LD R7, R7_BACKUP_3100

RET
MASK .FILL x8000
COUNTTWELVE .FILL #12
COUNT .FILL #4
ZERO .FILL x30
ONE .FILL x31
SPACE .FILL x20
SEC_COUNT .FILL #0
R1_BACKUP_3100 .BLKW #1
R2_BACKUP_3100 .BLKW #1
R3_BACKUP_3100 .BLKW #1
R4_BACKUP_3100 .BLKW #1
R5_BACKUP_3100 .BLKW #1
R6_BACKUP_3100 .BLKW #1
R7_BACKUP_3100 .BLKW #1
NUMARRAY .FILL x3500
DEC_0 .FILL #0

.orig x3600
ADDNUM .FILL #1
ANDNUM .FILL #5
BRNUM .FILL #0
JMPNUM .FILL #12
JSRNUM .FILL #4
JSRRNUM .FILL #4
LDNUM .FILL #2
LDINUM .FILL #10
LDRNUM .FILL #6
LEANUM .FILL #14
NOTNUM .FILL #9
RETNUM .FILL #12
RTINUM .FILL #8
STNUM .FILL #3
STINUM .FILL #11
STRNUM .FILL #7
TRAPNUM .FILL #15

.orig x3700

ADDSTR .STRINGZ "ADD = "
ANDSTR .STRINGZ "AND = "
BRSTR .STRINGZ "BR = "
JMPSTR .STRINGZ "JMP = "
JSRSTR .STRINGZ "JSR = "
JSRRSTR .STRINGZ "JSRR = "
LDSTR .STRINGZ "LD = "
LDISTR .STRINGZ "LDI = "
LDRSTR .STRINGZ "LDR = "
LEASTR .STRINGZ "LEA = "
NOTSTR .STRINGZ "NOT = "
RETSTR .STRINGZ "RET = "
RTISTR .STRINGZ "RTI = "
STSTR .STRINGZ "ST = "
STISTR .STRINGZ "STI = "
STRSTR .STRINGZ "STR = "
TRAPSTR .STRINGZ "TRAP = "

.orig x3400

ST R7, R7_BACKUP_3400

LD R5, OPCODEARRAY
LD R6, STRINGARRAY
LD R3, COUNT1

LOOP
ADD R0, R6, #0
PUTS
REPEAT
ADD R6, R6, #1
LDR R0, R6, #0
ADD R0, R0, #0
BRnp REPEAT
ADD R6, R6, #1

LDR R1, R5, #0
LD R4, OPCODE_PRINT1
JSRR R4
ADD R5, R5, #1

LD R0, newLine
OUT

ADD R3, R3, #-1
BRp LOOP


LD R7, R7_BACKUP_3400
RET

OPCODE_PRINT1 .FILL x3100
R7_BACKUP_3400 .BLKW #1
OPCODEARRAY .FILL x3600
STRINGARRAY .FILL x3700
newLine .FILL x0A
COUNT1 .FILL #17
.END