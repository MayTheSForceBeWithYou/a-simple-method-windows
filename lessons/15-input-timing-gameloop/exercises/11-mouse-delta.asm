; Exercise: 11-mouse-delta
;
; dx=5 dy=-2; manhattan 7; exit 7.
; Expected stdout: (none)
;
; Contract: implement `ex_11_mouse_delta` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_mouse_delta:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_11_mouse_delta in this file.
    call    ex_11_mouse_delta
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
