; Exercise: 06-path-step
;
; Follow next cell delta x+1; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_06_path_step PROC
    sub rsp, 40
    mov rcx, 1
    mov     eax, 1
    add     rsp, 40
    ret
ex_06_path_step ENDP
main PROC
    sub     rsp, 40
    call    ex_06_path_step
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
