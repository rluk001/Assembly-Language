;=================================================
; Name: Luk, Ryan
; Username: rluk001
;
; Assignment name: Assignment 6
; Lab section: 022
; TA: Bryan Marsh
;
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;=================================================
.orig x3000

INFLOOP
JSR MENU

LD R2, NUMONE
ADD R2, R0, R2
BRp STEP1
LD R6, ALL_MACHINES_BUSY 
JSRR R6
BR INFLOOP

STEP1
LD R2, NUMTWO
ADD R2, R0, R2
BRp STEP2 
LD R6, ALL_MACHINES_FREE
JSRR R6
BR INFLOOP

STEP2
LD R2, NUMTHREE
ADD R2, R0, R2
BRp STEP3
LD R6, NUM_BUSY_MACHINES
JSRR R6
BR INFLOOP

STEP3
LD R2, NUMFOUR
ADD R2, R0, R2
BRp STEP4
LD R6, NUM_FREE_MACHINES
JSRR R6
BR INFLOOP

STEP4
;LD R2, NUMFIVE
;ADD R2, R0, R2
;BRp STEP5 
;LD R6, MACHINE_STATUS
;JSRR R6

;STEP5
;LD R2, NUMSIX
;ADD R2, R0, R2
;BRp STEP6
;LD R6, FIRST_FREE
;JSRR R6

;STEP6
LD R2, NUMSEVEN
ADD R2, R0, R2
BRz INFLOOP_END

BR INFLOOP

LEA R0, GOODBYE
PUTS

INFLOOP_END
HALT

ALL_MACHINES_BUSY .FILL x3400
ALL_MACHINES_FREE .FILL x3600
NUM_BUSY_MACHINES .FILL x3800
NUM_FREE_MACHINES .FILL x4000
NUMONE .FILL #-49
NUMTWO .FILL #-50
NUMTHREE .FILL #-51
NUMFOUR .FILL #-52
NUMFIVE .FILL #-53
NUMSIX .FILL #-54
NUMSEVEN .FILL #-55
GOODBYE .STRINGZ "Goodbye!"

.orig x3200

MENU
ST R7, R7_BACKUP_3200

LEA R0, MENUPRINTOUT
PUTS

NEXT
LD R0, newLineChar
OUT

LEA R0, CHOICES
PUTS

GETC
OUT

LD R3, ONE
LD R4, SEVEN

ADD R3, R0, R3
BRn NEXT

ADD R4, R0, R4
BRp NEXT

LD R7, R7_BACKUP_3200

RET

R7_BACKUP_3200 .BLKW #1
ONE .FILL #-49
SEVEN .FILL #-55
newLineChar .FILL x0A
CHOICES .STRINGZ "Please choose any number from 1-7: "
MENUPRINTOUT .STRINGZ "**********************\n* The Busyness Server ************************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.orig x3400
ST R7, R7_BACKUP_3400

LD R6, VECTOR
JSRR R6

ADD R1, R5, #0

LD R5, COUNT_1

loop
	ADD R1, R1, #0
	BRn NEXT1			; Goes to ELSE_IF if MSB is negative
IF_STATEMENT
	BR FAIL
NEXT1	
	ADD R1, R1, R1 		; Left shifting	
	ADD R5, R5, #-1 		; Decrements count
	BRp loop			; Repeat through loop, until it stops at 0
loop_END 
BR GETZERO

FAIL
LEA R0, string1
PUTS
BR ENDLOOP

GETZERO
LEA R0, string2
PUTS

ENDLOOP
LD R7, R7_BACKUP_3400

RET
COUNT_1 .FILL #16
VECTOR .FILL x5000
MASK1 .FILL xFFFF
R7_BACKUP_3400 .BLKW #1
string1 .STRINGZ "\nNot all machines are busy.\n"
string2 .STRINGZ "\nAll machines are busy.\n"

.orig x3600
ST R7, R7_BACKUP_3600

LD R6, VECTOR2
JSRR R6

ADD R1, R5, #0

LD R5, COUNT_2
loop2
	ADD R1, R1, #0
	BRzp NEXT2			; Goes to ELSE_IF if MSB is negative
