;=================================================
; Name: Luk, Ryan
; Username: rluk001
; 
; Assignment name: Assignment 5
; Lab section: 022
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;=================================================
.orig x3000

JSR INPUT 			; Receive First Input
ADD R2, R1, #0   	; Swap it to R2 to save

JSR INPUT 			; Receive Second Input
ADD R4, R1, #0 		; Swap R1 to R4
ADD R1, R2, #0 		; Swap R2 to R1
ADD R2, R4, #0 		; Swap R4 to R2

LD R6, PRINTOUT 	; Printout R1
JSRR R6

LD R0, STAR 		; Print Star
OUT

LD R0, PRINTASPACE 	; Print Space
OUT

ADD R4, R1, #0
ADD R1, R2, #0
LD R6, PRINTOUT 	; Printout R2
JSRR R6

LD R0, EQUALSSIGN 	; Print '=' sign
OUT

LD R0, PRINTASPACE  ; Print Space
OUT

ADD R1, R4, #0

JSR MULTIPLYNUMS 	; Multiply Nums

HALT

STAR .FILL #42
EQUALSSIGN .FILL #61
PRINTASPACE .FILL #32
PRINTOUT .FILL x3600

.orig x3200
INPUT

ST R2, R2_BACKUP_3200
ST R7, R7_BACKUP_3200

LEA R0, prompt
PUTS 

IF_STATEMENT 			;Big Loop
	GETC
	OUT
	ADD R3, R0, #0 		;Checks for big loops

	LD R1, PLUS 		; Checks if R0 is '+'
	NOT R1, R1  		; Inverting for 2's complement
	ADD R1, R1, #1 		; Adding 1 for 2's complement
	ADD R3, R0, R1 		; If its 0, R0 is a '+'
	BRz PLUSLOOP 		; Enters the PLUSLOOP

	LD R2, MINUS 		; Checks if R0 is '-'
	NOT R2, R2 			; Inverting for 2's complement
	ADD R2, R2, #1		; Adding 1 for 2's complement
	ADD R3, R0, R2 		; If its 0, R0 is a '-'
	BRz MINUSLOOP 		; Enters the MINUSLOOP

	LD R1, ZERO 		; First Check to see if R0 is >= 0
	NOT R1, R1 			; Inverting for 2's complement
	ADD R1, R1, #1 		; Adding 1 for 2's complement
	ADD R1, R0, R1 		; If its zero or positive, R0 is a number >= 0
	ADD R3, R1, #0
	BRzp SECOND_CHECK 	; Enters the SECOND_CHECK loop

	ERROR 				; It hits error for all the other cases
		LD R0, newLine
		OUT
		LEA R0, error
		PUTS
	BR IF_STATEMENT 	; Loops back to the big loop

SECOND_CHECK 			; Second Check to see if R0 is <= 9
	LD R2, NINE 		; Load R2 with '9'
	NOT R2, R2 			; Inverting for 2's complement 
	ADD R2, R2, #1 		; Adding 1 for 2's complement
	ADD R2, R0, R2 		; If its negative or zero, R0 is a number <= 9
	BRnz PLUSLOOP_START ; Enters the PLUSLOOP_START and ignores GETC/OUT of PLUSLOOP
BR ERROR 				; Goes to error if its not a number between 0-9

