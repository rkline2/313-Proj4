	extern printf
	extern drawBoard
	extern randomNum
	extern askLocation
	extern checkWinner
	
        section .data
	
array:		db "                "
	
        section .bss
winner:		resb 1
	section .text
	global compEasy
        
        
compEasy:
	;; parameters goes as follow: (rdi,rsi,rdx,rcx,r8,r9)	
	;; askLocation(array)
	xor rdi,rdi
	mov rdi,array ;pass in array into ask Location
    call askLocation

	;; cpu's location is set
	xor rdi,rdi
	xor rsi,rsi
	;pass in max and array into Random Num Generator
	mov rdi,16
	call randomNum
	;CPU move to random spot returned from RandomNum
	jmp compMove
continue:
	;call Draw Board to show CPU's move
	xor rdi,rdi
	mov rdi,array
	call drawBoard
	;setting first parameter in check winner to array
	xor rdi,rdi
	mov rdi,array
	call checkWinner
	;check if winner found, checkWinner returns 1 if so
	xor r14,r14
	mov r14b,al
	cmp r14b,1
	je quit
	;no winner found, continue playing
	jmp compEasy
compMove:
	mov r11,rax
	mov r12,array
	add r12b,r11b
	cmp byte[r12],32
	je cpuMove
	cmp byte[r12],32
	jne getAnotherRandomNum
cpuMove:
	mov byte[r12],111
	jmp continue
getAnotherRandomNum:
		call randomNum
		jmp compMove

quit:
	ret
        
