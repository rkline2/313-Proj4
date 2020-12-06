	extern menu
	extern compEasy

	section .data
new_line:		       db      10
easy:			       db      'a'
hard:			       db      'b'
quit:			       db      'q'

	section .bss
num_buff:		resq 2
menu_input:		resb 1

	section .text

	global main
main:

	call compEasy
	jmp exit


exit:
	xor rax,rax
	mov rax,60
	xor rdi,rdi
	syscall
	
