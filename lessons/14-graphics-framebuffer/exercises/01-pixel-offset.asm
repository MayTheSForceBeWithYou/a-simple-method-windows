; 01-pixel-offset: pixel offset
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_pixel_offset:PROC
main PROC
    ; TODO: implement ex_01_pixel_offset (student routine; defined in solutions/).
    call    ex_01_pixel_offset
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