PLUSLOOP
	GETC
	OUT
	PLUSLOOP_START 			; Loop for positive numbers
		LD R6, newLine 		; Load R6 with newLine character
		NOT R6, R6  		; Inverting for 2's complement
		ADD R6, R6, #1 		; Adding 1 for 2's complement
		ADD R5, R0, R6 		; If its 0, R0 is the newline character
		BRz ERROR_1 		; Goes to ERROR loop
		FIR_CHECK 			; First Check
			LD R1, ZERO
			NOT R1, R1
			ADD R1, R1, #1
			ADD R1, R0, R1
			BRzp SEC_CHECK  ; Goes to Second Check
		BR ERROR_1 			; Goes to Error if first check fails
		SEC_CHECK 			; Second Check
			LD R2, NINE
			NOT R2, R2
			ADD R2, R2, #1
			ADD R2, R0, R2
			BRnz NEXTCNT 	; Goes to NEXTCNT which means R0 is a number
		BR ERROR_1 			; Goes to Error if second check fails
		NEXTCNT				; NEXTCNT checkmark
		LD R2, ZERO
		NOT R2, R2
		ADD R2, R2, #1
		ADD R0, R0, R2 		; Subtracting R0 from '0'
		ADD R4, R0, #0 		; Save the value of R0 into R4
		ADD R1, R0, #0 		; Save the value of R0 into R1
		LD R5, NUM_4 		; Getting up to 5 digits
		REPSTEP 				; REPSTEP loop
			LD R6, MULTIPLY 	; R6 is 10 for the adding of the same number
			NEXTPLUS 			; NEXTPLUS loop
				ADD R4, R4, R1 	; Adding the number 10 times
				ADD R6, R6, #-1 ; Decrementing count
				BRp NEXTPLUS 	; Loop goes through 10x
			ADD R3, R1, #0
			CHECK1
			GETC 				
			OUT
			LD R6, newLine
			NOT R6, R6
			ADD R6, R6, #1
			ADD R2, R0, R6 		; Checks to see if the char inputted is the newline character
			BRz NEXTPART 		; Goes to NEXTPART if R0 is the newline character
			F_CHECK 			; First Check
				LD R2, ZERO
				NOT R2, R2
				ADD R2, R2, #1
				ADD R2, R0, R2
				BRzp S_CHECK 	; Goes to Second Check
			BR ERROR_1 			; Goes to Error if first check fails
			S_CHECK 			; Second Check
				LD R2, NINE
				NOT R2, R2
				ADD R2, R2, #1
				ADD R2, R0, R2 	
				BRnz CONTINUE 	; Goes to CONTINUE checkmark
			BR ERROR_1 			; Goes to Error if second check fails
			CONTINUE 			; CONTINUE checkmark
				LD R2, ZERO
				NOT R2, R2
				ADD R2, R2, #1
				ADD R0, R0, R2 	; Subtract R0 with ASCII '0'
				ADD R4, R4, R0 	; Save R0 value into R4
				ADD R1, R4, #0 	; Save R0 value into R1
				ADD R3, R1, #0  ; Save R0 value into R3
				ADD R5, R5, #-1 ; Decrement count
				BRp REPSTEP 	; Continue loop to REPSTEP
		ADD R1, R4, #0 			; Puts the R4 value into R1
		BR IF_STATEMENT_END 		; Goes to end

		ERROR_1
			LEA R0, error_loop
			PUTS
			BR CHECK1

		ERROR_2
			LEA R0, error_loop
			PUTS
			BR CHECK2
MINUSLOOP
	GETC
	OUT
	LD R6, newLine
	NOT R6, R6
	ADD R6, R6, #1
	ADD R5, R0, R6
	BRz ERROR_2				; ERROR Check
	FR_CHECK 				; First Check
		LD R1, ZERO
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R0, R1
		BRzp SC_CHECK 		; Goes to Second Check
	BR ERROR_2 				; Goes to Error if first check fails
	SC_CHECK 				; Second Check
		LD R2, NINE
		NOT R2, R2
		ADD R2, R2, #1
		ADD R2, R0, R2
		BRnz CNT 			; Goes to CNT checkmark
	BR ERROR_2 				; Goes to Error if second check fails
	CNT 					; CNT checkmark
	LD R2, ZERO
	NOT R2, R2
	ADD R2, R2, #1
	ADD R0, R0, R2 			; Subtract R0 with ASCII '0'
	ADD R4, R0, #0 			; Save R0 value into R4
	ADD R1, R0, #0 			; Save R0 value into R1
	LD R5, NUM_4 			; R5 Count
	REPSTEP2
		LD R6, MULTIPLY 	; R6 is 10 for the adding of the same number
		NEXTPLUS2 			; NEXTPLUS loop
			ADD R4, R4, R1 	; Adding the number 10 times
			ADD R6, R6, #-1 ; Decrementing count
			BRp NEXTPLUS2 	; Loop goes through 10x
		ADD R3, R1, #0
		CHECK2
		GETC
		OUT
		LD R6, newLine
		NOT R6, R6
		ADD R6, R6, #1
		ADD R2, R0, R6
		BRz NEXTPARTMINUS 	; Checks if R0 is the newline character
		ONE_CHECK 			; First Check
			LD R2, ZERO
			NOT R2, R2
			ADD R2, R2, #1
			ADD R2, R0, R2
			BRzp TWO_CHECK  ; Goes to Second Check
		BR ERROR_2 			; Goes to Error if first check fails
		TWO_CHECK 			; Second Check
			LD R2, NINE
			NOT R2, R2
			ADD R2, R2, #1
			ADD R2, R0, R2
			BRnz NXTCONTINUE ; Goes to NXTCONTINUE checkmark
		BR ERROR_2 			; Goes to Error if second check fails 
		NXTCONTINUE 		; NXTCONTINUE checkmark
		LD R2, ZERO
		NOT R2, R2
		ADD R2, R2, #1
		ADD R0, R0, R2 		; Subtracting R0 with ASCII '0'
		ADD R4, R4, R0 		; Saving R0 value into R4 
		ADD R1, R4, #0 		; Saving R0 value into R1
		ADD R3, R1, #0 		; Saving R0 value into R3
		ADD R5, R5, #-1 	; Decrement Count
		BRp REPSTEP2 		; If positive go back to REPSTEP2
	NOT R4, R4 				; Invert R4
	ADD R4, R4, #1 			; Adding +1 for R4
	ADD R1, R4, #0 			; Saving the value into R1
	BR IF_STATEMENT_END 	; Goes to end

