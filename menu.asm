	extern printf		
	extern scanf
	
	section .data
intro:		db "Welcome to TIC-TAC-ASSEMBLY",0
ask_route:	db "Pick an option from the menu below:",0
err:		db "Invalid Input!",0
	
opts:		db "a - Easy",10,"b - Hard",10,"q - quit", 10,0

fmt:		db "%s",10,0
fmt_scan:	db "%s",0	; the scanf format
	

	section .bss
lett_buff:	resq	1
	
	section .text
	global menu
menu:
	;; parameters goes as follow: rdi,rsi,rdx,rcx,r8,r9
	;; rax value is returned
	push rbp
	mov rbp,rsp

	;; printf("Welcome to TIC-TAC-ASSEMBLY\n")
	mov rdi,fmt
	mov rsi,intro
	mov rax,0
	call printf
	
	;; printf("Pick an option from the menu below:\n")
	mov rdi,fmt
	mov rsi,ask_route
	mov rax,0
	call printf

	;; displays all the options  
	mov rdi,fmt
	mov rsi,opts
	mov rax,0
	call printf

	;; scanf("%c")
	mov rdi,fmt_scan
	mov rsi,lett_buff
	mov rax,0
	

	push rbp
	call scanf
	pop rbp

	;; rbx = lett_buff
	xor rbx,rbx
	mov bl,[lett_buff]

	
	;; checks if input is valid
	cmp bl,97		; lett_buff == a?
	je quit

	cmp bl,98		; lett_buff == b?
	je quit

	cmp bl,113		; lett_buff == q?
	je quit


	;; print("Invalid Input!")
	mov rdi,fmt
	mov rsi,err
	mov rax,0
	call printf

	pop rbp
	

	;; repeat until input is valid
	jmp menu

	
quit:
	pop rbp

	;; rax = lett_buff
	mov al,[lett_buff]
	
	ret
	




