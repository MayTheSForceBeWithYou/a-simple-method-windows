; 19-debug-parent-index: debug parent index
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_parent_index:PROC
main PROC
    ; TODO: implement ex_19_debug_parent_index (student routine; defined in solutions/).
    call    ex_19_debug_parent_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
