;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 09
; Lab section: 022
; TA: Bryan Marsh
;=================================================
.orig x3000

LD R6, SUB_STACK_PUSH
JSRR R6

LD R6, SUB_RPN_MULTIPLY
JSRR R6


HALT
SUB_STACK_PUSH .FILL x3200
SUB_STACK_POP .FILL x3400
SUB_RPN_MULTIPLY .FILL x3600
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R1): stack_addr: A pointer to the beginning of the stack
; Parameter (R2): top: A pointer to the next place to PUSH an item
; Parameter (R3): capacity: The number of additional items the stack can hold
; Postcondition: The subroutine has pushed (R0) onto the stack. If an overflow
; occurred, the subroutine has printed an overflow error message
; and terminated.
; Return Value: R2 ← updated top value
; R3 ← updated capacity value
;-----------------------------------------------------------------------------------------------
.orig x3200
ST R0, R0_BACKUP_3200
ST R5, R5_BACKUP_3200
ST R6, R6_BACKUP_3200
ST R7, R7_BACKUP_3200

LD R2, TOP
LD R1, STACK_ADDR
ADD R2, R1, #1
LD R3, CAPACITY
LD R6, TOP

LEA R0, PROMPT
PUTS

FOR_LOOP
	GETC
	OUT
	LOOP1
	LD R5, newLineChar
	ADD R5, R0, R5
	BRz ADDTOSTACK
	
	LD R5, numberzero
	ADD R5, R0, R5
	BRzp CONT
	BR ERROR_1
	CONT
	LD R5, numbernine
	ADD R5, R0, R5
	BRnz CONT2
	BR ERROR_1
	CONT2
	ADD R6, R6, R0
	BR FOR_LOOP
FOR_LOOP_END

BR FINE

ADDTOSTACK
	ADD R4, R4, #1
	STR R6, R1, #0
	ADD R1, R1, #1
	ADD R2, R1, #1
	LD R6, RESET
	ADD R3, R3, #-1
	BRz CANNOTSTACKANYMORE
	LEA R0, PRESSENTER
	PUTS
	GETC
	OUT
	LD R5, newLineChar
	ADD R5, R0, R5
	BRz FINE
	BR LOOP1
	
ERROR_1
	LEA R0, INVALIDNUMBER
	PUTS
	BR FOR_LOOP

CANNOTSTACKANYMORE
	LEA R0, ERROR
	PUTS

FINE
ADD R1, R1, #-1
ADD R2, R2, #-1

LD R0, R0_BACKUP_3200
LD R5, R5_BACKUP_3200
LD R6, R6_BACKUP_3200
LD R7, R7_BACKUP_3200

RET

ASCII_CONVERT .FILL #-48
CAPACITY .FILL #5
TOP .FILL #0
STACK_ADDR .FILL x4000
R0_BACKUP_3200 .BLKW #1
R5_BACKUP_3200 .BLKW #1
R6_BACKUP_3200 .BLKW #1
R7_BACKUP_3200 .BLKW #1
numberzero .FILL #-48
numbernine .FILL #-57
newLineChar .FILL -x0A
RESET .FILL #0
PROMPT .STRINGZ "Please enter a number from 0-9 to push onto the stack(followed by ENTER): "
PRESSENTER .STRINGZ "Press enter to stop pushing to stack: "
ERROR .STRINGZ "Capacity Overflow\n"
INVALIDNUMBER .STRINGZ "Invalid number\n"

;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R1): stack_addr: A pointer to the beginning of the stack
; Parameter (R2): top: A pointer to the item to POP
; Parameter (R3): capacity: The # of additional items the stack can hold
; Postcondition: The subroutine has popped MEM[top] off of the stack.
; If an underflow occurred, the subroutine has printed an
; underflow error message and terminated.
; Return Value: R0 ← value popped off of the stack
; R2 ← updated top value
; R3 ← updated capacity value
;-----------------------------------------------------------------------------------------------
.orig x3400

ST R5, R5_BACKUP_3400
ST R6, R6_BACKUP_3400
ST R7, R7_BACKUP_3400

LEA R0, stack_pop
PUTS

LD R5, resetNum
ADD R5, R4, #-1
ADD R4, R4, #0
BRz UNDERFLOW
LD R6, resetNum
LDR R0, R1, #0
STR R6, R1, #0
ADD R3, R3, #1
ADD R4, R4, #-1
BR END

UNDERFLOW
LEA R0, underflow
PUTS

END
ADD R1, R1, #-1
ADD R2, R2, #-1

LD R5, R5_BACKUP_3400
LD R6, R6_BACKUP_3400
LD R7, R7_BACKUP_3400

