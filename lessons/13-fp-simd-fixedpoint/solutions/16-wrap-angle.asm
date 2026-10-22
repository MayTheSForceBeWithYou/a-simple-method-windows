; Exercise: 16-wrap-angle
;
; Wrap 400 degrees modulo 360; exit 40.
; Expected exit: 40
;
.code
ex_16_wrap_angle PROC
    sub rsp, 40
    mov rax, 400
    xor rdx, rdx
    mov rbx, 360
    div rbx
    mov     eax, edx
    add rsp, 40
    ret
ex_16_wrap_angle ENDP
main PROC
    sub     rsp, 40
    call    ex_16_wrap_angle
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
