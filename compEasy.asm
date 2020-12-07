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

	mov [test],eax
	
	push rbp
	mov rbp,rsp
	mov rdi,fmt
	mov rsi,[test]
	mov rax,0

	call printf
	pop rbp

	cmp r14b,0
	je get_random_val
	
	cmp r14b,2
	je quit
	
	cmp r14b,3
	je quit
		
	jmp ai_mode 
	
ai_mode:
	xor rdi,rdi
	xor rsi,rsi
	
	mov rdi,array
	mov rsi,r12
	
	call o_marks_the_spot
	
	jmp compEasy
	
get_random_val:
;;;  cpu's location is set
	;; xor rdi,rdi
	;; xor rsi,rsi

	;; mov rdi,16
	;; mov rsi,array
	;; call randomNum
	
	
quit:
	
	ret
        
