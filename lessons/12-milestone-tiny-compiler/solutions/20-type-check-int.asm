; Exercise 20: type check int
;
; Type tag int=1; expression type int; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

TY_INT EQU 1

.code

ex_20_type_check_int PROC
mov rcx, TY_INT
    mov     eax, ecx
    ret
ex_20_type_check_int ENDP
main PROC
    sub     rsp, 40
    call    ex_20_type_check_int
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
