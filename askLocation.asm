	extern printf
	extern scanf
	
	section	.data
loc_prompt:     db "Enter a location on the board 1-16",0
err:		db "Invalid Input!",0
	
len_p:          equ $-loc_prompt
fmt:		db "%s",10,0
fmt_scan:	db "%d",0

	section .bss
location:	resq 3
	section .text
	global askLocation
askLocation:
	;; parameters go as follow: rdi,rsi,rdx,rcx,r8,r9
	;; rax value is returned
	push rbp
	mov rbp,rsp

	;; print(loc_prompt)  
	mov rdi,fmt
	mov rsi,loc_prompt
	mov rax,0
	call printf

	;; scanf("%d")
	mov rdi,fmt_scan
	mov rsi,location
	mov rax,0

	push rbp
	call scanf
	pop rbp

	;; rbx = location
	xor rbx,rbx
	mov bl,[location]

	pop rbp

	;; (location < 1)? repeat : continue
	cmp bl,1
	jl repeat

	;; (location > 16)? repeat : continue
	cmp bl,16
	jg repeat

	;; return location
	mov al,[location]
	ret
	
repeat:
	;; repeats invalid input 
	push rbp
	mov rdi,fmt
	mov rsi,err
	mov rax,0
	
	call printf
	
	pop rbp
	jmp askLocation
