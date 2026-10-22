; Exercise: 12-debug-clobber-rax
;
; BUG HUNT: Should write "X\n" then exit 0. Register setup wrong before WriteFile. Fix in `ex_12_debug_clobber_rax`.
;
; Contract: implement `ex_12_debug_clobber_rax` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
msg BYTE "X", 13, 10
msg_len EQU $ - msg

.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_12_debug_clobber_rax:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_debug_clobber_rax in this file.
    call    ex_12_debug_clobber_rax
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
