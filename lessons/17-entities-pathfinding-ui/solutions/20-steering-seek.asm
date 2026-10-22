; Exercise 20: steering seek
;
; Seek desired vel = target-pos; (10-3)=7; exit 7.
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_20_steering_seek PROC
mov rcx, 10
    sub rcx, 3
    mov     eax, ecx
    ret
ex_20_steering_seek ENDP
main PROC
    sub     rsp, 40
    call    ex_20_steering_seek
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
