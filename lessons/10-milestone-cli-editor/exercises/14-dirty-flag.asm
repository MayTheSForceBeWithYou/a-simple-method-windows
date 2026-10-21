; 14-dirty-flag.asm: Set dirty=1 on edit, clear on save, exit dirty
.DATA?
dirty QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov dirty, 0

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
