; 03-macro-write.asm
; Macro writes "M\n", exit 0.
; Task: Define macro that gets stdout and writes message.

.DATA
msg DB "M", 13, 10
msgLen EQU $ - msg
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_03_macro_write:PROC

; TODO: Define WriteMsgMacro

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_macro_write in this file.
    call    ex_03_macro_write
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
