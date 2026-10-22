; Exercise: 16-debug-callee-clobber
;
; BUG fixed: preserve rbx. Exit 11.
;
; Contract: implement `ex_16_debug_callee_clobber` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 11
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_16_debug_callee_clobber:PROC

helper PROC
    ; BUG: uses RBX without saving (nonvolatile in MS x64)
    mov rbx, 99
    mov rax, 1
    ret
helper ENDP

main PROC
    sub     rsp, 40
    mov     rbx, 11
    ; TODO: write ex_16_debug_callee_clobber in this file (fix helper, preserve rbx, exit 11).
    call    ex_16_debug_callee_clobber
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
