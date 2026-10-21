; Exercise 20: steering seek
;
; Seek desired vel = target-pos; (10-3)=7; exit 7.
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 10
    sub rcx, 3
    call ExitProcess
main ENDP
END
