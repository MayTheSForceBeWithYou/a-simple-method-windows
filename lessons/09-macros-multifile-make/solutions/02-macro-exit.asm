; Exercise 02: macro exit
;
; MACRO exit_with code ... ENDM; exit 7.
;
; Build: ml64 /c 02-macro-exit.asm && link /OUT:02-macro-exit.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-macro-exit.obj kernel32.lib
;
; Expected exit: 7

EXTERN ExitProcess:PROC

; MASM macro with named parameter
exit_with MACRO code
    mov rcx, code
    call ExitProcess
ENDM

.code
ex_02_macro_exit PROC
    sub rsp, 40
    exit_with 7
    add     rsp, 40
ex_02_macro_exit ENDP
main PROC
    call    ex_02_macro_exit
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
