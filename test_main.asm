	extern randomNum

	section .data
new_line:	       db      10
	section .bss
num_buff:	resq 2
	
	section .text
	
	global main
main:
	RDRAND r8
	mov rdi,r8
	mov rsi,16
	xor rax,rax
	call randomNum

	add rax,97
	mov [num_buff],rax

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
