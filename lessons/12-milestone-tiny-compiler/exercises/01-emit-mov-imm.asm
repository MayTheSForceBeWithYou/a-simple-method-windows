; 01-emit-mov-imm.asm: Emit MOV immediate instruction (x64: mov rax, 42), exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_emit_mov_imm:PROC
main PROC
    ; TODO: write ex_01_emit_mov_imm in this file.
    call    ex_01_emit_mov_imm
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
