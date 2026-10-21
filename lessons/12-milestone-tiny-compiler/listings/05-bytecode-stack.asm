; Listing 05: Stack bytecode interpreter (LESSON.md block 5)
; Expected exit: 9
; Expected stdout: (none)

.DATA
code DB 1, 4, 1, 5, 2, 0

.DATA?
st DQ 16 DUP(?)
sp_ QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     sp_, 0
    lea     rsi, code
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
    mov     rcx, sp_
    mov     st[rcx*8], rax
    inc     sp_
    jmp     fetch
add_op:
    dec     sp_
    mov     rcx, sp_
    mov     rax, st[rcx*8]
    dec     sp_
    mov     rcx, sp_
    add     rax, st[rcx*8]
    mov     rcx, sp_
    mov     st[rcx*8], rax
    inc     sp_
    jmp     fetch
halt:
    dec     sp_
    mov     rcx, sp_
    mov     rax, st[rcx*8]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
