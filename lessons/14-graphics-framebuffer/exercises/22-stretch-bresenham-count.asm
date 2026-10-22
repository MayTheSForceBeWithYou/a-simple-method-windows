; 22-stretch-bresenham-count: stretch bresenham count
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_bresenham_count:PROC
main PROC
    ; TODO: implement ex_22_stretch_bresenham_count (student routine; defined in solutions/).
    call    ex_22_stretch_bresenham_count
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
