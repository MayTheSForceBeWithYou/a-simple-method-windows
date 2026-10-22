; Exercise: 17-vsync-stub
;
; Frame ready flag clear; exit 0.
; Expected stdout: (none)
;
; Contract: implement `ex_17_vsync_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_vsync_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_vsync_stub in this file.
    call    ex_17_vsync_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
