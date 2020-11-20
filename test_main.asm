extern maxrand

	section .data

	section .bss
num_buff:	resq 2
	
	section .text
	
	global main
main:
	RDRAND rdi
	mov rsi,16
	xor rax,rax
	call maxrand
	mov [num_buff],al

	mov rax,1
	mov rdi,1
	mov rsi,num_buff
	mov rdx,2
	syscall

	mov rax,0
	ret
