; Exercise: 22-stretch-bresenham-count
;
; STRETCH: line from 0,0 to 3,0 plots 4 pixels; exit 4.
; Expected stdout: (none)
;
; Contract: implement `ex_22_stretch_bresenham_count` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_bresenham_count:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_bresenham_count in this file.
    call    ex_22_stretch_bresenham_count
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
