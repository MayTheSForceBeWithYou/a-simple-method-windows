; 15-clip-rect: clip rect
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_clip_rect:PROC
main PROC
    ; TODO: write ex_15_clip_rect in this file.
    call    ex_15_clip_rect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
