; 09-map-place-path: map place path
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_map_place_path:PROC
main PROC
    ; TODO: implement ex_09_map_place_path (student routine; defined in solutions/).
    call    ex_09_map_place_path
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
