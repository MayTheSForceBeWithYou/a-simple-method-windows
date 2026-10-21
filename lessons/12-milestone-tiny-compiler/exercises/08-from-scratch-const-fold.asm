; 08-from-scratch-const-fold.asm: Fold (1+2)*3 with correct precedence, exit 9
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
