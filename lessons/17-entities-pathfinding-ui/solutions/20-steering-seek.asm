; Exercise 20: steering seek
;
; Seek desired vel = target-pos; (10-3)=7; exit 7.
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_20_steering_seek PROC
    sub rsp, 40
    mov rcx, 10
    sub rcx, 3
    mov     eax, 7
    ret
ex_20_steering_seek ENDP
main PROC
    call    ex_20_steering_seek
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
