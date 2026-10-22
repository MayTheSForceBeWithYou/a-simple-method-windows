; 19-debug-offset-bpp: debug offset bpp
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_offset_bpp:PROC
main PROC
    ; TODO: implement ex_19_debug_offset_bpp (student routine; defined in solutions/).
    call    ex_19_debug_offset_bpp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