IF_STATEMENT2
	BR FAIL2
NEXT2	
	ADD R1, R1, R1 		; Left shifting	
	ADD R5, R5, #-1 		; Decrements count
	BRp loop2			; Repeat through loop, until it stops at 0
loop2_END 
BR GETONE

FAIL2
LEA R0, string4
PUTS
BR ENDLOOP2

GETONE
LEA R0, string3
PUTS

ENDLOOP2

LD R7, R7_BACKUP_3600

RET

COUNT_2 .FILL #16
MASK2 .FILL xFFFF
VECTOR2 .FILL x5000
R7_BACKUP_3600 .BLKW #1
string3 .STRINGZ "\nAll machines are free.\n"
string4 .STRINGZ "\nNot all machines are free.\n"

.orig x3800
ST R7, R7_BACKUP_3800

LD R6, VECTOR3
JSRR R6

ADD R1, R5, #0

LD R3, MASK3
LD R5, COUNT3
LD R4, NUMMACHINES
loop3
	AND R6, R1, R3		; Checks if the MSB is positive or negative from MASK
	BRn NEXT3			; Goes to ELSE_IF if MSB is negative
IF_STATEMENT3
	ADD R4, R4, #1
NEXT3	
	ADD R1, R1, R1 		; Left shifting	
	ADD R5, R5, -1 		; Decrements count
	BRp loop3			; Repeat through loop, until it stops at 0
loop3_END 	

ADD R2, R4, #0

LEA R0, output
PUTS

LD R5, SUB2
ADD R0, R2, R5
BRp CONT

LD R5, ASCII_CONVERT
ADD R0, R4, R5
OUT
BR ENDTHISLOOP

CONT
LD R0, ASCII_ONE
OUT

ADD R0, R0, R5
OUT

ENDTHISLOOP

LEA R0, output2
PUTS

LD R7, R7_BACKUP_3800

RET
ASCII_CONVERT .FILL #48
ASCII_ONE .FILL #49
SUB2 .FILL #-10
COUNT3 .FILL #16
NUMMACHINES .FILL #0
VECTOR3 .FILL x5000
R7_BACKUP_3800 .BLKW #1
MASK3 .FILL x8000
output .STRINGZ "\nThere are "
output2 .STRINGZ " busy machines.\n"

.orig x4000
ST R7, R7_BACKUP_4000

ADD R1, R5, #0

LD R3, MASK4
LD R5, COUNT2
LD R4, NUMMACHINES2
loop4
	AND R6, R1, R3		; Checks if the MSB is positive or negative from MASK
	BRzp NEXT4			; Goes to ELSE_IF if MSB is negative
IF_STATEMENT4
	ADD R4, R4, #1
NEXT4	
	ADD R1, R1, R1 		; Left shifting	
	ADD R5, R5, -1 		; Decrements count
	BRp loop4			; Repeat through loop, until it stops at 0
loop4_END 	

ADD R2, R4, #0

LEA R0, output3
PUTS

LD R5, SUB3
ADD R0, R2, R5
BRp CONTINUETHIS

LD R5, ASCII_CONVERT2
ADD R0, R4, R5
OUT
BR ENDTHISLOOP2

CONTINUETHIS
LD R0, ASCII_ONE2
OUT

ADD R0, R0, R5
OUT

ENDTHISLOOP2

LEA R0, output4
PUTS

LD R7, R7_BACKUP_4000

RET

ASCII_CONVERT2 .FILL #48
ASCII_ONE2 .FILL #49
SUB3 .FILL #-10
MASK4 .FILL x8000
R7_BACKUP_4000 .BLKW #1
COUNT2 .FILL #16
NUMMACHINES2 .FILL #0
VECTOR4 .FILL x5000
output3 .STRINGZ "\nThere are "
output4 .STRINGZ " free machines.\n"

.orig x5000
ST R7, R7_BACKUP_5000

LD R5, BUSYNESS

LD R7, R7_BACKUP_5000

RET

BUSYNESS .FILL x6A13
R7_BACKUP_5000 .BLKW #1

.END
