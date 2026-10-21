; 01-fixed-mul.asm: Multiply Q16.16: 2.0 * 3.0, exit 6
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
