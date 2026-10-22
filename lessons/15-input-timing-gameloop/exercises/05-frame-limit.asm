; 05-frame-limit: frame limit
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_frame_limit:PROC
main PROC
    ; TODO: implement ex_05_frame_limit (student routine; defined in solutions/).
    call    ex_05_frame_limit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
