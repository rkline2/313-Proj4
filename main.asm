;;  Project 4
;;  Authors: Tehila Levin(NG71810) & Rooklyn Kline(TU79695)
;;  Description: In this project, we developed a game of
;;  tic tac toe where a player will be playing against
;;  the computer. Unlike regular titactoe, our game
;;  will be played on a 4x4 board.
	
	extern menu
	extern compEasy
	extern compHard

	section .data
new_line:		       db      10
easy:			       db      'a'
hard:			       db      'b'
quit:			       db      'q'

	section .bss
num_buff:		resq 2
menu_input:		resb 1

	section .text

	global main
main:
	xor r15,r15
	call menu
	mov byte[menu_input],al

	cmp byte[menu_input],97
	je goEasy
	
	cmp byte[menu_input],98
	je goHard
	
	jmp exit

goEasy:
	call compEasy
	jmp main

goHard:
	call compHard
	jmp main
exit:
	xor rax,rax
	mov rax,60
	xor rdi,rdi
	syscall
	
