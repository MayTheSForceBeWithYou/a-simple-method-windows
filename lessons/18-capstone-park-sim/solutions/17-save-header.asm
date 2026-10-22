; Exercise: 17-save-header
;
; Write magic+version size 8; exit 8.
; Expected stdout: (none)
; Expected exit: 8
;
.code
ex_17_save_header PROC
    sub rsp, 40
    mov rcx, 8
    mov     eax, 8
    add     rsp, 40
    ret
ex_17_save_header ENDP
main PROC
    sub     rsp, 40
    call    ex_17_save_header
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
