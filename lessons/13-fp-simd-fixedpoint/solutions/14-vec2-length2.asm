; Exercise 14: vec2 length2
;
; length^2 of (3,4)=25; exit 25.
; Expected exit: 25

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 3
    imul rax, rax
    mov rbx, 4
    imul rbx, rbx
    add rax, rbx
    mov rcx, rax
    call ExitProcess
main ENDP
END
