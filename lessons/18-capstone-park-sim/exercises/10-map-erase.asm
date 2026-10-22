; 10-map-erase: map erase
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_map_erase:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_map_erase in this file.
    call    ex_10_map_erase
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
