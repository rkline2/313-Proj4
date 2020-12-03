	section .data		
playerRow:		TIMES 16 db 0
playerCol:		TIMES 16 db 0
cpuRow:			TIMES 16 db 0
cpuCol:			TIMES 16 db 0

	section .bss
;; variables 
playerRowIndex:	resb 2
playerColIndex:	resb 2
cpuColIndex:	resb 2
cpuRowIndex:	resb 2
col_Index:	resb 2
coordinates:	resb 2

array:		resb 16
	
	
	section .text
	global checkWinner
	
checkWinner:
	;; parameters: (rdi,rsi,rdx,rcx,r8,r9)
	;; rdi = array, rsi = num_moves
	;; rax value is returned
	mov word[array],di
	mov byte[playerRowIndex],0
	mov byte[playerColIndex],0
	mov byte[cpuColIndex],0
	mov byte[col_Index],0
	mov rax,0
	
	jmp while

;; r10 = temp1, r11 = temp2, *r12 -> arr[i], rax = i
while:
	;; while (ax < 16)
	cmp al,16
	jge done6

	mov r12,array
	add r12b,al

	;; storing current position of i
	xor r13,r13
	mov r13b,al

	;; temp1 = getcoord(i)
	xor rdi,rdi
	mov dil,al
	call getcoord
	
	xor r10,r10
	mov r10,rax

	;; temp2 = getcoord(col_Index)
	xor rdi,rdi
	mov dil,byte[col_Index]
	call getcoord
	
	xor r11,r11
	mov r11,rax

	;; rax = i
	xor rax,rax
	mov rax,r13
	
	;; clear r13
	xor r13,r13
	
	;; if(arr[i] == 'x')
	cmp r12,120 		;error if dereference r12
	jne done1

	mov r13,playerRow	       ; playerRow[playerRowIndex] = temp1[1]
	add r13b,byte[playerRowIndex]  ; playerRowIndex++
	mov byte[r13],r10b		
	add byte[playerRowIndex],1
	
	jmp done1

	
	

done1:
	;; if(arr[i] == 'o')
	cmp byte[r12],111 		;error if compare and dereference r12
	jne done2

	xor r13,r13
	mov r13,cpuRow	 	   ; cpuRow[cpuRowIndex] = temp1[1]
	add r13b,byte[cpuRowIndex] ; cpuRowIndex++

	mov r14,r10
	
	mov byte[r13],r14b
	inc byte[cpuRowIndex]
	xor r14,r14

	jmp done2

done2:
	;;  if(arr[col_Index] == 'x')
	xor r13,r13
	mov r13,array
	add r13b,byte[col_Index]
	
	cmp byte[r13],120
	jne done3
	
	xor r13,r13
	xor r15,r15
	
	mov r13,playerCol		; playerCol[playerColIndex] = temp2[2]
	add r13b,byte[playerColIndex]   ; playerColIndex++
	xor r14,r14
	
	mov r14,r11		;r11 = temp2
	inc r14
	
	mov byte[r13],r14b
	inc byte[playerColIndex]
	xor r14,r14
	
	jmp done3

done3:
	;;   if(arr[col_Index] == '0')
	xor r13,r13
	mov r13,array
	add r13b,byte[col_Index]

	cmp byte[r13],111
	jne done4

	xor r13,r13

	mov r13,cpuCol 	; cpuCol[cpuColIndex] = temp2[2]
	add r13b,byte[cpuColIndex] ; cpuColIndex++
	xor r14,r14

	mov r14,r11		;r11 = temp2
	inc r14

	mov byte[r13],r14b
	inc byte[cpuColIndex]
	xor r14,r14

	jmp done4

done4:
	xor rdx,rdx		; if((col_index / 4) + 1 != 4){ col_index +=4; }
	xor r13,r13

	mov r13w,ax
	mov ax,word[col_Index]
	
	mov r14w,4
	div r14w
	inc ax
	
	mov r14w,ax
			;rax = i
	cmp r14w,4
	je else

	xor rax,rax
	mov ax,r13w
	add byte[col_Index],4
	jmp done5

else:
	xor rax,rax		; else{ col_index = (i+1)/4; }
	mov ax,r13w		; r13 = i
	mov r13w,ax

	xor rdx,rdx
	inc rax			; rax = i + 1

	mov r14w,4
	div r14w
	
	mov word[col_Index],ax

	xor rax,rax
	mov ax,r13w		; rax = i

	jmp done5
	
done5:	
	inc rax			; i++
	jmp while

done6:
	ret
	
getcoord:
	xor r13,r13
	;; rdi = location
	inc rdi
	mov rax,rdi
	xor rdx,rdx
	mov r14,4
	div r14
	;; r13 = col
	mov r13,rdx
	
	cmp r13,0
	je  else1
	inc rax
	mov r10,rax
	mov r11,r13
	xor r9,r9
	mov r9,coordinates
	mov byte[coordinates],r10b
	inc r9
	mov [r9],r11
	jmp exit

else1:
	;; temp =r13
	xor r13,r13
	mov r13,rax
	xor r9,r9
	mov r9,coordinates
	mov byte[coordinates],r13b
	inc r9
	mov byte[r9],4
	
	jmp exit
	
exit:
	mov rax,[coordinates]
	ret
	
	
	
	
