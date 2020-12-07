	extern printf
	extern drawBoard
	extern randomNum
	extern askLocation
	extern checkWinner
	extern o_marks_the_spot
	
        section .data
	
array:		db "                "
p_wins:		db "player wins!",0
c_wins:		db "cpu wins!",0
tie_msg:	db "no winner!",0
	
fmt:		db "%d",10,0
fmt_s:		db "%s",10,0
        section .bss
test:		resd 1
winner:		resb 1
num_moves:	resb 1
	section .text
	global compEasy
compEasy:	
        mov byte[num_moves],0
	jmp PlayItOut
PlayItOut:
	;; parameters goes as follow: (rdi,rsi,rdx,rcx,r8,r9)
	;; rax value is returned

;;   printBoard(array)
	xor rdi,rdi
	mov rdi,array
	call drawBoard
	
;; checkwinner ******************** checkwinner 
	xor r12,r12
	xor r14,r14
	xor r13,r13

	xor rdi,rdi
	mov rdi,array

	call checkWinner
	mov r12,rax
	mov r14,rax

	; mov [test],eax 	;testing only!
	; push rbp 		;testing only!
	; mov rbp,rsp		;testing only!
	; mov rdi,fmt		;testing only!
	; mov rsi,[test]	;testing only!
	; mov rax,0		;testing only!
	; call printf		;testing only!
	; pop rbp		;testing only!
	

	cmp r14b,2
	je player_wins

	cmp r14b,3
	je cpu_wins

	cmp byte[num_moves],16
	jge tie_break

;;  checkwinner ******************** checkwinner



;;  askLocation(array)
	xor rdi,rdi
	mov rdi,array
	call askLocation

	inc byte[num_moves]
;;   checkwinner ******************** checkwinner
	xor r12,r12
	xor r13,r13
	xor r14,r14
	
	xor rdi,rdi
	mov rdi,array
	
	call checkWinner
        mov r12,rax
	mov r14,rax

	
	;;  mov [test],eax        ;testing only!
	;;  mov [test],eax        ;testing only!
	;;  push rbp              ;testing only!
	;;  mov rbp,rsp           ;testing only!
	;;  mov rdi,fmt           ;testing only!
	;;  mov rsi,[test]        ;testing only!
	;;  mov rax,0             ;testing only!
	;;  call printf           ;testing only!
	;;  pop rbp               ;testing only!
	
	
	cmp r14b,2
	je player_wins
	
	cmp r14b,3
	je cpu_wins

	cmp byte[num_moves],16
	jge tie_break
		
	jmp get_random_val 
;;   checkwinner ******************** checkwinner

ai_mode:
	xor rdi,rdi
	xor rsi,rsi
	
	mov rdi,array
	mov rsi,r12
	
	call o_marks_the_spot

	inc byte[num_moves]
	
	jmp PlayItOut
	
get_random_val:
;;;  cpu's location is set
	xor rdi,rdi
	xor rsi,rsi

	mov rdi,16
	mov rsi,array
	call randomNum

	inc byte[num_moves]
	
	jmp PlayItOut
	
player_wins:
	push rbp		
	mov rbp,rsp	
	mov rdi,fmt_s	
	mov rsi,p_wins	
	mov rax,0	

	call printf	
	pop rbp
	
	jmp quit
cpu_wins:
	push rbp
	mov rbp,rsp
	mov rdi,fmt_s
	mov rsi,c_wins
	mov rax,0

	call printf
	pop rbp

	jmp quit

tie_break:
	push rbp
	mov rbp,rsp
	mov rdi,fmt_s
	mov rsi,tie_msg
	mov rax,0

	call printf
	pop rbp
	
	jmp quit
quit:
	
	ret
        
