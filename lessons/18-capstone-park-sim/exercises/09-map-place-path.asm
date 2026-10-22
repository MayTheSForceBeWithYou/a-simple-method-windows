; 09-map-place-path: map place path
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_map_place_path:PROC
main PROC
    ; TODO: write ex_09_map_place_path in this file.
    call    ex_09_map_place_path
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
