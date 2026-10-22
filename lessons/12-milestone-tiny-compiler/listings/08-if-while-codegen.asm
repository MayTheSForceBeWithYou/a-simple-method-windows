; Listing 08: if-then-else and while loop codegen shapes
; Expected exit: 3
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     rax, 1
    test    rax, rax
    jz      else_branch
    mov     rax, 7
    jmp     after_if
else_branch:
    mov     rax, 9
after_if:
    xor     rcx, rcx
while_test:
    cmp     rcx, 3
    jge     while_done
    inc     rcx
    jmp     while_test
while_done:
    mov     ecx, ecx
    call    ExitProcess
main ENDP
END
