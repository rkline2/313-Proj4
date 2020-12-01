	section .data
	
playerRow:	TIMES 16 db 0
playerCol:	TIMES 16 db 0
cpuRow:		TIMES 16 db 0
cpuCol:		TIMES 16 db 0

	section .bss
;; variables 
playerRowIndex:	resb 2
playerColIndex:	resb 2
cpuColIndex:	resb 2
cpuRowIndex:	resb 2
col_Index:	resb 2
coordinates:	resb 2
	
	section .text
	global checkWinner
	
checkWinner:
	;; parameters: (rdi,rsi,rdx,rcx,r8,r9)
	;; rdi = array, rsi = num_moves
	;; rax value is returned
	
	mov word[playerRowIndex],0
	mov word[playerColIndex],0
	mov word[cpuColIndex],0
	mov word[col_Index],0
	mov rax,0
	jmp while

;; r10 = temp1, r11 = temp2, *r12 -> arr[i], rax = i
while:
	;; while (ax < 16)
	cmp ax,16
	jge done6

	mov r12,array
	add r12,ax

	;; storing current position of i
	mov r13,rax

	;; temp1 = getcoord(arr[i]) 
	mov rdi,[r12]
	call getcoord
	mov r10,rax

	;; temp2 = getcoord(arr[col_Index])
	mov rdi,[col_Index]
	call getcoord
	mov r11,rax

	;; rax = i
	xor rax,rax
	mov rax,r13
	
	;; clear r13
	xor r13,r13
	
	;; if(arr[i] == 'x')
	cmp [r12],120
	jne done1

	mov r13,playerRow	  ; playerRow[playerRowIndex] = temp1[1]
	add r13,[playerRowIndex]  ; playerRowIndex++
	mov [r13],byte[r10]		
	inc playerRowIndex
	
	jmp done1

	
	

done1:
	;; if(arr[i] == 'o')
	cmp [r12],111
	jne done2

	mov r13,cpuRow	 	; cpuRow[cpuRowIndex] = temp1[1]
	add r13,[cpuRowIndex] ; cpuRowIndex++
	mov [r13],byte[r10]
	inc cpuRowIndex

	jmp done2

done2:
	;;  if(arr[col_Index] == 'x')
	xor r13,r13
	mov r13,array
	add r13,[col_Index]
	
	cmp [r13],120
	jne done3
	
	xor r13,r13
	
	mov r13,playerCol	; playerCol[playerColIndex] = temp2[2]
	add r13,[playerColIndex] ; playerColIndex++
	xor r14,r14
	
	mov r14,r11		;r11 = temp2
	inc r14
	
	mov [r13],byte[r14]
	inc playerColIndex
	xor r14,r14
	
	jmp done3

done3:
	;;   if(arr[col_Index] == '0')
	xor r13,r13
	mov r13,array
	add r13,[col_Index]

	cmp [r13],111
	jne done4

	xor r13,r13

	mov r13,cpuCol 	; cpuCol[cpuColIndex] = temp2[2]
	add r13,[cpuColIndex] ; cpuColIndex++
	xor r14,r14

	mov r14,r11		;r11 = temp2
	inc r14

	mov [r13],byte[r14]
	inc cpuColIndex
	xor r14,r14

	jmp done4

done4:
	xor rdx,rdx		; if((col_index / 4) + 1 != 4){ col_index +=4; }
	xor r13,r13
	
	mov r13,rax

	mov rax,[col_index]
	div 4
	inc rax
	
	cmp ax,4
	je else
	add [col_index],4

	move rax,r13		; rax = i
	jmp done5

else:				; else{ col_index = (i+1)/4; }
	mov r13,rax		; r13 = i
	
	xor rdx,rdx
	inc rax			; rax = i + 1

	div 4
	mov [col_index],rx
	
	mov rax,r13		; rax = i

	
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
	div 4
	;; r13 = col
	mov r13,rdx
	
	cmp r13,0
	je  else1
	inc rax
	mov r10,rax
	mov r11,r13
	xor r9,r9
	mov r9,coordinates
	mov byte[coordinates],r10
	inc r9
	mov [r9],r11
	jmp exit

else1:
	;; temp =r13
	xor r13,r13
	mov r13,rax
	xor r9,r9
	mov r9,coordinates
	mov byte[coordinates],r13
	inc r9
	mov[r9],4
	
	jmp exit
	
exit:
	mov rax,[coordinates]
	ret
	
	
	
	
