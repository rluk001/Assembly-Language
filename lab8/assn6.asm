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

LD R4, NUMONE
ADD R4, R0, R4
BRp STEP1
LD R6, ALL_MACHINES_BUSY 
JSRR R6
BR INFLOOP

STEP1
LD R4, NUMTWO
ADD R4, R0, R4
BRp STEP2 
LD R6, ALL_MACHINES_FREE
JSRR R6
BR INFLOOP

STEP2
LD R4, NUMTHREE
ADD R4, R0, R4
BRp STEP3
LD R6, NUM_BUSY_MACHINES
JSRR R6
BR INFLOOP

STEP3
LD R4, NUMFOUR
ADD R4, R0, R4
BRp STEP4
LD R6, NUM_FREE_MACHINES
JSRR R6
BR INFLOOP

STEP4
LD R4, NUMFIVE
ADD R4, R0, R4
BRp STEP5 
LD R6, MACHINE_STATUS
JSRR R6

STEP5
LD R4, NUMSIX
ADD R4, R0, R4
BRp STEP6
LD R6, FIRST_FREE
JSRR R6

STEP6
LD R4, NUMSEVEN
ADD R4, R0, R4
BRz INFLOOP_END

BR INFLOOP

INFLOOP_END

LEA R0, GOODBYE
PUTS

HALT

ALL_MACHINES_BUSY .FILL x3400
ALL_MACHINES_FREE .FILL x3600
NUM_BUSY_MACHINES .FILL x3800
NUM_FREE_MACHINES .FILL x4000
MACHINE_STATUS .FILL x4200
FIRST_FREE .FILL x4400
NUMONE .FILL #-49
NUMTWO .FILL #-50
NUMTHREE .FILL #-51
NUMFOUR .FILL #-52
NUMFIVE .FILL #-53
NUMSIX .FILL #-54
NUMSEVEN .FILL #-55
GOODBYE .STRINGZ "\nGoodbye!\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
; user to select an option, and returned the selected option.
; Return Value (R1): The option selected: #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------

.orig x3200

MENU
ST R7, R7_BACKUP_3200

LEA R0, MENUPRINTOUT
PUTS

LD R0, newLineChar
OUT

LEA R0, CHOICES
PUTS

NEXT

GETC
OUT

ADD R4, R0, #0

LD R5, ONE
LD R6, SEVEN

ADD R5, R0, R5
BRn ERROR_1
BR XCONT

ADD R6, R0, R6
BRp ERROR_1
BR XCONT

ERROR_1
LEA R0, ERRORPRINT
PUTS

BR NEXT

XCONT

LD R1, COVERT

ADD R1, R4, R1

LD R7, R7_BACKUP_3200

RET

R7_BACKUP_3200 .BLKW #1
COVERT .FILL #-48
ONE .FILL #-49
SEVEN .FILL #-55
newLineChar .FILL x0A
CHOICES .STRINGZ "Please choose any number from 1-7: "
ERRORPRINT .STRINGZ "\nError: please choose any number from 1-7: "
MENUPRINTOUT .STRINGZ "**********************\n* The Busyness Server *\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------

.orig x3400
ST R7, R7_BACKUP_3400

LD R6, VECTOR
JSRR R6

ADD R1, R5, #0

LD R2, ZEROSET
LD R5, COUNT_1

loop
	ADD R1, R1, #0
	BRzp NEXT1			; Goes to ELSE_IF if MSB is negative
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
ADD R2, R2, #1
ENDLOOP
LD R7, R7_BACKUP_3400

RET
ZEROSET .FILL #0
COUNT_1 .FILL #16
VECTOR .FILL x5000
MASK1 .FILL xFFFF
R7_BACKUP_3400 .BLKW #1
string1 .STRINGZ "\nNot all machines are busy.\n"
string2 .STRINGZ "\nAll machines are busy.\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------

.orig x3600
ST R7, R7_BACKUP_3600

LD R6, VECTOR2
JSRR R6

ADD R1, R5, #0
LD R2, ZEROSET2
LD R5, COUNT_2
loop2
	ADD R1, R1, #0
	BRn NEXT2			; Goes to ELSE_IF if MSB is negative
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
ADD R2, R2, #1
ENDLOOP2

