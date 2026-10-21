; Listing 05: Stack bytecode interpreter (LESSON.md block 5)
; Expected exit: 9
; Expected stdout: (none)

.DATA
bytecode DB 1, 4, 1, 5, 2, 0

.DATA?
stack_mem DQ 16 DUP(?)
stack_sp QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     stack_sp, 0
    lea     rsi, bytecode
    lea     rdi, stack_mem
fetch:
    movzx   rax, BYTE PTR [rsi]
    inc     rsi
    cmp     rax, 0
    je      halt
    cmp     rax, 1
    je      push_op
    cmp     rax, 2
    je      add_op
    mov     ecx, 255
    call    ExitProcess
push_op:
    movzx   rax, BYTE PTR [rsi]
    inc     rsi
    mov     rcx, stack_sp
    mov     QWORD PTR [rdi+rcx*8], rax
    inc     stack_sp
    jmp     fetch
add_op:
    dec     stack_sp
    mov     rcx, stack_sp
    mov     rax, QWORD PTR [rdi+rcx*8]
    dec     stack_sp
    mov     rcx, stack_sp
    add     rax, QWORD PTR [rdi+rcx*8]
    mov     rcx, stack_sp
    mov     QWORD PTR [rdi+rcx*8], rax
    inc     stack_sp
    jmp     fetch
halt:
    dec     stack_sp
    mov     rcx, stack_sp
    mov     rax, QWORD PTR [rdi+rcx*8]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
