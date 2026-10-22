; 09-clear-color: clear color
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_clear_color:PROC
main PROC
    ; TODO: implement ex_09_clear_color (student routine; defined in solutions/).
    call    ex_09_clear_color
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
