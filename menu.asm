	
	section .data
intro:		db "Welcome to TIC-TAC-ASSEMBLY",10
len_i:		equ $-intro
ask_route:	db "Pick an option from the menu below:",10
len_a:		equ $-ask_route
err:		db "Invalid Input!",10
len_e:		equ $-err
easter_egg:	db  "Free Xbox Series X -> visit imfailingassembly.com!",10
len_egg:	equ $-easter_egg	
opts:		db "a - Easy",10,"b - Hard",10,"q - quit", 10	
len_o:		equ $-opts
	section .bss
lett_buff:	resb	2
	
	section .text
	global menu

menu:
	xor r14,r14
menu2:
        
	;; parameters goes as follow: rdi,rsi,rdx,rcx,r8,r9
	;; rax value is returned
	
	;; printf("Welcome to TIC-TAC-ASSEMBLY\n")
	xor rdi,rdi
	xor rsi,rsi
	xor rax,rax
	
	mov rax,1		
        mov rdi,1
        mov rsi,intro
        mov rdx,len_i
        syscall
	
	;; printf("Pick an option from the menu below:\n")
	xor rdi,rdi
        xor rsi,rsi
        xor rax,rax

	
	mov rax,1		
        mov rdi,1
        mov rsi,ask_route
        mov rdx,len_a
        syscall
	
	
	;; displays all the options
	xor rdi,rdi
        xor rsi,rsi
        xor rax,rax

	mov rax,1		
        mov rdi,1
        mov rsi,opts
        mov rdx,len_o
        syscall
	
	;; scanf("%c")
	xor rdi,rdi
        xor rsi,rsi
        xor rax,rax

	
	mov rax,0		
        mov rdi,0		
        mov rsi,lett_buff
        mov rdx,2
        syscall
	

	;; rbx = lett_buff
	xor rbx,rbx
	mov bl,[lett_buff]

        	
	;; checks if input is valid
	cmp bl,97		; lett_buff == a?
	je quit

	cmp bl,98		; lett_buff == b?
	je quit

	cmp bl,113		; lett_buff == q?
	je quit
	
	cmp bl,99		;easter egg
	jne restart
	jmp easteregg
	
restart:
	xor r14,r14
	jmp invalid
	
invalid:	
	;; print("Invalid Input!")
	xor rdi,rdi
        xor rsi,rsi
        xor rax,rax

	mov rax,1               ; displaying prompt to user
        mov rdi,1
        mov rsi,err
        mov rdx,len_e
        syscall

		;; repeat until input is valid
	jmp menu2
	
easteregg:
	inc r14
	cmp r14,4
	je activated
	jmp invalid
activated:
	xor rdi,rdi
        xor rsi,rsi
        xor rax,rax

	mov rax,1               
        mov rdi,1
        mov rsi,easter_egg
        mov rdx,len_egg
        syscall
        
	jmp menu

quit:

	;; rax = lett_buff
	mov al,[lett_buff]
	
	ret
	




