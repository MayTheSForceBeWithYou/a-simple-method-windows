; 05-bytecode-interp.asm: Interpret bytecode: LOAD 10, LOAD 20, ADD, HALT → exit 30
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
