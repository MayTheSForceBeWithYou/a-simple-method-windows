; Exercise 18: call codegen
;
; Compile call: function returns 11; exit 11.
; Expected exit: 11

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    call f
    mov rcx, rax
    call ExitProcess
main ENDP

f PROC
    mov rax, 11
    ret
f ENDP
END
