; Exercise: 05-frame-limit
;
; If frame_time < min, pad; return pad amount 2.
; Expected stdout: (none)
;
; Contract: implement `ex_05_frame_limit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_05_frame_limit:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_frame_limit in this file.
    call    ex_05_frame_limit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
