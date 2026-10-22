; Exercise: 15-getpid
;
; GetCurrentProcessId; exit 0 if the pid is nonzero, else 1.
; Expected exit: 0
;
.code
ex_15_getpid PROC
    sub rsp, 40
    
    call GetCurrentProcessId
    test eax, eax
    setz cl
    movzx rcx, cl
    mov     eax, ecx
    add     rsp, 40
    ret
ex_15_getpid ENDP
main PROC
    sub     rsp, 40
    call    ex_15_getpid
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
