	extern printf
	extern drawBoard
	extern randomNum
	extern askLocation
	extern checkWinner3
	
        section .data
	
array:		db "                "
	
        section .bss
winner:		resb 1
	section .text
	global compEasy
        
        
compEasy:
	;; parameters goes as follow: (rdi,rsi,rdx,rcx,r8,r9)
	;; rax value is returned
	
	;; printBoard(array)
	
	
	
	;; askLocation(array)
	xor rdi,rdi
	mov rdi,array
        call askLocation

	;; cpu's location is set
	xor rdi,rdi
	xor rsi,rsi
	mov rdi,16
	mov rsi,array
	call randomNum

	
	;mov rdi,array ;setting first parameter in check winner to array
	xor rdi,rdi
	mov rdi,array
	call drawBoard
	xor rdi,rdi
	mov rdi,array
	call checkWinner3
	xor r14,r14
	mov r14b,al
	cmp r14b,1
	je quit
	jmp compEasy
	

quit:
	
	ret
        
