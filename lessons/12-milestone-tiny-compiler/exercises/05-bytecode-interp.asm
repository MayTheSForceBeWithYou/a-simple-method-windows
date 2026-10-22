; 05-bytecode-interp.asm: Interpret bytecode: LOAD 10, LOAD 20, ADD, HALT → exit 30
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_bytecode_interp:PROC
main PROC
    ; TODO: implement ex_05_bytecode_interp (student routine; defined in solutions/).
    call    ex_05_bytecode_interp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
