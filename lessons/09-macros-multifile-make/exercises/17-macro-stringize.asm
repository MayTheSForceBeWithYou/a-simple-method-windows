; 17-macro-stringize.asm
; Stores string "Q\n", exit 0 (no stringification in MASM).

.DATA
msg DB "Q", 13, 10
msgLen EQU $ - msg
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_17_macro_stringize:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_macro_stringize in this file.
    call    ex_17_macro_stringize
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
