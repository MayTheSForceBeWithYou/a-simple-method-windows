; Exercise 05: dot2 fixed
;
; dot (1,2)*(3,4)=11; exit 11.
; Expected exit: 11

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 1*3+2*4
    call ExitProcess
main ENDP
END
