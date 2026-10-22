; 09-key-down-up: key down up
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_key_down_up:PROC
main PROC
    ; TODO: write ex_09_key_down_up in this file.
    call    ex_09_key_down_up
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
