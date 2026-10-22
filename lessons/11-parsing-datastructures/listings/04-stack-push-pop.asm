; 04-stack-push-pop.asm: Explicit stack (array+index), push 42, pop, exit popped value
; Expected exit: 42
; Expected stdout: (none)
.DATA?
stack_data DQ 16 DUP(?)
stack_top QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea     r10, stack_data
    mov     stack_top, 0
    mov     rax, 42
    mov     rbx, stack_top
    mov     QWORD PTR [r10+rbx*8], rax
    inc     stack_top
    dec     stack_top
    mov     rbx, stack_top
    mov     rax, QWORD PTR [r10+rbx*8]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
