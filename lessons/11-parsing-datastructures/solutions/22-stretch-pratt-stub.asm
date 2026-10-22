; Exercise 22: stretch pratt stub
;
; STRETCH: binding power for + is 10, for * is 20; exit 20.
; Expected exit: 20

EXTERN ExitProcess:PROC

.code

ex_22_stretch_pratt_stub PROC
mov rcx, 20
    mov     eax, ecx
    ret
ex_22_stretch_pratt_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_pratt_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
