; Exercise: 21-debug-macro-arity
;
; BUG: EXIT_STATUS macro has an extra skew arg; fix macro and use EXIT_STATUS 4 in ex_21_debug_macro_arity.
;
; Contract: implement `ex_21_debug_macro_arity` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_21_debug_macro_arity:PROC

EXIT_STATUS MACRO status, skew:=<1>
    mov ecx, status
    add ecx, skew               ; BUG: drop skew parameter; macro should take only status
    call ExitProcess
ENDM

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_debug_macro_arity in this file (fixed macro; exit 4 via EAX return path).
    call    ex_21_debug_macro_arity
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
