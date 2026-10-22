; 14-frame-stats: frame stats
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_frame_stats:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_frame_stats in this file.
    call    ex_14_frame_stats
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
