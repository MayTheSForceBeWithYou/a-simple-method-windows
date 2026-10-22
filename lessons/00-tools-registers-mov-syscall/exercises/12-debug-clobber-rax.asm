; Exercise: 12-debug-clobber-rax
;
; BUG HUNT: Should write "X\n" then exit 0. Register set wrong before write. Fix.
;
; Contract: implement `ex_12_debug_clobber_rax` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
msg BYTE "X", 13, 10
msg_len EQU $ - msg

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_12_debug_clobber_rax:PROC

main PROC
    sub     rsp, 40
    jmp     __ex_call
    mov rcx, 1                  ; BUG: wrong handle — fix in ex_12_debug_clobber_rax
    lea rdx, msg
    mov r8d, msg_len
    mov rax, rcx                ; BUG: clobbered RAX before syscall-style setup
__ex_call:
    ; TODO: write ex_12_debug_clobber_rax in this file.
    call    ex_12_debug_clobber_rax
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
