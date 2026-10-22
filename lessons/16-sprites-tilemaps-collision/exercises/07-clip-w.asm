; 07-clip-w: clip w
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_clip_w:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_07_clip_w in this file.
    call    ex_07_clip_w
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