NEXTPART
	LD R6, DIVIDE 			; Need to subtract by the last number 10 times
	NOT R3, R3
	ADD R3, R3, #1
	POS_LOOP 				; POS_LOOP
		ADD R4, R4, R3 		; Subtracting R3 from R4
		ADD R6, R6, #-1
		BRp POS_LOOP
	ADD R1, R4, #0 			; Store value into R1
	BR IF_STATEMENT_END 	; Goes to end loop

NEXTPARTMINUS
	LD R6, DIVIDE 			; Need to add by the last number 10 times
	NOT R3, R3
	ADD R3, R3, #1
	NEG_LOOP 				; NEG_LOOP
		ADD R4, R4, R3
		ADD R6, R6, #-1
		BRp NEG_LOOP
	ADD R1, R4, #0 			; Store value into R1
	NOT R1, R1 				; Invert R1
 	ADD R1, R1, #1 			; Adding +1 into R1
IF_STATEMENT_END

LD R0, newLine
OUT

	LD R2, R2_BACKUP_3200
	LD R7, R7_BACKUP_3200

	RET

R2_BACKUP_3200 .BLKW #1
R7_BACKUP_3200 .BLKW #1
PLUS .FILL #43
MINUS .FILL #45
newLine .FILL x0A
NUM_4 .FILL #4
MULTIPLY .FILL #9
DIVIDE .FILL #9
SPACE .FILL x20
ZERO .FILL #48
NINE .FILL #57

prompt .STRINGZ "Input a positive or negative decimal number (max 5 digits), followed by ENTER: \n"
error .STRINGZ "Error: Please enter a sign '+', sign '-', or numerical digit: \n"
error_loop .STRINGZ "Error: Please enter a numerical digit: \n"

.orig x3400

MULTIPLYNUMS

ST R1, R1_BACKUP_3400
ST R2, R2_BACKUP_3400
ST R7, R7_BACKUP_3400

ADD R1, R1, #0
BRz EQUALSZERO 		; If R1 is zero
BRn FORNEGATIVE 	; If R1 is negative
ADD R2, R2, #0
BRz EQUALSZERO  	; If R2 is zero
BRn FORNEGATIVE2 	; If R2 is negative

NOT R3, R1 			; Subtract R1 from R2
ADD R3, R3, #1

ADD R5, R2, R3
BRp largerNumberPos 	; If positive R2 is larger, R1 is smaller
BRn smallerNumberPos 	; If negative R2 is smaller, R1 is larger
BRz sameNumber 			; If R1 and R2 are the same number

FORNEGATIVE 		; R1 is negative
ADD R2, R2, #0
BRn FORNEGATIVEBOTH ; Check if R2 is also negative
BRz EQUALSZERO 		; Check if R2 is zero

ADD R5, R1, R2
BRp largerNumberNeg 	; R2 is larger, R1 is smaller
BRn smallerNumberNeg 	; R1 is larger, R2 is smaller

FORNEGATIVE2
ADD R5, R1, R2 			
BRp largerNumberNeg2 	; R1 is larger, R2 is smaller
BRn smallerNumberNeg2 	; R2 is larger, R1 is smaller

FORNEGATIVEBOTH
NOT R3, R1 	
ADD R3, R3, #1

ADD R5, R2, R3
BRn largerNumberPos 	; R2 is larger, R1 is smaller
BRp smallerNumberPos 	; R1 is larger, R2 is smaller
BRz sameNumber 			; R1 and R2 are the same

largerNumberPos 	;R2 is larger, R1 is smaller
ADD R1, R1, #0
BRn CONVERTR1
CHECK_1
ADD R2, R2, #0
BRn CONVERTR2
CHECK_2

ADD R4, R2, #0
ADD R1, R1, #-1
BRnz SKIPSTEP2
FOR_LOOP
	ADD R2, R2, R4
	ADD R2, R2, #0
	BRn OVERFLOW
	ADD R1, R1, #-1
	BRp FOR_LOOP
SKIPSTEP2
ADD R3, R2, #0
BR PRINTTHIS

