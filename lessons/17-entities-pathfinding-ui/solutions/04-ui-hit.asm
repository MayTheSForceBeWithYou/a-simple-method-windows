; Exercise: 04-ui-hit
;
; Point in panel -> 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_04_ui_hit PROC
    sub rsp, 40
    mov rcx, 1
    mov     eax, 1
    add     rsp, 40
    ret
ex_04_ui_hit ENDP
main PROC
    sub     rsp, 40
    call    ex_04_ui_hit
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
