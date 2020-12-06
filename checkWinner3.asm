	
	section .data
printX: db "X Won!",10
len_X:  equ $-printX
printO: db "COMPUTER WINS!",10
len_O:  equ $-printO
	section .bss
winner: resb 1
	section .text
	global checkWinner3
checkWinner3:

	xor r15,r15
	mov r15,rdi 		;r15 point to board array at begining r15=board[0]
	cmp byte[r15],120
	je row1X
	cmp byte[r15],111
	je row1O
	cmp byte[r15],32
	je row2X
	
	
row1X:
		xor r14,r14
		xor r13,r13
		xor r12,r12
		mov r14,r15
		add r14,1
		cmp byte[r14],120
		jne row1O
		mov r13,r15
		add r13,2
		cmp byte[r13],120
		jne row1O
		mov r12,r15
		add r12,3
		cmp byte[r12],120
		je WonUser
row1O:
		xor r14,r14
		xor r13,r13
		xor r12,r12
		mov r14,r15
		add r14,1
		cmp byte[r14],111
		jne row2X
		mov r13,r15
		add r13,2
		cmp byte[r13],111
		jne row2X
		mov r12,r15
		add r12,3
		cmp byte[r12],111
		je WonComp
row2X:
		xor r14,r14
		xor r13,r13
		xor r12,r12
		xor r11,r11
		mov r11,r15
		add r11,4
		cmp byte[r11],120
		jne row2O
		mov r14,r11
		add r14,1
		cmp byte[r14],120
		jne row2O
		mov r13,r11
		add r13,2
		cmp byte[r13],120
		jne row2O
		mov r12,r11
		add r12,3
		cmp byte[r12],120
		je WonUser
row2O:
		xor r14,r14
		xor r13,r13
		xor r12,r12
		cmp byte[r11],111
		jne row3X
		mov r14,r11
		add r14,1
		cmp byte[r14],111
		jne row3X
		mov r13,r11
		add r13,2
		cmp byte[r13],111
		jne row3X
		mov r12,r11
		add r12,3
		cmp byte[r12],111
		je WonComp
row3X: ;add 8 not 4
		xor r14,r14
		xor r13,r13
		xor r12,r12
		mov r11,r15
		add r11,8
		cmp byte[r11],120
		jne row3O
		mov r14,r11
		add r14,1
		cmp byte[r14],120
		jne row3O
		mov r13,r11
		add r13,2
		cmp byte[r13],120
		jne row3O
		mov r12,r11
		add r12,3
		cmp byte[r12],120
		je WonUser
row3O:
		xor r14,r14
		xor r13,r13
		xor r12,r12
		cmp byte[r11],111
		jne row4X
		mov r14,r11
		add r14,1
		cmp byte[r14],111
		jne row4X
		mov r13,r11
		add r13,2
		cmp byte[r13],111
		jne row4X
		mov r12,r11
		add r12,3
		cmp byte[r12],111
		je WonComp
row4X:
		xor r14,r14
		xor r13,r13
		xor r12,r12
		mov r11,r15
		add r11,12
		cmp byte[r11],120
		jne row4O
		mov r14,r11
		add r14,1
		cmp byte[r14],120
		jne row4O
		mov r13,r11
		add r13,2
		cmp byte[r13],120
		jne row4O
		mov r12,r11
		add r12,3
		cmp byte[r12],120
		je WonUser
row4O:
		xor r14,r14
		xor r13,r13
		xor r12,r12
		cmp byte[r11],111
		jne col1X
		mov r14,r11
		add r14,1
		cmp byte[r14],111
		jne col1X
		mov r13,r11
		add r13,2
		cmp byte[r13],111
		jne col1X
		mov r12,r11
		add r12,3
		cmp byte[r12],111
		je WonComp
col1X:
		
		xor r14,r14
		xor r13,r13
		xor r12,r12
		xor r11,r11
		
		mov r14,r15
		
		cmp byte[r14],120
		jne col1O
		mov r13,r14
		add r13,4
		cmp byte[r13],120
		jne col1O
		mov r12,r14
		add r12,8
		cmp byte[r12],120
		jne col1O
		mov r11,r14
		add r11,r12
		cmp byte[r12],120
		je WonUser
col1O:
		ret
		
WonUser:
	xor rax,rax
	mov rax,1
	mov rdi,1
	mov rsi,printX
	mov rdx,len_X
	syscall
	jmp finish
WonComp:
	xor rax,rax
	mov rax,1
	mov rdi,1
	mov rsi,printO
	mov rdx,len_O
	syscall	
	jmp finish
finish:
	xor rax,rax
	mov rax,1
	ret
		
	
		
	