; 18-double-buffer-index: double buffer index
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_double_buffer_index:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_double_buffer_index in this file.
    call    ex_18_double_buffer_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
