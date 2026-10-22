; 23-stretch-chunk-coords: stretch chunk coords
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_chunk_coords:PROC
main PROC
    ; TODO: write ex_23_stretch_chunk_coords in this file.
    call    ex_23_stretch_chunk_coords
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
