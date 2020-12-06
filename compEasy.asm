	extern printf
	extern drawBoard
	extern randomNum
	extern askLocation
	extern checkWinner
	
        section .data
	
array:		db "                "

test:		db "test",0
print:	       db "test fun"
	
false:		equ 0
true:		equ 1
winner:		db false
	
fmt:		db "%s",10,0
        section .bss

test1:		resb 2
numMoves:	resq 1
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
	
	inc byte[numMoves]

	;; cpu's location is set
	xor rdi,rdi
	xor rsi,rsi
	
	mov rdi,16
	mov rsi,array
	call randomNum

	
	;mov rdi,array ;setting first parameter in check winner to array

	inc byte[numMoves]
	
	mov rdi,array
	mov rsi,numMoves
	call checkWinner
	
	; cmp byte[winner],2

	; jne compEasy

	
	cmp byte[numMoves],16
	jle compEasy
	cmp byte[numMoves],16
	je print1
	xor rax,rax
	
	ret
	;; not finished yet, need to determine who wins,0-no winner 1-almost winner
	;; 2-player wins 3-comp wins 4-tie/board filled, keep track of moves made <= 16
	
testing:
	mov rax,1
	mov rdi,1
	mov rsi,print
	mov rdx,1
	ret
	
print1:
	mov rax,1
	mov rdi,1
	mov rsi,[numMoves]
	mov rdx,1
	syscall
	


        