RET
R5_BACKUP_3400 .BLKW #1
R6_BACKUP_3400 .BLKW #1
R7_BACKUP_3400 .BLKW #1
stack_addr .FILL x4000
resetNum .FILL #0
underflow .STRINGZ "Capacity Underflow\n"
stack_pop .STRINGZ "Stack popping now\n"

;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R1): stack_addr
; Parameter (R2): top
; Parameter (R3): capacity
; Postcondition: The subroutine has popped off the top two values of the stack,
; multiplied them together, and pushed the resulting value back
; onto the stack.
; Return Value: R2 ← updated top value
; R3 ← updated capacity value
;-----------------------------------------------------------------------------------------------
.orig x3600
ST R7, R7_BACKUP_3600

LD R6, popping
JSRR R6

LD R5, ASCII_CONVERTING
ADD R5, R0, R5

LD R6, popping
JSRR R6

LD R6, ASCII_CONVERTING
ADD R6, R0, R6

LD R0, multiply
JSRR R0

ADD R1, R1, #1
ADD R2, R2, #1
ADD R4, R4, #1
STR R3, R1, #0
ADD R5, R4, #0
NOT R5, R5
ADD R5, R5, #1
LD R6, CHECK_CAPACITY
ADD R3, R5, R6

LD R6, popping
JSRR R6

ADD R5, R0, #0

LEA R0, string
PUTS

LD R6, printALL
JSRR R6

LD R7, R7_BACKUP_3600

RET

printALL .FILL x4200
CHECK_CAPACITY .FILL #5
R7_BACKUP_3600 .BLKW #1
ASCII_CONVERTING .FILL #-48
popping .FILL x3400
multiply .FILL x3800
string .STRINGZ "Answer = "
.END

.orig x3800

MULTIPLYNUMS

