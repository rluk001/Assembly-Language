;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 02
; Lab section: 022
; TA: Bryan Marsh
;=================================================
.orig x3000
;--------------
; Instructions
;--------------
	LD R5, DEC_65
	LD R6, HEX_41
	
	LDR R3, R5, #0	;R3 <-- #65
	LDR R4, R6, #0	;R4 <-- x41
	
	ADD R3, R3, #1
	ADD R4, R4, #1
	
	STR R3, R5, #0
	STR R4, R6, #0

	HALT
	;------------
	; Local Data
	;------------
	DEC_65	.FILL x4000
	HEX_41 .FILL x4001
		
	;------------
	; Remote Data
	;------------
	.orig x4000
	NEW_DEC_65	.FILL #65	;put #65 into memory here
	NEW_HEX_41	.FILL x41	;put #41 into memory here
	
.END
