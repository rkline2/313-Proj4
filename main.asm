	extern menu
	extern compEasy
	extern compHard

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
	xor r15,r15
	call menu
	mov byte[menu_input],al

	cmp byte[menu_input],97
	je goEasy
	
	cmp byte[menu_input],98
	je goHard
	
	jmp exit

goEasy:
	call compEasy
	jmp main

goHard:
	call compHard
	jmp main
exit:
	xor rax,rax
	mov rax,60
	xor rdi,rdi
	syscall
	
