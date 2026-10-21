; 03-const-fold.asm: Fold constant expression (1+2)*3, exit 9
; Demonstrates precedence: * before +
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov rax, 1
    add rax, 2
    imul rax, 3
    mov ecx, eax
    call ExitProcess
main ENDP
END
