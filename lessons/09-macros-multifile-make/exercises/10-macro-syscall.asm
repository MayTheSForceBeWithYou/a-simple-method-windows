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
EXTRN ex_10_macro_syscall:PROC

; TODO: Define WriteK MACRO (no args) that writes msg

main PROC
    sub     rsp, 40
    ; TODO: implement ex_10_macro_syscall (student routine; defined in solutions/).
    call    ex_10_macro_syscall
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
