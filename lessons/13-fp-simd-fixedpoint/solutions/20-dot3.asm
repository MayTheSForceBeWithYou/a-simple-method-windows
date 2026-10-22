; Exercise 20: dot3
;
; dot (1,2,3)*(4,5,6)=32; exit 32.
; Expected exit: 32

EXTERN ExitProcess:PROC

.code

ex_20_dot3 PROC
mov rcx, 1*4+2*5+3*6
    mov     eax, ecx
    ret
ex_20_dot3 ENDP
main PROC
    sub     rsp, 40
    call    ex_20_dot3
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
