; 01-map-cell: map cell
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_map_cell:PROC
main PROC
    ; TODO: implement ex_01_map_cell (student routine; defined in solutions/).
    call    ex_01_map_cell
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
