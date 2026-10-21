; 21-debug-fold-bug.asm: Debug: wrong precedence 1+2*3 → fix to get 7 not 9
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
