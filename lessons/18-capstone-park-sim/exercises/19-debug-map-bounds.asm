; 19-debug-map-bounds: debug map bounds
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_map_bounds:PROC
main PROC
    ; TODO: write ex_19_debug_map_bounds in this file.
    call    ex_19_debug_map_bounds
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
