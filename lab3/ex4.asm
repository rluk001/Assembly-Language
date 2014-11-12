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

LD R1, DEC_0
LD R2, ARRAY_1

loop
GETC
OUT
STR R0, R2, #0
ADD R2, R2, #1
ADD R1, R1, #1
ADD R0, R0, #0

LD R3, newLine
NOT R3, R3
ADD R3, R3, #1
ADD R0, R0, R3

BRp loop
loop_END

LD R0, newLine
OUT
ADD R1, R1, #-1
LD R2, ARRAY_1

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
DEC_0 .FILL #0
newLine .FILL x0A
ARRAY_1 .FILL x4000
prompt .STRINGZ "Please enter any sequence of characters: "
.END
