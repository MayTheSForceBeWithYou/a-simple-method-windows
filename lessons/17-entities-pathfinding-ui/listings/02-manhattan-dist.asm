; Manhattan distance for A*, exit dist
; Expected exit: 5
; Expected stdout: (none)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov rax, 10
    mov rbx, 5
    sub rax, rbx
    test rax, rax
    jns pos1
    neg rax
pos1:
    mov ecx, eax
    call ExitProcess
main ENDP
END
