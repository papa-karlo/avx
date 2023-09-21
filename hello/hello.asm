
;hello.asm
section .data
	msg db "Hello, world AVX!",0dh, 0ah,0
section .bss
section .text
	global main
main:
	mov rax, 1 ; 1 = запись.
	mov rdi, 1 ; 1 = в поток стандартного вывода stdout.
	mov rsi, msg ; Выводимая строка в регистре rsi.
	mov rdx, 12+2 ; Длина строки без конечного 0.
	syscall ; Вывод строки.
	mov rax, 60 ; 60 = код выхода из программы.
	mov rdi, 0 ; 0 = код успешного завершения программы.
	syscall ; Выход из программы
	
	

