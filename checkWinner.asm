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
		
int_i:		resb 2
	
coordinates:	resb 2
temp_1:		resb 2
temp_2:		resb 2
	
num_x_1:	resb 2
num_x_2:	resb 2
	
num_y_1:	resb 2
num_y_2:	resb 2

num_moves:	resb 2

max_pl_dup:	resb 2
max_cpu_dup:	resb 2

player_dup:	resb 2
cpu_dup:	resb 2

max:		resb 2
max1:		resb 2
max2:		resb 2
	
currNumDupes:	resb 2

last:		resb 2
	section .text
	global checkWinner
	
checkWinner:
	;; parameters: (rdi,rsi,rdx,rcx,r8,r9)
	;; rdi = array, rsi = num_moves
	;; rax value is returned
	xor r15,r15
	mov r15,rdi 		;added r15 to point to array

	xor r10,r10
	mov r10,rsi
	mov byte[num_moves],r10b
	xor r10,r10

	;; int all Indexes = 0 
	mov byte[playerRowIndex],0
	mov byte[playerColIndex],0
	mov byte[cpuColIndex],0
	mov byte[col_Index],0

	mov byte[coordinates],0
	mov byte[temp_1],0
	mov byte[temp_2],0
	
	mov byte[int_i],0 		;set i outside loop? (yes so an infinite loop doesn't occur)

	
	jmp while
	

;; r10 = temp1[1], r11 = temp2[2], *r12 -> arr[i], r15 = array
while:
	;; while (ax < 16)
	cmp byte[int_i],16 		
	jge done6

	mov r12,r15
	add r12b,byte[int_i]

	
	;; temp1 = getcoord(i)
	xor rdi,rdi
	mov rdi,[int_i]		
	call getcoord

	mov [temp_1],rax

	xor r13,r13
	mov r13,temp_1 
	
	xor r10,r10
	mov r10,[r13]

	xor r13,r13
	xor rax,rax

	;; temp2 = getcoord(col_Index)
	xor rdi,rdi
	mov rdi,[col_Index]
	call getcoord

	mov [temp_2],rax
	mov r13,temp_2
	inc r13

	mov r11,[r13]
	
	;; clear r13 & return value
	xor r13,r13
	xor rax,rax
	
	;; if(arr[i] == 'x')
	cmp byte[r12],120 		
	jne done1

	mov r13,playerRow	       ; 
	add r13b,byte[playerRowIndex]  ; playerRow[playerRowIndex] = temp1[1]

	mov byte[r13],r10b
	inc byte[playerRowIndex]	; playerRowIndex++

	xor r13,r13
	
	jmp done1

	
	

done1:
	;; if(arr[i] == 'o')
	cmp byte[r12],111 
	jne done2

	xor r13,r13
	mov r13,cpuRow	 	   ; cpuRow[cpuRowIndex] = temp1[1]
	add r13b,byte[cpuRowIndex] ; cpuRowIndex++
	
	mov byte[r13],r10b
	inc byte[cpuRowIndex]
	
	xor r13,r13

	jmp done2

done2:
	;;  if(arr[col_Index] == 'x')
	xor r13,r13
	mov r13,r15
	add r13b,byte[col_Index]
	
	cmp byte[r13],120
	jne done3
	
	xor r13,r13
	
	mov r13,playerCol		; playerCol[playerColIndex] = temp2[2]
	add r13b,byte[playerColIndex]   ; playerColIndex++
	
	mov byte[r13],r11b		;r11 = temp[2]
	inc byte[playerColIndex]

	xor r13,r13
	
	jmp done3

done3:
	;;   if(arr[col_Index] == 'o')
	xor r13,r13
	mov r13,r15
	add r13b,byte[col_Index]

	cmp byte[r13],111
	jne done4

	xor r13,r13

	mov r13,cpuCol 	; cpuCol[cpuColIndex] = temp2[2]
	add r13b,byte[cpuColIndex] ; cpuColIndex++
	
	mov byte[r13],r11b
	inc byte[cpuColIndex]

	xor r13,r13

	jmp done4

done4:
	xor rdx,rdx		; if((col_index / 4) + 1 != 4){ col_index +=4; }
	xor rax,rax
	xor r13,r13
	xor r14,r14

	mov al,[col_Index]
	mov r14b,4
	div r14b
	inc al
	
	mov r14b,al
		
	cmp r14b,4
	jge else

	xor rax,rax
	xor rdx,rdx
	
	add byte[col_Index],4
	jmp done5

else:
	xor rax,rax		; else{ col_index = (i+1)/4; }
	xor rdx,rdx
	xor r13,r13
	mov rax,[int_i]

	inc rax			; rax = i + 1

	mov r14b,4
	div r14b
	mov r13,rax
	
	mov byte[col_Index],r13b

	xor rax,rax
	xor rdx,rdx
	xor r13,r13

	jmp done5
	
done5:	
	inc byte[int_i]			; i++
	jmp while

done6:
	;; while loop is exited
	
	mov byte[num_x_1],0
	mov byte[num_o_1],0
	
	mov byte[num_x_2],0
	mov byte[num_o_2],0

	mov byte[int_i],0
	xor r12,r12
	
	jmp diag1


diag1:
	cmp byte[int_i],16
	jge exit_diag1

	xor r12,r12
	
	mov r12,r15
	add r12b,byte[int_i]

	comp byte[r12],120
	je inc_num_x1
	
	comp byte[r12],111
	je inc_num_o1
	
	jmp inc_diag1

inc_num_x1:
	inc byte[num_x_1]
	jmp inc_diag1

inc_num_o1:
	inc byte[num_o_1]
	jmp inc_diag1

	
inc_diag1:	
	add byte[int_i],5
	jmp diag1


exit_diag1:
	mov byte[int_i],3
	xor r12,r12

	jmp diag2

diag2:
	cmp byte[int_i],13
	jge exit_diag2

	xor r12,r12
	
	mov r12,r15
	add r12b,byte[int_i]

	comp byte[r12],120
	je inc_num_x2

	comp byte[r12],111
	je inc_num_o2

	jmp inc_diag2

inc_num_x2:
	inc byte[num_x_2]
	jmp inc_diag2

inc_num_o2:
	inc byte[num_o_2]
	jmp inc_diag2

inc_diag2:
	add byte[int_i],3
	jmp diag2

	;; stupid diag cases are done
exit_diag2:
	mov byte[max_pl_dup],0
	mov byte[max_cpu_dup],0
	
	cmp byte[num_x_1], byte[num_x_2]
	jg max_is_num_x_1

	mov byte[max_pl_dup], byte[num_x_2]
	jmp find_max_cpu_dup
	
max_is_num_x_1:
	mov byte[max_pl_dup], byte[num_x_1]
	jmp find_max_cpu_dup
	
find_max_cpu_dup:
	cmp byte[num_o_1], byte[num_o_2]
	jg max_is_num_o_1

	mov byte[max_cpu_dup], byte[num_o_2]
	jmp find_player_dup

max_is_num_o_1:
	mov byte[max_cpu_dup], byte[num_o_1]
	jmp find_player_dup

find_player_dup:
	xor r12,r12
	xor r13,r13

	mov r12,[playerRowIndex]
	mov r13,[playerColIndex]
	
	mov rdi,playerRow
	mov rsi,playerCol
	
	mov rdx,r12
	mov rcx,r13
	
	call FindMaxDup
	mov byte[player_dup],al

	xor r12,r12
	xor r13,r13

	mov r12,[cpuRowIndex]
	mov r13,[cpuColIndex]
	
	mov rdi,cpuRow
	mov rsi,cpuCol

	mov rdx,r12
	mov rcx,r13

	call FindMaxDup

	mov byte[cpu_dup],al

	xor r12,r12
	xor r13,r13
	xor rax,rax
	
	;; player returns
	cmp byte[player_dup],4
	je return_2
	
	cmp byte[player_dup],3
	je return_1
	
	cmp byte[max_pl_dup],4
	je return_2
	
	cmp byte[max_pl_dup],3
	je return_1

	;; cpu returns
	cmp byte[cpu_dup],4
	je return_3
	
	cmp byte[cpu_dup],3
	je return_1
	
	cmp byte[max_cpu_dup],4
	je return_3
	
	cmp byte[max_cpu_dup],3
	je return_1

	cmp byte[num_moves],16
	je return_4

	mov rax,0
	ret

return_1:
	mov rax,1
	ret

return_2:
	mov rax,2
	ret

return_3:
	mov rax,3
	ret

return_4:	
	mov rax,4
	ret

getcoord:
	;; rdi = index number, r13 = col
	xor r10,r10		;r10 = row
	xor r11,r11		;r11 = col
	xor r15,r15		;r15 = rdi

	mov r15,rdi
	
	xor rax,rax
	xor rdx,rdx

	mov rax,r15		; row = location / 4
	mov r10,4		; col = location % 4
	div r10
	
	mov r10,rax
	mov r11,rdx
	
	xor r9,r9
	mov r9,coordinates
	mov byte[r9],r10b	; coordinates[1] = r10
	
	inc r9
	mov byte[r9],r11b	; coordinates[2] = r13

	xor rax,rax
	xor rdx,rdx
	
	mov rax,coordinates	;return value is int coordinates
	ret

FindMaxDup:
	;; rdi = row[], rsi = col[], rdx = row.len(), rcx = col.len()
	xor r11,r11
	xor r12,r12
	xor r13,r13
	xor r14,r14
	xor r15,r15
	
	mov r11,rdi			;r11 = row[]
	mov r12,rsi			;r12 = col[]
	mov r14,rdx			;r14 = row.len()
	mov r15,rcx			;r15 = col.len()
	inc r14
	inc r15
	
	mov r13,r11			;r13 = row[0]
	mov byte[last],byte[r13] 	;last = row[0]
	
	mov byte[max],0
	mov byte[max1],0
	mov byte[currNumDupes],1

	mov byte[int_i],0

	jmp MaxRow

MaxRow:
	cmp byte[int_i],r14
	jge rowComp

	xor r13,r13
	mov r13,r11		;r11 = row[]
	
	add r13b,byte[int_i]

	cmp byte[r13],byte[last] ;if(row[i] == last)
	
	jne row_else
	
	inc byte[currNumDupes]

	jmp MaxRowExit
	
row_else:
	cmp byte[max1],byte[currNumDupes]
	jg row_else2
	mov byte[max1],byte[currNumDupes]
	
	mov byte[currNumDupes],1
	jmp MaxRowExit

row_else2:
	mov byte[currNumDupes],1
	jmp MaxRowExit

MaxRowExit:
	mov byte[last],byte[r13] ; last = row[i]
	inc byte[int_i]

row_Comp:
	cmp byte[max1], byte[currNumDupes]
	jg MaxCol

	mov byte[max1],byte[currNumDupes]
	jmp MaxCol
	

MaxCol:				;r12 = col[]
	mov byte[max2],0

	xor r13,r13
	mov r13,col		;r13 = col[i]
	
	mov byte[last],byte[r13] ;last = col[0]

	mov byte[currNumDupes],1
	mov byte[int_i],1
	jmp MaxColLoop
	
MaxColLoop:
	cmp byte[int_i],r15
	jge ExitColLoop

	add r13,byte[int_i]
	cmp byte[r13],byte[last] ;if (col[i] == last)
	jne col_else

	inc byte[currNumDupes]
	jmp MaxColExit

col_else:
	cmp byte[max2],byte[currNumDupes]
	jg col_else2
	mov byte[max2],byte[currNumDupes]
	
	mov byte[currNumDupes],1
	jmp MaxColExit

col_else2:
	mov byte[currNumDupes],1
	jmp MaxColExit
	
	
MaxColExit:
	mov byte[last],byte[r13]
	inc [int_i]
	
	jmp MaxColLoop

ExitColLoop:
	cmp byte[max2],byte[currNumDupes]
	jg col_else3
	mov byte[max2],byte[currNumDupes]
	jmp col_else3
	
col_else3:
	cmp byte[max1],byte[max2]
	jg Max1IsSupreme
	mov byte[max],byte[max2]
	jmp ExitDaMaxDup

Max1IsSupreme:
	mov byte[max],byte[max1]
	jmp ExitDaMaxDup

ExitDaMaxDup:
	mov rax,max
	ret
