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

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    ; TODO: GetStdHandle, WriteFile msg, exit 0
    .ERR <TODO: Write "Q\n", exit 0>
main ENDP
END
