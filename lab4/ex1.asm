;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 04
; Lab section: 022
; TA: Bryan Marsh
;=================================================
.orig x3000

LD R6, ZERO
LD R1, ARRAY_1
LD R4, ARRAY_1
LD R3, NINE

FOR
	STR R6, R1, #0
	ADD R1, R1, #1
	ADD R6, R6, #1		
	ADD R3, R3, -1
	BRzp FOR
FOR_END

ADD R4, R4, #6
LDR R2, R4, #0
HALT

NINE .FILL #9
ZERO .FILL #0
ARRAY_1 .FILL x4000
.orig x4000 
.BLKW #10

.END
