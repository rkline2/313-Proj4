	section .data
printX: db "X Won!",10
len_X:  equ $-printX
printO: db "COMPUTER WINS!",10
len_O:  equ $-printO
	section .bss
winner: resb 1
	
c_row0: resb 1
c_row1: resb 1
c_row2: resb 1
c_row3: resb 1

c_col0: resb 1
c_col1: resb 1
c_col2: resb 1
c_col3: resb 1

c_diag1: resb 1
c_diag2: resb 1

p_row0: resb 1
p_row1: resb 1
p_row2: resb 1
p_row3: resb 1

p_col0: resb 1
p_col1: resb 1
p_col2: resb 1
p_col3: resb 1

p_diag1: resb 1
p_diag2: resb 1
	
	section .text
	global checkWinner
checkWinner:

	xor r15,r15
	xor r8,r8
	xor r9,r9
	
	mov r15,rdi 		;r15 point to board array at begining r15=board[0]
	
; computer ********************* computer
	mov byte[c_row0],0
	mov byte[c_row1],0
	mov byte[c_row2],0
	mov byte[c_row3],0
	
	mov byte[c_col0],0
	mov byte[c_col1],0
	mov byte[c_col2],0
	mov byte[c_col3],0
	
	mov byte[c_diag1],0
	mov byte[c_diag2],0
; computer ********************* computer

; player ********************* player
	mov byte[p_row0],0
	mov byte[p_row1],0
	mov byte[p_row2],0
	mov byte[p_row3],0
	
	mov byte[p_col0],0
	mov byte[p_col1],0
	mov byte[p_col2],0
	mov byte[p_col3],0
	
	mov byte[p_diag1],0
	mov byte[p_diag2],0
; player ********************* player
	
	jmp row0
		
;;  row 0 ********************************************* row 0
row0:
	xor r8,r8		;r8 = num_x
	xor r9,r9		;r9 = num_o
	xor r10,r10		;r10 = num_sp
	
	xor r14,r14
	xor r13,r13
	xor r12,r12

	mov r14,r15
	cmp byte[r14],120
	je row0_0_is_x
	
	cmp byte[r14],111
	je row0_0_is_o
	
	inc r10			;num_sp++
	
	jmp row0_1
	
row0_0_is_x:
	inc r8
	jmp row0_1
	
row0_0_is_o:
	inc r9
	jmp row0_1
	
row0_1:	
	xor r14,r14
	
	mov r14,r15
	add r14,1		; r14 = array[1]
	
	cmp byte[r14],120
	je row0_1_is_x
	
	cmp byte[r14],111
	je row0_1_is_o
	
	inc r10

	jmp row0_2

row0_1_is_x:
	inc r8
	jmp row0_2

row0_1_is_o:
	inc r9
	jmp row0_2

	
row0_2:	
	xor r14,r14

	mov r14,r15
	add r14,2
	cmp byte[r14],120
	je row0_2_is_x
	
	cmp byte[r14],111
	je row0_2_is_o

	inc r10			; num_sp++
	
	jmp row0_3

row0_2_is_x:
	inc r8
	jmp row0_3

row0_2_is_o:
	inc r9
	jmp row0_3
	
	
row0_3:	
	xor r14,r14

	mov r14,r15
	add r14,3
	
	cmp byte[r14],120
	je row0_3_is_x
	
	cmp byte[r14],111
	je row0_3_is_o
	
	inc r10
	jmp cmp_row0

row0_3_is_x:
	inc r8
	jmp cmp_row0

row0_3_is_o:
	inc r9
	jmp cmp_row0
	
cmp_row0:	
	cmp r8,4		; player is winner
	je WonUser 
	cmp r9,4		; cpu is winner
	je WonComp
	
	cmp r8,3		; player is almost winner
	je cmp_almost_p_row0

	cmp r9,3		; cpu is almost winner
	je cmp_almost_c_row0
	jmp row1

cmp_almost_p_row0:
	cmp r10,1
	je set_almost_p_row0
	
	jmp row1
	
cmp_almost_c_row0:
	cmp r10,1
	je set_almost_c_row0
	
	jmp row1
	
