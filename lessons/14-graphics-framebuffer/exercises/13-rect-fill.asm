; 13-rect-fill: rect fill
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_rect_fill:PROC
main PROC
    ; TODO: implement ex_13_rect_fill (student routine; defined in solutions/).
    call    ex_13_rect_fill
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
