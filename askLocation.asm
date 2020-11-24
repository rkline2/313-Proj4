	section	.data
loc_prompt:     db "Enter a location on the board 1-16"
len_p:          equ $-loc_prompt

	section .bss
	section .text
	global askLocation
askLocation:
	
