; Exercise: 23-debug-stdout-fd
;
; BUG HUNT: handle is wrong. Fix to stdout.
;
; Contract: implement `ex_23_debug_stdout_fd` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
msg BYTE "Hi", 13, 10
msg_len EQU $ - msg

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_23_debug_stdout_fd:PROC

main PROC
    sub     rsp, 40
    jmp     __ex_call
    mov rcx, 1                  ; BUG: not stdout handle — fix in ex_23_debug_stdout_fd
    lea rdx, msg
    mov r8d, msg_len
__ex_call:
    ; TODO: write ex_23_debug_stdout_fd in this file.
    call    ex_23_debug_stdout_fd
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
