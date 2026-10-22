; Exercise: 07-clip-w
;
; sprite w clipped; exit 2.
; Expected stdout: (none)
;
; Contract: implement `ex_07_clip_w` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
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
