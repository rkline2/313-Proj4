	extern printf
	extern drawBoard
	extern randomNum
	extern askLocation
	extern checkWinner
	extern o_marks_the_spot
	
        section .data
	
array:		db "                "
fmt:		db "%d",10,0
	
        section .bss
test:		resd 1
winner:		resb 1
	section .text
	global compEasy
        
        
compEasy:
	;; parameters goes as follow: (rdi,rsi,rdx,rcx,r8,r9)
	;; rax value is returned
	
	;; printBoard(array)
	xor rdi,rdi
	mov rdi,array
	call drawBoard
	
	;; askLocation(array)
	xor rdi,rdi
	mov rdi,array
        call askLocation

	;; cpu's location is set
		;xor rdi,rdi
		;xor rsi,rsi
	
		;mov rdi,16
		;mov rsi,array
		;call randomNum

	xor r12,r12
	xor r14,r14
	xor r13,r13
	
	xor rdi,rdi
	mov rdi,array
	
	call checkWinner
	mov r12,rax
	mov r14,rax
	
	mov r13d,10
	
	xor rdx,rdx
	xor rax,rax
	
	mov eax,r14d
	div r13d
	
	xor r13,r13
	mov r13b,al

	cmp r13b,0
	jg ai_mode
	
	jmp compEasy
	
ai_mode:
	xor rdi,rdi
	xor rsi,rsi
	
	mov rdi,array
	mov rsi,r12
	
	call o_marks_the_spot
	
	jmp compEasy
quit:
	
	ret
        
