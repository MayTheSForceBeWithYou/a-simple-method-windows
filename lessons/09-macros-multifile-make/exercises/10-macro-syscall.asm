; 10-macro-syscall.asm
; Zero-arg macro writes "K\n", exit 0.

.DATA
msg DB "K", 13, 10
msgLen EQU $ - msg
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

; TODO: Define WriteK MACRO (no args) that writes msg
.ERR <TODO: Define zero-argument macro>

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    ; TODO: Invoke WriteK
    .ERR <TODO: Invoke macro, exit 0>
main ENDP
END
