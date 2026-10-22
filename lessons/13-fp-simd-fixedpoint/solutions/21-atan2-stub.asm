; Exercise: 21-atan2-stub
;
; Stub: angle for (0,1) as 90 degrees; exit 90.
; Expected exit: 90
;
.code
ex_21_atan2_stub PROC
    sub rsp, 40
    mov     eax, 90
    add rsp, 40
    ret
ex_21_atan2_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_21_atan2_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
