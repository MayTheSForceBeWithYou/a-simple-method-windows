; 15-clip-rect: clip rect
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_clip_rect:PROC
main PROC
    ; TODO: implement ex_15_clip_rect (student routine; defined in solutions/).
    call    ex_15_clip_rect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
