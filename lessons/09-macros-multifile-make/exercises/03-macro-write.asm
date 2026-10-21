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

; TODO: Define WriteMsgMacro

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    ; TODO: Invoke macro, exit 0

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
