; 01-map-cell: map cell
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_map_cell:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_map_cell in this file.
    call    ex_01_map_cell
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