set_almost_p_row0:
	mov byte[p_row0],1
	
	jmp row1
	
set_almost_c_row0:
	mov byte[c_row0],1
	
	jmp row1
	
;; row 1 ********************************************* row 1
	
row1:
	xor r8,r8	;r8 = num_x
	xor r9,r9	;r9 = num_o
	xor r10,r10	;r10 = num_sp

	xor r14,r14
	xor r13,r13
	xor r12,r12

	mov r14,r15
	add r14,4
	
	cmp byte[r14],120
	je row1_0_is_x

	cmp byte[r14],111
	je row1_0_is_o

	inc r10		;num_sp++

	jmp row1_1


row1_0_is_x:
	inc r8
	jmp row1_1

row1_0_is_o:
	inc r9
	jmp row1_1
	
row1_1:
	xor r14,r14

	mov r14,r15
	add r14,5	; r14 = array[1]

	cmp byte[r14],120
	je row1_1_is_x

	cmp byte[r14],111
	je row1_1_is_o

	inc r10

	jmp row1_2

row1_1_is_x:
	inc r8
	jmp row1_2

row1_1_is_o:
	inc r9
	jmp row1_2

row1_2:
	xor r14,r14

	mov r14,r15
	add r14,6
	
	cmp byte[r14],120
	je row1_2_is_x
	
	cmp byte[r14],111
	je row1_2_is_o

	inc r10		; num_sp++

	jmp row1_3

row1_2_is_x:
	inc r8
	jmp row1_3

row1_2_is_o:
	inc r9
	jmp row1_3
	

row1_3:
	xor r14,r14

	mov r14,r15
	add r14,7
	
	cmp byte[r14],120
	je row1_3_is_x
	
	cmp byte[r14],111
	je row1_3_is_o
	
	inc r10
	jmp cmp_row1

row1_3_is_x:
	inc r8
	jmp cmp_row1

row1_3_is_o:
	inc r9
	jmp cmp_row1

cmp_row1:
	cmp r8,4	; player is winner
	je WonUser
	
	cmp r9,4	; cpu is winner
	je WonComp

	cmp r8,3	; player is almost winner
	je cmp_almost_p_row1

	cmp r9,3	; cpu is almost winner
	je cmp_almost_c_row1
	jmp row2

cmp_almost_p_row1:
	cmp r10,1
	je set_almost_p_row1
	
	jmp row2
	
cmp_almost_c_row1:
	cmp r10,1
	je set_almost_c_row1
	
	jmp row2
	
set_almost_p_row1:
	mov byte[p_row1],1
	
	jmp row2
	
set_almost_c_row1:
	mov byte[c_row1],1
	
	jmp row2
	
;;  row 2 ********************************************* row 2
	
row2:
	xor r8,r8       ;r8 = num_x
	xor r9,r9       ;r9 = num_o
	xor r10,r10     ;r10 = num_sp

	xor r14,r14
	xor r13,r13
	xor r12,r12

	mov r14,r15
	add r14,8	;change here

	cmp byte[r14],120
	je row2_0_is_x	;change here

	cmp byte[r14],111
	je row2_0_is_o	;change here

	inc r10         ;num_sp++

	jmp row2_1	;change here


row2_0_is_x:
	inc r8
	jmp row2_1	;change here

row2_0_is_o:
	inc r9
	jmp row2_1	;change here

row2_1:
	xor r14,r14

	mov r14,r15
	add r14,9	;change here

	cmp byte[r14],120
	je row2_1_is_x	;change here

	cmp byte[r14],111
	je row2_1_is_o	;change here

	inc r10

	jmp row2_2	;change here

row2_1_is_x:
	inc r8
	jmp row2_2	;change here

row2_1_is_o:
	inc r9
	jmp row2_2	;change here

row2_2:
	xor r14,r14

	mov r14,r15
	add r14,10	;change here

	cmp byte[r14],120
	je row2_2_is_x
	
	cmp byte[r14],111
	je row2_2_is_o

	inc r10		;num_sp++

	jmp row2_3	;change here

row2_2_is_x:
	inc r8
	jmp row2_3	;change here

row2_2_is_o:
	inc r9
	jmp row2_3	;change here

