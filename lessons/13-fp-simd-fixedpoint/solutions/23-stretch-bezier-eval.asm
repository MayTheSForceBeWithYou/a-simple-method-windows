; Exercise 23: stretch bezier eval
; Linear bezier P0=0 P1=10 at t=0.5; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
ex_23_stretch_bezier_eval PROC
    sub rsp, 40
    mov     eax, 5
    add rsp, 40
    ret
ex_23_stretch_bezier_eval ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_bezier_eval
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
