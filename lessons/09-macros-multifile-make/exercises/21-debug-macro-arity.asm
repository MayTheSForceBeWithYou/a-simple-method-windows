; Exercise: 21-debug-macro-arity
;
; Exercise 21: debug macro arity
; BUG: macro invoked with wrong arg count conceptually; fix EXIT_STATUS 4.
;
; Contract: implement `ex_21_debug_macro_arity` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;

; Exercise 21: debug macro arity
; BUG: EXIT_STATUS should take one argument (4). Extra macro parameter skews the exit code.
; Expected exit: 4

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_debug_macro_arity:PROC

EXIT_STATUS MACRO status, skew:=<1>
    mov ecx, status
    add ecx, skew               ; BUG: second macro arg should not exist
    call ExitProcess
ENDM

main PROC
    sub     rsp, 40
    jmp     __ex_call
    EXIT_STATUS 4, 1            ; BUG: fix macro arity and use EXIT_STATUS 4 in ex_21
__ex_call:
    ; TODO: write ex_21_debug_macro_arity in this file.
    call    ex_21_debug_macro_arity
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
