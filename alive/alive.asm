;alive.asm
section .data
    msg1 db "Hello, World!",10,0    ; Строка с NL и 0
    msg1Len equ $-msg1-1        ; length without 0
    msg2 db "Alive and Kicking!",10,0   ; Строка с NL и 0
    msg2Len equ $-msg2-1        ; length without 0
    radius dq 357               ; Это не строка, можно ли вывести?
    pi dq   3.14                ; Это не строка, можно ли вывести?
section .bss
section .text
    global main
main:
    push    rbp             ; СОХРАНИТЬ текущий указатель на стеке
    mov     rbp, rsp        ; устанавливаем стек в bp

    mov     rax, 1          ; write
    mov     rdi, 1          ; stdout
    mov     rsi, msg1       ; message address
    mov     rdx, msg1Len    ; message length
    syscall                 ; out to stdout

    mov     rax, 1          ; write
    mov     rdi, 1          ; stdout
    mov     rsi, msg2       ; message address
    mov     rdx, msg2Len    ; message length
    syscall                 ; out to stdout

    mov     rsp, rbp        ; restore stack
    pop     rbp

    mov     rax, 60	     ; exit system call
    mov     rdi, 0	
    syscall

