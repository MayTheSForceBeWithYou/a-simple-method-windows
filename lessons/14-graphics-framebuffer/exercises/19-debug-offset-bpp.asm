; 19-debug-offset-bpp: debug offset bpp
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_offset_bpp:PROC
main PROC
    ; TODO: write ex_19_debug_offset_bpp in this file.
    call    ex_19_debug_offset_bpp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
