; 17-floor-fixed.asm: Floor Q16.16 (clear frac bits), exit int
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
