; 01-keymap: keymap
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_keymap:PROC
main PROC
    ; TODO: implement ex_01_keymap (student routine; defined in solutions/).
    call    ex_01_keymap
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
