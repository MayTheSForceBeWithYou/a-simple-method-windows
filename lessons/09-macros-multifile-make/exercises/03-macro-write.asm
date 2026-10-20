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
.ERR <TODO: Macro to GetStdHandle, WriteFile>

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    ; TODO: Invoke macro, exit 0
    .ERR <TODO: Call macro, exit 0>
main ENDP
END
