; 10-q16-frac.asm: Two halves (0.5+0.5=1.0), exit 1
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
