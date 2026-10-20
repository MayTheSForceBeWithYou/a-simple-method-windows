; Exercise 12: parse paren
;
; (1+2)*3 = 9; exit 9.
; Expected exit: 9

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 1
    add rax, 2
    imul rax, 3
    mov rcx, rax
    call ExitProcess
main ENDP
END
