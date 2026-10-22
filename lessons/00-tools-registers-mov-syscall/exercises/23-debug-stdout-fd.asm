; Exercise: 23-debug-stdout-fd
;
; BUG HUNT: handle is wrong (uses 1, not GetStdHandle(STD_OUTPUT_HANDLE)). Fix in `write_hi_buggy` when you implement `ex_23_debug_stdout_fd`.
;
; Contract: implement `ex_23_debug_stdout_fd` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
msg BYTE "Hi", 13, 10
msg_len EQU $ - msg

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_23_debug_stdout_fd:PROC

; BUG: rcx=1 is not stdout — use GetStdHandle(-11) in ex_23_debug_stdout_fd.
write_hi_buggy PROC
    sub     rsp, 56
    mov     rcx, 1
    lea     rdx, msg
    mov     r8d, msg_len
    mov     r9, 0
    mov     QWORD PTR [rsp+32], 0
    mov     QWORD PTR [rsp+40], 0
    call    WriteFile
    mov     eax, 0
    add     rsp, 56
    ret
write_hi_buggy ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_23_debug_stdout_fd in this file (correct stdout handle; exit 0 in EAX).
    call    ex_23_debug_stdout_fd
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
