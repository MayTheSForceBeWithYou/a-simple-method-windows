; Exercise: 15-debug-wrong-arg-reg
;
; BUG fixed: use rdx. add(2,40)=42. MS x64 ABI.
;
; Contract: implement `ex_15_debug_wrong_arg_reg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_15_debug_wrong_arg_reg:PROC

add2 PROC
    mov rax, rcx
    add rax, rdx
    ret
add2 ENDP

main PROC
    sub     rsp, 40
    mov     rcx, 2
    mov     rsi, 40                ; BUG: second arg must be in RDX for add2
    ; TODO: write ex_15_debug_wrong_arg_reg in this file (correct arg regs, call add2).
    call    ex_15_debug_wrong_arg_reg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