row2_3:
	xor r14,r14

	mov r14,r15
	add r14,11	;change here

	cmp byte[r14],120
	je row2_3_is_x	;change here

	cmp byte[r14],111
	je row2_3_is_o	;change here

	inc r10
	jmp cmp_row2

row2_3_is_x:
	inc r8
	jmp cmp_row2	;change here

row2_3_is_o:
	inc r9
	jmp cmp_row2	;change here

cmp_row2:
	cmp r8,4        ; player is winner
	je WonUser

	cmp r9,4        ; cpu is winner
	je WonComp

	cmp r8,3        ; player is almost winner
	je cmp_almost_p_row2 ;change here

	cmp r9,3        ; cpu is almost winner
	je cmp_almost_c_row2 ;change here
	jmp row3     ;change here


cmp_almost_p_row2:
	cmp r10,1
	je set_almost_p_row2
	
	jmp row3
	
cmp_almost_c_row2:
	cmp r10,1
	je set_almost_c_row2
	
	jmp row3
	
set_almost_p_row2:
	mov byte[p_row2],1
	
	jmp row3
	
set_almost_c_row2:
	mov byte[c_row2],1
	
	jmp row3
	

;;  row 3 ********************************************* row 3

row3:
	xor r8,r8       ;r8 = num_x
	xor r9,r9       ;r9 = num_o
	xor r10,r10     ;r10 = num_sp

	xor r14,r14
	xor r13,r13
	xor r12,r12

	mov r14,r15
	add r14,12	;change here

	cmp byte[r14],120
	je row3_0_is_x	;change here

	cmp byte[r14],111
	je row3_0_is_o	;change here

	inc r10         ;num_sp++

	jmp row3_1	;change here


row3_0_is_x:
	inc r8
	jmp row3_1	;change here

row3_0_is_o:
	inc r9
	jmp row3_1	;change here

row3_1:
	xor r14,r14

	mov r14,r15
	add r14,13	;change here

	cmp byte[r14],120
	je row3_1_is_x	;change here

	cmp byte[r14],111
	je row3_1_is_o	;change here

	inc r10

	jmp row3_2	;change here

row3_1_is_x:
	inc r8
	jmp row3_2	;change here

row3_1_is_o:
	inc r9
	jmp row3_2	;change here

row3_2:
	xor r14,r14

	mov r14,r15
	add r14,14	;change here

	cmp byte[r14],120
	je row3_2_is_x		;change here

	cmp byte[r14],111
	je row3_2_is_o		;change here

	inc r10		;num_sp++

	jmp row3_3	;change here

row3_2_is_x:
	inc r8
	jmp row3_3	;change here

row3_2_is_o:
	inc r9
	jmp row3_3	;change here

row3_3:
	xor r14,r14

	mov r14,r15
	add r14,15	;change here

	cmp byte[r14],120
	je row3_3_is_x	;change here

	cmp byte[r14],111
	je row3_3_is_o	;change here

	inc r10
	jmp cmp_row3

row3_3_is_x:
	inc r8
	jmp cmp_row3	;change here

row3_3_is_o:
	inc r9
	jmp cmp_row3	;change here

cmp_row3:
	cmp r8,4        ; player is winner
	je WonUser

	cmp r9,4        ; cpu is winner
	je WonComp

	cmp r8,3        ; player is almost winner
	je cmp_almost_p_row3 ;change here

	cmp r9,3        ; cpu is almost winner
	je cmp_almost_c_row3 ;change here
	jmp col0     ;change here

cmp_almost_p_row3:
	cmp r10,1
	je set_almost_p_row3
	
	jmp col0
	
cmp_almost_c_row3:
	cmp r10,1
	je set_almost_c_row3
	
	jmp col0
	
set_almost_p_row3:
	mov byte[p_row3],1
	
	jmp col0
	
set_almost_c_row3:
	mov byte[c_row3],1
	
	jmp col0
	
;;   col 0 ********************************************* col 0
	
