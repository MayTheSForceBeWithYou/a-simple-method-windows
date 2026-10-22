; Exercise: 08-from-scratch-rol
;
; Expected exit: 1
;
.code
ex_08_from_scratch_rol PROC
    sub rsp, 40
    mov al, 80h
    rol al, 1
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_08_from_scratch_rol ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_rol
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
