; Listing 13: Array stack push/pop (LESSON.md block 13)
; Expected exit: 2
; Expected stdout: (none)

.DATA?
stk DQ 16 DUP(?)
sp QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     sp, 0
    mov     rdi, 1
    mov     rcx, sp
    mov     stk[rcx*8], rdi
    inc     sp
    mov     rdi, 2
    mov     rcx, sp
    mov     stk[rcx*8], rdi
    inc     sp
    dec     sp
    mov     rcx, sp
    mov     rax, stk[rcx*8]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