col0:
	xor r8,r8       ;r8 = num_x
	xor r9,r9       ;r9 = num_o
	xor r10,r10     ;r10 = num_sp

	xor r14,r14
	xor r13,r13
	xor r12,r12

	mov r14,r15
	add r14,0	;change here

	cmp byte[r14],120
	je col0_0_is_x	;change here

	cmp byte[r14],111
	je col0_0_is_o	;change here

	inc r10         ;num_sp++

	jmp col0_1	;change here


col0_0_is_x:
	inc r8
	jmp col0_1	;change here

col0_0_is_o:
	inc r9
	jmp col0_1	;change here

col0_1:
	xor r14,r14

	mov r14,r15
	add r14,4	;change here

	cmp byte[r14],120
	je col0_1_is_x	;change here

	cmp byte[r14],111
	je col0_1_is_o	;change here

	inc r10

	jmp col0_2	;change here

col0_1_is_x:
	inc r8
	jmp col0_2	;change here

col0_1_is_o:
	inc r9
	jmp col0_2	;change here

col0_2:
	xor r14,r14

	mov r14,r15
	add r14,8	;change here

	cmp byte[r14],120
	je col0_2_is_x		;change here

	cmp byte[r14],111
	je col0_2_is_o		;change here

	inc r10		;num_sp++

	jmp col0_3	;change here

col0_2_is_x:
	inc r8
	jmp col0_3	;change here

col0_2_is_o:
	inc r9
	jmp col0_3	;change here

col0_3:
	xor r14,r14

	mov r14,r15
	add r14,12	;change here

	cmp byte[r14],120
	je col0_3_is_x	;change here

	cmp byte[r14],111
	je col0_3_is_o	;change here

	inc r10
	jmp cmp_col0

col0_3_is_x:
	inc r8
	jmp cmp_col0	;change here

col0_3_is_o:
	inc r9
	jmp cmp_col0	;change here

cmp_col0:
	cmp r8,4        ; player is winner
	je WonUser

	cmp r9,4        ; cpu is winner
	je WonComp

	cmp r8,3        ; player is almost winner
	je cmp_almost_p_col0 ;change here

	cmp r9,3        ; cpu is almost winner
	je cmp_almost_c_col0 ;change here
	jmp col1     ;change here

cmp_almost_p_col0:
	cmp r10,1
	je set_almost_p_col0
	
	jmp col1
	
cmp_almost_c_col0:
	cmp r10,1
	je set_almost_c_col0
	
	jmp col1
	
set_almost_p_col0:
	mov byte[p_col0],1
	
	jmp col1
	
set_almost_c_col0:
	mov byte[c_col0],1
	
	jmp col1
	
;;    col 1 ********************************************* col 1
col1:
	xor r8,r8       ;r8 = num_x
	xor r9,r9       ;r9 = num_o
	xor r10,r10     ;r10 = num_sp

	xor r14,r14
	xor r13,r13
	xor r12,r12

	mov r14,r15
	add r14,1	;change here

	cmp byte[r14],120
	je col1_0_is_x	;change here

	cmp byte[r14],111
	je col1_0_is_o	;change here

	inc r10         ;num_sp++

	jmp col1_1	;change here


col1_0_is_x:
	inc r8
	jmp col1_1	;change here

col1_0_is_o:
	inc r9
	jmp col1_1	;change here

col1_1:
	xor r14,r14

	mov r14,r15
	add r14,5	;change here

	cmp byte[r14],120
	je col1_1_is_x	;change here

	cmp byte[r14],111
	je col1_1_is_o	;change here

	inc r10

	jmp col1_2	;change here

col1_1_is_x:
	inc r8
	jmp col1_2	;change here

col1_1_is_o:
	inc r9
	jmp col1_2	;change here

col1_2:
	xor r14,r14

	mov r14,r15
	add r14,9	;change here

	cmp byte[r14],120
	je col1_2_is_x		;change here

	cmp byte[r14],111
	je col1_2_is_o		;change here

	inc r10		;num_sp++

	jmp col1_3	;change here

col1_2_is_x:
	inc r8
	jmp col1_3	;change here

col1_2_is_o:
	inc r9
	jmp col1_3	;change here

col1_3:
	xor r14,r14

	mov r14,r15
	add r14,13	;change here

	cmp byte[r14],120
	je col1_3_is_x	;change here

	cmp byte[r14],111
	je col1_3_is_o	;change here

	inc r10
	jmp cmp_col1

