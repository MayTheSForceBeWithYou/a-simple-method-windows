; Exercise 20: dot3
;
; dot (1,2,3)*(4,5,6)=32; exit 32.
; Expected exit: 32

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 1*4+2*5+3*6
    call ExitProcess
main ENDP
END
