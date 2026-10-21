; 19-debug-mul-overflow.asm: Debug: fix Q16.16 mul overflow
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
