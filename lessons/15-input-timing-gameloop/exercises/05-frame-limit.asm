; 05-frame-limit: frame limit
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_frame_limit:PROC
main PROC
    ; TODO: write ex_05_frame_limit in this file.
    call    ex_05_frame_limit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
