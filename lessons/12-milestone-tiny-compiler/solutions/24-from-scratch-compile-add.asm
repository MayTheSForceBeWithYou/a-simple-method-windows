; Exercise 24: from scratch compile add
;
; FROM SCRATCH: compile-time eval of 40+2; exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
ex_24_from_scratch_compile_add PROC
    sub rsp, 40
    mov rcx, 40
    add rcx, 2
    mov     eax, ecx
    add     rsp, 40
    ret
ex_24_from_scratch_compile_add ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_compile_add
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
