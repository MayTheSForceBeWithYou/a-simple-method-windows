; 04-q16-clamp.asm: Clamp Q16.16 value to range [0, max]
; Expected exit: 100
; Expected stdout: (none)
; Clamp 150 to [0, 100], exit 100
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov rax, 150
    mov rbx, 100
    cmp rax, rbx
    jle no_clamp
    mov rax, rbx
no_clamp:
    mov ecx, eax
    call ExitProcess
main ENDP
END
