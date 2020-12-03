	extern printf
	extern scanf
	
	section	.data
loc_prompt:     db "Enter a location on the board 1-16",0
err:		db "Invalid Input!",0
space_occupied:	db "This is not an empty space. Try again!",0
	
len_p:          equ $-loc_prompt
fmt:		db "%s",10,0
fmt_scan:	db "%d",0
array:		db "                "
	section .bss
location:	resq 2
test:		resb 1
	section .text
	global askLocation
askLocation:
	;; parameters go as follow: rdi,rsi,rdx,rcx,r8,r9
	;; rax value is returned
	mov word[array],di
	
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

	
	call scanf
	

	pop rbp
	;; rbx = location
	xor rbx,rbx
	mov bl,byte[location]
	dec bl


	;; (location < 0)? repeat : continue
	cmp bl,0
	jl repeat

	;; (location > 15)? repeat : continue
	cmp bl,15
	jg repeat

	xor r10,r10		;error here
	mov r10,array	;point into array
	
	;; locate spot 
	add r10b,bl
	
	;cmp byte[r10],32
	;;jne occupied 
	
	mov byte[r10],120
		
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
