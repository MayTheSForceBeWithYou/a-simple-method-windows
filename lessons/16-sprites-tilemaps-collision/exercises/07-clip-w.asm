; 07-clip-w: clip w
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_clip_w:PROC
main PROC
    ; TODO: implement ex_07_clip_w (student routine; defined in solutions/).
    call    ex_07_clip_w
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
