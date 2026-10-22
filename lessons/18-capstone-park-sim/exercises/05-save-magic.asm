; 05-save-magic: save magic
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_save_magic:PROC
main PROC
    ; TODO: write ex_05_save_magic in this file.
    call    ex_05_save_magic
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
