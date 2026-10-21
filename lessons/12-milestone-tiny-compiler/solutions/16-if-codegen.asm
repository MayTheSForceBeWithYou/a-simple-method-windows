; Exercise 16: if codegen
;
; if 1 then 7 else 9; exit 7.
; Expected exit: 7

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 1
    test rax, rax
    jz else_branch
    mov rcx, 7
    jmp done
else_branch:
    mov rcx, 9
done:
    call ExitProcess
main ENDP
END
