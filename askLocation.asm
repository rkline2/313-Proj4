	section	.data
loc_prompt:     db "Enter a location on the board 1-16"
len_p:          equ $-loc_prompt

	section .bss
location:	resb 3
	section .text
	global askLocation
askLocation:

	mov rax,1
	mov rdi,1
	mov rsi,loc_prompt
	mov rdx,len_p
	syscall

	mov rax,0
	mov rdi,0
	mov rsi,location
	mov rdx,3

	ret
	
