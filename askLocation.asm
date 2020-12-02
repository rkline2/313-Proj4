	extern printf
	extern scanf
	
	section	.data
loc_prompt:     db "Enter a location on the board 1-16",0
err:		db "Invalid Input!",0
space_occupied:	db "This is not an empty space. Try again!",0
	
len_p:          equ $-loc_prompt
fmt:		db "%s",10,0
fmt_scan:	db "%d",0

	section .bss
location:	resq 2
	section .text
	global askLocation
askLocation:
	;; parameters go as follow: rdi,rsi,rdx,rcx,r8,r9
	;; rax value is returned
	push rbp
	mov rbp,rsp
	
	xor r10,r10
	mov r10,rdi 		;place array into register
	
	;; print(loc_prompt)  
	mov rdi,fmt
	mov rsi,loc_prompt
	mov rax,0
	call printf

	;; scanf("%d")
	mov rdi,fmt_scan
	mov rsi,location
	mov rax,0

	
	call scanf
	

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
	
	;; locate spot 
	dec bl
	add r10b,bl
	

	cmp byte[r10],0
	jne occupied
	
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
	
occupied:
	;; requests location again if space already occupied
	push rbp
	mov rdi,fmt
	mov rsi,space_occupied
	mov rax,0

	call printf
	
	pop rbp
	jmp askLocation
