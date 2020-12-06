	section .data
new_line:	db	10
	section .bss
	
num_b:		resb	2
	section .text
	global randomNum 
randomNum:
	;; parameters goes as follow: rdi,rsi,rdx,rcx,r8,r9
	;; rdi = int max, rsi = array, rdx = seed
	xor r8,r8 		; r8 = random_seed
	xor r9,r9		; r9 = seed
	xor r11,r11
	xor r12,r12
	
	xor rdx,rdx
	xor rax,rax
	
	RDRAND r9
	mov r8,0
	
	mov rax,1103515245
	
	add r8,r9		; random_seed + seed
	mul r8			; r8(random_seed + seed) * rax(1103515245)

	mov r8,rax		; storing result in r8
	add r8,12345		; random_seed
	
	xor rdx,rdx
	xor rax,rax
	xor rbx,rbx
	
	mov rax,r8
	mov rbx,65536		; rax = random_seed / 65536
	div rbx
	
	mov r8,rdi		; max val + 1
	inc r8

	xor rdx,rdx
	div r8			; (random_seed / 65536) % (max + 1) value is in rdx

	xor r12,r12
	mov r12,rdx
	dec r12
	xor rax,rax
	mov rax,r12 ;return random num from 1-16
	ret

