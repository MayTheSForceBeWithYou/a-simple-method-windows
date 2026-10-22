; 10-world-to-tile: world to tile
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_world_to_tile:PROC
main PROC
    ; TODO: implement ex_10_world_to_tile (student routine; defined in solutions/).
    call    ex_10_world_to_tile
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
