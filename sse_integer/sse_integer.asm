;sse_integer.asm

extern printf   ; external function printf from C library

section .data
; single precision
align 16
    pdivector1   dd  1
                dd  2
                dd  3
                dd  4
    pdivector2   dd  5
                dd  6
                dd  7
                dd  8
    fmt1   db  "Packet Integer Vector 1: %d, %d, %d, %d",10,0       ; string formating
    fmt2   db  "Packet Integer Vector 2: %d, %d, %d, %d",10,0       ; string formating
    fmt3   db  "Sum Vector: %d, %d, %d, %d",10,0                    ; string formating
    fmt4   db  "Reverse of Sum Vector: %d, %d, %d, %d",10,0         ; string formating

section .bss
align 16
    pdivector_res    resd 4
    pdivector_other  resd 4

section .text


    global main
main:
    mov rbp, rsp; for correct debugging
    push    rbp             ; СОХРАНИТЬ текущий указатель на стеке
    mov     rbp, rsp        ; устанавливаем стек в bp

    ; output vector 1
    mov     rsi,pdivector1
    mov     rdi,fmt1
    call    printpdi

    ; output vector 2
    mov     rsi,pdivector2
    mov     rdi,fmt2
    call    printpdi

    ; add vector 1 & 2
    movdqa  xmm0, [pdivector1]
    paddd   xmm0, [pdivector2]
    ; store result to memory
    movdqa  [pdivector_res], xmm0
    ; output result
    mov     rsi,pdivector_res
    mov     rdi,fmt3
    call    printpdi

    ; copy result to register xmm3
    movdqa  xmm3, [pdivector_res]
    ; copy from xmm3 to common registers
    pextrd  eax, xmm3, 0
    pextrd  ebx, xmm3, 1
    pextrd  ecx, xmm3, 2
    pextrd  edx, xmm3, 3
    ; word reorder for xmm0
    pinsrd  xmm0, eax, 3
    pinsrd  xmm0, ebx, 2
    pinsrd  xmm0, ecx, 1
    pinsrd  xmm0, edx, 0
    ; output reorder result
    movdqa  [pdivector_other], xmm0
    mov     rsi,pdivector_other
    mov     rdi,fmt4
    call    printpdi

    leave
    ret                     ; return from function


printpdi:
    push        rbp
    mov         rbp,rsp
    movdqa      xmm0, [rsi]
    pextrd  esi, xmm0, 0
    pextrd  edx, xmm0, 1
    pextrd  ecx, xmm0, 2
    pextrd  r8d, xmm0, 3
    mov         rax,0       ; not float point
    call        printf
    leave
    ret

