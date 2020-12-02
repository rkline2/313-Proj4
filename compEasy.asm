	extern drawBoard
	extern randomNum
	extern askLocation
	extern checkWinner
	
        section .data
	
array:	 db "                "

false:		equ 0
true:		equ 1
winner:	 db 	false
        section .bss
	
	section .text
	global compEasy
        
        
compEasy:
	;; parameters goes as follow: (rdi,rsi,rdx,rcx,r8,r9)
	;; rax value is returned

	;; printBoard(array)
	xor r10,r10
	xor rdi,rdi
	
        mov rdi,array
	
        call drawBoard

	;; askLocation()
	mov rdi,array
        call askLocation
	xor rbx,rbx
	mov rbx,rax 		;return value from ask location

	;; player's location is set  
	xor r10,r10		;char pointer to beg. of array
	mov r10,array
	
	dec rbx
	
	add r10,rbx		;pointing to position in array
	mov byte[r10],120		;r10='x'

	;; cpu's location is set
	call randomNum
	
	xor rbx,rbx
	mov rbx,rax		;rtn value from randomNum
	xor r10,r10

	mov r10,array
	add r10,rbx
	mov byte[r10],111		;r10='o'

	mov rdi,[array]		;setting first parameter in check winner to array

	call checkWinner
	
	mov [winner],al

	cmp byte[winner],1
	jne compEasy		;while !winner

	xor rax,rax		
	ret
	;; not finished yet, need to determine who wins,0-no winner 1-almost winner
	;; 2-player wins 3- comp wins 4-tie/board filled, keep track of moves made <= 16
	
	
	
	


        
