; Exercise: 17-floor-fixed
;
; Floor Q16.16 3.75 (3<<16 + 49152); exit 3.
; Expected exit: 3
;
.code
ex_17_floor_fixed PROC
    sub rsp, 40
    mov eax, 3
    shl eax, 16
    add eax, 49152
    sar eax, 16
    mov     eax, eax
    add rsp, 40
    ret
ex_17_floor_fixed ENDP
main PROC
    sub     rsp, 40
    call    ex_17_floor_fixed
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