col1_3_is_x:
	inc r8
	jmp cmp_col1	;change here

col1_3_is_o:
	inc r9
	jmp cmp_col1	;change here

cmp_col1:
	cmp r8,4        ; player is winner
	je WonUser

	cmp r9,4        ; cpu is winner
	je WonComp

	cmp r8,3        ; player is almost winner
	je cmp_almost_p_col1 ;change here

	cmp r9,3        ; cpu is almost winner
	je cmp_almost_c_col1 ;change here
	jmp col2     ;change here

cmp_almost_p_col1:
	cmp r10,1
	je set_almost_p_col1
	
	jmp col2
	
cmp_almost_c_col1:
	cmp r10,1
	je set_almost_c_col1
	
	jmp col2
	
set_almost_p_col1:
	mov byte[p_col1],1
	
	jmp col2
	
set_almost_c_col1:
	mov byte[c_col1],1
	
	jmp col2
	
;;    col 2 ********************************************* col 2
col2:
	xor r8,r8       ;r8 = num_x
	xor r9,r9       ;r9 = num_o
	xor r10,r10     ;r10 = num_sp

	xor r14,r14
	xor r13,r13
	xor r12,r12

	mov r14,r15
	add r14,2	;change here

	cmp byte[r14],120
	je col2_0_is_x	;change here

	cmp byte[r14],111
	je col2_0_is_o	;change here

	inc r10         ;num_sp++

	jmp col2_1	;change here


col2_0_is_x:
	inc r8
	jmp col2_1	;change here

col2_0_is_o:
	inc r9
	jmp col2_1	;change here

col2_1:
	xor r14,r14

	mov r14,r15
	add r14,6	;change here

	cmp byte[r14],120
	je col2_1_is_x	;change here

	cmp byte[r14],111
	je col2_1_is_o	;change here

	inc r10

	jmp col2_2	;change here

col2_1_is_x:
	inc r8
	jmp col2_2	;change here

col2_1_is_o:
	inc r9
	jmp col2_2	;change here

col2_2:
	xor r14,r14

	mov r14,r15
	add r14,10	;change here

	cmp byte[r14],120
	je col2_2_is_x		;change here

	cmp byte[r14],111
	je col2_2_is_o		;change here

	inc r10		;num_sp++

	jmp col2_3	;change here

col2_2_is_x:
	inc r8
	jmp col2_3	;change here

col2_2_is_o:
	inc r9
	jmp col2_3	;change here

col2_3:
	xor r14,r14

	mov r14,r15
	add r14,14	;change here

	cmp byte[r14],120
	je col2_3_is_x	;change here

	cmp byte[r14],111
	je col2_3_is_o	;change here

	inc r10
	jmp cmp_col2

col2_3_is_x:
	inc r8
	jmp cmp_col2	;change here

col2_3_is_o:
	inc r9
	jmp cmp_col2	;change here

cmp_col2:
	cmp r8,4        ; player is winner
	je WonUser

	cmp r9,4        ; cpu is winner
	je WonComp

	cmp r8,3        ; player is almost winner
	je cmp_almost_p_col2 ;change here

	cmp r9,3        ; cpu is almost winner
	je cmp_almost_c_col2 ;change here
	jmp col3     ;change here

cmp_almost_p_col2:
	cmp r10,1
	je set_almost_p_col2
	
	jmp col3
	
cmp_almost_c_col2:
	cmp r10,1
	je set_almost_c_col2
	
	jmp col3
	
set_almost_p_col2:
	mov byte[p_col2],1
	
	jmp col3
	
set_almost_c_col2:
	mov byte[c_col2],1
	
	jmp col3

;;     col 3 ********************************************* col 3

col3:
	xor r8,r8       ;r8 = num_x
	xor r9,r9       ;r9 = num_o
	xor r10,r10     ;r10 = num_sp

	xor r14,r14
	xor r13,r13
	xor r12,r12

	mov r14,r15
	add r14,3	;change here

	cmp byte[r14],120
	je col3_0_is_x	;change here

	cmp byte[r14],111
	je col3_0_is_o	;change here

	inc r10         ;num_sp++

	jmp col3_1	;change here


