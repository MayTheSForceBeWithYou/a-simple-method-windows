; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_08_from_scratch_rol PROC
    sub rsp, 40
    mov al, 80h
    rol al, 1
    movzx rcx, al
    mov     eax, 1
    ret
    add     rsp, 40
ex_08_from_scratch_rol ENDP
main PROC
    call    ex_08_from_scratch_rol
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
