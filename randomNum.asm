	section .data

	section .bss
	
num_b:	resb	2
	
	section .text
maxrand:
	;; parameters goes as follow: rdi,rsi,rdx,rcx,r8,r9
	;; rdi = int seed ; rsi = int max
	xor r8,r8
	mov rax,1103515245
	
	add r8,rdi		; seed
	mul r8
	add r8,12345
	
	xor rdx,rdx
	xor rax,rax
	xor rbx,rbx
	
	mov rax,r8
	mov rbx,65536		; random_seed / 65536
	div rbx

	inc rsi			; max val

	div rsi			; (random_seed / 65536) % (max + 1)

	mov rax,rdx		; value gets returned

	mov [num_b],al
	
	mov rax,1
	mov rdi,1
	mov rsi,num_b
	mov rdx,2
	syscall
	
	ret