col3_0_is_x:
	inc r8
	jmp col3_1	;change here

col3_0_is_o:
	inc r9
	jmp col3_1	;change here

col3_1:
	xor r14,r14

	mov r14,r15
	add r14,7	;change here

	cmp byte[r14],120
	je col3_1_is_x	;change here

	cmp byte[r14],111
	je col3_1_is_o	;change here

	inc r10

	jmp col3_2	;change here

col3_1_is_x:
	inc r8
	jmp col3_2	;change here

col3_1_is_o:
	inc r9
	jmp col3_2	;change here

col3_2:
	xor r14,r14

	mov r14,r15
	add r14,11	;change here

	cmp byte[r14],120
	je col3_2_is_x		;change here

	cmp byte[r14],111
	je col3_2_is_o		;change here

	inc r10		;num_sp++

	jmp col3_3	;change here

col3_2_is_x:
	inc r8
	jmp col3_3	;change here

col3_2_is_o:
	inc r9
	jmp col3_3	;change here

col3_3:
	xor r14,r14

	mov r14,r15
	add r14,15	;change here

	cmp byte[r14],120
	je col3_3_is_x	;change here

	cmp byte[r14],111
	je col3_3_is_o	;change here

	inc r10
	jmp cmp_col3

col3_3_is_x:
	inc r8
	jmp cmp_col3	;change here

col3_3_is_o:
	inc r9
	jmp cmp_col3	;change here

cmp_col3:
	cmp r8,4        ; player is winner
	je WonUser

	cmp r9,4        ; cpu is winner
	je WonComp

	cmp r8,3        ; player is almost winner
	je cmp_almost_p_col3 ;change here

	cmp r9,3        ; cpu is almost winner
	je cmp_almost_c_col3 ;change here
	jmp diag1  ;change here

cmp_almost_p_col3:
	cmp r10,1
	je set_almost_p_col3
	
	jmp diag1
	
cmp_almost_c_col3:
	cmp r10,1
	je set_almost_c_col3
	
	jmp diag1
	
set_almost_p_col3:
	mov byte[p_col3],1
	
	jmp diag1
	
set_almost_c_col3:
	mov byte[c_col3],1
	
	jmp diag1

;;  diag 1 ********************************************* diag 1

diag1:
	xor r8,r8       ;r8 = num_x
	xor r9,r9       ;r9 = num_o
	xor r10,r10     ;r10 = num_sp

	xor r14,r14
	xor r13,r13
	xor r12,r12

	mov r14,r15
	add r14,0	;change here

	cmp byte[r14],120
	je diag1_0_is_x	;change here

	cmp byte[r14],111
	je diag1_0_is_o	;change here

	inc r10         ;num_sp++

	jmp diag1_1	;change here


diag1_0_is_x:
	inc r8
	jmp diag1_1	;change here

diag1_0_is_o:
	inc r9
	jmp diag1_1	;change here

diag1_1:
	xor r14,r14

	mov r14,r15
	add r14,5	;change here

	cmp byte[r14],120
	je diag1_1_is_x	;change here

	cmp byte[r14],111
	je diag1_1_is_o	;change here

	inc r10

	jmp diag1_2	;change here

diag1_1_is_x:
	inc r8
	jmp diag1_2	;change here

diag1_1_is_o:
	inc r9
	jmp diag1_2	;change here

diag1_2:
	xor r14,r14

	mov r14,r15
	add r14,10	;change here

	cmp byte[r14],120
	je diag1_2_is_x		;change here

	cmp byte[r14],111
	je diag1_2_is_o		;change here

	inc r10		;num_sp++

	jmp diag1_3	;change here

diag1_2_is_x:
	inc r8
	jmp diag1_3	;change here

diag1_2_is_o:
	inc r9
	jmp diag1_3	;change here

diag1_3:
	xor r14,r14

	mov r14,r15
	add r14,15	;change here

	cmp byte[r14],120
	je diag1_3_is_x	;change here

	cmp byte[r14],111
	je diag1_3_is_o	;change here

	inc r10
	jmp cmp_diag1

