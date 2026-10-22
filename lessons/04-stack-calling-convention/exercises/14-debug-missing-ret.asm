; Exercise: 14-debug-missing-ret
;
; BUG fixed: added ret. Exit 3.
;
; Contract: implement `ex_14_debug_missing_ret` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_debug_missing_ret:PROC

three PROC
    mov rax, 3
    ; BUG: missing RET — falls through if called
three ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_14_debug_missing_ret in this file (call three with a proper RET).
    call    ex_14_debug_missing_ret
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
