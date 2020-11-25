
	extern randomNum
	extern menu
	extern compEasy
	extern compHard

	section .data
new_line:	       db      10
easy:		       db      'a'
hard:		       db      'b'
quit:		       db      'q'

	section .bss
num_buff:	resq 2
menu_input:	resb 1
	
	section .text
	
	global main
main:

	call menu
	mov [menu_input],al
	cmp byte[menu_input],easy
	jne  else_if
	call compEasy
	jmp main	
	
else_if:
	cmp byte[menu_input],hard
	jne exit
	call compHard
	jmp main
	
exit:
	mov rax,0
	ret
