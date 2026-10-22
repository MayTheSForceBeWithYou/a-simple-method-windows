; Exercise: 01-exit-zero
;
; Exit with status 0 using ExitProcess.
; Expected exit: 0
;
.code
ex_01_exit_zero PROC
    sub rsp, 40
    mov rcx, 0
    mov     eax, 0
    add     rsp, 40
    ret
ex_01_exit_zero ENDP
main PROC
    sub     rsp, 40
    call    ex_01_exit_zero
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
