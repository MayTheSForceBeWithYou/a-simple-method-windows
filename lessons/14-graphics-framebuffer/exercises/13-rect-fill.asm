; 13-rect-fill: rect fill
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_rect_fill:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_rect_fill in this file.
    call    ex_13_rect_fill
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
