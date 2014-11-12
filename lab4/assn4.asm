;=================================================
; Name: Luk, Ryan	
; Username: rluk001
; 
; Assignment name: Assignment 4
; Lab section: 022
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;=================================================
.orig x3000

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
		BRz ERROR 			; Goes to ERROR loop
		FIR_CHECK 			; First Check
			LD R1, ZERO
			NOT R1, R1
			ADD R1, R1, #1
			ADD R1, R0, R1
			BRzp SEC_CHECK  ; Goes to Second Check
		BR ERROR 			; Goes to Error if first check fails
		SEC_CHECK 			; Second Check
			LD R2, NINE
			NOT R2, R2
			ADD R2, R2, #1
			ADD R2, R0, R2
			BRnz NEXTCNT 	; Goes to NEXTCNT which means R0 is a number
		BR ERROR 			; Goes to Error if second check fails
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
			BR ERROR 			; Goes to Error if first check fails
			S_CHECK 			; Second Check
				LD R2, NINE
				NOT R2, R2
				ADD R2, R2, #1
				ADD R2, R0, R2 	
				BRnz CONTINUE 	; Goes to CONTINUE checkmark
			BR ERROR 			; Goes to Error if second check fails
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

MINUSLOOP
	GETC
	OUT
	LD R6, newLine
	NOT R6, R6
	ADD R6, R6, #1
	ADD R5, R0, R6
	BRz ERROR 				; ERROR Check
	FR_CHECK 				; First Check
		LD R1, ZERO
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R0, R1
		BRzp SC_CHECK 		; Goes to Second Check
	BR ERROR 				; Goes to Error if first check fails
	SC_CHECK 				; Second Check
		LD R2, NINE
		NOT R2, R2
		ADD R2, R2, #1
		ADD R2, R0, R2
		BRnz CNT 			; Goes to CNT checkmark
	BR ERROR 				; Goes to Error if second check fails
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
		BR ERROR 			; Goes to Error if first check fails
		TWO_CHECK 			; Second Check
			LD R2, NINE
			NOT R2, R2
			ADD R2, R2, #1
			ADD R2, R0, R2
			BRnz NXTCONTINUE ; Goes to NXTCONTINUE checkmark
		BR ERROR 			; Goes to Error if second check fails 
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

HALT

PLUS .FILL #43
MINUS .FILL #45
newLine .FILL x0A
NUM_4 .FILL #4
MULTIPLY .FILL #9
DIVIDE .FILL #9
SPACE .FILL x20
ZERO .FILL #48
NINE .FILL #57

prompt .STRINGZ "Input a positive or negative decimal number (max 5 digits), followed by ENTER: "
error .STRINGZ "Error: Please enter a sign '+', sign '-', or numerical digit: "

.END