diag1_3_is_x:
	inc r8
	jmp cmp_diag1	;change here

diag1_3_is_o:
	inc r9
	jmp cmp_diag1	;change here

cmp_diag1:
	cmp r8,4        ; player is winner
	je WonUser

	cmp r9,4        ; cpu is winner
	je WonComp

	cmp r8,3        ; player is almost winner
	je cmp_almost_p_diag1 ;change here

	cmp r9,3        ; cpu is almost winner
	je cmp_almost_c_diag1 ;change here
	jmp diag2     ;change here

cmp_almost_p_diag1:
	cmp r10,1
	je set_almost_p_diag1
	
	jmp diag2
	
cmp_almost_c_diag1:
	cmp r10,1
	je set_almost_c_diag1
	
	jmp diag2
	
set_almost_p_diag1:
	mov byte[p_diag1],1
	
	jmp diag2
	
set_almost_c_diag1:
	mov byte[c_diag1],1
	
	jmp diag2
	
;;  diag 2 ********************************************* diag 2

diag2:
	xor r8,r8       ;r8 = num_x
	xor r9,r9       ;r9 = num_o
	xor r10,r10     ;r10 = num_sp

	xor r14,r14
	xor r13,r13
	xor r12,r12

	mov r14,r15
	add r14,3	;change here

	cmp byte[r14],120
	je diag2_0_is_x	;change here

	cmp byte[r14],111
	je diag2_0_is_o	;change here

	inc r10         ;num_sp++

	jmp diag2_1	;change here


diag2_0_is_x:
	inc r8
	jmp diag2_1	;change here

diag2_0_is_o:
	inc r9
	jmp diag2_1	;change here

diag2_1:
	xor r14,r14

	mov r14,r15
	add r14,6	;change here

	cmp byte[r14],120
	je diag2_1_is_x	;change here

	cmp byte[r14],111
	je diag2_1_is_o	;change here

	inc r10

	jmp diag2_2	;change here

diag2_1_is_x:
	inc r8
	jmp diag2_2	;change here

diag2_1_is_o:
	inc r9
	jmp diag2_2	;change here

diag2_2:
	xor r14,r14

	mov r14,r15
	add r14,9	;change here

	cmp byte[r14],120
	je diag2_2_is_x		;change here

	cmp byte[r14],111
	je diag2_2_is_o		;change here

	inc r10		;num_sp++

	jmp diag2_3	;change here

diag2_2_is_x:
	inc r8
	jmp diag2_3	;change here

diag2_2_is_o:
	inc r9
	jmp diag2_3	;change here

diag2_3:
	xor r14,r14

	mov r14,r15
	add r14,12	;change here

	cmp byte[r14],120
	je diag2_3_is_x	;change here

	cmp byte[r14],111
	je diag2_3_is_o	;change here

	inc r10
	jmp cmp_diag2

diag2_3_is_x:
	inc r8
	jmp cmp_diag2	;change here

diag2_3_is_o:
	inc r9
	jmp cmp_diag2	;change here

cmp_diag2:
	cmp r8,4        ; player is winner
	je WonUser

	cmp r9,4        ; cpu is winner
	je WonComp

	cmp r8,3        ; player is almost winner
	je cmp_almost_p_diag2 ;change here

	cmp r9,3        ; cpu is almost winner
	je cmp_almost_c_diag2 ;change here
	
	jmp default_ret   ;change here

cmp_almost_p_diag2:
	cmp r10,1
	je set_almost_p_diag2
	
	jmp all_almost_cmp
	
cmp_almost_c_diag2:
	cmp r10,1
	je set_almost_c_diag2
	
	jmp all_almost_cmp
	
set_almost_p_diag2:
	mov byte[p_diag2],1
	
	jmp all_almost_cmp
	
set_almost_c_diag2:
	mov byte[c_diag2],1
	
	jmp all_almost_cmp
	
