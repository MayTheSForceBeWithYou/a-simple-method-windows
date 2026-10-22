; 10-map-erase: map erase
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_map_erase:PROC
main PROC
    ; TODO: implement ex_10_map_erase (student routine; defined in solutions/).
    call    ex_10_map_erase
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
