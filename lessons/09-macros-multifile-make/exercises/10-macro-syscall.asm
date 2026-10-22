; Exercise: 10-macro-syscall
;
; Exercise 10: macro syscall
; MACRO CALL_FUNC for calling ExitProcess; Print "K\n" exit 0.
; Expected stdout: "K\n"
;
; Contract: implement `ex_10_macro_syscall` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

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
    ; TODO: write ex_10_macro_syscall in this file.
    call    ex_10_macro_syscall
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
