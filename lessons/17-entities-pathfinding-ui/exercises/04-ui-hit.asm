; Exercise: 04-ui-hit
;
; Point in panel -> 1.
; Expected stdout: (none)
;
; Contract: implement `ex_04_ui_hit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_ui_hit:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_ui_hit in this file.
    call    ex_04_ui_hit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
