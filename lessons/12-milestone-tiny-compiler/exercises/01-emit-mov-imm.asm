; 01-emit-mov-imm.asm: Emit MOV immediate instruction (x64: mov rax, 42), exit 0
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
