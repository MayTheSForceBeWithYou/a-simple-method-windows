; Exercise: 19-extern-declare
;
; EXTERN for multi-file; local call exit 9.
; Expected exit: 9
;
.code
ex_19_extern_declare PROC
    sub rsp, 40
    
    call foo
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_19_extern_declare ENDP
main PROC
    sub     rsp, 40
    call    ex_19_extern_declare
    mov     rcx, rax
    call    ExitProcess
main ENDP

foo PROC
    mov rax, 9
    ret
foo ENDP
END
