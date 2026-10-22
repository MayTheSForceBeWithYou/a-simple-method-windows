; 01-keymap: keymap
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_keymap:PROC
main PROC
    ; TODO: write ex_01_keymap in this file.
    call    ex_01_keymap
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