all_almost_cmp:
; computer ********************* computer
	xor r11,r11
	mov r11,[c_row0]
	cmp r11b,1
	je almost_c_row0
	
	xor r11,r11
	mov r11,[c_row1]
	cmp r11b,1
	je almost_c_row1
	
	xor r11,r11
	mov r11,[c_row2]
	cmp r11b,1
	je almost_c_row2
	
	xor r11,r11
	mov r11,[c_row3]
	cmp r11b,1
	je almost_c_row3
	
	xor r11,r11
	mov r11,[c_col0]
	cmp r11b,1
	je almost_c_col0
	
	xor r11,r11
	mov r11,[c_col1]
	cmp r11b,1
	je almost_c_col1
	
	xor r11,r11
	mov r11,[c_col2]
	cmp r11b,1
	je almost_c_col2
	
	xor r11,r11
	mov r11,[c_col3]
	cmp r11b,1
	je almost_c_col3
	
	xor r11,r11
	mov r11,[c_diag1]
	cmp r11b,1
	je almost_c_diag1
	
	xor r11,r11
	mov r11,[c_diag2]
	cmp r11b,1
	je almost_c_diag2
; computer ********************* computer

; player ********************* player
	xor r11,r11
	mov r11,[p_row0]
	cmp r11b,1
	je almost_p_row0
	
	xor r11,r11
	mov r11,[p_row1]
	cmp r11b,1
	je almost_p_row1
	
	xor r11,r11
	mov r11,[p_row2]
	cmp r11b,1
	je almost_p_row2
	
	xor r11,r11
	mov r11,[p_row3]
	cmp r11b,1
	je almost_p_row3
	
	xor r11,r11
	mov r11,[p_col0]
	cmp r11b,1
	je almost_p_col0
	
	xor r11,r11
	mov r11,[p_col1]
	cmp r11b,1
	je almost_p_col1
	
	xor r11,r11
	mov r11,[p_col2]
	cmp r11b,1
	je almost_p_col2
	
	xor r11,r11
	mov r11,[p_col3]
	cmp r11b,1
	je almost_p_col3
	
	xor r11,r11
	mov r11,[p_diag1]
	cmp r11b,1
	je almost_p_diag1
	
	xor r11,r11
	mov r11,[p_diag2]
	cmp r11b,1
	je almost_p_diag2
; player ********************* player
	
	jmp default_ret
	
;; return values are opcode for "almost"
	
;; 8 (p=1 or c=2), 8 (row val), 8 (col val), 8 (diag 1 or 2)	

;; ********************************************
almost_p_row0:
	xor rax,rax
	mov rax,1088

	ret
almost_p_row1:
	xor rax,rax
	mov rax,1188
	
	ret
almost_p_row2:
	xor rax,rax
	mov rax,1288

	ret
almost_p_row3:
	xor rax,rax
	mov rax,1388

	ret
	
;; ********************************************
almost_p_col0:
	xor rax,rax
	mov rax,1808

	ret
almost_p_col1:
	xor rax,rax
	mov rax,1818

	ret
almost_p_col2:
	xor rax,rax
	mov rax,1828

	ret
almost_p_col3:
	xor rax,rax
	mov rax,1838

	ret
	
;; ********************************************
almost_p_diag1:
	xor rax,rax
	mov rax,1881

	ret

almost_p_diag2:
	xor rax,rax
	mov rax,1882

	ret
;;  ********************************************
almost_c_row0:
	xor rax,rax
	mov rax,2088

	ret
almost_c_row1:
	xor rax,rax
	mov rax,2188

	ret
almost_c_row2:
	xor rax,rax
	mov rax,2288

	ret
almost_c_row3:
	xor rax,rax
	mov rax,2388

	ret
;;********************************************
almost_c_col0:
	xor rax,rax
	mov rax,2808

	ret
almost_c_col1:
	xor rax,rax
	mov rax,2818

	ret
almost_c_col2:
	xor rax,rax
	mov rax,2828

	ret
almost_c_col3:
	xor rax,rax
	mov rax,2838

	ret
;; ********************************************

almost_c_diag1:
	xor rax,rax
	mov rax,2881

	ret

almost_c_diag2:
	xor rax,rax
	mov rax,2882

	ret
	
;; ********************************************
	

default_ret:
	xor rax,rax
	mov rax,0
	ret
	
WonUser:
	xor rax,rax
	mov rax,2
	ret
WonComp:
	xor rax,rax
	mov rax,3
	
	ret
