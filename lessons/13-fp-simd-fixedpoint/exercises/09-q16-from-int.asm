; 09-q16-from-int.asm: Encode 5 in Q16.16, decode, exit 5
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
