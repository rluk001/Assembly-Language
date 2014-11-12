;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 01
; Lab section: 022
; TA: Bryan Marsh
;=================================================

.ORIG x3000
;--------------
; Instructions
;--------------

	LEA R0, MSG_TO_PRINT ;R0 <-- the location of the label: MSG_TO_PRINT
	PUTS 				 ;Prints string defined at MSG_TO_PRINT
	
	HALT				 ;terminate program
;------------
; Local Data
;------------
	MSG_TO_PRINT .STRINGZ "HELLO WORLD!!!\n" 
							;store 'H' in an address labeled
							;MSG_TO_PRINT and then each
							;character ('e','l','l','o','', 'w', ...) in
							;it's own (consecutive) memory
							;address, followed by #0 at the end
							;of the string to mark the end of the
							 ;string
.END
