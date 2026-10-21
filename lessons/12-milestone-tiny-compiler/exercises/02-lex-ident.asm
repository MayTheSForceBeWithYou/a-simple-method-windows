; 02-lex-ident.asm: Test if byte is lowercase letter ('a'..'z'), exit 1 if true
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