LD R7, R7_BACKUP_3600

RET

COUNT_2 .FILL #16
ZEROSET2 .FILL #0
VECTOR2 .FILL x5000
R7_BACKUP_3600 .BLKW #1
string3 .STRINGZ "\nAll machines are free.\n"
string4 .STRINGZ "\nNot all machines are free.\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------

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
ADD R3, R2, R5
BRzp CONT

LD R5, ASCII_CONVERT
ADD R0, R4, R5
OUT
BR ENDTHISLOOP

CONT
LD R5, ASCII_CONVERT
LD R0, ASCII_ONE
OUT

ADD R0, R3, R5
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

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------

.orig x4000
ST R7, R7_BACKUP_4000

LD R6, VECTOR4
JSRR R6

ADD R1, R5, #0

LD R5, COUNT2
LD R4, NUMMACHINES2
loop4
	ADD R1, R1, #0		; Checks if the MSB is positive or negative from MASK
	BRzp NEXT4			; Goes to ELSE_IF if MSB is negative
IF_STATEMENT4
	ADD R4, R4, #1
NEXT4	
	ADD R1, R1, R1 		; Left shifting	
	ADD R5, R5, #-1 		; Decrements count
	BRp loop4			; Repeat through loop, until it stops at 0
loop4_END 	

ADD R2, R4, #0

LEA R0, output3
PUTS

LD R5, SUB3
ADD R3, R2, R5
BRzp CONTINUETHIS

LD R5, ASCII_CONVERT2
ADD R0, R4, R5
OUT
BR ENDTHISLOOP2

CONTINUETHIS
LD R5, ASCII_CONVERT2
LD R0, ASCII_ONE2
OUT

ADD R0, R3, R5
OUT

ENDTHISLOOP2

LEA R0, output4
PUTS

LD R7, R7_BACKUP_4000

RET

ASCII_CONVERT2 .FILL #48
ASCII_ONE2 .FILL #49
SUB3 .FILL #-10
R7_BACKUP_4000 .BLKW #1
COUNT2 .FILL #16
NUMMACHINES2 .FILL #0
VECTOR4 .FILL x5000
output3 .STRINGZ "\nThere are "
output4 .STRINGZ " free machines.\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
; by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------

.orig x4200

ST R7, R7_BACKUP_4200

LEA R0, question
PUTS

LD R1, RESETZERO
LD R3, RESETZERO
LD R4, CHECKFORONE
LD R5, RESETZERO

LOOP
LD R6, myNewLine
GETC
OUT
ADD R6, R0, R6
BRz END_ME

LD R6, NEGZERO
ADD R6, R0, R6
BRzp GOTONEXT1
BR ERRORPRINTOUT_1

GOTONEXT1
LD R6, NEGNINE
ADD R6, R0, R6
BRnz GOTONEXT2
BR ERRORPRINTOUT_1

GOTONEXT2
LD R2, RESETZERO
ADD R4, R4, #-1
LD R5, ASCII_CONVERT3
ADD R5, R0, R5
ADD R5, R5, R2
BRnz CONTINUE123
ADD R1, R5, #1
ADD R3, R3, R1
BR LOOP
CONTINUE123
ADD R2, R5, #1
ADD R4, R4, #0
BRp ADDPARTS
ADD R3, R3, R2
BR LOOP
ADDPARTS
ADD R2, R2, #0
BRz LOOP
LD R6, ADDTEN
ADD R3, R2, R6
ADD R1, R2, #0
BR LOOP

END_ME

ADD R4, R4, #0
BRz GOTOTHISTHING

ADD R2, R1, #0
BR SKIPPY

GOTOTHISTHING
ADD R2, R3, #0

SKIPPY
LD R6, VECTOR5
JSRR R6

ADD R1, R5, #0
ADD R5, R2, #0

LD R4, RESETZERO
ADD R4, R2, R4
BRzp NEXT7
BR ERRORPRINTOUT_1

NEXT7
LD R4, NUMBER15
ADD R4, R2, R4
BRnz NEXT8
BR ERRORPRINTOUT_1

NEXT8
loop5
	ADD R5, R5, #0
	BRnz loop5_END	
	ADD R1, R1, R1 		; Left shifting	
	ADD R5, R5, #-1 	; Decrements count
	BRp loop5			; Repeat through loop, until it stops at 0
