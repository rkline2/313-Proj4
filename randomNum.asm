	section .data
new_line:	db	10
	section .bss
	
num_b:		resb	2
	section .text
	global randomNum 
randomNum:
	;; parameters goes as follow: rdi,rsi,rdx,rcx,r8,r9
	;; rdi = int seed ; rsi = int max
	xor r8,r8 		; r8 = random_seed
	xor r9,r9
	xor rdx,rdx
	xor rax,rax
	
	mov rax,1103515245
	mov r9,rdi
	
	add r8,r9		; random_seed + seed
	mul r8			; r8(random_seed + seed) * rax(1103515245)

	mov r8,rax		; storing result in r8
	add r8,12345		; random_seed
	
	xor rdx,rdx
	xor rax,rax
	xor rbx,rbx
	
	mov rax,r8
	mov rbx,65536		; random_seed / 65536
	div rbx
	
	mov r8,rsi		; max val
	inc r8

	xor rdx,rdx
	div r8			; (random_seed / 65536) % (max + 1)

	mov rax,rdx		; value gets returned
				; Optional: convert to ascii before returning value  
	ret

