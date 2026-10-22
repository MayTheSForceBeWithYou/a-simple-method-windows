; Exercise: 06-quit-flag
;
; quit dq 1; exit quit.
; Expected stdout: (none)
; Expected exit: 1
;
.data
quit QWORD 1

.code
ex_06_quit_flag PROC
    sub rsp, 40
    mov rcx, [quit]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_06_quit_flag ENDP
main PROC
    sub     rsp, 40
    call    ex_06_quit_flag
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
