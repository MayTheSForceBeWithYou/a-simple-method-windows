; 24-from-scratch-compile-add.asm: Full: lex "a+b", parse, emit code, exit 0
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
