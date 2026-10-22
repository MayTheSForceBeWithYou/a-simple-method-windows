; Exercise: 11-debug-wrong-syscall
;
; BUG HUNT: Intends to exit status 3 but uses wrong function. Fix it.
;
; Contract: implement `ex_11_debug_wrong_syscall` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_11_debug_wrong_syscall:PROC

main PROC
    sub     rsp, 40
    ; BUG: see exercise description; implement fix in student routine.
    ; TODO: write ex_11_debug_wrong_syscall in this file.
    call    ex_11_debug_wrong_syscall
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
