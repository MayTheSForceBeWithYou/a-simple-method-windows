; Exercise 27: debug stack imbalance
;
; BUG: extra push without pop before ret corrupts return. Fix; exit 2.
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_27_debug_stack_imbalance PROC
.ALLOCSTACK 40
    .ENDPROLOG
    call two
    mov rcx, rax
    mov     eax, rax
    ret
ex_27_debug_stack_imbalance ENDP
main PROC
    sub     rsp, 40
    call    ex_27_debug_stack_imbalance
    mov     rcx, rax
    call    ExitProcess
main ENDP

two PROC
    mov rax, 2
    ret
two ENDP
END
