; 05-save-magic: save magic
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_save_magic:PROC
main PROC
    ; TODO: implement ex_05_save_magic (student routine; defined in solutions/).
    call    ex_05_save_magic
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
