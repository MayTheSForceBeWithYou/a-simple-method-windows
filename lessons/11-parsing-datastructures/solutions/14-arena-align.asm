; Exercise 14: arena align
;
; Bump 1 then align to 8; bump becomes 8; exit 8.
; Expected exit: 8

EXTERN ExitProcess:PROC

.data?
bump QWORD ?

.code
ex_14_arena_align PROC
    sub rsp, 40
    mov QWORD PTR [bump], 1
    mov rax, QWORD PTR [bump]
    add rax, 7
    and rax, NOT 7
    mov QWORD PTR [bump], rax
        mov     eax, rax
    add     rsp, 40
    ret
ex_14_arena_align ENDP
main PROC
    sub     rsp, 40
    call    ex_14_arena_align
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
