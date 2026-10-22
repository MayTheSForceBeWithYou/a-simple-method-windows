; Exercise: 20-alpha-stub
;
; Alpha blend stub: out=src if a=255; exit 7.
; Expected stdout: (none)
; Expected exit: 7
;
.code
ex_20_alpha_stub PROC
    sub rsp, 40
    mov rcx, 7
    mov     eax, 7
    add     rsp, 40
    ret
ex_20_alpha_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_20_alpha_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
