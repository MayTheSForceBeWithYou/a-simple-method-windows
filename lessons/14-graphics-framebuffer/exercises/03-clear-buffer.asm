; 03-clear-buffer: clear buffer
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_clear_buffer:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_clear_buffer in this file.
    call    ex_03_clear_buffer
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
