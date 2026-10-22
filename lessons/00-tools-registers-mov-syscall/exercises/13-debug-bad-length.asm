; Exercise: 13-debug-bad-length
;
; BUG HUNT: Writes "Hi\n" but length parameter too short. Fix via EQU.
;
; Contract: implement `ex_13_debug_bad_length` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
msg BYTE "Hi", 13, 10
msg_len EQU $ - msg

.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_13_debug_bad_length:PROC

main PROC
    sub     rsp, 40
    jmp     __ex_call
    mov rcx, 1
    lea rdx, msg
    mov r8d, 2                  ; BUG: length too small — fix in ex_13_debug_bad_length
    ; TODO: write ex_13_debug_bad_length in this file.
    call    ex_13_debug_bad_length
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
