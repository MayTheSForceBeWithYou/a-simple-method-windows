; Exercise 21: debug macro arity
;
; BUG: macro invoked with wrong arg count conceptually; fix EXIT_STATUS 4.
;
; Build: ml64 /c 21-debug-macro-arity.asm && link /OUT:21-debug-macro-arity.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-debug-macro-arity.obj kernel32.lib
;
; Expected exit: 4

EXTERN ExitProcess:PROC

; MASM macro with single parameter
EXIT_STATUS MACRO code
    mov rcx, code
    call ExitProcess
ENDM

.code
ex_21_debug_macro_arity PROC
    sub rsp, 40
    EXIT_STATUS 4
ex_21_debug_macro_arity ENDP
main PROC
    sub     rsp, 40
    call    ex_21_debug_macro_arity
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
