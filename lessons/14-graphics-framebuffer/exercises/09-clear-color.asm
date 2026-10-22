; 09-clear-color: clear color
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_clear_color:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_09_clear_color in this file.
    call    ex_09_clear_color
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
