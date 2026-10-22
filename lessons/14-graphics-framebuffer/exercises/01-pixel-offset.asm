; 01-pixel-offset: pixel offset
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_pixel_offset:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_pixel_offset in this file.
    call    ex_01_pixel_offset
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
