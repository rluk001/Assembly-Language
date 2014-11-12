;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 05
; Lab section: 022
; TA: Bryan Marsh
;=================================================
.orig x3000

LD R6, SUB_GET_NUM
JSRR R6

ADD R2, R1, #0

HALT

SUB_GET_NUM .FILL x3200

.orig x3200

ST R7, BACKUP_R7_3200

GETC
OUT	

LD R1, ZERO_MINUS
LD R2, NINE
NOT R1, R1
ADD R1, R1, #1
ADD R1, R0, R1
ADD R3, R1, #0
ADDLOOP
	ADD R1, R1, R3
	ADD R2, R2, #-1
	BRp ADDLOOP

GETC
OUT

LD R2, ZERO_MINUS
NOT R2, R2
ADD R2, R2, #1
ADD R4, R0, R2
ADD R1, R1, R4

LD R7, BACKUP_R7_3200

RET

ZERO_MINUS .FILL #48
NINE .FILL #9
BACKUP_R7_3200 .BLKW #1

.END
