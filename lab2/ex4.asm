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

	LD R0, HEX_61
	LD R1, HEX_1A
	
	FOR_LOOP
		OUT
		ADD R0, R0, #1
		ADD R1, R1, #-1
		BRp FOR_LOOP
			
	END_FOR_LOOP
	HALT
	;------------
	; Local Data
	;------------
	HEX_61	.FILL x61	;put x61 into memory here
	HEX_1A	.FILL x1A	;put x1A into memory here
	
.END

