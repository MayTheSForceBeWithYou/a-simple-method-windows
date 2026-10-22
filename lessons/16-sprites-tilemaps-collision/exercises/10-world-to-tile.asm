; 10-world-to-tile: world to tile
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_world_to_tile:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_world_to_tile in this file.
    call    ex_10_world_to_tile
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
