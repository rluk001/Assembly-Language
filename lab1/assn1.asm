;=================================================
; Name: Ryan Luk
; Username: rluk001
; 
; Assignment name: Assignment 01
; Lab section: 022
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

;-------------------------------------------------
;REG VALUES 	R0	R1	R2	R3	R4	R5	R6	R7
;-------------------------------------------------
;Pre-loop		0	6	12	0	0	0	0	1168
;Iteration 01	0	5	12	12	0	0	0	1168
;Iteration 02	0	4	12	24	0	0	0	1168
;Iteration 03	0	3	12	36	0	0	0	1168
;Iteration 04	0	2	12	48	0	0	0	1168
;Iteration 05	0	1	12	60	0	0	0	1168
;Iteration 06	0	0	12	72	0	0	0	1168
;End of Program 0	0	12	72	0	0	0	DEC_0
;-------------------------------------------------

.ORIG x3000
;--------------
; Instructions
;--------------
	LD R1, DEC_6	; R1 <-- #6
	LD R2, DEC_12	; R2 <-- #12
	LD R3, DEC_0	; R3 <-- #0
	
	DO_WHILE_LOOP
		ADD R3, R3, R2				; R1 <-- R1 + R2
		ADD R1, R1, #-1				; R3 <-- R3 - #1
		BRp DO_WHILE_LOOP			; if (R3 > 0): goto DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	HALT							; halt program (like exit() in C++)
	;------------
	; Local Data
	;------------
	DEC_0 	.FILL #0				; put #0 into memory here
	DEC_6 	.FILL #6				; put #6 into memory here
	DEC_12 	.FILL #12				; put #12 into memory here
.END
