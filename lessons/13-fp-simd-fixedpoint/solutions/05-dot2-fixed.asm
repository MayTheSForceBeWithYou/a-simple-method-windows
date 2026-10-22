; Exercise 05: dot2 fixed
;
; dot (1,2)*(3,4)=11; exit 11.
; Expected exit: 11

EXTERN ExitProcess:PROC

.code
ex_05_dot2_fixed PROC
    sub rsp, 40
        mov     eax, 1*3+2*4
    ret

ex_05_dot2_fixed ENDP
main PROC
    call    ex_05_dot2_fixed
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