loop5_END
ADD R4, R2, #0

LEA R0, machineNum
PUTS

LD R5, SUB_1
ADD R3, R2, R5
BRzp CONTINUETHIS_01

LD R5, ASCII_CONVERT_1
ADD R0, R4, R5
OUT
BR ENDTHISLOOP_1

CONTINUETHIS_01
LD R0, ASCII_ONE_1
OUT

ADD R0, R2, R5

LD R5, ASCII_CONVERT_1

ADD R0, R0, R5
OUT

ENDTHISLOOP_1

ADD R1, R1, #0
BRn FREEPART

LEA R0, busyOutput
PUTS

LD R2, ZEROSET3
BR ENDALLOFTHIS

FREEPART
LEA R0, freeOutput
PUTS

LD R2, ZEROSET3
ADD R2, R2, #1
BR ENDALLOFTHIS

ERRORPRINTOUT_1
LEA R0, ERRORPRINT2
PUTS

ENDALLOFTHIS
LD R7, R7_BACKUP_4200

RET

ZEROSET3 .FILL #0
SUB_1 .FILL #-10
ASCII_CONVERT_1 .FILL #48
ASCII_ONE_1 .FILL #49
ADDTEN .FILL #9
NEGZERO .FILL #-48
NEGNINE .FILL #-57
CHECKFORONE .FILL #2
RESETZERO .FILL #0
NUMBER15 .FILL #-15
myNewLine .FILL -x0A
ASCII_CONVERT3 .FILL #-49
VECTOR5 .FILL x5000
R7_BACKUP_4200 .BLKW #1
question .STRINGZ "\nWhich machine do you want the status of (0-15)? "
machineNum .STRINGZ "\nMachine #"
busyOutput .STRINGZ " is busy.\n"
freeOutput .STRINGZ " is free.\n"
ERRORPRINT2 .STRINGZ "\nError: Invalid Number. Going Back to Menu\n"
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------

.orig x4400

ST R7, R7_BACKUP_4400

LD R6, VECTOR6
JSRR R6

ADD R1, R5, #0

LD R4, COUNTME
LD R5, COUNTALL
LEFTSHIFTING1
	ADD R1, R1, #0
	BRn FINALCOUNT
	ADD R1, R1, R1
	ADD R4, R4, #1
	ADD R5, R5, #-1
BRp LEFTSHIFTING1

FINALCOUNT

LD R5, NEGCOUNT
ADD R5, R4, R5
BRz NEGATIVESTUFF

LEA R0, firstAvailable
PUTS

LD R5, SUB4
ADD R3, R4, R5
BRp CONTINUETHIS_2

LD R5, ASCII_CONVERT4
ADD R0, R4, R5
OUT
BR ENDTHISLOOP2_1

CONTINUETHIS_2
LD R5, ASCII_CONVERT4
LD R0, ASCII_ONE4
OUT

ADD R0, R3, R5
OUT

ENDTHISLOOP2_1

LEA R0, firstAvailable2
PUTS
BR END123
NEGATIVESTUFF

LEA R0, noneAvailable
PUTS

END123
ADD R2, R4, #0

LD R7, R7_BACKUP_4400

RET

NEGCOUNT .FILL #-16
SUB4 .FILL #-10
ASCII_ONE4 .FILL #49
ASCII_CONVERT4 .FILL #48
anotherNLine .FILL x0A
COUNTME .FILL #0
COUNTALL .FILL #16
R7_BACKUP_4400 .BLKW #1
VECTOR6 .FILL x5000
firstAvailable .STRINGZ "\nThe first available machine is number "
firstAvailable2 .STRINGZ ".\n"
noneAvailable .STRINGZ "\nThere are no machines available at the moment.\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: BUSYNESS_VECTOR
; Inputs: None
; Postcondition: 
; The subroutine loads the register R5 with an address.
; Return Value (R5): the address for busyness
;-----------------------------------------------------------------------------------------------------------------

.orig x5000
ST R7, R7_BACKUP_5000

LD R5, BUSYNESS

LD R7, R7_BACKUP_5000

RET

BUSYNESS .FILL x6A13
R7_BACKUP_5000 .BLKW #1

.END
