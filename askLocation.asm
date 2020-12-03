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
location:	resb 2
test:		resq 1

	section .text
	global askLocation
askLocation:
	xor r15,r15
	mov r15,rdi
	
	jmp getLocation
	
getLocation:
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
	
	call scanf

	pop rbp
	
	;; rbx = location
	dec byte[location]
	
	xor r12,r12
	mov r12,[location]

	;; (location < 0)? repeat : continue
	cmp r12b,0
	jl repeat

	;; (location > 15)? repeat : continue
	cmp r12b,15
	jg repeat

	xor r10,r10	
	mov r10,r15	;point to array
	
	;; locate spot 
	add r10b,r12b
	
	cmp byte[r10],111	;arr[askLocation] == 'x'
	je occupied

	cmp byte[r10],120
	je occupied

	
	mov byte[r10],120
		
	ret
	
repeat:
	xor r12,r12
	xor r10,r10
	
	;; repeats invalid input 
	push rbp
	mov rdi,fmt
	mov rsi,err
	mov rax,0
	
	call printf

	pop rbp
	jmp getLocation
	
occupied:
	xor r12,r12
	xor r10,r10
	
	;; requests location again if space already occupied
	push rbp
	mov rdi,fmt
	mov rsi,space_occupied
	mov rax,0

	call printf
	
	pop rbp
	
	jmp getLocation
