; Exercise: 15-clip-rect
;
; Clip x to [0,w); x=-1 -> 0; exit 0.
; Expected stdout: (none)
;
; Contract: implement `ex_15_clip_rect` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_15_clip_rect:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_clip_rect in this file.
    call    ex_15_clip_rect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