ST R1, R1_BACKUP_3800
ST R2, R2_BACKUP_3800
ST R4, R4_BACKUP_3800
ST R7, R7_BACKUP_3800
ADD R1, R5, #0
ADD R1, R1, #0
BRz EQUALSZERO ; If R1 is zero
BRn FORNEGATIVE ; If R1 is negative
ADD R2, R6, #0
ADD R2, R2, #0
BRz EQUALSZERO ; If R2 is zero
BRn FORNEGATIVE2 ; If R2 is negative
NOT R3, R1 ; Subtract R1 from R2
ADD R3, R3, #1
ADD R5, R2, R3
BRp largerNumberPos ; If positive R2 is larger, R1 is smaller
BRn smallerNumberPos ; If negative R2 is smaller, R1 is larger
BRz sameNumber ; If R1 and R2 are the same number
FORNEGATIVE ; R1 is negative
ADD R2, R2, #0
BRn FORNEGATIVEBOTH ; Check if R2 is also negative
BRz EQUALSZERO ; Check if R2 is zero
ADD R5, R1, R2
BRp largerNumberNeg ; R2 is larger, R1 is smaller
BRn smallerNumberNeg ; R1 is larger, R2 is smaller
BRz zeroNeg
FORNEGATIVE2
ADD R5, R1, R2
BRp largerNumberNeg2 ; R1 is larger, R2 is smaller
BRn smallerNumberNeg2 ; R2 is larger, R1 is smaller
BRz zeroNeg
FORNEGATIVEBOTH
NOT R3, R1
ADD R3, R3, #1
ADD R5, R2, R3
BRn largerNumberPos ; R2 is larger, R1 is smaller
BRp smallerNumberPos ; R1 is larger, R2 is smaller
BRz sameNumber ; R1 and R2 are the same
largerNumberPos ;R2 is larger, R1 is smaller
ADD R1, R1, #0
BRn CONVERTR1
CHECK_1
ADD R2, R2, #0
BRn CONVERTR2
CHECK_2
ADD R4, R2, #0
ADD R1, R1, #-1
BRnz SKIPSTEP2
FOR_LOOPh
ADD R2, R2, R4
ADD R2, R2, #0
BRn OVERFLOW
ADD R1, R1, #-1
BRp FOR_LOOPh
SKIPSTEP2
ADD R3, R2, #0
BR PRINTTHIS
largerNumberNeg ;R2 is larger, R1 is smaller
NOT R1, R1
ADD R1, R1, #1
ADD R4, R2, #0
ADD R1, R1, #-1
BRnz SKIPSTEP1
FOR_LOOP_1 ; Smart ADD
ADD R2, R2, R4
ADD R2, R2, #0
BRn OVERFLOW
ADD R1, R1, #-1
BRp FOR_LOOP_1
SKIPSTEP1
NOT R2, R2
ADD R2, R2, #1
BRp OVERFLOW
ADD R3, R2, #0
BR PRINTTHIS
largerNumberNeg2 ;R1 is larger, R2 is smaller
NOT R2, R2
ADD R2, R2, #1
ADD R3, R1, #0
ADD R2, R2, #-1
BRnz SKIPSTEP
FOR_LOOP_2 ; Smart ADD
ADD R1, R1, R3
ADD R1, R1, #0
BRn OVERFLOW
ADD R2, R2, #-1
BRp FOR_LOOP_2
SKIPSTEP
NOT R1, R1
ADD R1, R1, #1
BRp OVERFLOW
ADD R3, R1, #0
BR PRINTTHIS
smallerNumberPos ;R1 is larger, R2 is smaller
ADD R1, R1, #0
BRn CONVERTR1_2
CHECK_1_2
ADD R2, R2, #0
BRn CONVERTR2_2
CHECK_2_2
ADD R3, R1, #0
ADD R2, R2, #-1
BRnz SKIPSTEP3
FOR_LOOP_3 ; Smart ADD
ADD R1, R1, R3
ADD R1, R1, #0
BRn OVERFLOW
ADD R2, R2, #-1
BRp FOR_LOOP_3
SKIPSTEP3
ADD R3, R1, #0
BR PRINTTHIS
smallerNumberNeg ;R1 is larger, R2 is smaller
ADD R1, R1, #0
BRn CONVERTR1_23
CHECK1_23
ADD R3, R1, #0
ADD R2, R2, #-1
BRnz SKIPSTEP4
FOR_LOOP_4 ; Smart ADD
ADD R1, R1, R3
ADD R1, R1, #0
BRn OVERFLOW
ADD R2, R2, #-1
BRp FOR_LOOP_4
SKIPSTEP4
NOT R1, R1
ADD R1, R1, #1
BRp OVERFLOW
ADD R3, R1, #0
BR PRINTTHIS
smallerNumberNeg2 ;R2 is larger, R1 is smaller
ADD R2, R2, #0
BRn CONVERTR2_23
CHECK2_23
ADD R4, R2, #0
ADD R1, R1, #-1
BRnz SKIPSTEP5
FOR_LOOP_5 ; Smart ADD
ADD R2, R2, R4
ADD R2, R2, #0
BRn OVERFLOW
ADD R1, R1, #-1
BRp FOR_LOOP_5
SKIPSTEP5
NOT R2, R2
ADD R2, R2, #1
BRp OVERFLOW
ADD R3, R2, #0
BR PRINTTHIS
sameNumber ;R1 and R2 are the same
ADD R1, R1, #0
BRn CONVERTR1_3
CHECK1_3
ADD R2, R2, #0
BRn CONVERTR2_3
CHECK2_3
ADD R3, R1, #0
ADD R2, R2, #-1
BRnz SKIPSTEP6
FOR_LOOP_6 ; Smart ADD
ADD R1, R1, R3
ADD R1, R1, #0
BRn OVERFLOW
ADD R2, R2, #-1
BRp FOR_LOOP_6
SKIPSTEP6
ADD R3, R1, #0
BR PRINTTHIS
zeroNeg
ADD R1, R1, #0
BRn CONVR1
CHCK1
ADD R2, R2, #0
BRn CONVR2
CHCK2
ADD R3, R1, #0
ADD R2, R2, #-1
BRnz SKIPSTEP7
FOR_LOOP7
ADD R1, R1, R3
ADD R1, R1, #0
BRn OVERFLOW
ADD R2, R2, #-1
BRp FOR_LOOP7
SKIPSTEP7
NOT R1, R1
ADD R1, R1, #1
ADD R3, R1, #0
BR PRINTTHIS
OVERFLOW
LEA R0, overflowissue
PUTS
BR MULTIPLYNUMS_END
CONVR1
NOT R1, R1
ADD R1, R1, #1
BR CHCK1
CONVR2
NOT R2, R2
ADD R2, R2, #1
BR CHCK2
CONVERTR1 ;Converting without same name
NOT R1, R1
ADD R1, R1, #1
BR CHECK_1
CONVERTR2
NOT R2, R2
ADD R2, R2, #1
BR CHECK_2
CONVERTR1_2
NOT R1, R1
ADD R1, R1, #1
BR CHECK_1_2
CONVERTR1_23
NOT R1, R1
ADD R1, R1, #1
BR CHECK1_23
CONVERTR2_2
NOT R2, R2
ADD R2, R2, #1
BR CHECK_2_2
CONVERTR2_23
NOT R2, R2
ADD R2, R2, #1
BR CHECK2_23
CONVERTR1_3
NOT R1, R1
ADD R1, R1, #1
BR CHECK1_3
CONVERTR2_3
NOT R2, R2
ADD R2, R2, #1
BR CHECK2_3
EQUALSZERO
LD R3, DEC_0
PRINTTHIS ; Calls Subroutine for Print
ADD R1, R3, #0
;LD R6, SUBROUTINEPRINT
;JSRR R6
MULTIPLYNUMS_END
LD R1, R1_BACKUP_3800
LD R2, R2_BACKUP_3800
LD R4, R4_BACKUP_3800
LD R7, R7_BACKUP_3800
RET
R1_BACKUP_3800 .BLKW #1
R2_BACKUP_3800 .BLKW #1
R4_BACKUP_3800 .BLKW #1
R7_BACKUP_3800 .BLKW #1
myNewLine .FILL x0A
DEC_0 .FILL #0
overflowissue .STRINGZ "OVERFLOW!\n"
SUBROUTINEPRINT .FILL x4200

