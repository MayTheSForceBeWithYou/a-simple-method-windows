; Convert tile coords to index, exit index
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov rax, 3
    mov rbx, 16
    imul rax, rbx
    add rax, 5
    mov ecx, eax
    call ExitProcess
main ENDP
END
