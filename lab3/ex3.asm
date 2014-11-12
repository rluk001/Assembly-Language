;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 03
; Lab section: 022
; TA: Bryan Marsh
;=================================================
.orig x3000
LEA R0, prompt
PUTS

LD R1, TEN
LEA R2, ARRAY_1

loop
GETC
OUT
STR R0, R2, #0
ADD R2, R2, #1
ADD R1, R1, #-1
BRp loop
loop_END
LD R0, newLine
OUT


LD R1, TEN
LEA R2, ARRAY_1
myLoops
LDR R0, R2, #0
OUT
ADD R2, R2, #1
LD R0, newLine
OUT
ADD R1, R1, #-1
BRp myLoops
myLoops_END

HALT


;--------------
;-----DATA_----
;--------------
ARRAY_1 .BLKW #10
TEN .FILL #10
newLine .FILL x0A
prompt .STRINGZ "Please enter 10 letters: "
.END
