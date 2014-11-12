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
	LD R3, DEC_65	;R3 <-- #65
	LD R4, HEX_41	;R4 <-- x41

	HALT
	;------------
	; Local Data
	;------------
	DEC_65	.FILL #65	;put #65 into memory here
	HEX_41	.FILL x41	;put #41 into memory here
	
.END
