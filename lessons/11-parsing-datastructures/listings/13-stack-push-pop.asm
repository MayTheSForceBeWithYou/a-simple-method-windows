; Listing 13: Array stack push/pop (LESSON.md block 13)
; Expected exit: 2
; Expected stdout: (none)

.DATA?
stk DQ 16 DUP(?)
stack_sp QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, stk
    mov     stack_sp, 0
    mov     rdi, 1
    mov     rcx, stack_sp
    mov     QWORD PTR [r10+rcx*8], rdi
    inc     stack_sp
    mov     rdi, 2
    mov     rcx, stack_sp
    mov     QWORD PTR [r10+rcx*8], rdi
    inc     stack_sp
    dec     stack_sp
    mov     rcx, stack_sp
    mov     rax, QWORD PTR [r10+rcx*8]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
