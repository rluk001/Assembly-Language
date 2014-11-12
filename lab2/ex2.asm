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
	LDI R3, DEC_65	;R3 <-- #65
	LDI R4, HEX_41	;R4 <-- x41
	
	ADD R3, R3, #1	;R3 <-- R3 + 1
	ADD R4, R4, #1	;R3 <-- R4 + 1
	
	STI R3, DEC_65	
	STI R4, HEX_41

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
