; 09-key-down-up: key down up
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_key_down_up:PROC
main PROC
    ; TODO: implement ex_09_key_down_up (student routine; defined in solutions/).
    call    ex_09_key_down_up
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
