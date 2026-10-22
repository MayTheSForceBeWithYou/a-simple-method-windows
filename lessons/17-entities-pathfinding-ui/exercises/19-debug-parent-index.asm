; 19-debug-parent-index: debug parent index
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_parent_index:PROC
main PROC
    ; TODO: write ex_19_debug_parent_index in this file.
    call    ex_19_debug_parent_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
