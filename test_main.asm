	extern randomNum
	extern menu

	section .data
new_line:	       db      10
	section .bss
num_buff:	resq 2
	
	section .text
	
	global main
main:

	call menu

	mov [num_buff],al

	mov rax,1
	mov rdi,1
	mov rsi,num_buff
	mov rdx,2
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,new_line
	mov rdx,1
	syscall

	mov rax,0
	ret
