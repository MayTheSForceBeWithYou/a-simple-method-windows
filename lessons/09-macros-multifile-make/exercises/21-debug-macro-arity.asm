; Exercise: 21-debug-macro-arity
;
; BUG: macro invoked with wrong arg count conceptually; fix EXIT_STATUS 4.
;
; Contract: implement `ex_21_debug_macro_arity` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_21_debug_macro_arity:PROC

EXIT_STATUS MACRO status, skew:=<1>
    mov ecx, status
    add ecx, skew               ; BUG: second macro arg should not exist
    call ExitProcess
ENDM

main PROC
    sub     rsp, 40
    jmp     __ex_call
    EXIT_STATUS 4, 1            ; BUG: fix macro arity and use EXIT_STATUS 4 in ex_21
    ; TODO: write ex_21_debug_macro_arity in this file.
    call    ex_21_debug_macro_arity
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
