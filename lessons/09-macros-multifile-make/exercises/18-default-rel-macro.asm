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

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    ; TODO: GetStdHandle, WriteFile, exit 0
    .ERR <TODO: Write "hi\n", exit 0>
main ENDP
END
