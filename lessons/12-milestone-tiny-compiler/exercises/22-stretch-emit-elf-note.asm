; 22-stretch-emit-elf-note.asm: Track ELF note section size, exit size
.CODE
EXTRN ExitProcess:PROC
main PROC

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
