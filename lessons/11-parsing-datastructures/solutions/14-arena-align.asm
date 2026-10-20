; Exercise 14: arena align
;
; Bump 1 then align to 8; bump becomes 8; exit 8.
; Expected exit: 8

EXTERN ExitProcess:PROC

.data?
bump QWORD ?

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [bump], 1
    mov rax, QWORD PTR [bump]
    add rax, 7
    and rax, NOT 7
    mov QWORD PTR [bump], rax
    mov rcx, rax
    call ExitProcess
main ENDP
END
