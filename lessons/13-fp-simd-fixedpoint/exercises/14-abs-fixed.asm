; Exercise: 14-abs-fixed
;
; Absolute value of Q16.16 -3.0; exit 3.
;
; Contract: implement `ex_14_abs_fixed` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_abs_fixed:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_abs_fixed in this file.
    call    ex_14_abs_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
