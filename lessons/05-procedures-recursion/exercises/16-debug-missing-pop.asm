; Exercise: 16-debug-missing-pop
;
; BUG fixed: balanced stack. fact(3)=6.
;
; Contract: implement `ex_16_debug_missing_pop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_16_debug_missing_pop:PROC

fact PROC
    cmp rcx, 1
    jle fact_base
    push rcx
    sub rsp, 40
    dec rcx
    call fact
    add rsp, 40
    ; BUG: missing POP RCX before IMUL
    imul rax, rcx
    ret
fact_base:
    mov rax, 1
    ret
fact ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_16_debug_missing_pop in this file (balanced fact).
    call    ex_16_debug_missing_pop
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
