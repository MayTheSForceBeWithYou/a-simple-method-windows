; 08-from-scratch-q8.asm: Q8.8 format: 8 int, 8 frac bits
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