largerNumberNeg 	;R2 is larger, R1 is smaller
NOT R1, R1
ADD R1, R1, #1
ADD R4, R2, #0
ADD R1, R1, #-1
BRnz SKIPSTEP1
FOR_LOOP_1 			; Smart ADD
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

largerNumberNeg2	;R1 is larger, R2 is smaller
NOT R2, R2
ADD R2, R2, #1
ADD R3, R1, #0
ADD R2, R2, #-1
BRnz SKIPSTEP
FOR_LOOP_2			; Smart ADD
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

smallerNumberPos 	;R1 is larger, R2 is smaller
ADD R1, R1, #0
BRn CONVERTR1_2
CHECK_1_2
ADD R2, R2, #0
BRn CONVERTR2_2
CHECK_2_2

ADD R3, R1, #0
ADD R2, R2, #-1
BRnz SKIPSTEP3
FOR_LOOP_3			; Smart ADD
	ADD R1, R1, R3
	ADD R1, R1, #0
	BRn OVERFLOW
	ADD R2, R2, #-1
	BRp FOR_LOOP_3
SKIPSTEP3
ADD R3, R1, #0
BR PRINTTHIS

smallerNumberNeg 	;R1 is larger, R2 is smaller
ADD R1, R1, #0
BRn CONVERTR1_23
CHECK1_23
ADD R3, R1, #0
ADD R2, R2, #-1
BRnz SKIPSTEP4
FOR_LOOP_4			; Smart ADD
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

smallerNumberNeg2 	;R2 is larger, R1 is smaller
ADD R2, R2, #0
BRn CONVERTR2_23
CHECK2_23
ADD R4, R2, #0
ADD R1, R1, #-1
BRnz SKIPSTEP5
FOR_LOOP_5			; Smart ADD
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

sameNumber 	;R1 and R2 are the same
ADD R1, R1, #0
BRn CONVERTR1_3
CHECK1_3
ADD R2, R2, #0
BRn CONVERTR2_3
CHECK2_3
ADD R3, R1, #0
ADD R2, R2, #-1
BRnz SKIPSTEP6
FOR_LOOP_6			; Smart ADD
	ADD R1, R1, R3
	ADD R1, R1, #0
	BRn OVERFLOW
	ADD R2, R2, #-1
	BRp FOR_LOOP_6
SKIPSTEP6
ADD R3, R1, #0
BR PRINTTHIS

OVERFLOW
LEA R0, overflowissue
PUTS
BR MULTIPLYNUMS_END

CONVERTR1 		;Converting without same name
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

PRINTTHIS 	; Calls Subroutine for Print
	ADD R1, R3, #0
	LD R6, SUBROUTINEPRINT
	JSRR R6
MULTIPLYNUMS_END

LD R1, R1_BACKUP_3400
LD R2, R2_BACKUP_3400
LD R7, R7_BACKUP_3400

RET

R1_BACKUP_3400 .BLKW #1
R2_BACKUP_3400 .BLKW #1
R7_BACKUP_3400 .BLKW #1
myNewLine .FILL x0A
DEC_0 .FILL #0
overflowissue .STRINGZ "OVERFLOW!\n"
SUBROUTINEPRINT .FILL x3600

.orig x3600

ST R1, BACKUP_R1_3600
ST R2, BACKUP_R2_3600
ST R3, BACKUP_R3_3600
ST R4, BACKUP_R4_3600
ST R7, BACKUP_R7_3600

LD R6, COUNT

ADD R1, R1, #0
BRn NEGATIVEPRINT 	
LD R0, PLUSSIGN 	; '+' sign
OUT
BR SKIP

NEGATIVEPRINT
LD R0, MINUSSIGN 	; '-' sign
OUT
NOT R1, R1
ADD R1, R1, #1

SKIP
LD R3, COUNT
LD R2, SUBTRACT5
LD R5, ZEROPLUS

FOR1_LOOP 			; -10000
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
FOR2_LOOP 			; -1000
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
FOR3_LOOP 			; -100
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
FOR4_LOOP 			; -10
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

ADD R0, R1, R5    ; Print for single digits regardless
OUT

LD R0, PRINTSPACE
OUT

LD R1, BACKUP_R1_3600
LD R2, BACKUP_R2_3600
LD R3, BACKUP_R3_3600
LD R4, BACKUP_R4_3600
LD R7, BACKUP_R7_3600

RET

BACKUP_R1_3600 .BLKW #1
BACKUP_R2_3600 .BLKW #1
BACKUP_R3_3600 .BLKW #1
BACKUP_R4_3600 .BLKW #1
BACKUP_R7_3600 .BLKW #1
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