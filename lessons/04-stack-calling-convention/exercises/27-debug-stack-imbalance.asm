; Exercise: 27-debug-stack-imbalance
;
; BUG: extra push without pop before ret corrupts return. Fix; exit 2.
; Expected stdout: (none)
;
; Contract: implement `ex_27_debug_stack_imbalance` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_27_debug_stack_imbalance:PROC

two PROC
    mov rax, 2
    push rax                ; BUG: extra push before RET
    ret
two ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_27_debug_stack_imbalance in this file (balance stack around two).
    call    ex_27_debug_stack_imbalance
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
