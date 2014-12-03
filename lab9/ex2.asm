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

LD R6, SUB_STACK_POP
JSRR R6
HALT
SUB_STACK_PUSH .FILL x3200
SUB_STACK_POP .FILL x3400
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
ADD R2, R1, #-1
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


.END
