	extern printf
	
	section .data
err_msg:	db "error",0
	
fmt:		db "%s",10,0
fmt_dgt:	db "%d",10,0

	section .bss
opcode:		resd 1
temp1:		resd 1
temp2:		resd 1
	
	section .text
	global o_marks_the_spot
	;; parameters go as follow: rdi,rsi,rdx,rcx,r8,r9
	;; rdi = array, rsi = opcode	
o_marks_the_spot:
;;  Opcode:  8 (p=1 or c=2), 8 (row val), 8 (col val), 8 (diag 1 or 2)

	xor r8,r8		;2nd digit
	xor r9,r9		;3rd digit
	xor r10,r10		;4th digit
	
	xor r12,r12		;r12 = array_ptr
	xor r14,r14		;r14 = opcode
	xor r15,r15		;r15 = array
	
	mov r15,rdi		
	mov r14,rsi		
	mov dword[opcode],r14d
	

	mov r8d,100
	xor rdx,rdx
	xor rax,rax

	mov eax,r14d
	div r8d
	
	mov dword[temp1],eax

	xor rdx,rdx
	xor r8,r8
	
	mov r8d,10
	
	div r8d

	xor rdx,rdx
	mul r8d
	
	mov dword[temp2],eax

	xor r8,r8
	xor rdx,rdx
	
	mov r8,[temp1]
	sub r8,[temp2]

;; r9 ******************************** r9
	mov r9d,10 		;change here
	xor rdx,rdx
	xor rax,rax

	mov eax,r14d
	div r9d

	mov dword[temp1],eax

	xor rdx,rdx
	xor r9,r9

	mov r9d,10

	div r9d

	xor rdx,rdx
	mul r9d

	mov dword[temp2],eax

	xor r9,r9
	mov r9d,10

	div r9d

	xor rdx,rdx
	mul r9d

	mov dword[temp2],eax

	xor r9,r9
	xor rdx,rdx

	mov r9,[temp1]
	sub r9,[temp2]

;;  r10 ******************************** r10
	mov r10d,1 		;change here
	xor rdx,rdx
	xor rax,rax

	mov eax,r14d
	div r10d

	mov dword[temp1],eax

	xor rdx,rdx
	xor r10,r10
 
	mov r10d,10

	div r10d

	xor rdx,rdx
	mul r10d

	mov dword[temp2],eax

	xor r10,r10
	mov r10d,10

	div r10d

	xor rdx,rdx
	mul r10d

	mov dword[temp2],eax

	xor r10,r10
	xor rdx,rdx

	mov r10,[temp1]
	sub r10,[temp2]
	
	;; rows	
	cmp r8b,0
	je row0
	cmp r8b,1
	je row1
	cmp r8b,2
	je row2
	cmp r8b,3
	je row3

	;; cols
	cmp r9b,0
	je col0
	cmp r9b,1
	je col1
	cmp r9b,2
	je col2
	cmp r9b,3
	je col3

	;; diags
	cmp r10b,1
	je diag1
	cmp r10b,2
	je diag2

	jmp err
		
	

;; row0 *********************************** row0 
row0:
	xor r12,r12
	mov r12,r15
	
	cmp byte[r12],32
	je exit

	inc r12

	cmp byte[r12],32
	je exit
	
	inc r12

	cmp byte[r12],32
	je exit

	inc r12

	cmp byte[r12],32
	je exit

	jmp err
	
;;  row1 *********************************** row1	
row1:
	xor r12,r12
	mov r12,r15
	add r12,4

	cmp byte[r12],32
	je exit

	inc r12

	cmp byte[r12],32
	je exit
	
	inc r12

	cmp byte[r12],32
	je exit
	
	inc r12

	cmp byte[r12],32
	je exit

	jmp err
	
;;  row2 *********************************** row2
row2:
	xor r12,r12
	mov r12,r15
	add r12,8

	cmp byte[r12],32
	je exit

	inc r12

	cmp byte[r12],32
	je exit

	inc r12

	cmp byte[r12],32
	je exit

	inc r12

	cmp byte[r12],32
	je exit

	jmp err
	
	
;;  row3 *********************************** row3
row3:
	xor r12,r12
	mov r12,r15
	add r12,12

	cmp byte[r12],32
	je exit

	inc r12

	cmp byte[r12],32
	je exit

	inc r12

	cmp byte[r12],32
	je exit

	inc r12

	cmp byte[r12],32
	je exit

	jmp err
	
	
;;  col0 *********************************** col0
col0:
	xor r12,r12
	mov r12,r15
	add r12,0

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,4

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,8

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,12

	cmp byte[r12],32
	je exit

	jmp err
	

;;   col1 *********************************** col1
col1:
	xor r12,r12
	mov r12,r15
	add r12,1

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,5

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,9

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,13

	cmp byte[r12],32
	je exit

	jmp err
	

;;   col2 *********************************** col2
col2:
	xor r12,r12
	mov r12,r15
	add r12,2

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,6

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,10

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,14

	cmp byte[r12],32
	je exit

	jmp err
	

;;   col3 *********************************** col3
col3:
	xor r12,r12
	xor r12,r12
	mov r12,r15
	add r12,3

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,7

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,11

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,15

	cmp byte[r12],32
	je exit

	jmp err
	

;;   diag1 *********************************** diag1
diag1:
	xor r12,r12
	mov r12,r15
	add r12,0

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,5

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,10

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,15

	cmp byte[r12],32
	je exit

	jmp err
	

;;   diag2 *********************************** diag2
diag2:
	xor r12,r12
	mov r12,r15
	add r12,3

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,6

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,9

	cmp byte[r12],32
	je exit

	xor r12,r12
	mov r12,r15
	add r12,12

	cmp byte[r12],32
	je exit

	jmp err
	

;; return values 
exit:
	mov byte[r12],111
	ret
err:
	xor rax,rax
	push rbp
	mov rbp,rsp
	
	mov rdi,fmt
	mov rsi,err
	mov rax,0
	
	call printf
	
	pop rbp
	
	ret
