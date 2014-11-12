;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 03
; Lab section: 022
; TA: Bryan Marsh
;=================================================
.orig x3000
;--------------
; Instructions
;--------------
	LD R5, DATA_PTR
		
	LDR R3, R5, #0
	LDR R4, R5, #1	
		
	ADD R3, R3, #1
	ADD R4, R4, #1
	
	STR R3, R5, #0
	STR R4, R5, #1

	HALT
	;------------
	; Local Data
	;------------
	DATA_PTR .FILL x4000
			
	;------------
	; Remote Data
	;------------
	.orig x4000
	NEW_DEC_65	.FILL #65	;put #65 into memory here
	NEW_HEX_41	.FILL x41	;put #41 into memory here
	
.END
