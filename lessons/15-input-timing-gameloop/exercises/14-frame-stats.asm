; 14-frame-stats: frame stats
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_frame_stats:PROC
main PROC
    ; TODO: implement ex_14_frame_stats (student routine; defined in solutions/).
    call    ex_14_frame_stats
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
