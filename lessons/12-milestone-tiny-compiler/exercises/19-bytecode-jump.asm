; 19-bytecode-jump.asm: Bytecode jump instruction (set IP), exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_bytecode_jump:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_19_bytecode_jump in this file.
    call    ex_19_bytecode_jump
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
