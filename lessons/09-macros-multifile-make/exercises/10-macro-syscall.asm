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

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    ; TODO: Invoke WriteK

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
