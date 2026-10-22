; Exercise 22: stretch color interp
; Lerp 0..100 at t=0.5 in Q16.16; exit 50.
; Expected exit: 50

EXTERN ExitProcess:PROC

.code
ex_22_stretch_color_interp PROC
    sub rsp, 40
    mov rax, 100
    shl rax, 16
    shr rax, 1
    shr rax, 16
    mov     eax, eax
    add rsp, 40
    ret
ex_22_stretch_color_interp ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_color_interp
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
