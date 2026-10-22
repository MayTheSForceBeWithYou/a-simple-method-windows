; 18-double-buffer-index: double buffer index
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_double_buffer_index:PROC
main PROC
    ; TODO: implement ex_18_double_buffer_index (student routine; defined in solutions/).
    call    ex_18_double_buffer_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
