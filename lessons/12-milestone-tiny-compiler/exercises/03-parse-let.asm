; 03-parse-let.asm: Check first byte is 'l' (simplified keyword test), exit 1 if match
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
