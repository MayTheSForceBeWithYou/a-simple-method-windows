; Exercise 27: debug stack imbalance
;
; BUG: extra push without pop before ret corrupts return. Fix; exit 2.
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC FRAME
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    call two
    mov rcx, rax
    call ExitProcess
main ENDP

two PROC
    mov rax, 2
    ret
two ENDP
END
