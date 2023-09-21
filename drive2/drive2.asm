;alive.asm
section .data
    msg1 db "Hello, World!",10,0    ; Строка с NL и 0
    msg1Len equ $-msg1-1        ; length without 0
    msg2 db "Alive and Kicking!",10,0   ; Строка с NL и 0
    msg2Len equ $-msg2-1        ; length without 0
    radius dd 357               ; Это не строка, можно ли вывести?
    pi     dq   3.14                ; Это не строка, можно ли вывести?
    fmtstr   db  "%s",10,0       ; string formating
    fmtflt   db  "%lf",10,0       ; float point formating
    fmtint   db  "%d",10,0       ; integer formating

section .bss
section .text
extern printf   ; external function printf from C library

    global main
main:
    mov rbp, rsp; for correct debugging
    push    rbp             ; СОХРАНИТЬ текущий указатель на стеке
    mov     rbp, rsp        ; устанавливаем стек в bp

    mov     rax, 0          ; without float point
    mov     rdi, fmtstr     ; format address
    mov     rsi, msg1       ; message address
    call    printf          ; out to stdout

    mov     rax, 0          ; without float point
    mov     rdi, fmtstr     ; format address
    mov     rsi, msg2       ; message address
    call    printf          ; out to stdout

    mov     rax, 0          ; without float point
    mov     rdi, fmtint     ; format address
    mov     rsi, [radius]   ; load value from address
    call    printf          ; out to stdout

    mov     rax, 1          ; use 1 register xmm
    mov     rdi, fmtflt     ; format address
    movq    xmm0, [pi]      ; load value from address
    call    printf          ; out to stdout

    mov     rsp, rbp        ; restore stack
    pop     rbp

    ret                     ; return from function


