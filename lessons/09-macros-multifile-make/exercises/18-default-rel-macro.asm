; 18-default-rel-macro.asm
; Print "hi\n", exit 0 (MASM uses RIP-relative by default in 64-bit).

.DATA
msg DB "hi", 13, 10
msgLen EQU $ - msg
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_18_default_rel_macro:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_18_default_rel_macro (student routine; defined in solutions/).
    call    ex_18_default_rel_macro
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
