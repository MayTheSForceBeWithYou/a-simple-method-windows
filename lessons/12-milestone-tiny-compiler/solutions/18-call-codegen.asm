; Exercise 18: call codegen
;
; Compile call: function returns 11; exit 11.
; Expected exit: 11

EXTERN ExitProcess:PROC

.code

ex_18_call_codegen PROC
call f
    mov rcx, rax
    mov     eax, ecx
    ret
ex_18_call_codegen ENDP
main PROC
    sub     rsp, 40
    call    ex_18_call_codegen
    mov     rcx, rax
    call    ExitProcess
main ENDP

f PROC
    mov rax, 11
    ret
f ENDP
END
