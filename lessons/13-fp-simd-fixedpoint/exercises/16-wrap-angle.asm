; Exercise: 16-wrap-angle
;
; Wrap 400 degrees modulo 360; exit 40.
;
; Contract: implement `ex_16_wrap_angle` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 40
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_wrap_angle:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_wrap_angle in this file.
    call    ex_16_wrap_angle
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
