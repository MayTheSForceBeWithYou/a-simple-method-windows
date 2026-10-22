; Exercise: 13-variadic-max
;
; max_n(n, ...) MS x64: rcx=count, args on stack. max(3, 5,1,9)=9.
;
; Contract: implement `ex_13_variadic_max` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_variadic_max:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_13_variadic_max in this file.
    call    ex_13_variadic_max
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
