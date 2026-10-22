; 03-clear-buffer: clear buffer
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_clear_buffer:PROC
main PROC
    ; TODO: implement ex_03_clear_buffer (student routine; defined in solutions/).
    call    ex_03_clear_buffer
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
