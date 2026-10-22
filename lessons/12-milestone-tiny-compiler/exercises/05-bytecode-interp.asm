; 05-bytecode-interp.asm: Interpret bytecode: LOAD 10, LOAD 20, ADD, HALT → exit 30
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_bytecode_interp:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_bytecode_interp in this file.
    call    ex_05_bytecode_interp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
