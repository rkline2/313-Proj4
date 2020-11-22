	extern scanf
	section .data
new_line:	db 10
intro:		db "Welcome to TIC-TAC-ASSEMBLY",10
ask_route:	db "Pick an option from the menu below:",10
err:		db "Invalid Input!",10
	
opt_1:		db "a - Easy",10
opt_2:		db "b - Hard",10
opt_3:		db "q - quit",10
fmt_scan:	db '%c',0	; the scanf format
	
len_i:		equ $-intro
len_r:		equ $-ask_route
len_e:		equ $-err
len_opts:	equ $-opt_1

	section .bss
lett_buff:	resq	1
	
	section .text
	global menu
menu:
	;; parameters goes as follow: rdi,rsi,rdx,rcx,r8,r9
	;; rax value is returned
	push rbp
	;; print("Welcome to TIC-TAC-ASSEMBLY\n")
	mov rax,1
	mov rdi,1
	mov rsi,intro		
	mov rdx,len_i
	syscall

	;; print("Pick an option from the menu below:\n")
	mov rax,1
	mov rdi,1
	mov rsi,ask_route
	mov rdx,len_i
	syscall

	;; scanf("%c")
	mov rdi,fmt_scan
	mov rsi,lett_buff
	mov rax,0
	
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
	mov rax,1
	mov rdi,1
	mov rsi,err
	mov rdx,len_e
	syscall

	;; repeat until input is valid
	jmp menu


quit:
	;; testing only 
	mov rax,1
	mov rdi,1
	mov rsi,lett_buff
	mov rdx,2
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,new_line
	mov rdx,1
	syscall
	
	;; rax = lett_buff
	mov al,[lett_buff]
	
	ret
	
