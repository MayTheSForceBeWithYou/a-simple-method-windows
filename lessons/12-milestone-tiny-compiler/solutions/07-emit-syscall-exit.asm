; Exercise 07: emit syscall exit
;
; Hand-written 'codegen' template exits status 0.
; Expected exit: 0

EXTERN ExitProcess:PROC

.code

ex_07_emit_syscall_exit PROC
xor rcx, rcx
    mov     eax, 0
    ret
ex_07_emit_syscall_exit ENDP
main PROC
    sub     rsp, 40
    call    ex_07_emit_syscall_exit
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
