; 02-fixed-add.asm: Add Q16.16: 1.5 + 2.5, exit 4
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
