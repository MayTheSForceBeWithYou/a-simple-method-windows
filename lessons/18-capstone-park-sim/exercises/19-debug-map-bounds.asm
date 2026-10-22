; 19-debug-map-bounds: debug map bounds
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_map_bounds:PROC
main PROC
    ; TODO: implement ex_19_debug_map_bounds (student routine; defined in solutions/).
    call    ex_19_debug_map_bounds
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