.orig x4200
ST R1, BACKUP_R1_4200
ST R2, BACKUP_R2_4200
ST R3, BACKUP_R3_4200
ST R4, BACKUP_R4_4200
ST R7, BACKUP_R7_4200
LD R6, COUNT
ADD R1, R5, #0
BRn NEGATIVEPRINT
LD R0, PLUSSIGN ; '+' sign
OUT
BR SKIP
NEGATIVEPRINT
LD R0, MINUSSIGN ; '-' sign
OUT
NOT R1, R1
ADD R1, R1, #1
SKIP
LD R3, COUNT
LD R2, SUBTRACT5
LD R5, ZEROPLUS
FOR1_LOOP ; -10000
ADD R4, R1, #0
ADD R1, R1, R2
BRzp INC5
BR FOR1_LOOP_END
INC5
ADD R3, R3, #1
BR FOR1_LOOP
FOR1_LOOP_END
ADD R0, R3, R5
ADD R6, R6, #0
BRp SKIP_1
ADD R3, R3, #0
BRz SKIPPRINT1
SKIP_1
ADD R6, R6, #1
OUT
SKIPPRINT1
ADD R1, R4, #0
LD R3, COUNT
LD R2, SUBTRACT4
FOR2_LOOP ; -1000
ADD R4, R1, #0
ADD R1, R1, R2
BRzp INC4
BR FOR2_LOOP_END
INC4
ADD R3, R3, #1
BR FOR2_LOOP
FOR2_LOOP_END
ADD R0, R3, R5
ADD R6, R6, #0
BRp SKIP_2
ADD R3, R3, #0
BRz SKIPPRINT2
SKIP_2
ADD R6, R6, #1
OUT
SKIPPRINT2
ADD R1, R4, #0
LD R3, COUNT
LD R2, SUBTRACT3
FOR3_LOOP ; -100
ADD R4, R1, #0
ADD R1, R1, R2
BRzp INC3
BR FOR3_LOOP_END
INC3
ADD R3, R3, #1
BR FOR3_LOOP
FOR3_LOOP_END
ADD R0, R3, R5
ADD R6, R6, #0
BRp SKIP_3
ADD R3, R3, #0
BRz SKIPPRINT3
SKIP_3
ADD R6, R6, #1
OUT
SKIPPRINT3
ADD R1, R4, #0
LD R3, COUNT
LD R2, SUBTRACT2
FOR4_LOOP ; -10
ADD R4, R1, #0
ADD R1, R1, R2
BRzp INC2
BR FOR4_LOOP_END
INC2
ADD R3, R3, #1
BR FOR4_LOOP
FOR4_LOOP_END
ADD R0, R3, R5
ADD R6, R6, #0
BRp SKIP_4
ADD R3, R3, #0
BRz SKIPPRINT4
SKIP_4
ADD R6, R6, #1
OUT
SKIPPRINT4
ADD R1, R4, #0
ADD R0, R1, R5 ; Print for single digits regardless
OUT
LD R0, PRINTSPACE
OUT
LD R1, BACKUP_R1_4200
LD R2, BACKUP_R2_4200
LD R3, BACKUP_R3_4200
LD R4, BACKUP_R4_4200
LD R7, BACKUP_R7_4200
RET
BACKUP_R1_4200 .BLKW #1
BACKUP_R2_4200 .BLKW #1
BACKUP_R3_4200 .BLKW #1
BACKUP_R4_4200 .BLKW #1
BACKUP_R7_4200 .BLKW #1
SUBTRACT5 .FILL #-10000
SUBTRACT4 .FILL #-1000
SUBTRACT3 .FILL #-100
SUBTRACT2 .FILL #-10
COUNT .FILL #0
ZEROPLUS .FILL #48
PLUSSIGN .FILL #43
MINUSSIGN .FILL #45
PRINTSPACE .FILL #32
.END
